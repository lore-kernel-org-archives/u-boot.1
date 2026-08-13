Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8036C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 21:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B6B660DE2;
	Thu, 13 Aug 2026 21:00:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8YcLAK5TooDt; Thu, 13 Aug 2026 21:00:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 84165606D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786654820;
	bh=sRu83YAQU/tM+9qIQGuHIrjrFEBHyuIXEPmom6g28l0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ATPe+O9TzAg4DiQaV9blKWutoQnF2KJxeUvOIPfE5h9v9jKnhRB0GNtANaTef1l/+
	 dpPHxbCw27WMZqcaiuxy+NvK8BWvtOpJwhBswdoTW067cH+CNRLJBO1YGG19w1rk4Z
	 zqB6N1GWJLnUQgCtO80WV2YNX6UnTfOKOuZyGfX2cuwlcEEIEWODY6BepW5lPMBCPg
	 1hl/cBTqbkHZvcwUFFXmd3h6bafXhVzoBUqwMu56QBHj2InOMINcE1G53RKq5p9wuu
	 IVXaT7zZgHHAkk6e8lg/Bvu/zNqqACSDnbwn65+tHlxNFverSYfYj91C22JXcOJiqp
	 owsrjClYtdTuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84165606D5;
	Thu, 13 Aug 2026 21:00:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 77411139C
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 21:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5DA6840CEE
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 21:00:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ckGmUUQQqp3 for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 21:00:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7F49D40CEC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F49D40CEC
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=oFHk9JtG
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7F49D40CEC
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 21:00:18 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c15e62c695cso4085366b.1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 14:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786654816; x=1787259616;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sRu83YAQU/tM+9qIQGuHIrjrFEBHyuIXEPmom6g28l0=;
 b=oFHk9JtGb/9MUnTnwhxjkULVw2UE2SL2Q90NYlmCdx3+vqdsoooxBYpbmu0A8Dg/67
 WQdMDr4OuCy/uZ8oU75I+IqcVEjIKFMqu5dASzUUqE1bk9lFV3bbdzrPqW5ZDA2FPzha
 AbWapEhF6/hyTa4uz45nPDomE6xOW6Mx0O3AWDa31EwanNqke1O7cL1jZDBvoFwCQSl/
 YmRkHAxymFgmq9PnlC06Eqjhcvv7+ktRPCmp47km7F0PZxUDqvZMBvvtJzrwBFAqKLGN
 Rd6R26gXrOzd+sxTLDAoyKyXXKifMWrkr3gY386VlYx4uRS6R1Nf8v6sx6W4yg/MQ/Of
 whTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786654816; x=1787259616;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sRu83YAQU/tM+9qIQGuHIrjrFEBHyuIXEPmom6g28l0=;
 b=dIHk8AVUA0s9PzYnATSF1IISBTYZUQ3EupVMpW5nUf5Wthjjhk8Rxo1bjS0AGOIsUX
 OaZm2U6fHbIfql53Q2m+h3kK5nAfBj4Z6Vlx94LPoKrQ9SPF7LU/tBuiltpErfjPaVLs
 RSiAtipSCgDB1P93weiG5dmxeJCiw7Gl74WuKfgWHzj4WxmQzd/pPj0jxZRvT6KJ4qm3
 kbxeYp1CrUHbRAvBXDSmLETCHduGBm3AlefmyHoamq9591n21irip/Xkakjx+bhRx3ib
 Uyx5yGsE1tvckMFlWM1zPe4uh+A7NtRXZ5o2Y4NZ0NeDzkjT/iOYoEwCqskXaMpqGROT
 00iw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUx02cp+C45T5XoXqZ54ngXZcf4uMAuqKUbB+dXJakbAX28O/cVh2x2uFPcClGQKlL0akstz8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwuqtEAbAw/aOFXNbqvqX7vOTpT1ww6ZYJHI1w0zh8CoV/38W65
 wJubTbFTBG/rfTRylGVjbC09dA32BKm3qeq3BCjaB2JHVBy9cZskt1Os
X-Gm-Gg: AR+sD13O18c27cT2+QZhZ044pBCY6XFqLiH3UYKb6Ci7GsGRCuQlUq1/S2iIlRAF3oG
 yJelV/cllwjSm12Be9E+RtgPw1NIuYd+cjCOqhqzLNna6CrOnaPLolris8OsyLNk+hE8d17mTc2
 7p9LhGXc86D1EgdQA+Xfb5j7HI6mmPFTi3HSvKO04pfpz9WxdsK/PB48MeRi2haB5ngVxSjqRGb
 5s2E4PfND/MPbu1SoBdKUr1K4tgvEh4PoiiSl2h5/NmBgSiAzOPWsw0gNudOJbJbRkym/K1rNS7
 tnYsAVwz2HVztAWt8i/AV7YfZJ1Ql8BYDwNyhBx5WbJz8Iln7MEjyUNgyXnBFjZYui0SnhEo0lL
 HEpYrqI9LToHKwC3L3nqBGDEKH1qASqONT8Zej7BVgmnQZb8zTn5FRCPwkAjUxjK1tm88/XcTJJ
 6Nzud6EggawKsv3lHy/qosvlu7f/J6OjVz7WDMZSD6DCOCvLLaRjFDMi7m54JuSE+1FKlQE0OUj
 YGEJovbfzygLnb2FHFu3jKvL4Y=
X-Received: by 2002:a17:907:3e9b:b0:c12:732a:fe52 with SMTP id
 a640c23a62f3a-c212a26d6a6mr26026566b.4.1786654816474; 
 Thu, 13 Aug 2026 14:00:16 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c21234c45ffsm30641266b.19.2026.08.13.14.00.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 14:00:14 -0700 (PDT)
Message-ID: <bcd1ab49-dee7-4f99-962f-1d4876e7758e@gmail.com>
Date: Thu, 13 Aug 2026 23:00:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v6 6/6] rockchip: doc: add notes section
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <53b3903e-9413-4c96-ab45-4c34a2a6dca9@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <53b3903e-9413-4c96-ab45-4c34a2a6dca9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a notes section for things that don't need
a chapter. Include some rk3036/rk3066 cases.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 doc/board/rockchip/rockchip.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 7f6570f95cf4..3fbc307a0c45 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -332,6 +332,14 @@ To build rk3588 boards:
         make evb-rk3588_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-
 
+Notes
+^^^^^
+
+* rk3036: SDMMC and the debug uart share the same iomux, so if
+  a SD card is the boot medium, the debug uart must be disabled.
+* rk3066: eMMC and NAND share the same iomux, so if in Mask ROM mode
+  and a NAND is the boot medium, clear the emmc_flash_sel bit in GRF_SOC_CON0.
+
 Mask ROM mode
 -------------
 
-- 
2.39.5


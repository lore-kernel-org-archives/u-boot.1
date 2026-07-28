Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35555C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 06:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1BA760846;
	Tue, 28 Jul 2026 06:56:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z6smlkjmYN8h; Tue, 28 Jul 2026 06:56:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C004960831
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785221770;
	bh=aAWAsKh6mOeIRz8epGjwF4ejMnp96Ubexyi68p3ezrY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rOwyYWwnMHHfXBd4wdq9WZNPpTK6/n47eb6mZZtKZ+2OJILWepppnqEfX2AgOvyaj
	 L9HlyB4AmO8YrdDTYcMo2rEXZeQiDkAFRpcykTfOnZnYTUYr2bi9AUIy/+uloOCs2b
	 NsC//Ts2QlsLG9O3kGqSzdO/yDTCT1nsJKNjV4RH9ANLTyoH/dLCfa5ib0jgamcehh
	 pjfB1OVNB2L90rnO/f8HuT8AEbk1AmrypXlZcXuJw9QYnjKL1tFQUcris0KeHfSMAv
	 Gydf7qEpN2wX4Pv0EggeP55TxPmqvCUNTYGIB5M2jSD3iZn+Aln8TVNxadmUkz84sv
	 2Mq4oV6ckr55A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C004960831;
	Tue, 28 Jul 2026 06:56:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BEA1326C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:56:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B04C2405DE
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:56:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MM4FIQ2wSJKx for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 06:56:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C6C7340594
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C6C7340594
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C6C7340594
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:56:07 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c15df0c154dso32764566b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785221766; x=1785826566;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aAWAsKh6mOeIRz8epGjwF4ejMnp96Ubexyi68p3ezrY=;
 b=Io6MF1LP8pWHpm7MdO127RVKlhYMmNv64c3ElRRqu0plR7Bk3cnOw51v87AAVHfhl8
 NQycseH+/BdFTaRTZXiaIKjbiMURChL6PqFU14pb7av8VqBTpGPY7Wg4mPAOTBh5NMPp
 LTGAKf4kTi1Kjog2k8CEJfKqlRZHhW8uAwAJxQepYcWzBwEdfrhgBY45oaqG+m5+ppij
 Htu7g3+X+lbqlr3coTfSePB4+TwuGPca+1D6aJjLq6NuOiB68ob7jurF3d/3LZcvXE7O
 2sIlvLnvcrVGBlM9zC/U/Tt5QT4SKGCkor3HwYoXWeucvCxrLrzh2RTdRTRfx5GhHJk9
 9hcg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrw3ivTuq/Hs/T5L3oVYDS5SD18YjMw1K+f/91cyD8Ifvfo0dLB2Q04nmmvnQjyx4rz+ZE8/uk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yyu7ej+gJCau3O30vgFff4GdbJCnF4R8TiJcBacXA//4KJ6V776
 eLitkOoornPznEy28X9IjbIA9jNzm9C0l4Q5adR9UecEaXdIefAd89GK
X-Gm-Gg: AR+sD10w3WgWkzBdVch4dIOTIrZyZNGUR+pLEVeefKjgO6UOl1bb0w2LD2gka2q/P5g
 AyEtV2XA/EyZPuv0emY/aHjpkOmdE7Oa6gqYcAIaZ7PwPEJf1rh1WD2B6VmnRwqAqFKcHwtXEhu
 TlBjw4G8XJPdWFkFFtfY0c31NsTGA6LP9dkggHSPrF6z9uqPtS28HLH5LndlwhFlEYjAnZb8iLU
 8DSIoMXoffx4UgdrViEnZUdSKZ9AAA0C6O149B3nWw3nE8FYJjwuj1Cp+rlJnRuFQUOm+LAEepg
 6y/HqFcqfPi5XpL/uKKUYb2HTjATa9fqitMVLaY9b1sXrPphrkz+3TnGTvr2VzXTk4bajTCgy4I
 yeiTONaM3sAa08JH8hg0ZBztZHpIo88z1APhyHVekF3AYhqOIya5mQwEfVIz1xvoDDxN2Jo0l/b
 wDKi6bAwGqYUmXi+QsO8APaNreU8TAePqVMVz5ENUU
X-Received: by 2002:a17:907:8b92:b0:c16:6a15:cc8d with SMTP id
 a640c23a62f3a-c1f727c1d00mr23788666b.7.1785221765401; 
 Mon, 27 Jul 2026 23:56:05 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32ebac95sm715193666b.47.2026.07.27.23.56.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 23:56:05 -0700 (PDT)
Message-ID: <b42c2735-b16a-4129-9278-c026243999bf@gmail.com>
Date: Tue, 28 Jul 2026 08:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 07/11] rockchip: doc: add more EMMC program examples
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785221766; x=1785826566;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aAWAsKh6mOeIRz8epGjwF4ejMnp96Ubexyi68p3ezrY=;
 b=WQpqZtYp9Y3dLEvhGCW32qSoCj3Z+rmwVtJLJzjS2BCB2u4gK0mL3BGb/fmNRkqYDK
 12+LDF8ET/o46nVNdR78V/eChtMimQDRGeOvgZHdDjg3a2oOjxNx+ZBdbCVieNFxsuXi
 f8UKyJbTHx9zsVA9qqjrkHN4m/gn7w6kHLll3HFH+vbHLKT9wxismpDAdmupRczfO2iJ
 NiC/wPqGtP/jIZYgKA/xDVdah80UCOaOiDeTPUXV9tafzmEsXLpa7xnq0iU7/FycbHKl
 ARvhwVpOxApBzZ8QrQN89igycfU47NFczB/3PqCP6X3V09QVic0jqK2tPnVpnkh8URWi
 huxQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=WQpqZtYp
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

There are more tools that can program a EMMC.
Add more EMMC program examples.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 doc/board/rockchip/rockchip.rst | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index e6c4815258bc..7da74eb8fb12 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -415,13 +415,22 @@ Upon a successful gadget connection the host shows the USB device with:
         lsusb
         # Bus 001 Device 020: ID 2207:330c Fuzhou Rockchip Electronics Company RK3399 in Mask ROM mode

-Program the flash with:
+Program example with fastboot:

 .. code-block:: bash

         sudo fastboot -i 0x2207 flash loader1 idbloader.img
         sudo fastboot -i 0x2207 flash loader2 u-boot.itb

+Program example with rkdeveloptool:
+
+.. code-block:: bash
+
+        rkdeveloptool db rk3308_loader_v1.26.117.bin
+        rkdeveloptool wl 0x40 idbloader.img
+        rkdeveloptool wl 0x4000 u-boot.itb
+        rkdeveloptool rd
+
 Note:

 For Rockchip 32-bit platforms the U-Boot proper image
--
2.39.5


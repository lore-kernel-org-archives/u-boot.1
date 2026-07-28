Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA002C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 06:54:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93EC260821;
	Tue, 28 Jul 2026 06:54:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mBNnM9gp5mKR; Tue, 28 Jul 2026 06:54:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 56EF26081F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785221660;
	bh=1r7JpX8axK8FzHTEpX5heSIY28EisS1OGVGBHbtm8dE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ACkVHjPhD0a2VJOMgg0XqOXkNqwKDlnmGXpjX+pW9a0hoGlyKP4woouikMcs4U7f8
	 Auy6hHM8qNA+pWb9viG0/ONa2g8Q6G8rue69XwM6kc3Ea736l136sG74HXx5PFsftC
	 1aq7AA/1yuMn0y2GFMnwdZTX1MK3mb5Q8Z3r+VEDHheL2y6C2g7FC2+OmCPfs3YCm7
	 6V/Ntvujun998APdE6EXjdqODLEF7uZgQqsgocXBveuv+zL3SkXHdoXcwKzMUMmA3Z
	 gLhMcniOuNSyhBfaKRxWQ7LspVaSU+CbKabg5XU7j6o/qplDlmnx9HkjJ8UVt+2vH/
	 iktf+UY/ZJiHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56EF26081F;
	Tue, 28 Jul 2026 06:54:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A67D423F
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 987A981265
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:54:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LKzbX1E_gmwN for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 06:54:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A42BE81263
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A42BE81263
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A42BE81263
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:54:17 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c15c1f1be0bso59328266b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785221655; x=1785826455;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1r7JpX8axK8FzHTEpX5heSIY28EisS1OGVGBHbtm8dE=;
 b=HKSGjTsv+2a4solN7lfjVOumrsQzWh11QYMLA+q/poQcX1ztzxREasXiy4P/JENw5i
 7TkC0WBOPtQhB4eBRivJxhVzSBTMFclg+e6K3KT0AFaJfbN6RngYFXRO+GzDDAchoUv2
 HlxCxLP6vFmrFbRZ+QkwmeVzAYQAwFSDST9LJT0T9CORh6Z9b0G4SfdXzGrcBn36Fya9
 zGDcHc58U5d68I2KPdP95bx2mW7Am/tggVL014VA9q0QICywbawB/lGkR1g/UfWuAiXn
 PYDEzW9NZ0eo1CJimXavh+0cqozIxbV/1495vCdFZmYZjtNOgFJRYUuiKH9Q1aMn4BO3
 AAZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrhL9qdhjm7QNtNsImPuG5ZRay51zVMUvRqfcqw3kPRH6Vsn3PSff7UkYQFxoA70vSlqCRRpds=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzSEjfCUi/ef+pwRzFjF3ITEwL/iNTfIuNPLcVJLp+nGnz60aWl
 oATVw1zXyG9gg41hzt8tBV7xZ2C53oJRGqYwU+M8/HCQvmjnEOkqquR6
X-Gm-Gg: AR+sD12I+m6WKdwoicFHOJ2tpkUsxXXQr0rViURxzuXvOQDfgxFhsetdlCncHQDJyht
 JrBsp7jVIzkJLB+/UH31sFzDPkxIzq4cQlVsyA3iVAeEGO5BPuQLrFHj5FGDc/5tQm4N4H0978S
 oXyUDI8IyTfg0vE9CynoLFP4Ip3AcuFrPcG+HED4MgyGx0oqYh4/XiZYK0cHoMC09AIVDNOGSII
 6ZgzEx8kYlMSr3m2/bjeEz5GTJG0EF+j5+d1saK+Njobf+StOrTqokX9bwxEm84AM6FJWWWpniW
 +Q/wtOWA79QU2aCEenM1MALJgqqOEy93CIVHF4wEOLXAZls8GPMUHZxNKzTTB6D8plgWXcLNcT5
 P6HAEKqR09/wURFr7IlmyxV2mZwTnx5h4sX0NWVUSOqe7iJxvIVqA3pcaOmH3Zl7pRas4sYX64u
 +9lzV27zLFoQ455i4HgiioMKtuh1LaguQoBzMc0WXovb3A+Wr17qo=
X-Received: by 2002:a17:907:3f07:b0:c1c:4820:65d2 with SMTP id
 a640c23a62f3a-c1f71cefca8mr24846266b.2.1785221655320; 
 Mon, 27 Jul 2026 23:54:15 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32f12994sm728853666b.60.2026.07.27.23.54.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 23:54:14 -0700 (PDT)
Message-ID: <d7728192-7ec3-4c47-a4a9-70a85920f3e5@gmail.com>
Date: Tue, 28 Jul 2026 08:54:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 03/11] rockchip: doc: add BootROM/MaskROM mode text
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785221655; x=1785826455;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1r7JpX8axK8FzHTEpX5heSIY28EisS1OGVGBHbtm8dE=;
 b=qXtDKLpe8+VGL5JC8wYPj0KH6qNnoPoXnYeSE2u+x8fjk2qlsthDMnUg91Oy7hCTMU
 UGFzjnH1PxhJGSTXIFzBVdJXnh6TU72X6QDirRTn9SAbgRwRCQCTX5wkj1tolTUhWvuC
 tqc5M86aiUKNmk+ZF/GZLSNX/1bsuxDDQYLCkwH8oKWpY/Y54u/lR3MieYpl2+mvDvXL
 rscZK4S89s5RuKwchVqN/8kV4gkq11BlIB4lsHSIcs26EpBH6GjPkRod8mdyI1wkNnsJ
 R1gqpnYiTtSCOSpxFH7ANylBzyidymeuKWKF6BkYnHIl/pK9YjzEqynuKRdmIKLg160a
 k7iA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=qXtDKLpe
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

Add text that explains how to get into BootROM/MaskROM mode.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 doc/board/rockchip/rockchip.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 718d5c6f25ba..4ebe20d81324 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -325,6 +325,21 @@ To build rk3588 boards:
         make evb-rk3588_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-

+BootROM/MaskROM mode
+--------------------
+
+Options to get your board into BootROM mode:
+
+* Holding the recovery button when you boot the board.
+* Remove the SD card.
+* Erase the NAND, MMC or SPI chip part where the BootROM blocks are located.
+
+Methods of last resort (USE AT YOUR OWN RISK):
+
+* NAND: connect pin 8 and 9 of the NAND flash with a needle while
+  reconnecting to the USB OTG port to a PC.
+* EMMC: short the clock line to ground while reconnecting to the USB OTG port to a PC.
+
 Flashing
 --------

--
2.39.5


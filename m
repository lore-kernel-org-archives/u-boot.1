Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9810C5AD5A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 13:08:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CA2D80F62;
	Sat, 15 Aug 2026 13:08:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SYyEZ5D2CW2w; Sat, 15 Aug 2026 13:07:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2772E81202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786799279;
	bh=nTJTOl9IMYMvRRA1rw1fJerTLBG9e4miZKBSZK9ARD0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rw1Lm/30TyORI1JbFitFjj9WY/9OJ/HN4uE4x1l+XWbvt81UvCLqc9KXa+zBusjR4
	 WXtleUS25rjq8iiMsr/J0l+7yvwugqQnEnyuUqo8O+h1CV9evn7FCWuyMxebFBFW3s
	 qV82L5WeSXlPPLXRORzmmVALCEseIpiRs1Ld2IgIUsfe2MEAHinZlhxfAcVPP8A9Z2
	 Vwbfe4Y3ZkYUhRztB8Ow6MCcoAUHMPR/yZK/9mrtYSgUEJyYodyfpPVa2cgJFsRNSV
	 h7p2Krb2Qw78zoiJnHC6hs9wVhl6eiP3vZ1hc8QlVx9Un4PXoak0R0x/q3Ldmq6dUL
	 HAJQ+w+WIkZeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2772E81202;
	Sat, 15 Aug 2026 13:07:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 61AE7109
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 13:07:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F6306065E
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 13:07:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zCxskQTkskaA for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 13:07:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 765CC6065D
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 765CC6065D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Qxy6LbAa
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 765CC6065D
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 13:07:56 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-69a33fb0031so264712a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 06:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786799274; x=1787404074;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nTJTOl9IMYMvRRA1rw1fJerTLBG9e4miZKBSZK9ARD0=;
 b=Qxy6LbAaQZoyssBPNoLHzHzmzVal8cA9Owndb4KQnnPS4+7WQNS8WFaAALLmrs0ox9
 8BH9rm45Tm5oYF4xJtktOF25bCVmb6mb/VpnkOaFHw/WrIA6v7thR2UFe+ODbCjNYA9B
 /cmaXrEP1QzKm/QcpoVc7jppuCia1FZbWOQ+OifDcLZ3GZsnUd3etQUeyeAv2mPUhzZ/
 2MYa7zX0sD0jqGAIw38hf5RXp6D55QEJoBENFnHnq/j25IzGrTWrKdCDLe1/WAiZyz7H
 vaYDhAwv6ZLEFeP+03BNGKApt+GrXE55Djp5BUzwxu5/iRw2G4OMgPwtTGOz7PSEXmot
 OpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786799274; x=1787404074;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nTJTOl9IMYMvRRA1rw1fJerTLBG9e4miZKBSZK9ARD0=;
 b=sWkNikXqnkNVQIVBRW6StGlwm9UUBCiyFy49eC6p08vGVA8IQYMfc/FHv7u/vUJTPU
 MIBbw1QJTCimDhFnwSJ1sxZK567bs7b55iR7So31W0OUKOM+XCtxlH0BH1xylURa3OQk
 iubrz4kEH5ba2x37ke+LAoDSyZJRBgF9dg6pyQE3LnaKLmtImjau0GTtvJC5g8ivJCMm
 2TTv54KhvoqXxDTpJxxf6u+3qBJU7S0fgo8ZACIplbrkIqbTvaVn7bcayTDAq0sTZuMd
 Ze4nYbR8icd8bkbOPUoObzF/noYs60WljismDqCVS2BFf8OQd71IsZVFzVjSzC8c+Qyf
 T/QQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+gI1rKgIX/9wTV0d4hH9IPV2CB1vNsa2FxyJ0ml32te1mHvxksQLGBfjSYAO55gHo9KZDWY4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyBAxaYa0WqCdeGLR3nX4AksMBEZ/blfuqbbYqwB4QRuNQRXt9A
 umTPLeAv+O+jV+8/jsAMQtruZtdZRk3XC9XQrEUNLNKeWTTAyusIQT6p
X-Gm-Gg: AR+sD11mhBqyG7gJF27+9rf/Zx91piwpgzmOqgIssDZjqKIghdhyO7dsIyh6PV4YXvc
 qG2agAzNn0zx0v41Yh2D26GBv7jCWLboK3FpaVSl0JF8QcRIIUQTn1zEAaJQUXNyS4poHUt1uEn
 YdnL73ZQUQEGlRE4oIc+CgT/18xZ4vXBP2KfQ4DOzIIpBFaGHYbW69U7lIu+noBGwk5Mbxeguvk
 Lvvcqy+0fYcdI6/dk8KxTqihq9E6xLIvauOGxxRE59BsrILIPwP1zlrC6aNyK867dMZfgHgKcTA
 UMdH1zGqy3FKuX1Ax22BEGoQX5EHXwtpiPrc7xLEZCtYq6ml0MqGOXiOL1LNdl1gv3XkvyqxVo4
 /f9JMlBM0gEnzBD1J9nDXYBazOlgzKVsA3p3dOygmN0H7XBMUyMa1NQ92CIg0ehbHJ+/vQW4Onn
 HFhsZHzOnMvIoh1+lAQqhICpvbSYeuYuVVfC3v1VzHQf4iklhPRk7nFVxqWB/c05NnwDjmjUnnB
 uUnmf9tNdty5NoRsNS4YI5XfTc=
X-Received: by 2002:a17:907:3e9b:b0:c12:732a:fe52 with SMTP id
 a640c23a62f3a-c212a26d6a6mr310839466b.4.1786799274263; 
 Sat, 15 Aug 2026 06:07:54 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c21237defbasm213936466b.42.2026.08.15.06.07.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 06:07:53 -0700 (PDT)
Message-ID: <72cb1d52-c09a-4f33-a369-1741e0b0f543@gmail.com>
Date: Sat, 15 Aug 2026 15:07:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v7 2/6] rockchip: doc: add mask ROM mode text
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <5e1799a6-68b3-4535-b56b-f115467e637e@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <5e1799a6-68b3-4535-b56b-f115467e637e@gmail.com>
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

Add text that explains how to get into mask ROM mode.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changed V6:
BootROM/Mask ROM swap

Changed V5:
reword
---
 doc/board/rockchip/rockchip.rst | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index de2df3046e28..7c911662b840 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -325,6 +325,27 @@ To build rk3588 boards:
         make evb-rk3588_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-
 
+Mask ROM mode
+-------------
+
+Mask ROM mode is the fallback mode of the boot ROM,
+in which it listens for USB commands 0x471/0x472.
+
+Options to get your board into Mask ROM mode:
+
+* Hold the recovery button, depending on firmware support or wiring,
+  while booting the board.
+* Remove any SD cards, removable eMMC or removable UFS modules.
+* Erase any storage media containing boot firmware.
+
+Methods of last resort (USE AT YOUR OWN RISK):
+
+Short the following pins briefly while powering the board, so the boot ROM
+cannot locate any boot firmware and falls back into Mask ROM mode:
+
+* NAND: connect pin 8 and 9 of the NAND flash with a needle.
+* eMMC: connect the clock line to ground.
+
 Flashing
 --------
 
@@ -443,8 +464,8 @@ Note:
 3. Package the RK3066 image with U-Boot TPL/SPL on NAND
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-Unlike later SoC models the rk3066 BootROM doesn't have SDMMC support.
-If all other boot options fail then it enters into a BootROM mode on the USB OTG port.
+Unlike later SoC models the rk3066 boot ROM doesn't have SDMMC support.
+If all other boot options fail then it enters into a Mask ROM mode on the USB OTG port.
 This method loads TPL/SPL on NAND with U-Boot and kernel on SD card.
 
 SD Card
@@ -485,10 +506,10 @@ To write a U-Boot image to the SD card (assumed to be /dev/sda):
 NAND
 """"
 
-Bring device in BootROM mode:
+Bring device in Mask ROM mode:
 
-If bricked and no BootROM mode shows up then connect pin 8 and 9 of the NAND flash
-with a needle while reconnecting to the USB OTG port to a PC.
+If bricked and no Mask ROM mode shows up then connect pin 8 and 9
+of the NAND flash briefly with a needle while powering the board.
 
 Show connected devices with:
 
-- 
2.39.5


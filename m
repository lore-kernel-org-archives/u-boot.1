Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55023C55196
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:12:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 158BA606FD;
	Mon,  3 Aug 2026 19:12:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id miH6if3evrZt; Mon,  3 Aug 2026 19:12:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7080C606AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785784322;
	bh=Nd86tbx0PRF5j1UF+U2/8lLyjZA/hBm5rQ4IHaWtsuU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WE9U/dePY9HsVSOEJKBJlj1/5Hd8VByZDgIp+i38k6Wlsc2OeRt9ay3AFV0lvsmOJ
	 qq/OfdlYVfzxO1i1LXS2OQwJIrTXhLrzpo7LOOqbpsAwJu3kiLajfRqqzNljvc5ij1
	 +9pfF2E+VH0/6Lh4gsf5JWTgLRJ0bTDpwTQiM/DNkeNoUIPipgUyTQwG1dwgdhRKT1
	 0/Js1Mjvxxb2gCHGBwxSnKHbNefuNUQyEduTQ+8fOX7hGsOClrKZqWXGVM7cJnvw8p
	 W69aE5DNXeRepL4oyi6ZTtG5SpZ7CUB58FdLk1hwpIHO3q/meJbIke5oCA+ZhMoxi+
	 UPFikwPe9sQdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7080C606AE;
	Mon,  3 Aug 2026 19:12:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B027194
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:12:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 816CB4015A
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:12:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vqB9gAexky34 for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:12:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B85174005A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B85174005A
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B85174005A
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:11:59 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a10d6f455dso98041a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 12:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785784318; x=1786389118;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nd86tbx0PRF5j1UF+U2/8lLyjZA/hBm5rQ4IHaWtsuU=;
 b=NS9DhRoiHDLP5HZPM670MBsvAbReBlQZcrZasrY+O2hejsOZl0NxS07n5anEyVwj/K
 1ITothaTkT/PdPjdxsFZdPEFfXdm4ZyYSFTt2cpSs9Bz2vjonE8HBIdM4IxcIceh7fSg
 GKHN7au4rMvnAMBsVsByz5vAfc1AGqfr6pqR3WZXa8JfxIjJ0SHIk0lmMy3U4mSw3CtW
 gyUPlG/PfqYxWx//+pwUGGenyIEjmPgqmBkzfViAIvoOBhKYvBirkctmdktLS0FezO+M
 9pxQF5RCmwEXQUs7tNyMzjz3Z8No4ww9GRsRvWU+UQ/iQOhPKsoBSOgmqpLysNjcN1cR
 N7+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqiOGaWjjFr45M7cw5JFgidt2AY0twMmYDf5GD3rN/wOqNtdPeJjxn5ppGvePm2s+w/RdCNe5w=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx/bEGPrS+SAHrd8igzqyjIFeVpxbRTuHF1UKOWRdJJJj8U5llR
 8afbjWK06x3dIVLulpvhqz00rK2sBTMvERckqfbPFlJ+LQUM0q8I+7KG
X-Gm-Gg: AR+sD12X1G4EuV5rX16bO5pgnr0I0gsIHzMnrtQLN4/A8GQNiROEPOYQkwPqxavQv8L
 HEhy3C7i44Zreg7isqKBfa36hdWmdeAkLJ0cnoik3SWlb1IcYdDMqi8uunQiLDywmkeNxUEVSgs
 GhEHlQsU6xGJ4wcc+1Pnu2aSTzHcA2DVmJ6ZiD+f4FP6AUbhy8lcfcphb3PxsuOVQvQt6FERgme
 +pgTrbd9Hp5qC+s17nNI5l6MqvFMXydhJBgQd6ChpgKt6bM9Dtve8jB1FZB+nTVwuR/FrmCdB2T
 CAImquPZL6W4alyXubL6bAQjCDbnDlp/OUt+oUdembblII2fpY5d1JDQGEBVAo34YHONJrjN6MY
 u5Zrq3HF26oh8JCeoRl1PonFUNcqu14eIbw/2zmilkaf5UUNIOm4zYSTYA6zFuuICdrPLo2BFkm
 7LG2a5GpVJFb2jpV5i3LdHnWfb4q4cu+iK6CSIHbuEOoyCXa7hhnRaxAzit0oRn6RAspwkoL/a1
 UCzeUjBSTxnmRukPnt5W/IXa2w=
X-Received: by 2002:a05:6402:2b90:b0:6a0:9076:4de1 with SMTP id
 4fb4d7f45d1cf-6a0a7cf3766mr5100891a12.3.1785784317371; 
 Mon, 03 Aug 2026 12:11:57 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a0d0a70ae5sm2640654a12.14.2026.08.03.12.11.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 12:11:55 -0700 (PDT)
Message-ID: <8e3babdf-dc50-44b2-a184-7d9f2a9938ff@gmail.com>
Date: Mon, 3 Aug 2026 21:11:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 2/9] rockchip: doc: add mask ROM mode text
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <d15555b5-e57b-4567-ab70-56d48fd4b878@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <d15555b5-e57b-4567-ab70-56d48fd4b878@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785784318; x=1786389118;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nd86tbx0PRF5j1UF+U2/8lLyjZA/hBm5rQ4IHaWtsuU=;
 b=HhZ3ISxE7ikrJdIJsNw+6udxEJS7IN9rqps8LaVIEeY/Vyq2dDPBaZRVVfl+VQzlLp
 af121+B6tGcaTmpi9YxGVhiDoY9wiIZl+j6s276QvJX+4aH1zwMR/J/5Jb2K7rQNeb/X
 NvtVTGji1H6tS3XKZ+JoR76JqrpxnqkzoNL/eMflmzvAx6m9c8eSuzCzXIMxrQCumkIW
 T+ztoeuRZM+YtB48Nb0RdGhOgrCKAfrF6rOBIz1/aQG6STyo+OzqH39eXz6hAr2DTY58
 434LgmEcmblJ7eDLyaW9M+7UKxmvuz/IYcfw0MsMPplJPjItRJKqQpct0UJG3JUh9dLt
 rdRg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=HhZ3ISxE
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
---
 doc/board/rockchip/rockchip.rst | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index de2df3046e28..d31b6d182c5e 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -325,6 +325,28 @@ To build rk3588 boards:
         make evb-rk3588_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-
 
+Mask ROM mode
+-------------
+
+The mode that the boot ROM falls back into that listens to
+0x471/0x472 USB commands.
+
+Options to get your board into Mask ROM mode:
+
+* Holding the recovery button, depending on firmware support or wiring,
+  when booting the board.
+* Remove any SD cards, removable eMMC or removable UFS modules.
+* Erase any storage media containing boot firmware.
+
+Methods of last resort (USE AT YOUR OWN RISK):
+
+Pins that should be connected/sorted for a
+short period when the board is connected to power, so that boot ROM
+cannot locate any boot firmware and falls back into Mask ROM mode.
+
+* NAND: connect pin 8 and 9 of the NAND flash with a needle.
+* eMMC: connect the clock line to ground.
+
 Flashing
 --------
 
@@ -485,9 +507,9 @@ To write a U-Boot image to the SD card (assumed to be /dev/sda):
 NAND
 """"
 
-Bring device in BootROM mode:
+Bring device in Mask ROM mode:
 
-If bricked and no BootROM mode shows up then connect pin 8 and 9 of the NAND flash
+If bricked and no Mask ROM mode shows up then connect pin 8 and 9 of the NAND flash
 with a needle while reconnecting to the USB OTG port to a PC.
 
 Show connected devices with:
-- 
2.39.5


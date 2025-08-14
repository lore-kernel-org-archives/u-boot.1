Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C724CA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 13:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A38D58393F;
	Thu, 14 Aug 2025 15:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QxmQPU8c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3665B83939; Thu, 14 Aug 2025 15:27:26 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DA8183942
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 15:27:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-55ce5090b1cso982460e87.0
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755178043; x=1755782843; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WqBntBmL2QGxKlLZA1F2i1RklGRvumatyO36RVU7k2s=;
 b=QxmQPU8cYFWCppr+WWW10kTSIavAbKanybxG0xqe54bxqbnz7bDobFzMPMcvGpVRWa
 RoYgSSEGP7sypgB/ksl8pVfN0To8zrnb0aeRDCoF6be1H5GVAwhiSwzGbI1AKEnTmajW
 ibc0jSrNE0yvggQZtz78HolXivYMq0DBg9Zfx7qEkhkRzQFv6QxpTUPUasVgnYTGT1zV
 /ew+Ai6Cqu2GQvvqxP72zAG806kVzNH51qO8BPmsrZY7e1wYpAbjNSCwhYZBjFJjEjJV
 tdtQTx0T1GqVG+isY8I2A324LTpKs4U18tBcAytaiExWGDt0DZoP0W8AU/eZUOiND+rf
 Zv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755178043; x=1755782843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WqBntBmL2QGxKlLZA1F2i1RklGRvumatyO36RVU7k2s=;
 b=e6/AP22JhDOxqA05OriQXYqHF/12OUReZJXzv4Nxpfx1Pt77WLfUlQv0Tsk0ZFm3tC
 HlQ2VNFEzcMhnqJiAdGs94LDrWTwH00U5Tx/A3T0F/B6mdgfvBLoSbMBdpKzdmoKxz3z
 UKQIedJC3wz2ckrQ0QH3LdbWdquEptPfU6OreiAemxoZGf1GOTCoKSU5Q/zQESelfM63
 g8rY4khO7N5QjiVTkKFEE14AU/ftR86o9IwPrPQXQswmlcGPWZNsoJySqgOxutvlM/sG
 ITRoy1t8CMImzY7m6L7WzvujflJ2/vM6loH64LbD4sBYmpC6CaAbFAvzb0oh9ospRmXd
 Dwig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQRewoLbR62Qw4FGogzAMUVivlfJdgEWsuktOINTJqFFUQwgASN/0/v5YnKjl0LTBwlob8tlc=@lists.denx.de
X-Gm-Message-State: AOJu0YziuGmWKvz9CZchni0aYa3SdAKi5CrkSBsCeml0RmmupID9LUBG
 MB3WEfogBoqxmgOaE6zphUoN8BhXyLSuW1XzXk9tzAYExQERuI2RpAENqGnZ8UTpiiJ/cB+ZeTx
 EKdYi3JIVgcFtaPCpNmd10paTd4xkhqI=
X-Gm-Gg: ASbGnctepXpNOoA8AMAdPqg473ZXco9U8DzB6+EBi8ArDwZmAwcInR6Ni92F2eQXy2+
 j7dtjCdpw24Fz3pSrFGHHQJ+db/7xEQJPmQq9tpQj4SkldHRr7jRc/dmWXpdNCwRntLYeP0l3GI
 +b3JyIbiI7ji0LfFC8UHkOUEPq9ZfFtDY8LsHIZ18bx4hYprDkdnH4ZpB22QK7djiBQqDotkr+M
 /TX0nN0lfcmjOt6EkqvTC5oozGE/fzhaXWU7YAH8W8yo4XC
X-Google-Smtp-Source: AGHT+IH/EkNW+k++NYJjyFndHgDQpUtSxwK/voeuZk00iX5gsrg2dd+P5ih+aoLO8hb6IlJzy4QV9Zg1fLxH2kePSd8=
X-Received: by 2002:a05:6512:33c7:b0:55c:c937:111a with SMTP id
 2adb3069b0e04-55ce5029cb2mr885145e87.35.1755178043099; Thu, 14 Aug 2025
 06:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <cdfbaad3-e9ed-4678-9a65-c3561537d600@siemens.com>
 <CAOMZO5D+1v-721g5nE3NFQ4igrBHvF0rWs6Jkvm-Jo+R0QXKwA@mail.gmail.com>
 <87h5yakqug.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87h5yakqug.fsf@bloch.sibelius.xs4all.nl>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 14 Aug 2025 10:27:11 -0300
X-Gm-Features: Ac12FXwgjTdhkBC8Re6la-BImTVqbxVA5iky6rRNcjMrFWGT8UBq3_s-JW7DMZc
Message-ID: <CAOMZO5Cmgs3zUxdy_PRtE85pJLzG5=_1kReezFfKX6Xv05vHdg@mail.gmail.com>
Subject: Re: CONFIG_SYS_EARLY_PCI_INIT for PCI-attached eMMC
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: jan.kiszka@siemens.com, trini@konsulko.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Thu, Aug 14, 2025 at 9:52=E2=80=AFAM Mark Kettenis <mark.kettenis@xs4all=
.nl> wrote:

> Not without removing the 2nd pci_init_r() that is conditionalized on
> !CONFIG_IS_ENABLED(SYS_EARLY_PCI_INIT).
>
> That would require some thorough testing though; I certainly wouldn't
> be sure calling pci_init_r() is safe at that point on the boards I
> maintain.

You're right.

Maybe we could solve it with two patches:

1. Convert EARLY_PCI_INIT to a Kconfig symbol:

diff --git a/common/Kconfig b/common/Kconfig
index a2f653f7e722..9119a1c0869f 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -824,6 +824,13 @@ config SYS_I2C_EEPROM_NXID

 endchoice

+config EARLY_PCI_INIT
+       bool "Enumerate PCI buses early during init"
+       depends on PCI
+       help
+         Do early PCI configuration _before_ the flash gets initialised,
+         because PCU resources are crucial for flash access on some boards=
.
+
 config PCI_INIT_R
        bool "Enumerate PCI buses during init"
        depends on PCI

2. Select CONFIG_EARLY_PCI_INIT in the defconfig

diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
index d5890bf87fb3..a0d03dc19d0b 100644
--- a/configs/qemu_arm_defconfig
+++ b/configs/qemu_arm_defconfig
@@ -28,6 +28,7 @@ CONFIG_USE_PREBOOT=3Dy
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 # CONFIG_BOARD_INIT is not set
+CONFIG_EARLY_PCI_INIT=3Dy
 CONFIG_PCI_INIT_R=3Dy
 CONFIG_CMD_BOOTEFI_SELFTEST=3Dy
 CONFIG_CMD_NVEDIT_EFI=3Dy

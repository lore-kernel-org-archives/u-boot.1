Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F62C02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 13:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C14E9805C5;
	Tue, 21 Jan 2025 14:06:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mAS+3rWT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AA8F80763; Tue, 21 Jan 2025 13:37:45 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBF8580326
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 13:37:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=queen.homa@gmail.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6dccccd429eso51053376d6.3
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 04:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737463062; x=1738067862; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=f96lOINpsk40TGRE+FjkkSwbLVdusNKbb3ehQJhH6vI=;
 b=mAS+3rWTWXAe51G4OPjCGL43t36zWLYWumS+zP2MuDdgXbtUPPoojA66ZNI57G51tD
 1RTzj6YDtFgRJAhcuejn3aKxiYrFIimsoZcS8niI6YrOrxBLhhOIuqYV0Z1vykOdQN8O
 Fn0XzZk0F+nCl8DsSa0vtNiXHHNghu+luuSvLgeshC9bwiv+tSxvkd50hjfBd3FHgNPQ
 UCW7u9nMHQMvPsZ3fSbdephvtiP0gtP4MDniqfn1jsg+ckb+JDEZG/OiEiI969nuqMko
 0wSr/CrvLAtGluP0Yt6BxlpDBFhNy6i7GysMO5Z18j36kmE+bc31pC/XlWKgicg98x9m
 roJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737463062; x=1738067862;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f96lOINpsk40TGRE+FjkkSwbLVdusNKbb3ehQJhH6vI=;
 b=R3RrMwn8eqx5nVDTwHBSyGp4mTW5IGihWQ/Ul8p0gaVuHyBd9xQI7HDlZMssImPYM3
 34gfCDXE6/S+g6RT3+GLUPU+2nOLNx3OC8B2EB9JcXhmEZe0/hiA81WStaOPrBUQ/ZWo
 uqECEOKcNNatMc7qP8TxBjD077JrPTa+DB4CHQV5wSyz3dY+DvV1K9soYfyNhe6Qi0nF
 DJmOINCGEdvAXaP3iFgu7jJjEycOrs8PhMBMOFYO1njqTbzsZD3MgV1TM4DAaWyaGa8J
 LQJFU9M0/QccnpgMS+A/6OEmLI1PDG7zR2wzVyFI4gfoUDpL+Si7uehct86I/xZUuRPP
 kQww==
X-Gm-Message-State: AOJu0Yx+IPVV5Xn6aHMJVcVNYiBUvQeBQ2lgSznw1hqaTwFaOA9tU86x
 OLTa+fE5gybAS3yJcPIS7WMA+bQ+cMYktck/Ylj5jT6zc26vsPz/IjJ5OzO86V2vah3huORY31G
 xZ8m9OwqHTZOPIY4jpYypVf14CV9n/SgC0iuTxBbW
X-Gm-Gg: ASbGncuzR8Mhh3j2zHpFDr+ZEKH6AiOGBHwRd5kWf1ORxj45dKHPBFjwWyyYHraHpjY
 ReyWqmsrzjgh9Cs7gy55ky+8+w8TP1LxySbzTCRjahc5XLn+CDw==
X-Google-Smtp-Source: AGHT+IG0baGlntA9K6VeUAKE0WgSXsxsl29OaQHpOkscyAh9bsWmvIXgJ2qZddQxzbhOf6HDt3yxX9DcxD5uJ/JINqI=
X-Received: by 2002:a05:6214:54c9:b0:6d8:916b:1caa with SMTP id
 6a1803df08f44-6e1b21ef52fmr303490226d6.27.1737463061554; Tue, 21 Jan 2025
 04:37:41 -0800 (PST)
MIME-Version: 1.0
From: Hossein Majidi <queen.homa@gmail.com>
Date: Tue, 21 Jan 2025 16:07:31 +0330
X-Gm-Features: AbW1kvZRqyB9nbMFamom8jzREZE0krL9cmc2L7WMir5VlOEKIgG9v5HiEJShSP0
Message-ID: <CAA---AkDRr9GLCgreFex6T1wnukbqR3OBv5VUM+pqOvRRGC+RQ@mail.gmail.com>
Subject: Guidance on Building a Lightweight and Updated System for PX30 Board
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Tue, 21 Jan 2025 14:06:38 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello,

I have a board from the company 9Tripod with a Rockchip PX30 (X30)
processor. The source code provided by the company includes U-Boot version
2017.09 and kernel 4.4.194, which are outdated, unstable, and heavy.
Therefore, I decided to build a lightweight, stable, and updated
Debian-based operating system with a newer U-Boot and kernel for this board.

To achieve this, I tried using the source code of similar boards that also
use the PX30 processor. Unfortunately, none of those boards could boot
after compiling U-Boot and deploying it on my board. The only board whose
U-Boot booted successfully was *Ringneck-px30*, (However I had to change
its Ram config to DDR3 cause my 9tripod px30 board is DDR3 and theirs is
DDR4) but it still had several issues:

   1. During the boot process, I encountered the error: *"No Ethernet
   Found."*
   2. Any changes made to the Device Tree for the PMIC unit were not
   applied, even after recompilation and flashing.
   3. I attempted to remove the SD Card as a boot target and rely solely on
   eMMC, but this change was ineffective, and the board still behaved as
   before.

My goal is to create a lightweight and updated operating system with the
following features:

   - Proper functioning of *networking* (Network chip: Realtek)
   - Support for *RGB888 Display* and *LVDS*
   - Support for *SPI, I2C, USART, USB OTG, and eMMC (without SD Card)*
   - Support for *RTC and CAN*
   - Exclusion of *Camera, Sound, PCIe, Wi-Fi, and MIPI*

The most critical requirement is that both U-Boot and the kernel are
updated and modern.

I would greatly appreciate your guidance on how to proceed with this task
and achieve my goal. Any suggestions or resources that might help would be
incredibly valuable.

Thank you in advance,
Hossein

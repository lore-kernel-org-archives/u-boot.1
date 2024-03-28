Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462AAC54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 05:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CB098808D;
	Thu, 28 Mar 2024 06:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kLvQ9d9O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CD3B8808A; Thu, 28 Mar 2024 06:02:56 +0100 (CET)
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D09C87D2E
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 06:02:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-4d43b3fc06cso222899e0c.3
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 22:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711602173; x=1712206973; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kjz2dDVlJ/4adcw+ilZgEmHGAEtwONmekCar2FZ+JJo=;
 b=kLvQ9d9O5JfES3re17dXB3z3OLZWnRjw2mmk6z1G8bxw6yx+RCZ805nu5oiJwYvIhc
 4OB7DX4QnkIrEW8atDtw2TFnbEM9aM2ZS/6bJOcWeP68Ydz280Gkx5EJs+XPP86V4Cn2
 xlp8bbcY30Ui9ti/H87/8xzWC2dzg0NmhjOwEFSl5TA9x7hOCul4swvl6WEWi8otWZLX
 Q4fb1AAvzWqXvHeFhKyQIAGJ2AVoMhTMBqFKyKFxHpa+wXwSoH7WSyB9aqq6f8sv60r2
 ZKXrgi9jIHwUlWiYJfkVFHbOl8xMNC7xup9mmaQDU5ZpjTkr2sOFQr+XDEi9z6LtBCNn
 iJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711602173; x=1712206973;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kjz2dDVlJ/4adcw+ilZgEmHGAEtwONmekCar2FZ+JJo=;
 b=L089fGR/+Twnv3OnBKrOQ9Zew4220SRMHGQljaZ25rbJ1qtvNqAxh6zKu1hkMAXE9y
 TqFmhDdvjMylJUNvrf8qYH5TVlXgwwCMBDYtOM+BDnssqnC+z9m2+hgd8G+0XU/YVkRn
 Q+WaUPjoAi2byPFDUI0KulPXnice1hcNi9JGDOCqFqsoNAHfT0Qp7+sUdcyjL8HWpAS3
 YaYI+f9YezvhxyvkrfgFk9Jyeq4/X1x7kMq0mpJ9aGGonMoNnj2/Xz25BkFaWj2avh6I
 V1erHaWSbnmzsEpQTQN+nxA3/oMd2fKQgBKj2raFCAb5ROQB/rGPDrY8fA5YRxT994EH
 sUaQ==
X-Gm-Message-State: AOJu0YwgoLFURPWFtSdufN9D2pFPa5nHVXzYQu/QcTUhYQlf9duIBWjb
 wpobq50vwaze1ftpW6t3xz0hVs8jr74SX5qgfJTKp5TqLioV+fP9qsQ9TpMHuhBqQ6CZySgJU5U
 Ochphh/bwLAvXxXVGwQuLohc4fBKFh/j7z44R1g==
X-Google-Smtp-Source: AGHT+IH0RapVseiP77MNxifYW+OHjh26xo5GPgaGoN85JR7U1K2+0U6IJW9FCXzVtaItEMZpt0Fia0ql7hKTV5VeQeo=
X-Received: by 2002:a05:6122:c8c:b0:4cb:fc25:7caa with SMTP id
 ba12-20020a0561220c8c00b004cbfc257caamr1434905vkb.14.1711602173142; Wed, 27
 Mar 2024 22:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240221120014.149193-1-namcao@linutronix.de>
 <20240313184206.GA20322@m1pro.arvanta.net>
 <20240314130436.76a2892a@namcao> <20240318203431.GA21567@m1pro.arvanta.net>
In-Reply-To: <20240318203431.GA21567@m1pro.arvanta.net>
From: E Shattow <lucent@gmail.com>
Date: Wed, 27 Mar 2024 22:02:41 -0700
Message-ID: <CANV2PTMT+8rcVkZEqX8Db_CV445dvBnFmnTqLj1LCWuUFiG=oA@mail.gmail.com>
Subject: Re: [PATCH] starfive: visionfive2: switch to standard boot
To: u-boot@lists.denx.de
Cc: Nam Cao <namcao@linutronix.de>,
 =?UTF-8?Q?Milan_P=2E_Stani=C4=87?= <mps@arvanta.net>, 
 ycliang@andestech.com, yanhong.wang@starfivetech.com, 
 chanho61.park@samsung.com, wiagn233@outlook.com, sjg@chromium.org, 
 inindev@gmail.com, rick@andestech.com, bmeng@tinylab.org, 
 minda.chen@starfivetech.com
Content-Type: text/plain; charset="UTF-8"
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

Hi, does this standard boot no longer try to boot from the configured
EFI list? I have a boot listing (for Debian's grub EFI loader)
configured with u-boot eficonfig but it does not seem to be attempting
EFI boot anymore, there is a message about card select error but I
think that must be trying the eMMC (mmc 1) and not the SD Card (mmc
0).

StarFive # mmc list
mmc@16010000: 0 (SD)
mmc@16020000: 1

StarFive # help bootflow
bootflow - Boot flows

Usage:
bootflow scan - boot first available bootflow


StarFive # bootflow scan
Card did not respond to voltage select! : -110
No working controllers found
ethernet@16030000 Waiting for PHY auto negotiation to complete....... done
BOOTP broadcast 1

StarFive # bootefi bootmgr
Card did not respond to voltage select! : -110
Booting: Debian bootloader GRUB
error: no suitable video mode found.
"                                    GNU GRUB  version 2.12-1+b1"...

The documentation for bootflow command seems to have a lot more
options than what I'm seeing now?

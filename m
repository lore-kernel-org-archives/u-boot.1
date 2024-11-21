Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533C5E64039
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 22:42:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C900C896C2;
	Thu, 21 Nov 2024 23:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PUerfXnq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 349F6896C5; Thu, 21 Nov 2024 23:42:08 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9A8D8919F
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 23:42:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ffa12ad18cso11572401fa.2
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 14:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732228925; x=1732833725; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SxJRfPZo5yGcaWJaBwIRIgX6E8NGo7ZT6qBJtS2y/Hs=;
 b=PUerfXnqPzIqtTbqHCK1FGZRO0DbypgRFSC6+Bx4PMClq575DNkzc/XmEl+XT3Ynjr
 02ia0+B62opcwOW11vbVNJttz00Giw2ovK48bOMJoX9syCJk5Hg9DKK1wVp1w1GN5tt9
 xC9chnga8L2aMt4Y4xDvEBLTQHj2o5jaPx/4c/cPiIG4uqT5ZEsZZqff3mH/fDHFtUUz
 cEsekkNErINWwLENsqPsoBO1tsdzzXUkF1DdfU5Cc1vysyPlNz6JpXX1geFs9dU6AEKe
 EulcnCyByqTKYfOlGeO3m3l6N9SfSrd2mPnQjbY9CrXwh/SJ0GJA69SU3DJ5f6TnybZi
 zy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732228925; x=1732833725;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SxJRfPZo5yGcaWJaBwIRIgX6E8NGo7ZT6qBJtS2y/Hs=;
 b=WmOas9NgaR3DalL+oLsZrNDQeqG198N6Si88wS4qv+qVgb1n3LYKAPrsouxDcRoayD
 EvwmaXdI7Us7ykKuiHCcT/Jj/ojrB12oF/90y4Lwd65wqV0qAOcFLWH94OiztC6dv8Ri
 tQQ0ks/Absvaxk9qI86ULfc2h7RfqRCM5YFa8kC5e3qGIGvXJyU59wyQvkLGFCQ4Utpt
 am/kHgoZuXTMATrzxsiVanLEhv5myS4Tgo0t/dEUqg1jvZRPEHvv11C9NevO557v7hnZ
 sBaxly96O2TvGHB+L4hvaF8GAnfJYWD1DpxgIvPcQFf0yRa6kCjCNYINHe0lPxzKnmRF
 36yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVObNnEGrSUBakQvHGdmYeQbjuYEpVIeuNaJVOgDsDC3E8AQf2bhVw+8Dut/RCPuYqOZNRxHtA=@lists.denx.de
X-Gm-Message-State: AOJu0YwqmGFOv9wiQUGgm8M/YTXURFUT/Jak0d2RSoEE20JR9dvYpFBa
 CkJEn2eqJtdDcZ73wU9vKTA+dT+tI8XFazmmllFijhDG2QYk5i5SH9wZE/8P/vzKXovIu2Hxk9e
 9efK3QzkV8b9LY3nHZlHdNL0IFJk=
X-Gm-Gg: ASbGncvAnTamR7wQRKieoDaGFzcMMP9t8C5Kfxf/ciDdmM8abVamkBAd3+5hLZx/8Yh
 8pnqLElnHci8Kk2ErrPX1tlD+7oprpmVVbny0/gcQFZ3i1a8FW07uIH9FkNd1i2UNkg==
X-Google-Smtp-Source: AGHT+IEh7IaQ9jhn6jgRy8xe996yHnXzW5zAjjcvRAbA6TkkP0DCpk6R7LLKP05r9cXV+Y/5nqk+DLyzJ8lahnkwjZQ=
X-Received: by 2002:a05:651c:1990:b0:2f9:ce91:dea9 with SMTP id
 38308e7fff4ca-2ffa71811acmr2439051fa.32.1732228924654; Thu, 21 Nov 2024
 14:42:04 -0800 (PST)
MIME-Version: 1.0
References: <20241121142522.59059-1-heinrich.schuchardt@canonical.com>
 <mvmjzcwobi0.fsf@suse.de> <a6a1d0cb-c363-47bf-aa91-b3c2ad2fd5b9@canonical.com>
In-Reply-To: <a6a1d0cb-c363-47bf-aa91-b3c2ad2fd5b9@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Thu, 21 Nov 2024 14:41:52 -0800
Message-ID: <CANV2PTNnOC43iYnyoczWev+2vAjKR+BEU5o1rEyZqr4uPVaJ8Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] configs: JH7110: enable EFI_LOADER_BOUNCE_BUFFER
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Andreas Schwab <schwab@suse.de>, Minda Chen <minda.chen@starfivetech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rick Chen <rick@andestech.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Hal Feng <hal.feng@starfivetech.com>,
 Tom Rini <trini@konsulko.com>, Chanho Park <chanho61.park@samsung.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Nam Cao <namcao@linutronix.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
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

On Thu, Nov 21, 2024 at 8:05=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 21.11.24 16:24, Andreas Schwab wrote:
> > On Nov 21 2024, Heinrich Schuchardt wrote:
> >
> >> Our MMC driver for JH7110 boards only supports reading to the low 4 Gi=
B of
> >> memory. Booting boards with more memory requires EFI_LOADER_BOUNCE_BUF=
FER.
> >
> > That doesn't change the situation with the booting problem I have.
> >
>
> Do you relate to
> https://lore.kernel.org/u-boot/mvm8qtnv310.fsf@suse.de/
> where you had some problem reading the FAT file system and which was for
> as system with only 4 GiB of memory?
>
> In E Shattow's case on a board with 8 GiB the file was read without
> error but then reported as not being an EFI binary.
>
> Best regards
>
> Heinrich
>
>

Hi,

Test failed for both boards here with origin/master then applying this
series, then starfive_visionfive2_defconfig target and set
CONFIG_BOOTSTD=3Dn following with oldconfig target.

Testing failed on 4GB Star64:

Hit any key to stop autoboot:  0
Unknown command 'bootflow' - try 'help'
StarFive # bootefi bootmgr
Card did not respond to voltage select! : -110
Not a PE-COFF file
Loading Boot0000 'mmc 0' failed
Booting: nvme 0
error: no such partition.
grub rescue>

The grub EFI loader from EFI System Partition on eMMC fails to load.
The same EFI System Partition data on NVMe is successful.

Testing failed on 8GB Mars CM Lite:

Hit any key to stop autoboot:  0
Unknown command 'bootflow' - try 'help'
StarFive # bootefi bootmgr
Card did not respond to voltage select! : -110
Failed to load EFI variables
Error reading cluster
Loading Boot0000 'mmc 0' failed
EFI boot manager: Cannot load any image

We see that the grub EFI loader from this EFI System Partition fails
to load from MMC (SD Card).

Procedure that was used to update SPI NOR flash on either board
includes sanitizing the environment variable storages:
env erase; env default -a -f; sf probe; dhcp; env set serverip <ip
address of tftp server>
tftpboot $loadaddr u-boot-spl.bin.normal.out; sf update $loadaddr 0 $filesi=
ze
tftpboot $loadaddr u-boot.itb; sf update $loadaddr 100000 $filesize
fatrm mmc 0:1 ubootefi.var

This does not say anything for or against the validity of the patch
series as the root cause is a limitation of the dw mmc driver on
JH7110 not resolved here.

-E

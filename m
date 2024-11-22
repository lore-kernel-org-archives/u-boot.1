Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC0AE65D0C
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 06:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9059089797;
	Fri, 22 Nov 2024 07:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oOHCQbXk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3715B89775; Fri, 22 Nov 2024 07:32:15 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC09F8970A
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 07:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5cece886771so1968219a12.0
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 22:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732257132; x=1732861932; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TSbLOmeWjiqdYV8umYH56mCp+miRN0UYjA+RSwczXV0=;
 b=oOHCQbXkR+OA+vyjdxgVTGTz8zkvo7niFeJd9e0iknQwz0J1p96Nb1F5xWfrz4bu/w
 h12ukBtVdkHaSu/sWtIjOcv/x/LgLytz/cygqIwl5CYRS+9Ng/cNkRZePbuyMZxCWG3R
 /sJEVI1pwzBf9mhuy8/ELgrJvNlhtnmCa9wdGS6Sk1AWo4ydvyVi/fXc7S/nvSen14Gb
 MTtHHtVWWoRm5RW6OCBkf6LQ5Zyrevb1Kpd3GixWdV7gT9PlyDEAqUIT2fRt59HX3Cfd
 hjvUJf05J/P2Qqcs/Vbye6QYSRk80aP4UsoavXgKUtoAnQoILv+aMtpFEnhIsL6eKCk1
 xxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732257132; x=1732861932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TSbLOmeWjiqdYV8umYH56mCp+miRN0UYjA+RSwczXV0=;
 b=aANYbM/nhb+E2WwTdQd+mWZBswuRZJ2xz4YE5ShTHlNHl7XZ9Kx402aFPYIMl7DuF6
 i0BWevhp2QyFVt0nNNRX4cLPlRq+RPcrxrg3Rg54p/wuAtkoBYWYd1Z56LG4fnHbjRjq
 gUBhsUZGxdnvNNNHhMxMrq5lPsfEBl6gFdgtbqLBi3uH+pq3oXB+NQ0r6pwiplZsRtNi
 35zvL1hIrAgEpRS3RwIaPS204uXbzkEuuMno/Cmx/ciMDRg+n5b+wzJYOhoSim3yWajo
 qYkQ8Xz4/GI/f7WiJawSTsCsGHUvs5YMkfryVcdCs3KzQ/yHvsS4dB140SNP5u1zWvm6
 i4jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7lTHEf5WMUw2r6/nEyMYkJh6+bnxXOMk/g9+oVPnAnwGIjrQEiGi99ydciZ5ez+1D57QGtkE=@lists.denx.de
X-Gm-Message-State: AOJu0YwQ65gJTKCchGHL7z9KRUpXALcxTsMRXah+hfYH1qOVuRRFmWym
 Kwb9Fie0SxSH51NoEjQNt/PDCRUNYR0nOM4FLjAktsm5/k+bF3Gp+V4+wmAGFeEJV3xprbE9ghA
 Yj61o6f8o3dsACSggIhFrvER93rcZUVZY8txs9A==
X-Gm-Gg: ASbGncsYseATdLuaK2VgyoG9fAq6YMMAbYVv44AfN7D/V2J7d8QPFnZKBBM75ncSbna
 5IcF1FA14X5ujhFK8h4yioq9cb9Q1CkDT
X-Google-Smtp-Source: AGHT+IEa2qLHCV/x2hlhC0zSoaMAP8yQwhSn+yp6zK+MzkfKtQ/X3YNEcjQKohd7Y8uNWsD8eIttfgtep7OjptgzmvQ=
X-Received: by 2002:a05:6402:2686:b0:5cf:d341:dfec with SMTP id
 4fb4d7f45d1cf-5d0073daa0cmr6162198a12.0.1732257132073; Thu, 21 Nov 2024
 22:32:12 -0800 (PST)
MIME-Version: 1.0
References: <20241121142522.59059-1-heinrich.schuchardt@canonical.com>
 <mvmjzcwobi0.fsf@suse.de> <a6a1d0cb-c363-47bf-aa91-b3c2ad2fd5b9@canonical.com>
 <CANV2PTNnOC43iYnyoczWev+2vAjKR+BEU5o1rEyZqr4uPVaJ8Q@mail.gmail.com>
In-Reply-To: <CANV2PTNnOC43iYnyoczWev+2vAjKR+BEU5o1rEyZqr4uPVaJ8Q@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 22 Nov 2024 12:02:01 +0530
Message-ID: <CADg8p97T1L-JwPRAu7Wq4Uz-yEBuvNucJcNULcCTi2o+zFTRiQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] configs: JH7110: enable EFI_LOADER_BOUNCE_BUFFER
To: E Shattow <lucent@gmail.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Andreas Schwab <schwab@suse.de>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Rick Chen <rick@andestech.com>,
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

On Fri, 22 Nov 2024 at 04:12, E Shattow <lucent@gmail.com> wrote:
>
> On Thu, Nov 21, 2024 at 8:05=E2=80=AFAM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 21.11.24 16:24, Andreas Schwab wrote:
> > > On Nov 21 2024, Heinrich Schuchardt wrote:
> > >
> > >> Our MMC driver for JH7110 boards only supports reading to the low 4 =
GiB of
> > >> memory. Booting boards with more memory requires EFI_LOADER_BOUNCE_B=
UFFER.
> > >
> > > That doesn't change the situation with the booting problem I have.
> > >
> >
> > Do you relate to
> > https://lore.kernel.org/u-boot/mvm8qtnv310.fsf@suse.de/
> > where you had some problem reading the FAT file system and which was fo=
r
> > as system with only 4 GiB of memory?
> >
> > In E Shattow's case on a board with 8 GiB the file was read without
> > error but then reported as not being an EFI binary.
> >
> > Best regards
> >
> > Heinrich
> >
> >
>
> Hi,
>
> Test failed for both boards here with origin/master then applying this
> series, then starfive_visionfive2_defconfig target and set
> CONFIG_BOOTSTD=3Dn following with oldconfig target.

I think you need to apply another patch [1].

-sughosh

[1] - https://patchwork.ozlabs.org/project/uboot/patch/20241121142522.59059=
-2-heinrich.schuchardt@canonical.com/

>
> Testing failed on 4GB Star64:
>
> Hit any key to stop autoboot:  0
> Unknown command 'bootflow' - try 'help'
> StarFive # bootefi bootmgr
> Card did not respond to voltage select! : -110
> Not a PE-COFF file
> Loading Boot0000 'mmc 0' failed
> Booting: nvme 0
> error: no such partition.
> grub rescue>
>
> The grub EFI loader from EFI System Partition on eMMC fails to load.
> The same EFI System Partition data on NVMe is successful.
>
> Testing failed on 8GB Mars CM Lite:
>
> Hit any key to stop autoboot:  0
> Unknown command 'bootflow' - try 'help'
> StarFive # bootefi bootmgr
> Card did not respond to voltage select! : -110
> Failed to load EFI variables
> Error reading cluster
> Loading Boot0000 'mmc 0' failed
> EFI boot manager: Cannot load any image
>
> We see that the grub EFI loader from this EFI System Partition fails
> to load from MMC (SD Card).
>
> Procedure that was used to update SPI NOR flash on either board
> includes sanitizing the environment variable storages:
> env erase; env default -a -f; sf probe; dhcp; env set serverip <ip
> address of tftp server>
> tftpboot $loadaddr u-boot-spl.bin.normal.out; sf update $loadaddr 0 $file=
size
> tftpboot $loadaddr u-boot.itb; sf update $loadaddr 100000 $filesize
> fatrm mmc 0:1 ubootefi.var
>
> This does not say anything for or against the validity of the patch
> series as the root cause is a limitation of the dw mmc driver on
> JH7110 not resolved here.
>
> -E

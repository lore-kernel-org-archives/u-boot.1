Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF4FC28B2E
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 11:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2A4C80F9C;
	Thu, 13 Mar 2025 12:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hQZKoH9p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18B8981335; Thu, 13 Mar 2025 12:58:19 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E02F98007D
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 12:58:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso7755955e9.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 04:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741867095; x=1742471895; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hpjRtzAown3J4hyyLrJv7mWZWVC/qaNZoevBnYAipDw=;
 b=hQZKoH9pWBfQuDJIL1+mds8kFucVJwNScCF+juVmSybH6ULrx67/R2rTbhLWhb9s0o
 RG3eYwO0s32sqXCHZB/b9/3A8Geh14G4zg/iftZMA7AAPqTs0e04KzIckIJzq9051aEO
 4Kedt87LR1u+CCkGMkNHJxjvPWFDs1Q93hrPSY4v8Kgi2JrFlkg2FMYj90+HHqEZnSic
 E59H0u2SQU5ZTRFk8DCR9qiHHIzcaSDB0lzFljcfUH5MCCXs5qvepQPEUm90El84eZ01
 HZ0JcYbMa+S9NmxLjWwUOMhHhsQwFvZ/Yu+/SnwFzI3t4hxOiAzxl5BLPfEnHzR9P3nn
 hGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741867095; x=1742471895;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hpjRtzAown3J4hyyLrJv7mWZWVC/qaNZoevBnYAipDw=;
 b=duCgJ7ZtkgsI8NpgzDNyWPtQGdtCGJ+hcZiY0+lSARy/tegvQg2J6NZVbwwZ22MeHM
 OafjFBN1wL4+oWNpZKWmv6GNkbIpzwncLEIGgqlxCyrebZg9C7YcwYEYeSUDVswPErLJ
 iZ4JvBABuzmbgqnAaXTVfmZRwCWoJr9C/4I2vCpIDLmwAJPnP2oT9kW8ILYPIVLwt6Gb
 +ANPIZXxa6wyEIAC+UuRq6tjKmge5q5Tcl22mgMPD/wuA3Kx2VcCZwnACrvvq3lTx4II
 ki/8kLJO5uO5EzsLCCcnjkgAPgg5pos5yA0vhiuxYVX054B0qRvogN7GQa7QUi5Qtiaz
 sOnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPIbRTcC1pkc8c1dPuw2TVvEjQUEwAOFpIKO50LjaOs+uoQtMtd7odvFKVIwjGgZ93VkAt6L8=@lists.denx.de
X-Gm-Message-State: AOJu0YzMJuSrpj2wI4bzXafdchU5U9lkoBfjF2XUh8DrbSJcNFZLIOOS
 HetITXojxSLr+k0Gr6VHM0BUE7VF2PWNCPeR3HAWdJO672wtJgL6r5GJkEQhNDS791bTQrZhDu4
 gUrGsBUJ9LRkbECJ2DX7FGMDBOVQ=
X-Gm-Gg: ASbGnctrqBeA5oiMx/Wrj3acDAlIGT3Hka2KCK2il3ALRl1PmB7/eroOVmUrtXG0WVb
 tfquJRFHcpEdKHJMdKNQAr0NVdonTzrni1HGhOPcQLk4h2hzeMcJvP9LzTDvIGhG2QZdeNAZMFs
 KNt7XFl2RVV5EHLHsE6ucBa1hZJVTPTy0YdeUUiQ==
X-Google-Smtp-Source: AGHT+IGtp8oxP/v5B1ZVQvP/DcSmbuJXr0YIZee+9W68NOcPsEKi4KZevOi4R8kN+6G5GRaIBZmBf/UySSZ3+DRg5Aw=
X-Received: by 2002:a05:600c:a201:b0:43c:e481:3353 with SMTP id
 5b1f17b1804b1-43ce481377bmr199463145e9.17.1741867095043; Thu, 13 Mar 2025
 04:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250312175857.120313-1-clamor95@gmail.com>
 <CALeDE9PBFv1ebVBrmAzUgEtD+jnfjxDMk7grQYG1tKmD=hQMjg@mail.gmail.com>
In-Reply-To: <CALeDE9PBFv1ebVBrmAzUgEtD+jnfjxDMk7grQYG1tKmD=hQMjg@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 13 Mar 2025 13:58:03 +0200
X-Gm-Features: AQ5f1JrwU5T4ysyBYsY0OlEP9kXOb9g1LYrh3nL3Z5j7v5rPctyeBN3tH_m6nMA
Message-ID: <CAPVz0n0o6UMr-AGHdH5YPxcOaRGwoe=4R3fcaZLej4n=rjPYZw@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] video: tegra: migrations, HDMI and HOST1x
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 u-boot@lists.denx.de
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

=D1=87=D1=82, 13 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 13:55 Pete=
r Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hey Svyatoslav,
>
> What generations of the hardware do you expect this to work on?
>

Changes were tested on T20, T30, T114 and T124. They all successfully
work with proposed changes.

> Peter
>
> On Wed, 12 Mar 2025 at 17:59, Svyatoslav Ryhel <clamor95@gmail.com> wrote=
:
>>
>> Migrate DC and DSI to support video bridge UCLASS and OF graph bindings.
>> Add HDMI and basic HOST1X bus drivers. Move DC driven PWM backlight
>> into DC node.
>>
>> Svyatoslav Ryhel (10):
>>   video: tegra20: implement a minimal HOST1X driver for essential clock
>>     and reset setup
>>   video: tegra20: provide driver support for the HDMI controller
>>   video: tegra20: dc: add video bridge support
>>   video: tegra20: dc: convert to use of_graph
>>   video: tegra20: dc: get DSI/HDMI clock parent if internal DSI/HDMI is
>>     used
>>   video: tegra20: dc: remove unused video operations
>>   video: tegra20: dc: support binding child devices
>>   video: tegra20: pwm-backlight: convert into DC child
>>   video: tegra20: dsi: convert to video bridge UCLASS
>>   video: tegra20: dsi: respect speed mode used for DSI commands transfer
>>
>>  arch/arm/include/asm/arch-tegra/dc.h        |  46 +-
>>  drivers/video/tegra20/Kconfig               |  16 +-
>>  drivers/video/tegra20/Makefile              |   2 +
>>  drivers/video/tegra20/tegra-dc.c            | 233 +++++--
>>  drivers/video/tegra20/tegra-dc.h            |   3 -
>>  drivers/video/tegra20/tegra-dsi.c           |  12 +-
>>  drivers/video/tegra20/tegra-hdmi.c          | 623 +++++++++++++++++++
>>  drivers/video/tegra20/tegra-hdmi.h          | 652 ++++++++++++++++++++
>>  drivers/video/tegra20/tegra-host1x.c        |  86 +++
>>  drivers/video/tegra20/tegra-pwm-backlight.c |  12 +-
>>  10 files changed, 1603 insertions(+), 82 deletions(-)
>>  create mode 100644 drivers/video/tegra20/tegra-hdmi.c
>>  create mode 100644 drivers/video/tegra20/tegra-hdmi.h
>>  create mode 100644 drivers/video/tegra20/tegra-host1x.c
>>
>> --
>> 2.43.0
>>

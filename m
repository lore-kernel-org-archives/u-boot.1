Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00CBC28B2E
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 11:56:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C2F381895;
	Thu, 13 Mar 2025 12:56:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jv2FQZI1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA8D9819D9; Thu, 13 Mar 2025 12:56:00 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B55BA81895
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 12:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e60cfef9cfso1201700a12.2
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 04:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741866954; x=1742471754; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QRpxSbJlIeQSIYbWiNwathLWaS5B+fvjF3MhqlnUNNk=;
 b=jv2FQZI1V1AXA/SSFsI59Ir+qrjb4ilS6+CMhOop58h7Yy53ISRDKHV5suJA4DKGmk
 577WLzKh0TnOjp7d4EruhSeAQ7Cu9ueGbXxIm6WZGuqFml9tmVg4hznqrUSHROrDULsx
 tiXQXBKbvNDLkyrbGOF3bW/6Bc/eKhfkWc9ZPAwfaWxSv1UlnogTkI5UXFZ+mbGgSdmj
 ZvKz71ZnuZDxJDf5ot5YNLp3V6SRJiBnQYOEbq11J0yHQpRCqTvwfmPrsmUEPLiXBHSP
 0JKHmAne6YowS76N4amA+zea/qFLO/a35pMYaKvgQ/JB8BcrmbBJjAXfzFEs0WZiaivA
 VtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741866954; x=1742471754;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QRpxSbJlIeQSIYbWiNwathLWaS5B+fvjF3MhqlnUNNk=;
 b=rIEpP66OyjRCQ+PBOuM4wkYwesDbfvnLAxO4nR5flWPBfxMdizfD9OhlaI0/BRZKQf
 aUeYzBJfpIFZMC2igNKESUPt4hktvrIfC4ca5ccsEw79f0uD2c/Yndu1cQtJuAljQm7Y
 hiTJiYyfPXrmhP3sBfG8iSPbILofa8gRXHtRkhCBqx1MRh4LUVejVtEsDQCJVma2ccTs
 gQYlgeRyQMKS6IVEvGKBX32PkGI0+DFV3kQqFT/rEGslAKEekk6wz/HfVwnh/YY6bYfP
 wettE9MCzmYtkXDmzAmZ/n1rpqNXhdx2qJ8OF7Hhu9wSzBRNMZdlvXNgv4pwHHPUTIfX
 nhcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+nE/SAmw+3NoIpo9TVGLomPl2luKBvC+6vgBjGJkZQABrWKUeTHqceH7isTeZCvSGkMFNiAA=@lists.denx.de
X-Gm-Message-State: AOJu0YypHAsKlNgCoZ4dJI+/eamDLzC/3mjOFBA402p7w2Qh6MDe/499
 0/0+vwYLFA8ArhA8gJv0UOH3uQ4mUzBtY+CLNtwfKbNmnmoVBq31ENDpzWvHN9JuRS/PEe6GZvK
 mg2uspf5iiVhbHIAy/YUYQ7DnIZ0=
X-Gm-Gg: ASbGnct6cMImz35DV0/6m9EGASfi5TrE77DOAuYYYtTrMj4xC2alswcgt8IOqKolO2E
 w4gQYS0/v0py6mf/7QdeWrTJ1aXwW8u2b95vtfrPNMQxbFJGTHrOjfEOeEV+90j8hO6NL/zIfBM
 TOH0q3I5FvVxXemXzyanaM2amny8x6XYzvlLysR1VsNUk3Ge6SvV+ZHVNujVU=
X-Google-Smtp-Source: AGHT+IGWMxBZJtu97u01xDB7hoWNfQku5tJCCMjXsPmqP+9BuMg6sTAyK996OL5tkSYq0ehSz1ZLuCNFp3OiLAmyqpY=
X-Received: by 2002:a05:6402:43cb:b0:5e7:8be5:d1b1 with SMTP id
 4fb4d7f45d1cf-5e78be5d41emr12224987a12.19.1741866953969; Thu, 13 Mar 2025
 04:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250312175857.120313-1-clamor95@gmail.com>
In-Reply-To: <20250312175857.120313-1-clamor95@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 13 Mar 2025 11:55:42 +0000
X-Gm-Features: AQ5f1JolN5GcNA3tmOPbb7DdgbmTPoRJdRrbDWvQOlBI0JyeXRylBUgsIOaGtE0
Message-ID: <CALeDE9PBFv1ebVBrmAzUgEtD+jnfjxDMk7grQYG1tKmD=hQMjg@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] video: tegra: migrations, HDMI and HOST1x
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 u-boot@lists.denx.de
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

Hey Svyatoslav,

What generations of the hardware do you expect this to work on?

Peter

On Wed, 12 Mar 2025 at 17:59, Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Migrate DC and DSI to support video bridge UCLASS and OF graph bindings.
> Add HDMI and basic HOST1X bus drivers. Move DC driven PWM backlight
> into DC node.
>
> Svyatoslav Ryhel (10):
>   video: tegra20: implement a minimal HOST1X driver for essential clock
>     and reset setup
>   video: tegra20: provide driver support for the HDMI controller
>   video: tegra20: dc: add video bridge support
>   video: tegra20: dc: convert to use of_graph
>   video: tegra20: dc: get DSI/HDMI clock parent if internal DSI/HDMI is
>     used
>   video: tegra20: dc: remove unused video operations
>   video: tegra20: dc: support binding child devices
>   video: tegra20: pwm-backlight: convert into DC child
>   video: tegra20: dsi: convert to video bridge UCLASS
>   video: tegra20: dsi: respect speed mode used for DSI commands transfer
>
>  arch/arm/include/asm/arch-tegra/dc.h        |  46 +-
>  drivers/video/tegra20/Kconfig               |  16 +-
>  drivers/video/tegra20/Makefile              |   2 +
>  drivers/video/tegra20/tegra-dc.c            | 233 +++++--
>  drivers/video/tegra20/tegra-dc.h            |   3 -
>  drivers/video/tegra20/tegra-dsi.c           |  12 +-
>  drivers/video/tegra20/tegra-hdmi.c          | 623 +++++++++++++++++++
>  drivers/video/tegra20/tegra-hdmi.h          | 652 ++++++++++++++++++++
>  drivers/video/tegra20/tegra-host1x.c        |  86 +++
>  drivers/video/tegra20/tegra-pwm-backlight.c |  12 +-
>  10 files changed, 1603 insertions(+), 82 deletions(-)
>  create mode 100644 drivers/video/tegra20/tegra-hdmi.c
>  create mode 100644 drivers/video/tegra20/tegra-hdmi.h
>  create mode 100644 drivers/video/tegra20/tegra-host1x.c
>
> --
> 2.43.0
>
>

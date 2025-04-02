Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0EFC3601B
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 19:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D43BE81FDE;
	Wed,  2 Apr 2025 21:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZFb9T72r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DD6581F66; Wed,  2 Apr 2025 21:22:45 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DB1281F44
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 21:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac28e66c0e1so19427166b.0
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 12:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743621763; x=1744226563; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lp2+wGE1mw4+MGSoVxcN/o2XaveiKr8z3/GcO3IX0rg=;
 b=ZFb9T72r38PZPCU9cfDkpVC2RAToQI5so1cJPsTqhaRgxulpXMuRjDDGS+d+lj9t4D
 cwhcyEvN/IFow/aZIEA09UDWVv4riEor+247UtGDGbSIHqZ1dPZjuHdmrCMxVs5nyuOj
 /9g6OVeMKoxrLSHqgsMG1FHVsXnClPpVB9vTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743621763; x=1744226563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lp2+wGE1mw4+MGSoVxcN/o2XaveiKr8z3/GcO3IX0rg=;
 b=M8bANVWrtU6VYo1idAMSRNgERy52BF5d5yfjJOqHKKjBDHat3uFNn1dP/aQ+H3a1AS
 G9dnk/mI8YeECE7xZ6Tb1VGFcHD7ZN1sFMPEVZG7yv4WAfwDjekW/Izw2TrZAbr81toO
 qzC9JpY6/QF3rTw7x6sQuXOxk+RMQm8VEigfshDUc18CcPy07d2PngKtX11D+47SZGNO
 9+zxlJOgulImzeMVifHQj8ZhCqvJpoQxrl6xyeTHLe2JoJXOhQE1a1I6HKJTVMlfr9NT
 FrovRsvPZ1DLK+SwXWNToDi/ywqtnvpW2e6iDWYbvMG+TX6X9Yss1svI6t3pX2OcDL1z
 0jIQ==
X-Gm-Message-State: AOJu0Yz5Jzw/MY3EwcUBzdMPfZvGlpFKqz3e27E+ZsCtJGw0RHJOK9yS
 ad+vrKHOdVsXVEMfRoShmWPvX9IbcQY8+tX63+L6McAPuS18FRpv9QaVS+xyX259pbxy6oIPiNX
 rs0kuavUAjDqGYPEpeYgLgMgEF2r93HDfdi7a
X-Gm-Gg: ASbGncuOgWNx1MGeS+ev2mSIW8zBLt2CAYNymeuYe01dxYUycXVbHP59OTSxgDnTCtY
 VTGSaEAdMFRWqdEQ3IXRAAKGtkA9AtKg7N2udj8hGvPAcg2v3MiLQhQSiDknUM0+tkt5O1kbBNz
 PRo0auuxu5ZVrKTWcZ+Ch+UKJ0/W0rc8srMKg64ss=
X-Google-Smtp-Source: AGHT+IEiqY8L9rSvPCWPm3L7qCNPMdJOfOu0PAg5J4mXmNrmF5761+IQkwn8rGeDyNgct7iPul35ACZTPsWVCdq5RF4=
X-Received: by 2002:a17:907:868a:b0:ac3:bd68:24eb with SMTP id
 a640c23a62f3a-ac7389e793cmr1867546966b.1.1743621762512; Wed, 02 Apr 2025
 12:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-39-sjg@chromium.org>
 <20250402142851.GS5495@bill-the-cat>
In-Reply-To: <20250402142851.GS5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Apr 2025 08:22:30 +1300
X-Gm-Features: AQ5f1JrcJKlV9glqrWb0iM3ECUxZrPuW6rXQ3rKGXVUF6KsGqXQAFY72-GDjEU0
Message-ID: <CAFLszTjmrn0_idbmmS53dgbK45YsZHHNYN+38i5OhtrRBWHijg@mail.gmail.com>
Subject: Re: [PATCH v5 38/46] boot: Consider non-bootable partitions
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Tom,

On Thu, 3 Apr 2025 at 03:28, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Mar 15, 2025 at 02:25:58PM +0000, Simon Glass wrote:
>
> > Any 'bootable' flag in a DOS partition causes boostd to only scan
> > bootable partitions for that media. This can mean that extlinux.conf
> > files on the root disk are missed.
> >
> > Put this logic behind a flag and update the documentation.
> >
> > For now, the flag is enabled, to preserve existing behaviour. Future
> > work may provide a command (or some other mechanism) to control this.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v4)
> >
> > Changes in v4:
> > - Rewrite the commit message
> > - Enable the flag by default
> >
> > Changes in v3:
> > - Add new patch to consider non-bootable partitions
> >
> >  boot/bootdev-uclass.c            | 4 +++-
> >  cmd/bootflow.c                   | 2 +-
> >  doc/develop/bootstd/overview.rst | 5 +++--
> >  include/bootflow.h               | 2 ++
> >  test/boot/bootdev.c              | 1 +
> >  test/boot/bootflow.c             | 5 +++--
> >  6 files changed, 13 insertions(+), 6 deletions(-)
>
> Having spent another 10 minutes just now trying to understand things,
> again:
> - The commit message, and the implementation are either in disagreement
>   or just too vague. Saying "to preserve existing behaviour" is unclear
>   about which behavior is being preserved, since we're setting the flag
>   to continue to only check bootable flagged partitions
>   (BOOTFLOWIF_ONLY_BOOTABLE). But then we would continue to miss
>   extlinux.conf files on root filesystems, which would seem to be the
>   bug that needed fixing?

How about 'to preserve the existing behaviour of bootstd which is to
ignore non-bootable partitions so long as there is at least one
bootable partition on the disk"  ?

> - It's still unclear if this makes bootstd match the exiting distro
>   script behavior or not, and from your other emails it sounded like you
>   were expecting someone else to dig around.

The distro scripts include the code below. My reading of it is that it
only considers bootable partitions, except that if there is none, then
it always scans partition 1.

"scan_dev_for_boot_part="                                         \
"part list ${devtype} ${devnum} -bootable devplist; "     \
"env exists devplist || setenv devplist 1; "              \
"for distro_bootpart in ${devplist}; do "                 \
"if fstype ${devtype} "                           \
"${devnum}:${distro_bootpart} "   \
"bootfstype; then "               \
"part uuid ${devtype} "                   \
"${devnum}:${distro_bootpart} "   \
"distro_bootpart_uuid ; "         \
"run scan_dev_for_boot; "                 \
"fi; "                                            \
"done; "                                                  \
"setenv devplist\0"   \
\

Regards,
Simon

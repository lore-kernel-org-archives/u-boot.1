Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CFDCCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60CF7842C7;
	Fri, 10 Oct 2025 21:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SdgOcGtI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9052184040; Fri, 10 Oct 2025 21:39:14 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD14A84040
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-634b774f135so4056262a12.2
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 12:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760125150; x=1760729950; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5cLCRYerlnKVNCqQF1pMi1edx8JWA7mHtnP3N2pCeHE=;
 b=SdgOcGtISdYxPpQqc24FPe8CNdZWazfzHn09kIvVix6EzsREq49t3dIFEhueXzXynn
 +kkZ2AU6SVe4TQILHZPEP7m4M19Okgga6DvQiBgEN4w82Ri5ky808cCgtkA1rCWtGrWm
 JPIKzbeVPJIQW+h3byE24iOty3ggLun2dQDkR3Pa6NeprlHlcZDjeG0I4RqDUWhtU7cx
 8BBmWx2AK5l1CbGXAz9j/NwZKandyxiAkaqnkgeN/eLCPtz6mB+7lNrC47If8CjL1tE/
 cvdj0SfcT3HypXoZN717guEKc0sVIegZX+7Ozh4uZIJS3T0wuvsDXH/m4xEGqR/bJOmK
 srTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760125150; x=1760729950;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5cLCRYerlnKVNCqQF1pMi1edx8JWA7mHtnP3N2pCeHE=;
 b=QygL5HABKQ/EOvu1k4KW6HvxcFKOo6PS5oJd6kIkYziEsRqfYDLlfyXNEyZ9r+utx+
 oYMsuDh7p/31/NpPEiJUoWqC+ugeTPmsGnQI7Q3jywUj5acu7f7aAG9kNfgQ8rIRtZqy
 7FHu3OShL5TX6i65/L+QOmDDC49JGyqS36R5i3KXb11gb4/yY/46VZ+lKsQCNU/9cmUL
 HK5jTfQr7T7z1sl5GM4RFEUeRnptQ5MZbGoBmHb76gVibjd7swij7u49oVOgUyxA4ZUs
 9jZ9Aqi4G5owrY8ZNAA50X0laKPbJvbnQ3Kyd9LYITnHoxSmr0kdBKXsQ29PKI6E7+Dv
 n6LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxl9xuIMmxkcpkBvLazdj66HBWNz39g4DZSk0IWc6xFGuOaOyeLGaZmihXTHAt6Yx1SipMWZU=@lists.denx.de
X-Gm-Message-State: AOJu0YyAQT3qFSHl+LLsxawF5FZIyQ7Caz+RH7I6lXuX454kZ7knN/sp
 QGxycRwN6rHQg2JtVDtxe6yn8+j07wugCaXazA9KoCO379+tJioqGmyRUvOUNs42bUIOJgEKBRT
 pFiXX6kyDZAQG2plI/IVlBhC9RZ4IiYI=
X-Gm-Gg: ASbGncsfFfNhxFiaRq6TilKGX2cYHnvtqhw1w2CsbwOFGaM2iGOSI7Zu4hTP8UqyzKm
 z1/4PH3PSeDgbjamXAfycm/QkDIPQOEJrA4IDBb4tzq4ttrz2WnXWTkAHY8mfnG9RnvFlrDMLFu
 e2GD2w4s7gzHSJdJevi14HVC5oBZdJxFb3G4ukkrCF5Yu+7yIWZ1WUlV4cIu9/bgXAPmKToe3nA
 lkbAaao/MmJEk5PMjLMxRJr8hk=
X-Google-Smtp-Source: AGHT+IFihUKfrxkTbHoQkTPkk3X6ypKbTIwMnWtdeDw3PcOVgk5mjLZ9TyWXMWTYbM5GvWRcqkEfj+4dbGA2AS7VpOY=
X-Received: by 2002:a05:6402:348a:b0:639:f54d:9274 with SMTP id
 4fb4d7f45d1cf-639f54d9c20mr7534831a12.2.1760125150056; Fri, 10 Oct 2025
 12:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20251010053056.32495-1-mibodhi@gmail.com>
 <20251010142835.GY298503@bill-the-cat>
In-Reply-To: <20251010142835.GY298503@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 10 Oct 2025 12:38:58 -0700
X-Gm-Features: AS18NWAfCNP-FS5eB5KeDUdLC3Q6yajYBi9WSsKVP-1XPKn1fbENwUYXL-_z1Fk
Message-ID: <CAJaLiFyYGJjO=BjvL3HXAfbE1V2bwB_CSkcOTC6tQTJAR_DMVA@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Allow PXE boot to be disabled
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, 
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>, 
 Peter Robinson <pbrobinson@gmail.com>
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

Hi Tom & Simon,

On Fri, Oct 10, 2025 at 7:28=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Oct 09, 2025 at 10:29:17PM -0700, Tony Dinh wrote:
>
> > Make it possible to disable CMD_PXE.
> > Remove unnecessary PXE_UTILS selection in BOOTMETH_EXTLINUX config.
> > In extlinux_boot(), invoke pxe utils only when
> > CONFIG_BOOTMETH_EXTLINUX_PXE is enabled.
> >
> > This patch results in about 9K reduction in image size when
> > PXE boot is disabled.
> >
> > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > ---
> >
> >  boot/Kconfig             |  3 +--
> >  boot/bootmeth_extlinux.c | 18 ++++++++++--------
> >  2 files changed, 11 insertions(+), 10 deletions(-)
>
> Is some part of the symbol logic here wrong? A challenge is that "PXE"
> is also where the logic to parse extlinux.conf style files came from,
> and I thought we had split those two out. And then there's this:
>
> >
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index 2993cd7f9ba..403ce4c3d46 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -421,10 +421,10 @@ config BOOT_DEFAULTS_CMDS
> >       select CMD_PART if PARTITIONS
> >       select CMD_DHCP if CMD_NET
> >       select CMD_PING if CMD_NET
> > -     select CMD_PXE if CMD_NET
> >       select CMD_BOOTI if ARM64
> >       select CMD_BOOTZ if ARM && !ARM64
> >       imply CMD_MII if NET
> > +     imply CMD_PXE if CMD_NET
>
> This is one of the things where defaults isn't supposed to be so easy to
> get out of. How many platforms are you wanting to then disable CMD_PXE
> on to save space?

I'm simply trying to compile out PXE for a board that I'm working on!
The only thing I need is booting with scripts on a block device. And
it looks like we have to include everything in bootstd to use it. It
seems wrong to make the image a lot larger than needed for boards that
never use a specific feature.

I would agree about  "defaults isn't supposed to be so easy to get out
of". But in this case (and similarly in other CMD_x), CMD_PXE brings
in all dependencies for PXE including pxe_utils.

All the best,
Tony

>
> --
> Tom

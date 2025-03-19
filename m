Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BFDC36000
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 19:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DF1E810F2;
	Wed, 19 Mar 2025 20:14:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QYCAHlF8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4AAD810F4; Wed, 19 Mar 2025 20:14:07 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AB1580FF0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 20:14:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-224341bbc1dso142708605ad.3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 12:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742411644; x=1743016444; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Ukb+4udof4o1hqMNvjqcRySDSvwcXftfvXgpGNHjT8=;
 b=QYCAHlF8js2pnz8FiehMn8KhzLAMh6oLYibXHSsTQ5Dd9OHwh9rWBXHCW1kb1kN2Co
 Hz5u/0Cmlb5BN1uUp6n992QLR8+lZ2XpbFaBS7YrPZw0p5/Pe0Mo1JDZsOhve6KE66gY
 /FYPIFzD7dm9sMPDfBLvx0+3LHLqxMhIL2GINKHv/acqS6EMzTTWzTb7jst1KSJMZEva
 Is78xPHn5nPYdUZvSXEo3HYn3ihoAxizZ0dI1FiXe5fEe1zjWfRzrDZ8EnWQoxnrkom4
 9+MRXFSs/EPtr+m4b7NOrGXEpAlUzjabh/ZazXCImXLoIoD8i4uyNfTxCJ+h8uTAKvpv
 J5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742411644; x=1743016444;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Ukb+4udof4o1hqMNvjqcRySDSvwcXftfvXgpGNHjT8=;
 b=ry+yWIYCC6DbUwA5jbX0tygIc6Vq9uApCvs2ylyna/O6RUYPoU+3BSWYn4+E85cCTO
 ycyEg7MaU4dbk2LWHlKD6M8rd1tgeWgHYNnb/TYSQnIVFdVzGwDtGKR/MdIvtyXUk9IQ
 Zx+sXnW/ElMmyrJgz6QJMpIBWHoYQFUsdV9UuyCDPbsKcUtb2RqysECc0vShxqjq5Eny
 jpkJy8nthlHWuz1xSlgp01lzydN/gQxnJoEATRu9YqSkvbkbAee5Da2gG0orElOfNfsh
 FbHYGHEIoPGGdTlyQfraX8i4EoBsTAe8ajcjBm1xgqjeTRwsy/xKIF4sN6TfOxGePuod
 V3YQ==
X-Gm-Message-State: AOJu0YysVezhHdEfwONnWuxK59tgKMejXBCROfhBNxHzCFcyaViQ5awd
 M7I3K8bTpWvgrSZ8Zm5jAiiCLp6t9Akq7In/sd5lPYcZVW1kxyh8OY5T0E6oZNG0gCfiWch0eUw
 mvhvFpblGv28pe+muWenyqbqW5nU=
X-Gm-Gg: ASbGncvErmJHqPSNElL1p0FQ85e0HA78KJcAYNaeUT6wuRSTYSO2YynArHt1r4vSCUo
 dH8oDtCsTC3/b/1L22yfR6rin5/rfy7NecvlGkXL/ZmytUdIoLpEAZCATUKTbl4mUuwzZNFOHkJ
 0fM4sEU5ShEnsv0T0TIgTPhcVXbw==
X-Google-Smtp-Source: AGHT+IGVIGk+hAV9ONPHSVeaBDq25dus9V0b6OQ8MB6Gsmg8wEwzRMYCoF71E3Nt7+5lXXTEVP3WlUT5aQw76Yt0Zd4=
X-Received: by 2002:a17:90b:2e86:b0:2ee:edae:780 with SMTP id
 98e67ed59e1d1-301bdf941bcmr6000617a91.15.1742411644015; Wed, 19 Mar 2025
 12:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250319014240.592189-1-aford173@gmail.com>
 <b32475f3-d7a4-4eda-841e-1014201d61d3@mailbox.org>
In-Reply-To: <b32475f3-d7a4-4eda-841e-1014201d61d3@mailbox.org>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 19 Mar 2025 14:13:52 -0500
X-Gm-Features: AQ5f1JovRgULLBv1HRlXxfAiKhAtVym3FTZzXzoeZsKbZylpWjOVR4WFTyZRbr8
Message-ID: <CAHCN7xJUgRZJ6AzXYS1xdf0nVgK0s0t0Y7bRga5miUYxzCYmEg@mail.gmail.com>
Subject: Re: [PATCH 1/4] cpu: imx8_cpu: Print Speed grade if IMX_THERMAL or
 IMX_TMU
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, festevam@gmail.com, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>
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

On Tue, Mar 18, 2025 at 9:13=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.or=
g> wrote:
>
> On 3/19/25 2:42 AM, Adam Ford wrote:
> > Much of the data that is display by imx8_cpu.c is also
> > displayed from arch/arm/mach-imx/cpu.c, except the
> > speed grade and temperature unless the SoC is an i.MX9.
> > Expand this to include checks for IMX_THERMAL or IMX_TMU
> > in the same way it's done for mach-imx/cpu.c.
> >
> > Before:
> > CPU:   NXP i.MX8MP Rev1.1 A53 at 1200 MHz
> > Model: Beacon EmbeddedWorks i.MX8MPlus Development kit
> >
> > After:
> > CPU:   NXP i.MX8MP Rev1.1 A53 at 1200 MHz
> > CPU:   Industrial temperature grade  (-40C to 105C) at 28C
> > Model: Beacon EmbeddedWorks i.MX8MPlus Development kit
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
> > index 53d31b3c0bf..facd561022f 100644
> > --- a/drivers/cpu/imx8_cpu.c
> > +++ b/drivers/cpu/imx8_cpu.c
> > @@ -177,7 +177,9 @@ static int cpu_imx_get_desc(const struct udevice *d=
ev, char *buf, int size)
> >       ret =3D snprintf(buf, size, "NXP i.MX%s Rev%s %s at %u MHz",
> >                      plat->type, plat->rev, plat->name, plat->freq_mhz)=
;
> >
> > -     if (IS_ENABLED(CONFIG_IMX9)) {
> > +     if (IS_ENABLED(CONFIG_IMX9) ||
> > +         IS_ENABLED(CONFIG_IMX_THERMAL) ||
> > +         IS_ENABLED(CONFIG_IMX_TMU)) {
>
> Can CONFIG_IMX9 instead select CONFIG_IMX_THERMAL or CONFIG_IMX_TMU , so
> the SoC specific check could be removed from here ?

Any idea which of IMX_THERMAL or IMX_TMU should be selected or
implied?  I don't have an IMX9 to test.

adam

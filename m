Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F38C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 19:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1601E831A1;
	Mon, 17 Jun 2024 21:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="cejtXKNL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BB7880C58; Mon, 17 Jun 2024 21:32:37 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B341831A1
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 21:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52cc1528c83so567947e87.2
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 12:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1718652754; x=1719257554; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qSvkUE2KaeLk5py2393v4+hVr4Lu7ozb6q4lL7IOwuQ=;
 b=cejtXKNLLCe3uzHkZGTsCqnQlKQSBlP/7A8MjtEj736z2312nipjPTpqbaNior1gMf
 Yc7rVkcf1vJdMRctOiEUXzkeOlBjQbgCpnv7WEazm/dv19mj69xlX9XXzr5TSd9zoIPG
 JnheS61E0tfXUzSEz45KvXeWeCfdAAsfw8eiX6rfvW/6o+nZIMzDHAglg+8H7LXiFONg
 Gl3IzQTEgoBHTgK3Cya3rvxgXp8+YEMpwdDvqeT5zCEDSgrQMboRiYWkqp90wGAHhNYQ
 JQAG9g7FouGKnUtYVVhHNlg1IGfB5XCwxHdpelTvXQ/3NxeNlAgD5V1MxGzEpXxahgdv
 iL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718652754; x=1719257554;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qSvkUE2KaeLk5py2393v4+hVr4Lu7ozb6q4lL7IOwuQ=;
 b=I58fm5P5hjwn6XiGc/JdMaFM/0k5wCwILAl4FbWBYnZSHyToyv6oZHZ2Vz6Mr+9SDN
 ECEJ+v59M2A11PO2HVljI11DFXMeQUmAfXSqYAfBbfo0/V/DSnYkI3Egz2wHt2vLFv71
 kdaqHFDPMylUoqnuvK74AzL6BGWCCqVfuAk1JdKHdB5OTq64r3bULS8wZjUBWFJyM9XL
 V1bfQAnKcxGRhUnhfTTOk1PZ3E3di7t3gkjB98H58kj4Rar+f/yO+GsGnuRRi35MUlzR
 272IeANwS2167AqAR1MoFBj53L9UcDDw07HRU9MJHnMrFlIS6isEDt8++4iJwJn4upBV
 Rxfw==
X-Gm-Message-State: AOJu0YzMsMN0RAffvbRqJ80krWmtm2g3vrMWov9MsxXMM2IbxwbTDbrn
 UEp9HKq8DzcL5rRzYdIA/Qs1ZmwF5eQIw+cyKSTIQ3YYERlBTxm7mdiUcIw8gp3uyRF54cKAqYk
 EZQeBc5JvcTwUEL9JBUo241QceJEauudsCc9vqQ==
X-Google-Smtp-Source: AGHT+IGdSq9gRFLd52a6vWJVYyZmebQdzXr0ZkOdXXHSjrHWK+qQDQuJLWcae3YOZXUdv62A/cRxztMkTWzaTmkCpJ4=
X-Received: by 2002:a19:f706:0:b0:52c:98ad:2a99 with SMTP id
 2adb3069b0e04-52ca6e56033mr7003432e87.13.1718652754116; Mon, 17 Jun 2024
 12:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240530220634.155951-1-tharvey@gateworks.com>
 <20240613221807.GA2448330@bill-the-cat>
In-Reply-To: <20240613221807.GA2448330@bill-the-cat>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 17 Jun 2024 12:32:22 -0700
Message-ID: <CAJ+vNU1naf11vZyZCctCiELHLUV3g=kCxot5G0qx_t=5eWicdg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] automatically add /chosen/kaslr-seed and
 deduplicate code
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>
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

On Thu, Jun 13, 2024 at 3:18=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, May 30, 2024 at 03:06:31PM -0700, Tim Harvey wrote:
>
> > This series will automatically add /chosen/kaslr-seed to the dt if DM_R=
NG is enabled
> > during the boot process.
> >
> > If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> > randomize the virtual address at which the kernel image is loaded, it
> > expects entropy to be provided by the bootloader by populating
> > /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
> >
> > If we have DM_RNG enabled populate this value automatically when
> > fdt_chosen is called. We skip this if ARMV8_SEC_FIRMWARE_SUPPORT
> > is enabled as its implementation uses a different source of entropy
> > that is not yet implemented as DM_RNG. We also skip this if
> > MEASURED_BOOT is enabled as in that case any modifications to the
> > dt will cause measured boot to fail (although there are many other
> > places the dt is altered).
> >
> > As this fdt node is added elsewhere create a library function and
> > use it to deduplicate code. We will provide a parameter to overwrite
> > the node if present.
> >
> > For our automatic injection, we will use the first rng device and
> > not overwrite if already present with a non-zero value (which may
> > have been populated by an earlier boot stage). This way if a board
> > specific ft_board_setup() function wants to customize this behavior
> > it can call fdt_kaslrseed with a rng device index of its choosing and
> > set overwrite true.
> >
> > Note that the kalsrseed command (CMD_KASLRSEED) is likely pointless now
> > but left in place in case boot scripts exist that rely on this command
> > existing and returning success. An informational message is printed to
> > alert users of this command that it is likely no longer needed.
> >
> > Note that the Kernel's EFI STUB only relies on EFI_RNG_PROTOCOL for
> > randomization and completely ignores the kaslr-seed for its own
> > randomness needs (i.e the randomization of the physical placement of
> > the kernel). It gets weeded out from the DTB that gets handed over via
> > efi_install_fdt() as it would also mess up the measured boot DTB TPM
> > measurements as well.
>
> This needs to be reworked / update the test that now breaks:
> https://source.denx.de/u-boot/u-boot/-/jobs/849988#L264
>

Tom,

Sorry about that. I sent a v6 with a patch to take care of this.

I still haven't quite figured out how to use CI locally to catch
things like this. It looks like I need to use gitlab according to [1]
but I'm not familiar with Gitlab and creating a uboot project there
and pushing my branch failed with a 'pre-receive hook declined'. I'm
not sure if anyone has any documentation on how to get started with
U-Boot CI?

Best Regards,

Tim
[1] https://github.com/u-boot/u-boot/blob/master/doc/develop/ci_testing.rst

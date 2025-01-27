Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD702C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 17:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00F2681292;
	Mon, 27 Jan 2025 18:00:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="O6RsOb+W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06CDF812BB; Mon, 27 Jan 2025 18:00:37 +0100 (CET)
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch
 [79.135.106.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DE918128B
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 18:00:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1737997233; x=1738256433;
 bh=3HFGJ2boMcNJ5GdGaVxWTzXb0WE5c3QBKvWSnWyMSsk=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=O6RsOb+WVx88QvrbskdptuWYMg8xYIL0E3R9pE2mQAdL44NRm0t5OvO/UZdun9GnE
 21fsqxK+u0Jyz13r5CriE/I4lnEOrMLuVz35PlsEYe/cOPfTR3hb5ahlznuzQfByBh
 ip9iVDTplZ+wWzsMGsE7DW8ShFs9RVF7TlLfIz1raRIdk7Y5EeXKQJlxmBluUZtY4j
 2DhdCwL1gTkKBaq5+U0eYpFwtaNpnJFarJjaqAZS7MiJnIbttMTPgMGsdxZTYt+7QS
 PazMLH/cPolujPWniD/YRwtf/hdeHKJFaWO+kCOfiSQ5UaS/yWqvY7/G1E0icY4FwN
 iJbsSEiuiXrTg==
Date: Mon, 27 Jan 2025 17:00:26 +0000
To: Sam Day <me@samcday.com>
From: Sam Day <me@samcday.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, trini@konsulko.com,
 caleb.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH] mach-snapdragon: handle platforms without PSCI support
Message-ID: <i8bHrDGFWqgv7Se1W1-TcbDixixmVwJRGAEYWAn0liWIGZ8YdTkAjqIlFxbS1zKUhYbD7lgKdeGAR9dwmVoTL74cyO3W0vHkTeplyCQvdiU=@samcday.com>
In-Reply-To: <GSFboJvxfcEJj0TdjwY0sIuTkclILyTp9XRiI-uOgoAGSNDniyQUKZel7Dis7sw_ElD6SHRwsmFovnH7UiTWX8fey2KjItW-r6yBfVIabss=@samcday.com>
References: <20250127-qcom-handle-absent-psci-v1-1-e762f2db938c@samcday.com>
 <87sep4i57r.fsf@bloch.sibelius.xs4all.nl>
 <GSFboJvxfcEJj0TdjwY0sIuTkclILyTp9XRiI-uOgoAGSNDniyQUKZel7Dis7sw_ElD6SHRwsmFovnH7UiTWX8fey2KjItW-r6yBfVIabss=@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 544c05ed323f4676d8851432efff9a583632735d
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Mark,

On Monday, 27 January 2025 at 17:51, Sam Day <me@samcday.com> wrote:

>=20
>=20
> Hello Mark,
>=20
> On Monday, 27 January 2025 at 17:36, Mark Kettenis mark.kettenis@xs4all.n=
l wrote:
>=20
> > > Date: Mon, 27 Jan 2025 14:48:55 +0000
> >=20
> > > From: Sam Day me@samcday.com
> >=20
> > Hi Sam,
> >=20
> > > Most MSM8916 devices shipped without PSCI support. The history is qui=
te
> > > nuanced (a good overview can be found in 1), but the end result is
> > > that the upstream DTs for this SoC pretend that PSCI exists, and it's
> > > expected that the bootloader handles the case where it doesn't. This =
is
> > > codified by the de-facto bootloader for MSM8916 devices, lk2nd 2.
> > >=20
> > > So we handle it here by deleting the /psci node if we detect the abse=
nce
> > > of PSCI. We need to do this early to ensure sysreset works correctly,
> > > since the PSCI firmware driver is PRE_RELOC and binds the PSCI sysres=
et
> > > driver.
> >=20
> > But deleting the /psci node isn't enough is it? At least on systems
> > with more than a single core the OS will need a way to spin up the
> > additonal cores. So you'll need to modify the CPU nodes as well and
> > change the "enable-method" property to "spin-table" and add the
> > necessary infrastructure for that.
>=20
>=20
> Yes, you're absolutely right. I'm preparing to submit a patch series that
> does exactly that. The spin-table setup bits already exists in U-Boot, th=
e
> MSM8916 specific bits (qcom-scm SMC call + poking APCS registers) will be
> the bulk of the work I submit later tonight.
>=20
> I opted to submit this patch alone without that work for a few reasons:
>=20
> * I've already submitted some patches to enable sysreset support for
> MSM8916 [1] and with this patch, sysreset will then work properly on
> this platform.
> * As it currently stands, the secondary cores can't be booted on this
> platform, regardless of whether the /psci node exists or not. Deleting
> the psci node doesn't make matters any worse when booting on devices
> that have no PSCI implementation.
> * The SMP bring-up code is a lot meatier (I had to pull in a bunch of qco=
m
> SCM calling code from the kernel) and might need a few rounds before it
> can land.
> * U-Boot can be experimentally chained from lk2nd (which itself is chaine=
d
> from aboot, which itself is chained from ... well, you get the idea!),
> and so in that case the SMP spin-table setup + DT patching has already
> happened in that previous bootloader. But that BL only disables the
> /psci node, which doesn't prevent the U-Boot PSCI firmware driver from
> binding and causing the (non-functional) PSCI sysreset driver to also be
> bound.
> * And so considering the previous points, my hope is that this modest
> patch will land in time for v2025.04 release and make U-Boot a bit more
> functional on (non-PSCI) MSM8916 devices.
>=20
> [1]: https://patchwork.ozlabs.org/project/uboot/list/?series=3D441769

Uh, disregard bullet point 4, I don't know why I thought that a disabled
DT node would still be bound. The rest of the points still hopefully make
sense, though :)

Cheers,
-Sam

>=20
> Warm Regards,
> -Sam
>=20
> > > Additionally, show_psci_version is updated to check that PSCI exists.
> > > Currently this banner outputs "PSCI: 65535.65535" on devices without
> > > PSCI support, which isn't very useful :)
> > >=20
> > > Signed-off-by: Sam Day me@samcday.com
> > > ---
> > > arch/arm/mach-snapdragon/board.c | 43 +++++++++++++++++++++++++++++++=
+++++----
> > > 1 file changed, 39 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdra=
gon/board.c
> > > index e87551784b8d7afb4186533d43b8bddacba9faec..75b9cf1a8a1b3383665eb=
2d4e6725efe59718de0 100644
> > > --- a/arch/arm/mach-snapdragon/board.c
> > > +++ b/arch/arm/mach-snapdragon/board.c
> > > @@ -162,11 +162,42 @@ static void show_psci_version(void)
> > >=20
> > > arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res=
);
> > >=20
> > > + /* Some older SoCs like MSM8916 don't always support PSCI */
> > > + if ((int)res.a0 =3D=3D PSCI_RET_NOT_SUPPORTED)
> > > + return;
> > > +
> > > debug("PSCI: v%ld.%ld\n",
> > > PSCI_VERSION_MAJOR(res.a0),
> > > PSCI_VERSION_MINOR(res.a0));
> > > }
> > >=20
> > > +/**
> > > + * Most MSM8916 devices in the wild shipped without PSCI support, bu=
t the
> > > + * upstream DTs pretend that PSCI exists. If that situation is detec=
ted here,
> > > + * the /psci node is deleted. This is done very early to ensure the =
PSCI
> > > + * firmware driver doesn't bind (which then binds a sysreset driver =
that won't
> > > + * work).
> > > + */
> > > +static void qcom_psci_fixup(void fdt)
> > > +{
> > > + int offset, ret;
> > > + struct arm_smccc_res res;
> > > +
> > > + arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &r=
es);
> > > +
> > > + if ((int)res.a0 !=3D PSCI_RET_NOT_SUPPORTED)
> > > + return;
> > > +
> > > + offset =3D fdt_path_offset(fdt, "/psci");
> > > + if (offset < 0)
> > > + return;
> > > +
> > > + debug("Found /psci DT node on device with no PSCI. Deleting.\n");
> > > + ret =3D fdt_del_node(fdt, offset);
> > > + if (ret)
> > > + log_err("Failed to delete /psci node: %d\n", ret);
> > > +}
> > > +
> > > / We support booting U-Boot with an internal DT when running as a fir=
st-stage bootloader
> > > * or for supporting quirky devices where it's easier to leave the dow=
nstream DT in place
> > > * to improve ABL compatibility. Otherwise, we use the DT provided by =
ABL.
> > > @@ -212,12 +243,16 @@ int board_fdt_blob_setup(void **fdtp)
> > >=20
> > > if (internal_valid) {
> > > debug("Using built in FDT\n");
> > > - return -EEXIST;
> > > + ret =3D -EEXIST;
> > > + } else {
> > > + debug("Using external FDT\n");
> > > + *fdtp =3D external_fdt;
> > > + ret =3D 0;
> > > }
> > >=20
> > > - debug("Using external FDT\n");
> > > - *fdtp =3D external_fdt;
> > > - return 0;
> > > + qcom_psci_fixup(*fdtp);
> > > +
> > > + return ret;
> > > }
> > >=20
> > > void reset_cpu(void)
> > >=20
> > > ---
> > > base-commit: 2eed5a1ff36217372e19f7513bd07077fc76718a
> > > change-id: 20250127-qcom-handle-absent-psci-6e8e8af7bcd7
> > > prerequisite-change-id: 20250120-qcom-parse-memory-updates-96ffe248cd=
f1:v3
> > > prerequisite-patch-id: 65448b5a93120d2117c1361035afc9bd911d005f
> > >=20
> > > Best regards,
> > > --
> > > Sam Day me@samcday.com

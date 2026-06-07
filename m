Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD875CD8C89
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 03:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B3EB8063E;
	Sun,  7 Jun 2026 05:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="egD9cdx0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AF0083314; Sun,  7 Jun 2026 05:49:31 +0200 (CEST)
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F2C580433
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 05:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780804167; x=1781063367;
 bh=8p8pTJspPKCuwHmI7JTWNW9ED26OigeCP64RSPNV5pY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=egD9cdx0hRpcmuFT5ijzTYcS+Pkg8o1h/zcNOMEz80fOLwPpDbOciAKDKEdNE/PbG
 JLZD9iKajaAaHvaLEFAvKiBRjhoLEwPVF9pYMpg9zytP4QkzmvwKYBdxfbU+ptR4IV
 NVCsDpD6N13FrklNS8hXzEsYHZNJ5Ogl56ibreGuLzcO11FQa+XwTwFoRNRa8wtD5z
 0ba0mbAlMPhwr1Xxg4BxJmjvi/0Xl/89OurfWA/wDjkLbKs23lEdUedTOBJhdEJ8f7
 uBSBovpATpAgN0zmizLvMKMWeELOygUYfPbLk1pD1GRIo7cP1UZZNf056mc2qEkjWA
 RDtoM2edfCErg==
Date: Sun, 07 Jun 2026 03:49:22 +0000
To: Neil Armstrong <neil.armstrong@linaro.org>
From: Sam Day <me@samcday.com>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Sumit Garg <sumit.garg@kernel.org>, Casey Connolly <casey.connolly@linaro.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io, Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 4/6] mach-snapdragon: fixup CPUs with PSCI enable-method
Message-ID: <WG9m5PO_iaZNTn_J_JqQpbGkBoM4NMFlWZGlaNOlBjJ-m2gIsO4xV-DQmk_looBs3eG-okawx1hz8-msVI5BnUFjDaYBnxP0nKVwRH4nx0w=@samcday.com>
In-Reply-To: <a98fe06c-be89-4f0a-a547-15ce783c55cf@linaro.org>
References: <20260602-msm8916-smp-support-v2-0-792e53dac374@samcday.com>
 <20260602-msm8916-smp-support-v2-4-792e53dac374@samcday.com>
 <0291ada3-0426-4893-93ae-f49cd7c1eb91@linaro.org>
 <NSO1C4Gn8wtOi9FvzD06-Mqkv1rpQAJuKgQ6BFNMPeNiJ_bJugEd-VzU-zwzn4U1dcBY6-U8jV46v1gE-80q7pbeI_rM2bDSa6FmDpNzs-Y=@samcday.com>
 <a98fe06c-be89-4f0a-a547-15ce783c55cf@linaro.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 0305d21566fdb5e7882ea74911f8d08fc9c93a72
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

Hello Neil,

On Thursday, 4 June 2026 at 4:59 PM, Neil Armstrong <neil.armstrong@linaro.=
org> wrote:

> Hi,
>=20
> On 6/4/26 08:53, Sam Day wrote:
> > Hey Neil,
> >
> > On Thursday, 4 June 2026 at 4:33 PM, Neil Armstrong <neil.armstrong@lin=
aro.org> wrote:
> >
> >> On 6/2/26 09:19, Sam Day via B4 Relay wrote:
> >>> From: Sam Day <me@samcday.com>
> >>>
> >>> If there's no PSCI implementation, then change the enable-method of a=
ll
> >>> CPUs from "psci" to "spin-table". Later, when spin_table_update_dt ru=
ns,
> >>> it will further patch the CPU nodes with the necessary cpu-release-ad=
dr.
> >>>
> >>> This new fixup is only applied when CONFIG_ARMV8_SPIN_TABLE is enable=
d,
> >>> since that also determines whether spin_table_update_dt runs.
> >>>
> >>> Signed-off-by: Sam Day <me@samcday.com>
> >>> ---
> >>>    arch/arm/mach-snapdragon/board.c | 41 ++++++++++++++++++++++++++++=
++++++++++++
> >>>    1 file changed, 41 insertions(+)
> >>>
> >>> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdra=
gon/board.c
> >>> index 829a0109ac7..3b08069af98 100644
> >>> --- a/arch/arm/mach-snapdragon/board.c
> >>> +++ b/arch/arm/mach-snapdragon/board.c
> >>> @@ -183,7 +183,9 @@ static void show_psci_version(void)
> >>>    static void qcom_psci_fixup(void *fdt)
> >>>    {
> >>>    =09int offset, ret;
> >>> +=09uint reg;
> >>>    =09struct arm_smccc_res res;
> >>> +=09const char *prop;
> >>>
> >>>    =09arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0=
, &res);
> >>>
> >>> @@ -198,6 +200,45 @@ static void qcom_psci_fixup(void *fdt)
> >>>    =09ret =3D fdt_del_node(fdt, offset);
> >>>    =09if (ret)
> >>>    =09=09log_err("Failed to delete /psci node: %d\n", ret);
> >>> +
> >>> +=09if (!CONFIG_IS_ENABLED(ARMV8_SPIN_TABLE))
> >>> +=09=09return;
> >>
> >> Can this be dynamic ?
> >
> > Sure can! ... Just as soon as I pin down exactly what you mean by that =
:D
> >
> > Are you asking that this be guarded not just by ARMV8_SPIN_TABLE
> > enablement, but also by root device compatible?
> >
> > e.g:
> >
> > =09if (!CONFIG_IS_ENABLED(ARMV8_SPIN_TABLE))
> > =09=09return;
> >
> > =09if (fdt_node_check_compatible(fdt, 0, "qcom,msm8916") &&
> >          fdt_node_check_compatible(fdt, 0, "qcom,apq8016"))
> > =09=09return;
>=20
> Yes perhaps move this in a helper function to guard all the spin table fu=
nctionality ?

Ack, I've queued that up for v3. This series already introduces msm8916-smp=
.c, so
it was easy enough to move it over there.

Best,
-Sam

>=20
> Thanks,
> Neil
>=20
> >
> > Kind regards,
> > Sam
> >
> >>
> >> Neil
> >>
> >>> +
> >>> +=09/* If spin-table support is enabled, make sure any CPU nodes with=
 a
> >>> +=09 * PSCI enable-method are updated to spin-table. Further, any PSC=
I
> >>> +=09 * power-domains properties are removed.
> >>> +=09 */
> >>> +
> >>> +=09offset =3D fdt_path_offset(fdt, "/cpus");
> >>> +=09if (offset < 0)
> >>> +=09=09return;
> >>> +
> >>> +=09for (offset =3D fdt_first_subnode(fdt, offset);
> >>> +=09     offset >=3D 0;
> >>> +=09     offset =3D fdt_next_subnode(fdt, offset)) {
> >>> +=09=09prop =3D fdt_getprop(fdt, offset, "device_type", NULL);
> >>> +=09=09if (!prop || strcmp(prop, "cpu"))
> >>> +=09=09=09continue;
> >>> +
> >>> +=09=09prop =3D fdt_getprop(fdt, offset, "enable-method", NULL);
> >>> +=09=09if (!prop || strcmp(prop, "psci"))
> >>> +=09=09=09continue;
> >>> +
> >>> +=09=09reg =3D fdtdec_get_uint(fdt, offset, "reg", 0);
> >>> +=09=09ret =3D fdt_setprop_string(fdt, offset,
> >>> +=09=09=09=09=09 "enable-method", "spin-table");
> >>> +=09=09if (ret)
> >>> +=09=09=09log_err("Failed to set CPU%d enable-method to 'spin-table',=
 this CPU will not be available to booted OS! %d\n",
> >>> +=09=09=09=09reg, ret);
> >>> +
> >>> +=09=09log_info("Patched CPU%d enable-method to 'spin-table'\n", reg)=
;
> >>> +
> >>> +=09=09prop =3D fdt_getprop(fdt, offset, "power-domain-names", NULL);
> >>> +=09=09if (prop && !strcmp(prop, "psci")) {
> >>> +=09=09=09fdt_delprop(fdt, offset, "power-domains");
> >>> +=09=09=09fdt_delprop(fdt, offset, "power-domain-names");
> >>> +=09=09}
> >>> +=09}
> >>>    }
> >>>
> >>>    /* We support booting U-Boot with an internal DT when running as a=
 first-stage bootloader
> >>>
> >>
> >>
>=20
> 

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB578CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 06:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48ACB83FF5;
	Thu,  4 Jun 2026 08:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="ecFdU6sM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39648840ED; Thu,  4 Jun 2026 08:53:57 +0200 (CEST)
Received: from mail-244120.protonmail.ch (mail-244120.protonmail.ch
 [109.224.244.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD3BC83314
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 08:53:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780556033; x=1780815233;
 bh=E0z/YHrius5OYrXEcnr1cwpt+jnL01JTJiFp8j7ZkCI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=ecFdU6sMkncda9eslK5GXst7pMX3rcwflH83VQAOj6mZ2J3wffeU258ru+vmAkIot
 SdgRcFg7xhjYaxlgpgbg7DPkVcOdNos6bOz2UubtxDj/cs/d4YlMQoTxGhM/Tn6NUw
 HP5DmYzVBi46Cw3rflpKhjJzYlfR7hoTxnFPPOpfwkYvLnOt00EYYReRfLBt6Kr0J1
 kU/BqYtDSMFFNO5IHgvMCCQbHfqiIcCBQGFPo884Ku9FiiEkkqmYznyY6DVNJd7SOr
 H2HH53df0tRrlaq02/tInVWphTg1PYiECFMAcZWnYRncq5LtUYO+7Cs5fMhlST56gX
 Ej4WWg6TfhETw==
Date: Thu, 04 Jun 2026 06:53:47 +0000
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
Message-ID: <NSO1C4Gn8wtOi9FvzD06-Mqkv1rpQAJuKgQ6BFNMPeNiJ_bJugEd-VzU-zwzn4U1dcBY6-U8jV46v1gE-80q7pbeI_rM2bDSa6FmDpNzs-Y=@samcday.com>
In-Reply-To: <0291ada3-0426-4893-93ae-f49cd7c1eb91@linaro.org>
References: <20260602-msm8916-smp-support-v2-0-792e53dac374@samcday.com>
 <20260602-msm8916-smp-support-v2-4-792e53dac374@samcday.com>
 <0291ada3-0426-4893-93ae-f49cd7c1eb91@linaro.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 68fdf219ef44846abd9a570875a260b1bd45284d
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

Hey Neil,

On Thursday, 4 June 2026 at 4:33 PM, Neil Armstrong <neil.armstrong@linaro.=
org> wrote:

> On 6/2/26 09:19, Sam Day via B4 Relay wrote:
> > From: Sam Day <me@samcday.com>
> >
> > If there's no PSCI implementation, then change the enable-method of all
> > CPUs from "psci" to "spin-table". Later, when spin_table_update_dt runs=
,
> > it will further patch the CPU nodes with the necessary cpu-release-addr=
.
> >
> > This new fixup is only applied when CONFIG_ARMV8_SPIN_TABLE is enabled,
> > since that also determines whether spin_table_update_dt runs.
> >
> > Signed-off-by: Sam Day <me@samcday.com>
> > ---
> >   arch/arm/mach-snapdragon/board.c | 41 +++++++++++++++++++++++++++++++=
+++++++++
> >   1 file changed, 41 insertions(+)
> >
> > diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdrago=
n/board.c
> > index 829a0109ac7..3b08069af98 100644
> > --- a/arch/arm/mach-snapdragon/board.c
> > +++ b/arch/arm/mach-snapdragon/board.c
> > @@ -183,7 +183,9 @@ static void show_psci_version(void)
> >   static void qcom_psci_fixup(void *fdt)
> >   {
> >   =09int offset, ret;
> > +=09uint reg;
> >   =09struct arm_smccc_res res;
> > +=09const char *prop;
> >
> >   =09arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &=
res);
> >
> > @@ -198,6 +200,45 @@ static void qcom_psci_fixup(void *fdt)
> >   =09ret =3D fdt_del_node(fdt, offset);
> >   =09if (ret)
> >   =09=09log_err("Failed to delete /psci node: %d\n", ret);
> > +
> > +=09if (!CONFIG_IS_ENABLED(ARMV8_SPIN_TABLE))
> > +=09=09return;
>=20
> Can this be dynamic ?

Sure can! ... Just as soon as I pin down exactly what you mean by that :D

Are you asking that this be guarded not just by ARMV8_SPIN_TABLE
enablement, but also by root device compatible?

e.g:

=09if (!CONFIG_IS_ENABLED(ARMV8_SPIN_TABLE))
=09=09return;

=09if (fdt_node_check_compatible(fdt, 0, "qcom,msm8916") &&
        fdt_node_check_compatible(fdt, 0, "qcom,apq8016"))
=09=09return;

Kind regards,
Sam

>=20
> Neil
>=20
> > +
> > +=09/* If spin-table support is enabled, make sure any CPU nodes with a
> > +=09 * PSCI enable-method are updated to spin-table. Further, any PSCI
> > +=09 * power-domains properties are removed.
> > +=09 */
> > +
> > +=09offset =3D fdt_path_offset(fdt, "/cpus");
> > +=09if (offset < 0)
> > +=09=09return;
> > +
> > +=09for (offset =3D fdt_first_subnode(fdt, offset);
> > +=09     offset >=3D 0;
> > +=09     offset =3D fdt_next_subnode(fdt, offset)) {
> > +=09=09prop =3D fdt_getprop(fdt, offset, "device_type", NULL);
> > +=09=09if (!prop || strcmp(prop, "cpu"))
> > +=09=09=09continue;
> > +
> > +=09=09prop =3D fdt_getprop(fdt, offset, "enable-method", NULL);
> > +=09=09if (!prop || strcmp(prop, "psci"))
> > +=09=09=09continue;
> > +
> > +=09=09reg =3D fdtdec_get_uint(fdt, offset, "reg", 0);
> > +=09=09ret =3D fdt_setprop_string(fdt, offset,
> > +=09=09=09=09=09 "enable-method", "spin-table");
> > +=09=09if (ret)
> > +=09=09=09log_err("Failed to set CPU%d enable-method to 'spin-table', t=
his CPU will not be available to booted OS! %d\n",
> > +=09=09=09=09reg, ret);
> > +
> > +=09=09log_info("Patched CPU%d enable-method to 'spin-table'\n", reg);
> > +
> > +=09=09prop =3D fdt_getprop(fdt, offset, "power-domain-names", NULL);
> > +=09=09if (prop && !strcmp(prop, "psci")) {
> > +=09=09=09fdt_delprop(fdt, offset, "power-domains");
> > +=09=09=09fdt_delprop(fdt, offset, "power-domain-names");
> > +=09=09}
> > +=09}
> >   }
> >
> >   /* We support booting U-Boot with an internal DT when running as a fi=
rst-stage bootloader
> >
>=20
> 

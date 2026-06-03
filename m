Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8F6CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 23:25:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB21583FF5;
	Thu,  4 Jun 2026 01:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="Wu20+Nge";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA99B840ED; Thu,  4 Jun 2026 01:25:40 +0200 (CEST)
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch
 [109.224.244.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C726980433
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 01:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780529136; x=1780788336;
 bh=XrOlMHLPLWGQV44cgdojidkZv1Itfg11KbIgT216Fgw=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Wu20+NgeUds2oKvO3INppQuLZlwpDLtTTTPUd3BaCK2UqTFy+lyWzjl/YdVXbkM8N
 IIGKfSlED3UWC+noYIfOgRpHeLO7iJrsWIiyQ7bx2B+8UtHWHg2KCqLtOxDlPEKLFN
 +KGuUCUoxiTtDaeJWsPV1FfAsm/+1aocHyAMZXNmr7eSZXAURtDP+cbkpB1/qbXFMY
 kjhhU+abrmokpPgK1cN2VALdaBuzZ5TXB5wPMrS9DxnHdrKymLG/TgnKF/wClZTXIB
 NbziTu+NTkySSzWGYqVuKgRjArg+5lZ/X9xxrq/PrLZFuMDpvx1T5oWtW4ctTgADZ+
 LRX5tsfBWGU7A==
Date: Wed, 03 Jun 2026 23:25:31 +0000
To: Stephan Gerhold <stephan.gerhold@linaro.org>
From: Sam Day <me@samcday.com>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Sumit Garg <sumit.garg@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Simon Glass <sjg@chromium.org>,
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
 Luca Weiss <luca.weiss@fairphone.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 5/6] mach-snapdragon: MSM8916 spin-table CPU boot
 support
Message-ID: <5x0vgyet4y7JLsj-Uu23U47TjeKoXWgyGUEUKSZ0HGDMOrG2C5HSAUzww5vVT3Cik7CRq96oBYBqBUl_DfDwi4twyfkRmzo2r1_prZ1L_xI=@samcday.com>
In-Reply-To: <aiA2YFnFBLJKahGU@linaro.org>
References: <20260602-msm8916-smp-support-v2-0-792e53dac374@samcday.com>
 <20260602-msm8916-smp-support-v2-5-792e53dac374@samcday.com>
 <aiA2YFnFBLJKahGU@linaro.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: cb37d6b462ccbf5281fe8d19cd2076c940266fa1
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

Hey Stephan,

On Thursday, 4 June 2026 at 12:12 AM, Stephan Gerhold <stephan.gerhold@lina=
ro.org> wrote:

> On Tue, Jun 02, 2026 at 05:19:01PM +1000, Sam Day via B4 Relay wrote:
> > From: Sam Day <me@samcday.com>
> >
> > Most MSM8916 devices lack PSCI support, instead they're brought online
> > with a qcom SCM call to set the boot address, and some register poking
> > of the APCS register block.
> >
> > Signed-off-by: Sam Day <me@samcday.com>
> > ---
> >  arch/arm/mach-snapdragon/Makefile      |   1 +
> >  arch/arm/mach-snapdragon/msm8916-smp.c | 138 +++++++++++++++++++++++++=
++++++++
> >  2 files changed, 139 insertions(+)
> >
> > diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdrag=
on/Makefile
> > index 343e825c6fd..584b8af055a 100644
> > --- a/arch/arm/mach-snapdragon/Makefile
> > +++ b/arch/arm/mach-snapdragon/Makefile
> > @@ -5,3 +5,4 @@
> >  obj-y +=3D board.o
> >  obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) +=3D capsule_update.o
> >  obj-$(CONFIG_OF_LIVE) +=3D of_fixup.o
> > +obj-$(CONFIG_ARMV8_SPIN_TABLE) +=3D msm8916-smp.o
> > diff --git a/arch/arm/mach-snapdragon/msm8916-smp.c b/arch/arm/mach-sna=
pdragon/msm8916-smp.c
> > new file mode 100644
> > index 00000000000..24f5590ccc3
> > --- /dev/null
> > +++ b/arch/arm/mach-snapdragon/msm8916-smp.c
> > @@ -0,0 +1,138 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * On MSM8916 devices that lack a PSCI implementation, firing up the s=
econdary
> > + * cores requires a call to TZ to set the boot address, and some pokin=
g of ACPS
> > + * register block.
> > + *
> > + * Copyright (c) 2025 Linaro Ltd.
> > + */
>=20
> Was Linaro involved in this in 2025? Did you write the code yourself
> (the init sequence, especially) or take it over from somewhere else?
> Would be good to be precise here.

Uh - I don't remember why Jan-2025 Sam thought to place Linaro copyrights h=
ere.
I think the logic was that, since I don't care about owning the copyright, =
I
figured I'd just assign it to the entity that owns a lot of the code in
mach-snapdragon already.

Anyway, since most of the code here came from the kernel, and I used lk2nd =
as
a reference, I'll just preserve those copyrights in v3 instead.

>=20
> > +
> > +#include <asm/io.h>
> > +#include <asm/spin_table.h>
> > +#include <asm/system.h>
> > +#include <cpu_func.h>
> > +#include <dm/ofnode.h>
> > +#include <firmware/qcom/scm.h>
> > +#include <linux/arm-smccc.h>
> > +#include <linux/delay.h>
> > +
> > +#define APCS_CPU_PWR_CTL=090x04
> > +#define CORE_PWRD_UP=09=09BIT(7)
> > +#define COREPOR_RST=09=09BIT(5)
> > +#define CORE_RST=09=09BIT(4)
> > +#define CORE_MEM_HS=09=09BIT(3)
> > +#define CORE_MEM_CLAMP=09=09BIT(1)
> > +#define CLAMP=09=09=09BIT(0)
> > +
> > +#define APC_PWR_GATE_CTL=090x14
> > +#define GDHS_CNT_SHIFT=09=0924
> > +#define GDHS_EN=09=09=09BIT(0)
> > +
> > +static void qcom_boot_cortex_a53(phys_addr_t acc_base)
> > +{
> > +=09u32 reg_val;
> > +
> > +=09/* Put the CPU into reset. */
> > +=09reg_val =3D CORE_RST | COREPOR_RST | CLAMP | CORE_MEM_CLAMP;
> > +=09writel(reg_val, acc_base + APCS_CPU_PWR_CTL);
> > +
> > +=09/* Turn on the GDHS and set the GDHS_CNT to 16 XO clock cycles */
> > +=09writel(GDHS_EN | (0x10 << GDHS_CNT_SHIFT), acc_base + APC_PWR_GATE_=
CTL);
> > +=09/* Wait for the GDHS to settle */
> > +=09udelay(2);
> > +
> > +=09reg_val &=3D ~CORE_MEM_CLAMP;
> > +=09writel(reg_val, acc_base + APCS_CPU_PWR_CTL);
> > +=09reg_val |=3D CORE_MEM_HS;
> > +=09writel(reg_val, acc_base + APCS_CPU_PWR_CTL);
> > +=09udelay(2);
> > +
> > +=09reg_val &=3D ~CLAMP;
> > +=09writel(reg_val, acc_base + APCS_CPU_PWR_CTL);
> > +=09udelay(2);
> > +
> > +=09/* Release CPU out of reset and bring it to life. */
> > +=09reg_val &=3D ~(CORE_RST | COREPOR_RST);
> > +=09writel(reg_val, acc_base + APCS_CPU_PWR_CTL);
> > +=09reg_val |=3D CORE_PWRD_UP;
> > +=09writel(reg_val, acc_base + APCS_CPU_PWR_CTL);
>=20
> Nitpick (might be fine as-is, since Linux seems to have the same):
> Strictly speaking, I think we need some memory barriers / DSBs in here
> to make sure the write is complete before the udelay() starts (although
> this is notoriously hard. If you're interested in this, take a look at
> https://youtu.be/i6DayghhA8Q?t=3D1677, although I think it doesn't
> translate exactly to U-Boot).

Hmm yeah, it's odd because kernel is *not* issuing barriers in the
cortex_a7 startup sequence, but *is* for kpss v1/v2. Since lk2nd
already has prior art for this I'll just follow that lead in v3.

>=20
> > +}
> > +
> > +static int qcom_scm_set_boot_addr_mc(void *entry, unsigned int flags)
> > +{
> > +=09struct qcom_scm_desc desc =3D {
> > +=09=09.svc =3D QCOM_SCM_SVC_BOOT,
> > +=09=09.cmd =3D QCOM_SCM_BOOT_SET_ADDR_MC,
> > +=09=09.owner =3D ARM_SMCCC_OWNER_SIP,
> > +=09=09.arginfo =3D QCOM_SCM_ARGS(6),
> > +=09=09.args =3D {
> > +=09=09=09(u64)entry,
> > +=09=09=09/* Apply to all CPUs in all affinity levels */
> > +=09=09=09~0ULL, ~0ULL, ~0ULL, ~0ULL,
> > +=09=09=09flags,
> > +=09=09},
> > +=09};
> > +
> > +=09if (!qcom_scm_is_call_available(desc.svc, desc.cmd))
> > +=09=09return -EOPNOTSUPP;
> > +
> > +=09return qcom_scm_call(&desc, NULL);
> > +}
> > +
> > +static bool boot_addr_set;
> > +
> > +int spin_table_boot_cpu(void *fdt, int cpu_offset)
> > +{
> > +=09struct fdtdec_phandle_args acc;
> > +=09u32 mpidr_aff, acc_base, reg;
> > +=09int ret;
> > +
> > +=09if (fdt_node_check_compatible(fdt, 0, "qcom,msm8916"))
> > +=09=09return 0;
>=20
> What if we have a qcom,apq8016? :)

Wellll, in that case there's a functional TZ that can handle the PSCI call,
right? ;) I suppose there's probably situations where that's not the case.
Rabble rabble rabble.

Anyway, I added this check in the eleventh hour right before submitting,
because I was paranoid that it might impact some other platform (big-tent b=
oard
code is great but also hellish). In retrospect this is unnecessary:
spin_table_boot_cpu() is kicked by the generic code for each spin-table CPU
it finds in the DT. We only force cores to spin-table enablement when we de=
tect
the busted-PSCI situation.

I've removed this check entirely in v3.

>=20
> > +
> > +=09reg =3D fdtdec_get_uint(fdt, cpu_offset, "reg", 0);
> > +
> > +=09if (fdt_node_check_compatible(fdt, cpu_offset, "arm,cortex-a53")) {
> > +=09=09log_warning("CPU%d is not arm,cortex-a53 compatible\n", reg);
> > +=09=09return -EINVAL;
> > +=09}
> > +
> > +=09if (!boot_addr_set) {
> > +=09=09debug("Setting CPU boot address to 0x%llx\n",
> > +=09=09      (phys_addr_t)&spin_table_reserve_begin);
> > +=09=09ret =3D qcom_scm_set_boot_addr_mc(&spin_table_reserve_begin,
> > +=09=09=09=09=09=09QCOM_SCM_BOOT_MC_FLAG_AARCH64 |
> > +=09=09=09=09=09=09QCOM_SCM_BOOT_MC_FLAG_COLDBOOT);
> > +=09=09if (ret) {
> > +=09=09=09log_err("Failed to set CPU boot addr: %d\n", ret);
> > +=09=09=09return ret;
> > +=09=09}
> > +
> > +=09=09boot_addr_set =3D true;
> > +=09}
>=20
> I would move this below log_info("Booting CPU"), so you don't waste
> doing this for nothing if one of the other check fails.

Good catch, fixed in v3.

Thanks for the thorough review Stephan!
-Sam

>=20
> > +
> > +=09mpidr_aff =3D read_mpidr() & 0xffffff;
> > +
> > +=09if (reg =3D=3D mpidr_aff) {
> > +=09=09debug("Skipping boot of current CPU%d\n", reg);
> > +=09=09return 0;
> > +=09}
> > +
> > +=09ret =3D fdtdec_parse_phandle_with_args(fdt, cpu_offset, "qcom,acc",
> > +=09=09=09=09=09     NULL, 0, 0, &acc);
> > +=09if (ret) {
> > +=09=09log_err("Failed to parse qcom,acc phandle: %d\n", reg);
> > +=09=09return ret;
> > +=09}
> > +
> > +=09acc_base =3D fdtdec_get_addr_size_auto_noparent(fdt, acc.node, "reg=
", 0,
> > +=09=09=09=09=09=09      NULL, true);
> > +=09if (!acc_base) {
> > +=09=09log_err("Failed to parse qcom,acc regbase\n");
> > +=09=09return -EINVAL;
> > +=09}
> > +
> > +=09log_info("Booting CPU%d @ 0x%x\n", reg, acc_base);
> > +=09qcom_boot_cortex_a53(acc_base);
> > +=09return 0;
> > +}
>=20
> Thanks,
> Stephan
> 

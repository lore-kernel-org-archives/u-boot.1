Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F48CC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 21:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E1FD8283E;
	Tue, 29 Apr 2025 23:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="NA3ZB7RX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF8B0829A1; Tue, 29 Apr 2025 23:02:29 +0200 (CEST)
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch
 [109.224.244.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 631DE8272A
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 23:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail; t=1745960545; x=1746219745;
 bh=yjXBP/mP+QyNeKeYenDhHza38WYDqlDm+GygOI+oVME=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=NA3ZB7RXdDeJOxwh4jdf4wOzGGcL5zrZKWSkKxNgC0xjnE2NKz1FBGB6u5mhDerAT
 IVh0CKVTrPZkAsomQ09CnWwTKKWJJ5fHjQouUiNwu0674jqsr4rSgixWEuNjqFQ5K9
 1lQF4v9YJw5qqUyjCWJZ8xdnlCcpvzfbel5e9/aKcON6BEJEMkMR5vE0fFE91xQNbd
 TOEOUZFlIg/HxF6IFeIjjIwDGG9C9vtJ17sCcyYcQE5lwU4wsTEr8bfeY08o16G7RF
 gufyHgM2cifZZz9UGdFlFw70Vmn0MTtxgzp2cxlw0EmbaYdt8xV9Xw9jkuOuhaVSNI
 a33z3a8TsvSYA==
Date: Tue, 29 Apr 2025 21:02:18 +0000
To: Casey Connolly <casey.connolly@linaro.org>
From: Sam Day <me@samcday.com>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 caleb.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 sjg@chromium.org, ilias.apalodimas@linaro.org, sughosh.ganu@linaro.org,
 marex@denx.de, robert.marko@sartura.hr, seashell11234455@gmail.com,
 ycliang@andestech.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1 2/3] sysreset: Implement PSCI based reset to EDL mode
 for QCOM SoCs
Message-ID: <LuL4WXnr__yuMdWjNvf8teZE0XqtpLYxukfJXSiHAOwA4XpuCGGZA1uZl-dkXbR9lA0ilkh9k-N6hvDayjRSgW-Trb8cxyZgdMCEcQ8LGts=@samcday.com>
In-Reply-To: <1e0e9a72-40a8-4ce3-a390-edef1d6a03d8@linaro.org>
References: <20250410120208.4142087-1-quic_varada@quicinc.com>
 <20250410120208.4142087-3-quic_varada@quicinc.com>
 <1e0e9a72-40a8-4ce3-a390-edef1d6a03d8@linaro.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 4aaa851d8c08c8ca1cd2c3320ef386add0636c40
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

Hey Casey, Varadarajan,

On Tuesday, April 29th, 2025 at 12:22 AM, Casey Connolly <casey.connolly@li=
naro.org> wrote:

>=20
>=20
>=20
>=20
> On 4/10/25 14:02, Varadarajan Narayanan wrote:
>=20
> > Add SYSRESET_EDL to sysreset_t and handle the different SYSRESET_xxx
> > requests in sysreset_qcom-psci.c.
>=20
>=20
> To be honest, I'm not really excited about this. Copying the entire PSCI
> reset code and polluting the global sysreset reason enum with entirely
> platform specific symbols is not good practise.
>=20
> Additionally, while this specific EDL implementation works on your
> platform, it does not work on (for example) sdm845 and sm8250 which are
> platforms we still very much care about. I'm also not sure if it works
> on SC7280.
>=20
> I think this should be handled in an/the SCM driver like it is in Linux,
> not sure if Sam is working on that or if I can send a barebones version
> of the one I have in my tree. It will need to be based on the compatible
> string for the scm node in DT (and checking for the qcom,dload-mode
> property too I think).

I've started on the v2 of the SCM driver patch, but I'm behind on
everything atm, and not expecting to resend that series for another
couple of weeks.

If someone wants to pick up the SCM part please be my guest :D

Thanks,
-Sam

>=20
> As I proposed before on IRC, I think it makes sense to pass the "reset"
> arguments into sysreset and allow the sysreset driver to implement a
> callback/handler for them, this way the "edl" argument makes it all the
> way to our platform-specific driver which can then call
> "psci_system_reset2()"
>=20
> I would implement this by adding a new op to sysreset_ops, something
> like .request_args, then have a second for loop which calls this, since
> we want any reset handler which /can/ parse the args to do so before we
> call the normal .request callback (otherwise some other handler might do
> a normal reset before we have parsed the arguments).
>=20
> For now I'm fine with this new sysreset-qcom.c driver being specific to
> qcs9100, but please include a comment that the psci reset2 call is only
> supported on some newer qualcomm platforms and that others can be
> supported via SCM.
>=20
> On that note, how does this new driver actually get bound? It doesn't
> have any compatible strings associated? Or am I missing something
> here... Please explain this.
>=20
> Otherwise, I'm looking forward to v2.
>=20
> Kind regards,
>=20
> > Signed-off-by: Varadarajan Narayanan quic_varada@quicinc.com
> > ---
> > drivers/sysreset/Kconfig | 5 +++
> > drivers/sysreset/Makefile | 1 +
> > drivers/sysreset/sysreset-uclass.c | 7 ++--
> > drivers/sysreset/sysreset_qcom-psci.c | 47 +++++++++++++++++++++++++++
> > include/sysreset.h | 2 ++
> > 5 files changed, 60 insertions(+), 2 deletions(-)
> > create mode 100644 drivers/sysreset/sysreset_qcom-psci.c
> >=20
> > diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> > index 121194e4418..a6a1e57b603 100644
> > --- a/drivers/sysreset/Kconfig
> > +++ b/drivers/sysreset/Kconfig
> > @@ -240,6 +240,11 @@ config SYSRESET_RAA215300
> > help
> > Add support for the system reboot via the Renesas RAA215300 PMIC.
> >=20
> > +config SYSRESET_QCOM_PSCI
> > + bool "Support sysreset for Qualcomm SoCs via PSCI"
> > + help
> > + Add support for the system reboot on Qualcomm SoCs via PSCI.
> > +
> > config SYSRESET_QCOM_PSHOLD
> > bool "Support sysreset for Qualcomm SoCs via PSHOLD"
> > depends on ARCH_IPQ40XX
> > diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
> > index 796fc9effa5..12dbad5254a 100644
> > --- a/drivers/sysreset/Makefile
> > +++ b/drivers/sysreset/Makefile
> > @@ -29,5 +29,6 @@ obj-$(CONFIG_SYSRESET_RESETCTL) +=3D sysreset_resetct=
l.o
> > obj-$(CONFIG_$(PHASE_)SYSRESET_AT91) +=3D sysreset_at91.o
> > obj-$(CONFIG_$(PHASE_)SYSRESET_X86) +=3D sysreset_x86.o
> > obj-$(CONFIG_SYSRESET_RAA215300) +=3D sysreset_raa215300.o
> > +obj-$(CONFIG_SYSRESET_QCOM_PSCI) +=3D sysreset_qcom-psci.o
> > obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) +=3D sysreset_qcom-pshold.o
> > obj-$(CONFIG_TARGET_XTFPGA) +=3D sysreset_xtfpga.o
> > diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysr=
eset-uclass.c
> > index 536ac727142..d06c0a6908a 100644
> > --- a/drivers/sysreset/sysreset-uclass.c
> > +++ b/drivers/sysreset/sysreset-uclass.c
> > @@ -125,8 +125,11 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int =
argc, char *const argv[])
> > if (argc > 2)
> > return CMD_RET_USAGE;
> >=20
> > - if (argc =3D=3D 2 && argv[1][0] =3D=3D '-' && argv[1][1] =3D=3D 'w') =
{
> > - reset_type =3D SYSRESET_WARM;
> > + if (argc =3D=3D 2) {
> > + if (argv[1][0] =3D=3D '-' && argv[1][1] =3D=3D 'w')
> > + reset_type =3D SYSRESET_WARM;
> > + else if (!strncmp("edl", argv[1], 3))
> > + reset_type =3D SYSRESET_EDL;
> > }
> >=20
> > printf("resetting ...\n");
> > diff --git a/drivers/sysreset/sysreset_qcom-psci.c b/drivers/sysreset/s=
ysreset_qcom-psci.c
> > new file mode 100644
> > index 00000000000..3afb79e2d2e
> > --- /dev/null
> > +++ b/drivers/sysreset/sysreset_qcom-psci.c
> > @@ -0,0 +1,47 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2017 Masahiro Yamada yamada.masahiro@socionext.com
> > + /
> > +
> > +#include <dm.h>
> > +#include <sysreset.h>
> > +#include <asm/system.h>
> > +#include <linux/errno.h>
> > +#include <linux/psci.h>
> > +
> > +__weak int qcom_psci_sysreset_get_status(struct udevice dev, char buf,=
 int size)
> > +{
> > + return -EOPNOTSUPP;
> > +}
> > +
> > +static int qcom_psci_sysreset_request(struct udevice dev, enum sysrese=
t_t type)
> > +{
> > + switch (type) {
> > + case SYSRESET_WARM:
> > + case SYSRESET_COLD:
> > + psci_sys_reset(type);
> > + break;
> > + case SYSRESET_POWER_OFF:
> > + psci_sys_poweroff();
> > + break;
> > + case SYSRESET_EDL:
> > + psci_system_reset2(0, 1);
> > + break;
> > + default:
> > + return -EPROTONOSUPPORT;
> > + }
> > +
> > + return -EINPROGRESS;
> > +}
> > +
> > +static struct sysreset_ops qcom_psci_sysreset_ops =3D {
> > + .request =3D qcom_psci_sysreset_request,
> > + .get_status =3D qcom_psci_sysreset_get_status,
> > +};
> > +
> > +U_BOOT_DRIVER(qcom_psci_sysreset) =3D {
> > + .name =3D "qcom_psci-sysreset",
> > + .id =3D UCLASS_SYSRESET,
> > + .ops =3D &qcom_psci_sysreset_ops,
> > + .flags =3D DM_FLAG_PRE_RELOC,
> > +};
> > diff --git a/include/sysreset.h b/include/sysreset.h
> > index ff20abdeed3..8bda9703cd9 100644
> > --- a/include/sysreset.h
> > +++ b/include/sysreset.h
> > @@ -21,6 +21,8 @@ enum sysreset_t {
> > SYSRESET_POWER,
> > / @SYSRESET_POWER_OFF: turn off power /
> > SYSRESET_POWER_OFF,
> > + / @SYSRESET_EDL: reset and boot into Emergency DownLoader /
> > + SYSRESET_EDL,
> > / @SYSRESET_COUNT: number of available reset types */
> > SYSRESET_COUNT,
> > };
>=20
> --
> Casey (she/they)

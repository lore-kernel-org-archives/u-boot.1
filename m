Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9ADCCD8C85
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 01:32:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E70E08063E;
	Sun,  7 Jun 2026 03:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="F6CdrhhT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E61583314; Sun,  7 Jun 2026 03:32:40 +0200 (CEST)
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39CBC80433
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 03:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780795955; x=1781055155;
 bh=f4w6byaYPASyo1x9tW+IUgFCH1njs7ft22pnaH+UnAc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=F6CdrhhTwiToqFnno6CaN3ODTZt7MAsfRPb1IN9comska4Fe7OkmtVsr/GJ44kYmG
 zKYTWza4/rqtleTXmeFH7uBuHnsE1TY4aTaO26eohMQFaH4ZhOtvoPDN1g7e5zArEK
 2CEwq+ZPACSNo5nK/S9P6LJ3ZiPxil7/4p+BV6f9lEg/8SjO71zOKi4E4HCMYILwuT
 7/EnuXDoDZDrMHyFhoAafkdu4EAopuwyYottAOyG2iY7amm8p389XqqQgiQxUZ05b8
 WnohpfYrwX+tQ9iX1phLCNwbnq4MJ2kSgCYZO6HIR7NU5E8+TVYepXiBzbQGxxKCFI
 uDEZ0SrjIzTQw==
Date: Sun, 07 Jun 2026 01:32:31 +0000
To: Casey Connolly <casey.connolly@linaro.org>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Anshul Dalal <anshuld@ti.com>, Kever Yang <kever.yang@rock-chips.com>,
 Neha Malcom Francis <n-francis@ti.com>, Justin Klaassen <justin@tidylabs.net>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peter Robinson
 <pbrobinson@gmail.com>, Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Dmitrii Merkurev <dimorinny@google.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 08/11] mach-snapdragon: Integrate reboot-mode handling
Message-ID: <Fm26g-2DIjWkmweiA6UwdkZJJpeqeNPV3NRSfdtyASki2_mJC9HgH9gErN-PhaIGtMIu-SnZMvTzc8zR_XljCeA69eiAcukEw-scW33p0J4=@samcday.com>
In-Reply-To: <fb02b123-df74-4911-bc52-144c901e713d@linaro.org>
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
 <20260606-pm8916-pon-v1-8-170c9cbe5099@samcday.com>
 <fb02b123-df74-4911-bc52-144c901e713d@linaro.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 17404a44335f569bb1b3e52cd03bc44a3c697154
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

Hi Casey,

On Saturday, 6 June 2026 at 10:07 PM, Casey Connolly <casey.connolly@linaro=
.org> wrote:

> Hi Sam,
>=20
> FYI this is superseded by
> https://lore.kernel.org/u-boot/20260521180549.282377-4-aswin.murugan@oss.=
qualcomm.com/
>=20
> When you resend you can just indicate that your series is based on top
> of that one so it can get picked.

Thanks, I've queued that change for the v2.

Regards,
-Sam

>=20
> Kind regards,
>=20
> On 6/6/26 10:47, Sam Day via B4 Relay wrote:
> > From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> >
> > Add reboot-mode detection and automatic fastboot entry to Qualcomm boar=
d
> > initialization. This enables 'reboot bootloader' functionality on
> > platforms with reboot-mode device tree configuration.
> >
> > Changes:
> > - Add qcom_handle_reboot_mode() call in board_late_init()
> > - Conditionally compile with CONFIG_DM_REBOOT_MODE
> > - Reorganize header includes
> >
> > Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> >   arch/arm/mach-snapdragon/board.c | 56 +++++++++++++++++++++++++++++++=
+--------
> >   1 file changed, 45 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdrago=
n/board.c
> > index 829a0109ac7..c37195def57 100644
> > --- a/arch/arm/mach-snapdragon/board.c
> > +++ b/arch/arm/mach-snapdragon/board.c
> > @@ -9,6 +9,15 @@
> >   #define LOG_CATEGORY LOGC_BOARD
> >   #define pr_fmt(fmt) "QCOM: " fmt
> >
> > +#include <command.h>
> > +#include <env.h>
> > +#include <fdt_support.h>
> > +#include <init.h>
> > +#include <lmb.h>
> > +#include <malloc.h>
> > +#include <sort.h>
> > +#include <time.h>
> > +#include <usb.h>
> >   #include <asm/armv8/mmu.h>
> >   #include <asm/gpio.h>
> >   #include <asm/io.h>
> > @@ -16,22 +25,14 @@
> >   #include <asm/system.h>
> >   #include <dm/device.h>
> >   #include <dm/pinctrl.h>
> > -#include <dm/uclass-internal.h>
> >   #include <dm/read.h>
> > -#include <power/regulator.h>
> > -#include <env.h>
> > -#include <fdt_support.h>
> > -#include <init.h>
> > +#include <dm/uclass-internal.h>
> >   #include <linux/arm-smccc.h>
> >   #include <linux/bug.h>
> >   #include <linux/psci.h>
> >   #include <linux/sizes.h>
> > -#include <lmb.h>
> > -#include <malloc.h>
> > -#include <fdt_support.h>
> > -#include <usb.h>
> > -#include <sort.h>
> > -#include <time.h>
> > +#include <power/regulator.h>
> > +#include <reboot-mode/reboot-mode.h>
> >
> >   #include "qcom-priv.h"
> >
> > @@ -506,6 +507,33 @@ void qcom_show_boot_source(void)
> >   =09env_set("boot_source", name);
> >   }
> >
> > +/**
> > + * qcom_handle_reboot_mode() - Process reboot-mode detection and handl=
e fastboot entry
> > + *
> > + * This function detects the reboot reason from PMIC registers and aut=
omatically
> > + * enters fastboot mode if the reboot reason was "bootloader".
> > + */
> > +static void qcom_handle_reboot_mode(void)
> > +{
> > +=09struct udevice *reboot_dev;
> > +=09const char *reboot_mode;
> > +=09int ret;
> > +
> > +=09ret =3D uclass_first_device_err(UCLASS_REBOOT_MODE, &reboot_dev);
> > +=09if (ret)
> > +=09=09return;
> > +
> > +=09ret =3D dm_reboot_mode_update(reboot_dev);
> > +=09if (ret)
> > +=09=09return;
> > +
> > +=09reboot_mode =3D env_get("reboot-mode");
> > +=09if (reboot_mode && !strcmp(reboot_mode, "bootloader")) {
> > +=09=09printf("Entering fastboot mode due to reboot reason...\n");
> > +=09=09run_command("run fastboot", 0);
> > +=09}
> > +}
> > +
> >   void __weak qcom_late_init(void)
> >   {
> >   }
> > @@ -575,6 +603,12 @@ int board_late_init(void)
> >   =09qcom_late_init();
> >
> >   =09qcom_show_boot_source();
> > +
> > +=09/* Handle reboot-mode detection and fastboot entry */
> > +#if IS_ENABLED(CONFIG_DM_REBOOT_MODE)
> > +=09qcom_handle_reboot_mode();
> > +#endif
> > +
> >   =09/* Configure the dfu_string for capsule updates */
> >   =09qcom_configure_capsule_updates();
> >
> >
>=20
> 

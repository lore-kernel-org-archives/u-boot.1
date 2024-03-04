Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126DCC48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 14:12:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CA7E87D7E;
	Mon,  4 Mar 2024 15:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="VcGHAZm2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 706D587FA6; Mon,  4 Mar 2024 15:03:05 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1009B87FA0
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 15:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 525CA120008;
 Mon,  4 Mar 2024 17:03:02 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 525CA120008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1709560982;
 bh=r2Yc/DdnIfEja355Eki0qNVFEoSLP245r/2KUrlAEHo=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=VcGHAZm2Rngl4w9EPYGoicXysKl3mC561fWswafs/fg6AZz3wQvOE2EaeG4RnoRNo
 jSNLXcEk0LNKEveoUUR9Vdax5uAik3tbYGaYlJYEvQp0j0BfC06hDKW3SssfXBHUuq
 jh8NS9gHdn2BAM4qtKIJ7v3bIHZ9CDGX+XIK4RYB/z5ZP0Wx26e7EXUTskKfo221dS
 vY+HW37jGVcEzXoLWPGjl3AK+jUg07n9wb4e7obZwWCWbTC5NqpxNW49S0FrGlIhS0
 1HR4sUIt2mn0ekuqAzRH4AzBbhiDlkk+wc7LrS4lDH7O/WTSLvP42e3P27mkTCFzJq
 dBbgnaF7qh/ng==
Received: from smtp.sberdevices.ru (p-i-exch-a-m2.sberdevices.ru
 [172.24.196.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon,  4 Mar 2024 17:03:02 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-a-m2.sberdevices.ru (172.24.196.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 4 Mar 2024 17:03:01 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([fe80::6d41:e8f1:b95e:ba1]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::6d41:e8f1:b95e:ba1%7]) with
 mapi id 15.02.1118.040; Mon, 4 Mar 2024 17:03:01 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
CC: "sjg@chromium.org" <sjg@chromium.org>, "hs@denx.de" <hs@denx.de>,
 "sean.anderson@seco.com" <sean.anderson@seco.com>, "dimorinny@google.com"
 <dimorinny@google.com>, "patrick.delaunay@foss.st.com"
 <patrick.delaunay@foss.st.com>, kernel <kernel@sberdevices.ru>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [RFC PATCH v2 2/2] board: ad401: example of fastboot oem board
 realization
Thread-Topic: [RFC PATCH v2 2/2] board: ad401: example of fastboot oem board
 realization
Thread-Index: AQHaVO/tacIhsq/EBEWrtLsZKJ51orELBU2AgByX2oA=
Date: Mon, 4 Mar 2024 14:03:01 +0000
Message-ID: <20240304140257.f3tguxyg3z47mhbi@cab-wsm-0029881.sigma.sbrf.ru>
References: <20240201092027.6258-1-avromanov@salutedevices.com>
 <20240201092027.6258-3-avromanov@salutedevices.com>
 <871q9eytac.fsf@baylibre.com>
In-Reply-To: <871q9eytac.fsf@baylibre.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.93]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E021F85B18B67841B5FBD7766C0AA954@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Track_E25351},
 {Tracking_from_domain_doesnt_match_to}, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Mon, 04 Mar 2024 15:12:51 +0100
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

Hello Mattijs,

On Thu, Feb 15, 2024 at 10:24:11AM +0100, Mattijs Korpershoek wrote:
> On jeu., f'evr. 01, 2024 at 12:20, Alexey Romanov <avromanov@salutedevice=
s.com> wrote:
>=20
> > An example of how we use fastboot oeam board subcommand
> > for Sean Anderson.
> >
> > 1 - OEM_BOARD_WRITE_BOOTLOADER_CMD:
> >
> > We use it for custom Amlogic bootloader + tpl
> > flashing protocol.
> >
> > 2 - OEM_BOARD_ERASE_CMD:
> >
> > Custom logic for erasing the env-emulated partition,
> > which isn't in the mtd markup map.
> >
> > Example of the script which completely flashes the device:
> >
> >   $ fastboot erase bootloader
> >   $ fastboot stage u-boot.bin
> >   $ fastboot oem board:write_bootloader
> >   $ fastboot reboot-bootloader
> >   $ fastboot oem board:erase_env
> >   $ fastboot erase misc
> >   $ fastboot erase super
> >   $ fastboot flash super rootfs
> >   $ fastboot reboot
> >
> > Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> > ---
> >  board/amlogic/ad401/fastboot.c | 222 +++++++++++++++++++++++++++++++++
> >  1 file changed, 222 insertions(+)
> >  create mode 100644 board/amlogic/ad401/fastboot.c
> >
> > diff --git a/board/amlogic/ad401/fastboot.c b/board/amlogic/ad401/fastb=
oot.c
> > new file mode 100644
> > index 0000000000..01da8efa5b
> > --- /dev/null
> > +++ b/board/amlogic/ad401/fastboot.c
> > @@ -0,0 +1,222 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * (C) Copyright 2023 SaluteDevices, Inc.
> > + */
> > +
> > +#include <common.h>
> > +#include <env.h>
> > +#include <fastboot.h>
> > +#include <nand.h>
> > +#include <asm/arch/nand.h>
> > +#include <jffs2/load_kernel.h>
> > +#include <linux/sizes.h>
> > +#include <linux/types.h>
> > +#include <linux/mtd/mtd.h>
> > +
> > +enum {
> > +	OEM_BOARD_ERASE_CMD,
> > +	OEM_BOARD_WRITE_BOOTLOADER_CMD,
> > +};
> > +
> > +struct defenv {
> > +	char *name;
> > +	char value[256];
> > +};
> > +
> > +static void save_defenv(struct defenv *e, size_t cnt)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < cnt; i++) {
> > +		const char *env_val =3D env_get(e[i].name);
> > +
> > +		if (env_val)
> > +			strlcpy(e[i].value, env_val, sizeof(e[i].value));
> > +		else
> > +			e[i].value[0] =3D '\0';
> > +	}
> > +}
> > +
> > +static void set_defenv(struct defenv *e, size_t cnt)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < cnt; i++)
> > +		env_set(e[i].name, e[i].value);
> > +}
> > +
> > +static int fastboot_erase_env(void)
> > +{
> > +	char *const defenv_names[] =3D { "lock", "mtdparts", "mtdids" };
> > +	struct defenv env[ARRAY_SIZE(defenv_names)];
> > +	int err, i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(env); i++)
> > +		env[i].name =3D defenv_names[i];
> > +
> > +	printf("ENV is being erased...\n");
> > +
> > +	/*
> > +	 * Reset environment to the default, excluding 'lock' variable,
> > +	 * because it reflects the fastboot's state after execution of
> > +	 * 'flashing unlock' command, hence it must survive the env-erasing.
> > +	 * Otherwise, further erase commands will fail on check_lock().
> > +	 *
> > +	 * Also, we have to save 'mtdparts' and 'mtdids' variables
> > +	 * because they are necessary to obtain partition map.
> > +	 */
> > +
> > +	save_defenv(env, ARRAY_SIZE(env));
> > +	env_set_default(NULL, 0);
> > +	set_defenv(env, ARRAY_SIZE(env));
> > +
> > +	err =3D env_save();
> > +	if (err) {
> > +		pr_err("Can't overwrite ENV-partition\n");
> > +		return err;
> > +	}
>=20
> Hmm so the fastboot locked state is saved in the U-Boot environment.
> There is probably a good reason for this (no secure storage for
> example). But this does not feel board specific.
>=20
> Wouldn't it be better if we could just run "fastboot erase bootenv" and
> that the generic fastboot code does the right thing?

Are you proposing to modify the code of fastboot in such a way
that if user send 'erase bootenv' string, then we call generic
function to cleanup environment, instead of try to search (and erase)
in partition schema 'bootenv' partition?

> (which is env default, and ignoring some magic/specific variables)
>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static int fastboot_nand_write_tpl(struct mtd_info *mtd, void *buffer,
> > +				   u32 offset, size_t size, int flags)
> > +{
> > +	int boot_cpy_num =3D meson_bootloader_copy_num(BOOT_TPL);
> > +	u64 size_per_copy =3D meson_bootloader_copy_size(mtd, BOOT_TPL);
> > +	int i;
> > +
> > +	for (i =3D 0; i < boot_cpy_num; i++) {
> > +		size_t retlen, len =3D size;
> > +		int ret;
> > +
> > +		ret =3D nand_write_skip_bad(mtd, offset + (i * size_per_copy),
> > +					  &len, &retlen, offset + size_per_copy,
> > +					  buffer, flags);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int fastboot_nand_write_bl2(struct mtd_info *mtd, void *buffer,
> > +				   u32 offset, size_t size, int flags)
> > +{
> > +	int boot_cpy_num =3D meson_bootloader_copy_num(BOOT_BL2);
> > +	u64 size_per_copy =3D meson_bootloader_copy_size(mtd, BOOT_BL2);
> > +	int i;
> > +
> > +	for (i =3D 0; i < boot_cpy_num; i++) {
> > +		int ret;
> > +
> > +		ret =3D meson_bootloader_write_bl2(mtd, buffer,
> > +						 offset + (i * size_per_copy),
> > +					         size, flags);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return meson_bootloader_write_info_pages();
> > +}
> > +
> > +static int fastboot_nand_write_bootloader(void *buffer, u32 size)
> > +{
> > +	struct part_info *part;
> > +	struct mtd_info *mtd =3D NULL;
> > +	struct mtd_device *dev;
> > +	u8 pnum;
> > +	int ret;
> > +
> > +	if (size < BL2_SIZE)
> > +		return 0;
> > +
> > +	if (!buffer)
> > +		return -EINVAL;
> > +
> > +	ret =3D mtdparts_init();
> > +	if (ret) {
> > +		pr_err("Cannot initialize MTD partitions\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D find_dev_and_part("bootloader", &dev, &pnum, &part);
> > +	if (ret) {
> > +		pr_err("cannot find 'bootloader' partition\n");
> > +		return ret;
> > +	}
> > +
> > +	mtd =3D get_nand_dev_by_index(dev->id->num);
> > +	if (!mtd)
> > +		return -EINVAL;
> > +
> > +	ret =3D fastboot_nand_write_bl2(mtd, buffer, part->offset,
> > +				      BL2_SIZE, WITH_WR_VERIFY);
> > +	if (ret) {
> > +		pr_err("fastboot: failed to write BL2\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D find_dev_and_part("tpl", &dev, &pnum, &part);
> > +	if (ret) {
> > +		pr_err("cannot find 'bootloader' partition\n");
> > +		return ret;
> > +	}
> > +
> > +	mtd =3D get_nand_dev_by_index(dev->id->num);
> > +	if (!mtd)
> > +		return -EINVAL;
> > +
> > +	ret =3D fastboot_nand_write_tpl(mtd, buffer + BL2_SIZE, part->offset,
> > +				      size - BL2_SIZE, WITH_WR_VERIFY);
> > +	if (ret) {
> > +		pr_err("fastboot: failed to write TPL\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +int get_oem_board_command(const char *cmd)
> > +{
> > +	const char *oem_commands[] =3D {
> > +		[OEM_BOARD_ERASE_CMD] =3D "erase_env",
> > +		[OEM_BOARD_WRITE_BOOTLOADER_CMD] =3D "write_bootloader",
> > +	};
> > +	int i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(oem_commands); i++)
> > +		if (!strcmp(cmd, oem_commands[i]))
> > +			return i;
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +void fastboot_oem_board(const char *cmd_parameter, void *data, u32 siz=
e,
> > +			char *response)
> > +{
> > +	char buf[128] =3D { 0 };
> > +	int ret, cmd;
> > +
> > +	cmd =3D get_oem_board_command(cmd_parameter);
> > +
> > +	switch (cmd) {
> > +		case OEM_BOARD_ERASE_CMD:
> > +			ret =3D fastboot_erase_env();
> > +			break;
> > +		case OEM_BOARD_WRITE_BOOTLOADER_CMD:
> > +			ret =3D fastboot_nand_write_bootloader(data, size);
> > +			break;
> > +		default:
> > +			snprintf(buf, sizeof(buf),
> > +				 "Command 'oem board %s' not supported",
> > +				 cmd_parameter);
> > +			fastboot_fail(buf, response);
> > +			return;
> > +	}
> > +
> > +	if (ret < 0)
> > +		fastboot_fail("Failed to erase env partition", response);
> > +	else
> > +		fastboot_okay(NULL, response);
> > +}
> > --=20
> > 2.30.1

--=20
Thank you,
Alexey=

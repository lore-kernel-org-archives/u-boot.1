Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA66ACD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6F2F88396;
	Wed,  3 Apr 2024 14:55:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="ibM/qxei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6601587F4A; Wed,  3 Apr 2024 10:49:09 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90152881BC
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 10:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 2FF84100012;
 Wed,  3 Apr 2024 11:49:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2FF84100012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1712134146;
 bh=GOlg21uhERBWsyF9FS1zULK55Lo4GcmtssqmqEGNCeA=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=ibM/qxeidJo/Tw15BMDVOXojU+rPvG3BpzoumCvSiDljDqiKt79DwQ++3+eJnWXax
 sDSvoNulF2kieLhfsTIUVCamRsIQJBP51QAu8mHapGPCCks5jJaqaZ+4s5IkZLXgOQ
 2y8mgo+UVXgYk6mdO2g7VM6mBrxxs2m0eu0bodR3IF88zwJ95VM9IxtCQHjr7Axxr9
 SkLxgI8UeI3VggBp18p2AQ/EIuPPQfRzuBJZz7OLLUQDrCZi93BH47ywoZXz1oIpX2
 zTUmgBIy3iU4AYxzufS+ojvEhNjSR5w5uH7BxhpG2jvwc846XGDENQ3mCjrrxmN1nm
 zPvxTuZfVsZVA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed,  3 Apr 2024 11:49:05 +0300 (MSK)
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 3 Apr 2024 11:49:05 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511]) by
 p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511%9]) with
 mapi id 15.02.1118.040; Wed, 3 Apr 2024 11:49:05 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
CC: "sjg@chromium.org" <sjg@chromium.org>, "hs@denx.de" <hs@denx.de>,
 "sean.anderson@seco.com" <sean.anderson@seco.com>, "dimorinny@google.com"
 <dimorinny@google.com>, "patrick.delaunay@foss.st.com"
 <patrick.delaunay@foss.st.com>, kernel <kernel@sberdevices.ru>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>
Subject: Re: [RFC PATCH v2 1/2] fastboot: introduce 'oem board' subcommand
Thread-Topic: [RFC PATCH v2 1/2] fastboot: introduce 'oem board' subcommand
Thread-Index: AQHaVO/sb2jtpFqkYkuipzwztG7h57ELAoSAgEto3AA=
Date: Wed, 3 Apr 2024 08:49:05 +0000
Message-ID: <20240403084900.5yxzfp7lz2u56y57@cab-wsm-0029881>
References: <20240201092027.6258-1-avromanov@salutedevices.com>
 <20240201092027.6258-2-avromanov@salutedevices.com>
 <874jeaytqy.fsf@baylibre.com>
In-Reply-To: <874jeaytqy.fsf@baylibre.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.93]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7658B55F6E4BF74D8B73C17E6DAD913E@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184547 [Apr 03 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14
 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to},
 salutedevices.com:7.1.1; 127.0.0.199:7.1.2; github.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/02 23:35:00
X-KSMG-LinksScanning: Clean, bases: 2024/04/02 23:34:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/04/03 07:03:00 #24587967
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Wed, 03 Apr 2024 14:55:06 +0200
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
is there any feedback?

On Thu, Feb 15, 2024 at 10:14:13AM +0100, Mattijs Korpershoek wrote:
> Hi Alexey,
>=20
> Thank you for the patch.
>=20
> On jeu., f'evr. 01, 2024 at 12:20, Alexey Romanov <avromanov@salutedevice=
s.com> wrote:
>=20
> > Currently, fastboot protocol in U-Boot has no opportunity
> > to execute vendor custom code with verifed boot. This patch
> > introduce new fastboot subcommand fastboot oem board:<cmd>,
> > which allow to run custom oem_board function.
> >
> > Default implementation is __weak. Vendor must redefine it in
> > board/ folder with his own logic.
> >
> > For example, some vendors have their custom nand/emmc partition
> > flashing or erasing. Here some typical command for such use cases:
> >
> > - flashing:
> >
> >   $ fastboot stage bootloader.img
> >   $ fastboot oem board:write_bootloader
> >
> > - erasing:
> >
> >   $ fastboot oem board:erase_env
> >
> > Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
>=20
> Sorry for the delay. I needed time to give this some thoughts and I
> waited for Sean to chime as well on this.
>=20
> I've heard from Neil that this might be related to:
> https://github.com/superna9999/pyamlboot/pull/20
>=20
> I think this can be useful. Not necessarily for writing custom
> partitions, but I see this could be used for other things:
>=20
> 1. Provision SoC-specific fuses (serialno/mac addr) at the factory line
>    (for production devices)
>    Examples:
>    $ fastboot oem board:write_serialno ABCDEF
>    $ fastboot oem board:write_macaddr AA:BB:CC:DD:EE
>=20
> 2. Access secure storage (via an Trusted Application)
>=20
> But both examples could also be in a fastboot flash format:
> $ fastboot flash serialno ABCDEF
>=20
> One concern I have is that U-Boot forks might use this command as
> an excuse to not makes things generic.
>=20
> I hope that others will chime in on this as well.
> I'd like to discuss this more because once this command is in we cannot
> remove it later.
>=20
> > ---
> >  drivers/fastboot/Kconfig      |  7 +++++++
> >  drivers/fastboot/fb_command.c | 15 +++++++++++++++
> >  include/fastboot.h            |  1 +
> >  3 files changed, 23 insertions(+)
> >
> > diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> > index a4313d60a9..4d94391a76 100644
> > --- a/drivers/fastboot/Kconfig
> > +++ b/drivers/fastboot/Kconfig
> > @@ -241,6 +241,13 @@ config FASTBOOT_OEM_RUN
> >  	  this feature if you are using verified boot, as it will allow an
> >  	  attacker to bypass any restrictions you have in place.
> > =20
> > +config FASTBOOT_OEM_BOARD
> > +	bool "Enable the 'oem board' command"
> > +	help
> > +	  This extends the fastboot protocol with an "oem board" command. Thi=
s
> > +	  command allows running vendor custom code defined in board/ files.
> > +	  Otherwise, it will do nothing and send fastboot fail.
>=20
> If we move forward with this, please also document the new command in:
> doc/android/fastboot.rst
>=20
> > +
> >  endif # FASTBOOT
> > =20
> >  endmenu
> > diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_comman=
d.c
> > index 5fcadcdf50..2298815770 100644
> > --- a/drivers/fastboot/fb_command.c
> > +++ b/drivers/fastboot/fb_command.c
> > @@ -40,6 +40,7 @@ static void reboot_recovery(char *, char *);
> >  static void oem_format(char *, char *);
> >  static void oem_partconf(char *, char *);
> >  static void oem_bootbus(char *, char *);
> > +static void oem_board(char *, char *);
> >  static void run_ucmd(char *, char *);
> >  static void run_acmd(char *, char *);
> > =20
> > @@ -107,6 +108,10 @@ static const struct {
> >  		.command =3D "oem run",
> >  		.dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_OEM_RUN, (run_ucmd), (NULL)=
)
> >  	},
> > +	[FASTBOOT_COMMAND_OEM_BOARD] =3D {
> > +		.command =3D "oem board",
> > +		.dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_OEM_BOARD, (oem_board), (NU=
LL))
> > +	},
> >  	[FASTBOOT_COMMAND_UCMD] =3D {
> >  		.command =3D "UCmd",
> >  		.dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_ucmd), (N=
ULL))
> > @@ -490,3 +495,13 @@ static void __maybe_unused oem_bootbus(char *cmd_p=
arameter, char *response)
> >  	else
> >  		fastboot_okay(NULL, response);
> >  }
> > +
> > +void __weak fastboot_oem_board(char *cmd_parameter, void *data, u32 si=
ze, char *response)
> > +{
> > +	fastboot_fail("oem board function not defined", response);
> > +}
> > +
> > +static void __maybe_unused oem_board(char *cmd_parameter, char *respon=
se)
> > +{
> > +	fastboot_oem_board(cmd_parameter, fastboot_buf_addr, image_size, resp=
onse);
> > +}
> > diff --git a/include/fastboot.h b/include/fastboot.h
> > index 296451f89d..06c1f26b6c 100644
> > --- a/include/fastboot.h
> > +++ b/include/fastboot.h
> > @@ -37,6 +37,7 @@ enum {
> >  	FASTBOOT_COMMAND_OEM_PARTCONF,
> >  	FASTBOOT_COMMAND_OEM_BOOTBUS,
> >  	FASTBOOT_COMMAND_OEM_RUN,
> > +	FASTBOOT_COMMAND_OEM_BOARD,
> >  	FASTBOOT_COMMAND_ACMD,
> >  	FASTBOOT_COMMAND_UCMD,
> >  	FASTBOOT_COMMAND_COUNT
> > --=20
> > 2.30.1

--=20
Thank you,
Alexey=

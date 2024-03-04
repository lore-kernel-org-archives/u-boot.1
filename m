Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD367C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 14:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 252C887FA1;
	Mon,  4 Mar 2024 15:12:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="m1PF1OdP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4410787D0A; Mon,  4 Mar 2024 15:11:36 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41DF687D7E
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 15:11:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 9ECA4100007;
 Mon,  4 Mar 2024 17:11:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9ECA4100007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1709561492;
 bh=aDUpvlIdrXhKY7f27Wxik7S2wPivE1PI+oWsZigNdM8=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=m1PF1OdP2LwSo/4wGaXX0ashF9IwazcMptMmqE/ROACH3G6U9yo3T1PL04C0WK3xI
 G2IHCUt7Uiby+b2P3fC1z8e8+ttHErDvlHIvSLdeJfQgjOO8PmaSxaYXm2zgcQ04ix
 R3wBzGq74P0y1lRFgAN++dNk0B2M65wieh2uc13Lv7J8P8JjJHA4pwJbX+8ZVZNLN1
 +8sIEmYcH/8gKzmkqNINWTOveALGY7eP4tjsEekNYtnqdnsyP2pf1EB3atbPuI0riB
 iQKo7lvvy+GpN+KR3TvZVZo++TVMzMYH9aUxT/7k8QAuQ9jSIbFuX2Ut4m45P058VI
 VIQveFDWAUGPw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon,  4 Mar 2024 17:11:32 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Mar 2024 17:11:32 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([fe80::6d41:e8f1:b95e:ba1]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::6d41:e8f1:b95e:ba1%7]) with
 mapi id 15.02.1118.040; Mon, 4 Mar 2024 17:11:32 +0300
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
Thread-Index: AQHaVO/sb2jtpFqkYkuipzwztG7h57ELAoSAgBydAQA=
Date: Mon, 4 Mar 2024 14:11:32 +0000
Message-ID: <20240304141126.otcp6tl7v6pupgzl@cab-wsm-0029881.sigma.sbrf.ru>
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
Content-ID: <2272005A75783F4C9B49850E747DC2A3@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/02/29 16:52:00
X-KSMG-LinksScanning: Clean, bases: 2024/02/29 16:52:00
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

Hello,

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

Yeah, pyamlboot also uses the same 'bootloader' partition flashing
scheme as I present in the patch 2. This is custom Amlogic protocol.

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

Agree, you are completely right.

>=20
> But both examples could also be in a fastboot flash format:
> $ fastboot flash serialno ABCDEF

But this case requires to 'serialno' partition definition in schema?
I didn't fully understand you.

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

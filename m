Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB003C47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 13:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE5E187B3F;
	Thu, 11 Jan 2024 14:08:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="lFMCbje2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2B0E8753C; Thu, 11 Jan 2024 12:16:09 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD27687620
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 12:16:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 2A73F10001B;
 Thu, 11 Jan 2024 14:16:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2A73F10001B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1704971766;
 bh=CoefCHeoXvQDxGiutSk4AoAtceROfXrMna9213RsrP0=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=lFMCbje2K3gJbHW5NV5Ng3i8HmUx8RfBUYt/99bJwPO9qGmM8RDSU9rywamnXRmfA
 O0/xFUFl5avfhojnT4nRRFbPKr2PcorlRjbzzps6djsKiYXkYvCLk2hmDylKDi9JHo
 bl8jtFpPyMpoKEbDcSW1JiAr6iMmyqS69G/m/RoOwBolDI8c77mGl+LFUX41knmEpr
 DjEx5+GDQa0NSDZW2rspI91QENNTmiBMM9+SosN04xgkHQfbTQYlR75pq1AvD9vqMU
 d084Vi97jCRV8S4cgrFUcOkgVmi0LozcF9Y70hB+1eoqynPykVeOiOY67hucARIHmY
 oikrPCdaTwvWA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 11 Jan 2024 14:16:05 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 11 Jan 2024 14:16:05 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([fe80::e8ee:cc43:7c6f:7ce0]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::e8ee:cc43:7c6f:7ce0%7]) with
 mapi id 15.02.1118.040; Thu, 11 Jan 2024 14:16:05 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
CC: Sean Anderson <sean.anderson@seco.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "hs@denx.de" <hs@denx.de>, "dimorinny@google.com"
 <dimorinny@google.com>, "patrick.delaunay@foss.st.com"
 <patrick.delaunay@foss.st.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1] fastboot: introduce 'oem board' subcommand
Thread-Topic: [PATCH v1] fastboot: introduce 'oem board' subcommand
Thread-Index: AQHaOaIWePMEMcT2lUeNAWB2040KM7C+tNoAgBJykACAAFjZAIABES8AgAGwMwCAAAbFAIAAESMA
Date: Thu, 11 Jan 2024 11:16:05 +0000
Message-ID: <20240111111503.ykncuvvdkiawtvgk@cab-wsm-0029881>
References: <20231228152522.83291-1-avromanov@salutedevices.com>
 <a3aea373-80fc-4799-894b-b0879e63da39@seco.com>
 <20240109102746.75iqizxeo6fxq4cu@cab-wsm-0029881>
 <48b16521-f1aa-4f78-ae9d-96832da0da72@seco.com>
 <20240110080332.o24rv45vadrzdsns@cab-wsm-0029881>
 <877ckg6vx9.fsf@baylibre.com>
 <20240111101433.k3sr5nphmerntxdo@cab-wsm-0029881>
In-Reply-To: <20240111101433.k3sr5nphmerntxdo@cab-wsm-0029881>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.92]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B536BD3E4CFAE14F887BCAD12FABEAA3@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182551 [Jan 11 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; smtp.sberdevices.ru:5.0.1,7.1.1;
 docs.u-boot.org:7.1.1; salutedevices.com:7.1.1; lore.kernel.org:7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/01/11 08:51:00
X-KSMG-LinksScanning: Clean, bases: 2024/01/11 08:52:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/01/11 08:56:00 #23088828
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 11 Jan 2024 14:08:34 +0100
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

On Thu, Jan 11, 2024 at 10:14:45AM +0000, Alexey Romanov wrote:
> Hi Mattijs,
>=20
> On Thu, Jan 11, 2024 at 10:50:26AM +0100, Mattijs Korpershoek wrote:
> > Hi Alexey, Sean,
> >=20
> > On mer., janv. 10, 2024 at 08:03, Alexey Romanov <avromanov@salutedevic=
es.com> wrote:
> >=20
> > > Hi,
> > >
> > > On Tue, Jan 09, 2024 at 10:45:46AM -0500, Sean Anderson wrote:
> > >> On 1/9/24 05:27, Alexey Romanov wrote:
> > >> > Hello Sean!
> > >> >=20
> > >> > Thanks for you reply.
> > >> >=20
> > >> > On Thu, Dec 28, 2023 at 11:45:04AM -0500, Sean Anderson wrote:
> > >> >> On 12/28/23 10:25, Alexey Romanov wrote:
> > >> >> > Currently, fastboot protocol in U-Boot has no opportunity
> > >> >> > to execute vendor custom code with verifed boot.
> > >> >>=20
> > >> >> Well, I would say the most conventional way to do this would be s=
omething like
> > >> >>=20
> > >> >> =3D> fastboot 0
> > >> >> =3D> source \# CONFIG_FASTBOOT_BUF_ADDR
> > >> >>=20
> > >> >> and on your host machine,
> > >> >>=20
> > >> >> $ fastboot stage my_script.itb
> > >> >>=20
> > >> >> where my_script.its looks like
> > >> >>=20
> > >> >> /dts-v1/;
> > >> >>=20
> > >> >> / {
> > >> >>     description =3D "my script";
> > >> >>     #address-cells =3D <1>;
> > >> >>=20
> > >> >>     images {
> > >> >>         my-script {
> > >> >>             data =3D /incbin/("my_script.scr");
> > >> >>             type =3D "script";
> > >> >>             arch =3D "arm64";
> > >> >>             compression =3D "none";
> > >> >>             hash-1 {
> > >> >>                 algo =3D "sha256";
> > >> >>             };
> > >> >>         };
> > >> >>     };
> > >> >>=20
> > >> >>     configurations {
> > >> >>         default =3D "conf";
> > >> >>         conf {
> > >> >>             description =3D "Load my script";
> > >> >>             script =3D "my-script";
> > >> >>             signature {
> > >> >>                 algo =3D "sha256,rsa2048";
> > >> >>                 key-name-hint =3D "vboot";
> > >> >>                 sign-images =3D "script";
> > >> >>             };
> > >> >>         };
> > >> >>     };
> > >> >> };
> > >> >>=20
> > >> >> This method is especially useful to pass complex parameters to yo=
ur command.
> > >> >> This method of course requires commit bcc85b96b5f ("cmd: source: =
Support
> > >> >> specifying config name").
> > >> >>=20
> > >> >> Would it be possible to use the above method for your use case?
> > >> >=20
> > >> > This method sounds good for some cases, but we have encountered so=
me
> > >> > problems that prevent us from applying it:
> > >> >=20
> > >> > 1. Looks like this method requires access to UART (for typing 'sou=
rce'
> > >> > command). Open the UART is unsafe at devices with verified boot.
> > >>=20
> > >> Generally the idea is that you run source after you run fastboot. E.=
g. you set
> > >> your altbootcmd (or whatever) to something like
> > >>=20
> > >> while true; fastboot 0; source \# || boot; done
> > >>=20
> > >> so you try to source whatever gets staged, and boot it otherwise.
> > >
> > > If I understand right, U-Boot always will try fastboot mode?
> > > Yes, it seems like it will work. But the code for complex
> > > fastboot scripts will be complex and difficult to read.
> > >
> > > I think my version looks more elegant and simple.
> >=20
> > I think your solution is elegant, but i'd like to make sure that the
> > problem cannot be solved otherwise (via environment changes or other th=
ings)
> >=20

I think we need to abstract ourselves from my specific case.
OEM commands, logically, should be define at the board level (not at
the command or scripts level). Currently, U-Boot doesn't provide such an
opportunity; OEM cannot run custom code defined at board level with a verif=
ied boot.

This is the main idea of my patch.

source command is not suitable in all cases, in addition, it forces you
you to store the necessary (for firmware flashing) *.itb files at your
host.

> > >
> > >>=20
> > >> > 2. We use automation scripts to flash our devices using fastboot
> > >> > protocol. A typical example of flashing scripts (device is already=
 in
> > >> > fastboot mode):
> > >> >=20
> > >> >   $ fastboot erase bootloader
> > >> >   $ fastboot stage bootloader.img
> > >> >   $ fastboot oem board:write_bootloader
> > >> >=20
> > >> >   $ fastboot reboot-bootloader
> > >> >=20
> > >> >   $ fastboot erase super
> > >> >   $ fastboot flash super super.bin
> > >> >=20
> > >> >   $ fastboot reboot
> > >> >=20
> > >> > This method doesn't assume what something typing additional comman=
d in
> > >> > U-Boot shell, even if we have access to UART.
> > >>=20
> > >> I'm curious what you actual usage for this is? That is, what do you =
need
> > >> a custom command for.
> > >
> > > Our SoC vendor use custom scheme for flashing bootloader partition.
> > > So we can't just use fastbooot flash command - we have to use custom
> > > flashing logic. We also don't want to use hacks in generic fastboot
> > > code, for example something like this in _fb_nand_write():
> > >
> > >   ...
> > >
> > >   if (!strcmp(part->name, "bootloader"))
> > >      write_bootloader_custom_logic(...)
> > >   else
> > >     nand_write_skip_bad(...)
> >=20
> > Could you detail what "custom scheme" means?
>=20
> We have a binary file that is uboot.bin combined with bl2.bin.
> This binary file must be written in a special way to the bootloader
> partition using helpers from following patchset:
>=20
> https://lore.kernel.org/all/20231228151421.82746-1-avromanov@salutedevice=
s.com/
>=20
> Our oem board implementation uses these functions with custom vendor flas=
hing
> logic. Something like this:
>=20
>     ...
>=20
>     int write_bootloader(offset, partition_name)
>     {
>         int cpy_num =3D meson_bootloader_copy_num(partition_name);
>=20
>         for (int i =3D 0; i < cpy_num; i++)
>             if (!strcmp(partition_name, BOOT_BL2))
>                 meson_bootloader_write_bl2(...);
>             else
>                 nand_write_skip_bad(...);
>=20
>         if (!strcmp(partition_name, BOOT_BL2))
>             meson_bootloader_write_info_pages();
>     }
>=20
>     write_bootloader(offset, BOOT_BL2);
>     write_bootloader(offset + BL2_SIZE, BOOT_TPL);
>=20
>     ...
>=20
> >=20
> > Wouldn't using "fastboot_raw_partition_*" be appropriate for your use-c=
ase?
> > https://docs.u-boot.org/en/latest/android/fastboot.html#raw-partition-d=
escriptors
>=20
> I'm not sure it will be possible to combine this with our
> implementation.
>=20
> >=20
> > I know the above is for mmc but maybe this can be extended for nand ?
> >=20
> > >
> > >   ...
> > >
> > >>=20
> > >> --Sean
> > >>=20
> > >> >>=20
> > >> >> --Sean
> > >> >>=20
> > >> >> > This patch
> > >> >> > introduce new fastboot subcommand fastboot oem board:<cmd>,
> > >> >> > which allow to run custom oem_board function.
> > >> >> > =3D
> > >> >> > Default implementation is __weak. Vendor must redefine it in
> > >> >> > board/ folder with his own logic.
> > >> >> >=20
> > >> >> > For example, some vendors have their custom nand/emmc partition
> > >> >> > flashing or erasing. Here some typical command for such use cas=
es:
> > >> >> >=20
> > >> >> > - flashing:
> > >> >> >=20
> > >> >> >   $ fastboot stage bootloader.img
> > >> >> >   $ fastboot oem board:write_bootloader
> > >> >> >=20
> > >> >> > - erasing:
> > >> >> >=20
> > >> >> >   $ fastboot oem board:erase_env
> > >> >> >=20
> > >> >> > Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> > >> >> > ---
> > >> >> >  drivers/fastboot/Kconfig      |  7 +++++++
> > >> >> >  drivers/fastboot/fb_command.c | 15 +++++++++++++++
> > >> >> >  include/fastboot.h            |  1 +
> > >> >> >  3 files changed, 23 insertions(+)
> > >> >> >=20
> > >> >> > diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfi=
g
> > >> >> > index 3cfeea4837..4c955cabab 100644
> > >> >> > --- a/drivers/fastboot/Kconfig
> > >> >> > +++ b/drivers/fastboot/Kconfig
> > >> >> > @@ -241,6 +241,13 @@ config FASTBOOT_OEM_RUN
> > >> >> >  	  this feature if you are using verified boot, as it will all=
ow an
> > >> >> >  	  attacker to bypass any restrictions you have in place.
> > >> >> > =20
> > >> >> > +config FASTBOOT_OEM_BOARD
> > >> >> > +	bool "Enable the 'oem board' command"
> > >> >> > +	help
> > >> >> > +	  This extends the fastboot protocol with an "oem board" comm=
and. This
> > >> >> > +	  command allows running vendor custom code defined in board/=
 files.
> > >> >> > +	  Otherwise, it will do nothing and send fastboot fail.
> > >> >> > +
> > >> >> >  endif # FASTBOOT
> > >> >> > =20
> > >> >> >  endmenu
> > >> >> > diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/f=
b_command.c
> > >> >> > index 71cfaec6e9..4d2b451f46 100644
> > >> >> > --- a/drivers/fastboot/fb_command.c
> > >> >> > +++ b/drivers/fastboot/fb_command.c
> > >> >> > @@ -39,6 +39,7 @@ static void reboot_recovery(char *, char *);
> > >> >> >  static void oem_format(char *, char *);
> > >> >> >  static void oem_partconf(char *, char *);
> > >> >> >  static void oem_bootbus(char *, char *);
> > >> >> > +static void oem_board(char *, char *);
> > >> >> >  static void run_ucmd(char *, char *);
> > >> >> >  static void run_acmd(char *, char *);
> > >> >> > =20
> > >> >> > @@ -106,6 +107,10 @@ static const struct {
> > >> >> >  		.command =3D "oem run",
> > >> >> >  		.dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_OEM_RUN, (run_ucmd)=
, (NULL))
> > >> >> >  	},
> > >> >> > +	[FASTBOOT_COMMAND_OEM_BOARD] =3D {
> > >> >> > +		.command =3D "oem board",
> > >> >> > +		.dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_OEM_BOARD, (oem_boa=
rd), (NULL))
> > >> >> > +	},
> > >> >> >  	[FASTBOOT_COMMAND_UCMD] =3D {
> > >> >> >  		.command =3D "UCmd",
> > >> >> >  		.dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_u=
cmd), (NULL))
> > >> >> > @@ -489,3 +494,13 @@ static void __maybe_unused oem_bootbus(cha=
r *cmd_parameter, char *response)
> > >> >> >  	else
> > >> >> >  		fastboot_okay(NULL, response);
> > >> >> >  }
> > >> >> > +
> > >> >> > +void __weak fastboot_oem_board(char *cmd_parameter, void *data=
, u32 size, char *response)
> > >> >> > +{
> > >> >> > +	fastboot_fail("oem board function not defined", response);
> > >> >> > +}
> > >> >> > +
> > >> >> > +static void __maybe_unused oem_board(char *cmd_parameter, char=
 *response)
> > >> >> > +{
> > >> >> > +	fastboot_oem_board(cmd_parameter, fastboot_buf_addr, image_si=
ze, response);
> > >> >> > +}
> > >> >> > diff --git a/include/fastboot.h b/include/fastboot.h
> > >> >> > index 296451f89d..06c1f26b6c 100644
> > >> >> > --- a/include/fastboot.h
> > >> >> > +++ b/include/fastboot.h
> > >> >> > @@ -37,6 +37,7 @@ enum {
> > >> >> >  	FASTBOOT_COMMAND_OEM_PARTCONF,
> > >> >> >  	FASTBOOT_COMMAND_OEM_BOOTBUS,
> > >> >> >  	FASTBOOT_COMMAND_OEM_RUN,
> > >> >> > +	FASTBOOT_COMMAND_OEM_BOARD,
> > >> >> >  	FASTBOOT_COMMAND_ACMD,
> > >> >> >  	FASTBOOT_COMMAND_UCMD,
> > >> >> >  	FASTBOOT_COMMAND_COUNT
> > >> >>=20
> > >> >=20
> > >>=20
> > >
> > > --=20
> > > Thank you,
> > > Alexey
>=20
> --=20
> Thank you,
> Alexey

--=20
Thank you,
Alexey=

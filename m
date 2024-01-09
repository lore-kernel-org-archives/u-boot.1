Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3681C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 12:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D13B8878B8;
	Tue,  9 Jan 2024 13:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="cQs2OpMj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3413687871; Tue,  9 Jan 2024 11:27:57 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94BA18783F
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 11:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id BDDF4120003;
 Tue,  9 Jan 2024 13:27:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BDDF4120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1704796073;
 bh=iCN0B0xiOJH1xFnjitoU96/1ZHEvIScTeiGaph6wK5g=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=cQs2OpMj4OmrpnWYC69DXdZpD3fzTeaNzgnK0y2+UsdIlu+mK7nUCSevlBt6VBjqD
 HplIiAhznluh/xn0XVQNnmCMd+LCv8VU4ue8ctm0wAnsIXZiOlfpNO4j4liADu1TRT
 tfWPGd/4AXA6wVbtEckQbUcfdxtuNzMIBjIIgHKvs/ixIgq25Af5MrT4A035g3gJoM
 GTiSTFFvKK4kLnRU2xDfDPbjqO62lh56NQV7MNYJEhTVyPclYG4iqkR7paA5U45+ER
 O8QXtDLEYSfF101TS4oQEwhcP16zw14gmrB2HNMd75fha9loc4XIOgMYAPJ9CV0DU3
 kU/PxtIewkRqQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue,  9 Jan 2024 13:27:52 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 13:27:52 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([fe80::e8ee:cc43:7c6f:7ce0]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::e8ee:cc43:7c6f:7ce0%7]) with
 mapi id 15.02.1118.040; Tue, 9 Jan 2024 13:27:52 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: Sean Anderson <sean.anderson@seco.com>
CC: "sjg@chromium.org" <sjg@chromium.org>, "hs@denx.de" <hs@denx.de>,
 "dimorinny@google.com" <dimorinny@google.com>, "mkorpershoek@baylibre.com"
 <mkorpershoek@baylibre.com>, "patrick.delaunay@foss.st.com"
 <patrick.delaunay@foss.st.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1] fastboot: introduce 'oem board' subcommand
Thread-Topic: [PATCH v1] fastboot: introduce 'oem board' subcommand
Thread-Index: AQHaOaIWePMEMcT2lUeNAWB2040KM7C+tNoAgBJykAA=
Date: Tue, 9 Jan 2024 10:27:52 +0000
Message-ID: <20240109102746.75iqizxeo6fxq4cu@cab-wsm-0029881>
References: <20231228152522.83291-1-avromanov@salutedevices.com>
 <a3aea373-80fc-4799-894b-b0879e63da39@seco.com>
In-Reply-To: <a3aea373-80fc-4799-894b-b0879e63da39@seco.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.93]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <49F41DF8592B42489E066C8BBC8F5F23@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182496 [Jan 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Track_E25351},
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2; smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/01/09 08:44:00 #23037611
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Tue, 09 Jan 2024 13:21:09 +0100
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

Hello Sean!

Thanks for you reply.

On Thu, Dec 28, 2023 at 11:45:04AM -0500, Sean Anderson wrote:
> On 12/28/23 10:25, Alexey Romanov wrote:
> > Currently, fastboot protocol in U-Boot has no opportunity
> > to execute vendor custom code with verifed boot.
>=20
> Well, I would say the most conventional way to do this would be something=
 like
>=20
> =3D> fastboot 0
> =3D> source \# CONFIG_FASTBOOT_BUF_ADDR
>=20
> and on your host machine,
>=20
> $ fastboot stage my_script.itb
>=20
> where my_script.its looks like
>=20
> /dts-v1/;
>=20
> / {
>     description =3D "my script";
>     #address-cells =3D <1>;
>=20
>     images {
>         my-script {
>             data =3D /incbin/("my_script.scr");
>             type =3D "script";
>             arch =3D "arm64";
>             compression =3D "none";
>             hash-1 {
>                 algo =3D "sha256";
>             };
>         };
>     };
>=20
>     configurations {
>         default =3D "conf";
>         conf {
>             description =3D "Load my script";
>             script =3D "my-script";
>             signature {
>                 algo =3D "sha256,rsa2048";
>                 key-name-hint =3D "vboot";
>                 sign-images =3D "script";
>             };
>         };
>     };
> };
>=20
> This method is especially useful to pass complex parameters to your comma=
nd.
> This method of course requires commit bcc85b96b5f ("cmd: source: Support
> specifying config name").
>=20
> Would it be possible to use the above method for your use case?

This method sounds good for some cases, but we have encountered some
problems that prevent us from applying it:

1. Looks like this method requires access to UART (for typing 'source'
command). Open the UART is unsafe at devices with verified boot.

2. We use automation scripts to flash our devices using fastboot
protocol. A typical example of flashing scripts (device is already in
fastboot mode):

  $ fastboot erase bootloader
  $ fastboot stage bootloader.img
  $ fastboot oem board:write_bootloader

  $ fastboot reboot-bootloader

  $ fastboot erase super
  $ fastboot flash super super.bin

  $ fastboot reboot

This method doesn't assume what something typing additional command in
U-Boot shell, even if we have access to UART.

>=20
> --Sean
>=20
> > This patch
> > introduce new fastboot subcommand fastboot oem board:<cmd>,
> > which allow to run custom oem_board function.
> > =3D
> > Default implementation is __weak. Vendor must redefine it in
> > board/ folder with his own logic.
> >=20
> > For example, some vendors have their custom nand/emmc partition
> > flashing or erasing. Here some typical command for such use cases:
> >=20
> > - flashing:
> >=20
> >   $ fastboot stage bootloader.img
> >   $ fastboot oem board:write_bootloader
> >=20
> > - erasing:
> >=20
> >   $ fastboot oem board:erase_env
> >=20
> > Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> > ---
> >  drivers/fastboot/Kconfig      |  7 +++++++
> >  drivers/fastboot/fb_command.c | 15 +++++++++++++++
> >  include/fastboot.h            |  1 +
> >  3 files changed, 23 insertions(+)
> >=20
> > diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> > index 3cfeea4837..4c955cabab 100644
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
> > +
> >  endif # FASTBOOT
> > =20
> >  endmenu
> > diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_comman=
d.c
> > index 71cfaec6e9..4d2b451f46 100644
> > --- a/drivers/fastboot/fb_command.c
> > +++ b/drivers/fastboot/fb_command.c
> > @@ -39,6 +39,7 @@ static void reboot_recovery(char *, char *);
> >  static void oem_format(char *, char *);
> >  static void oem_partconf(char *, char *);
> >  static void oem_bootbus(char *, char *);
> > +static void oem_board(char *, char *);
> >  static void run_ucmd(char *, char *);
> >  static void run_acmd(char *, char *);
> > =20
> > @@ -106,6 +107,10 @@ static const struct {
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
> > @@ -489,3 +494,13 @@ static void __maybe_unused oem_bootbus(char *cmd_p=
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
>=20

--=20
Thank you,
Alexey=

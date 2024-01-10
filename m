Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AED3C4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 13:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BD7687ABA;
	Wed, 10 Jan 2024 14:04:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="Im66FQV2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2261878B2; Wed, 10 Jan 2024 09:59:37 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EC3A878B2
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 09:59:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id CDBAF120018;
 Wed, 10 Jan 2024 11:59:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CDBAF120018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1704877174;
 bh=LXbaV/3dLG5aoaHAPxxnYmjAL6phJlNVw5c+jWV9JNI=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=Im66FQV2sJlDMrlA+dfgbxlxGE/mRJjx5XXPxwYP95H6oLNqTAhFHvROpJoBSLeV5
 1wBjPxPFwe9/jAMLAwVOPh45/ny0ODf5QNnVadbfRaGKOe131VzgEGBbz52y5SPJyH
 zuQIesyQu8j2oJPnjAvCTaKkMM0zPjcqN0N3YXIhDG35qs3j99Vll2NDZtxzwfELpB
 XFGI0yJqk4EWiH9QOnwiLD0VUPQm7EOgGFQNCb6+1PKgtKHqCGV9B6500sAeZfZyxz
 KLVgRUBLV6MFSjD7I/4mPf6yLtHzv+42XBnD52hJDGuFtzZJ92E2Wnqywa5uCRjbvR
 770U38jOOayKw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed, 10 Jan 2024 11:59:33 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 11:59:32 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([fe80::e8ee:cc43:7c6f:7ce0]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::e8ee:cc43:7c6f:7ce0%7]) with
 mapi id 15.02.1118.040; Wed, 10 Jan 2024 11:59:32 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: Sean Anderson <sean.anderson@seco.com>
CC: "sjg@chromium.org" <sjg@chromium.org>, "hs@denx.de" <hs@denx.de>,
 "dimorinny@google.com" <dimorinny@google.com>, "mkorpershoek@baylibre.com"
 <mkorpershoek@baylibre.com>, "patrick.delaunay@foss.st.com"
 <patrick.delaunay@foss.st.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1] fastboot: introduce 'oem board' subcommand
Thread-Topic: [PATCH v1] fastboot: introduce 'oem board' subcommand
Thread-Index: AQHaOaIWePMEMcT2lUeNAWB2040KM7C+tNoAgBJykACAAFjZAIABES8AgAAPoQA=
Date: Wed, 10 Jan 2024 08:59:32 +0000
Message-ID: <20240110085854.qdjeosewhdvdurla@cab-wsm-0029881>
References: <20231228152522.83291-1-avromanov@salutedevices.com>
 <a3aea373-80fc-4799-894b-b0879e63da39@seco.com>
 <20240109102746.75iqizxeo6fxq4cu@cab-wsm-0029881>
 <48b16521-f1aa-4f78-ae9d-96832da0da72@seco.com>
 <20240110080332.o24rv45vadrzdsns@cab-wsm-0029881>
In-Reply-To: <20240110080332.o24rv45vadrzdsns@cab-wsm-0029881>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.93]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D19D1F9797508E46B9E55CC2A8864933@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182526 [Jan 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a,
 {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; smtp.sberdevices.ru:7.1.1,5.0.1;
 salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/01/10 05:49:00 #23060564
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Wed, 10 Jan 2024 14:04:49 +0100
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

Sorry, my e-mail client is lagging and I sent two replies.

On Wed, Jan 10, 2024 at 08:03:39AM +0000, Alexey Romanov wrote:
> Hi,
>=20
> On Tue, Jan 09, 2024 at 10:45:46AM -0500, Sean Anderson wrote:
> > On 1/9/24 05:27, Alexey Romanov wrote:
> > > Hello Sean!
> > >=20
> > > Thanks for you reply.
> > >=20
> > > On Thu, Dec 28, 2023 at 11:45:04AM -0500, Sean Anderson wrote:
> > >> On 12/28/23 10:25, Alexey Romanov wrote:
> > >> > Currently, fastboot protocol in U-Boot has no opportunity
> > >> > to execute vendor custom code with verifed boot.
> > >>=20
> > >> Well, I would say the most conventional way to do this would be some=
thing like
> > >>=20
> > >> =3D> fastboot 0
> > >> =3D> source \# CONFIG_FASTBOOT_BUF_ADDR
> > >>=20
> > >> and on your host machine,
> > >>=20
> > >> $ fastboot stage my_script.itb
> > >>=20
> > >> where my_script.its looks like
> > >>=20
> > >> /dts-v1/;
> > >>=20
> > >> / {
> > >>     description =3D "my script";
> > >>     #address-cells =3D <1>;
> > >>=20
> > >>     images {
> > >>         my-script {
> > >>             data =3D /incbin/("my_script.scr");
> > >>             type =3D "script";
> > >>             arch =3D "arm64";
> > >>             compression =3D "none";
> > >>             hash-1 {
> > >>                 algo =3D "sha256";
> > >>             };
> > >>         };
> > >>     };
> > >>=20
> > >>     configurations {
> > >>         default =3D "conf";
> > >>         conf {
> > >>             description =3D "Load my script";
> > >>             script =3D "my-script";
> > >>             signature {
> > >>                 algo =3D "sha256,rsa2048";
> > >>                 key-name-hint =3D "vboot";
> > >>                 sign-images =3D "script";
> > >>             };
> > >>         };
> > >>     };
> > >> };
> > >>=20
> > >> This method is especially useful to pass complex parameters to your =
command.
> > >> This method of course requires commit bcc85b96b5f ("cmd: source: Sup=
port
> > >> specifying config name").
> > >>=20
> > >> Would it be possible to use the above method for your use case?
> > >=20
> > > This method sounds good for some cases, but we have encountered some
> > > problems that prevent us from applying it:
> > >=20
> > > 1. Looks like this method requires access to UART (for typing 'source=
'
> > > command). Open the UART is unsafe at devices with verified boot.
> >=20
> > Generally the idea is that you run source after you run fastboot. E.g. =
you set
> > your altbootcmd (or whatever) to something like
> >=20
> > while true; fastboot 0; source \# || boot; done
> >=20
> > so you try to source whatever gets staged, and boot it otherwise.
>=20
> If I understand right, U-Boot always will try fastboot mode?
> Yes, it seems like it will work. But the code for complex
> fastboot scripts will be complex and difficult to read.
>=20
> I think my version looks more elegant and simple.
>=20
> >=20
> > > 2. We use automation scripts to flash our devices using fastboot
> > > protocol. A typical example of flashing scripts (device is already in
> > > fastboot mode):
> > >=20
> > >   $ fastboot erase bootloader
> > >   $ fastboot stage bootloader.img
> > >   $ fastboot oem board:write_bootloader
> > >=20
> > >   $ fastboot reboot-bootloader
> > >=20
> > >   $ fastboot erase super
> > >   $ fastboot flash super super.bin
> > >=20
> > >   $ fastboot reboot
> > >=20
> > > This method doesn't assume what something typing additional command i=
n
> > > U-Boot shell, even if we have access to UART.
> >=20
> > I'm curious what you actual usage for this is? That is, what do you nee=
d
> > a custom command for.
>=20
> Our SoC vendor use custom scheme for flashing bootloader partition.
> So we can't just use fastbooot flash command - we have to use custom
> flashing logic. We also don't want to use hacks in generic fastboot
> code, for example something like this in _fb_nand_write():
>=20
>   ...
>=20
>   if (!strcmp(part->name, "bootloader"))
>      write_bootloader_custom_logic(...)
>   else
>     nand_write_skip_bad(...)
>=20
>   ...
>=20
> >=20
> > --Sean
> >=20
> > >>=20
> > >> --Sean
> > >>=20
> > >> > This patch
> > >> > introduce new fastboot subcommand fastboot oem board:<cmd>,
> > >> > which allow to run custom oem_board function.
> > >> > =3D
> > >> > Default implementation is __weak. Vendor must redefine it in
> > >> > board/ folder with his own logic.
> > >> >=20
> > >> > For example, some vendors have their custom nand/emmc partition
> > >> > flashing or erasing. Here some typical command for such use cases:
> > >> >=20
> > >> > - flashing:
> > >> >=20
> > >> >   $ fastboot stage bootloader.img
> > >> >   $ fastboot oem board:write_bootloader
> > >> >=20
> > >> > - erasing:
> > >> >=20
> > >> >   $ fastboot oem board:erase_env
> > >> >=20
> > >> > Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> > >> > ---
> > >> >  drivers/fastboot/Kconfig      |  7 +++++++
> > >> >  drivers/fastboot/fb_command.c | 15 +++++++++++++++
> > >> >  include/fastboot.h            |  1 +
> > >> >  3 files changed, 23 insertions(+)
> > >> >=20
> > >> > diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> > >> > index 3cfeea4837..4c955cabab 100644
> > >> > --- a/drivers/fastboot/Kconfig
> > >> > +++ b/drivers/fastboot/Kconfig
> > >> > @@ -241,6 +241,13 @@ config FASTBOOT_OEM_RUN
> > >> >  	  this feature if you are using verified boot, as it will allow =
an
> > >> >  	  attacker to bypass any restrictions you have in place.
> > >> > =20
> > >> > +config FASTBOOT_OEM_BOARD
> > >> > +	bool "Enable the 'oem board' command"
> > >> > +	help
> > >> > +	  This extends the fastboot protocol with an "oem board" command=
. This
> > >> > +	  command allows running vendor custom code defined in board/ fi=
les.
> > >> > +	  Otherwise, it will do nothing and send fastboot fail.
> > >> > +
> > >> >  endif # FASTBOOT
> > >> > =20
> > >> >  endmenu
> > >> > diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_c=
ommand.c
> > >> > index 71cfaec6e9..4d2b451f46 100644
> > >> > --- a/drivers/fastboot/fb_command.c
> > >> > +++ b/drivers/fastboot/fb_command.c
> > >> > @@ -39,6 +39,7 @@ static void reboot_recovery(char *, char *);
> > >> >  static void oem_format(char *, char *);
> > >> >  static void oem_partconf(char *, char *);
> > >> >  static void oem_bootbus(char *, char *);
> > >> > +static void oem_board(char *, char *);
> > >> >  static void run_ucmd(char *, char *);
> > >> >  static void run_acmd(char *, char *);
> > >> > =20
> > >> > @@ -106,6 +107,10 @@ static const struct {
> > >> >  		.command =3D "oem run",
> > >> >  		.dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_OEM_RUN, (run_ucmd), (=
NULL))
> > >> >  	},
> > >> > +	[FASTBOOT_COMMAND_OEM_BOARD] =3D {
> > >> > +		.command =3D "oem board",
> > >> > +		.dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_OEM_BOARD, (oem_board)=
, (NULL))
> > >> > +	},
> > >> >  	[FASTBOOT_COMMAND_UCMD] =3D {
> > >> >  		.command =3D "UCmd",
> > >> >  		.dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_ucmd=
), (NULL))
> > >> > @@ -489,3 +494,13 @@ static void __maybe_unused oem_bootbus(char *=
cmd_parameter, char *response)
> > >> >  	else
> > >> >  		fastboot_okay(NULL, response);
> > >> >  }
> > >> > +
> > >> > +void __weak fastboot_oem_board(char *cmd_parameter, void *data, u=
32 size, char *response)
> > >> > +{
> > >> > +	fastboot_fail("oem board function not defined", response);
> > >> > +}
> > >> > +
> > >> > +static void __maybe_unused oem_board(char *cmd_parameter, char *r=
esponse)
> > >> > +{
> > >> > +	fastboot_oem_board(cmd_parameter, fastboot_buf_addr, image_size,=
 response);
> > >> > +}
> > >> > diff --git a/include/fastboot.h b/include/fastboot.h
> > >> > index 296451f89d..06c1f26b6c 100644
> > >> > --- a/include/fastboot.h
> > >> > +++ b/include/fastboot.h
> > >> > @@ -37,6 +37,7 @@ enum {
> > >> >  	FASTBOOT_COMMAND_OEM_PARTCONF,
> > >> >  	FASTBOOT_COMMAND_OEM_BOOTBUS,
> > >> >  	FASTBOOT_COMMAND_OEM_RUN,
> > >> > +	FASTBOOT_COMMAND_OEM_BOARD,
> > >> >  	FASTBOOT_COMMAND_ACMD,
> > >> >  	FASTBOOT_COMMAND_UCMD,
> > >> >  	FASTBOOT_COMMAND_COUNT
> > >>=20
> > >=20
> >=20
>=20
> --=20
> Thank you,
> Alexey

--=20
Thank you,
Alexey=

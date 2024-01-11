Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C629EC47258
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 13:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4840087B14;
	Thu, 11 Jan 2024 14:08:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="fz2xRM07";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA1C58785F; Thu, 11 Jan 2024 11:14:49 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 259218765B
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 11:14:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 56E8C120005;
 Thu, 11 Jan 2024 13:14:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 56E8C120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1704968086;
 bh=KtF6vuTQqV64DQT8R9CE+ksHgVqEGJ68GMK71X2KfoE=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=fz2xRM07cUzndAGanG3YeKAP4qCj0mgGJUBlAmd/XFGInbvmIVzRnniwztqgsSOcK
 DNa0Oaya53eWv9vqtugTLCfoWBBClxL5GpZylu9foz0YkzMJsbBQHBvOkWnLrU9ox+
 Qf0iJZRjiXPvSJHXulD0QymbscebLnfTxXqyDfz7A2zhk7qW2JVq4qBvpk/D58cMjl
 0QZlbePvaNCmxIkNoI7K1X6PenHJFePNWQ2/U/VkDuUliamhl9QFTFir+06G/tWB7q
 OGP4oC8J8xLoU69HE8eDQu8SctPJmDxueVxTgO4aUyaNmbAZTQ8k0pvFsXg9EH9Opy
 2qYHofLVYoimw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 11 Jan 2024 13:14:46 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 11 Jan 2024 13:14:45 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([fe80::e8ee:cc43:7c6f:7ce0]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::e8ee:cc43:7c6f:7ce0%7]) with
 mapi id 15.02.1118.040; Thu, 11 Jan 2024 13:14:45 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
CC: Sean Anderson <sean.anderson@seco.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "hs@denx.de" <hs@denx.de>, "dimorinny@google.com"
 <dimorinny@google.com>, "patrick.delaunay@foss.st.com"
 <patrick.delaunay@foss.st.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1] fastboot: introduce 'oem board' subcommand
Thread-Topic: [PATCH v1] fastboot: introduce 'oem board' subcommand
Thread-Index: AQHaOaIWePMEMcT2lUeNAWB2040KM7C+tNoAgBJykACAAFjZAIABES8AgAGwMwCAAAbFAA==
Date: Thu, 11 Jan 2024 10:14:45 +0000
Message-ID: <20240111101433.k3sr5nphmerntxdo@cab-wsm-0029881>
References: <20231228152522.83291-1-avromanov@salutedevices.com>
 <a3aea373-80fc-4799-894b-b0879e63da39@seco.com>
 <20240109102746.75iqizxeo6fxq4cu@cab-wsm-0029881>
 <48b16521-f1aa-4f78-ae9d-96832da0da72@seco.com>
 <20240110080332.o24rv45vadrzdsns@cab-wsm-0029881>
 <877ckg6vx9.fsf@baylibre.com>
In-Reply-To: <877ckg6vx9.fsf@baylibre.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.92]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8F9FE18BA347FB4382A4AC34A3CA9ACC@sberdevices.ru>
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
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, docs.u-boot.org:7.1.1;
 smtp.sberdevices.ru:5.0.1,7.1.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 lore.kernel.org:7.1.1; 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1, FromAlignment: s
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

Hi Mattijs,

On Thu, Jan 11, 2024 at 10:50:26AM +0100, Mattijs Korpershoek wrote:
> Hi Alexey, Sean,
>=20
> On mer., janv. 10, 2024 at 08:03, Alexey Romanov <avromanov@salutedevices=
.com> wrote:
>=20
> > Hi,
> >
> > On Tue, Jan 09, 2024 at 10:45:46AM -0500, Sean Anderson wrote:
> >> On 1/9/24 05:27, Alexey Romanov wrote:
> >> > Hello Sean!
> >> >=20
> >> > Thanks for you reply.
> >> >=20
> >> > On Thu, Dec 28, 2023 at 11:45:04AM -0500, Sean Anderson wrote:
> >> >> On 12/28/23 10:25, Alexey Romanov wrote:
> >> >> > Currently, fastboot protocol in U-Boot has no opportunity
> >> >> > to execute vendor custom code with verifed boot.
> >> >>=20
> >> >> Well, I would say the most conventional way to do this would be som=
ething like
> >> >>=20
> >> >> =3D> fastboot 0
> >> >> =3D> source \# CONFIG_FASTBOOT_BUF_ADDR
> >> >>=20
> >> >> and on your host machine,
> >> >>=20
> >> >> $ fastboot stage my_script.itb
> >> >>=20
> >> >> where my_script.its looks like
> >> >>=20
> >> >> /dts-v1/;
> >> >>=20
> >> >> / {
> >> >>     description =3D "my script";
> >> >>     #address-cells =3D <1>;
> >> >>=20
> >> >>     images {
> >> >>         my-script {
> >> >>             data =3D /incbin/("my_script.scr");
> >> >>             type =3D "script";
> >> >>             arch =3D "arm64";
> >> >>             compression =3D "none";
> >> >>             hash-1 {
> >> >>                 algo =3D "sha256";
> >> >>             };
> >> >>         };
> >> >>     };
> >> >>=20
> >> >>     configurations {
> >> >>         default =3D "conf";
> >> >>         conf {
> >> >>             description =3D "Load my script";
> >> >>             script =3D "my-script";
> >> >>             signature {
> >> >>                 algo =3D "sha256,rsa2048";
> >> >>                 key-name-hint =3D "vboot";
> >> >>                 sign-images =3D "script";
> >> >>             };
> >> >>         };
> >> >>     };
> >> >> };
> >> >>=20
> >> >> This method is especially useful to pass complex parameters to your=
 command.
> >> >> This method of course requires commit bcc85b96b5f ("cmd: source: Su=
pport
> >> >> specifying config name").
> >> >>=20
> >> >> Would it be possible to use the above method for your use case?
> >> >=20
> >> > This method sounds good for some cases, but we have encountered some
> >> > problems that prevent us from applying it:
> >> >=20
> >> > 1. Looks like this method requires access to UART (for typing 'sourc=
e'
> >> > command). Open the UART is unsafe at devices with verified boot.
> >>=20
> >> Generally the idea is that you run source after you run fastboot. E.g.=
 you set
> >> your altbootcmd (or whatever) to something like
> >>=20
> >> while true; fastboot 0; source \# || boot; done
> >>=20
> >> so you try to source whatever gets staged, and boot it otherwise.
> >
> > If I understand right, U-Boot always will try fastboot mode?
> > Yes, it seems like it will work. But the code for complex
> > fastboot scripts will be complex and difficult to read.
> >
> > I think my version looks more elegant and simple.
>=20
> I think your solution is elegant, but i'd like to make sure that the
> problem cannot be solved otherwise (via environment changes or other thin=
gs)
>=20
> >
> >>=20
> >> > 2. We use automation scripts to flash our devices using fastboot
> >> > protocol. A typical example of flashing scripts (device is already i=
n
> >> > fastboot mode):
> >> >=20
> >> >   $ fastboot erase bootloader
> >> >   $ fastboot stage bootloader.img
> >> >   $ fastboot oem board:write_bootloader
> >> >=20
> >> >   $ fastboot reboot-bootloader
> >> >=20
> >> >   $ fastboot erase super
> >> >   $ fastboot flash super super.bin
> >> >=20
> >> >   $ fastboot reboot
> >> >=20
> >> > This method doesn't assume what something typing additional command =
in
> >> > U-Boot shell, even if we have access to UART.
> >>=20
> >> I'm curious what you actual usage for this is? That is, what do you ne=
ed
> >> a custom command for.
> >
> > Our SoC vendor use custom scheme for flashing bootloader partition.
> > So we can't just use fastbooot flash command - we have to use custom
> > flashing logic. We also don't want to use hacks in generic fastboot
> > code, for example something like this in _fb_nand_write():
> >
> >   ...
> >
> >   if (!strcmp(part->name, "bootloader"))
> >      write_bootloader_custom_logic(...)
> >   else
> >     nand_write_skip_bad(...)
>=20
> Could you detail what "custom scheme" means?

We have a binary file that is uboot.bin combined with bl2.bin.
This binary file must be written in a special way to the bootloader
partition using helpers from following patchset:

https://lore.kernel.org/all/20231228151421.82746-1-avromanov@salutedevices.=
com/

Our oem board implementation uses these functions with custom vendor flashi=
ng
logic. Something like this:

    ...

    int write_bootloader(offset, partition_name)
    {
        int cpy_num =3D meson_bootloader_copy_num(partition_name);

        for (int i =3D 0; i < cpy_num; i++)
            if (!strcmp(partition_name, BOOT_BL2))
                meson_bootloader_write_bl2(...);
            else
                nand_write_skip_bad(...);

        if (!strcmp(partition_name, BOOT_BL2))
            meson_bootloader_write_info_pages();
    }

    write_bootloader(offset, BOOT_BL2);
    write_bootloader(offset + BL2_SIZE, BOOT_TPL);

    ...

>=20
> Wouldn't using "fastboot_raw_partition_*" be appropriate for your use-cas=
e?
> https://docs.u-boot.org/en/latest/android/fastboot.html#raw-partition-des=
criptors

I'm not sure it will be possible to combine this with our
implementation.

>=20
> I know the above is for mmc but maybe this can be extended for nand ?
>=20
> >
> >   ...
> >
> >>=20
> >> --Sean
> >>=20
> >> >>=20
> >> >> --Sean
> >> >>=20
> >> >> > This patch
> >> >> > introduce new fastboot subcommand fastboot oem board:<cmd>,
> >> >> > which allow to run custom oem_board function.
> >> >> > =3D
> >> >> > Default implementation is __weak. Vendor must redefine it in
> >> >> > board/ folder with his own logic.
> >> >> >=20
> >> >> > For example, some vendors have their custom nand/emmc partition
> >> >> > flashing or erasing. Here some typical command for such use cases=
:
> >> >> >=20
> >> >> > - flashing:
> >> >> >=20
> >> >> >   $ fastboot stage bootloader.img
> >> >> >   $ fastboot oem board:write_bootloader
> >> >> >=20
> >> >> > - erasing:
> >> >> >=20
> >> >> >   $ fastboot oem board:erase_env
> >> >> >=20
> >> >> > Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> >> >> > ---
> >> >> >  drivers/fastboot/Kconfig      |  7 +++++++
> >> >> >  drivers/fastboot/fb_command.c | 15 +++++++++++++++
> >> >> >  include/fastboot.h            |  1 +
> >> >> >  3 files changed, 23 insertions(+)
> >> >> >=20
> >> >> > diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> >> >> > index 3cfeea4837..4c955cabab 100644
> >> >> > --- a/drivers/fastboot/Kconfig
> >> >> > +++ b/drivers/fastboot/Kconfig
> >> >> > @@ -241,6 +241,13 @@ config FASTBOOT_OEM_RUN
> >> >> >  	  this feature if you are using verified boot, as it will allow=
 an
> >> >> >  	  attacker to bypass any restrictions you have in place.
> >> >> > =20
> >> >> > +config FASTBOOT_OEM_BOARD
> >> >> > +	bool "Enable the 'oem board' command"
> >> >> > +	help
> >> >> > +	  This extends the fastboot protocol with an "oem board" comman=
d. This
> >> >> > +	  command allows running vendor custom code defined in board/ f=
iles.
> >> >> > +	  Otherwise, it will do nothing and send fastboot fail.
> >> >> > +
> >> >> >  endif # FASTBOOT
> >> >> > =20
> >> >> >  endmenu
> >> >> > diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_=
command.c
> >> >> > index 71cfaec6e9..4d2b451f46 100644
> >> >> > --- a/drivers/fastboot/fb_command.c
> >> >> > +++ b/drivers/fastboot/fb_command.c
> >> >> > @@ -39,6 +39,7 @@ static void reboot_recovery(char *, char *);
> >> >> >  static void oem_format(char *, char *);
> >> >> >  static void oem_partconf(char *, char *);
> >> >> >  static void oem_bootbus(char *, char *);
> >> >> > +static void oem_board(char *, char *);
> >> >> >  static void run_ucmd(char *, char *);
> >> >> >  static void run_acmd(char *, char *);
> >> >> > =20
> >> >> > @@ -106,6 +107,10 @@ static const struct {
> >> >> >  		.command =3D "oem run",
> >> >> >  		.dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_OEM_RUN, (run_ucmd), =
(NULL))
> >> >> >  	},
> >> >> > +	[FASTBOOT_COMMAND_OEM_BOARD] =3D {
> >> >> > +		.command =3D "oem board",
> >> >> > +		.dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_OEM_BOARD, (oem_board=
), (NULL))
> >> >> > +	},
> >> >> >  	[FASTBOOT_COMMAND_UCMD] =3D {
> >> >> >  		.command =3D "UCmd",
> >> >> >  		.dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_ucm=
d), (NULL))
> >> >> > @@ -489,3 +494,13 @@ static void __maybe_unused oem_bootbus(char =
*cmd_parameter, char *response)
> >> >> >  	else
> >> >> >  		fastboot_okay(NULL, response);
> >> >> >  }
> >> >> > +
> >> >> > +void __weak fastboot_oem_board(char *cmd_parameter, void *data, =
u32 size, char *response)
> >> >> > +{
> >> >> > +	fastboot_fail("oem board function not defined", response);
> >> >> > +}
> >> >> > +
> >> >> > +static void __maybe_unused oem_board(char *cmd_parameter, char *=
response)
> >> >> > +{
> >> >> > +	fastboot_oem_board(cmd_parameter, fastboot_buf_addr, image_size=
, response);
> >> >> > +}
> >> >> > diff --git a/include/fastboot.h b/include/fastboot.h
> >> >> > index 296451f89d..06c1f26b6c 100644
> >> >> > --- a/include/fastboot.h
> >> >> > +++ b/include/fastboot.h
> >> >> > @@ -37,6 +37,7 @@ enum {
> >> >> >  	FASTBOOT_COMMAND_OEM_PARTCONF,
> >> >> >  	FASTBOOT_COMMAND_OEM_BOOTBUS,
> >> >> >  	FASTBOOT_COMMAND_OEM_RUN,
> >> >> > +	FASTBOOT_COMMAND_OEM_BOARD,
> >> >> >  	FASTBOOT_COMMAND_ACMD,
> >> >> >  	FASTBOOT_COMMAND_UCMD,
> >> >> >  	FASTBOOT_COMMAND_COUNT
> >> >>=20
> >> >=20
> >>=20
> >
> > --=20
> > Thank you,
> > Alexey

--=20
Thank you,
Alexey=

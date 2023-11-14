Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574E5C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 10:30:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE83E87440;
	Tue, 14 Nov 2023 11:30:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LxAmqe+b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C978786FBC; Tue, 14 Nov 2023 11:30:49 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60CB987113
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 11:30:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso793404466b.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 02:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699957847; x=1700562647; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gV1HVA7GL3Fv4aYAdDE8D8BWKqMMJyNAKx1ohfh73dk=;
 b=LxAmqe+baY6AJ0NRcBrvpMM1frWFXm9k+sHeXYji1n+o2I7LC4GDvhTAIlJrAUaxyi
 IlHIFIU4Em0/VHY6tdM1ssjbNKVG8eWUbE9fdQtu23gGO7TRHMosyro6b5krklTVahAO
 tn0C5O4eelD+BrpAq7j447ixzLUyJij+IV0UztAo9Xco7YcKwUhmanJXWJl2bu/ASTo9
 nty5kGwVdH+I5eyNjt5Os/DqSRLgPs94nH366DHMtmsfh0yuu3FEiFBYbmULKe85mDIR
 yZWa+Qvkbg3wmtNAUihIX2ovNUtngm1esyGo2DB8vLZLPI7p1Pj8IQAgbj9Nis0k3AvB
 vTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699957847; x=1700562647;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gV1HVA7GL3Fv4aYAdDE8D8BWKqMMJyNAKx1ohfh73dk=;
 b=RtzqUpCjHp52Y1EYYyP0evzk3AlwgcrWGl7K2dz1SggNLVrlGMoB2+1l/Mh1zRswHJ
 ClyOMjPnpAyaOe7IHmJS6W4x0VdphaaIHzybx855m+XK9nswjCfInCWlY75dZ86iEebq
 JS0xX4IBiQ84HMWq9wrTj7tUsBr2SWxJH/glxgBCzqtC7h2sppA/geq0E4R6ydwaPz4S
 zuHSoI/X3NOuKOdQ9g2qGKSTxOfl+SQrsKK4v0oiXRP0tFo5VCi7g94wzQtYK/qMAsLH
 Ip5WIeYhE1oTFRSPLtIlPdsCH9Q1w5Z9+3QXRPCsImKuGEAbOhe0vHrPycpcTzP9G+ce
 273A==
X-Gm-Message-State: AOJu0Yyc1rYi+w1KqHz24sL0w+dzQBnMrLCAS0zdfAOb/BHM4NBrDxs3
 K1dyC/gZE06WPo6cdUBoKWw=
X-Google-Smtp-Source: AGHT+IHYKTBp9yZslAXjDDchqYWgTHcJHIcrxTEOB75HDMW+nq9Z9RpEEbgQZCdzCZn+Sunex93hpg==
X-Received: by 2002:a17:906:ccc2:b0:9d2:63ab:6d4f with SMTP id
 ot2-20020a170906ccc200b009d263ab6d4fmr6658670ejb.55.1699957846591; 
 Tue, 14 Nov 2023 02:30:46 -0800 (PST)
Received: from [127.0.0.1] ([91.204.85.69]) by smtp.gmail.com with ESMTPSA id
 dx5-20020a170906a84500b0099bd1a78ef5sm5309603ejb.74.2023.11.14.02.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 02:30:46 -0800 (PST)
Date: Tue, 14 Nov 2023 12:30:45 +0200
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Ion Agorria <ion@agorria.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Harald Seiler <hws@denx.de>, Sean Anderson <sean.anderson@seco.com>,
 Heiko Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
CC: u-boot@lists.denx.de
Subject: Re: [PATCH v1 5/5] fastboot: add oem console command support
User-Agent: K-9 Mail for Android
In-Reply-To: <87leb0my2z.fsf@baylibre.com>
References: <20231107124241.35432-1-clamor95@gmail.com>
 <20231107124241.35432-6-clamor95@gmail.com> <87leb0my2z.fsf@baylibre.com>
Message-ID: <179F78E6-C7C7-4A0F-908A-64CFDDCB57B0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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



14 =D0=BB=D0=B8=D1=81=D1=82=D0=BE=D0=BF=D0=B0=D0=B4=D0=B0 2023 =D1=80=2E 1=
2:24:52 GMT+02:00, Mattijs Korpershoek <mkorpershoek@baylibre=2Ecom> =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>Hi Svyatoslav,
>
>Thank you for your patch=2E
>
>On mar=2E, nov=2E 07, 2023 at 14:42, Svyatoslav Ryhel <clamor95@gmail=2Ec=
om> wrote:
>
>> From: Ion Agorria <ion@agorria=2Ecom>
>>
>> "oem console" serves to read console record buffer=2E
>>
>> Signed-off-by: Ion Agorria <ion@agorria=2Ecom>
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> ---
>>  doc/android/fastboot=2Erst      |  1 +
>>  drivers/fastboot/Kconfig      |  7 +++++++
>>  drivers/fastboot/fb_command=2Ec | 39 +++++++++++++++++++++++++++++++++=
++
>>  include/fastboot=2Eh            |  1 +
>>  4 files changed, 48 insertions(+)
>>
>> diff --git a/doc/android/fastboot=2Erst b/doc/android/fastboot=2Erst
>> index 1ad8a897c8=2E=2E05d8f77759 100644
>> --- a/doc/android/fastboot=2Erst
>> +++ b/doc/android/fastboot=2Erst
>> @@ -29,6 +29,7 @@ The following OEM commands are supported (if enabled)=
:
>>    with <arg> =3D boot_ack boot_partition
>>  - ``oem bootbus``  - this executes ``mmc bootbus %x %s`` to configure =
eMMC
>>  - ``oem run`` - this executes an arbitrary U-Boot command
>> +- ``oem console`` - this dumps U-Boot console record buffer
>> =20
>>  Support for both eMMC and NAND devices is included=2E
>> =20
>> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
>> index 837c6f1180=2E=2E58b08120a4 100644
>> --- a/drivers/fastboot/Kconfig
>> +++ b/drivers/fastboot/Kconfig
>> @@ -241,6 +241,13 @@ config FASTBOOT_OEM_RUN
>>  	  this feature if you are using verified boot, as it will allow an
>>  	  attacker to bypass any restrictions you have in place=2E
>> =20
>> +config FASTBOOT_CMD_OEM_CONSOLE
>> +	bool "Enable the 'oem console' command"
>> +	depends on CONSOLE_RECORD
>> +	help
>> +	  Add support for the "oem console" command to input and read console
>> +	  record buffer=2E
>> +
>>  endif # FASTBOOT
>> =20
>>  endmenu
>> diff --git a/drivers/fastboot/fb_command=2Ec b/drivers/fastboot/fb_comm=
and=2Ec
>> index 6f621df074=2E=2Eacf5971108 100644
>> --- a/drivers/fastboot/fb_command=2Ec
>> +++ b/drivers/fastboot/fb_command=2Ec
>> @@ -41,6 +41,7 @@ static void reboot_recovery(char *, char *);
>>  static void oem_format(char *, char *);
>>  static void oem_partconf(char *, char *);
>>  static void oem_bootbus(char *, char *);
>> +static void oem_console(char *, char *);
>>  static void run_ucmd(char *, char *);
>>  static void run_acmd(char *, char *);
>> =20
>> @@ -108,6 +109,10 @@ static const struct {
>>  		=2Ecommand =3D "oem run",
>>  		=2Edispatch =3D CONFIG_IS_ENABLED(FASTBOOT_OEM_RUN, (run_ucmd), (NUL=
L))
>>  	},
>> +	[FASTBOOT_COMMAND_OEM_CONSOLE] =3D {
>> +		=2Ecommand =3D "oem console",
>> +		=2Edispatch =3D CONFIG_IS_ENABLED(FASTBOOT_CMD_OEM_CONSOLE, (oem_con=
sole), (NULL))
>> +	},
>>  	[FASTBOOT_COMMAND_UCMD] =3D {
>>  		=2Ecommand =3D "UCmd",
>>  		=2Edispatch =3D CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_ucmd), =
(NULL))
>> @@ -159,6 +164,23 @@ void fastboot_multiresponse(int cmd, char *respons=
e)
>>  	case FASTBOOT_COMMAND_GETVAR:
>>  		fastboot_getvar_all(response);
>>  		break;
>> +#if CONFIG_IS_ENABLED(FASTBOOT_CMD_OEM_CONSOLE)
>
>Checkpatch also complains about this=2E
>
>Can we rewrite this using if (IS_ENABLED(CONFIG=2E=2E=2E)) please ?
>

Please, do not relay on checkpatch that much=2E In this case #ifdef is bet=
ter since in this case all under ifdef will be cut off while using if(=2E=
=2E=2E) requires all code under the if to be able to be run even if config =
is not enabled=2E Thanks=2E

>> +	case FASTBOOT_COMMAND_OEM_CONSOLE:
>> +		char buf[FASTBOOT_RESPONSE_LEN] =3D { 0 };
>> +
>> +		if (console_record_isempty()) {
>> +			console_record_reset();
>> +			fastboot_okay(NULL, response);
>> +		} else {
>> +			int ret =3D console_record_readline(buf, sizeof(buf) - 5);
>> +
>> +			if (ret < 0)
>> +				fastboot_fail("Error reading console", response);
>> +			else
>> +				fastboot_response("INFO", response, "%s", buf);
>> +		}
>> +		break;
>> +#endif
>>  	default:
>>  		fastboot_fail("Unknown multiresponse command", response);
>>  		break;
>> @@ -503,3 +525,20 @@ static void __maybe_unused oem_bootbus(char *cmd_p=
arameter, char *response)
>>  	else
>>  		fastboot_okay(NULL, response);
>>  }
>> +
>> +/**
>> + * oem_console() - Execute the OEM console command
>> + *
>> + * @cmd_parameter: Pointer to command parameter
>> + * @response: Pointer to fastboot response buffer
>> + */
>> +static void __maybe_unused oem_console(char *cmd_parameter, char *resp=
onse)
>> +{
>> +	if (cmd_parameter)
>> +		console_in_puts(cmd_parameter);
>> +
>> +	if (console_record_isempty())
>> +		fastboot_fail("Empty console", response);
>> +	else
>> +		fastboot_response("MORE", response, NULL);
>
>MORE -> TEXT
>
>> +}
>> diff --git a/include/fastboot=2Eh b/include/fastboot=2Eh
>> index d1a2b74b2f=2E=2E23d26fb4be 100644
>> --- a/include/fastboot=2Eh
>> +++ b/include/fastboot=2Eh
>> @@ -37,6 +37,7 @@ enum {
>>  	FASTBOOT_COMMAND_OEM_PARTCONF,
>>  	FASTBOOT_COMMAND_OEM_BOOTBUS,
>>  	FASTBOOT_COMMAND_OEM_RUN,
>> +	FASTBOOT_COMMAND_OEM_CONSOLE,
>>  	FASTBOOT_COMMAND_ACMD,
>>  	FASTBOOT_COMMAND_UCMD,
>>  	FASTBOOT_COMMAND_COUNT
>> --=20
>> 2=2E40=2E1

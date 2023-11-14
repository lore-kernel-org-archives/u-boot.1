Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5627C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 12:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC27686EFA;
	Tue, 14 Nov 2023 13:14:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rSo6yoG8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2E7986758; Tue, 14 Nov 2023 13:14:57 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 865A98727E
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 13:14:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32deb2809daso3277383f8f.3
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 04:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699964093; x=1700568893;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TUE36/FmFxqRQOQC4lidzRkRr+UBRCZXTe91HrevsOM=;
 b=rSo6yoG8E7uh1kj+6ryDoOPVRH7yPIHxYr1GFqvP1BPTGwfJb1gBQU0/7AZ8YK9SYe
 P+VIclqI6wWhFNVZd8os+SvNOuIt5+7pbJGrpeBKjjIaJMoA0vso7Omlswvim+0UXmgk
 o543uRZO7skgjY52RbGnyY/N+8YfsAihOgZXLBvH4k+cbauADWJPrf7hLfa6+9LX8ct0
 ia4t+/FlGkgeCQ3dxEeS2wvPghp+kDvtkjUKnnBZnvjw0e3OdIcdC+FPIKSq9FaObdCN
 Xdwqk54eEpXQxSwQhCvFxqJZWC3/6KRoOuCYcmMgTSRMPtnk3ZTm0XaUiG5jCM9pi0/w
 zwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699964093; x=1700568893;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TUE36/FmFxqRQOQC4lidzRkRr+UBRCZXTe91HrevsOM=;
 b=HWYcv1C4N2/je3orJyTHjW7oM6YfvQpVzlttcQHOjiifAgMKV1mEvG2zcpkqTz1QQn
 gwpJNAcpxg+5ESBZnRF5tPK4PxUwflK0waVgoFEU2uu5yoTeNthNJ5S5qB9ISQJTVHOV
 PAUnEMGd27itTUQiGzl136WcrVNeylMjUtCND0PfQeDJ79akQbPqvww3QhJK1YBDkCPP
 BDHxESK3t+7ufcE1OQPTkeHmtbotF6yrHPCOBVjGIOakqrD8Cp9GJZ64y2zOrRULbUdC
 ytQ+BNHVe0knb/lvGSmbgbu1WLBANIjlJF0hSrGa69QiYGf27rz+0X0m87BJh4q8kN2u
 PazQ==
X-Gm-Message-State: AOJu0YwXzoanrXPAq6zrLMXyz9k2I2ALcuTzqpqn0djN3Tdm2Ibo4Crz
 VBv4JAYz2fbG27DwOv/zqRNpMw==
X-Google-Smtp-Source: AGHT+IFEtIkO8Zpqbn45eMm09Vl6AIp4kN0egZaShCkx6CCSI6rscjQRabcn5q1U6FKNtQnuHHR9HA==
X-Received: by 2002:a5d:4842:0:b0:32d:9e4f:718f with SMTP id
 n2-20020a5d4842000000b0032d9e4f718fmr7009413wrs.44.1699964092695; 
 Tue, 14 Nov 2023 04:14:52 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 o16-20020adfe810000000b0032326908972sm7709579wrm.17.2023.11.14.04.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 04:14:52 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>, Sean
 Anderson <sean.anderson@seco.com>, Heiko Schocher <hs@denx.de>, Dmitrii
 Merkurev <dimorinny@google.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1 5/5] fastboot: add oem console command support
In-Reply-To: <179F78E6-C7C7-4A0F-908A-64CFDDCB57B0@gmail.com>
References: <20231107124241.35432-1-clamor95@gmail.com>
 <20231107124241.35432-6-clamor95@gmail.com> <87leb0my2z.fsf@baylibre.com>
 <179F78E6-C7C7-4A0F-908A-64CFDDCB57B0@gmail.com>
Date: Tue, 14 Nov 2023 13:14:51 +0100
Message-ID: <87il64mszo.fsf@baylibre.com>
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

Hi Svyatoslav,

On mar., nov. 14, 2023 at 12:30, Svyatoslav Ryhel <clamor95@gmail.com> wrot=
e:

> 14 =D0=BB=D0=B8=D1=81=D1=82=D0=BE=D0=BF=D0=B0=D0=B4=D0=B0 2023 =D1=80. 12=
:24:52 GMT+02:00, Mattijs Korpershoek <mkorpershoek@baylibre.com> =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>>Hi Svyatoslav,
>>
>>Thank you for your patch.
>>
>>On mar., nov. 07, 2023 at 14:42, Svyatoslav Ryhel <clamor95@gmail.com> wr=
ote:
>>
>>> From: Ion Agorria <ion@agorria.com>
>>>
>>> "oem console" serves to read console record buffer.
>>>
>>> Signed-off-by: Ion Agorria <ion@agorria.com>
>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>>> ---
>>>  doc/android/fastboot.rst      |  1 +
>>>  drivers/fastboot/Kconfig      |  7 +++++++
>>>  drivers/fastboot/fb_command.c | 39 +++++++++++++++++++++++++++++++++++
>>>  include/fastboot.h            |  1 +
>>>  4 files changed, 48 insertions(+)
>>>
>>> diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
>>> index 1ad8a897c8..05d8f77759 100644
>>> --- a/doc/android/fastboot.rst
>>> +++ b/doc/android/fastboot.rst
>>> @@ -29,6 +29,7 @@ The following OEM commands are supported (if enabled):
>>>    with <arg> =3D boot_ack boot_partition
>>>  - ``oem bootbus``  - this executes ``mmc bootbus %x %s`` to configure =
eMMC
>>>  - ``oem run`` - this executes an arbitrary U-Boot command
>>> +- ``oem console`` - this dumps U-Boot console record buffer
>>>=20=20
>>>  Support for both eMMC and NAND devices is included.
>>>=20=20
>>> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
>>> index 837c6f1180..58b08120a4 100644
>>> --- a/drivers/fastboot/Kconfig
>>> +++ b/drivers/fastboot/Kconfig
>>> @@ -241,6 +241,13 @@ config FASTBOOT_OEM_RUN
>>>  	  this feature if you are using verified boot, as it will allow an
>>>  	  attacker to bypass any restrictions you have in place.
>>>=20=20
>>> +config FASTBOOT_CMD_OEM_CONSOLE
>>> +	bool "Enable the 'oem console' command"
>>> +	depends on CONSOLE_RECORD
>>> +	help
>>> +	  Add support for the "oem console" command to input and read console
>>> +	  record buffer.
>>> +
>>>  endif # FASTBOOT
>>>=20=20
>>>  endmenu
>>> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_comman=
d.c
>>> index 6f621df074..acf5971108 100644
>>> --- a/drivers/fastboot/fb_command.c
>>> +++ b/drivers/fastboot/fb_command.c
>>> @@ -41,6 +41,7 @@ static void reboot_recovery(char *, char *);
>>>  static void oem_format(char *, char *);
>>>  static void oem_partconf(char *, char *);
>>>  static void oem_bootbus(char *, char *);
>>> +static void oem_console(char *, char *);
>>>  static void run_ucmd(char *, char *);
>>>  static void run_acmd(char *, char *);
>>>=20=20
>>> @@ -108,6 +109,10 @@ static const struct {
>>>  		.command =3D "oem run",
>>>  		.dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_OEM_RUN, (run_ucmd), (NULL))
>>>  	},
>>> +	[FASTBOOT_COMMAND_OEM_CONSOLE] =3D {
>>> +		.command =3D "oem console",
>>> +		.dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_CMD_OEM_CONSOLE, (oem_conso=
le), (NULL))
>>> +	},
>>>  	[FASTBOOT_COMMAND_UCMD] =3D {
>>>  		.command =3D "UCmd",
>>>  		.dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_ucmd), (N=
ULL))
>>> @@ -159,6 +164,23 @@ void fastboot_multiresponse(int cmd, char *respons=
e)
>>>  	case FASTBOOT_COMMAND_GETVAR:
>>>  		fastboot_getvar_all(response);
>>>  		break;
>>> +#if CONFIG_IS_ENABLED(FASTBOOT_CMD_OEM_CONSOLE)
>>
>>Checkpatch also complains about this.
>>
>>Can we rewrite this using if (IS_ENABLED(CONFIG...)) please ?
>>
>
> Please, do not relay on checkpatch that much. In this case #ifdef is bett=
er since in this case all under ifdef will be cut off while using if(...) r=
equires all code under the if to be able to be run even if config is not en=
abled. Thanks.

I understand that sometimes, checkpatch generates false positives or bad
suggestions.
I also understand the differences between #ifdef and if (IS_ENABLED()).

I did not measure whether the binary size is bigger when switching from
#ifdef to "if IS_ENABLED()" but I suspect that the compiler can
optimize this out as it's known at compile-time.

This file (and the fastboot code in general) mostly uses
"if (IS_ENABLED())" and to keep the code consistent I recommend using it.

Therefore, can we please use if (IS_ENABLED()) here ?

Thank you

Mattijs

>
>>> +	case FASTBOOT_COMMAND_OEM_CONSOLE:
>>> +		char buf[FASTBOOT_RESPONSE_LEN] =3D { 0 };
>>> +
>>> +		if (console_record_isempty()) {
>>> +			console_record_reset();
>>> +			fastboot_okay(NULL, response);
>>> +		} else {
>>> +			int ret =3D console_record_readline(buf, sizeof(buf) - 5);
>>> +
>>> +			if (ret < 0)
>>> +				fastboot_fail("Error reading console", response);
>>> +			else
>>> +				fastboot_response("INFO", response, "%s", buf);
>>> +		}
>>> +		break;
>>> +#endif
>>>  	default:
>>>  		fastboot_fail("Unknown multiresponse command", response);
>>>  		break;
>>> @@ -503,3 +525,20 @@ static void __maybe_unused oem_bootbus(char *cmd_p=
arameter, char *response)
>>>  	else
>>>  		fastboot_okay(NULL, response);
>>>  }
>>> +
>>> +/**
>>> + * oem_console() - Execute the OEM console command
>>> + *
>>> + * @cmd_parameter: Pointer to command parameter
>>> + * @response: Pointer to fastboot response buffer
>>> + */
>>> +static void __maybe_unused oem_console(char *cmd_parameter, char *resp=
onse)
>>> +{
>>> +	if (cmd_parameter)
>>> +		console_in_puts(cmd_parameter);
>>> +
>>> +	if (console_record_isempty())
>>> +		fastboot_fail("Empty console", response);
>>> +	else
>>> +		fastboot_response("MORE", response, NULL);
>>
>>MORE -> TEXT
>>
>>> +}
>>> diff --git a/include/fastboot.h b/include/fastboot.h
>>> index d1a2b74b2f..23d26fb4be 100644
>>> --- a/include/fastboot.h
>>> +++ b/include/fastboot.h
>>> @@ -37,6 +37,7 @@ enum {
>>>  	FASTBOOT_COMMAND_OEM_PARTCONF,
>>>  	FASTBOOT_COMMAND_OEM_BOOTBUS,
>>>  	FASTBOOT_COMMAND_OEM_RUN,
>>> +	FASTBOOT_COMMAND_OEM_CONSOLE,
>>>  	FASTBOOT_COMMAND_ACMD,
>>>  	FASTBOOT_COMMAND_UCMD,
>>>  	FASTBOOT_COMMAND_COUNT
>>> --=20
>>> 2.40.1

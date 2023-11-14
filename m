Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AF7C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 09:38:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDD03870F6;
	Tue, 14 Nov 2023 10:38:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VKSocG/v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA75E87278; Tue, 14 Nov 2023 10:38:46 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E65A6870F5
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 10:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5441305cbd1so8253240a12.2
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 01:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699954724; x=1700559524; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WAievZ3WimDKUAeStzyFddiOTxVkD7Zeaf5NGHE5vVQ=;
 b=VKSocG/vAf3xLNrbyO6LgLKlKML1TSJuYA0iumAtnfVBO2bIZFl/xa1n4OBmA6xql8
 Ijg5R3TJMOuTEJqEB2DXn3M3DEmL5CNKh+NmkQ+xIXL92uD/98B54LG5vZACZUrjJDAm
 QeUvy9QBopYIn+LWwym7cDAPVABkSsHiAMmAT1rIHsHJG3BiAihKC80q2boOUALQOAqF
 7/xTnS32piYoj1YN+/J30p89UF99XwqQuJxplAcxCP+RcFzYeaB+wgNWa0lcQ7tIH96F
 rYLdiQADj9e+WubODCuWm9UD2U8ZuXguFeAWSNcCR5cNbvgeZTz729t3lcLdogVuKIv2
 hEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699954724; x=1700559524;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WAievZ3WimDKUAeStzyFddiOTxVkD7Zeaf5NGHE5vVQ=;
 b=uay7qJB5RUEeO463tjBpj42JiawHXOU6RowfCcXRCX+O31p5LP2cv/kFb1yiv4xq1c
 Xm3pe8TDVR3kOzfmLyK2YPmyqPE5920p8zYQCtuBzqapPetTmltZuooi9l0Yj2jDy8YV
 JjQZyuxwsbE/cnwU4RkSYOFBFg+GonVNEsPfuVvTUVdmCYvrQoGUv3OQLx29aN1ojLMV
 cKnCQi2vmbj7RwgaETJhfQfXtlmyBGeu7/phW6jCLRM8noxAX/ffzORrx/hK9dIw+WQU
 eMSoyc+SX83eVa2jQ0zZDuIQ4b0YFaeifnZGog8ifmlZ4fqpKfvh/07i6Yvuu+7FiBEr
 yhXA==
X-Gm-Message-State: AOJu0YxZjtnRrdjtTcl4GMiTGGVWbcJ/xn9y6xJhggmWpTPrxplTeoHD
 6hh+LxhEw8hCUvDSmZ924SE=
X-Google-Smtp-Source: AGHT+IEYLXtK5s/+DXMsnf29O2m8Q6uG44nF2orgIrVdnohPGPSSY3njoh3SOi07xY9S8n+67+8WhA==
X-Received: by 2002:aa7:d04a:0:b0:543:7115:eb15 with SMTP id
 n10-20020aa7d04a000000b005437115eb15mr6617595edo.20.1699954724141; 
 Tue, 14 Nov 2023 01:38:44 -0800 (PST)
Received: from [127.0.0.1] ([91.204.85.69]) by smtp.gmail.com with ESMTPSA id
 q29-20020a50cc9d000000b0052ffc2e82f1sm4995274edi.4.2023.11.14.01.38.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 01:38:43 -0800 (PST)
Date: Tue, 14 Nov 2023 11:38:43 +0200
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
Subject: Re: [PATCH v1 2/5] fastboot: implement "getvar all"
User-Agent: K-9 Mail for Android
In-Reply-To: <87pm0cn0i4.fsf@baylibre.com>
References: <20231107124241.35432-1-clamor95@gmail.com>
 <20231107124241.35432-3-clamor95@gmail.com> <87pm0cn0i4.fsf@baylibre.com>
Message-ID: <F2F4770F-E6B4-4BF7-9579-A377A4EB83DE@gmail.com>
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
1:32:35 GMT+02:00, Mattijs Korpershoek <mkorpershoek@baylibre=2Ecom> =D0=BD=
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
>> This commit implements "fastboot getvar all" listing
>> by iterating the existing dispatchers that don't require
>> parameters (as we pass NULL), uses fastboot multiresponse=2E
>>
>> Signed-off-by: Ion Agorria <ion@agorria=2Ecom>
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>
>Some small comments below=2E
>
>With those addressed, please add:
>
>Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre=2Ecom>
>
>> ---
>>  doc/android/fastboot-protocol=2Erst |  3 ++
>>  drivers/fastboot/fb_command=2Ec     |  3 ++
>>  drivers/fastboot/fb_getvar=2Ec      | 75 +++++++++++++++++++++++++----=
--
>>  include/fastboot-internal=2Eh       |  7 +++
>>  4 files changed, 75 insertions(+), 13 deletions(-)
>>
>> diff --git a/doc/android/fastboot-protocol=2Erst b/doc/android/fastboot=
-protocol=2Erst
>> index e8cbd7f24e=2E=2E8bd6d7168f 100644
>> --- a/doc/android/fastboot-protocol=2Erst
>> +++ b/doc/android/fastboot-protocol=2Erst
>> @@ -173,6 +173,9 @@ The various currently defined names are::
>>                        bootloader requiring a signature before
>>                        it will install or boot images=2E
>> =20
>> +  all                 Provides all info from commands above as
>> +                      they were called one by one
>> +
>>  Names starting with a lowercase character are reserved by this
>>  specification=2E  OEM-specific names should not start with lowercase
>>  characters=2E
>> diff --git a/drivers/fastboot/fb_command=2Ec b/drivers/fastboot/fb_comm=
and=2Ec
>> index ab72d8c781=2E=2E6f621df074 100644
>> --- a/drivers/fastboot/fb_command=2Ec
>> +++ b/drivers/fastboot/fb_command=2Ec
>> @@ -156,6 +156,9 @@ int fastboot_handle_command(char *cmd_string, char =
*response)
>>  void fastboot_multiresponse(int cmd, char *response)
>>  {
>>  	switch (cmd) {
>> +	case FASTBOOT_COMMAND_GETVAR:
>> +		fastboot_getvar_all(response);
>> +		break;
>>  	default:
>>  		fastboot_fail("Unknown multiresponse command", response);
>>  		break;
>> diff --git a/drivers/fastboot/fb_getvar=2Ec b/drivers/fastboot/fb_getva=
r=2Ec
>> index 8cb8ffa2c6=2E=2Efc5e1dac87 100644
>> --- a/drivers/fastboot/fb_getvar=2Ec
>> +++ b/drivers/fastboot/fb_getvar=2Ec
>> @@ -29,53 +29,67 @@ static void getvar_is_userspace(char *var_parameter=
, char *response);
>> =20
>>  static const struct {
>>  	const char *variable;
>> +	bool list;
>>  	void (*dispatch)(char *var_parameter, char *response);
>>  } getvar_dispatch[] =3D {
>>  	{
>>  		=2Evariable =3D "version",
>> -		=2Edispatch =3D getvar_version
>> +		=2Edispatch =3D getvar_version,
>> +		=2Elist =3D true,
>>  	}, {
>>  		=2Evariable =3D "version-bootloader",
>> -		=2Edispatch =3D getvar_version_bootloader
>> +		=2Edispatch =3D getvar_version_bootloader,
>> +		=2Elist =3D true
>>  	}, {
>>  		=2Evariable =3D "downloadsize",
>> -		=2Edispatch =3D getvar_downloadsize
>> +		=2Edispatch =3D getvar_downloadsize,
>> +		=2Elist =3D true
>>  	}, {
>>  		=2Evariable =3D "max-download-size",
>> -		=2Edispatch =3D getvar_downloadsize
>> +		=2Edispatch =3D getvar_downloadsize,
>> +		=2Elist =3D true
>>  	}, {
>>  		=2Evariable =3D "serialno",
>> -		=2Edispatch =3D getvar_serialno
>> +		=2Edispatch =3D getvar_serialno,
>> +		=2Elist =3D true
>>  	}, {
>>  		=2Evariable =3D "version-baseband",
>> -		=2Edispatch =3D getvar_version_baseband
>> +		=2Edispatch =3D getvar_version_baseband,
>> +		=2Elist =3D true
>>  	}, {
>>  		=2Evariable =3D "product",
>> -		=2Edispatch =3D getvar_product
>> +		=2Edispatch =3D getvar_product,
>> +		=2Elist =3D true
>>  	}, {
>>  		=2Evariable =3D "platform",
>> -		=2Edispatch =3D getvar_platform
>> +		=2Edispatch =3D getvar_platform,
>> +		=2Elist =3D true
>>  	}, {
>>  		=2Evariable =3D "current-slot",
>> -		=2Edispatch =3D getvar_current_slot
>> +		=2Edispatch =3D getvar_current_slot,
>> +		=2Elist =3D true
>>  #if IS_ENABLED(CONFIG_FASTBOOT_FLASH)
>>  	}, {
>>  		=2Evariable =3D "has-slot",
>> -		=2Edispatch =3D getvar_has_slot
>> +		=2Edispatch =3D getvar_has_slot,
>> +		=2Elist =3D false
>>  #endif
>>  #if IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC)
>>  	}, {
>>  		=2Evariable =3D "partition-type",
>> -		=2Edispatch =3D getvar_partition_type
>> +		=2Edispatch =3D getvar_partition_type,
>> +		=2Elist =3D false
>>  #endif
>>  #if IS_ENABLED(CONFIG_FASTBOOT_FLASH)
>>  	}, {
>>  		=2Evariable =3D "partition-size",
>> -		=2Edispatch =3D getvar_partition_size
>> +		=2Edispatch =3D getvar_partition_size,
>> +		=2Elist =3D false
>>  #endif
>>  	}, {
>>  		=2Evariable =3D "is-userspace",
>> -		=2Edispatch =3D getvar_is_userspace
>> +		=2Edispatch =3D getvar_is_userspace,
>> +		=2Elist =3D true
>>  	}
>>  };
>> =20
>> @@ -237,6 +251,38 @@ static void getvar_is_userspace(char *var_paramete=
r, char *response)
>>  	fastboot_okay("no", response);
>>  }
>> =20
>> +int current_all_dispatch;
>
>static please, as this is only used in drivers/fastboot/fb_getvar=2Ec
>
>> +void fastboot_getvar_all(char *response)
>> +{
>> +	/*
>> +	 * Find a dispatch getvar that can be listed and send
>> +	 * it as INFO until we reach the end=2E
>> +	 */
>> +	while (current_all_dispatch < ARRAY_SIZE(getvar_dispatch)) {
>> +		if (!getvar_dispatch[current_all_dispatch]=2Elist) {
>> +			current_all_dispatch++;
>> +			continue;
>> +		}
>> +
>> +		char envstr[FASTBOOT_RESPONSE_LEN] =3D { 0 };
>> +		getvar_dispatch[current_all_dispatch]=2Edispatch(NULL, envstr);
>
>=2E/scripts/checkpatch=2Epl --strict --u-boot complains a missing line he=
re
>
>> +
>> +		char *envstr_start =3D envstr;
>
>=2E/scripts/checkpatch=2Epl --strict --u-boot complains a missing line he=
re
>

About missing lines, I have intentionally not added them since it does not=
 make reading code harder while having a line-space-line IMHO makes it more=
 unpleasant to read=2E I would like to leave it as is if possible=2E Everyt=
hing else will be adjusted=2E Thanks!

>> +		if (!strncmp("OKAY", envstr, 4) || !strncmp("FAIL", envstr, 4))
>> +			envstr_start +=3D 4;
>> +
>> +		fastboot_response("INFO", response, "%s: %s",
>> +				  getvar_dispatch[current_all_dispatch]=2Evariable,
>> +				  envstr_start);
>> +
>> +		current_all_dispatch++;
>> +		return;
>> +	}
>> +
>> +	fastboot_response("OKAY", response, NULL);
>> +	current_all_dispatch =3D 0;
>> +}
>> +
>>  /**
>>   * fastboot_getvar() - Writes variable indicated by cmd_parameter to r=
esponse=2E
>>   *
>> @@ -254,6 +300,9 @@ void fastboot_getvar(char *cmd_parameter, char *res=
ponse)
>>  {
>>  	if (!cmd_parameter) {
>>  		fastboot_fail("missing var", response);
>> +	} else if (!strncmp("all", cmd_parameter, 3) && strlen(cmd_parameter)=
 =3D=3D 3) {
>> +		current_all_dispatch =3D 0;
>> +		fastboot_response("MORE", response, NULL);
>>  	} else {
>>  #define FASTBOOT_ENV_PREFIX	"fastboot=2E"
>>  		int i;
>> diff --git a/include/fastboot-internal=2Eh b/include/fastboot-internal=
=2Eh
>> index bf2f2b3c89=2E=2E610d4f9141 100644
>> --- a/include/fastboot-internal=2Eh
>> +++ b/include/fastboot-internal=2Eh
>> @@ -18,6 +18,13 @@ extern u32 fastboot_buf_size;
>>   */
>>  extern void (*fastboot_progress_callback)(const char *msg);
>> =20
>> +/**
>> + * fastboot_getvar_all() - Writes current variable being listed from "=
all" to response=2E
>> + *
>> + * @response: Pointer to fastboot response buffer
>> + */
>> +void fastboot_getvar_all(char *response);
>> +
>>  /**
>>   * fastboot_getvar() - Writes variable indicated by cmd_parameter to r=
esponse=2E
>>   *
>> --=20
>> 2=2E40=2E1

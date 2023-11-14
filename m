Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200DFC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 09:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87854870F6;
	Tue, 14 Nov 2023 10:32:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pokObdW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1191870E1; Tue, 14 Nov 2023 10:32:41 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6BD68727E
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 10:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32fb190bf9bso3754861f8f.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 01:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699954357; x=1700559157;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=k3tUFl2nd3sJzz5Nx3nh87mg/N3kfPcurTXU9LYThEU=;
 b=pokObdW6CG9S25Om+pGjtC7Wh4Zuei9ttsmuSyWoaYl/fKls0LLSm9VIJ0gHllKiGS
 7rxipeM6r9DusgKAZRTOM2X0LHvfP6HnDwGTZbXbZHzon99Vlo2qD99cxaIELRMn/BPX
 jz270tAkGhUv5ZMmm90lIByZO/Wh5QBiLlqqnjJQWlJ9hutdMILym+qSFNvR+adAQtG9
 TgOXjzD16SHxVhUl3TMhshxMs1FURSvz9HdCuzYA6jrBKe7AiN300muSYWYsbw0k899P
 Ut9yW1G8QuFcPuQENrHMyTTR27sFyE6dPn8IdLXOzYRJ0uwZhmKrI4SCK38NIQsKlj/K
 kPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699954357; x=1700559157;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k3tUFl2nd3sJzz5Nx3nh87mg/N3kfPcurTXU9LYThEU=;
 b=iSejVOZOw9XIBkeixqWRKDoEUDyHOIxJRrRG0nRnhi/2dUGKQkaESs/hK7nOA6ymcj
 fqbfcI8u9696hLhwu7rgjJwuxzpu+at8Fk27cUjlJX0Bmt8uF1TJdmC3eZeOIb4lmRPY
 GQqBWSoICT3j5XDb+TPHKNescb+EqAh09mrHAVQx5NAAWCJS5HLfEyLdIAq9nw8zyX0b
 v1muG6G7UAJYjUCba4y2JlfxVq30PZCkLUnrZdsSYRlfkkN59KPrS8Fx8LeUzgl3kCis
 B/y6zVsjbGVO0qfnGJ/I+03fq+UBYo7pJcmFUZCFEXBmMojFe+GAsKzg0WD6dqFPH/ap
 3x1w==
X-Gm-Message-State: AOJu0YwGW8D7h5N8gb/eVUT035olfwecMKTKr6I2NfJ0Zobfq4aKTh3T
 N3C0Jg3m5V07jKl9Kbo1uwAhQQ==
X-Google-Smtp-Source: AGHT+IHMr1ub+aOkn3Vviw88DLJA0NoRYbbJuX+6K3kgol1685Gy5gKaSiFPKASot8wJKJZMqHTvWA==
X-Received: by 2002:adf:fbc9:0:b0:32f:76a0:a99b with SMTP id
 d9-20020adffbc9000000b0032f76a0a99bmr1755085wrs.19.1699954357110; 
 Tue, 14 Nov 2023 01:32:37 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 m3-20020adffe43000000b0032d8354fb43sm7285017wrs.76.2023.11.14.01.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 01:32:36 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>, Svyatoslav
 Ryhel <clamor95@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Harald Seiler <hws@denx.de>, Sean Anderson <sean.anderson@seco.com>, Heiko
 Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1 2/5] fastboot: implement "getvar all"
In-Reply-To: <20231107124241.35432-3-clamor95@gmail.com>
References: <20231107124241.35432-1-clamor95@gmail.com>
 <20231107124241.35432-3-clamor95@gmail.com>
Date: Tue, 14 Nov 2023 10:32:35 +0100
Message-ID: <87pm0cn0i4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Thank you for your patch.

On mar., nov. 07, 2023 at 14:42, Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> From: Ion Agorria <ion@agorria.com>
>
> This commit implements "fastboot getvar all" listing
> by iterating the existing dispatchers that don't require
> parameters (as we pass NULL), uses fastboot multiresponse.
>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Some small comments below.

With those addressed, please add:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  doc/android/fastboot-protocol.rst |  3 ++
>  drivers/fastboot/fb_command.c     |  3 ++
>  drivers/fastboot/fb_getvar.c      | 75 +++++++++++++++++++++++++------
>  include/fastboot-internal.h       |  7 +++
>  4 files changed, 75 insertions(+), 13 deletions(-)
>
> diff --git a/doc/android/fastboot-protocol.rst b/doc/android/fastboot-protocol.rst
> index e8cbd7f24e..8bd6d7168f 100644
> --- a/doc/android/fastboot-protocol.rst
> +++ b/doc/android/fastboot-protocol.rst
> @@ -173,6 +173,9 @@ The various currently defined names are::
>                        bootloader requiring a signature before
>                        it will install or boot images.
>  
> +  all                 Provides all info from commands above as
> +                      they were called one by one
> +
>  Names starting with a lowercase character are reserved by this
>  specification.  OEM-specific names should not start with lowercase
>  characters.
> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
> index ab72d8c781..6f621df074 100644
> --- a/drivers/fastboot/fb_command.c
> +++ b/drivers/fastboot/fb_command.c
> @@ -156,6 +156,9 @@ int fastboot_handle_command(char *cmd_string, char *response)
>  void fastboot_multiresponse(int cmd, char *response)
>  {
>  	switch (cmd) {
> +	case FASTBOOT_COMMAND_GETVAR:
> +		fastboot_getvar_all(response);
> +		break;
>  	default:
>  		fastboot_fail("Unknown multiresponse command", response);
>  		break;
> diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
> index 8cb8ffa2c6..fc5e1dac87 100644
> --- a/drivers/fastboot/fb_getvar.c
> +++ b/drivers/fastboot/fb_getvar.c
> @@ -29,53 +29,67 @@ static void getvar_is_userspace(char *var_parameter, char *response);
>  
>  static const struct {
>  	const char *variable;
> +	bool list;
>  	void (*dispatch)(char *var_parameter, char *response);
>  } getvar_dispatch[] = {
>  	{
>  		.variable = "version",
> -		.dispatch = getvar_version
> +		.dispatch = getvar_version,
> +		.list = true,
>  	}, {
>  		.variable = "version-bootloader",
> -		.dispatch = getvar_version_bootloader
> +		.dispatch = getvar_version_bootloader,
> +		.list = true
>  	}, {
>  		.variable = "downloadsize",
> -		.dispatch = getvar_downloadsize
> +		.dispatch = getvar_downloadsize,
> +		.list = true
>  	}, {
>  		.variable = "max-download-size",
> -		.dispatch = getvar_downloadsize
> +		.dispatch = getvar_downloadsize,
> +		.list = true
>  	}, {
>  		.variable = "serialno",
> -		.dispatch = getvar_serialno
> +		.dispatch = getvar_serialno,
> +		.list = true
>  	}, {
>  		.variable = "version-baseband",
> -		.dispatch = getvar_version_baseband
> +		.dispatch = getvar_version_baseband,
> +		.list = true
>  	}, {
>  		.variable = "product",
> -		.dispatch = getvar_product
> +		.dispatch = getvar_product,
> +		.list = true
>  	}, {
>  		.variable = "platform",
> -		.dispatch = getvar_platform
> +		.dispatch = getvar_platform,
> +		.list = true
>  	}, {
>  		.variable = "current-slot",
> -		.dispatch = getvar_current_slot
> +		.dispatch = getvar_current_slot,
> +		.list = true
>  #if IS_ENABLED(CONFIG_FASTBOOT_FLASH)
>  	}, {
>  		.variable = "has-slot",
> -		.dispatch = getvar_has_slot
> +		.dispatch = getvar_has_slot,
> +		.list = false
>  #endif
>  #if IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC)
>  	}, {
>  		.variable = "partition-type",
> -		.dispatch = getvar_partition_type
> +		.dispatch = getvar_partition_type,
> +		.list = false
>  #endif
>  #if IS_ENABLED(CONFIG_FASTBOOT_FLASH)
>  	}, {
>  		.variable = "partition-size",
> -		.dispatch = getvar_partition_size
> +		.dispatch = getvar_partition_size,
> +		.list = false
>  #endif
>  	}, {
>  		.variable = "is-userspace",
> -		.dispatch = getvar_is_userspace
> +		.dispatch = getvar_is_userspace,
> +		.list = true
>  	}
>  };
>  
> @@ -237,6 +251,38 @@ static void getvar_is_userspace(char *var_parameter, char *response)
>  	fastboot_okay("no", response);
>  }
>  
> +int current_all_dispatch;

static please, as this is only used in drivers/fastboot/fb_getvar.c

> +void fastboot_getvar_all(char *response)
> +{
> +	/*
> +	 * Find a dispatch getvar that can be listed and send
> +	 * it as INFO until we reach the end.
> +	 */
> +	while (current_all_dispatch < ARRAY_SIZE(getvar_dispatch)) {
> +		if (!getvar_dispatch[current_all_dispatch].list) {
> +			current_all_dispatch++;
> +			continue;
> +		}
> +
> +		char envstr[FASTBOOT_RESPONSE_LEN] = { 0 };
> +		getvar_dispatch[current_all_dispatch].dispatch(NULL, envstr);

./scripts/checkpatch.pl --strict --u-boot complains a missing line here

> +
> +		char *envstr_start = envstr;

./scripts/checkpatch.pl --strict --u-boot complains a missing line here

> +		if (!strncmp("OKAY", envstr, 4) || !strncmp("FAIL", envstr, 4))
> +			envstr_start += 4;
> +
> +		fastboot_response("INFO", response, "%s: %s",
> +				  getvar_dispatch[current_all_dispatch].variable,
> +				  envstr_start);
> +
> +		current_all_dispatch++;
> +		return;
> +	}
> +
> +	fastboot_response("OKAY", response, NULL);
> +	current_all_dispatch = 0;
> +}
> +
>  /**
>   * fastboot_getvar() - Writes variable indicated by cmd_parameter to response.
>   *
> @@ -254,6 +300,9 @@ void fastboot_getvar(char *cmd_parameter, char *response)
>  {
>  	if (!cmd_parameter) {
>  		fastboot_fail("missing var", response);
> +	} else if (!strncmp("all", cmd_parameter, 3) && strlen(cmd_parameter) == 3) {
> +		current_all_dispatch = 0;
> +		fastboot_response("MORE", response, NULL);
>  	} else {
>  #define FASTBOOT_ENV_PREFIX	"fastboot."
>  		int i;
> diff --git a/include/fastboot-internal.h b/include/fastboot-internal.h
> index bf2f2b3c89..610d4f9141 100644
> --- a/include/fastboot-internal.h
> +++ b/include/fastboot-internal.h
> @@ -18,6 +18,13 @@ extern u32 fastboot_buf_size;
>   */
>  extern void (*fastboot_progress_callback)(const char *msg);
>  
> +/**
> + * fastboot_getvar_all() - Writes current variable being listed from "all" to response.
> + *
> + * @response: Pointer to fastboot response buffer
> + */
> +void fastboot_getvar_all(char *response);
> +
>  /**
>   * fastboot_getvar() - Writes variable indicated by cmd_parameter to response.
>   *
> -- 
> 2.40.1

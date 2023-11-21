Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926F8C61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 13:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9155875F8;
	Tue, 21 Nov 2023 14:53:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cMQ0rcAx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93319875F8; Tue, 21 Nov 2023 14:53:56 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 206C087582
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40b2c9ee8ecso1477045e9.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 05:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700574832; x=1701179632;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1tiJ0QHY9jEZQ9SlVnihYZACVnO4Ay+Gp2Y5mb4QA7A=;
 b=cMQ0rcAxz/s9ZfYbS8nJ/0c9NxuzgD5BkSMkukG4IvW10vQY2QulncLCuXny5bTvz3
 iudYJFMynN7cwdOj5wETEnq6VrnDZHC18TotpDDySI+UiKvlxvkHJxwoctXzsckfXMaq
 W7ryw/z5AMTWzR/8giAWBwTLG7G7/hlZplF62bZlxktGNlGt/36lV93QmYfsPYMJCvb0
 xOECIqfWb1n8CAfoNkDegTqiwjMlwqp3MEW4sIzGn1et5lxhxYwiLluZES21yzuoYeH6
 V+2sTcaNdRR8SLmLktuFRCRAjLFqV2lsuK1lyPI/QYRHp7PzMhuHWHh/hRA6Z0cwkpa2
 pLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700574832; x=1701179632;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1tiJ0QHY9jEZQ9SlVnihYZACVnO4Ay+Gp2Y5mb4QA7A=;
 b=gMvWHDnJORRzIcGLs4T9o4Nj+CWmvE0Q1It2SHKCgtXSVZ6bPTszqyschZwAhLcfDE
 ilGHebuCbRiZGq6hCbM4vdy/VAbxdSbKDc74o0Fxdj9UlACFwUdmRpaL0L0mLRF9bx3Y
 g9+fxpkleL5NCswpaFvJNWLeWx95aJge9XGJVFX3YrDNRl+ApALQ+9e8iFiyeqznkKtu
 xSte76AFvgcIV+biEFGGABICQL/JH5Zwuo1uDcRfgl4FDYwT+rDTcJkUY6CNtSLQY1z6
 DEjLXD+0kFP0bo93nafU3aLYeTusPmz9xYX2dosYG/qpqi31hALu6Fi9SN7iOBANfVE7
 85iA==
X-Gm-Message-State: AOJu0Yy/Z42mPNuBZunZxcellPNhFkuwB1n44bLqs24bRNuZt8NP2qcI
 gX9T7rtK7QOB76OYEAhFu7WmqQ==
X-Google-Smtp-Source: AGHT+IGCJD8O820mdGXgQlZhAtjva3Il74CB2IRxoEgcj9GppGC3uuL9lqEp5dfFUIuvRCns91PtFQ==
X-Received: by 2002:a05:600c:45c4:b0:407:4944:76d1 with SMTP id
 s4-20020a05600c45c400b00407494476d1mr9134909wmo.17.1700574832308; 
 Tue, 21 Nov 2023 05:53:52 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 h20-20020a05600c30d400b004060f0a0fdbsm21106445wmn.41.2023.11.21.05.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 05:53:51 -0800 (PST)
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
Subject: Re: [PATCH v2 2/5] fastboot: implement "getvar all"
In-Reply-To: <20231115153836.16537-3-clamor95@gmail.com>
References: <20231115153836.16537-1-clamor95@gmail.com>
 <20231115153836.16537-3-clamor95@gmail.com>
Date: Tue, 21 Nov 2023 14:53:50 +0100
Message-ID: <87sf4zkya9.fsf@baylibre.com>
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

On mer., nov. 15, 2023 at 17:38, Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> From: Ion Agorria <ion@agorria.com>
>
> This commit implements "fastboot getvar all" listing
> by iterating the existing dispatchers that don't require
> parameters (as we pass NULL), uses fastboot multiresponse.
>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
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
> index 8cb8ffa2c6..0307fdfece 100644
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
> +static int current_all_dispatch;
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

As requested in [1], please resolve the checkpatch errors.
They are reported as WARNING:

WARNING: Missing a blank line after declarations

And the doc states [2] that WARNINGs need a careful review.

Since a respin is needed (because we need to add a stub in [3/5]) could
you please also reorder this to avoid any warnings?

If not, I can do it while applying this to the u-boot-dfu custodian
tree.

Thanks!
Mattijs

[1] https://lore.kernel.org/all/87pm0cn0i4.fsf@baylibre.com/
[2] https://docs.u-boot.org/en/latest/develop/checkpatch.html?highlight=checkpatch#message-levels

> +
> +		char *envstr_start = envstr;
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
> +		fastboot_response(FASTBOOT_MULTIRESPONSE_START, response, NULL);
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

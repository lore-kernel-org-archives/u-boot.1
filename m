Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A35FA375B
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 15:47:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 393D188DB8;
	Fri, 13 Sep 2024 17:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d42n4Vvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D332588DCA; Fri, 13 Sep 2024 17:46:57 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF28588DB8
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 17:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-375e5c12042so1326108f8f.3
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726242415; x=1726847215;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=3lLdMocvAQRNOmBFNjKSPIRGExuP7lKloJuQy/hqTrA=;
 b=d42n4VvfcmxOTPRMtaxeRUTrnOP+oXAFMUIiWozXAGZebE+WR6ZcHskzrF8XRZyscO
 sSRmRzVwPKKmDVmbBIW6aKDEqjOyEaTWZ/IR6RV0R0BrwDQFl8n634Sq4cZuJKLzST8B
 /oJfVrsczOkKY7W4QdbW1/OYWqPEsubdidLjG61jggOrtzcLQKv0ud8Ft3RQtG8uV6c1
 yjq1LUaBmmCoifPVbOHyZJL+2+JFZTBiqxNJXOn22X1R0UHPB13EOWqL92RUUw/0j6IR
 Y9clGNSD9EItQDIpF79Jruye9LnGjAnpE5pP6P6O4Zh8fBiLy/x+Z6P2Zt91jwD0n4mi
 G/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726242415; x=1726847215;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3lLdMocvAQRNOmBFNjKSPIRGExuP7lKloJuQy/hqTrA=;
 b=CeZkip1F7p5WYVSq3vQMrruMGk9YyUA5edDmo+xOhXQ2cO5Y7+z/iIiHtpk6bamJUC
 umx/Y7xAPKw0oykFU9qCOA01ewbCUzG8VL1ov+vtx0F234+yUpM8L4wu7oHEXeQn9hHW
 MRjj/0tim97kodWHTfROcuquF2M3M0w1hf1Yd/76NFMQjg0TXrFB3orOxk2w41sZPVlc
 oUG+7afywBEUBVVHJFV6RUqUDM77od4VrBIE9TX8cpS5s6kKGou/0guVlUUA+5cWgjdE
 lr/TjaWtd+UicnB1wYKK3QNSL/iTLfNgh9ypNgTAhnl0D1/po39UQmUNuSEmCXZSrxje
 64NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF7blcSQAI6E2ZKvEK0X+bfCn6kEDfvHUDPKO89kOHFKS+c758JfEScn5MlE9NiiffN2gspfA=@lists.denx.de
X-Gm-Message-State: AOJu0YwZxRMrygV/k4Wo8MUlQeYu9Ou+mir9Xp98v3POadv2VPHUrKFB
 WBOW0pyIsokeMnsgjeJwHr/6hf/E70SJnEFic3WQpcyTcGpJezmtqRH32E4sMug=
X-Google-Smtp-Source: AGHT+IEoi22sj9m99gJHWAvXv4m2Ycplf5tTTiOBqtC+kekrH1h0KwwV4WPbMO6D/fK/Tpn8d8f3+g==
X-Received: by 2002:a05:6000:1561:b0:374:93c4:2f61 with SMTP id
 ffacd0b85a97d-378c2cfecaamr5665177f8f.5.1726242414258; 
 Fri, 13 Sep 2024 08:46:54 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956653d1sm17336142f8f.33.2024.09.13.08.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:46:53 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH] dfu: define a callback function for the dfu_alt_info
 environment variable
In-Reply-To: <20240911133900.1444083-1-rasmus.villemoes@prevas.dk>
References: <20240911133900.1444083-1-rasmus.villemoes@prevas.dk>
Date: Fri, 13 Sep 2024 17:46:52 +0200
Message-ID: <87v7yzk13n.fsf@baylibre.com>
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

Hi Rasmus,

Thank you for the patch.

On mer., sept. 11, 2024 at 15:39, Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:

> I'm trying to use dfu-util for bootstrapping an stm32mp board. It
> mostly works fine, but something goes horribly wrong as soon as I make
> use of the ability to run arbitrary u-boot shell commands. The shell
> commands themselves work fine, but the heuristic "dfu_alt_info may
> have changed, we have to reinit" seems to cause the board and/or my
> host machine to go into some bad state, and further dfu-util commands
> fail.
>
> U-Boot already has a mechanism whereby C code can be told about
> changes to specific environment variables. So instead of always doing
> re-init, add a hook to the dfu_alt_info variable so that we only do
> set dfu_reinit_needed if the commands actually did modify that
> variable.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/dfu/dfu.c      | 16 ++++++++++++++++
>  drivers/dfu/dfu_mmc.c  |  3 ++-
>  include/dfu.h          |  1 +
>  include/env_callback.h |  7 +++++++
>  4 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
> index 540d48fab77..7a4d7ba2a7f 100644
> --- a/drivers/dfu/dfu.c
> +++ b/drivers/dfu/dfu.c
> @@ -27,6 +27,21 @@ static unsigned long dfu_timeout = 0;
>  #endif
>  
>  bool dfu_reinit_needed = false;
> +bool dfu_alt_info_changed = false;
> +
> +static int on_dfu_alt_info(const char *name, const char *value, enum env_op op,
> +			   int flags)
> +{
> +	switch (op) {
> +	case env_op_create:
> +	case env_op_overwrite:
> +	case env_op_delete:
> +		dfu_alt_info_changed = true;
> +		break;
> +	}
> +	return 0;
> +}
> +U_BOOT_ENV_CALLBACK(dfu_alt_info, on_dfu_alt_info);
>  
>  /*
>   * The purpose of the dfu_flush_callback() function is to
> @@ -152,6 +167,7 @@ int dfu_init_env_entities(char *interface, char *devstr)
>  	int ret = 0;
>  
>  	dfu_reinit_needed = false;
> +	dfu_alt_info_changed = false;
>  
>  #ifdef CONFIG_SET_DFU_ALT_INFO
>  	set_dfu_alt_info(interface, devstr);
> diff --git a/drivers/dfu/dfu_mmc.c b/drivers/dfu/dfu_mmc.c
> index 8f7ecfa8fc7..c19eb919388 100644
> --- a/drivers/dfu/dfu_mmc.c
> +++ b/drivers/dfu/dfu_mmc.c
> @@ -232,7 +232,8 @@ int dfu_flush_medium_mmc(struct dfu_entity *dfu)
>  		break;
>  	case DFU_SCRIPT:
>  		/* script may have changed the dfu_alt_info */
> -		dfu_reinit_needed = true;
> +		if (dfu_alt_info_changed)
> +			dfu_reinit_needed = true;
>  		break;
>  	case DFU_RAW_ADDR:
>  	case DFU_SKIP:
> diff --git a/include/dfu.h b/include/dfu.h
> index 6c5431b3948..e25588c33cb 100644
> --- a/include/dfu.h
> +++ b/include/dfu.h
> @@ -517,6 +517,7 @@ static inline int dfu_fill_entity_virt(struct dfu_entity *dfu, char *devstr,
>  #endif
>  
>  extern bool dfu_reinit_needed;
> +extern bool dfu_alt_info_changed;
>  
>  #if CONFIG_IS_ENABLED(DFU_WRITE_ALT)
>  /**
> diff --git a/include/env_callback.h b/include/env_callback.h
> index 8e500aaaf80..66cc8309e71 100644
> --- a/include/env_callback.h
> +++ b/include/env_callback.h
> @@ -69,6 +69,12 @@
>  #define BOOTSTD_CALLBACK
>  #endif
>  
> +#ifdef CONFIG_DFU
> +#define DFU_CALLBACK "dfu_alt_info:dfu_alt_info,"
> +#else
> +#define DFU_CALLBACK
> +#endif
> +
>  /*
>   * This list of callback bindings is static, but may be overridden by defining
>   * a new association in the ".callbacks" environment variable.
> @@ -79,6 +85,7 @@
>  	NET_CALLBACKS \
>  	NET6_CALLBACKS \
>  	BOOTSTD_CALLBACK \
> +	DFU_CALLBACK \
>  	"loadaddr:loadaddr," \
>  	SILENT_CALLBACK \
>  	"stdin:console,stdout:console,stderr:console," \
> -- 
> 2.46.0

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F939D711BD
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 15:52:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2CDB892DE;
	Wed, 20 Nov 2024 16:52:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uMRwJB89";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1019A8932B; Wed, 20 Nov 2024 16:52:01 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F4A1890BC
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 16:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a99f646ff1bso1041472866b.2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 07:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732117916; x=1732722716; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=46LMCmJ3Ik6bnmUXJF6Gz8zYHaCioKXHRUddbYYHTW0=;
 b=uMRwJB89fyTxocgJ3cvT/M/Bk3HCa3qPRThB2A2vLfLEmqulbyKaK8thdbguxIrQ6D
 ZETr1SXVaHzeYDzmRvONs88PcV/ovgxUGjC3NNNe4Mqv7dPq1RycqZa6BCBsr9s0lo+X
 /EL2ZYWEGCiSXET58XZqOSNAtAqmSK8y8LPMfQk8Ti/JWLxgnIfi3qjqCBZ4s2H8cnJR
 +MR87DiHh1zET61eOFclYaSnyn8SHZDiqKVM3hwsyTZDb2FGlbEM8K1+Qr1MMjR6Vpz/
 abMbY8cRNQynupFN0Su6wApPkvL79Rn3GNZLclc6OfScr5nsRYekJequTNnwZe+BiOWw
 2+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732117916; x=1732722716;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=46LMCmJ3Ik6bnmUXJF6Gz8zYHaCioKXHRUddbYYHTW0=;
 b=mqPTYAFXf9HZyiuDAuQOdgoXddURZrCgCOW+Eiq+fVmRlhMuZULizZulJZ75G6vjYO
 EPbO0tYrBY2gHVA4Bktp15tYBsCqKAxG4DOwrC7r2ICQ3v3yHuw7lpTRjZsgOLvWj3A1
 OJ/05ecBm4J/nuWxyxn+qTLJ3mEtgy0bU2TocbOhERishQZxdBJ1Vurajvbl9eehdftm
 /VXVdPKyD/VTWVsVsME9N/Mns4THYMMqiAhzVLBl4S1qJum/8NBTygVV5SrQfeGbhAJR
 OZVnSWsvRwYKDen0glb0UxGeH/cFCbVQcVYB3fRMGYN9ILQfVqzd1ACoErzgEoGfBHlx
 aeOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlIFm8zX8vYe4oXC6T9kkAHxPL62EJwDYQ3iEfq7Klw+ITOO6ui5XI4bV+ZaChMSIjWAsq7Ko=@lists.denx.de
X-Gm-Message-State: AOJu0YyoEhXg+xlati1mvMh3a06WCZ3rwvbkh9TSMtJlESXDzcz8j1RL
 qDf2GjhIpGoRGz1SEWkyEYcV9hH7Xjq3FtoB6YvNfW766rMM27vyrAfLK5RsHwY=
X-Google-Smtp-Source: AGHT+IEPLMt52443vVnQ/9QiVPliWxUqY1EiWnGQeMIJbSlVTVUVqzuyAbXvEbDtQ2XMCzrGlRDCpw==
X-Received: by 2002:a17:907:705:b0:aa1:e181:f211 with SMTP id
 a640c23a62f3a-aa4dd562fbbmr348037766b.18.1732117916592; 
 Wed, 20 Nov 2024 07:51:56 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20df50a14sm797658866b.64.2024.11.20.07.51.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 07:51:56 -0800 (PST)
Message-ID: <460f478d-62cc-4f17-8d52-00d2e1e83485@linaro.org>
Date: Wed, 20 Nov 2024 16:51:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] common: Move autoprobe out to board init
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>
Cc: Svyatoslav <clamor95@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
References: <20241120153642.861633-1-sjg@chromium.org>
 <20241120153642.861633-4-sjg@chromium.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241120153642.861633-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Simon, Marex,

On 20/11/2024 16:36, Simon Glass wrote:
> Rather than doing autoprobe within the driver model code, move it out to
> the board-init code. This makes it clear that it is a separate step from
> binding devices.
> 
> For now this is always done twice, before and after relocation, but we
> should discuss whether it might be possible to drop the post-relocation
> probe.
> 
> For boards with SPL, the autoprobe is still done there as well.
> 
> Note that with this change, autoprobe happens after the
> EVT_DM_POST_INIT_R/F events are sent, rather than before.
> 
> Link: https://lore.kernel.org/u-boot/20240626235717.272219-1-marex@denx.de/
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---

[...]

> +For some platforms, certain devices must be probed to get the platform into
> +a working state. To help with this, drivers marked with DM_FLAG_PROBE_AFTER_BIND

I've found the documentation around this flag lacking, and the
implementation confusing. Here you say /drivers/ with this flag (which
would imply I can add it to the U_BOOT_DRIVER() definition, but further
below the function doc says /device/ with this flag.

In practise, it seems like the flag has to be added to the device in the
bind() function, and adding it to the driver definition doesn't work
(this left me scrataching my head for a while). The commit message
adding it explains this and it seems like the idea was to have a way to
trigger probing a device from the .bind() callback.

I don't think I'm the only one confused by this, since grepping for it
reveals two watchdog drivers which set this on their U_BOOT_DRIVER()
definition.

I can only see one driver that ever enables this flag conditionally,
that's the ARM PSCI driver. Every other user sets it unconditionally in
the .bind() callback.

Would it make sense to rework this into a driver flag?

Otherwise, could you document this behaviour more explicitly in this series?

Kind regards,

> +will be probed immediately after all devices are bound. For now, this happens in
> +SPL, before relocation and after relocation. See the call to ``dm_autoprobe()``
> +for where this is done.
> +
> +The auto-probe feature is tricky because it bypasses the normal ordering of
> +probing. General, if device A (e.g. video) needs device B (e.g. clock), then
> +A's probe() method uses ``clk_get_by_index()`` and B is probed before A. But
> +A is only probed when it is used. Therefore care should be taken when using
> +auto-probe, limiting it to devices which truly are essential, such as power
> +domains or critical clocks.
> +
> +See here for more discussion of this feature:
> +
> +:Link: https://patchwork.ozlabs.org/project/uboot/patch/20240626235717.272219-1-marex@denx.de/
> +
>  Running stage
>  ^^^^^^^^^^^^^
>  
> diff --git a/drivers/core/root.c b/drivers/core/root.c
> index 2d4f078f97f..045f8fcda65 100644
> --- a/drivers/core/root.c
> +++ b/drivers/core/root.c
> @@ -281,6 +281,15 @@ void *dm_priv_to_rw(void *priv)
>  }
>  #endif
>  
> +/**
> + * dm_probe_devices() - Check whether to probe a device and all children
> + *
> + * Probes the device if DM_FLAG_PROBE_AFTER_BIND is enabled for it. Then scans
> + * all its children recursively to do the same.
> + *
> + * @dev: Device to (maybe) probe
> + * Return 0 if OK, -ve on error
> + */
>  static int dm_probe_devices(struct udevice *dev)
>  {
>  	struct udevice *child;
> @@ -299,6 +308,17 @@ static int dm_probe_devices(struct udevice *dev)
>  	return 0;
>  }
>  
> +int dm_autoprobe(void)
> +{
> +	int ret;
> +
> +	ret = dm_probe_devices(gd->dm_root);
> +	if (ret)
> +		return log_msg_ret("pro", ret);
> +
> +	return 0;
> +}
> +
>  /**
>   * dm_scan() - Scan tables to bind devices
>   *
> @@ -331,7 +351,7 @@ static int dm_scan(bool pre_reloc_only)
>  	if (ret)
>  		return ret;
>  
> -	return dm_probe_devices(gd->dm_root);
> +	return 0;
>  }
>  
>  int dm_init_and_scan(bool pre_reloc_only)
> diff --git a/include/dm/root.h b/include/dm/root.h
> index b2f30a842f5..a71a2ebef85 100644
> --- a/include/dm/root.h
> +++ b/include/dm/root.h
> @@ -136,6 +136,21 @@ int dm_scan_other(bool pre_reloc_only);
>   */
>  int dm_init_and_scan(bool pre_reloc_only);
>  
> +/**
> + * dm_autoprobe() - Probe devices which are marked for probe-after-bind
> + *
> + * This probes all devices with a DM_FLAG_PROBE_AFTER_BIND flag. It checks the
> + * entire tree, so parent nodes need not have the flag set.
> + *
> + * It recursively probes parent nodes, so they do not need to have the flag
> + * set themselves. Since parents are always probed before children, if a child
> + * has the flag set, then its parent (and any devices up the chain to the root
> + * device) will be probed too.
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +int dm_autoprobe(void);
> +
>  /**
>   * dm_init() - Initialise Driver Model structures
>   *

-- 
// Caleb (they/them)


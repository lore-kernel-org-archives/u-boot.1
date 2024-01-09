Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F5BC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 14:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B28F1877FD;
	Tue,  9 Jan 2024 15:29:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SNd4+cp1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E990F87902; Tue,  9 Jan 2024 15:29:39 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76DA4877FA
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 15:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-336c9acec03so2895851f8f.2
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 06:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704810576; x=1705415376;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=66jQDCRtZqevghi5u/yWd7i64gD8dZDebV3kpyuIqE0=;
 b=SNd4+cp1TUUL/TIX8N+szgKvbn3ujpyyXHhSmsuQYbgLu2tIm4EWC/HcJP4P4boQ7u
 W49qnxn0nQVkqOX7mW5pkiXDu8slyBW42Xb6pWDSfzHhNX/o9/+bJ+tscwzuV3NpJ1bT
 c1eR60NjJFiGabjcnKWVUFS7QeQTKTb0zDC+xZYbihwYfDn62RojxpmGqp8dYk2gBOUP
 gmL9EZ5EVPmwU5onZjTER5WbJ9xLf+xYcfYMeMpxZIqhZw8M2AemWoIbe5pL03lrghTh
 l8WDnV6Kc2WBKNkYKvLpmomsYq9cKnK/xF5AMNbSkJGj3dUdG42CmiyhmufvuCAlp5cw
 5s2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704810576; x=1705415376;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=66jQDCRtZqevghi5u/yWd7i64gD8dZDebV3kpyuIqE0=;
 b=BMzvUD+VU46evjU3NyV/73A/fM1G7/acMawM2zHIM9b7/c+1RYl6RdprxnnMKL2agX
 fhQrRjrSY1HebNIowhD00RTFEnwZYzPvwWBdoebTWQuUUjBvjbKVHaccoNjeUIkdBpcb
 g8v/c37r2OEy0rid3nj+585jXixdDh1WMVq+U3c+SdID/xsjHpXj5iMRc0mIRBqypi1/
 sVWOSixC0KbPd/HrAwt6vX23K9zbjFPOHMU/9pxFlLSVmoR1Q3uZKbbZ1qO/x+r3sQ3j
 kvCH38zCRXRoHVf3zOeyxuCS3iMijFDfCwlNtaXt80RdJJRp2xQY93wbu+xQU99HIKvY
 GxbQ==
X-Gm-Message-State: AOJu0YxHL35EPiqit0AqDuK99SmYqEmlYgR+sGAZk67wOIq/HTguiiS+
 w2lxNJ85HJtp/QWQl32eRIKfZNKl4zRXS15+10hmOnwQEZI=
X-Google-Smtp-Source: AGHT+IGJouOCKfsIbKTQs6HXAtp36Yf0lMAOMz9o/RnPB6t/VeqjuamXbbqFlrDTkjokC7HmLdckNA==
X-Received: by 2002:a05:6000:cc8:b0:336:1aef:7352 with SMTP id
 dq8-20020a0560000cc800b003361aef7352mr584098wrb.109.1704810575857; 
 Tue, 09 Jan 2024 06:29:35 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 l1-20020a05600012c100b00336670abdcasm2573592wrx.40.2024.01.09.06.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 06:29:35 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Manorit Chawdhry <m-chawdhry@ti.com>
Subject: Re: [PATCH 2/2] include: env: ti: add default for
 do_main_cpsw0_qsgmii_phyinit
In-Reply-To: <20240108-b4-upstream-fix-semicolon-v1-2-9437b3dc90ea@ti.com>
References: <20240108-b4-upstream-fix-semicolon-v1-0-9437b3dc90ea@ti.com>
 <20240108-b4-upstream-fix-semicolon-v1-2-9437b3dc90ea@ti.com>
Date: Tue, 09 Jan 2024 15:29:34 +0100
Message-ID: <87frz6wpf5.fsf@baylibre.com>
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

Hi Manorit,

Thank you for the patch.

On lun., janv. 08, 2024 at 13:48, Manorit Chawdhry <m-chawdhry@ti.com> wrote:

> By default this variable is unset and this causes the test condition to
> fail on devices that don't have this defined. Set a default value for
> this.
>
>    => boot
>    ## Error: "main_cpsw0_qsgmii_phyinit" not defined
>    [...]
>
> Fixes: 0d72b0f2f83b ("include: env: ti: ti_common: Run main_cpsw0_qsgmii_phyinit conditionally")
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  include/env/ti/ti_common.env | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
> index 5473f633aa7d..02b410c3adc4 100644
> --- a/include/env/ti/ti_common.env
> +++ b/include/env/ti/ti_common.env
> @@ -22,6 +22,7 @@ get_fit_overlaystring=
>  	done;
>  get_fit_config=setexpr name_fit_config gsub / _ conf-${fdtfile}
>  run_fit=run get_fit_config; bootm ${addr_fit}#${name_fit_config}${overlaystring}
> +do_main_cpsw0_qsgmii_phyinit=0
>  bootcmd_ti_mmc=
>  	run findfdt; run init_${boot};
>  #if CONFIG_CMD_REMOTEPROC
>
> -- 
> 2.43.0

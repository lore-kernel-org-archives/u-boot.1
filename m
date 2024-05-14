Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C460CC04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 13:00:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32D72880A7;
	Tue, 14 May 2024 15:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fj1SNhiV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DCF1880A7; Tue, 14 May 2024 15:00:56 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82D1888304
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 15:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2e564cad1f1so47651511fa.0
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 06:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715691652; x=1716296452;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=OJ0jXnRT97WygL6HxtSEZTPFvVAqN2wPPVHotWY3OS8=;
 b=fj1SNhiVVQ9DUOxOzEpyH6YviM7W9IYsEsvdy0zm+Lklnix6qsUdApv5HbBwFC8NO3
 xv+t9i4zXKGpWb+zQ5e0K+uqKt+05440BUunCRETBrm8TR8IwOw9hqdCHZ34UUkONnAf
 t0WpMWBTPC3kQYeP1KEhnLw2zsrgm/iDpxzzvPWOPdSXClhZvksXjP9tJ2bCfpqq1RsG
 iMSEIUE1/iAl229/GPlB6ze7xiTavwRevdUYmDSWjQIyn+rDB6DF+MUbM4SeNC+JR4MI
 sAr4e5fAe4TIogoBuRELFL8NrESZ2qxKJYaFAv7J7bPiLkTjFKOkm7CDJhjjNMnSjmK7
 nxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715691652; x=1716296452;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OJ0jXnRT97WygL6HxtSEZTPFvVAqN2wPPVHotWY3OS8=;
 b=v+TUAEwKb5k9glyyjAsnTC3Jl5XjfIJnTv6MTpuSxBtRP8JyA2tLxphg8bFUkLJmh9
 +9YAarBDy8v11Lu+IXVKIiSfN2MGLk/YQowtt1ShU2JWTqwPFIykCtUxcpnXwXUYXEiX
 NuCZm7q6JMZIt57q9C7qJyyqNSI7qW43rjtDkNpV474RYB47aokTaIP+iCh/Aw/yB0bj
 RfB9C0N6R8YywwUr7WIIuY0KIGtCaxskqU1gzqY//Wi95caF1wLmHuZ3kL0tOoIZahK2
 dhapF5Ap96uyuxpRymMhQ1Q1bYJINeCzGSXRVb8pQ42reDZB/BZhmL5jkhdnAscWX/rV
 fFSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoXykv6koOnO5blCWOErqR04RJ/VEjBJfdKgm3IlRpgUOVzaoeURSqVYRulbEgZaOQkSiNqpuiwacvHGe8oCr3I/Kh4g==
X-Gm-Message-State: AOJu0YzeMp+gBRgPe9ZopRP5sm/O2V2vNs9yitl7DgKVV7HXc1AWGvNI
 E80gvNojBJcHdqqGS5OSB15XjQcZFhwbIHmeOBmsAmDpz9Rng5Zu7vh0njFoAhQ=
X-Google-Smtp-Source: AGHT+IHpIViy73XTIpnlxFNP314thyRvMVwWZY+tzjAm0LEGa5BiDaoVGb55ZL461WzNey1uH8nMcA==
X-Received: by 2002:a05:651c:14f:b0:2df:eee9:c71f with SMTP id
 38308e7fff4ca-2e51fc36881mr74976561fa.7.1715691651762; 
 Tue, 14 May 2024 06:00:51 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-420193b0903sm55907575e9.47.2024.05.14.06.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 06:00:50 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>, u-boot@lists.denx.de
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>, Marek Vasut
 <marex@denx.de>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Nishanth Menon
 <nm@ti.com>, Sjoerd Simons <sjoerd@collabora.com>, Janusz Dziedzic
 <januszx.dziedzic@intel.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH 5/6] usb: dwc3: gadget: properly check ep cmd
In-Reply-To: <20240412202611.3565052-6-alexander.sverdlin@siemens.com>
References: <20240412202611.3565052-1-alexander.sverdlin@siemens.com>
 <20240412202611.3565052-6-alexander.sverdlin@siemens.com>
Date: Tue, 14 May 2024 15:00:48 +0200
Message-ID: <87r0e44kfz.fsf@baylibre.com>
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

Hi Alexander,

Thank you for the patch.

On ven., avril 12, 2024 at 22:26, "A. Sverdlin" <alexander.sverdlin@siemens.com> wrote:

> From: Felipe Balbi <felipe.balbi@linux.intel.com>
>
> Upstream Linux commit 5999914f227b.
>
> The cmd argument we pass to
> dwc3_send_gadget_ep_cmd() could contain extra
> arguments embedded. When checking for StartTransfer
> command, we need to make sure to match only lower 4
> bits which contain the actual command and ignore the
> rest.
>
> Reported-by: Janusz Dziedzic <januszx.dziedzic@intel.com>
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> [A. Sverdlin: cherry-picked only DWC3_DEPCMD_CMD() define]
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/dwc3/core.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 1e7eda89a34c9..7709ab793f36d 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -405,6 +405,8 @@
>  #define DWC3_DEPCMD_SETTRANSFRESOURCE	(0x02 << 0)
>  #define DWC3_DEPCMD_SETEPCONFIG		(0x01 << 0)
>  
> +#define DWC3_DEPCMD_CMD(x)		((x) & 0xf)
> +
>  /* The EP number goes 0..31 so ep0 is always out and ep1 is always in */
>  #define DWC3_DALEPENA_EP(n)		(1 << n)
>  
> -- 
> 2.44.0

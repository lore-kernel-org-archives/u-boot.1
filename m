Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731D9C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 08:49:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEE6587F6F;
	Tue, 20 Feb 2024 09:49:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q8gpwhq4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D67E87F88; Tue, 20 Feb 2024 09:49:33 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A315B87F1F
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 09:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a34c5ca2537so663117566b.0
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 00:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708418967; x=1709023767; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N3vsrnUic6rkR+ZQyCDkb8Qk5auCLUffNYRU+wK6mHY=;
 b=Q8gpwhq4xGR/vTIdiG8o9Fu9vr8x2eZCWlpr944NrIhRnYIA9RQLGF70YcEk41QeA1
 bpR+UFUpbccKTcEtPz81x8xuuW/5aRyJY/ISULLif1gcTjdRKF+gckHtWUhnIzV6txJc
 T5cyXSZHFcid0HDnPhmacfCXU07KlVEdLVHn5q7fyzMaakywbENxeJZcEQjIYtCBmQsW
 az5tVDtl2juWnjjxTcgOiDQ+CayR1h5rCNYKaRitZOiDz+392Gfy2d5t/wTD9/OHavdD
 vNIjBxOe1I39GOMo22RMlJZCGacVPHzqWjtza3xXjXR1VNZcI3fE3qhtFF8NPtibct1K
 qF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708418967; x=1709023767;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N3vsrnUic6rkR+ZQyCDkb8Qk5auCLUffNYRU+wK6mHY=;
 b=fXTBezyOy4VVD4CK4qaz5KOXSzh/ZCX/QqAjY2HFGRb6WRlTYrbw/bv+HtBw3FUXyK
 Zn13hAFoa901iQEdwNkiafdk+yRx+Lks4wLfySyHxIUv2SgyIJ+JOA19dCK2bMk8h+mB
 EOY7s1XIsfpKloNZm0/OV7CdhrdKoVaogneK+PHbYBpRpTZ83TyogLVxx4oEu5i6zegv
 ueBfjOZwF/fZnbvwl754EUWBxp6BWAM/3NtXrE2Gsr7dObWry9DoFYF+vneYX92EgmqF
 luy9Om8qBfiwEbV1+RNKQsxKqt+S8JwJ0bu2GgspvXZo76z5QNO7olMGr2+OoDtTC88N
 Z7Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNHB+L7quNaPpayPPPGt6FZwOvBoWJnXKh6UrGOtaqYzZegXO45akukmJYDn0NNLeJWLOSCCSHrkz7cPn/KRwmtfNj3A==
X-Gm-Message-State: AOJu0Yyv+n00aM3L07WL334Nwra/fgE4PcZqyh1h1RJIyUSp4nQvLgLJ
 uu103tpjcX6HFlIMqNfKvQHZksTH/bNSiCy7ncqxCSZpjpJiS4ygfTQ4ogU1pz0=
X-Google-Smtp-Source: AGHT+IG+n+lplBYWbHSqKuCaOeEkqotAWBl+NE8L2SS9AA9+WDd5Bj8HxeJydRdBunUKcai0uR9NnQ==
X-Received: by 2002:a17:906:8cf:b0:a3e:aadd:f962 with SMTP id
 o15-20020a17090608cf00b00a3eaaddf962mr2976962eje.62.1708418966816; 
 Tue, 20 Feb 2024 00:49:26 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 vi10-20020a170907d40a00b00a3e7713dcbesm2255333ejc.39.2024.02.20.00.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:49:26 -0800 (PST)
Date: Tue, 20 Feb 2024 11:49:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Frieder Schrempf <frieder@fris.de>, Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Christian Hewitt <christianshewitt@gmail.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tianling Shen <cnsztl@gmail.com>
Subject: Re: [PATCH v3 2/3] board: Add support for Sielaff i.MX6 Solo board
Message-ID: <232c2a37-4266-41d6-a806-4d807a11c41e@moroto.mountain>
References: <20240215133527.216126-1-frieder@fris.de>
 <20240215133527.216126-2-frieder@fris.de>
 <1a3b311d-0f5d-4f2e-a9f7-da0ec0c4f60b@moroto.mountain>
 <847f8bd9-000b-4005-b6e3-2075b72191d0@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <847f8bd9-000b-4005-b6e3-2075b72191d0@kontron.de>
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

On Tue, Feb 20, 2024 at 09:38:01AM +0100, Frieder Schrempf wrote:
> Hi Dan,
> 
> On 20.02.24 06:56, Dan Carpenter wrote:
> > On Thu, Feb 15, 2024 at 02:35:20PM +0100, Frieder Schrempf wrote:
> >> +int board_mmc_getcd(struct mmc *mmc)
> > 
> > This function is never called.  Also for bool functions make them type
> > bool and name them so that it's clear they return true/false such as
> > board_mmc_getcd_was_successful() but less wordy.
> 
> What makes you think so? This is an implementation for the existing
> prototype from mmc.h. As far as I can see this is called by the mmc
> driver and I can't change it in any way.
> 

Ah, yes.  You're right.  My bad.

regards,
dan carpenter


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B000C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 12:45:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B5CB87D9B;
	Wed, 24 Jan 2024 13:42:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dEl+E5M/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACE1187C1F; Wed, 24 Jan 2024 09:32:36 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD13B87C15
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 09:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-337cf4ac600so4840916f8f.3
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 00:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706085152; x=1706689952; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xm/5XAn9JbuQrfAWz3XAmqWWEzAc6hZj8INErSeSDXE=;
 b=dEl+E5M/JHaDtIarG52ZG8jxB1e9oJPFJCEOlF7o3NUtWRJye5YgZThXO7yBK6MWnq
 D+Pk59soIZ4VjvCuWFIuzkD3RjK2f6IGB1VhntqSShNNNCII29PT6H0FlewD6AnB6wd7
 WdpAqeQAiu8pHU5U119cjtGzbqVZDh04WUPVLJ28m+uhc78r/jMQVJGM52VcXh5t+gJ+
 TZTPoX0nm+XLIweMVpPEmpWtAfQL4EqBjeR4fRx3Uone+XtLFo+0WF4167F63ll7+ou7
 GM2HrURplpm1P/OauFtdH4ywMilO/iT57roFfOhgPQrXJufjqZEXZ2bd4CYPNAMB/2U+
 spJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706085152; x=1706689952;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xm/5XAn9JbuQrfAWz3XAmqWWEzAc6hZj8INErSeSDXE=;
 b=j53w4Ze5ryvXgYuZgWJ0Lh/9WFAXfnz0LlU6WvBpZo4xsipMTejzkhs5YBYB6DnfFN
 lNEsQb6MwQfr/PL5hk0UY/F/9ZOI6mCZiOiMFjxu1b3pDykvJVsMT1DJCvXtGTG6JLUn
 YxrA0jphIHfbSHYWu4XM0cjlrgexAGuPzic8feh3qgsorxHadJ9Jko0AjX2Zo+RKS3rB
 0VTLzxSm8Rsh59uyprAajgGNz9+jEt+6zT3MQFbsnq/AFW+qWncjuVWthtZX4uS+Lm6T
 3+AA9qvK4dVbLR6fN6zI4/Rb5RWoW6T9bUzkrHvZKjO4Xx0U+aTkbLEdboqPUaN1Ck8o
 Zxbw==
X-Gm-Message-State: AOJu0Yyo3GlsSSXM422ae+Py5zsL4oLKcT+txyX0JfoxU+xxNnajrGlS
 O7aF3qjiUfeFgTgKMLSF6eidTkMYQw63X0lizJSv7D2J3+nyzCBkirFeLTj6tdY=
X-Google-Smtp-Source: AGHT+IHn9KVZvpyW+qpg50qt02DOX1phmMuShA5wCEgltaEZjnpa6UkuCGJzER5FIHyJr1UlsK7gLg==
X-Received: by 2002:a05:600c:501e:b0:40e:a370:35dc with SMTP id
 n30-20020a05600c501e00b0040ea37035dcmr886297wmr.119.1706085152076; 
 Wed, 24 Jan 2024 00:32:32 -0800 (PST)
Received: from localhost ([102.140.209.237]) by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c3b9200b0040e4ca7fcb4sm45232790wms.37.2024.01.24.00.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 00:32:31 -0800 (PST)
Date: Wed, 24 Jan 2024 11:32:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>,
 Bryan Brattlof <bb@ti.com>, Sean Anderson <seanga2@gmail.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, FUKAUMI Naoki <naoki@radxa.com>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Hai Pham <hai.pham.ud@renesas.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Kever Yang <kever.yang@rock-chips.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, u-boot@lists.denx.de,
 srk@ti.com, r-gunasekaran@ti.com
Subject: Re: [RFC PATCH v3 14/15] board: ti: am65x: Add check for
 k3-am654-icssg2 in board_fit_config_match()
Message-ID: <da700f89-31d5-437b-b173-d57e53329bcc@moroto.mountain>
References: <20240124064930.1787929-1-danishanwar@ti.com>
 <20240124064930.1787929-15-danishanwar@ti.com>
 <6017b04a-ec47-49a8-9bac-720137c0d13e@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6017b04a-ec47-49a8-9bac-720137c0d13e@moroto.mountain>
X-Mailman-Approved-At: Wed, 24 Jan 2024 13:42:05 +0100
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

On Wed, Jan 24, 2024 at 11:27:12AM +0300, Dan Carpenter wrote:
> On Wed, Jan 24, 2024 at 12:19:29PM +0530, MD Danish Anwar wrote:
> > When CONFIG_TI_ICSSG_PRUETH is enabled, add config name check for the
> > icssg2 overlay in board_fit_config_match() API.
> > 
> > Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> > ---
> >  board/ti/am65x/evm.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/board/ti/am65x/evm.c b/board/ti/am65x/evm.c
> > index df209021c1..0b661f0084 100644
> > --- a/board/ti/am65x/evm.c
> > +++ b/board/ti/am65x/evm.c
> > @@ -90,10 +90,13 @@ int dram_init_banksize(void)
> >  #ifdef CONFIG_SPL_LOAD_FIT
> >  int board_fit_config_name_match(const char *name)
> >  {
> > -#ifdef CONFIG_TARGET_AM654_A53_EVM
> > -	if (!strcmp(name, "k3-am654-base-board"))
> > -		return 0;
> > -#endif
> > +	if (IS_ENABLED(CONFIG_TI_ICSSG_PRUETH)) {
> > +		if (!strcmp(name, "k3-am654-icssg2"))
> > +			return 0;
> > +	} else {
> > +		if (!strcmp(name, "k3-am654-base-board"))
> > +			return 0;
> > +	}
> >  
> >  	return -1;
> >  }
> 
> It probably should support both configs being enabled.
> 
> 	if (IS_ENABLED(CONFIG_TI_ICSSG_PRUETH) &&
> 	    strcmp(name, "k3-am654-icssg2") == 0)
> 		return 0;
> 
> 	if (IS_ENABLED(TARGET_AM654_A53_EVM) &&
> 	    strcmp(name, "k3-am654-base-board"))

I reversed this strcmp()...

	strcmp(name, "k3-am654-base-board") == 0)

regards,
dan carpenter


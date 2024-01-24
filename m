Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38904C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 12:45:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9EB987D91;
	Wed, 24 Jan 2024 13:42:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x9SExKru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36CF087C09; Wed, 24 Jan 2024 09:27:27 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0932B87C33
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 09:27:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2cd1232a2c7so69736791fa.0
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 00:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706084837; x=1706689637; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8hNZoqOMWq1AV7y50RuNgXSzJV2OutETWA8X3pr0upk=;
 b=x9SExKruTfmQ17JEkH1KmbxY/gvjE++HzFWCepGtlG3FHoPyvGKE6pfIKgOR1uP3kE
 VjKZ3t1TLnSvcvRJGjhyXE8znQK99oOXbaxh6/Iw8Q/Ca6b8fbRfTbPS65K8FeggLB7a
 BFzY/FtJ75sVurNEIi89xEqUuE+LOlwZ+lDBo6CYpNxqRJg1urrb1HapUNR9Bk/uGRZo
 SZnencBVwQXXsm5UIWSLiR/n81GgDxlm5MSARiX9jWC+hEZ7PqI9/I62A6cH0EepZVqH
 vTX6NFCJz6O1jCmSqlPmCU2VFJde9vNZ33AKhJy2QKdY9CQgdWPkrEj5/lv4dKYljNWF
 sg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706084837; x=1706689637;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8hNZoqOMWq1AV7y50RuNgXSzJV2OutETWA8X3pr0upk=;
 b=hKdV7AseffoS4RMyGrIO53p3LPrf6aIA/aJUF7UXWIsknVbDXE5GSJmTV9KRCpFEAN
 E0dYtlSWgL5Buws82pdeoPZiARP+iVySoIfN68RDUsTqrUd5baiP8pCyX6KTY7o5IZiq
 2aRH16Sv8LPpk8UTkjJfc7wqXtlEADADj6XjHH2FpDcMEXuOK+w7iNMdjRug3DN6khNK
 5GjjkuMx8O9TgEWh3dsPvph2y8EAl+sZDMXAtsqCKyY/vJk1CDgo4S/lOeUZ0MezioTx
 xIQew+PkxXgbtNggBpiRzCsssbbFxWnsfQDppqcizwWWC8NY4YkmSekzD4QapoeoRRdp
 i6PQ==
X-Gm-Message-State: AOJu0YwrO7H7F7Lf680u+OKoLJxh+hDD/7bF8q4zRPaAde0Dk/Xnfxh7
 zNHtf+yfzQUGKS7Wi7u76eMWh4QUkx85WuMPm063V9ZiYR1u/aDlQYv9LZDABJ0=
X-Google-Smtp-Source: AGHT+IGl0Kf6U9rf7YV0+OBKZuUL5JOmt0St6NyEGh1kxfuWglrF0z7vgESDdjWzh8OVMLgtIEHOng==
X-Received: by 2002:a2e:a608:0:b0:2cd:7a4b:9a3 with SMTP id
 v8-20020a2ea608000000b002cd7a4b09a3mr534350ljp.16.1706084837268; 
 Wed, 24 Jan 2024 00:27:17 -0800 (PST)
Received: from localhost ([102.140.209.237]) by smtp.gmail.com with ESMTPSA id
 w6-20020adfee46000000b00337cf4a20c6sm15553418wro.31.2024.01.24.00.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 00:27:16 -0800 (PST)
Date: Wed, 24 Jan 2024 11:27:12 +0300
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
Message-ID: <6017b04a-ec47-49a8-9bac-720137c0d13e@moroto.mountain>
References: <20240124064930.1787929-1-danishanwar@ti.com>
 <20240124064930.1787929-15-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124064930.1787929-15-danishanwar@ti.com>
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

On Wed, Jan 24, 2024 at 12:19:29PM +0530, MD Danish Anwar wrote:
> When CONFIG_TI_ICSSG_PRUETH is enabled, add config name check for the
> icssg2 overlay in board_fit_config_match() API.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  board/ti/am65x/evm.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/board/ti/am65x/evm.c b/board/ti/am65x/evm.c
> index df209021c1..0b661f0084 100644
> --- a/board/ti/am65x/evm.c
> +++ b/board/ti/am65x/evm.c
> @@ -90,10 +90,13 @@ int dram_init_banksize(void)
>  #ifdef CONFIG_SPL_LOAD_FIT
>  int board_fit_config_name_match(const char *name)
>  {
> -#ifdef CONFIG_TARGET_AM654_A53_EVM
> -	if (!strcmp(name, "k3-am654-base-board"))
> -		return 0;
> -#endif
> +	if (IS_ENABLED(CONFIG_TI_ICSSG_PRUETH)) {
> +		if (!strcmp(name, "k3-am654-icssg2"))
> +			return 0;
> +	} else {
> +		if (!strcmp(name, "k3-am654-base-board"))
> +			return 0;
> +	}
>  
>  	return -1;
>  }

It probably should support both configs being enabled.

	if (IS_ENABLED(CONFIG_TI_ICSSG_PRUETH) &&
	    strcmp(name, "k3-am654-icssg2") == 0)
		return 0;

	if (IS_ENABLED(TARGET_AM654_A53_EVM) &&
	    strcmp(name, "k3-am654-base-board"))
		return 0;

	return -1;

regards,
dan carpenter

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493B8C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 13:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 817568715C;
	Thu,  9 Nov 2023 14:37:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nC/ideV+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FF76870BE; Thu,  9 Nov 2023 14:37:38 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67FDF871DA
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 14:37:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-77891f362cfso72432185a.1
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 05:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699537054; x=1700141854; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qfoulZu4fnorpFHKChndym5f7QKB+uhZHLEbk1htOh0=;
 b=nC/ideV+OZPBE6jyUaKh74lTsJdtevKcbBK2P5lfr2GnIe+tF6tPdtAWhNQeWEwI5f
 3iUYaZVZx8GrDsDo6GfD84Mb7p3TYokscUx6/AzLPe24Bn9kNWoupzItmmb/yMVCwHrg
 IIA+Z/FKqssId3X8rm9Olk1lmyk/4Ghy1gxJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699537054; x=1700141854;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qfoulZu4fnorpFHKChndym5f7QKB+uhZHLEbk1htOh0=;
 b=ZYjiWWqrI/mEt3QZOGMnlAJ0rY5k45qM9p9LceY4tcS/NG4Ead/yDV+kTQ5YKBHaCM
 w+XCDYFwBLDDMQWHInMb6I0q4pr2kWNSWF/1b6fAQ5hgJ8Uw6bDW++V2jIQGtTinY8Ho
 yOrDTh4Kgrqj+2TFOSVpzr0pdvFAGXeKdRX6qCyoKOz6VlKgyY0bGy/GFbyuXcuvL2Ha
 efDY+p5CIvpj3gBc3ZktFt7AZ/CDjzA047kp3beLrkRCmSrMxMH+hNSpx0eJ4xqsQe/2
 yNoz4Q/HTUWOIA4VuFbLdR3I0Y1NtaIIgbzxw/4NV2wLAXO+PE6BGcXsN/VkC5vNUB1W
 WKpg==
X-Gm-Message-State: AOJu0YyzPZ5Hg4Lkp1+db1McNV2hGgUQMZbEWwhZgLzr/9iQkLvO5ROR
 Hd+DTkhO7V4VIUyyqXu+gRaEjw==
X-Google-Smtp-Source: AGHT+IE0aCBPWDgfu4LCFahYOn0MJa/3H5LZqd0JveqOlOp573uR4U5ew+V4ztWtlEVMrBY3imoUjg==
X-Received: by 2002:a05:620a:4150:b0:779:e19b:64f5 with SMTP id
 k16-20020a05620a415000b00779e19b64f5mr12599830qko.21.1699537054184; 
 Thu, 09 Nov 2023 05:37:34 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-58a3-ea36-c2a1-60cb.res6.spectrum.com.
 [2603:6081:7b00:6400:58a3:ea36:c2a1:60cb])
 by smtp.gmail.com with ESMTPSA id
 d26-20020a05620a141a00b007788bb0ab8esm2023735qkj.19.2023.11.09.05.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 05:37:33 -0800 (PST)
Date: Thu, 9 Nov 2023 08:37:31 -0500
From: Tom Rini <trini@konsulko.com>
To: Francis Laniel <francis.laniel@amarulasolutions.com>
Cc: u-boot@lists.denx.de,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v11 08/24] cli: Port Busybox 2021 hush to U-Boot
Message-ID: <20231109133731.GC6601@bill-the-cat>
References: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
 <20231107214121.132079-9-francis.laniel@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pCZBdRHZMkYY9tKM"
Content-Disposition: inline
In-Reply-To: <20231107214121.132079-9-francis.laniel@amarulasolutions.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--pCZBdRHZMkYY9tKM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 11:41:05PM +0200, Francis Laniel wrote:

> Adds new file cli_hush_2021.c, it is a copy of Busybox hush file as it wa=
s of
> time to commit 37460f5da.

I'm not sure where best to say this in the series so I'll try here. I
think we should name the hush.c file being imported from busybox as
"cli_hush_upstream.c" and the u-boot glue file around it as
"cli_hush_modern.c". Then instead of "CLI_HUSH_2021" etc,
"CLI_HUSH_MODERN" and then in due time, we drop CLI_HUSH_OLD and rename
CLI_HUSH_MODERN to CLI_HUSH.

> This commit modifies Busybox hush to not compile some part specific to Bu=
sybox
> and adds some code needed by U-Boot.
> The modifications consists mainly on adding code #if(n)def guards.

This patch is also where we should make the one line removal of
"# undef CONFIG_FEATURE_SH_STANDALONE" from the upstream file, for CI.

--=20
Tom

--pCZBdRHZMkYY9tKM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVM4JsACgkQFHw5/5Y0
tywl2gv/Z7jhYkyPXfHIanb7saeMNPvWHihgBJtaH0FzuBMgiyHdKrD8Iq/T4zct
LRlARQE+gyWAOGf78lGm89XjSrjamb/82zXG5QrB6GFySSQttBTOCLysA4vR3ytG
Z9AWa8Qi6TrvZRi6S+i7zVNpH6TFJjv6w3CeWcfSa3DcYfq3EJEmEouBAZRex4ZL
YIDIWJX3ymAhNNm2dUWqxPupBwoBAWDyXdedBgnJniGQZM7iwS1Px/Cpd3JI0AWR
eYXtXbNStoAtT3g8sBmBrDv8cT6fcGmJ5Ak/gmOYj7ddvFBx3THTNQWZzjtu1IPh
JbYyMLlj+6MYzp+edYj87Ipty+4pmlaet/4qmn8OcQWwrwUg2+ARsbARvjWSGHIr
Ft+P5jNecCGoVodKnGb72jKxJkUFCTjLbuwkVBnsa42o7nG8UEtTbAAdiDVidAI/
ZxYD+UzywuRpc/I4jY6MUBE/SgQtR1sipCfqNAxvpmst5tTUel49Ue0tIxeockRK
V2yuglcR
=ijDz
-----END PGP SIGNATURE-----

--pCZBdRHZMkYY9tKM--

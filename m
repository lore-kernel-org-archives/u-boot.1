Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9BAC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 07:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A315388C94;
	Thu,  2 May 2024 09:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Rp8ihbVu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9063B88C67; Thu,  2 May 2024 09:04:01 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB4C088C94
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 09:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41c7ac73fddso34640535e9.3
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 00:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714633438; x=1715238238;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d8GXK+JdvAEX0QOm2hOgRVKxNCi+YT2ZwIrvKEOezys=;
 b=Rp8ihbVumsgbOHE/YVgzYHVunShGUR7EF7cv8FRMJGdj3f4p4xbLRUlBS4n5nilFll
 jtS8kAKiw00bO1olldwFVe2VqRhtiWD4wCSCmX8sRsmvoEXkymlEZVM/HpKLCBtUeQwt
 gq/py43SDagqG1ruRDYRMNasdTqnBrwZcl377sAI33tduh2k0/Tq/0o82LvzvxpTul36
 DrKRrDybpJ7lCwwWkK2JXF8fJoIPwKRlZmPTiTao+CXeqf84vB1zG1oO98bPBhFQ0Jbr
 MoHcIskeEYbXaNahcZH+KIjMTRIDMGStx9IHcvMuzD0tHSaIp51XnMbyQAdgdFkoXc6G
 /OBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714633438; x=1715238238;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d8GXK+JdvAEX0QOm2hOgRVKxNCi+YT2ZwIrvKEOezys=;
 b=q/RMcKPX7e0/zYEH3DOFKDcmZVgZPFDsyz9c7VtpY6+qLuYUWaTujerbEzhB15GWGH
 q67gKsLUYQ0GA1kths90R4/NL4w//9nFZCRdcS34hvMsPf0saI51VQf+7gJk59+9MLWL
 +NcrwKJPd8eINbDmj0iN12iqG1MrWHbnGzbCO2d8ZmKZhfNC/SH5dG9XQtZSaqyu+NDE
 n678augCQ3RRY2vEJkyxY9T/JNJOQ2N45SMxBqERU1jC/VNEgpdYmQYwL6OOKZGJzAcL
 9PSMLUvn0zII0Gvkhp4o8kQ/zf0iAg7/q3inN4ada1nXG3+nWTsPZ74RTflJgCamXZ9j
 Ds2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTHX+NcrOeNh4klesWVXS/QFDvF1ciiJ2loDOa8OUngdvnKLfRgIkGxrULJLyBD6xRwgC7X4HAvxAzdu0tj6wqUHGlqQ==
X-Gm-Message-State: AOJu0YzxtPgD3zyrfPm2MGcnf4mV7r3e8RIVweQRB4bxbOAoN6moES8n
 PNh7o0yuiQt+pCZsos0h8dItcjKn+4vsd1IfIZ//TLEwcIzHChtO8UtbOXxCDGY=
X-Google-Smtp-Source: AGHT+IHeWkq9xKyUQn6FzyYFSZlJ4oktSjnCWvInzYtf2eX+Orp6TcbtCgJUnOulYDey0LnAbIQyAw==
X-Received: by 2002:a05:600c:1c03:b0:41c:23f3:65fa with SMTP id
 j3-20020a05600c1c0300b0041c23f365famr4028172wms.28.1714633437914; 
 Thu, 02 May 2024 00:03:57 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 s11-20020a05600c45cb00b00419f572671dsm861517wmo.20.2024.05.02.00.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 00:03:56 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Martyn Welch <martyn.welch@collabora.com>, Sjoerd Simons
 <sjoerd@collabora.com>, u-boot@lists.denx.de
Cc: Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>, Kunihiko
 Hayashi <hayashi.kunihiko@socionext.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 1/7] usb: dwc3: Add dwc3 glue driver for am62
In-Reply-To: <4fe368c01c937e93d7f634ffd7c02d99964d1f57.camel@collabora.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-2-sjoerd@collabora.com>
 <87ply14lxq.fsf@baylibre.com>
 <4fe368c01c937e93d7f634ffd7c02d99964d1f57.camel@collabora.com>
Date: Thu, 02 May 2024 09:03:52 +0200
Message-ID: <8734r066g7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Martyn,

On mer., mai 01, 2024 at 14:56, Martyn Welch <martyn.welch@collabora.com> w=
rote:

> On Tue, 2024-01-16 at 11:22 +0100, Mattijs Korpershoek wrote:
>> > +	/* Program PHY PLL refclk by reading syscon property */
>> > +	ret =3D regmap_update_bits(syscon, args.args[0],
>> > PHY_PLL_REFCLK_MASK, rate_code);
>> > +	if (ret) {
>>=20
>> The doc of ofnode_parse_phandle_with_args() states that:
>>=20
>> =C2=A0* Caller is responsible to call of_node_put() on the returned
>> out_args->np
>> =C2=A0* pointer.
>>=20
>> Should we call of_node_put(args->np); before returning here?
>>=20
>
> It doesn't seem that this is done in U-Boot as the definition of
> of_node_put() here is:
>
>    /* Dummy functions to mirror Linux. These are not used in U-Boot */
>    #define of_node_get(x) (x)
>    static inline void of_node_put(const struct device_node *np) { }

Indeed, thank you for looking into this.

In that case,

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> Martyn
>
>> Should the cleanup be done in case of success as well?
>>=20
>> With that fixed:
>>=20
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>=20

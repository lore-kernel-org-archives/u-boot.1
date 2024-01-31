Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2CDC47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 11:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48E9F87B1D;
	Wed, 31 Jan 2024 12:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o1NaPcmT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A241D87C13; Wed, 31 Jan 2024 12:49:25 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9197C87751
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 12:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d066b532f0so8608981fa.1
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 03:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706701763; x=1707306563; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nq3EHH6QY9lH7V0rZ+WIRJ/LCYlvS4/wtlruKn2iDaA=;
 b=o1NaPcmTQle7PsrRZBm8Pm3NesH6aW/jOp2/h0AVO4S+z7ofMth0Gs/B+5ZguurU4O
 aoo7O87yCnI9UdlORrKirTCxnKDIeydQRx4e3gFUzNGUmIFYWwc5Tf68IqUwZ+pKAJBx
 XrhstCfRQgrG7Fuf1Xw2VU/T9y4Ead0dHPH6Ed3YDoJYroC0cjEYLVbm9wU3qBSUP8AL
 3ANUaMDiRTr8zeIALtf1GiI1ShwdBiY6Wt22bDhhxfbg6cLpVur2VwgqsNEYuFfxm0+P
 nonBuXX+ef91sDVY0wdo+w7qa3IIBnr31L5uvstpET+0MzQxv+gTSsAObgNxg6dzTaUw
 xyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706701763; x=1707306563;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nq3EHH6QY9lH7V0rZ+WIRJ/LCYlvS4/wtlruKn2iDaA=;
 b=KTPpGGffdOUVUiP5aBWBw7uBv4ZJGdIjwB36hoz6ZO5vBFsWcrafgakbJu1OoNUjH5
 HmsFcUeuCrc/rXqXRI4bDjZwen3uwSCp1SdNBJ9LgpFeOfLxOaGCKrUiVKPgP4tgkbgX
 GCDF15TVIoCIqKGn4PXIj2TMhiFyDBEVKgkljwAT7GcjWOn17gL2lV9dwkMQadTiYa78
 CufWGthxa0h392nipAMXKhTgG4NECXMLp6gpZwgBvfqtFImGMJrdtKLQvGMJPJ693vcb
 yRX9kaFZw70SeL0AluztEABSGzTLINZyymYC/+z5Q6DK77e+ibYyiU1KOB5+YhUtdOi7
 qFrQ==
X-Gm-Message-State: AOJu0YzVDHVWiVLp4/W9iZq5TcGwbIXZVT3X5j/p+rZeBpp1LLFhR78x
 8EykRUFEYqOOzbJCOoYrsSz9/3fk7HoWXoS5SLRpUYUhUJQ1BOQDS8invMvNo1wAqC1MlQPJ5zj
 p
X-Google-Smtp-Source: AGHT+IFHcpyAtZDlbkvQ+DPA2kxcktCFeEtlVxOy9+fNnuieSebEpXcgiOhZoIjSIv9mK3NBQDN3xQ==
X-Received: by 2002:a05:600c:4750:b0:40e:8f44:68fd with SMTP id
 w16-20020a05600c475000b0040e8f4468fdmr1050929wmo.3.1706701742383; 
 Wed, 31 Jan 2024 03:49:02 -0800 (PST)
Received: from localhost ([102.140.226.10]) by smtp.gmail.com with ESMTPSA id
 v16-20020a05600c471000b0040fb6295018sm733543wmo.12.2024.01.31.03.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 03:49:01 -0800 (PST)
Date: Wed, 31 Jan 2024 14:48:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Weizhao Ouyang <o451686892@gmail.com>,
 Etienne Carriere <etienne.carriere@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/3] driver: rng: Fix SMCCC TRNG crash
Message-ID: <eb91a882-332a-4bce-8547-4f212b5b6982@moroto.mountain>
References: <20240131111217.30124-1-o451686892@gmail.com>
 <20240131111217.30124-3-o451686892@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131111217.30124-3-o451686892@gmail.com>
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

Etienne should have been on the CC list.  He's in
./scripts/get_maintainer.pl so I'm not sure what went wrong there...
I've added him.

On Wed, Jan 31, 2024 at 11:12:16AM +0000, Weizhao Ouyang wrote:
> Fix a SMCCC TRNG null pointer crash due to a failed smccc feature
> binding.
> 
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> ---
>  drivers/rng/smccc_trng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rng/smccc_trng.c b/drivers/rng/smccc_trng.c
> index 3a4bb33941..3087cb991a 100644
> --- a/drivers/rng/smccc_trng.c
> +++ b/drivers/rng/smccc_trng.c
> @@ -166,7 +166,7 @@ static int smccc_trng_probe(struct udevice *dev)
>  	struct smccc_trng_priv *priv = dev_get_priv(dev);
>  	struct arm_smccc_res res;
>  
> -	if (!(smccc_trng_is_supported(smccc->invoke_fn)))
> +	if (!smccc || !(smccc_trng_is_supported(smccc->invoke_fn)))

To me it seems a bit strange that dm_priv_to_rw() can return NULL...
Anyway, probably the Fixes tag should point to when the driver was
added.

Fixes: 53355bb86c25 ("drivers: rng: add smccc trng driver")

regards,
dan carpenter


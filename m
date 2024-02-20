Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14C3C5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 13:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D51187F75;
	Tue, 20 Feb 2024 14:29:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aNasJ+kK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E3DD87F67; Tue, 20 Feb 2024 14:29:37 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 947F687F7A
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 14:29:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a3e91993d73so315677966b.3
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 05:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708435769; x=1709040569; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6XKbtpMDXnyM8PaqY7r0rVu521sM1L4FLXF1GktUAO0=;
 b=aNasJ+kKxuZYTAVWIXs+z+uBzfne7Qd5wak3RV6S6SVFf3vQ1sAPuETJalX4JKiBe1
 pUpQnzv8Q9F0AOt82ymQRoSn86BnYKv5Lt5Pcm0ESRIeGacKhyoAah0Fla2bO1+vKQL+
 qvCkiqjK9uBrq4djMMDALclOV9RRMrZpu40EOUeryv58DlQhWNj+G/ayqIqN5FL/lPf/
 tWa1hQXto+Lr4ik7jwVOgIjO1CvaZhXUguw37aRv6Ka+pSEc04/jaw8O7cLurRgPuPTR
 wu4Stp5/L/M7vECeqgtLHAVANQ+tRJg1iKbNg0eC9FKJC2E/mZJjjvugsEk1bKwjNEJ9
 ozrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708435769; x=1709040569;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6XKbtpMDXnyM8PaqY7r0rVu521sM1L4FLXF1GktUAO0=;
 b=EtyUqkboMLpDMQQG0his3tseMQirA/c1LTzanocdqzY6dggAcxJA/kFSuZLRTeF2as
 HpOOJEYCQHY/dljEIRV1YmXH15Obvl/H/Ep3ZgNBki/zxvugPcEGQ56B2K8CII6ePTl2
 nnxjIJ9GvvjoLAhcYzReVbilqaJw8emtRJ3rN1yNAu6dxyW6Q8x/Arxm4fQYq+NpKk3z
 qOEFg/1WIXfYDurHxgGldq7UReIGivyBk/ukhHcXUGt9gdZt9EN7KXu+PBknpoKZtF1J
 j8Lm+Efg9/FJ08Z9A+IvSxWANYVsaCZ7xwcMxaGD2scOaWvzsLiMc1WkZxJLa+LNrnw4
 Tc9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBpWq/smyTpS7DkswWKJyDdxBjl5QzQAtRbq74R1Vnt+h2VW/m02nG6W+F6boSDMjdXdxGZPqV05NXUoR0M1lLZv3Maw==
X-Gm-Message-State: AOJu0YwvZAsQgygsYOEIVTjZvTX61obHYXaXgdvXHXzQ3MCl1KRbGzky
 9DbgmILjrkv2g73wu6wicIggzV+HalwpsCuPEeqJVq62/w53t0YQIWGUXRLriXGwn1h0BEgpsFj
 k
X-Google-Smtp-Source: AGHT+IGRhoiOyT61KSq8n+nuprm/tx0pIg4PihEOepEaIPM0/bO4SVD53/rXQM4Ptdha8Wq0fvRltA==
X-Received: by 2002:ac2:593b:0:b0:512:b366:6c42 with SMTP id
 v27-20020ac2593b000000b00512b3666c42mr3687339lfi.32.1708435317117; 
 Tue, 20 Feb 2024 05:21:57 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 i7-20020aa7c9c7000000b005649f17558bsm1338030edt.42.2024.02.20.05.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 05:21:56 -0800 (PST)
Date: Tue, 20 Feb 2024 16:21:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Rob Clark <robdclark@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] video: simplefb: modernise DT parsing
Message-ID: <4efbc685-4989-4680-9283-81bb0f806671@moroto.mountain>
References: <20240216183840.879482-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216183840.879482-1-caleb.connolly@linaro.org>
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

On Fri, Feb 16, 2024 at 06:38:06PM +0000, Caleb Connolly wrote:
> @@ -41,17 +41,25 @@ static int simple_video_probe(struct udevice *dev)
>  
>  	debug("%s: Query resolution...\n", __func__);
>  
> -	uc_priv->xsize = fdtdec_get_uint(blob, node, "width", 0);
> -	uc_priv->ysize = fdtdec_get_uint(blob, node, "height", 0);
> -	uc_priv->rot = fdtdec_get_uint(blob, node, "rot", 0);
> -	if (uc_priv->rot > 3) {
> -		log_debug("%s: invalid rot\n", __func__);
> -		return log_msg_ret("rot", -EINVAL);
> +	ret = ofnode_read_u32(node, "width", &width);
> +	ret = ret ?: ofnode_read_u32(node, "height", &height);
> +	if (ret || !width || !height) {
> +		log_err("%s: invalid width or height: %d\n", __func__, ret);
> +		return ret;

This should be something like:

	return ret ?: -EINVAL;

Perhaps print the width and height in the error message as well.

regards,
dan carpenter

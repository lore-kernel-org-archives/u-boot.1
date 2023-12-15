Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C60C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 12:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CF7487A9A;
	Fri, 15 Dec 2023 13:34:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j6oebb1N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5F1687859; Fri, 15 Dec 2023 13:34:19 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1ED387A9A
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 13:34:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40c6736d10fso7525745e9.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 04:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702643656; x=1703248456;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ayDLvIC22z0lI2WmjCEveqJ4HhG57PZRMoSWtXPXzrM=;
 b=j6oebb1NjFBJUn0YwP78EziQtkooInIeNL2Z9vmW/63/k8yo/kOxyrt7x6YAU7YlVk
 mlcBgvn8OTbdepukJL0gjXwBdCohbYHHluBP084BW8QNPoiXqGm5mQyhDQqvTqcBbqYM
 3aDBRWj5wkcSAPAdfShftTp4By/oLZBF/GTqU9ZVrQrBgmsOx41Jq+crF39g2ZZyYtKM
 LPomuuiqCXL1VwiTojFhP6C6eA83fhOS7JjUFvt7859wuwbZxDtnkCchQtkxH/ScjxZh
 lMUyL3zlld+6m94zNm7A2fDTUJzh99P8UsXX8b/ADSq/+mHnUai0UpfjIEcEsycKx7QU
 Xa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702643656; x=1703248456;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ayDLvIC22z0lI2WmjCEveqJ4HhG57PZRMoSWtXPXzrM=;
 b=VqkBfZAGdCyy+5oSI0E8i3IK8X5ScFCBWAYv4kArWV7hRYGWSGa9i1BeVvpq6FVU1/
 1MQb4jIzdlLL9/6h2Vg1QzqqiivMhzt1OaduhJVMaQ3zPUTHW2JSLZJDGlHcaq1aK8YR
 3dtRNCLPHvU12U+Qx710tcb+baHrWS9PHGo1SEW5SJCUR7vfx6h+7MQFynrXuwyHC9ue
 hWONF+klGUmin98TeB7KJh2gZzq0UMC9Mtygv0Im7n6QS2lrCsHV/h4aKufkHuJRXxeu
 IkhroZaytd/4LDkYj4pyjlIZCzI/lmXxSJxRGY0l+Y8faBuEN75TBBFwvkMW1ckoLhQz
 WCrA==
X-Gm-Message-State: AOJu0Yx2UUKXYTW9ke8f9jEX0ycEqGcbGGT4Gtovu4UtkdxjerzrH+ZI
 MmXKHEdrOnP+M4ff7ScqRmXW6w==
X-Google-Smtp-Source: AGHT+IEq3nl4kXC5yMHbrERVqdbaodc4f9plaoDgA5TS7tkyRjFtbRUuCQHDPHyjWryO2ur9fbjO2g==
X-Received: by 2002:a05:600c:4f81:b0:40c:3f09:57b7 with SMTP id
 n1-20020a05600c4f8100b0040c3f0957b7mr5647297wmq.145.1702643656287; 
 Fri, 15 Dec 2023 04:34:16 -0800 (PST)
Received: from localhost ([89.207.171.106]) by smtp.gmail.com with ESMTPSA id
 fl9-20020a05600c0b8900b0040b43da0bbasm29168380wmb.30.2023.12.15.04.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 04:34:15 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH] clk: fix clk_get_rate() always return ulong
In-Reply-To: <871qcj5frz.fsf@baylibre.com>
References: <871qcj5frz.fsf@baylibre.com>
Date: Fri, 15 Dec 2023 13:34:12 +0100
Message-ID: <878r5vtzjv.fsf@baylibre.com>
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

Hi Julien,

Thank you for the patch.

On mar., nov. 21, 2023 at 15:42, Julien Masson <jmasson@baylibre.com> wrote:

> When we call clk_get_rate(), we expect to get clock rate value as
> ulong.
> In that case we should not use log_ret() macro since it use internally
> an int.

This is quite subtle, it only happens when log_reg is enabled via
CONFIG_LOG_ERROR_RETURN.

> Otherwise we may return an invalid/truncated clock rate value.
>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>

I'm wondering if there are any other places where this happens,
but this change looks good to me.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/clk/clk-uclass.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index 3b5e3f9c86..41dcd14be5 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -488,11 +488,7 @@ ulong clk_get_rate(struct clk *clk)
>  	if (!ops->get_rate)
>  		return -ENOSYS;
>  
> -	ret = ops->get_rate(clk);
> -	if (ret)
> -		return log_ret(ret);
> -
> -	return 0;
> +	return ops->get_rate(clk);
>  }
>  
>  struct clk *clk_get_parent(struct clk *clk)
> -- 
> 2.41.0

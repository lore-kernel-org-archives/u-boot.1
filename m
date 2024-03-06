Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD70C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 05:30:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A2DE841BC;
	Wed,  6 Mar 2024 06:30:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aCjw79Sm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6258F841BC; Wed,  6 Mar 2024 06:30:29 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6101B83333
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 06:30:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33e27940554so2961351f8f.3
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 21:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709703027; x=1710307827; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uxgO8IlDGwUBlgkkOoAo6WAD6YwsD93gZMcc6lX8jVM=;
 b=aCjw79Sm0U05uvvmFfx2biFiI158rOOnYuQJKk/pyjb4oUX3J5ZSpQwlFfNt8FuGYI
 S0QGqwM7alkNPKXbG1eqXesoEOkplnzlQG4jDYLXM86Ovukwd0KnkgrGCf2p9xfZV3tX
 sCkeUCif19U1RsNCsC+SbpPXFGnPilMhBGhb8A0+7gvl2zZyPNDDWDb7zPsrxB/lZZ4c
 W5LR7XYpbvqC/SXztdXEsbLtPCBwD+J7tPX9c6o+y6mbpt6rUzxVjepblfmdoNfe3eZh
 zNpiLF3qfZkGca0rGD+tPwPZvvI+SUhBDa9evrHUGhNsovzSaYrWEmSuIlGRZmplokAp
 0w6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709703027; x=1710307827;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxgO8IlDGwUBlgkkOoAo6WAD6YwsD93gZMcc6lX8jVM=;
 b=f+mrxIIghEQKHL0ISoI4PRjnzDIrtL6tH9uoUDzQCFKtqmBW7nAwn4KhZ1PamtCBQn
 S/v0Lj20fnbJM7JM+kCGm6Hnva8LE3GLQbQSzlqzxpwwaDwB8pd1mJwbQuGS7pFcYv6U
 /fHroQoNMdpyPq7oW5Abvhx4QCE6AIiKX3rjrcF/r4ip0nIcGjkWSZwkrbg+3wKxfhnW
 MQuyPYxPD4+qyv58nmih9T4egeqIwDlD7xeci9klK/1scOTUFO8OOXI1qouvYZt3lfw0
 dGY1C6s0OejmaAfj13VAwGOFJN/KdpZhoEfOfhIRww9VDycvY4rILJ/QR3eu1SAQHjZ5
 8hHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqVwBKpSATYtyBRQuX+QL6S/y8A86fLtTh6eOd7OGgWWNL3BnhEi9S8brz273E5G4M8tC+RkBMat6xOJbUB2HAmwnDoQ==
X-Gm-Message-State: AOJu0Yyg/BocSYopfm0BzSG8n9zoXXWqcfWmRT1NR0akAvW/mfo+83eB
 OhjJBaw45qOildYwFwChEV5PsC/kUkhsv/bxSvIconChxQYsnwEmc7R4eFQsT1Y=
X-Google-Smtp-Source: AGHT+IGVeeCZX/qWidKZz0JN4b0Q3ZETuwWho4j6JEUWsuRBcJ3YTuC7oWP2uMkzEOBfJy1/1c4WbA==
X-Received: by 2002:adf:b611:0:b0:33d:c6dd:b4b6 with SMTP id
 f17-20020adfb611000000b0033dc6ddb4b6mr10391043wre.0.1709703026595; 
 Tue, 05 Mar 2024 21:30:26 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 bn14-20020a056000060e00b0033e4458ccd3sm5530567wrb.69.2024.03.05.21.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 21:30:25 -0800 (PST)
Date: Wed, 6 Mar 2024 08:30:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: zhangzj <zhangzj@rock-chips.com>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 weizhao.ouyang@arm.com, u-boot@lists.denx.de, trini@konsulko.com,
 quentin.schulz@theobroma-systems.com
Subject: Re: [PATCH v3] board: rockchip: add Rockchip Toybrick TB-RK3588X board
Message-ID: <95f8926d-0391-41c2-9276-689df932338c@moroto.mountain>
References: <20240305012922.49666-1-zhangzj@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305012922.49666-1-zhangzj@rock-chips.com>
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

On Tue, Mar 05, 2024 at 09:29:22AM +0800, zhangzj wrote:
> +
> +#ifdef CONFIG_OF_BOARD_SETUP
> +static int rk3588_add_reserved_memory_fdt_nodes(void *new_blob)
> +{
> +	struct fdt_memory gap1 = {
> +		.start = 0x3fc000000,
> +		.end = 0x3fc4fffff,
> +	};
> +	struct fdt_memory gap2 = {
> +		.start = 0x3fff00000,
> +		.end = 0x3ffffffff,
> +	};
> +	unsigned long flags = FDTDEC_RESERVED_MEMORY_NO_MAP;
> +	unsigned int ret;

"ret" should be int.  This doesn't affect runtime at all though.
#nitpicking

regards,
dan carpenter

> +
> +	/*
> +	 * Inject the reserved-memory nodes into the DTS
> +	 */
> +	ret = fdtdec_add_reserved_memory(new_blob, "gap1", &gap1,  NULL, 0,
> +					 NULL, flags);
> +	if (ret)
> +		return ret;
> +
> +	return fdtdec_add_reserved_memory(new_blob, "gap2", &gap2,  NULL, 0,
> +					  NULL, flags);
> +}


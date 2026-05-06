Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F27CD343B
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 14:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6B438490D;
	Wed,  6 May 2026 16:54:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iuvswRxX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 500AE84951; Wed,  6 May 2026 16:54:00 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B3D784903
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 16:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2aaed195901so27873255ad.0
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 07:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778079237; x=1778684037; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ft7hGuJ+w8IaaK1o4gJ1RAdVNeE5cZWJU1wKOntk/pI=;
 b=iuvswRxXKwkSE7Za0bYWOBzuHNmL+1itjs/cRy57HD4Rrbh2S7gSJEPT8f3I7vtouI
 wckWRnc0jnDHj43nWuwjodhzHpTRalBr1pN0PtOAiZpCTMTAKOpq4L87l2upD5yq4INs
 fM51OJyyUW/K8SdAeyHSAweVgbtiTgTGFlHcAvpc9S3SPqbJwW8ObmYGrqSHRozxOHFF
 wxVjuB7fVCszwcxuXWW+3V0/pDgv+LfQw7yPGxtwRvhAkh2V0RJV7M3pmW0+W1CxBacx
 DuUH22tKke7soXdgTmw/rwnmpRNCKw4hP/4SL5oc93oSGYK+3hueLFpDoLzrhVUHA4P1
 12jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778079237; x=1778684037;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ft7hGuJ+w8IaaK1o4gJ1RAdVNeE5cZWJU1wKOntk/pI=;
 b=j3pF0PgZmBBbDgNCya8B2gL7M8/OgwGsPVaHw9ETzR7P0P8iZx+ihKqWFDRzkcudQ9
 FEYx5vKhjMswcOuV/v84EbxIE+aGl+h17t7m8+LCySZt3+46+Ms9zUJw/ykfaRLbN3FL
 SIzjVKQhhGXh0p1rQQb9N5h2hO8exQ8Qaf3eBsQGhOui+T81Mxc6oy6QQwidDwKXdVaZ
 OzwI51EIusDAerEEwDM0GvaTyKQ35ZRVcfCSwmloSgsz6oBQfOsG1FWTlo6kESK9iiF1
 MjYj/mL1JARKjR/QYh1PeEv6y9+93p6dzM9H2UtDXewXUObdwA/I+AbKYuZy2rI4E/qt
 GhRw==
X-Gm-Message-State: AOJu0YyEp54DZz1qrbpZmNzZ5LSNLe2t2XEN3W9h6IaakJhjqef7DsXx
 rZA/0Xqv/zlQcAqsZCT6WwISXi9tq7EXQBb+qpoMFcFfnUqeeh66Ys/E
X-Gm-Gg: AeBDievZR+U2lSJiPzJc2HT3x4JcSyN8k1Bq7FccznR05I12chNT5jmwHyXRPTBE+yT
 j+EQ0mP4MrlYbtciYHjKucE0jbD4hLYaa5YhIRVxOchF+NZ2VxfnsJwICxg9AhUQEhZs7OAmliv
 /NvJ6zalBF12bR/kQ8RvxpN+/TSpU/PgqcDWKkjkajSslWHvd68qUWj7R5BfgzyJgjm/qVtEAqd
 tV5mw9bjYdrncqHNGN86jYKl+XQAQM6la+YrcQRXJflI16AqUBkrBGxzNq2RtzgquODq0uGjmsX
 CJUGQFLn9aJX79evY0qdxSxaWr0ywJQSFwbUUosCfS9J9ERWofW77AhEr8s2zkBVgpZZcvLz36f
 a0pOp0dT2dumPtOQC+M3U1Twk5n6nYDIxbKqfOBN2V4eyMeSA0p5DYN/wIqXuHa0MzwlH1e6531
 tBY1KBom1YM6EeXfIXd5OM3e/mD4WnXEKLEoRScfMXaGGYxdOk7lMVNSiQbg==
X-Received: by 2002:a17:903:17cb:b0:2b9:59ea:7eba with SMTP id
 d9443c01a7336-2ba78f54626mr35443615ad.13.1778079236521; 
 Wed, 06 May 2026 07:53:56 -0700 (PDT)
Received: from google.com ([2402:7500:a16:6bef:75cc:2938:69c9:71bf])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ba7ca109ddsm27972965ad.68.2026.05.06.07.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 07:53:55 -0700 (PDT)
Date: Wed, 6 May 2026 22:53:52 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Palmer <daniel@thingy.jp>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] virtio: fix boot device hunting in qemu with virtio
Message-ID: <aftWAKPOmhTR5vvV@google.com>
References: <20260504091023.v2.1.d2ced6516d3db067379940b538830e60968dbf6c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504091023.v2.1.d2ced6516d3db067379940b538830e60968dbf6c@changeid>
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

On Mon, May 04, 2026 at 09:10:23AM +0200, Ludwig Nussel wrote:
> Commit 70101c3217ae ("virtio: mmio: Return error codes on probe
> failures") returns -ENODEV where it would return 0 before. That path is
> apparently hit in qemu and breaks boot device discovery
> (virtio_bootdev_hunt() expects only ENOENT). So return -ENOENT in
> that path instead.
> The remaining two error returns in the function are untouched as I
> don't know where they play a role.
> 
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>

Acked-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> 
> ---
> 
> Changes in v2:
>  - return ENOENT in probe()
> 
>  drivers/virtio/virtio_mmio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 62afe609ec0..d90d8309f99 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -372,7 +372,7 @@ static int virtio_mmio_probe(struct udevice *udev)
>  		 * virtio-mmio device with an ID 0 is a (dummy) placeholder
>  		 * with no function. End probing now with no error reported.
>  		 */
> -		return -ENODEV;
> +		return -ENOENT;
>  	}
>  	uc_priv->vendor = readl(priv->base + VIRTIO_MMIO_VENDOR_ID);
>  
> -- 
> 2.43.0
> 
> base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
> branch: us-virtio2

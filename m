Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E96BC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 14:12:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C733A88633;
	Thu, 18 Apr 2024 16:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s+kS65Tw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E88488664; Thu, 18 Apr 2024 16:12:46 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9352881F6
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 16:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-516d6c1e238so1098421e87.2
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 07:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713449561; x=1714054361; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QvvFiFm52pj2p2xWGY4FGFzZkBXdWY0kRJqlsGpUXJY=;
 b=s+kS65TwVXYi0vL3V4uQFRDWEp2b3z+SMaXZiG9zbdhq+++80B2KpyRiici2ZsTOlz
 GNDCZsL2sjB3yUJqYdKokqkgg7bEQWP+bGLN9oz01XZesusdrB1zRUMU3gRfyL3EfK0J
 1guYEtpH4aBeCONOlNvbdCzBJxcOEdyvHwajsif5jARsywUzYii1y57fxoACWjxrCUR1
 1+Syl1+fm3y3qol1xVdUzPq3k3P8EwgNh3lsAZk2oSugqqs0xVl1GY6dLkIwWcYJLKQb
 rX4mi+ptPpbsQK5wcNmNmxNi1My/KJbit3sNaloSCWXn162Y5AVp78qUAPHx3U3uQmEB
 3Bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713449561; x=1714054361;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QvvFiFm52pj2p2xWGY4FGFzZkBXdWY0kRJqlsGpUXJY=;
 b=oZpkpYy/ygdQdd7JwwnGwvAx4IE/dFukO5IgajZJWxz37OJmAXZQ6lcJGXe+WpM7kH
 nmnXd7oGrvI2nopNxSOcNA+/PARMshTpJAGKjNW89+uycnDNfBDOFG8xc5JCPCcZbnEM
 Mz2SapZDMwzuvJwejTovtVQgLglxB1NJT7B/ArO2MuteAiED9nkYeNyM3OVCuxuelvqp
 VGwzgJEmNd3KuEZRJlLr/UDYJHFIvFoBXpwOJAKUYjxFWbecjAUjuw/wITiEZJMU6OPZ
 7P0s01zxF/oMn9GpNRrjjo2O5FX43mxTfknU+QiELnRto3qVk8rnmskgbjteFElC1pLK
 sufw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVViq+PKDQ2gsWu/UkOJoeyjC2j0PF2eRuvIB6AJ915sKnAPLE02shjnCOtSJoJE5bAjr6eVHPGDDSf5V7/fW4iolYaSg==
X-Gm-Message-State: AOJu0YwjeF/Hljpx5d612QTpczw6KsKfBlv27yfbjFf+JWkmVusou72i
 FSHlYywvHf+ufDPLm3HIbWg3ptA6F8LGZiA7YD6y2Kt3crtKXhWf9cyVCCJg8Q28BsPR35CFbGj
 ODKwpWJQC0MKTqmgj/vxGeCFiEbtWMJRnJKTpxg==
X-Google-Smtp-Source: AGHT+IFCdeoNbS//jAZaHV8v5jvd8KKzub5v5VBgbAf7oGydCgSmvo8ydgV3fN5JeDKlogLtnJaWST75BWoyAElCDDs=
X-Received: by 2002:ac2:4a78:0:b0:518:ae6c:c2b5 with SMTP id
 q24-20020ac24a78000000b00518ae6cc2b5mr1621527lfp.3.1713449561047; Thu, 18 Apr
 2024 07:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240418141112.141948-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240418141112.141948-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 18 Apr 2024 17:12:04 +0300
Message-ID: <CAC_iWjJmqfSZtan_zVC5YeGKR5NJqQdgx3QnzZ2Y6miLvi12rQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mailmap: add entry for AKASHI Takahiro
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 18 Apr 2024 at 17:11, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Akashi-san's Linaro email address in not valid anymore.
>
> Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index 932bd4d9a97..8049856d41c 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -15,6 +15,7 @@
>  # Proper Name <proper@email.xx> <commit@email.xx>
>  # Proper Name <proper@email.xx> Commit Name <commit@email.xx>
>
> +AKASHI Takahiro <akashi.tkhro@gmail.com> <takahiro.akashi@linaro.org>
>  Alexander Graf <agraf@csgraf.de> <agraf@suse.de>
>  Allen Martin <amartin@nvidia.com>
>  Amanda Baze <amanda.baze@amd.com> <nicole.baze@xilinx.com>
> --
> 2.43.0
>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

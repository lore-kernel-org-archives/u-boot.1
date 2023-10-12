Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B27DCDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:42:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 589D286DF6;
	Thu, 12 Oct 2023 05:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fCDe7GTP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5494786DD8; Thu, 12 Oct 2023 05:41:36 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 578E586DF7
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53db360294fso972419a12.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082091; x=1697686891; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YS7qr+I/FP9T0w41ctSA1AJauzd0UYqLjh7d2vFg6mA=;
 b=fCDe7GTPi+GzTWk2gqyZiwdQuExobYwCDcsZ3Xg6FLRIgDGGRPCAHcGQPTQUXBnlG4
 uU8yquPKkYW4gBEbeo+ZKXU+3B9MAekoBEB5fZNRm42QUSMVinOGdwiiEcWVyqgSwsHe
 kekYj6afsI5M9QBluaAIsckQlt02UqG+9LnUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082091; x=1697686891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YS7qr+I/FP9T0w41ctSA1AJauzd0UYqLjh7d2vFg6mA=;
 b=kHeZmHZW0YXl7N2bFM4Oqowr9FegqhkEcoASPfOaHK/titwP2mOFyrMzmW9TmMRggN
 k6N0AIhaP3o+RkTYTFG9D+rZTbki2A3vhgckjHUBLqPcvQBLqmg61fDq8P7fFnvEm8vl
 pf4JqdziS4Ps9WmKem5gTsiKAHqMzavevxWqAlbOGpgxvAFPxD/1V5IXUlYOe5gaTGoG
 z4VMs3s9gw/uOr4UievMoaHyiXHW7qecoCT/nqjehiEG5QgFNsmaQbc5DtoTusW7vQ9x
 vi/2hltgJuFUKWn7bSeQuSMSD+WlH5RlnRXC3YhBa/40P1jIMu/9w9DTaWyRG5C3drIW
 dC9A==
X-Gm-Message-State: AOJu0Ywx5DJan/ZFqNKQ+8dIGPISptIYiiLdtdc9DFyG49qWC1gvpPEH
 BAqu08pVA4aU1WzXtReRyY1Zfk2TVih5YZIEahCBLA==
X-Google-Smtp-Source: AGHT+IHRl1lPeAI4d1CsdBMxvrNdm9hg5mYRfJq8wSDOEJTkGgDSGjLLvWlx67Cmo1qOCURrOGZCIosa5NNPoEgFCm4=
X-Received: by 2002:a05:6402:550b:b0:53d:b59c:8f91 with SMTP id
 fi11-20020a056402550b00b0053db59c8f91mr3940438edb.27.1697082090765; Wed, 11
 Oct 2023 20:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-14-seanga2@gmail.com>
In-Reply-To: <20231012015626.3487451-14-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:07 -0700
Message-ID: <CAPnjgZ21qmrFCPwsx63jxSwDMeh02dh1FbDssOWebQcVL_jQqQ@mail.gmail.com>
Subject: Re: [PATCH 13/26] net: Fix compiling SPL when fastboot is enabled
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
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

On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>
> When fastboot is enabled in U-Boot proper and SPL_NET is enabled, we will
> try to (unsuccessfully) reference it in SPL. Fix these linker errors by
> conditioning on SPL_UDP/TCP_FUNCTION_FASTBOOT.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  net/Makefile | 4 ++--
>  net/net.c    | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

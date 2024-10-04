Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BC8CF8840
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 18:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDDDA88C44;
	Fri,  4 Oct 2024 20:36:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p0PhF5EX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92CBC88CD1; Fri,  4 Oct 2024 20:36:53 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02E3C88001
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 20:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7e6cbf6cd1dso1666849a12.3
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 11:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728067009; x=1728671809; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QVM6qsr+s5UEMl5tkmpjlG9SIYyiZo/f8IUhwSHQ7CM=;
 b=p0PhF5EXZElxG0L+dxZs1hsENaWJTYRgxknU6MKzbh/gpWqil5SDDVDylKdj4ypXMY
 utlRc+ghvA8ytWm5cjOfOhCT9j+iMYpbFMCt9KKNAaJnbMF0FlOz/u6z0H9WeoKAOQ1Z
 4rhTZFqPyo8rX5eG5QFR3Anb79Z2zAbtJaGAj9m7bXoyBQnrFj6IpQb7NJTvCi0zIA67
 XVRQzKj/f41AbCGIHfTppp2WOAwERz3x1k/JmI9VhGlIWVJl9+LIaDyVy/B95Wo2Nkns
 nVyuYEg5RCZmuFLL+UrbUMVr4McIxtxIar4oETAV6yNJ6r95snX+vWLSYXPECOanJzfl
 P7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728067009; x=1728671809;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QVM6qsr+s5UEMl5tkmpjlG9SIYyiZo/f8IUhwSHQ7CM=;
 b=WMn3L4ZUImy4aBL2B1dLXthu6merExY+kZJPVOpjGATsGWLCTYF8StY/Xbh7kbUwgz
 TKL1JaZ+Wc8rtRP0NEtuRg8rSH26UiUXtUGf9irmhtRY/qSna3rGyWx0E8BcUEQMAJJd
 /umgmR5x69YyxTaa2H/XxUFJJOanFKDGA9mbbkLiZFIKt7nWjkfyQE7ihM08K6wKK2N+
 Zh+ky71aW4LSHG/5OOKNSEz8kUoLcumx6CeNXe8NtisjvnywiIqlWj5RwCdj2r36oKtz
 v4e3Qr/D73i308plD3r8aCIu8PZWBgc2GV6JZ6e9rzAQKGsXH7cS3tZ7QLbaxRYURMLV
 sffw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsH4dKmDRMB3PYpeqBt833HMG206NOyTTcF9aEXDb/XgmVKKDV0r75lySJW+i/6KA3is4H1oM=@lists.denx.de
X-Gm-Message-State: AOJu0YxRf/fhGbuWsKvkjN7s6HyevDLd44kst7rEYH2244q6mGxni8U3
 LkTfwwcVx/11+j+RPjqbgSGaC3JcgXk88stqrhLK/KPB4KBP3J67x9zrRwrxkvVEFkraALeb/zN
 kSVNFUDPSdicGbyWTUDmIh/C1hUEXr/+1R4YeMg==
X-Google-Smtp-Source: AGHT+IFGWDWGMNAx1tKPY+hKAKLYsb4eSvEmJzTnhrKIaqvjMah8ePKn26gkjhNar/qW40PcASQxqpFsgErBJ/ImlO8=
X-Received: by 2002:a17:90a:9ac:b0:2e0:b26c:9069 with SMTP id
 98e67ed59e1d1-2e1e631ec6fmr3833977a91.25.1728067009461; Fri, 04 Oct 2024
 11:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <20241004183043.GI4737@bill-the-cat>
In-Reply-To: <20241004183043.GI4737@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 4 Oct 2024 21:36:13 +0300
Message-ID: <CAC_iWj+BOU1Qv_RH7B95e3nGBcLPCsf1M2sui1mR-X0+73ym-A@mail.gmail.com>
Subject: Re: [PATCH v11 00/29] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Anton Antonov <Anton.Antonov@arm.com>
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

Tom

On Fri, 4 Oct 2024 at 21:30, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 03, 2024 at 05:22:46PM +0200, Jerome Forissier wrote:
>
> > This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> > library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
> > stack [2] [3] as an alternative to the current implementation in net/,
> > selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> > reasons for doing so are:
> > - Make the support of HTTPS in the wget command easier. Javier T. and
> > Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> > so. With that it becomes possible to fetch and launch a distro installer
> > such as Debian etc. using a secure, authenticated connection directly
> > from the U-Boot shell. Several use cases:
> >   * Authentication: prevent MITM attack (third party replacing the
> > binary with a different one)
> >   * Confidentiality: prevent third parties from grabbing a copy of the
> > image as it is being downloaded
> >   * Allow connection to servers that do not support plain HTTP anymore
> > (this is becoming more and more common on the Internet these days)
> > - Possibly benefit from additional features implemented in lwIP
> > - Less code to maintain in U-Boot
> >
> > Prior to applying this series, the lwIP stack needs to be added as a
> > Git subtree with the following command:
> >
> >  $ git subtree add --squash --prefix lib/lwip/lwip \
> >    https://github.com/lwip-tcpip/lwip.git  STABLE-2_2_0_RELEASE
>
> So, assuming the outstanding questions raised on v11 are easy enough to
> resolve, I think v12 should be posted with being merged in mind (and so
> no TESTING patches, etc, since I'll "b4 shazam -SM" it. Thanks for
> working on this so hard!

FWIW I am generally happy with the whole series. Unfortunately I dont
have time to do a full detailed review, but we've fixed enough to be
confident it's 'ok' to pull.
I think we'll improve it faster over time once people start using it

Thanks
/Ilias
>
> --
> Tom

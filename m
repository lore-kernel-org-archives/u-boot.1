Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD00C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 09:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F15287DD3;
	Mon, 18 Dec 2023 10:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mHh2NMqe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2201487DC5; Mon, 18 Dec 2023 10:01:37 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8706487DF1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 10:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rfried.dev@gmail.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5906c569a1fso1189963eaf.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 01:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702890089; x=1703494889; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSs3PhXEtTUL14MU7Frv7VpDQZjJIBtupOZQmimb+nw=;
 b=mHh2NMqeoPl4s7G8rKavCi318OmieHTqfwd8HhNlGrGqTmZQjKCG+mHgRKVlGcSh7v
 9qGycFioXe61+Akw96pfEQuQ8xb4evd+XJc2OgQoJe6FcflUPHEPp8bytvoRljVa6a5T
 gKRMiKKde2LwwKrj6vSvArei39lICBJe459Pw9PemXdT88Hls98iZ3N2Cte5JEo2GVVi
 nohdReyYiOvavOahNwbVeTNKN2yjFEpVNlN8NphP743GixBmLWJvEUjLc8MWQSLikqCR
 218LOKMIlglgHfnxCML5G8DFgyVkNjeepJ0EukHPjFPwNyFQujUN7P80HJyTpzrX4y0K
 LpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702890089; x=1703494889;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CSs3PhXEtTUL14MU7Frv7VpDQZjJIBtupOZQmimb+nw=;
 b=bpu6iNPPanGscKG9Zi/zUc7oMbQgPM+8CFmQZIzlflLkTsyhYMcPiBhqc4lg8xywVF
 IeNXhbdSKUG8xjwy2krG1F0VhTgGqasbMBuiameYw7Hnlrd6ccgZJ6qm2nmEJw9nRjzK
 3Yew/pijrGArJer8kWi9K+xtWt06S9U41TH414/kdFKJAgriCqBHHN8b4U6W9OLaKoAl
 H1SDzuVUqnZG15eek3ZT4dGKcDT515BlawUKc5WC59yOyv02v2bVWEmKbItTxR4/2XUP
 0DyEHqEUEI/j8Vp8PP/UUy81t/jfZ0RnaYVFAxhDx6Im7qeCX4EfYj70Hm6oBq6bN2Dp
 JePw==
X-Gm-Message-State: AOJu0YywFR7to9+CHiSKFxNcuHcYEFkQbAANi2MzLm3e5eU2nW/m4YdE
 dW+YiBg+31nP388lxVMJgwE/AllMNURR8UE4wKk=
X-Google-Smtp-Source: AGHT+IE0VEYWwrtnmruugMWLIU69c0l4apBQ35wZCbCc5tHk4I+pYSpjS3PjKkq4BpJLnsOI3U3RSLZs5uUSquNGNL4=
X-Received: by 2002:a4a:d80a:0:b0:591:b9ad:4a07 with SMTP id
 f10-20020a4ad80a000000b00591b9ad4a07mr1779702oov.3.1702890089485; Mon, 18 Dec
 2023 01:01:29 -0800 (PST)
MIME-Version: 1.0
References: <e418d8cdf88c8ecf8cf1b9d50ae53aacfe884f94.1702885073.git.baruch@tkos.co.il>
In-Reply-To: <e418d8cdf88c8ecf8cf1b9d50ae53aacfe884f94.1702885073.git.baruch@tkos.co.il>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Mon, 18 Dec 2023 11:01:19 +0200
Message-ID: <CAGi-RUJHOM8ZTwxVaUgzOGDs-nSXG-q69d7j4b26kx8S1vZE1A@mail.gmail.com>
Subject: Re: [PATCH] net: fix NetConsole documentation reference
To: Baruch Siach <baruch@tkos.co.il>
Cc: Joe Hershberger <joe.hershberger@ni.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Dec 18, 2023 at 9:37=E2=80=AFAM Baruch Siach <baruch@tkos.co.il> wr=
ote:
>
> Fixes: d0253f7e5ca1 ("doc: move README.NetConsole to HTML documentation")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  net/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/Kconfig b/net/Kconfig
> index 4215889127c9..92a22ac1ea55 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -57,7 +57,7 @@ config NETCONSOLE
>         bool "NetConsole support"
>         help
>           Support the 'nc' input/output device for networked console.
> -         See README.NetConsole for details.
> +         See doc/usage/netconsole.rst for details.
>
>  config IP_DEFRAG
>         bool "Support IP datagram reassembly"
> --
> 2.43.0
>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>

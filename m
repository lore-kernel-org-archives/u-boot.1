Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3E3C5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 13:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7619F87600;
	Thu, 23 Nov 2023 14:13:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rv8pdyMx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CE0987600; Thu, 23 Nov 2023 14:13:18 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D28C87499
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 14:13:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a00a9c6f283so117838666b.0
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 05:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1700745196; x=1701349996;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MB0TTNyFG+yRspk8OkG3sdT8GkHputS1cI7LJnl+82Y=;
 b=rv8pdyMx4UQpdp5KWJWHPdfRv+aYqIOXoymFv/gwOnZoy30636wIwniktqG9Px1Ar1
 7I0+N5dP5tLqV8DvdkcQ5bDC9F4vr+RWtPgTLQp8uyoZoFo9qgt/8IFUizesqSIIOolL
 nyvBZ5GnVC//5sIchvAHDVFejheec3O6VXJrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700745196; x=1701349996;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MB0TTNyFG+yRspk8OkG3sdT8GkHputS1cI7LJnl+82Y=;
 b=mDpEwDXPUMSd99TTdmlDtYzOeNbpoXC9Pb7Hbx0y+PU4SzKT9QHbyDql6++l/m0vks
 slyj3kYfhe8haX5h7oGlKPr5L9mR1nPa/PHHnmYcQFHDEbSGovfWoTIl7iD6E3zsD9G2
 Om2PSjexkyvMhnsuv3JKUPkhS4k6pJAN0ZizUlTATRnlNamq03fIDc2CKr3rx6cbCFd7
 Bvo6ZUecPcWKZMe0xdHHlxQpTYQL/6p0X1dcBMwAjZ9LRscueqjab32aZgbHk49BNgTp
 BuSU3pgHM5EhCryT+EDc4n8oZnbNK0nDB52xYnFMsA7CiFHIaXUwtNgCLjmz1439HhSB
 lw6A==
X-Gm-Message-State: AOJu0Yx0ZShfw6UqEJawzABIIK2cd2gyeMeeLzRNWG6v/P1ECf+xNGO9
 QOj+JWtrq0PwGQANLldjYhcyAzC4hIom+Mz4LabC5g==
X-Google-Smtp-Source: AGHT+IFe4nSEP/9kDTRZxPmj0qZKdetXkE3YpW6iNOoF4cK5a+NgRfJ/CE5rrx38IFUQ7bLVB8zwgy1kx6xWMGka89Q=
X-Received: by 2002:a17:906:74ca:b0:9be:466c:1824 with SMTP id
 z10-20020a17090674ca00b009be466c1824mr4357928ejl.11.1700745195801; Thu, 23
 Nov 2023 05:13:15 -0800 (PST)
MIME-Version: 1.0
References: <20231123131003.238105-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20231123131003.238105-1-dario.binacchi@amarulasolutions.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 23 Nov 2023 14:13:04 +0100
Message-ID: <CAOf5uwmqVaUoD0HayhVkyPL+qNe+n2ZoV8PyjJzHmskBm2TKYQ@mail.gmail.com>
Subject: Re: [PATCH] binman: doc: fix typo
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Simon Glass <sjg@chromium.org>
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

Hi

On Thu, Nov 23, 2023 at 2:10=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> s/use set/set/
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>
>  tools/binman/binman.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> index 020988d955f0..230e055667f3 100644
> --- a/tools/binman/binman.rst
> +++ b/tools/binman/binman.rst
> @@ -2060,7 +2060,7 @@ don't have access to the blobs.
>  If the blobs are in a different directory, you can specify this with the=
 `-I`
>  option.
>
> -For U-Boot, you can use set the BINMAN_INDIRS environment variable to pr=
ovide a
> +For U-Boot, you can set the BINMAN_INDIRS environment variable to provid=
e a
>  space-separated list of directories to search for binary blobs::
>
>     BINMAN_INDIRS=3D"odroid-c4/fip/g12a \
> --
> 2.42.0
>

Reviewed-By: Michael Trimarchi <michael@amarulasolutions.com>

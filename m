Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6B7C83F2F
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 19:23:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9446E8669D;
	Thu, 31 Aug 2023 21:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aQpMZQLs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FC338669F; Thu, 31 Aug 2023 21:23:02 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 523CA8659F
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 21:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-52a40cf952dso1532928a12.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 12:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693509779; x=1694114579; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jbIItQXR81Tos+uksahYH2c9n2fow07XG1z86WKPhOA=;
 b=aQpMZQLscP3uqqrh3M6migMMdTtiuh3UCDTo08zSZoz79uKirOFYMtLkd5stOHuIFB
 AUh704Sxz/k8VmOU1TYSWv4ylRwRToh3DjIdb5MDT8as6GzH1sPYeIy7tLAEWcGYUCJt
 Wr2Kkj6ePxp78+s3UyzUod9G7pZglqVn/4gqTW4enVZoFN2luFA3eTx8Z0TeuJQakFKa
 sjVGq5hEicmOqcS6iNzSWs86iNzd9SfcH25VPFipKpaiRP8DifWq8YGt3GH6h3ngFvcP
 aMMku6tSZd1k1DOhX9rZ87dSnay5MO42Lf20RhxuB5ruBQqtZEqg6hBPYGKXlFaPGSZW
 gFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693509779; x=1694114579;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jbIItQXR81Tos+uksahYH2c9n2fow07XG1z86WKPhOA=;
 b=jgIs6vX/rCatR0WEwct8tPY4hmPXcvDO4m/NqOqIBoPGxyOrJZE4eVy7J5O0YrW7b4
 5WCjMrmyHJSj+1/e9uGARQLZbHqnG8f+ZrL4keqCexNu7HaJr+bdyeXsba7G4/MK7AlS
 vFBONZiNcv5UVaKnHjs3ditvz5oMCNkq44J1j6J99B83OQkJq+L9wCiuJpHKiTP45N6o
 v6p/I92/ux0hLX8TWobBf5gR/d9/XdMg5qjOvSjkc0pipaetw7GGzTJaEzIlwx7ly10H
 rgA7Lj8+S60blJ3/zvMun5B6t/o0XmhaU3/sqgAMXrAYkZ05cw5XkeqDGzREr+iHBgMz
 yN7w==
X-Gm-Message-State: AOJu0Yyc433FTuuFhYwSBqeH0Sh7i0fuVnB2UKRED9GNHVk6FpcFA0WQ
 DDH+R2ucWU4MtGX6PCsJKKGQx4YkFn71ctd72AU=
X-Google-Smtp-Source: AGHT+IHPwOxUFdK9I0zqtlH5Xon5qtCPaqPf6ilkHuc2Yjf1BW5Aba/crUiku5a0v9au9WKRT1i1qAWlI7q8Xv+TOV8=
X-Received: by 2002:a05:6402:5159:b0:523:69bf:2bd3 with SMTP id
 n25-20020a056402515900b0052369bf2bd3mr383895edd.13.1693509778508; Thu, 31 Aug
 2023 12:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230820190412.21266-1-jmcosta944@gmail.com>
 <30bc9a25cb0b3c6a7251056c0054680b5cb04d40.camel@phytec.de>
In-Reply-To: <30bc9a25cb0b3c6a7251056c0054680b5cb04d40.camel@phytec.de>
From: =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <jmcosta944@gmail.com>
Date: Thu, 31 Aug 2023 21:22:47 +0200
Message-ID: <CABfBAmAgyG4FyTcRGcYfVboz04MEKLSeCD7q2Qgr1ke9ZswKjA@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Port gen_compile_commands.py from Linux to U-Boot
To: Yannic Moog <Y.Moog@phytec.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "sjg@chromium.org" <sjg@chromium.org>, 
 "trini@konsulko.com" <trini@konsulko.com>,
 "antoningodard@pm.me" <antoningodard@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello Yannic,

Em seg., 28 de ago. de 2023 =C3=A0s 10:09, Yannic Moog <Y.Moog@phytec.de>
escreveu:

>
> Can you also add a patch to add the compile_commands.json to
> .gitignore, please?
>
> Yannic
>

Absolutely. I will add such patch in the v2 series. Thanks for the
suggestion.

--=20
Atenciosamente,
Jo=C3=A3o Marcos Costa

www.linkedin.com/in/jmarcoscosta/
https://github.com/jmarcoscosta

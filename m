Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D54AC47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 19:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81BEA87B84;
	Fri, 26 Jan 2024 20:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ByVMTqf2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA9A287B84; Fri, 26 Jan 2024 20:11:10 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94CED879F6
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 20:11:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-602c67c878eso1281007b3.1
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 11:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706296266; x=1706901066; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tWusyik5UaY6oXnBVpWTCRS/GOi1iylGj3yvcqU0+NA=;
 b=ByVMTqf2pTfsdFqZzIlYqcM2ht8Cpm3BZVvdiWJzuQIHwMBQxNCisyS7A3LiA0SwfR
 OwVLlBKIx/Ka0JrnAC97EiCFfd0MejO1v/P5PdrEGGT96totGyAOm6IB+qAIeNf+pU3u
 9V+xE0O9srZlimUlSoc29zajZO826Xf64DV+BJ61LJY0frTEMalzu+t3DFAO8wWd/nCP
 yBoR0b77n35bib3aqK5fOaM78arqhzWKqADUWBPjTb8wVtn4FEUFqbOvo0Z9+5iTChli
 Z5b5TQqpi5Qtw6I+iyzGtAe3modLAnzZ42B10GzehPakhU/QdBTCjoeWOGzPDH9wzsaf
 rKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706296266; x=1706901066;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tWusyik5UaY6oXnBVpWTCRS/GOi1iylGj3yvcqU0+NA=;
 b=qajvAXZnWoSkOau8duFHcHSPf5SXvTwIMCdbt+3pZNFdYkBKAz8ejzfN7SkjmuPhtY
 Z785Cso80HZ5ooQZFCOebT2pGgBMfbrvb07eLFESiQau1FRQ+mD+nwF9RZURb35s3iWY
 3ySM9G2Z00jLg2vVGiQRHVykN75UHwqfe54hucqrzxf7x+lR6SzTqOZtYDYW/cJJSNKt
 pqXIZEfZ7slmRdlUi7Ia8W4333K3m4sMxAjkdkoavA+T7bu7LL6anwG8Hc8OAZYEzni/
 17/Fs3jyHzwQTD/FK3f0+yXHbM485V++ByBwWPpZWdH7wLwYgjptnWLIIBYk036CSu5r
 G3zg==
X-Gm-Message-State: AOJu0Yyc0vTOBMD4e8nl+R/VhjS0MgvW5q/OtHCPe3iad8HSq7sizmZa
 ElyDKYM4lvfZjIt1666SWZXSEysXnWgYb+7R8lBHt+ATG82R94qoHS0p2/Go16oe/ZX6V6gnJMZ
 BOiG9ziJcwYAJG8Tf/XNuLUOfdN4=
X-Google-Smtp-Source: AGHT+IFnFp9J5TUrE9PpycC3VOibysKPjs2wfv28tfM4+LlZMXXPFoUiHJnDF+9wS49yxoroeUvO5P50X1EUe8EKX7g=
X-Received: by 2002:a81:918d:0:b0:5ff:7ce1:e86f with SMTP id
 i135-20020a81918d000000b005ff7ce1e86fmr447842ywg.5.1706296266226; Fri, 26 Jan
 2024 11:11:06 -0800 (PST)
MIME-Version: 1.0
References: <20240124021516.280026-1-Mr.Bossman075@gmail.com>
 <CAHCN7xKcoQixHvZbXos7kiBrZnMD12-q1UfDze+1Y220g_Oq8w@mail.gmail.com>
In-Reply-To: <CAHCN7xKcoQixHvZbXos7kiBrZnMD12-q1UfDze+1Y220g_Oq8w@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 26 Jan 2024 16:10:55 -0300
Message-ID: <CAOMZO5DZF72Uumk9bQJ-R=4kNOLz-EtJUgrLz_87Y1yOi8cCTg@mail.gmail.com>
Subject: Re: [PATCH v1] tools: mkimage: Add support for i.MXRT FlexSPI Header
To: Adam Ford <aford173@gmail.com>
Cc: Jesse Taube <mr.bossman075@gmail.com>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>, 
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, 
 Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>,
 Fabio Estevam <festevam@denx.de>, 
 Simon Glass <sjg@chromium.org>, Jassi Brar <jaswinder.singh@linaro.org>, 
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Alexander Dahl <ada@thorsis.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>, 
 Mikhail Ilin <ilin.mikhail.ol@gmail.com>
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

Hi Adam,

On Thu, Jan 25, 2024 at 7:37=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:

> I had to go back in time, because it appears the current version of
> 'master' doesn't fully boot the FSPI, but when I applied this patch
> against a working version, it still worked when I was done.  I'll try
> to git bisect the issue when I have time, but for now:
>
> Tested-by:  Adam Ford <aford173@gmail.com> #imx8mn-beacon

Thanks for testing, appreciate it. I will queue this one.

Hopefully, we can figure out the cause of the regression.

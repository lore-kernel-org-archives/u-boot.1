Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C08C47DA9
	for <u-boot@archiver.kernel.org>; Sat, 27 Jan 2024 01:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A68A587E50;
	Sat, 27 Jan 2024 02:58:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Az6y7gWe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D24E87E52; Sat, 27 Jan 2024 02:58:47 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F363B87E4B
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 02:58:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5ce2aada130so642237a12.1
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 17:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706320723; x=1706925523; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y6D1hBR4wr/PpJjK7uRSDLvHjpWa4RDYMlC0zPYoT6s=;
 b=Az6y7gWezaMZ0QlZsYi7PK3o/ex4O4KjKXuJoPwoAA8jt4v1fBWfYjmuA/7Xznz0m5
 SgAGngVJBAO5owrzrb/m2amqdg426bXI1d/SX0/Sq+qji0dy/F3G8v9e8Pil64+x0s+w
 YakTa7bDsuI6YvE/oNuS1UbzO5i/84GnraKGUO6GGgdbWaEgHTXxr9iBmt3LdtAHgJOO
 d3umyF7gYJp54mNIHz8f/6FkXAcWCuCMJU0HUbTsqii7GM0L2fzGAtybs+kZkeotNmfS
 T+sTZ0i6gYUAuScJ21jpYr1rassBDFPZOHuGfbB5ahKl9nBN9Vb8DI5qZPqrwHrBaGVo
 hDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706320723; x=1706925523;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y6D1hBR4wr/PpJjK7uRSDLvHjpWa4RDYMlC0zPYoT6s=;
 b=u7/Fn8+6udnNhrdICPSxeb0c3aGbWOeE9v+JA4PaDLBnmk096BsaFxfQJsx5RQCbCU
 vt65oPhKmNRC+Nsjrr8rdCHy3lx9AyRyz8eAn/SlNkxN/GrzVmEBsT7FLOy5LmgK15ww
 7UayPV/UvqYXImxcdotGgll0xts0ivd10fZVEdd9Uc231MyQFzfwNAeEv57xR5psVnmY
 mjKg5DRZYD10CcbeFKo4zwjCNGmS9BEC/lddc/9z9wVhaU4HSjAtE+wsuqxicr2UgZpA
 mL1nobSREdgBeY9DgZx9pURhxgFjTprBY6NeWhTFP3bhbZUqdLb7/N+C3K0eLTiBUnBT
 0VCA==
X-Gm-Message-State: AOJu0YyKI2mhXnPi08nJY6HUOXWhRA/lLTyCR98dmEq/KLDzsTb6GOq4
 g0e6uWKHXc40i/WFjNQm/R+EMev/MKEtZwuLSwzUYFubcJvem2rVRixa+BB+cfBpjYb9i2/rOIt
 rftE0T/ayOOW+WHqny86w2FX3jFw=
X-Google-Smtp-Source: AGHT+IG7PPmYo7pgEFGVUSScn5rBx4lfamF5t/rPLN4EQN5TuUS+bToyotWtkw6FQYUs8AAd19FR3zpLOcDh+QdwrUA=
X-Received: by 2002:aa7:8a4f:0:b0:6dd:81dd:862d with SMTP id
 n15-20020aa78a4f000000b006dd81dd862dmr591811pfa.42.1706320722931; Fri, 26 Jan
 2024 17:58:42 -0800 (PST)
MIME-Version: 1.0
References: <20240124021516.280026-1-Mr.Bossman075@gmail.com>
 <CAHCN7xKcoQixHvZbXos7kiBrZnMD12-q1UfDze+1Y220g_Oq8w@mail.gmail.com>
 <CAOMZO5DZF72Uumk9bQJ-R=4kNOLz-EtJUgrLz_87Y1yOi8cCTg@mail.gmail.com>
In-Reply-To: <CAOMZO5DZF72Uumk9bQJ-R=4kNOLz-EtJUgrLz_87Y1yOi8cCTg@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 26 Jan 2024 19:58:31 -0600
Message-ID: <CAHCN7xKOTE4CC5Zt28tWD6WO_dTEtDtaj+sV4YLHhVBgKwGkJg@mail.gmail.com>
Subject: Re: [PATCH v1] tools: mkimage: Add support for i.MXRT FlexSPI Header
To: Fabio Estevam <festevam@gmail.com>
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

On Fri, Jan 26, 2024 at 1:11=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Adam,
>
> On Thu, Jan 25, 2024 at 7:37=E2=80=AFPM Adam Ford <aford173@gmail.com> wr=
ote:
>
> > I had to go back in time, because it appears the current version of
> > 'master' doesn't fully boot the FSPI, but when I applied this patch
> > against a working version, it still worked when I was done.  I'll try
> > to git bisect the issue when I have time, but for now:
> >
> > Tested-by:  Adam Ford <aford173@gmail.com> #imx8mn-beacon
>
> Thanks for testing, appreciate it. I will queue this one.
>
No problem.  Sorry it took so long.

> Hopefully, we can figure out the cause of the regression.

I must have done something wrong when I tested this before, because
it's working fine for me now even when applied against the main trunk,
so I think all is good.

adam

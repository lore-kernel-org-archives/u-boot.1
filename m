Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA8ACE79AD
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 07:05:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CE4D86BAC;
	Wed, 20 Sep 2023 09:05:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fiOnTtgP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 959DB86BE8; Wed, 20 Sep 2023 09:05:53 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47A7386AFB
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 09:05:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer@gmail.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d81afd5273eso5633526276.3
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 00:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695193550; x=1695798350; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Trntn6XUx2404wXEJfEPAnBs0ob90g1dG2gzgCgRxsA=;
 b=fiOnTtgPxLqkPlcUxUJ0NFIVdoOXATaML5TeXA7dlDLaJHqv6zGZN+waUWpGSEWopx
 hFBizPwAozzFjVPISVv3nADt2nQCRKlH8VkXUXpxdZ980XgnfR+7v8g0uocAv8DzL0Gy
 PHDccJVazFb5Il5IfQEI/Ut0mNJYHJ5f3sNzYg+xXjz+bDGlDVcWfAzeQ0bIGNa2n0I5
 fFi4gerfpGtchH5LNV3GeWiQDCN657zypLr2upv+vo5arNK7gEQAdEUR1AlV2Uk4fTfQ
 J3PoBAhdkuuS1Ozmq+Ds1USZayz9w0y4fCfveQClVrNktCU1gpxeSXiokYilFMEabxk/
 mrlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695193550; x=1695798350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Trntn6XUx2404wXEJfEPAnBs0ob90g1dG2gzgCgRxsA=;
 b=exI0/Wze6S5daZlgMDHC6QGMsOr105rSBqp3sc8XNoxtYaU6gn0Nxdm9QlYBQFjdJu
 FmCWkldwBLb8mxFZYGvdIYtz8wLy8q1rd15KcENVaAqnYVtpWfBzcXWSSl7E8YeBj0/w
 QJPl8PM/yWmrZdTlk6KSEfedkfbTl529GjX8NixxW00Jh8o5wTplLblTV5oJnyczvSEO
 FsEbca9qwazF46PGemp1v89rtwxfUptp1W3KDylNK+9jBzO+tCN67EK3PBkYWmiNQDn6
 sLy/cxkQXn/i9I+ImpD+wLldnvcpv3fEGYV0tRNin8TU8tknUSYX8b+iQRQik09JbUx8
 vaqQ==
X-Gm-Message-State: AOJu0Yxxp9MLaoxC85asQaOnO0MoTFYldfkmIdHMqNO63GUTGOX/xAaR
 w0QE13teRJARmasBiMuWHNbYKrRKdRYX9k2Wl4k=
X-Google-Smtp-Source: AGHT+IEUDu4gw6/ZVMZiHUEgRjepfZ6ZzA0VNueArMZQbE1ogTFSgRd1cIIoj0r7+QSJXxowQxRPqoAzf7nDJIHd03U=
X-Received: by 2002:a25:c544:0:b0:d7f:cdc8:e184 with SMTP id
 v65-20020a25c544000000b00d7fcdc8e184mr1811845ybe.49.1695193549822; Wed, 20
 Sep 2023 00:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230919100222.9319-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ37dufD9oGuzSBkAoOz6GqndSuYbdYRkQv57k+V14bKJw@mail.gmail.com>
In-Reply-To: <CAPnjgZ37dufD9oGuzSBkAoOz6GqndSuYbdYRkQv57k+V14bKJw@mail.gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Wed, 20 Sep 2023 09:05:38 +0200
Message-ID: <CAC928Hbjn_P7CAGiH1vYzWB60DHDBOZcd64r6jWArLrm8ANk2w@mail.gmail.com>
Subject: Re: [PATCH 1/1] binman: doc: Remove incomplete sentence
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de
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

Il giorno mer 20 set 2023 alle ore 04:59 Simon Glass
<sjg@chromium.org> ha scritto:
>
> Hi Heinrich,
>
>
> On Tue, 19 Sept 2023 at 04:02, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > This is the difference between version 1 and 2 of Massimo's patch:
> >
> > binman: doc: fix reference tag placement for Logging section
> > v2: https://lore.kernel.org/u-boot/20230913161633.999542-1-massimo.pegorer+oss@gmail.com/
> > v1: https://lore.kernel.org/u-boot/20230909135235.21242-1-massimo.pegorer+oss@gmail.com/
> >
> > Fixes: 0f40e23fd22 ("binman: add documentation for binman sign option")
> > Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  tools/binman/binman.rst | 2 --
> >  1 file changed, 2 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Acked-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>

Thanks.
Massimo

>
> I don't mind which patch is applied.
>
>
> >
> > diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> > index 8945b19446..020988d955 100644
> > --- a/tools/binman/binman.rst
> > +++ b/tools/binman/binman.rst
> > @@ -1480,8 +1480,6 @@ as set in stone, so Binman will ensure it doesn't change. Without this feature,
> >  repacking an entry might cause it to disobey the original constraints provided
> >  when it was created.
> >
> > - Repacking an image involves
> > -
> >
> >  Signing FIT container with private key in an image
> >  --------------------------------------------------
> > --
> > 2.40.1
> >

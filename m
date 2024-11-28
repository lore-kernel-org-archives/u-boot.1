Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4093CD69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C531A89020;
	Thu, 28 Nov 2024 16:14:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b9a/aCJP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C6AA89046; Thu, 28 Nov 2024 16:14:58 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ED0688FFC
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:14:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21207f0d949so8073005ad.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732806894; x=1733411694; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3SU6OYLRckYo05WhwxTekXnD4NUdO4U27CI1Sd0bFgg=;
 b=b9a/aCJPgDOIWvHK4y2jPsd47uGhzBbYXxgadMx7Nz98BPXtmdhXsZYF270kl8oSOj
 OgVk1ac+5kx+x9W8FkFFHlsseCDek4a5skgb58enpo8CrtEekiPA/9QJns8MK4SiUB5K
 kRQKO/4ylpPWM/+RFzAXZC3ZJOq4x4r9oLwCpySA36RtnwtoBrXMlr+mupAgI1Dn0/A/
 hERAmpVdzAEIfqXPDyqhkOzkx+kCMbVgsOCzjsAIrkk0nonhdOVMR+mRsdIKfwh73AiK
 P5ndrO5UUBBHnTxVzZx5w2/xoX7Q2lXON/P+oUN2SpqdyvYh6/cm1zykl+XDEO/zvdLR
 WJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732806894; x=1733411694;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3SU6OYLRckYo05WhwxTekXnD4NUdO4U27CI1Sd0bFgg=;
 b=kAVPlKkCRUbPFv/qiBre1GU6WbkM3cXYMB5CGF8X+t10K6VFJg2Q2yIfEp+5W+5NlW
 uw3/egnFGmcuc2+mAs7WakUTsa2yjZHM5NguogwIjSB1l6NZ1eTCtsj9CMChLvm4HTcm
 oB4HBjWF197pJn1babLfLWW9V3iAjtsJmI5rk1RbTuQCpddt+TnN28T1FBgzGSaQi05+
 GlUEsFvaRYWqEtexUSfqMM64U56/lXW55zuN76HxMFMw5WGmJAiYeypYH8hdLQiSL+1Z
 zI9xpI9N/kVCUqnbPBvzwh39oT54V+tAX04j3X9wDV5wPzmx3cJIC1F++peoMLF1WaIj
 0JhQ==
X-Gm-Message-State: AOJu0YyIGx5PMTijUpNflFk+25HsR/hxu+34tPwwZVo8UXvyj92qC+Xj
 n2vn9TZA9O6YTvVHZKszYWRIfoAQcCIDQkqE98JswC4rqJzRZVBqJJP279FnCh2lUS/hwAapUVv
 KGQabKQE8F91jgxZx69hSDqRVHGo=
X-Gm-Gg: ASbGncv35JV0Y8XX9M9eAkAo9WHuKy1XBPpcAK1r832za2jn9sdcfKPMEgCg7sq80uB
 nGILQZpHlHK1fmGgS9gVGBOGGG0TCHQ==
X-Google-Smtp-Source: AGHT+IGvTQxQajN3Ark4S4SUJ5Iiogrtkcoa001851MB+wZEDTmXtkTeQ4Oj639Me3oHaEvCy8PuokhX5VpXNIlulhE=
X-Received: by 2002:a17:902:ea06:b0:215:30d1:36f8 with SMTP id
 d9443c01a7336-21530d139f3mr17590235ad.37.1732806894449; Thu, 28 Nov 2024
 07:14:54 -0800 (PST)
MIME-Version: 1.0
References: <20241128143704.590211-1-adrianox@gmail.com>
 <CAC_iWjJAw96K_t3R-fywHvYh__r6dsyeiVvDfdg8TxdS+As8fA@mail.gmail.com>
In-Reply-To: <CAC_iWjJAw96K_t3R-fywHvYh__r6dsyeiVvDfdg8TxdS+As8fA@mail.gmail.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Thu, 28 Nov 2024 12:14:43 -0300
Message-ID: <CAMGU2hWn62XNHgZGoALir1hiBS=6=ZGTscafLcOKLYyY111U0Q@mail.gmail.com>
Subject: Re: [PATCH] lwip: wget: Fix incorrect rebase of 5907c81 on top of
 5907c81
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de, trini@konsulko.com
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

El jue, 28 nov 2024 a las 12:11, Ilias Apalodimas (<
ilias.apalodimas@linaro.org>) escribi=C3=B3:

> Hi Adriano,
>
> On Thu, 28 Nov 2024 at 16:37, Adriano Cordova <adrianox@gmail.com> wrote:
> >
> >   Commit 5907c81 ("net: lwip: Enable https:// support for wget") was no=
t
> >   correctly rebased on top of the changes introduced by Commit 6cc4d04
> >   ("net/lwip: wget: put server_name and port into wget_ctx") in next.
> >   This commit re-applies a  couple of lines from 6cc4d04.
> >
> >   Fixes: Commit 5907c81 ("net: lwip: Enable https:// support for wget")
>
> Does it fix anything in -next? Fixes tags are used on actual fixes
>
Yes, the lwip wget command does not work in next

>
> Other than that
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> >
> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> > ---
> >  net/lwip/wget.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> > index af48d741a4..8b3e5cf29b 100644
> > --- a/net/lwip/wget.c
> > +++ b/net/lwip/wget.c
> > @@ -288,7 +288,6 @@ static err_t httpc_headers_done_cb(httpc_state_t
> *connection, void *arg, struct
> >
> >  static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
> >  {
> > -       char server_name[SERVER_NAME_SIZE];
> >  #if defined CONFIG_WGET_HTTPS
> >         altcp_allocator_t tls_allocator;
> >  #endif
> > @@ -297,7 +296,6 @@ static int wget_loop(struct udevice *udev, ulong
> dst_addr, char *uri)
> >         struct netif *netif;
> >         struct wget_ctx ctx;
> >         char *path;
> > -       u16 port;
> >         bool is_https;
> >
> >         ctx.daddr =3D dst_addr;
> > @@ -307,7 +305,7 @@ static int wget_loop(struct udevice *udev, ulong
> dst_addr, char *uri)
> >         ctx.prevsize =3D 0;
> >         ctx.start_time =3D 0;
> >
> > -       if (parse_url(uri, server_name, &port, &path, &is_https))
> > +       if (parse_url(uri, ctx.server_name, &ctx.port, &path, &is_https=
))
> >                 return CMD_RET_USAGE;
> >
> >         netif =3D net_lwip_new_netif(udev);
> > --
> > 2.43.0
> >
>

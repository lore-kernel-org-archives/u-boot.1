Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A24D69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1967089369;
	Thu, 28 Nov 2024 16:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L5zaePbf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66573893B6; Thu, 28 Nov 2024 16:11:53 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 216B888DFE
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6ee6a2ae6ecso9749437b3.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732806710; x=1733411510; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fAPX17IAG5AfsUebpZf2JtICoKlVoNh/UwXJp0WTcT8=;
 b=L5zaePbfmBOf5meSLFCXEvnyZtQiqzwXWDdFyArUG8rhn0mYoCNEIG9rCfWsUAJtr4
 NI3fx5idrmL3bQwZ7BB9w+C13kDs6e7EhT6nryBQOsbY07W8KNbQXkNw/pvwPBQnSsL1
 /8V2ik1EXEk8ndbFeQwr1+cUIoIG2MI1gTFfx3VDeTMs+BLRlgXIOsZ4+R6NN65yqcIP
 PofgnMVJ4lgtpxCC+Z4eziZ+wupRe/ofcfUowy/1nCRuSLDuGcDP34AzbR1rn349mIth
 dZiDrYwWmmw1PWwBJOoVgaJ0ZRrrXqkD1CACDqXZC+l/GoArhimzyeLFP9a++1S2411G
 MIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732806710; x=1733411510;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fAPX17IAG5AfsUebpZf2JtICoKlVoNh/UwXJp0WTcT8=;
 b=G3zmVfWP7SqUXS+6IDbdSABAyfwzowmSHi7XLS2lQsb2CVrxHlZUUSGvXThrZXsftn
 q9LekC4oCIJmwcoXtdybvxV1IrnonCwDav9YIwiQg17zYuZUKCwvnurLBV3+WZfNEUvj
 DzjdsLp3R4z0R2NkMXYB8sBSN5Ba3GxI3MG87jYGYkpsJOmiuKMoEVRTEAgOeLE/a6hH
 8p01rcWv2ArnGQsv++h03AoHtKh2Cl3RdmwE1HJM3d0TMLsZ76WuUuyhfkpbpEJFzsy3
 CQfKmkids+W1snA3LRUDM8dn02EaOUMFnn6l8fZLZS3czX8Gtvsx41J6OfKr2jZr32jM
 qzdQ==
X-Gm-Message-State: AOJu0Yyw+4cJulKGgbSVJKWuLFhay3aHgAwfPsnDjN9MrKXmnXvY7vtU
 doWDCbMbDPestJxJIBu0cJxXdRQOG+fAgdjAJyxhVceA3i71U2RFXlwyGkhrDkzPVVwi+wwheh0
 SUR7obzDQ9ZkRRENBis3jVLcgOUgGQqHa8kgP9w==
X-Gm-Gg: ASbGncv4WfhcTee+bbmMlVdxNmkptDIF5mVIjFy4V8M/mdOGd7mXb6jgGrXMVuV+712
 ZSafwa5QqJkmqskbrkwem+Pe1M9CIOg==
X-Google-Smtp-Source: AGHT+IFbiK2iv4rDaJ4Ps4PKd66UBl4scph4zOIqIGmNG18Hwn8fcmcbh8WO83uDTh/cCoqxn+COG2mYF0A7+FsSWqM=
X-Received: by 2002:a05:690c:45c8:b0:6dd:fb48:118c with SMTP id
 00721157ae682-6ef3727fb8cmr93279217b3.31.1732806708505; Thu, 28 Nov 2024
 07:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20241128143704.590211-1-adrianox@gmail.com>
 <CAC_iWjJAw96K_t3R-fywHvYh__r6dsyeiVvDfdg8TxdS+As8fA@mail.gmail.com>
In-Reply-To: <CAC_iWjJAw96K_t3R-fywHvYh__r6dsyeiVvDfdg8TxdS+As8fA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Nov 2024 17:11:11 +0200
Message-ID: <CAC_iWjLmeh7bjei7nkkAqYBxwOjni356z0pVzB0BnzmQrqny4A@mail.gmail.com>
Subject: Re: [PATCH] lwip: wget: Fix incorrect rebase of 5907c81 on top of
 5907c81
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de, trini@konsulko.com
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

On Thu, 28 Nov 2024 at 17:10, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Adriano,
>
> On Thu, 28 Nov 2024 at 16:37, Adriano Cordova <adrianox@gmail.com> wrote:
> >
> >   Commit 5907c81 ("net: lwip: Enable https:// support for wget") was not
> >   correctly rebased on top of the changes introduced by Commit 6cc4d04
> >   ("net/lwip: wget: put server_name and port into wget_ctx") in next.
> >   This commit re-applies a  couple of lines from 6cc4d04.
> >
> >   Fixes: Commit 5907c81 ("net: lwip: Enable https:// support for wget")
>
> Does it fix anything in -next? Fixes tags are used on actual fixes
>
> Other than that

Well... obviously with the change Quentin pointed out...

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
> > @@ -288,7 +288,6 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
> >
> >  static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
> >  {
> > -       char server_name[SERVER_NAME_SIZE];
> >  #if defined CONFIG_WGET_HTTPS
> >         altcp_allocator_t tls_allocator;
> >  #endif
> > @@ -297,7 +296,6 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
> >         struct netif *netif;
> >         struct wget_ctx ctx;
> >         char *path;
> > -       u16 port;
> >         bool is_https;
> >
> >         ctx.daddr = dst_addr;
> > @@ -307,7 +305,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
> >         ctx.prevsize = 0;
> >         ctx.start_time = 0;
> >
> > -       if (parse_url(uri, server_name, &port, &path, &is_https))
> > +       if (parse_url(uri, ctx.server_name, &ctx.port, &path, &is_https))
> >                 return CMD_RET_USAGE;
> >
> >         netif = net_lwip_new_netif(udev);
> > --
> > 2.43.0
> >

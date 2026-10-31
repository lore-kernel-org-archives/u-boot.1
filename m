Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33F0606A31C
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qDtTXmIe;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jsYh2Q5o
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4965240AA9;
	Sat, 31 Oct 2026 14:12:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TDQ8hBYj2BoB; Sat, 31 Oct 2026 14:12:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 40E0D40A88
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455921;
	b=qHYbQwn+BbIXFyEK1DHd9FMf+JCO01ACB6F4zmsmyBfZp4/QL5DqN1rGN+zKUE0r+3zL
	 bYmpIA8kCrt0Mt9gwQrTi6nZ4VzUnRfa9WDvskgSKwKyfSKe4odIUwLU/JPNUloAncp2B
	 G6RS3L+RReIQL1CvV6FJMEr9xRjvjeia3vO3rxu6RmqA74IqdVjKHv16VhnwDb8jFqlEK
	 TWqhBsWh1Q8zldMxEScxyak/vxCYLQtBQL/FjmT4MaqgqiZPtjWTYTqUMzUrpHEEi+eKs
	 EPAFACgIdqHzJFy5NqeOkqj4Msoj6pWiE/heId/4AaGmX91KVyObEkuxmo5ocQhBC+w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455921;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=hN9MFf5ocZm5r5K7CJiT0nciEiQqaAO4R9OkTEqF2YU=;
	b=Mrb6wqAd1h+iWhbBvPVW8ds+mGO51417eyQLX0Wp5Jt+DlsExeext8OuyK00OXRCRc/p
	 eF3b9UoNQv1haO8hs4W5DOJZ3cdENLgL6kk8ovIEs5fwzqVXVcAC9X2YPLwNdkvPirHgZ
	 ATEsfnvU1naXZ8pvPlZOXqaHKl+S3xnb+fQR1qmj4+rrzkn5PyIXZrOckGF5yIl5UBz9w
	 Bh23eFEbO0f051mo8ITceI+RBjybjAtAT9Ok8mxMPUJj599sFrKmD90JVWUDHTxk9eOAv
	 rMXkzhvaNBfubntgqX3DyH0SFnQA1tY+Q65ibbVCcBe+U+DHayHhduXbeijbKwZukBw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jsYh2Q5o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455921;
	bh=hN9MFf5ocZm5r5K7CJiT0nciEiQqaAO4R9OkTEqF2YU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qDtTXmIeBKvhCzfE6NoFrWF4MDWmgJtqSFG9OR3C3M1pVVhtO3xJLbGtxna/Xo2P9
	 /m/tvWzkCBSMTEJoTRUlbF/ZDmd84Xfr2q+Lye5nRXxDkWyIHaIXDxLsize4pXHZlt
	 gQDMJZOEq42R/RVVMsTveQ2DJqHKOfo3NpKaQUvBRCZIp2hxuJnhnagcl+s4Iazbtd
	 RVMglWZz/GCo+nTfTTsmTDAw/yLB8i1G+9c2CqH3XzGPxT+7JiiWjKQ/mmbzzneYYz
	 QdQkYdD74sxtgFVCzhJKmjsTGBo+6IIZMAD/DzDxUtEUymwOLyxbsU2/R52I34kV4v
	 8ALVB3hWlBKBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40E0D40A88;
	Sat, 31 Oct 2026 14:12:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6501C1DE
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4A82E40A85
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:11:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B5bLXXiiLFxG for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:11:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2872E40A88
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455917;
 b=tBVdnzsqLrltrTYIwabM/hnJo0Ubimz30Ysqs2f2g7j+gNAMEy+DDFFKLJYP8v7zYSHU
 gw5e1Wh4wZGIi4Jbn1581IPixEc6UKjb2xALA6NyzNoAmHH6L+nv6DKknyZNwpDOiwgDc
 D/XtUeFYWkevIMDQ6NYS82Iba+bGkRAsEjSscIL67+Qukx1wgGfzktZSPGoFroILkY5Hr
 SI8ZqMI0XK/Fo0Yy8pnNee4hjj8+QME2ir1r73N2U3jEADAoGe/j41bGBD/MI+JQUzi7P
 QnST6rM2k6AINgQh9DMo9czlWJFYmt8DsTbV8zCw1wwk5pLuc8qyfwx44Ew6RMnozkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793455917;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=hN9MFf5ocZm5r5K7CJiT0nciEiQqaAO4R9OkTEqF2YU=;
 b=Y5gO6snatkW/RrJB9DKKJapK1dLxOk/BNh2V1K+eWwjRiG947L2Ia9OKHb+ONh5YHUrV
 a9ffIgTG2CfJPgeQQ2eGA61XDtQnv8w8hARl2djU9IFk6QQf78OYbjJJbCRL1JZxI1RKv
 4/Rop9BGyh1SvDR/awDd0rpzTWVjYpC8Vz5xnUahMUSYCegSpEp7jsNWkeBZmxaErSMn6
 4wq1kTjZVq9mZHWREXwZ9hzQCiAmuR8O9bPchoxP1u64AHYLzyfRvD5CseHQMqMMH4HgP
 bwCC+3qnmLEm4/za5t3kYF682g+JvblNzYzyvMcbqiKs6FAXnUuKvHRtqafOly9VyXw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=jsYh2Q5o; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=jsYh2Q5o
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2872E40A88
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:11:56 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6b3dc272dcfso2151925a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 07:11:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793455915; cv=none;
 d=google.com; s=arc-20260327;
 b=OXi6FfEiLASlGaU3GC8YLQk29dy2GPK/OxoAyu/BMmwzZiiS0quXKwRNRbN9v549Vd
 buz9P22Dh45W59kuO3dr6hdGApQxvsq6GoL5oiAuEEIhy02QnGHkd06G3yHERLQxJ5GA
 nL8SNud0fWRvy77z1GJr/1RgQ1sUXJhXbZJO2/Qz/zrQL9Jwom2F6wVLFFBG+Je1NHKE
 tLV3PRGxzLbZeq36IeaYDLf/riuKKbU55itbb/1CunBdVbK5GTtLDvyjS1xQzkCXRXtW
 eUXOejEAJybNyLOnXEFguumbHSd8TnqFgpIaQJgRBnLly297kqyD2QUGswNMVpJlti1W
 2Raw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=hN9MFf5ocZm5r5K7CJiT0nciEiQqaAO4R9OkTEqF2YU=;
 fh=oQmPeBjrnnwBTp33uuG5BVyz5lzAB6u3TOXTbbc48dI=;
 b=CYHo0Hs3rIkZvLdOe0ARrG1b/O2FVDFQDt26sJMseJsn8kYuttLUucLRwv6mdSWU15
 kUq1oLTLKjyeDlotG1OsbP5RW/m3tg0zgPTXSvnp2ItzU0NnYLPhELAI0dNSf2dtR7Zs
 XsqzPG5pnGPbJ6+qC2W0sINJXllEb71we0sI/ujInLgU2XaRKFlTxtvnvPyz2lTZ7l9Q
 AKevBomAnw3HAI8QyFxU8BDugN9Tyyn+Q0J9iO38q2i2/mfMtqZncGJO+qPfVMA452+T
 1L9f+7qPZOcD66/sP9Xh/5AyMfxLSVD3nW2rZq6ceTlYlRJ5el3gwK3eMKPDMoSepvTl
 u1sg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793455915; x=1794060715;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hN9MFf5ocZm5r5K7CJiT0nciEiQqaAO4R9OkTEqF2YU=;
 b=jsYh2Q5oZk+h06+pq15O0tCGhmAaeXYPMq6OOIBoTGqYprkgNCKklCHEKpuoBNY7XL
 +KmErioltTcxVUUFpRWZrX4U0kFlFnvRXROBb71motjdqTmyyaVKpjfcYf0T+EeCQxz+
 6eYDB1vrIC4hgEfKCnjtuwq0RSvVebBwaIJI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793455915; x=1794060715;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hN9MFf5ocZm5r5K7CJiT0nciEiQqaAO4R9OkTEqF2YU=;
 b=DbH2aDvuiJPlkX9UZeg+F19FYXfy2UhnM5BdGyThPNwcqaNZBiJ6q3WdK3197TmYvB
 JNxcKtWt7QrzHoI7V0ni/TEKACX3BFQb7v7OXoTjb2dWhvvvzW83++E6tnNs3Klf8Zxi
 rhJMeH6HAnkhCrp2oD1BYIoqT4XxSeRLWsHotBseSKHQkXzVFrDZtJUDLLIpRfwJbY2v
 lrbQ01xFqeKUqqZtvjvm1r+5YIBm8n5i3Hu5/jbHruXwm5wJ0eEbWNcuiA2kpTK0Dq2K
 +aH84GZTzz5lSaSxxE86+TyQycQ2tQTPLmDPi3fs/HKNhADi24IIjC1jKG/v/qjc38gD
 0aOA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2NjBs6RWGv5sgVWVvcubkp9cRL63CLvY7U2IFyJvp7ToNYELDn60r0yjMZ6EznUThVmNY3qo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKK8H7/oxPrU0ykSVaeCdGT5JUKtUxsrQ8U8mNJU1bNYjOwSCkY
 7q3aANBDMRLRV7nb7nGS3PN+zjSpfB8zaQgeW1umKFkpnKNTcO8dnp/sp8UrShEluqqlTpZmwfq
 la4eMrrt4kl+3s/rOZ+nIseINqNiPA2+5hw3sH1GA
X-Gm-Gg: AYBFou0Wjb/nrGUNZoiQGqCM0+/uWqStIM1afTtrZY1m80iL3neEwgE6SkeQPusU9p6
 saTl8681mdPVa763g9/BlI5JJ0V2Bk9i/sxLop7b0vmk/aRqowbWBiKTvRjKzTNTrfghVvreYfD
 dxDmpXty/CPNv2uNcFETqy54QkHLByjQIp2TKeTRBdI+g6Nm6Uteoa0kbEg3IqabyAJdlaZ/MB3
 Vgvsv6zvJclIjfunG7iRVfe6CrH+0lH1Oqe6drejR/EeePA+pmBKizs39daWoHIhKZzLc9HMO9O
 cvvjnfxOYoZ2p60LMvTw6wyp8dzXpJv+H1P5FLvrIoDU0lDzmA5dTPgk98mY4FhyPwf2fiE+qEo
 oo8RwBFcISvKOJTpvfLwk+aPktf57I/EIf0H8s+fDuSaa1UCoUlM7sQ0Dyl1vRe4T3Jh6ZIY=
X-Received: by 2002:aa7:c156:0:b0:6b1:b5ea:258e with SMTP id
 4fb4d7f45d1cf-6b4d5ee4953mr2940792a12.41.1793455914672; Sat, 31 Oct 2026
 07:11:54 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 07:11:53 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 07:08:01 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029201348.730274-2-ekovsky@redhat.com>
References: <20261029201348.730274-1-ekovsky@redhat.com>
 <20261029201348.730274-2-ekovsky@redhat.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 07:11:53 -0700
X-Gm-Features: AclHuK_6OEW1qk6EDZhgdiXMO4CUyTVw8p_wjrq4nWpILv0r8yVOOgI6z-ivcZc
Message-ID: <CAFLszTi-awYf+i1REfOavGVxhJUeOr9Hyt5mDs5DO2e4Ma0PUw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] Add support for OpenSSL Provider API
To: ekovsky@redhat.com
Cc: Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Simon Glass <sjg@chromium.org>, 
 Jan Stancek <jstancek@redhat.com>, Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, 
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Johannes Schneider <johannes.schneider@leica-geosystems.com>,
 u-boot@lists.u-boot-project.org, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bastian <bst@pengutronix.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Eddie,

On 2026-10-29T20:13:40+11:00, Eddie Kovsky <ekovsky@redhat.com> wrote:
> Add support for OpenSSL Provider API

Please can you add a prefix, e.g. 'rsa: Add support for the OpenSSL
Provider API' here? Also, the commit message says the Engine API is
kept for older OpenSSL releases but doesn't say that engine support is
dropped completely on OpenSSL 3.x, even though 3.x still has engines
(deprecated, but present). This means 'mkimage -N' stops working
there, so please can you say so in the commit message and explain why?

> diff --git a/lib/aes/aes-encrypt.c b/lib/aes/aes-encrypt.c
> @@ -16,7 +16,9 @@
> -#include <openssl/engine.h>
> +#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
> +# include <openssl/engine.h>
> +#endif

As far as I can see nothing in aes-encrypt.c uses the engine API, so
you could just drop this include.

> diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
> @@ -19,7 +19,47 @@
> +#ifdef USE_PKCS11_PROVIDER
> +#define ERR(cond, fmt, ...)				\
> +	do {						\
> +		bool __cond = (cond);			\
> +		drain_openssl_errors(__LINE__, 0);	\
> +		if (__cond) {				\
> +			errx(1, fmt, ## __VA_ARGS__);	\
> +		}					\
> +	} while (0)

This comes from the Linux sign-file tool. That is a standalone
program, so errx() is fine there. Here we are in library code called
from mkimage, binman and so on, and the rest of the file reports
failures by returning an error code. Please can you use rsa_err() and
return an error instead? Then the ERR() macro, drain_openssl_errors()
(whose 'silent' argument is always 0) and the <err.h> include can all
go.

> diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
> @@ -207,13 +251,44 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
> +#ifdef USE_PKCS11_PROVIDER
> +	EVP_PKEY *private_key = NULL;
> +	OSSL_STORE_CTX *store;
> +
> +	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
> +		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
> +	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
> +		ERR(1, "OSSL_PROVIDER_try_load(default)");

Hmmm, this path handles ordinary PEM key files, but it now needs the
pkcs11 provider, and mkimage exits if that is missing. So anyone
signing with a plain .key file on OpenSSL 3 now needs pkcs11-provider,
which I suspect is why patch 2 adds it. As far as I know
PEM_read_PrivateKey() is not deprecated in 3.x, so is any change
needed here at all? I'd suggest keeping the existing PEM code for
files and only using OSSL_STORE with the pkcs11 provider for a
'pkcs11:' URI, as patch 3 already does. What do you think?

> +	while (!OSSL_STORE_eof(store)) {
> +		OSSL_STORE_INFO *info = OSSL_STORE_load(store);
> +
> +		if (!info) {
> +			drain_openssl_errors(__LINE__, 0);
> +			continue;
> +		}

If OSSL_STORE_load() keeps failing before EOF, this loop never ends.
Patch 3 checks OSSL_STORE_error() in its copy of this loop, and the
same check is needed here.

> +	OSSL_STORE_close(store);
> +
> +	*evpp = private_key;
> +#else
> +	if (!PEM_read_PrivateKey(f, evpp, NULL, path)) {
> +		rsa_err("Failure reading private key");
> +		fclose(f);
> +		return -EPROTO;
> +	}
> +	fclose(f);
> -
> +#endif
>  	return 0;

There are two problems here. First, the provider path opens 'f' above
but never closes it. Second, if no key is found the function returns 0
with *evpp set to NULL, so the caller goes on to sign with a NULL key.
Please can you return -EPROTO in that case, as the PEM path does?

> diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
> @@ -480,11 +561,13 @@ int rsa_sign(struct image_sign_info *info,
> +#ifdef USE_PKCS11_ENGINE
>  	if (info->engine_id) {
>  		ret = rsa_engine_init(info->engine_id, &e);
>  		if (ret)
>  			return ret;
>  	}
> +#endif

On OpenSSL 3, -N is now silently ignored. If an engine is passed,
mkimage should fail with a clear message rather than carry on, and
rsa_add_verify_data() needs the same check.

Also, binman's testFitSignEngine() uses the dummy-rsa-engine, and the
pkcs11 engine tests use softhsm2 with the engine. I suspect these fail
on a 3.x host after this change. Please can you run 'binman test' and
update the tests and the fit,engine documentation in
tools/binman/etype/fit.py to match?

>
> Add support for the Provider API while continuing to support the existing
> Engine API on distros shipping older releases of OpenSSL.
>
> This is based on similar work contributed by Jan Stancek updating Linux
> to use the Provider interface.
>
>     commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
>     Author: Jan Stancek <jstancek@redhat.com>
>     Date:   Fri Sep 20 19:52:48 2024 +0300
>
>         sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
>
> Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
> Tested-by: Mark Kettenis <mark.kettenis@xs4all.nl>
> Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
>
>  lib/aes/aes-encrypt.c |   4 +-
>  lib/rsa/rsa-sign.c    | 102 +++++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 100 insertions(+), 6 deletions(-)

Regards,
Simon

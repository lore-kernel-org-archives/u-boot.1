Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEB5E8B362
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 21:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 377DA802C1;
	Tue,  3 Feb 2026 22:29:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AJSrcmy0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 705DC83DA7; Tue,  3 Feb 2026 22:29:36 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 376B983D9C
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 22:29:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b8845cb580bso1011865766b.3
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 13:29:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770154174; cv=none;
 d=google.com; s=arc-20240605;
 b=Zp+MmUu6ng9V9QUnWqoizZjnw/7Q71ytgJdLFDX/h2CFXWtibaP3hUre3GvqufDnqn
 gk+p8OOk124ji6GUNt8dX8bWIcO/OtE7pDKHhcjHyKs5ZllAO/oN+J7peMz8pIcVLm7W
 0lf6G9Uy1hdkfi1RC7zxQCAbRaqeNwehQZdRrmnWAW2XqBvs7bmNXFe2ZcjwqLxoh4Ps
 WXyFsTCBm4wsFzXRD4zIYg9t0JC/rULT1fAoZwvJtzNbT/ARtPcF2QcOwTqMFriCAvG7
 7r1kr9oa8jgGaWOuK1yAm8Lv7DhI1Tbkuw+AWH+1+MZtss/lIYLf76tY97qQupOwf0pu
 Dsag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4GHJgGeiF5aBm23n3mWPMXAvDwCgCxzb1TIJHZa8pqg=;
 fh=MhOytYmu8ayUQMxNcTtTMAja/xwhNJRqDC9iVEwZvXs=;
 b=ceCSq6oRxAhrJpJDGDxZ3VnPdPNrPrzti7tKRfhpb8aVpCqtN6edgiS7z5DuHZVBcU
 ZgtRkgsrR2bGSUojl40bGhGiYR1U3na3NMcz6qr1VtzbgMRENIFWHqh0NxGEp714UawC
 hhnpXsLCr4xaO1ITinqeOEgJQEsMRsRMxg1oPArbl/RRx+KCbtd2tGiVZnzeECIzFgpB
 tWcyn0OLN4+YKeXd4JoqtuqLG6UFDfaJ5rvfGRKruDXk2f5RuSmaIuPRVtjBebJsF/qW
 4SfPX9UUcOk//ZgQXbXjzHwQB6fXbpJFx2xRffStTefhqwgHXFJn+YxM4ZOZ+TaPkMB3
 cZug==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1770154174; x=1770758974; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4GHJgGeiF5aBm23n3mWPMXAvDwCgCxzb1TIJHZa8pqg=;
 b=AJSrcmy0/51NMgAkiNAXGETL+gTEPPiwUQ1ls4UZp4U2oosG9H7KwuFuzt8t8TvOUg
 UhEZVhRmE5hyuJPVbCn6KuArL3Z5s/kZui5tFhEwiGNjC3p1qU1EtHkch5L9IkFsR04R
 7pnIGOfixqsQPVE/vkqEDj5gmgDXSkVQXiays=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770154174; x=1770758974;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4GHJgGeiF5aBm23n3mWPMXAvDwCgCxzb1TIJHZa8pqg=;
 b=adkPeQ8PZjMC+D5PI7JGKojcPTxEKwMalxGae0OjYWBXXzTo3BoV3zeCLpqIzuPPY6
 QB16cTxYjGFbTM441JL95I7ado7QQwWPoH1zjVV7e03T00AoPuiy6G7MXv14RNvZICGx
 1Ajccw6FQCBgVSVhkcJNrUnLMqjL8GMLHIWIAMYexRcKx0804Q8np75MGNFAjZLcxDPv
 fR8x3MLgjOlss+bagcweSl9oLRNrE65TAINwUjx0rek8TXzFTwq/P5FRYTESFmc7/fIx
 SKUI755pBqnfVBQWX+iZnb9GaLMuYLhoD3qt6nohdu8cjDFLUv8C/XytfXmOBwOimuJC
 LBkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2DNQoSjP96CNEhL/oOWq6BPrKmkwfR4Ijd1Z+C1lNwfvOWvIiUzWeA69/fyG+EAOh6fYbr0c=@lists.denx.de
X-Gm-Message-State: AOJu0YwM6vUz4RFiarmftDkjtCmfBRSMFcGi+Vysqlzo5sHMR/+c3bo3
 gHtKSR8J+MvSCVQwQUubEnolVk71zj5K72aR3kmk3UiOezXW11DC/+N7SoV4QJb9yOm9fYnrXwB
 4/LyQq28hv0fyy0UPplJBaanrMo0I0dj2bItWPagz
X-Gm-Gg: AZuq6aJedndI1sXIdwv3sSsF17vczNgi8T1mbtMm7XGHzM/+MZJd1Aq/QlYlIjoSRvr
 JNfqorUyfw48YqAdF6XECY7nlJKllqENmonprKbj/XnmCF07/dsmVNnaXmy0pFZL14m6le1uvnn
 GR3ot7uYKgUTcqoxdLZTdx6AniiqZ+3LmaKRysvhJ6aDvvFLp0uJFztFIFZ5+vb6w5fYlNaBPz6
 8MFhV5dPj8NBEUvezWhkad908ch9SHPAsO+Be+5YozjXklde6NVM6Iow93vRm1cwbkBWu9FGWtt
 /5CjOw==
X-Received: by 2002:a17:907:fd18:b0:b83:a32f:8106 with SMTP id
 a640c23a62f3a-b8e9f32ccfamr60226366b.46.1770154173634; Tue, 03 Feb 2026
 13:29:33 -0800 (PST)
MIME-Version: 1.0
References: <20250714210249.4139916-1-eric.schikschneit@novatechautomation.com>
 <20250714210249.4139916-2-eric.schikschneit@novatechautomation.com>
 <20260203181444.GQ2603314@bill-the-cat>
In-Reply-To: <20260203181444.GQ2603314@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Feb 2026 10:29:36 +1300
X-Gm-Features: AZwV_Qgy3Yfb4Kjn1VaOHuI5VvQsU4KyodqJvry2dfTSqkAq4jN-idSBocJzJWM
Message-ID: <CAFLszTgLx_TtEO-8qq_9uojLd7PgFdUuhs5_6kYqL7GuzFt7ow@mail.gmail.com>
Subject: Re: [PATCH 2/2] Fix x86 baytrail boot flow, UPD/VPD Updates
To: Tom Rini <trini@konsulko.com>
Cc: Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 u-boot@lists.denx.de, bmeng.cn@gmail.com
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

Hi,

On Wed, 4 Feb 2026 at 07:14, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jul 14, 2025 at 04:02:49PM -0500, Eric Schikschneit wrote:
>
> > The VPD has been updated to include additional values found in the Intel
> > FSP_MR5 Integration Guide.
> >
> > Disable MRC_CACHE for the baytrail platform as this will break the boot flow
> > as well. This issue has not been diagnosed further, but I suspect it is similar
> > to my previous patch and related to how modern GCC generates the low level
> > op-codes.
> >
> > Patch 2 of 2
> >
> > Upstream-Status: Pending
> >
> > Signed-off-by: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
> [snip]
> > +     /* Set all values to known good defaults as documented in       *
> > +      * Intel FSP_MR5 file: BAYTRAIL_FSP.bsf                         */
> > +
> > +     /* NOTE: This breaks u-boot ability to set board options via    *
> > +      * device tree, but guarantees specific known values..          *
> > +      * you wouldnt use an uninitialized variable would you??        */
>
> /*
>  * Multi-line comments like this please per
>  * https://docs.u-boot.org/en/latest/develop/codingstyle.html
>  */
>
> And we should spell out that device tree can't set these any more in the
> commit message, along with spelling out why we can't do that anymore
> safely (why can't we?). Thanks.

Again I am not seeing this problem with minnowmax, so would like a few
more details.

Regards,
Simon

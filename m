Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFE4606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xobnr+O3;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sWZ+2UFn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F9E740609;
	Thu, 29 Oct 2026 22:18:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ApNHZA4UIKe; Thu, 29 Oct 2026 22:18:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 302D840735
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793312330;
	b=KaTCm3PGMG9HS9MgSKnI28efyKtGFC2veEx6Gi7yXGpg9bvmKhWeolD900PQQDwHdEB0
	 jAfnzk6Jz6g8fmQTVBaEBA9GuVCGZjNnTLr7yt8mhMU7lF3ZfwRLDcuqQgzxD00cM+83l
	 V9sOmv3/jfT+klBdouQ9S2gw2SUmbxWyl+/k+PpcGwBVBqugIPSxZ4A9FjOX0aSO4YaLs
	 9BMHiKqPzXkcbyy7A7dQBpcjqtPzDCNgOwreMb2FHcrw65/jENBpTJ78Xy+DP6AWtmJcP
	 bUH/3V0JSVjM0akEhUU8CTsT0TV1UemsXgL6nwRL5exMFsHv8yb+b//daZ/dlk0w7Ig==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793312330;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=U8JRJf0QLBCGYE5PyHXN4+b7U+wmrB6urN+r1j1G92A=;
	b=aZGzlfG5O+dgArengRwzlLixfcbMjxf9aKktns1h1Rrf8K1WO/kTRQIOsf4J/Jl8VExp
	 wPA/RZczHdk+WWO/eC1lDlCxasCEHAsqp9F7XbibcMdjp29StAvvSpGB40uM//rsDSYTg
	 F4ui4eZwa+3nBiy1KLnXojLtTrXmeiWA4hmREGO0nbUaFyXeLFwJua2hXHqucu5ORv/QY
	 AIcMhmxFbravozHsjnJTL7krNeqgbKu/WPVNFHe9Ww+YcDN6ZrGDkSXfgkPca6ZPlWURd
	 lHuk3ftCbqbE9UTBy1FkvcoJgJ6HcLbexIp3O4OA3D+1mFt+eYJ0ZywSqM0rxqTW0Tw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793312330;
	bh=U8JRJf0QLBCGYE5PyHXN4+b7U+wmrB6urN+r1j1G92A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xobnr+O38vbXG35Ib1qycxyG5DvhxQiZF7J0b1uSiHs12gAKt+VAIqerp/WqrtRML
	 L2+xcOSmXcvm34AgWa+PqFvkJYS7dW3lxcah7opzanbn7tjWE3tTx2uyx8eWVmRU2i
	 VLrEAN16qjMZnjwmRPEcYmzS2lIyQQmC4tDKR2HIjujx11VTd9Z0RR9cEYsUklHAje
	 POCSR/u7d/Jnw0ELIDLz6rVITbk+eB8WuR7MV3HRFuQVeautyU3i4HEjpTuyN366+c
	 4fPkD1m5R4kizWC+pDCdnzvPWwX+r/vFj+Wn3J/rnuIntc+O5uuuhfW3b6JnE1dn62
	 Xal0QfBqGf4+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 302D840735;
	Thu, 29 Oct 2026 22:18:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 74FCA712
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:18:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6677560A79
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:18:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TjVZPoOwpDVq for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 22:18:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1BFC8605CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::633"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793312327;
 b=hpm3/vlCdZ8LN5HOcOjwlH0xxrnQtLRXFRsYo0STelHXzhCFLJNYwEStDiu1o1GgOBXD
 rxaVnkjzb2Q1iZ7CK/5fFs9qMBHK12zSrKqH5OXCNmlustiqluHtQEhQLQFUUkswsz/Eh
 tTAVovonPnlOUvQ4drjHp1z0KQVM/g1DnkgZkmyde+xloY5ItoIc047QqO0TmQs3o7GB7
 zwaXp48m2JSQ1p/lk46lMSm1ONqtrAatbKJE+S3qq+jqgbkUi0PFfeI3DMEUgFxrvs0xD
 MXYA0rllOryHntzESvGL28OlLl8Lz0Y+goAGqGceDmFO7uQQKbfXPUmPhFZZCS2x6HQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793312327;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=U8JRJf0QLBCGYE5PyHXN4+b7U+wmrB6urN+r1j1G92A=;
 b=EfNkq85tsMc/9JuPHq4IMwcuAhCtP6CSFtV5VOJJJh6f4+x2fZfeRsLaIM1y501XjEJ7
 fQcUvL8INnsNUeazybAVbp15NzslqtfMQb1E/tkVPskzH8mteffbOjcbXaXOZWDslqfuz
 c0iwF2VhQZs+1lyowLcA4G8wzfmok7ALXUaTlS6zyoN5tps86EZAv06DhKYvVX8qN32Sk
 SZs1YQxJGkXn7fkkqALOFhs/GuezK8Jo98DtOc38/EhTOcPTzgL0mrfH5ermkmQ9aaAWF
 2iBYL1nv7aWh2dq8zhJJrkNFJYMgAzE/gOhe/twkegAiSciieaW/nPOtkeFNC3Waxdg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=sWZ+2UFn; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::633"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=sWZ+2UFn
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1BFC8605CE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:18:46 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c4c9abc1824so3865166b.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793312324; cv=none;
 d=google.com; s=arc-20260327;
 b=JIpIu0Qo6Su36GwMJ4mi7zOybt9435Is6+i/7oeq1fFmYOsDIoK0MNl+XOWYwv2JGE
 5fGgEOvlmLdn6E8kP1JMjjre+BGSa7R2yPSjYWJyfaZN7/ISLckp00xz3O4FIltFYdwF
 rD+MKaiNXdFNlAUpzGsV4VqMidRK6oE7H6H8tqV7vxVqmRwCIpWlr1t62OThSf1UfMqR
 bpsUeaMCqvHhq1l0216GXtIiWun9L6eFojWSZfF4CXq1UaxGRIm2MWGcrH+LOQ3R+dBs
 oAaRWeXPJ8w3lAzZ+DCXG5B5lvQ6PV+9S/kPSQhtUSNdfYvE8tN2YjQLiqsRt2n+MIeO
 up4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=U8JRJf0QLBCGYE5PyHXN4+b7U+wmrB6urN+r1j1G92A=;
 fh=C4kIP6po4JFkF1jCFAnzjPS4M6EVoapB9Afmj8XncJM=;
 b=F+bC5ka6Nfn6fXTNa99AwvwLznTesQ3JbaMSm+iJEq+Pc/tR4tkSaD0psXKzNOEA18
 RU8RPWOOtKWkrKg0EC+XeBNTDV9e4tL8Wh3ubq53qkOMfGd1cxheYFcCKc1nTBMtD0JC
 n+VwgMf+4pk0M36tx9xYLPaCZjdeIQnt2OsAO/GV05DF3VNUu2a04oqM2azBIBtviqvs
 opdQ4hnllOVCLxVuTjK3ofVssb5qdrpnbaInJw2Nx/yXZvsi1mCiVNwE87Ml+FZPsr1U
 mzJZeiVyB+8ROYp4PyHJLkqZtbbn6K7HQMVhsWob8Mp7bFA9nEdC7eIRBYY/I4AxhJjE
 mt0w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793312324; x=1793917124;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=U8JRJf0QLBCGYE5PyHXN4+b7U+wmrB6urN+r1j1G92A=;
 b=sWZ+2UFnWo6CSQ34VEt0WanpCnRChTmbg93sXydctr/o+XbSUAKb8RYzHWTWDKhyjn
 tR6NVoEoR39Qvq7xuRDLqtha46eP5BJ/4sN3S8uW8wWDQNfZc4OIzMbI8h/wITxFRwWR
 t/NGl91YeEwbMwLfVwITTc3xxftQDyuqQ+s5jfi2N49Gk4VPDabaU50ifXOsam03TdP7
 pUkO13fpOkeNH1wo50r5GWuEb0Ju+q9680APxVIDBKh5I77iF4MhSU16vt5X6Ts0clFk
 LbKC7MXt6x1vhd6Bx/7Y/VDSB9fnukEIPXBo9DZcTmfw0+4sHIBShGXe3FFhb+Dn7ICT
 Pflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793312324; x=1793917124;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=U8JRJf0QLBCGYE5PyHXN4+b7U+wmrB6urN+r1j1G92A=;
 b=Hr39Zw1mwa24OkoQidtBabsKEqvCJQG26DhDUMMMQox7T+40QJZStC8F+CNYJv4KM5
 gldpGZw+YqFiWbfD9BA5o3n2nqpnCcr8wo6ce1UoqF1OIx5sSPo1+XPQ4qtjP8A7ATPI
 u89fJzG/8ZgZ0Z2hJVlWtMnL1StVtjIH3yzSYP4fGZ9pyjjLygJHnofdCOK/sN4b6Euo
 8zpcojQoDE81f23/Gm22/BecYNXUX2IKp9Y3FJYbYQoIGgGJ6RehMICRgIaX3UVo9mdj
 J2uREL0jrPW1uodqq62myV398LglCVCKFIFecrHERY/gSfOdVJy0UmWtlQJLJ4s0uuaS
 2uAQ==
X-Gm-Message-State: AFq9FYIDmmgfpial+pZe7l8ruy3FHrc41HxEMTCsyRBO8usO8RpYm+jW
 HYmnKSAcf/ahvWH6x31sym+FgybMf3zUu3/ip2LJ0yksOotQoIS7m99CuVbL+PY+aPTQDICVRni
 fAZCWZ/wQD5X4a5CTePHrnxwbkr18qxw=
X-Gm-Gg: AYBFou2unlSe0267uIRtmTmObXwoz8iZh4cOozurD2CH6BZQTOKdxV6c8vrvpO0xSG/
 CA4/+/XaAuG0lewp9z4H/q6fGrXzBH3YQZ/R6dOnG9Y7aqOmW9EptDiL3YRn9TTKVKERwGuz4p6
 9NUCYLLHVFXQP/OLBrCZq7DglXq+7f+4uHdyiGK7EPLE1+/XMTQLJAtcy4EO/imJTTVAjmTtSnJ
 ERcr9ppaEaQDawei5TJy9+xVhVRFTPOAO33WzSTE7Lg2VMUZchR25zVZB0fo9ffP3NJCNk1Ps4p
 gv+DdESK2MVU4Erir4n0FcKJ39flECmWkSabLzoEisrF+ODtvS6fXL/Kd0N7br65uf7H7zc/0Nm
 FOZaroXh7n3+l8Y6B0tR8qotjkjHWmB+GaYxqADJW/v1yWxPMUL7xiLB55Yo=
X-Received: by 2002:a17:907:d406:b0:c29:f5d8:9c6b with SMTP id
 a640c23a62f3a-c4ca7aa01ebmr38440166b.26.1793312324454; Thu, 29 Oct 2026
 15:18:44 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261018-master-main-v1-0-e07455d232bd@gmail.com>
 <20261018-master-main-v1-1-e07455d232bd@gmail.com>
 <6f3b7c32-05be-4f59-99ab-37978fac5bf9@0leil.net>
In-Reply-To: <6f3b7c32-05be-4f59-99ab-37978fac5bf9@0leil.net>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Thu, 29 Oct 2026 23:18:33 +0100
X-Gm-Features: AclHuK_R2M2MFabrethbq5wjk4dc4u3tzhN2bmC288oxNDZn07EvpQBHIPclKRE
Message-ID: <CAC928HZt+qymeZhCbrFWGLaqdaz91-jC8L_fMk0fo=R95S_Hig@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc: Replace master with main as primary branch name
To: Quentin Schulz <u-boot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>
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
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Il giorno mar 27 ott 2026 alle ore 19:00 Quentin Schulz ha scritto:
>
> Hi Massimo,
>
> On 10/18/26 5:59 PM, Massimo Pegorer wrote:
> > The primary branch name is main, not master anymore. Update references
> > still naming it master in the documentation, replacing master with main.
> >
> > Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > ---
> >   doc/CONTRIBUTE.rst              |  6 +++---
> >   doc/develop/sending_patches.rst | 12 ++++++------
> >   tools/buildman/buildman.rst     |  8 ++++----
> >   3 files changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
> > index e0394515702..b012648e3f2 100644
> > --- a/doc/CONTRIBUTE.rst
> > +++ b/doc/CONTRIBUTE.rst
> > @@ -73,11 +73,11 @@ considered as reasonable amount of time.
> >   Development Branches
> >   --------------------
> >
> > -The U-Boot developers use two main branches for developing the code. The master
> > +The U-Boot developers use two primary branches for developing the code. The main
> >   branch is used for the current development cycle, while there is also a next
> >   branch intended to land changes for the next release early to enable wider
> > -testing of larger code changes. The next branch is merged to master shortly
> > -after the tagging of a new major release.
> > +testing of larger code changes. The next branch is merged to main shortly after
> > +the tagging of a new major release.
> >
>
> I think this paragraph would benefit from highlighting the main and next
> word with double tick quotes like we do later in this diff in the next
> file. Can be done in a follow-up patch though.

Added in v2.

>
> >   Similar to Linux there is a three week merge window post release after which a
> >   release candidate is tagged. There's typically a new release candidate every
> > diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
> > index b4f82eb18e1..8b8a70da4bb 100644
> > --- a/doc/develop/sending_patches.rst
> > +++ b/doc/develop/sending_patches.rst
> > @@ -36,7 +36,7 @@ configuration file and ``scripts/get_maintainer.pl``.
> >   .. code-block:: bash
> >
> >      b4 prep -n mmc-fixes
> > -   git rebase -i origin/master
> > +   git rebase -i origin/main
> >      b4 prep --edit-cover
> >      b4 prep --auto-to-cc
> >
> > @@ -65,7 +65,7 @@ fold them into your commits before resending the updated series.
> >   .. code-block:: bash
> >
> >      b4 trailers -u
> > -   git rebase -i origin/master
> > +   git rebase -i origin/main
> >      b4 send
> >
> >   Using patman
> > @@ -132,11 +132,11 @@ General Patch Submission Rules
> >   * Send your patches as plain text messages: no HTML, no MIME, no links, no
> >     compression, no attachments. Just plain text. The best way to generate
> >     patches is by using the ``git format-patch`` command. For a patch that is
> > -  fixing a bug or regression of some sort, please use the ``master`` branch of
> > +  fixing a bug or regression of some sort, please use the ``main`` branch of
> >     the mainline U-Boot git repository located at
> >     https://git.u-boot-project.org/u-boot/u-boot.git as reference. For new features, if
> >     the ``next`` branch has been opened (which happens with the release of
> > -  ``-rc2``) that branch should be used, otherwise ``master`` is acceptable.
> > +  ``-rc2``) that branch should be used, otherwise ``main`` is acceptable.
> >
> >   * Make sure that your mailer does not mangle the patch by automatic changes
> >     like wrapping of longer lines etc.
> > @@ -452,8 +452,8 @@ today. Not all states are used by all custodians.
> >     it will be accepted for mainline.
> >
> >   * Awaiting Upstream: A custodian may have applied this to the ``next`` branch
> > -  and has not merged yet to master, or has queued the patch up to be submitted
> > -  to be merged, but has not yet.
> > +  and has not merged yet to ``main`` one, or has queued the patch up to be
>
> Spurious "one" here?

Removed in v2.

Thanks. Regards.
Massimo

>
> Looks good to me otherwise.
>
> Cheers,
> Quentin

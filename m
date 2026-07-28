Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE78C54F54
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 18:56:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A093B60A3A;
	Tue, 28 Jul 2026 18:56:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YvCI1Whj7XLC; Tue, 28 Jul 2026 18:56:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B0380608FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785265010;
	bh=vcwSVQJCKVNzndkginxbyk275q2TTkMZfvXXoKGkDZ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JVWPCHH12ZlNbua4yxes2Lp4P/h7r/IhzpEI+ZswGKbfc5BVJFXzj3SUxVXVV2vob
	 OSjpHAkI0OlTp+vekKFbnKSeGf9Z2xCn8VjhfgMAbLS48LGUlOkbwYPRJg99QJOtg0
	 zIBBWKSn3cIMaCEs8oQ1hXKvawgBpEjRu24sjPcTRINf23+KB6Sa8MSTTP7kALZb1n
	 gI5LhxH02G2jl3n6Cweeg2YZCNMUZl1UjyijqC9O2tPH4O6pbrV8pm65Do/MRycJTb
	 6G+O1/NSsEm+cG7VHKc9iR0bKcFpBmPtvEieYmMbj/3rtF6KId58Mtn0a2kR+xUsaP
	 Spba9etRQadSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0380608FE;
	Tue, 28 Jul 2026 18:56:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 48FFB26C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:56:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F02040A0C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:56:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cmf9WyeJ_3-i for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 18:56:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1CA06409EF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1CA06409EF
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1CA06409EF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:56:48 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c1c26d7e951so28476066b.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785265007; cv=none;
 d=google.com; s=arc-20260327;
 b=dSdw2auKGvQuDWGhWdjgrH2qxIVt6++rm9Oy2okr3INGABEnwAvghQgryCGB6go1GT
 qPzTTXED4sqoHEkmk9MufsOtIQ5ZorYnimirJa/vOvRDLlsBGYbQ3K+bNOnItCE0Is01
 1E1hqhYQPfTQJ1aPkyErnxO50T5AK6uPAVmuyOFyVgZTT2lHhnwspqcVg9R0/tRDgNpq
 CoB5ZvXJszBX5dXkLckxj4SSJMxJgB6AZTYILZzmAbmJVNcZt0dzLmLr5DF0fJYcgWFL
 q7IZFqmmT6Qb/HjnozXGN7KwEhmI3tohhjpdybhhcAQ7EHBtw1A9s+e0vvmb0rFtToN4
 ooTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vcwSVQJCKVNzndkginxbyk275q2TTkMZfvXXoKGkDZ0=;
 fh=K2wRAaH9ucaJd2sS37Dqsxa4E2UPayxCqiQy+IpyGsI=;
 b=d7hlZoK3244GukAi4uOkN9Us4Mf4vi0f9HhJfweuDonpAy4WmtgWwx+LkClZSZNt+W
 GumL86LK6JJf/uj6tB5jFwO9WoycXQTM4J3mAZWubso5K22YfzHUQWMUV8LYHOh8ZdYE
 pL2hwEJPBntbluLAsuSYgAE2F52ywZFJ1G9Tk2kRtk8lquJ/ETiunnXJ63yQKAop+3BH
 JZZuEGLfKKxYVKocGszFgn5JffUXfqfDv5Njcrp2WvbL1AdFpjR54B0upOPVtJxewa16
 2pAnCSZA/cjlwnIIvq8vsD1UjAN3i1PQnFVwKtPCrImcdRPP4G2geu2mQPq0BUl5z1Le
 sGJA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785265007; x=1785869807;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vcwSVQJCKVNzndkginxbyk275q2TTkMZfvXXoKGkDZ0=;
 b=CXHVMxpptooczQlRw3G6D6pBoSEUB6KACp3IFvIupxpGp2Mh4x1hYpVcL72KGMu1Sv
 JV/B0C5+fQy/zVxw8kmYfMsKYiYXKgXlhSVocNy+maiWxrjOSSQ+pajJFbuWQaj/Sqar
 vsPkoP93zOHyWcGwU6V0HXhkS4fXrQWwJwl7d/2Pf7HWF9SeLZ3BDhBVLy99bULxt/k4
 2vE2o2zCP5dMyo/+qtP2qjnRqHkEYUlLK5DJ/9K4xQmt67g3MA9+BSZW3C71XF2EgaI3
 GawVz3mEIQtRJCMvRf2bAUEda8euuqzThGdtWwbKyZtZizhI8xi8D1qGj1iCups0iWKO
 O2qw==
X-Gm-Message-State: AOJu0Yy7tS+Z1KVi4/4v1AUsNh5tp5Z9lCxqoSjmyJ8kkKXC49kbYQXv
 yeVAMs2mHIWwiF7VlXAOyaSU1MUP09ZR4Pmez+6INrdaWGk2JHJWUsdp1AL9VC6/f7SCkgHp0Uc
 NLGfXRUmwyqR2ur1rwb5/3kmTntPh/aXBAQnuvS67hYIu7nGIdew=
X-Gm-Gg: AR+sD10RRFzsoz3ORVHnJ6l82hMHhb4OrMIq4bw/HSjVFpBO3/VB6iFv/ZIvXbIhC23
 /dJSiGgziJQa3DlS1qYVll0blVXHJnW1G6Q8o5pKBS5tCN0BRhKVfl3tsGm2Sxai/vB3Mnwyu5H
 LAdqWG6wc2A28Za6xk51gLdBZiE2mZ4UUtA3ph843mdzyjA/4xDZQzg1MT/tmiCG3TPpt279Ic6
 b1auS4wp/W8xzaftLgORPoFOkM9VzPz+107IsXaMF8fAIQyCaU/N3nze4VKwLcNzdCw3NI=
X-Received: by 2002:a17:907:8b87:b0:c16:9d13:26ba with SMTP id
 a640c23a62f3a-c1f7221e483mr201172166b.35.1785265007013; Tue, 28 Jul 2026
 11:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1784601041.git.daniel@makrotopia.org>
 <CAFLszTgMxNnShY+WrNXxTwuZ2RMoqXDj7L5f0CofcDwNeehJOw@mail.gmail.com>
 <amj6nyd_JNOQczLt@makrotopia.org>
In-Reply-To: <amj6nyd_JNOQczLt@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 12:56:34 -0600
X-Gm-Features: AUfX_mySaw-2PVDzwV-cChBaUFbyKeKdlyuKhR0Zgyv9ULnktzu6_2RnLWcqdV4
Message-ID: <CAFLszTjfL2zWY3jpn4O1noZ7VUtKnNdYhjrJc+KOdM2DqZhncw@mail.gmail.com>
Subject: Re: [v3,0/3] boot: fit: authenticate the dm-verity roothash
To: Daniel Golle <daniel@makrotopia.org>
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785265007; x=1785869807;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vcwSVQJCKVNzndkginxbyk275q2TTkMZfvXXoKGkDZ0=;
 b=NFSOcLGFGnN/swth11UN1MHZ5Q2n7y0Iu0ysu+RVCwZz7gpRk+gmHmaYj1XJoPPzxb
 0kQgN8RITMeXjt19GqtALKDB9DED/FW5rVRsNtIJqLUjn6zxFWSmnyZm75IF3REOiUW9
 E4tcvdJlJTru/VYD6pzgQoBr5Wzug4t+BMxVM=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=NFSOcLGF
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Daniel,

On Tue, 28 Jul 2026 at 12:53, Daniel Golle <daniel@makrotopia.org> wrote:
>
> On Tue, Jul 28, 2026 at 12:45:38PM -0600, Simon Glass wrote:
> > Hi Daniel,
> >
> > On 2026-07-21T02:34:47, Daniel Golle <daniel@makrotopia.org> wrote:
> >
> > > v3: address comments by Simon Glass
> >
> > Thanks for the rework - the doc additions in signature.rst and
> > dm-verity.rst read well, and the test fix is a good catch.
> >
> > I still think we should state the compatibility break explicitly
> > somehow: because U-Boot rebuilds the node list rather than trusting
> > hashed-nodes, an image signed by an older mkimage that carries a
> > dm-verity subnode stops verifying under this fix, and an image signed
> > by the new mkimage does not verify on an older U-Boot.
> >
> > The new language in dm-verity.rst documents the security property (the
> > roothash can no longer be swapped out), but it doesn't warn that
> > deployed images must be re-signed after upgrading and that mixed
> > old/new fleets need care.
> >
> > The break is unavoidable I think and I may be overthinking all this,
> > but it would be nice to avoid people getting confused.
>
> Technically you are right, there could be, but I strongly believe
> there aren't any "deployments" of this right now.
>
> The whole mechanism is built in order to be deployed as part of the
> **upcoming** OpenWrt bootstd method. As of today, there aren't
> currently any deployments using dm-verity on OpenWrt with this
> mechanism (apart from some boards on my desk at least, and people
> who have tried the PoC[1] -- which is/was a PoC and obviously subject
> to changes as part of upstream review and standartization)

OK I see...and you would know :-) So that's fine, thanks.

Regards,
Simon

>
> [1]: https://github.com/openwrt/openwrt/pull/22177

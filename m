Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469ACC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:19:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AED2E80214;
	Wed, 15 Jan 2025 14:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m/yr88Sz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A35806D4; Wed, 15 Jan 2025 14:19:37 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D43B780040
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28881d6so9800258a12.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947174; x=1737551974; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s4yBGBe0P/Iz0RYbFRdYCHPw/9gJFH6nuN+r4GLkfGI=;
 b=m/yr88SzhjRT3yp48A6QPRPXPDZ5hAt6TUIUf1ANLkRPkTKcxDkCN/7Ifkl7Ib1vaY
 x7JamhNh8+bBSxCqqH5ryESDleW/T/W49SLjsKMRfhx5EiG/XzmaI1v+B2PV9jKdmbE1
 UotPUitxgWWshlTDj5ldT+YcUqWtmRm9kmEYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947174; x=1737551974;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s4yBGBe0P/Iz0RYbFRdYCHPw/9gJFH6nuN+r4GLkfGI=;
 b=pqXrydY/DSenep2XJzxchdDykNhJvZ0M043i/rPC535K7vPptMFeiw/XshH8/6B/rW
 PQaGc5Bfb2cNrnnAvoBgue3F8UAIrPRgHBxH/Lz5JQjDqEQlB6qGJeyzLg8xJ0vqW13R
 6wfhrRto7eI36FeYf5lXFadwcYYYR/BNgqvLAF+2WNwgH6e25zTgjLRm8db4th3iT+aE
 dZLwwe/tydgKCj72V3DOdYI0r6hXFTWw80eIjTursSl4GC90/c/rg7U3nSWe+BisZarW
 jfOeFaCLAlDqqRQHFgfCfhrSy4IiMNiv/Icl9zxW+o/UMrlOGyKGOKZCivJr4kVH9YmE
 bdNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRY85FSnOU4+Ht3KcqOlOrvCR/vb93OgQvh31G8Evpeigki4RLmNLv3Asujrv79coTl/rTdCE=@lists.denx.de
X-Gm-Message-State: AOJu0YyiyOJrlg1ErY/Hvorn+C6iCoZH+ji2JkFEVE96vG3GBfCvAyO+
 7YOc9q4ahgs5ep4W/KH771rC9uh3E4ki4veFX6jhHBz+RYAj7VWS5rCZGxDLwe3F2Y39O1pRHh+
 crjkTobjjJtN0ONy/aslTov6wQreIpeEK63o6
X-Gm-Gg: ASbGnct2fHDkQBiyxdvegE6FKcvyi0ecJbryLD09rI9n0IW8aQJ9QiFwxIhpAdKwk8D
 9K1BLZ6kbpF2TW3aLfpvy11tXm8JkP2GF5Kr9Isg=
X-Google-Smtp-Source: AGHT+IGr06IRJSwkHjSSs70zX2rXZjiwNxsli9/OydhCAdHyuUYFPB6P0YfmIENyLM3/D8pIYUQcTexPTKdcJRmyhic=
X-Received: by 2002:a05:6402:2105:b0:5d0:81f5:a398 with SMTP id
 4fb4d7f45d1cf-5d972e00056mr63196822a12.1.1736947174293; Wed, 15 Jan 2025
 05:19:34 -0800 (PST)
MIME-Version: 1.0
References: <tencent_9739C1044069984893BE3E6D3DB783BB6C08@qq.com>
 <3d51107a-4761-4de8-9bae-a462c2a8e890@cherry.de>
In-Reply-To: <3d51107a-4761-4de8-9bae-a462c2a8e890@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jan 2025 06:19:22 -0700
X-Gm-Features: AbW1kvYDPBNhKWmpThfEyzCFDyjO5lor55qgnETVQ4ekj6nI3OulEo_HBXYkP8c
Message-ID: <CAFLszThNpc-L_hOdqbKs_4Rr8ZLsRQniNVMj_Ae9tEtY8d=ZXg@mail.gmail.com>
Subject: Re: [PATCH] linker_lists: Update the alignment using
 CONFIG_LINKER_LIST_ALIGN
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: 1425075683@qq.com, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Quentin,

On Wed, 15 Jan 2025 at 03:58, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Liya,
>
> On 1/14/25 8:09 AM, 1425075683@qq.com wrote:
> > [You don't often get email from 1425075683@qq.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > From: Liya Huang <1425075683@qq.com>
> >
> > This patch updates the alignment of linker lists to use the
> > CONFIG_LINKER_LIST_ALIGN macro instead of a hardcoded value.
> > This ensures that the alignment is consistent with the configuration.
> > Replace __attribute__((unused)) with __maybe_unused and
> > __always_unused to eliminate the warning of checkpatch.pl.
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
>
> This... is odd. I don't see an earlier version of that patch and your
> name/mail only returns two patches on the U-Boot mailing list. I believe
> Reviewed-by needs to be publicly given on the ML as they are a proof of
> review by the mentioned person and is usually a trust mark for
> maintainers to merge code. Here it may have been added without Simon's
> consent. Now imagine Simon is not answering for a few days/weeks, the
> maintainer could still believe Simon went through a proper review and
> merge that patch taking that into account while no review may actually
> have been conducted. This is making me uncomfortable.
>
> Same issue for
> https://lore.kernel.org/u-boot/tencent_CCE8303926957C427AAE06F9D91282458109@qq.com/.
>
> I'm not saying review wasn't done properly, but its acknowledgment
> should be made public by the mentioned person instead of being put into
> the v1.
>
> Have I missed an earlier version or discussion maybe?

I was wondering the same thing, actually.

I don't see anything wrong with the code in this patch, though.

The docs are here:
https://docs.u-boot.org/en/latest/develop/sending_patches.html

Regards,
Simon

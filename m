Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAEA606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=n/UJXSIz;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=SgqFFMed
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1119D60659;
	Sat, 24 Oct 2026 13:03:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QD0t582zJ863; Sat, 24 Oct 2026 13:03:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 57D6D60724
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792847014;
	b=ns2bGO3IX7gVapJlWQ3D8p/mb9rd+vM1/gMpYXXF3baDEMqjte9p7jp6of75kGkRdmlM
	 1a4dew3YAQ75kmWjAEmDlpqa2wFX5/SaML8eSRhFapqIZcGl81P57WG2hxZgEnBS9UZ9m
	 a8Nfeuaq9Dg2XU6QWwLjK4sHlhTidmjm6ft3vu9TbwSURhi8WPc2/bAzVXdjKliLFkGb1
	 75vxqmRryez0hb8ZM4vLBgA0u3mFEcPM4yRj8x8+KF+pdoPSophe7ntXoqPF7sYFwS+a+
	 sEw2iH+DlJ/dNJPSYD4WQddleD67l0yBhvVdnnTbX3loTK0k89XlHsTr1zaaXz7E1cQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792847014;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=N44hTUi/icGbj8jtqZl1Xtl2ROWQ0dMqWIuj3Clvi7I=;
	b=Bl9sSlIUIXbixXu4ilFkxxoUr3IPqZaqAhfy7JAWP9q+IgSwv0nWCh6hHvjtvrIR6GHT
	 tTq4YqBL7BEHiy8RJxMu0dXK1QrlBTPscso+XWoUv/aOhCUEFeOXC4dG/dWDdNQVLk3OT
	 XFD2bIeZS+gTuT/dwqbFJpnnfLB/4cKH9F0045lExveicJBhdUsRdmq7zVEQ1rWe2eBZC
	 61qkaiiIeHijcB8O7wz96LYjyaYGXLQikPC/+AuMx1I+udaxIKFNB9oWnvcmNGOEZfB8t
	 A6y2gRFWAXprNxDHTwox1Pq6hQtES1+OuyVTe+zf1al9QbfQlGDWr2AVEeX7kM45+Ig==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792847014;
	bh=N44hTUi/icGbj8jtqZl1Xtl2ROWQ0dMqWIuj3Clvi7I=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n/UJXSIz7sFALGPL0QYRl161PNgQa0Q4Q2vkESOtnJ0rkNX4o50eR2A86S0BnbZb5
	 O8dNnfPMcIEJ+Wj/yXnK7RJXzL78UWjBwdwwxriAyuIv1MN6Py/Pkw5fX63Kik/CMH
	 5BarllwC/cpaNaoiX6NvOc5S0V5BtvwhUXSSaWk2Nb9r5jnmkpmcsHDZkkqBfJSGnq
	 ItTbmaQfVAmMxCcwXsVRPuKqFSHDDX5QaijkQ2a6t1zIM6TUuu1gr5lTO1eS2AJKbN
	 scbv++hv3yVda1hUEwKmpxBSJ7XXAfK8rzqXPfY4q8xJI6gW4ACEyNrLcqKlnkeOcA
	 CldgJCbIi5GYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57D6D60724;
	Sat, 24 Oct 2026 13:03:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DB276235
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CD2A78162E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xrIFHWD45sQj for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 07:00:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B976481589
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825211;
 b=PXK7q5jVzxfeM+44IJ7owhpqMlTLjIM+eeS8l63w7IjNN3zrL9z9ZmGC8qt3vPD6ii3z
 OmO+RexpIVhHnGCZ5MeofyrpSNzsTqDjOYbBzaRz5LhPWaHetzjs5m6GVz16Hh33/3cCV
 rxbn2KwiTDyc4/7cCXH4iEnAmVbH/Pcp3bzixjMcT4fP0jzm8VleVOrqocvogFclvrd/U
 kUFSQe5CJzXDFDEG7TvK9fAXrAVymPhvIPZIoiVhDEKx7GxY+GT5Gii9JCkdofpcmcYDv
 vaU0SIw3IYSzOuhs3oOKJR7Q+yvFrvbEB29A8PPLg9cUocJaVocihfTQ44PtMHm5PYA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825211;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=N44hTUi/icGbj8jtqZl1Xtl2ROWQ0dMqWIuj3Clvi7I=;
 b=YodHyz0vPLR2YniBkepXVruo7rGPZXMtYeYLYcBzN6rYY0Rhxc/P/D55TgA/i+xPEwqK
 v2HrsWSV5xsa8AY7LL60mkin+wdpYo1gtxBn7XQbxS70+JldOsqMZYS9WTA4kjbVd0vLY
 Iv55njf8BE4q4wpqs4GOwzYOl9XdBRTAb9QPUZcy8D6MYKfxRjF9haPr3LZiBFTgneZk/
 iEJjLEDACG6xKT7V4dRC9CERIAugrExSE/xqroT0HIppmWJNumlNsrO2t4Pk0ruWaSrB4
 dpuuN82AnCvPDAwAQnrSFg/DJPwhmX/b0iCf9QN5kS95C66PH5qJDoLYwBgKRmFGBEQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=SgqFFMed; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=SgqFFMed
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B976481589
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:10 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6afbc363efeso2493151a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:00:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792825208; cv=none;
 d=google.com; s=arc-20260327;
 b=nyR23CKvsle894CX2PJ4T8WtVMvsLXJH8Xub3YrSpsFil0RoEjJVnLNvPT/8D5ffFO
 Rg2iL026uJF1/a5xqecsNx/EiN/kwaoU9QP8DPxcVL9nzOO0kTFESd67LurXV3m4VA6D
 kyN225eVK0RwNYdtJZCaE929TyjX5KlvP5paOOml2ReU3xufAgy+cNqfx+VupV0DjidM
 E7c5S5CrUs40jHcLjCKvIbu4Q2IK1o8obbuCLMOS4Ad/ouQGaI4r4ZANJ8bwuryy94AJ
 NI+BN7ta6KLBTqhAaygpk+CpiXyRYmwVrrR/rWoKrDJYQL+/bmFrwekF4faieBEaDO5f
 8Pig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=N44hTUi/icGbj8jtqZl1Xtl2ROWQ0dMqWIuj3Clvi7I=;
 fh=K3qBHk2ExO+3ijmhm2JLE5PguYt4WNVvCbTK1y2ofoc=;
 b=RPgz/8toZExaAoTHKsJvMHtOL0ozqPrwPH6m+VxTS0Fgy+FNTPLiAeTHcaDEYV4ZfB
 TQ1huzcaEdjI6nUP1Aunl92D9WAc0QIUkyT9B0+PxABBbPhf3vrGVDMrp4Py0B36E6/C
 sF8ZSRyEMHstq6ff0LU1QYTl5oWgcxDNJbliKiyjKbA0jQcOGM6LSPWHaYBt3xCBt0TO
 FoBL8+quSHUOxk273BAGOj+Xn1tlck14xyf2K6RLxtJldBmT99hRSa5HWK/4QNdNqo6E
 vic2oXrfVEgs/JVHIuIDEbzd+o5ZYqBxDZR5Ue5yXnmbyc2S1UD+hyg05y7d9QL36JnF
 i2DA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792825208; x=1793430008;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=N44hTUi/icGbj8jtqZl1Xtl2ROWQ0dMqWIuj3Clvi7I=;
 b=SgqFFMedpcaBd/4WpC6s1aPLnJ4wxU6+AiTX8XhkVUdncm7FMtwAZ9njLnjr50Oh3X
 lxdUrXKSj2YuqRYidYmF7yxIEr8Zlr+bMsQTVwOJViDZA/NjtaTCgKAy0uNWtfn+vEJE
 2kwiRZPegoYozAPOCcHW3Aa+kWS7NWFt8QidY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825208; x=1793430008;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=N44hTUi/icGbj8jtqZl1Xtl2ROWQ0dMqWIuj3Clvi7I=;
 b=LVKyZRWZYv3mJ3Rqul6eDM5MJJG8UurzCRKvNQ+JbI5fvRf1SfqIUFj4sJJu0Sq597
 mLk66nFHO3AIMmoG4oc61/BCRfueHvud3/MWQ+ASKLnsFz2oIvEgbL4mOdpRV/erJNl8
 Y1JC6/nNN5RyFUOlHUGIbIyVbA1lS1urAU0GU7ugcdBisu/UY6ibzJTo5lYbt7sE1p0p
 QaTGG3NCQajtcUjwWKa5iq9KqvhVnUhwAKfcMO3JB5tyDnr1wP2bsIgGLawmrF/+SbfO
 PptJCdjPn8YR4+rndhT6o7JeiSjRRCp+HcTm6Q0OvRu/a7gvgmCHCkSYrWrcqoE0Cv6h
 Ghpw==
X-Gm-Message-State: AFq9FYLHtFQnxP0eKM0W3dArhtlLT3AXHE4byAPIwJhQ/C3JyEGVeHMz
 mjAA7ChJ8uAU34Z3T4+BGOXa285Q+eO5TlREkS+FoH52s1le3dtXaQr++jaA5i3cJJ3qcgOvMLN
 TC+bhCsgjqVTsLecImC/DkgxsxzhMJfQUp9eTregR
X-Gm-Gg: AYBFou3VgM3ofgTNV1TdVi84YcedfEUu8VCdTd8j4raEBXd7AiOABnhcQAvXZux/fRS
 XUvslTPRRuggXy2eytHYgjIl48GEJwVkT70FVq7dPQBjXcuAXRc3JH+xZXXFZl2dqwV9OCkEj9v
 i2nfmp5DOfkFF9J3i2u41wnbaTyyis4Ixli+YI762fRbPf26aCmwxDG0Ev9sV+nnM8aLKAXrCGT
 amWd+avnPWs2AI8Zktskt8aE/F9mltzPLrAnHPx48orajK7509BLKRVLkPTRfUxmeptVhO7b1FR
 UK2YPZbjJ+tKslp9gw43Xdvrxnhs+7uRD0ZxZnSktYuN+p0n6kjok7dKzmuXWZTLtS+opcFtm7s
 CNSLWt1MFVIBHOdHLySj2RVrE6myA7XBdJdo+eUCkEcNjpDFjy0k7/PxD
X-Received: by 2002:a05:6402:2022:b0:6b1:a509:875 with SMTP id
 4fb4d7f45d1cf-6b442fd86bfmr1142180a12.20.1792825208269; Sat, 24 Oct 2026
 00:00:08 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 00:00:06 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 08:16:24 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-spl-fit-compression-v3-5-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-5-6647aa23ade5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 Oct 2026 00:00:06 -0700
X-Gm-Features: AclHuK9YFg1wQbT2FvTQewV80ydEFsjRNQlloperZf01W_tHiOjRHNOn9Dt6CCA
Message-ID: <CAFLszTgs+VpTjdjEZxDdS9spCSP=z1xVq02cJ-qzaOqAGhRgYw@mail.gmail.com>
Subject: Re: [PATCH v3 05/23] spl: fit: Look up the compression without the
 table in a tiny FIT
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, u-boot@ew.tq-group.com, 
 Petr Hodina <petr.hodina@protonmail.com>, Bruno Banelli <bbanelli@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 24 Oct 2026 13:03:24 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20T16:40:47, Alexey Charkov <alchark@flipper.net> wrote:
> spl: fit: Look up the compression without the table in a tiny FIT
>
> SPL_FIT_IMAGE_TINY keeps image.c's tables out of SPL: the OS of an image
> is looked up by comparing its name against "u-boot" rather than through
> uimage_os[]. Reading an image's compression, which SPL is about to do for
> any decompressor it has, still goes through uimage_comp[] though, and
> brings back the strings of every table in image.c: around 2.5KB on
> tqma6ulx_mba6ul_mmc, which has SPL_LZO for its multi-DTB FIT.
>
> Do the same for the compression, and only tell apart the algorithms the
> phase can decompress, by name.
>
> Return the compression rather than fill it in, and count an image without
> the property as uncompressed, as SPL always has, so that the caller needs
> no default to fall back on.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
>  common/spl/spl_fit.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

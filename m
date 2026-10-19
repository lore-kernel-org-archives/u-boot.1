Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCCFCCF2D4
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 02:35:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3A3560612;
	Mon, 19 Oct 2026 02:35:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AN2uLQe26Cwe; Mon, 19 Oct 2026 02:35:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CFD5160656
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792377331;
	b=etTXU7m+1IAmnx3fPrhTE1nG5TmME7dJsCIEkMG+CLqim0TWEAtlyAYQFpw9FZDOdeqU
	 mMZCedNZozPGr+VglM+8h4npwc0NQRNAGzcvwE8i3/KbWAn28KTgyZ3yP8V+zGLTibhjv
	 882URmIhLdFzlIKLEgxlaMh/O8vK6/BzYdNLKLBiPuhtq7sfptDwPcRFJVn3gAHa+dTRq
	 q0qTNE4GZml9a2aBxxRyyStCYL4n3W7BT84uPtZC27tHrXl64Tt26ApYst6LHYDHJa4cf
	 0b5CYMsLp0knYSDfuA+epegOOyX36Cthh/mFWKhwbQQQNCrERSzUrPpGpMXBVIQUR8w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792377331;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7egZHB3Eonci97jjWtIMp+8biSWFoje1EiOb6Q9RYzU=;
	b=YXHTewO9MmxLuwU0AO3uqPG7KdekVeeSkS4GjQHc8UHuNH2YOKwgjz/Y6o5HAYeMKf6j
	 wNaFyqPYPhm483kDmdPzoqb/37CwP/gDvvl8B0ut1Bl0QFM2D9yRrcJ/EcaL40AeIf3ze
	 HELb85YDU3Gn8fy5HUCQC+FdT/j+9o5252+ZS2BvoikWhXYsxnX6n9jV/NqZVMjfAwMzj
	 bUisIUeDksMcDElg/tUhf/zcjdCO1PcqTEmWezhPqNpeyY2KJp70V5tUm4sFrraWzLD4N
	 k/z3szillYqsuspAyCIZjgD0V9GuzflXZXZrplooWKCRonRMukhyCGCnaEME4Zmv5SA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792377330;
	bh=7egZHB3Eonci97jjWtIMp+8biSWFoje1EiOb6Q9RYzU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0rXBEcpEfZWbKlLepCX2tMC5Bnfzb7qbzUJ2oZFM90iZildkio/qt8Iq9At/Fuecr
	 +dr43IT+lUdBTZd6FBhSIjRpcf4/b0InlpbWGHns/4aKQpDepeB32jq54AYqYK1KPr
	 IBsA+0U0yHOsCUCJEp0D8NBvJLqPvJX6WlanGlVwnxH3bxE7poYD06dTCRAk18tllz
	 nZwr5sgheqx/27ldzYfR9xRs8fdvea6BGjaJpU30qvuFylxkRcgtzPO1YkuXVIvqz7
	 bAvBw6YN5j7VFzkbM386KL225X3e043r2kSleZaq4Kb1zwrZkV9Bz2/5JZ+6ce8/wy
	 sznHOYpjMg5UQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFD5160656;
	Mon, 19 Oct 2026 02:35:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DF59D279
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C576E406E5
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:35:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NP7G58yP7mqU for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 02:35:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8CA2E406EE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792377328;
 b=Xn/p4Lsg9Mxmb5DhgeQf5AHP2aqAHaKeBA42dHK2y2yZDFAavJ/IFNDy45TCtKKka6Ma
 +3hPF1ynUin+F+WBvoDAFru9NlhO2K26+2TeQrdzt2/aQbDwEEfFHpy7ZzpF6XgDixUqk
 1tlRDBVB69aqtXLqBnk/q5I5chjTlf1Axao53SEm3+fk9KTms+k4TFzMlAnqQSAyuzxzu
 7gvzYE3rP+ciQCfOdTDrRxfXYRQBKMEK3IstkOEyCU9tRMrsMCqTUDYeVXDMB28zww7Rl
 dhxK3g4ciycHNxpsGp00LPwDeHUaQ8rHKmtK79Y/OZA5LwLA0uzs8qfYxFy2NjqvNYw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792377328;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=7egZHB3Eonci97jjWtIMp+8biSWFoje1EiOb6Q9RYzU=;
 b=CUOmvz7PxK4QBEf5sMEen4IRMgf0zTbviuhV8SjspCJq6Fa4WPOOx5ZmjpMOFUgSextd
 uVAzlfG2F981f8wE42jAQ5H2LjRcIm7wycGtVTTn03tHK7qjgIQjtVndq7ypSjkjUW4xR
 ZZP2ptvghiJTLD3GD13NGea8/TSaMXxLVph12x2FhWanp18tfk69f8KYPSUGorQR6zhP9
 am52k2YLsU5m+14FCv/38DSLZg7R1bHH79+cMXFDnF4QSZBPSBdtyZoe/Qz5FHFOzoFMQ
 4B17hZyDqD/U5ZzNEF7e6fs+LRajg82A8BMd0XRXM/17Jyz52HyGHRF4QNRbL/AEfjQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hQ9HCRHe; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hQ9HCRHe
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8CA2E406EE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:35:25 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6acba4bf65eso1755197a12.1
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 19:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792377323; cv=none;
 d=google.com; s=arc-20260327;
 b=asvJXIHMmvf+le4x6t/4YqGGF8qN7kJ6YYE47WZDxrFyf23i5Xux3f0TtZXD+QQlMh
 Ige8muD7g/T5rACBDtVIa6IET28CemOOOKZNGPTIX1KxMH9Q7wXmJENK44JlbhHC3SVo
 JW665qB5+n3qiz7hqNuGBIC+eBi/jAt5gbA4b8dyyCOuouo1novEQ3KOqV1hVeAwkeiC
 nm0EBYIjYCw/IC2J0yIwnu+lKgROQmVcRG76X1Sdlj9zW8pwbLPRvzaBNNup4cXX/2qI
 cZvUjLBdQooTgnL0OSCxAM6DwyljQ9bBOOlgcRy/JYSKBLM9wnbPmWB9gZuAt3UkrRLC
 xRTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7egZHB3Eonci97jjWtIMp+8biSWFoje1EiOb6Q9RYzU=;
 fh=YTvqMESiZqb9MltCeoV2ssRUfVtCr3/YnJCIUwV8lLo=;
 b=BIreKav5skfRmeFgXtheU1Xw5hLha6IRb49QUkSiLGN/B35jnALXmAgqiyUCCpfbsX
 VowV7Kju6U394djbLP9kuqUB/Wtn5TclQEo6T9jjODXkZvesHrgY7kVa03sQcUmrbogE
 /4H8CT9mvTqPRp+bzH6sqAvGpProkBLJXuUSSDS3AviAjjy78TXMu/2QYg2iY1bABvPA
 waUgrUiR1Y42bE9dREkokshSiGS2bafQLHaaf/uO3FkJBEi/qzAqotxGZvF6KA8Wf8A2
 d8fOiVskOTkZiHMs//RxShzEOoissCjSoV70yZ+fbRUqYum3N/Zc+1Aksp6WNvudK2dD
 QoOw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792377323; x=1792982123;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7egZHB3Eonci97jjWtIMp+8biSWFoje1EiOb6Q9RYzU=;
 b=hQ9HCRHee5YmzfXvvvJOxAHc5TbE2fI+GRjG2KlVhP4dp3OvWy1yk2hYjGC4uQPTnN
 7TkIjAuuA8UUPi3NgI5uH9814riiZ4OcQa2Y/mwV5lxhQlamtjXaFrorx6kDLP5Uk9ox
 DYAWhGNOhcWDFLn9iqFsSnDC8hPUANvAGTiv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792377323; x=1792982123;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7egZHB3Eonci97jjWtIMp+8biSWFoje1EiOb6Q9RYzU=;
 b=J0DWBnodtCddnYyhQJHyPeikiYc64WTQBRFwowspPUJ/mjhcaRXHYQIDERpNjCJqB+
 qpFIbu6OK3FlQMufgnzYiA3FcJQcy39oL7DCWdXjky/RepiEquwvycNXgKVu6Lk32VpS
 o9jBAjFbIPefuNzjQjfUf5+km6rl8nZkiPSf6/cHK3+W64An+sgfc4xZZiLj5xyg1sJP
 azP4Mc65ra0N4/CUh+YQAijURAPKiWi8tr2uLz8mvgGX5rx2HnDd9jg85ITKZ6zSFPAJ
 mmY8NAIBQf+F9GR3WT+QZuRPD7WE4t7IGGgfEXCgeeO/6oA49rl2Wc03Wi3DLAu27KTd
 GKnA==
X-Gm-Message-State: AFq9FYLNz7E2y1nMoe+FOPwzG/HDm1v2Top6IS7lp90SO53ddnroxg6Q
 dAY6gvsK0ZWmtAHeGV1QoXL3r5aUg4Pc9I/sjuFppYz6XuZf093CvYUO9ikU2Jur4Xq93t4oAei
 SNSz1gfTeP2sH41gsJaLuoRXqwNw7l01UxWqWQmIa
X-Gm-Gg: AYBFou1CmUOQ/PNYg0qgEjMN5u2KIeeh2vi+68Iz0xcaFadehaqwn52i7VhBYSkzK2E
 sf/pYk1yYXa9+r4uxfMUbQJ3brqw5glgwDGpcvmzBXjPhnliRdxfxAWxt7mfqIS0j7yblKBv/mC
 MCZHTY8MJAwEXNDgLiMW1lQbsnpg6AiYBOvXtau6seSp0j9xp2KvudMQNdzeVADWeGClL11+esG
 x4uruRFdP8Hwxj3yF/Gx/uJL7jPtQh4x5ecLCywlo1kmd2ZsJ+QDdaMjq6tFZD4F3lPglsBKp11
 zDMNB05dihXkYYbITv8SKkZ8II/uQri0cpItIHeKPV/C2vXeSiOyRw==
X-Received: by 2002:a05:6402:52c3:b0:6b1:d961:ecbb with SMTP id
 4fb4d7f45d1cf-6b3a81995acmr3769458a12.32.1792377323594; Sun, 18 Oct 2026
 19:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20261017-b4-simplefb-a8r8g8b8-v1-1-ce7e80682a5c@protonmail.com>
In-Reply-To: <20261017-b4-simplefb-a8r8g8b8-v1-1-ce7e80682a5c@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 03:35:12 +0100
X-Gm-Features: AclHuK8OUjOWecOEAtWBJp-F8ivkA3PQ_guxGCYGJQ7OQrIAHoxM0VF7DzASf-A
Message-ID: <CAFLszTg70Kior1RwwiWxKK_EQ_onsJyj9nbZMXh3c3xdVGr0Bg@mail.gmail.com>
Subject: Re: [PATCH] video: simplefb: add an a8r8g8b8 format with an opaque
 alpha
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Aelin Reidel <aelin@mainlining.org>, Luca Weiss <luca.weiss@fairphone.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, David Heidelberg <david@ixit.cz>,
 Petr Pavlata <petr@acrux.cz>
Content-Type: text/plain; charset="UTF-8"
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

Hi Petr,

On 2026-10-16T22:07:56, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> video: simplefb: add an a8r8g8b8 format with an opaque alpha
>
> Map "a8r8g8b8" to a new VIDEO_A8R8G8B8 format that writes 0xff in the
> alpha byte for the console colours and for the BMP/logo paths.
>
> Adds support for the framebuffer on Xiaomi Redmi Note 8 Pro (begonia).
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> drivers/video/simplefb.c     | 6 ++++--
>  drivers/video/video-uclass.c | 5 +++++
>  drivers/video/video_bmp.c    | 9 ++++++---
>  include/video.h              | 1 +
>  4 files changed, 16 insertions(+), 5 deletions(-)

This is also a behaviour change for any existing user that specifies
a8r8g8b8 in a simplefb node - the alpha byte now gets 0xff rather than
0. Worth calling out, since on hardware where the simplefb window is
composited with real alpha, previous versions would have rendered
fully transparent.

> diff --git a/drivers/video/video_bmp.c b/drivers/video/video_bmp.c
> @@ -461,7 +462,9 @@ int video_bmp_display(struct udevice *dev, ulong bmp_image, int x, int y,
>                                               *fb++ = *bmap++;
>                                               *fb++ = *bmap++;
>                                               *fb++ = *bmap++;
> -                                             *fb++ = *bmap++;
> +                                             /* blend on alpha */
> +                                             *fb++ = eformat == VIDEO_A8R8G8B8 ?
> +                                                     (bmap++, 0xff) : *bmap++;

Please can you avoid the comma-operator trick - hiding a side-effect
inside a ternary is hard to read. A plain if/else is clearer:

   if (eformat == VIDEO_A8R8G8B8) {
           bmap++;
           *fb++ = 0xff;
   } else {
           *fb++ = *bmap++;
   }

Also, the /* blend on alpha */ comment does not describe what the code
does - it forces the output alpha to opaque and discards the BMP's
alpha. I'd drop or reword it.

> diff --git a/drivers/video/video_bmp.c b/drivers/video/video_bmp.c
> @@ -423,7 +423,8 @@ int video_bmp_display(struct udevice *dev, ulong bmp_image, int x, int y,
>                                               *fb++ = *bmap++;
>                                               *fb++ = *bmap++;
>                                               *fb++ = *bmap++;
> -                                             *fb++ = 0;
> +                                             *fb++ = eformat == VIDEO_A8R8G8B8 ?
> +                                                     0xff : 0;

If you don't remove this (as David suggests), the VIDEO_A8R8G8B8 ?
0xff : 0 idiom now appears in three places, so should be in a helper.

> diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
> @@ -86,8 +86,10 @@ static int simple_video_probe(struct udevice *dev)
> +     } else if (strcmp(format, "a8r8g8b8") == 0) {
> +             uc_priv->bpix = VIDEO_BPP32;
> +             uc_priv->format = VIDEO_A8R8G8B8;
> +     } else if (strcmp(format, "x8r8g8b8") == 0) {

A test covering VIDEO_A8R8G8B8 in the BMP paths would be good, perhaps
as a follow-up - the existing dm_test video BMP tests only cover the X
variants.

Regards,
Simon

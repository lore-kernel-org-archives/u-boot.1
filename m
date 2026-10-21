Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8C6606A31D
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mFjc7vVf;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MZP59jGc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C4046084C;
	Wed, 21 Oct 2026 13:08:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5kgqCCNtvfIn; Wed, 21 Oct 2026 13:08:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A3B5B60719
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588089;
	b=hbKdxZ2yP1E7X/05R0hsOViy4A2ArDVtkmdlVyp/4q8GOycxnCMwsno8hA0drCmWZk8Z
	 3vO4OQ18s5bftRnhEnVnlap9oFJYcJLhCF3tuEjT41VAJhOSpy24n4HnYb0s1t85x5uxn
	 UFxs508XqiETnK8ohs/sXrjwD+FlAVnnA0v/TLChlpp7WIWdiwUBWdpnI3QpxzynY/rCs
	 oWx126GooISSExH2K7V42u3r8INhzXHGQrj0d37sT3XkpYnf/kvnDPBN/hWOCGwONCKp9
	 RoMgb2YM3RrKBaCrY26mLkT2aZTVoORMO5rWpIrMs0Ln59kwOkIgB2rz4BtuSAIlKmQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792588089;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KZE9QWuux4N01rjD91cwWBbD7eMyP876RRY8NlIryWw=;
	b=sDkJ96hziuRdhiVSeUYakETKEXTjobioAvGNCds8bwa1BTRbyanIpLBTkjgSgf6+Ynks
	 9WwGeq598mt3YiVghy1zcne9MhHNTLVQ765SWiriN87f065BFQFXDLT8Fc2veYvLxZkQF
	 opu9YOCr1j6+64LQbKJSqqUffpG89veYFFGIN/wc6VmJYoNLJH4WsMadX33J/qH15+nIK
	 k1rex3XMY/bVlnPx+CbUGqMfJxLf+P3+sR4rvz8bmteYOYJwyd750qWmOGs2cUwX0lt0M
	 E3MhXSPgvdElm6t14a3F0J8j+RCcszSHUsOxzXVAHzXs0VQDlAFptXG62LF+R9Fa7DA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792588089;
	bh=KZE9QWuux4N01rjD91cwWBbD7eMyP876RRY8NlIryWw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mFjc7vVf1bbq6TriU1ymVQEwL+8weGVoG9idoxrXvKVHGmovIEw4Wb3UDlYpJXeeE
	 O2J+iwwDl90GUnUBeyU1QOHPvldecoD+BmXlOoeSij4/ounR7uqVZQQ60gIcssSOIj
	 aTLKr+8LItmJhp/6BVXyfMeiQeGTK8QtiRoxisfV1s/Il10hNhfrVHHkH/GH1o1oMH
	 eaeamXhO/fKYiQCKEvBoEG0w41uvwfJiyexWEfxvYc8jLZ4BxiFuiCUSbXsRsPg9AN
	 Ej7lRrLwticDPOEvWlpmnNEkUlhYIymlU/h8yJOvKCD82+l33yNJ77v9v82eYadfrH
	 UzVAf55qcmx5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3B5B60719;
	Wed, 21 Oct 2026 13:08:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C9FB73A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:08:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B00B5408B2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:08:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Yp1njoc4OiJ for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:08:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9E70E40866
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588087;
 b=YnoOymbLB3MTyb+jpkRL45YxSe3sQLIogdzRwSvIvFBhEEYcddkevDUJu55+C7qxs/o6
 /LRfHUcIP3ZqKnJ7hgnttWRT/fJy+8eMBAhg5l703Fcg/QQSnvO3PwI0b1rkMjB92ufeu
 3GagrTSqQixbwRTZGUrAH0UMyqzCzVgdm8KW0+aYRmbG61J01cVE580BRbv2cci/iznQC
 tHWSICqoCt5FmuIYiMySGmbqAldDFsTyOTzMjOGKXYW8WIyW6g7uOBcCdhlrrxeaxGEpP
 wlluU9TyguQ1ZSxxKFKZ78jGDk/G6fNhzVdse+oI+esroOuwq/VWcsRqJB5Q5HQjS3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792588087;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=KZE9QWuux4N01rjD91cwWBbD7eMyP876RRY8NlIryWw=;
 b=Fp2AZnYeOLDlMY4Lgh+mEsPopkFGVTTOUqKs/i3Bo1XgSaO8iToVcdA+73LzeVJJnKTs
 muC6TuefOmYsJ68tm9Hrf7JOD20pGdO7wbN6zGv41EQ1nty9JzDlkbdvyIsPDniaglj0D
 YpjSWN48aCqu/1knYQD76dUEaMpN8j5Bw534+cg7BJ7OW1Ys8iRTgNBURy/NORhxil6yp
 4TvSTLblTpOtbhZ9/MUSDMEl91Xi07w3RF8Q5AZDTr9lZOUL/wl84k6p+xyPp4vmeaDqB
 KrSpESrFK28vVhEGu0lRi/GTQy5tU4YfRzwf3bibMEcB1cCINCZCjhrSeRG0/n3eriw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=MZP59jGc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=MZP59jGc
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E70E40866
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:08:05 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b1d8944cb0so1043703a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:08:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792588084; cv=none;
 d=google.com; s=arc-20260327;
 b=IStoBJltrLLLtLoE5RIyjQlCt1+XJ2EqWIlp/T9CPPBPYVKunyINV43Fqu+MIwF97k
 UyeYb32thE3BQBSVTFw4G0fdmPUgLmzRuRgzSJQJ9Tr3Wdd7HsYBasChQqPUPxrf3ceI
 yjPhean96PM5QYkFZ8eJxVW0rGrvbfEUV8QGyqEMvT03OIfQlIRQeDKkDx32Xkx3UjsY
 bbs53GJqdnACA93NTY/KgtAorkg3MPo7eiVADebzgm37DK6a9L2RTVUEctW5f9wKUHzI
 5rHbyBOc+SCfEW9A7ODCI3s29NKqjHjc/jc3b4qL0lOi2U8OPVsXBSG05yLCpCH0ZvPm
 lLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=KZE9QWuux4N01rjD91cwWBbD7eMyP876RRY8NlIryWw=;
 fh=rDOkmCQJ9cozxuZkgmyNWj5k0ThXnY0U4gnSEgE31/k=;
 b=fZ1KtZlR9P8uF8bR3im+/NH41V1/zejKfGjRIQ0GbY08wcvqsVutUjm6TTy6a39wd1
 cZBdwilIvKN52D5CrfcAh328SBpCxLlP1faegjgXoo9TtVCL1WtUiHCWz/dsnn8fz0vU
 n6PEKFlu50N824z4Z11ubGwYF7tNL9Yr33UnZwnqohYg08zJRHAj9Z69CjTl3v/K/Uzu
 B+jyMD/8Dc4YeLeYaETGcclGUW7soDwX8PunP7qq3UCWCi1s49stOTKS51z8JisupI6z
 02d3Ccq/rREl4pc1D7+4y9EB6Qu5xARdis7h8kaCk2yzYHA73ojrzWEELX1RpfZyKtrk
 My+g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792588084; x=1793192884;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KZE9QWuux4N01rjD91cwWBbD7eMyP876RRY8NlIryWw=;
 b=MZP59jGcoOBtWZUTysHdQX/AkfjWj4dnyGQrHOlJ+BC6JOJ+s99L3PZUdrkkdpRWSd
 lGeAvVFtnVsTjazm7P2m/ugKSSmOWp6VHXnnMSETdL+GON27gcLJhQNmhvZyVx/noPbD
 LKfGdevVS/nRcQ+5YkwAh4P30NjIeBGINzKA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792588084; x=1793192884;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KZE9QWuux4N01rjD91cwWBbD7eMyP876RRY8NlIryWw=;
 b=aQEmbP0NwrnUcAAO0yQzY78aIITHmLUKXb8oKKCM6UYEb+iH0RjuPrD0YXwbY9d5MB
 vTswDm8PgbfjBN4cELRYIxpWtddBsDqfM6YtGPsMtut5vVoCJ5ow+UawkwXFrcr2HhOO
 GGT6x+reAWFhc38V8e1KU18pgtmDd0EOZQBun8lSIFzQgYzMArfw+qF7AzubpjYcsSgb
 zN73tve8xP0OMDgfGdvxX0uJZ9MVk3zaM/9uyC2ADgD+h4iNazy96ICfHKXELCaZZ2fD
 mS55ufFqHF3+lyhRWJiRVrf17NqVC54kPuNnO6FAdvJ3EMF9GTBKf5zOyifaidijhLik
 ZRlA==
X-Gm-Message-State: AFq9FYIO6MDFlLm13h0kD83Rw7SkYsrYO9js/mB5C5sA2JeDMfvUI519
 VKZHJXfW6YOq1c9G3zt7vx6jZPoMSxS4zryihhmVTcJwwgJibq1hnezW96foFU7TxskvcnEKPaC
 5OEBARaFC0GnCskfpQaNSja04YkGTtUk3PXSplVRaS+zN+cM8ShXu/A==
X-Gm-Gg: AYBFou0CZofLC1EXD+xaT0XJTXrjCCEOC32+27c0GmeBZ0xkVQC39Rs4lD+jTwvAiTL
 aFw+D4UH8EhLOAXQKsvYljeIFW9/gHohbZ0oWazzbEpiWFABYXsRcvqcyHwxJjeE6DTLZFk4Euk
 7TKaT80yajtB2qfzmn+ffreoWW/yJLNRueTLZsHYbmhw3B//zNDFI9tRZSYKDCIxEsYbtfPaV4o
 y7+wciebsJDxETMBgHeDrVwtz0zjV6LojjyAV7Kgz/SJDRZi4Uu0y/M6BEdUwXspjSoJGHf8g8x
 AwozxBvu8yBW7xS5P9vN3HsnNqIUSgEqOMpe2zQIfkXG+3Ixiq6lZuFaHvMSg82yd7CiUxGlV8H
 QWONcjzBE051zJgnCK4+Tor8H8DUqnFCEW4M=
X-Received: by 2002:a05:6402:280f:b0:6b4:16fb:b9bf with SMTP id
 4fb4d7f45d1cf-6b416fbbe99mr638419a12.34.1792588083822; Wed, 21 Oct 2026
 06:08:03 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 13:08:01 +0000
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 13:41:46 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261013-b4-button-live-monitor-v3-1-3563b4d3ccdf@protonmail.com>
References: <20261013-b4-button-live-monitor-v3-0-3563b4d3ccdf@protonmail.com>
 <20261013-b4-button-live-monitor-v3-1-3563b4d3ccdf@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 13:08:01 +0000
X-Gm-Features: AclHuK92Kggab4ASMkbc96xMlJJI7g_OWP7ncXuDkbukUw_2ozR7hTnBpht-dqI
Message-ID: <CAFLszTiLoCqVn1kyPx6oz3yofiXqrbMfeGYYynDc=UGY5TzY=g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] cmd: button: factor out state printing from
 'button list'
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 David Heidelberg <david@ixit.cz>, Simon Glass <sjg@chromium.org>
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-13T16:33:33, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> cmd: button: factor out state printing from 'button list'
>
> Move the per-button state printing out of list_buttons() into
> show_button_status(). This prints on/off, <inactive> or Error N
> without a trailing newline. 'button list' output is unchanged.
>
> This is a preparation for a new subcommand.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
>  cmd/button.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

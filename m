Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54060CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:04:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B67E60C00;
	Thu,  1 Oct 2026 16:04:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LBKZWJDMeUJk; Thu,  1 Oct 2026 16:04:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4949860B26
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870667;
	b=MRGiIDKLJdeF3lwCswbPKoUR5Ay5petK80tQqVse4nTTmTw70q1am3YLLWxOm6eQd1Pi
	 E8mVkmFBUgw1IH+EOjHRUpTx6nc3bJ5JpIh0cjvooRwYDxVBIfWHkD6y9RrT3eOCLnpYK
	 r88uDY+1Y2aTa3eFcD7XVA7pHxwhk+86g7cryDanvxxhIqLyQoePCWADolxxyXH3AR8AQ
	 +FlHa0uXe3KIvjR7GAQ3MOaXS7eHDopcNXLaM9/XQrcglnxHz0jJ32U1R9qO5h9EOeG8j
	 x6U/VoLEyYQvtb5ApTBSwl6x+RyzjQY0BG04Ejbvnp2dQGKGWIVKsspale0ZVvhkyug==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790870667;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=x+BQSUCc3c/OcqNpmhohem5LBeMzeFnF95s2M/xaSTo=;
	b=o0t5zJKJEawAZQ1EPKgo8o6xe5ErWFg8lRBWi2u5vva+dR8o/aZxQYUGB3VWM8hI3Gqy
	 oOb2TC4LgTrFTwn553KQq+nJ4hvP6MGrqZCWWHrdT2c784tpOpmE+clcr+n8Pu5I5Fx3W
	 5Q7fkk6ovNcjaB+PsRwVslLDcF3HxfiOE1G1FOD0jQeOj+I/hR5VC0xuSfiXAdHE9PSJW
	 tHzEZ28rCeBbTER1OZBykuE3nph84QtyeE1WZpADNPu0Rj8VWJFSKD08jT9cwluG+UFZA
	 ibE4S6iNpPa2M1qNSHhTp4IkAv02+g01E5OiL5lI6Pjoiwv+NdiBkVCnjF2jRAkT6aQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790870667;
	bh=x+BQSUCc3c/OcqNpmhohem5LBeMzeFnF95s2M/xaSTo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=czl5zlpPYF1XKyjYRhSC5DJS3YeRv8TR0USvEnNaAGE1KEeHyBrxsCbxsWVbTM3/e
	 jbsyv8UzwEEOg2CsSrPQKACCbp5wLg5PYO61msZVicd2gwqKOdFW0lBZxTvEs9oE7r
	 rgpzgsRyBjC/fjfuJg4IK24v0ZLF+b3pdy7UjD7BlJrNqZasCmUaOg853/nrzOojmh
	 ixxHrsq7XkR/vOEA9KvV9/CALzAjB8VWPl3lUG0IwsDVltTETcaNVd7CTdRYLVFgmH
	 X1gnNdH4YEj8Kwrc9VbvbHxgP3FZ3Sw9WQvY5WvP3zsUI8u0rxkZDvfbhzOO7UVwkR
	 JEtBgoEhLLUfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4949860B26;
	Thu,  1 Oct 2026 16:04:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BF3C282
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F830407C4
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:04:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rIFRmGrio4UY for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:04:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5754740A91
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870664;
 b=bANsdmjqtRDD6VlATpi0EkL6JIpXRz7KAi4pPTCVf68tiPltLXsXm4EdMDZR3A5sFoEB
 o9r0BAPcsxYwXfGVxHEG8P5EJoOIpAlq/9VwPi1M4nNH9doLow6Nwk6pX/ZMMlaR3Be3+
 msP2gwTozl2pXNyoRshk5wlepK80kVg43BjZacBOO7N7bVc5Ep6BIOwEZLMRH/8F1YwpM
 rNWeksFep2SPncrPl/NWIKrU7ZcSABPBQrLNd/pitUu01FoIqweHksVmZua6IIgY+JdNw
 K1IkOUUov2hV5EO/zoy+ad6Tu89cZvGfjlGXfEQFzFOrcuEVvKCcONbjG/pKO5rF3sA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790870664;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=x+BQSUCc3c/OcqNpmhohem5LBeMzeFnF95s2M/xaSTo=;
 b=XfBArnhggc+0mkwcplvmOxIbr5J+QmSQwL5dzVKGT4GyvXxSTXe6EuV3YzkE70UzlZ0V
 MJi5Bey3uDBTP2SJcb+tryChxWnLbR90REE6uM5026M8OhLkyC7xysiFRXYNuRvmNPjtX
 ADXotXg8SIyqx0GIVacwAd+peY2CZNkLt8h5hPbQb+EqOJ3Yyr2sG9O7XDVrbdqkHN1mp
 rLmXT84gqlC8kbLszQfR/DyuLjd1FRYv3Ek5m7A4RnUQY5hcKvTWlYj/4xTPr7By6g98S
 iLvlG+6g9Cw2KhPfDu8BTWBgJo6m0qeo7OMeZa00fC0FLx7SmggGw/M9zhcKl5BHh+w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=obXQs3mU; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=obXQs3mU
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5754740A91
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:04:23 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ac768bda6aso8083653a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 09:04:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790870662; cv=none;
 d=google.com; s=arc-20260327;
 b=kR4NWQHUwhDOHpzEfJBRXojiagvuCJ4BgzkAFfJ+WZZcNUD4xTvk2AYEMGQ5LHULG7
 UZp3A3+xQbqEQATsBCoNW+QGSmiHOhP15fH1TGyW2gNkOV9cqIDtIyKho7tQtjVwTPHN
 ijEaphUxSwXyNXYaBq/6qowGUL3rmTqQSgY2JxPfrSv3kpjIv9Boxh1obQ7msXJF0zAv
 CGBXzMUfGaZv9e9GhVLjnLkUjSQ5Quv4JHQ0ZGzxY05Tc0oXvbzA/B+xVS1zB2MEDamV
 8kfCQ6yerrW4U/9X/99nzSgMpx4OI29VGpMT3lcSVjPHPYD9apPxFfAAH4s2bjteAukt
 6dpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=x+BQSUCc3c/OcqNpmhohem5LBeMzeFnF95s2M/xaSTo=;
 fh=BevGJNW5AOKnfy8O/FowEJJ3Prwfzn1eQzuyArZTRL0=;
 b=oBnG4AfiOjn1R+FCc6VJwfoHezQ1hTMjbQWaIS4ulFd6Tcj9KkcjCT7IgF51+jOBUF
 UjmkB7NFyVbn4/dGUnD9PdKIcXMUyRXSjkAcWka3jEEWNlW19Mth5lYYru/xBeztFZxB
 RkMbrUU0rtOm+UGmNQoF/l6gXxTnZyrpmJLMGeNJaAFuhxjHlcCw+sO8zqE5HAHu2EdU
 rG48sXpoCdrBzlHi4zDZgEEyErsR2vPDFg2XBZhQzxdd/+n944Iob+ew7FAad1BCkID9
 CV/WwAoyl2eZXhTe59TwnHCQPZC82LRR4qPmiVK7jMaRKO/AUyNW0F88XiNx8laApINC
 rHeg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790870662; x=1791475462;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=x+BQSUCc3c/OcqNpmhohem5LBeMzeFnF95s2M/xaSTo=;
 b=obXQs3mUX0RrV/arr0aj225gqKvglqvqri+2v0V7xqeVcdl4pHMoT0qUvijz6I3aFd
 ypVrJJbTpBPzMVBCDBm+YgYqKlCo8TgE8W2iPYq+5M3XpcV3LxZn2szTgLVm0xsy1eXn
 wjpZFUC5spvMin6PFVhpRe7y4TAqTUGz1JtMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790870662; x=1791475462;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=x+BQSUCc3c/OcqNpmhohem5LBeMzeFnF95s2M/xaSTo=;
 b=anZygJ7xt3neKI0OFxM+/I+RIfpcRuST1HTJ4gPpJU2lbVhVJwzZMxQoXtA94A+nqL
 3KB3GaMalScKvfkQy8Jz0H/9cV/Y+LQ6SNrPM1LxIT4aS3Ol1ECeOOLhIEP8S3SedLIj
 xdGbHpGBLM/tgFSdMS2KN4D7sBDxCM3+5qrx9mfjtLQAA8NuKh8YmBwFml7nrlffYsUF
 OzreZufQFDKJdxg9dJNagdioLhbvg2hn2actDJ/3fA6zNTAj4u90hoj6si2EAXpinBwz
 nEuElbmzatE6yuxBj2X1IzM7X52dy2m1hoIgU/GusJ7rWIpHiNWNaYOfQAN4pxxH3IoX
 VuXg==
X-Gm-Message-State: AFq9FYKnoJjOKxhCKMiECg27G+kvAdyC9BuhOez6WvMMxBfaf5kzZVvI
 +Um4ymRnBhbpuu88FIwTEBF2/bueSg8+tHJ05O1YieDbvrJAObQzp/7uujLGd0JjJe+mNl2esf/
 9fnNLK6MKjacGBIdAcJne+k4UIevSMHATpjPFlg5NI0JHj2wNPCUb7g==
X-Gm-Gg: AYBFou1zDBAzadsbFLJf7hzSWZkxaDGVEqUPuIc+ElVEPJDcbuDG6qFlQxgoRnR7kxs
 TUpnKyyI64EIfrdYj8ur7mXxhRMqUV1qN2R4zIVzvTvl/IQ/B/tqGcvngMIlMDml9WVVsv0e+y9
 ftpmYfDW4KtVtl7+7n+nuUU+TAwpqbDQJPmzBhSOvpp7mb0yDL/kz9DJh9WoscLcWEysDopxTcc
 QJcCyyx40bdw6bN7kYxaQycyVoQvKVcQjMMkbyL4Uv8IkerUZ+qei/L8JlpiIP6pnqPF0pNONjs
 Pq3wFJjqq2j3YtdpUsh/IRiZrtTuyLUF4SyD3IeI4RZf7AWYuB1+IIvv
X-Received: by 2002:a05:6402:5342:20b0:6aa:f2cb:754c with SMTP id
 4fb4d7f45d1cf-6ae198f3b35mr3466486a12.10.1790870661682; Thu, 01 Oct 2026
 09:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790626459.git.daniel@makrotopia.org>
In-Reply-To: <cover.1790626459.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 17:04:08 +0100
X-Gm-Features: AclHuK_6x4a8fQRGO-QAhP3hZDWYM2pJWTvsLY-X4p4yzrESuCl8QnAP--QgYqI
Message-ID: <CAFLszTjd1JWrhXB4oPFLnbistkMEwUVo_ocbqrtbNO7=yPiMkA@mail.gmail.com>
Subject: Re: [00/11] imagemap: fixes from the v1 review
To: daniel@makrotopia.org
Cc: u-boot@lists.u-boot-project.org
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

Hi Daniel,

On 2026-09-29T00:04:16, Daniel Golle <daniel@makrotopia.org> wrote:

> Simon Glass reviewed the v1 posting of the imagemap series
> (cover.1787272661.git.daniel@makrotopia.org) after v2 had already been
> applied, so his comments arrive against code that is now in next. This
> series carries the correctness half of them; a second series follows
> with the structural and cosmetic half.

Thanks for picking these up so quickly, and for splitting the
correctness fixes from the cosmetic ones. This is one of the most
tricky series I've looked at in a while!

Patches 4, 5 and 6 change how imagemap behaves but add no tests, so
'ut imagemap' passes both before and after each one. I've suggested a
test on each patch.

> Tested on sandbox: every commit builds, "ut imagemap" passes 13/13 and
> survives "ut -r3"

The -r3 run only exercises the passing path. If the UBI test fails
part-way, the MTD table, the attached UBI device and the static
ubi_blk_dev from patch 3 all survive the driver-model teardown and
point into the freed tree. So I think patches 3, 10 and 11 need a bit
more thought. Details are on those patches.

Smaller point: patch 2 adds a 'parent'/'ret' version of
ubi_blk_bind_once(), then patch 3 moves it and rewrites most of it.
Please consider doing the move first, or folding patch 2's error
report into patch 3, so the reader only reviews the function once.

Overall I am not thrilled with how driver model is holding up in this
case, e.g. the interaction with UBI and tests. I recently did some
work on putting the EFI state into a struct, so we can create a new
state for tests. I'd be interested in your thoughts on this, given
your effort in putting this series together.

Regards,
Simon

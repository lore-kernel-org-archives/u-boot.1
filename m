Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE28DC55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 19:34:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0908340801;
	Wed,  5 Aug 2026 19:34:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kYaKqRmJLfGh; Wed,  5 Aug 2026 19:34:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 13777407F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785958450;
	bh=Wh+NwYMzI92Tm+chmsSzH4Gjf59+M+ilCSdO7irCZKA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XvKmlRgaVGa2eTVvJru+UCL7sVoINRIKrIX6UZp5O996YsK2TXjntcaygX3MuKqHC
	 cgaRRVi5AiCI8dRhmEQaa3DBPJqAZT5mYtVSKg9jvPXUVZYdlgDeyjG6CUajAgG8bv
	 hPG97ZL5m0bKJQTCPuR2qdbvPN1L/1s0i2cnDWXqDzD1krxmu2486jSz3csF4OQxPJ
	 qlJFjnPT/vJFtjxRNxZZa7fryKKef6tel4UCMg66xEP4yaoiBoCXeot5UQDiDi9c52
	 xAjWVNf40oZdODCkWre/nxN8iQLYmsYVHacCt869LogNZmcbXpGFnMDbeHxnJ77iMQ
	 fZPCHsSskCq5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13777407F5;
	Wed,  5 Aug 2026 19:34:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9307D2A8
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 19:34:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7942680D9E
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 19:34:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p9kjm32olYXG for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 19:34:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 41A7280D6A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 41A7280D6A
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 41A7280D6A
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 19:34:08 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c2055573c8cso72958266b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 12:34:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785958446; cv=none;
 d=google.com; s=arc-20260327;
 b=Vj1TA5WHcaZXnZ5y7xSTXjuERyNsAf8bwCBnTpphR7t0pyMVP132I0EuGF2SERJru8
 lT/SK7pcTfGBQd1d4BHMQJs/CaTjeUxRL2+SuwsptQwMTEyxWlcMkma2xCqBxeXY05Yw
 tr28C2hE4J7hUXtK+I7EDi281gSR0nY65NnnJxG7m5Suj0ELf2EbN6gTbcUopn1MYLW7
 +cJmIaGCBIoF3es8S+ChMrprG7Du8MiiTwfbHHbclvaDD8lvteVF9xl2cgq57G2sV6Dl
 2dTX+fXGbRNK4YahjAXs5KQny92ythuLdGsNNsnwlJ5FMd6Vqct/VcYBj0Qd6Kzd39g7
 AW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Wh+NwYMzI92Tm+chmsSzH4Gjf59+M+ilCSdO7irCZKA=;
 fh=4Z9Hngv1u+xfl5eCS8/R1QtbzWnFYr4IieaWcdmVwA0=;
 b=fz3mDP8+ZSamWAlyvHbZ2QDYVYhleEScnItFqFG0h4GWPCOeBzQhO7eV1Oeup2aBHl
 6j7gKVRbKZFq+gV4HXU3UVTbic3TbfBOh7gPVtWjVMcfpCahocembggt3hzqejpnGQ9M
 cp0P6ty/kP3lWZ6ZWZx5mzT4F+/e0jW7wOQttrjCTxRQQiywl3EVYstnTRmettJkRnYd
 RDoMD+/Bmr8dKwZGc6sIKW1aTrJK7h8HJELzEYFfk7+mKyyB9x2TGiwohn+70x0ngiou
 BJ1IzU16fmJ4Go59Pf/9jEMjkcMnd8sXxfXLbGVVDNKjTKwsJdhGVBn62hm4j+UlHu+2
 Gc0w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785958446; x=1786563246;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Wh+NwYMzI92Tm+chmsSzH4Gjf59+M+ilCSdO7irCZKA=;
 b=Yadwo4/4EvxjWsjNUcMYy1bqk7fXDnz6T8O3S4FeD7886hCNoU4LRx8XyN7xALqnYf
 ZnwNa6uMnJeh2/EzQOKbb6WzpkfiyCR5qk63/bWs7C+0jjlKDAIUdN3KTnVGC9ecAs1T
 ZCcKKLEn11aWzTth8ef5bWZMUIBpcv+fnlGZfji8RYq2wr26i8nwfPcXrjoCL18I39ZF
 kFp1muBmGPC+e5MWctNNf/YZakOL729kiatzPjjBldCVjZ0vnV2M6Sy+WMWDC/nq8Iku
 uA6EK+bq9nTm2Ks1gBG9+NcfjIndTH/Jw61yJDcOqNX98nMtXRh9VtzHFeFa+/gouKEK
 IKeQ==
X-Gm-Message-State: AOJu0YzuAsJvxsgV7I5L0srbyduETcfdwRhF081LiSVmh/jSM59vceER
 EUZ8/R2BmyL6Z5h7tNdPd61PQRQnA7rnhD+/731R4JAU+0ZeSfXA0dpz1WQuT0d5bjNGDmXV4G/
 YH4jBAqt+PwBSWTGRocVWrxQUbKlNCrLi/LuC8vcz
X-Gm-Gg: AR+sD10LoVCZa46UatShSHDY0wZPTvaoNf8ddKCh+33gBi9TgjPRzGhxtMu1OWFIPEL
 hUPmqTSZLLaz5k05RjIs90bx/tGEmcZGEg3Q6RcM7RjF9IX+bIJmtBbJiDS92B0mXyjd5d/xOcw
 NFmnslfZOP9MpwlmH5aIsBUEn92NPawt0NBm0xYlp2rbvBdbfiri7BQd0n7OLAfFkf7ISsfIgYH
 4eniMEWY18bzWlSaKiIoXXfTYLAYThdi7gItdS6lDC/eJq97OT/PRvWYPiBBie5ltAx+HYcync7
 QX77Q54PbEW9oXEZm7vescDtzqPagJ60iZ33n7c3ITg=
X-Received: by 2002:a17:907:c807:b0:c1f:bada:4b2a with SMTP id
 a640c23a62f3a-c2039d7a9eemr467077666b.31.1785958446052; Wed, 05 Aug 2026
 12:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260805-pylibfdt-geo-growth-v1-1-dabe082367e5@flipper.net>
In-Reply-To: <20260805-pylibfdt-geo-growth-v1-1-dabe082367e5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Aug 2026 13:33:52 -0600
X-Gm-Features: AUfX_mzSkiTQkFAASLfzkNJraZajAV9FKq54R2miP2lDwOz2Zb1FAPvrz9cMFa8
Message-ID: <CAFLszTiJK9JFDe30ZfaXkZvmNUfWUVmC8ZVLU0b-7vfTsHaQ5w@mail.gmail.com>
Subject: Re: [PATCH] pylibfdt: Grow the FdtSw buffer geometrically
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785958446; x=1786563246;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wh+NwYMzI92Tm+chmsSzH4Gjf59+M+ilCSdO7irCZKA=;
 b=n/JCQCNJAWptT59w66dAZ/1TRDkZapzbvbnB8qPGf+VX6eLw9sCyz49JuEUVn+Q30Z
 unUmWtekGz5sUId7eHN5ucRNwbUc33i2ILVkbLdd8sYsIERjQGR1agUOySK/twSSk7F0
 nMCeydcNmgyXENpsF3x8HZyo/XzlOScwA4Tjg=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=n/JCQCNJ
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

Hi Alexey,

On 2026-08-05T14:47:38, Alexey Charkov <alchark@flipper.net> wrote:
> pylibfdt: Grow the FdtSw buffer geometrically
>
> Every expansion copies the whole tree into a freshly allocated buffer, so
> growing by a fixed amount makes building a tree cost time quadratic in
> its size. This is especially painful when assembling larger FIT images with
> binman, as it assembles the image with the data inline.
>
> Grow by at least as much as the tree already holds, which is what variable
> sized arrays usually do specifically to avoid such excessive copying.
>
> With this change, building a Rockchip TF-A+Falcon image whose FIT carries
> a 31 MiB kernel takes 33.1 s rather than 44.4 s, with binman itself down
> from 25.3 s to 14.0 s, as 7139 reallocations become 187. The images
> produced are byte-identical and the binman and dtoc test results are
> unaffected.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> scripts/dtc/pylibfdt/libfdt.i_shipped | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

This is a _shipped file from upstream dtc, so any change here will be
reverted on the next resync. Please can you send this to the dtc
project first (see https://github.com/dgibson/dtc) and reference the
upstream commit / PR in the U-Boot commit message, similar to how
a63456b9191 links to dgibson/dtc PR 154. Otherwise the improvement
will be lost.

> @@ -808,7 +812,7 @@ class FdtSw(FdtRo):
>          if check_err(val, QUIET_NOSPACE) < 0:
> -            self.resize(len(self._fdt) + self.INC_SIZE)
> +            self.resize(len(self._fdt) + max(len(self._fdt), self.INC_SIZE))

Logic looks correct - doubling gives amortised O(n) total copying, and
the INC_SIZE floor keeps small trees from taking many tiny growths.
Nice measurement in the commit message too.

Regards,
Simon

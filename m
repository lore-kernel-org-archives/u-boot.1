Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36A0C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:53:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D19940C9C;
	Fri, 14 Aug 2026 22:53:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N0BoCrBZfuSl; Fri, 14 Aug 2026 22:53:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 13F4640C87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786748000;
	bh=6EhSv4XmgkkMYyeIe0sAOMBZEvylCt2ytqUrnVwr/SY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nt2sieklQS+7r97rcUMPYiFPvvwoRuu4scV1mLzB5qYdnMTx/oyJFCGF4cVo5NI+s
	 eAqaNpg0vynVXCRP/tkB4ebaK9mqVzZgjT5WvPyVv8m1rYJnzXcza2og4yD/aaGLIz
	 EdHuA3v6QjtoGCivpm0PJZsXWiw0v/qcYFJ4+IiWj729ipugIo7Hb74vF/61jYhYGR
	 83Lb1MHpbOZzWwEx3nvKjBbkVUEfJd7aTNIGapzaBRKskIiMORdKm1JpC+kSam92HH
	 GJz6QwPsmsBFBYn5AzX42DC+3feQnM6b43n422c5QZObLb+WzqSy5Alg8kFnhXlmSr
	 cEFMaddAK6/Vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13F4640C87;
	Fri, 14 Aug 2026 22:53:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CFAE194
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F00C40B70
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:53:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id InraqdQIlUf9 for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:53:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2DDED40064
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2DDED40064
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=nZiFyfxQ
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2DDED40064
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:53:17 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a173ad7cf4so2231557a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 15:53:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786747995; cv=none;
 d=google.com; s=arc-20260327;
 b=VuY+FjEmSR/GppseACCb7875dmIPpU5ldgzBrdp6rvBsA8h7lktOO18UBpa3xZCWsU
 2do5IWTOLA2LsTqhQu0NJWAxrkRn2QBZyn/6auAOEgvSYxWyxZbm6yXgvngdiQCn8I9X
 vKevrPbX88AqXrOe0zXyzDgmPRC22TXXS/bwTV4ymonU+clV4WP3U/WsjipYjy4l50AB
 UKgY6JXm57yiRtjpU9QGRt39sD1jtaK/lNDUSJKRAROTFoVdOO4CLrQLn0ybbkyJpBRk
 tIdpp5usBU8zYYcyjVFZJf2/Oc0FRZzY3IuT2T7fJ8rNnTFYIF3UsB94mOvA2TryBBkU
 QenA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6EhSv4XmgkkMYyeIe0sAOMBZEvylCt2ytqUrnVwr/SY=;
 fh=OxwBz+aSMfoqYA7m5X8ntMZzs+rtqs88HfXAchVaEEc=;
 b=Ku6+SuklbdXODYRfdw7KkeMhOj4mlx3WcsnGLSONf0jLsKRgBJdZ+bJZRGsKLBFJ8b
 lTwEtkoQTnqH261MEPrL7jytqeYfnlNoYK0tWvWI9oM3QreRmsq9VMmpN1MdO0f5O18O
 xNPp9KAWIdIX4KYFV96auAVbB3UlFHUB+ibVRjtuwzql0VQ38RXOILKCKpYbaWfarst2
 yTlfeq+BK2q6xqAd2dae+lc8PUpAQ554MEADb3gUeTxEUznkxll0nFNLXEUkMWozOyv1
 DMLamzl3Aw8HJX9gCnySh/RJBedhZTZOu/S1SGdUTfTsbmfU9iRe5hWKh8y7OXareiG6
 YHcQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786747995; x=1787352795;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6EhSv4XmgkkMYyeIe0sAOMBZEvylCt2ytqUrnVwr/SY=;
 b=nZiFyfxQKauohsN6Pn8+hmHzA4ZPt1sUH3DLaul/bgV/nV+aJfivqDQDzsua1Vw41V
 EOpvi6EZh+xD0zMmNnfxDjKWmOHTZVm6AG770v/2A1XANcf9yO5XDyJGp8CYNa0JYd+i
 HVS6j3n2+413HfU3nTQhwiVUqkJA2kfj7BZ6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786747995; x=1787352795;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6EhSv4XmgkkMYyeIe0sAOMBZEvylCt2ytqUrnVwr/SY=;
 b=Tby6zHZyWPGKDW93yO5pARNIFQwYCh70xFaYzsKtwpd98duUk7dqZ9L80F13n95Rku
 3C4SYUgFIygDS9QWH8YdbapRf5mZ9fdzzdQyQFbPMBtva/Y2AiPHWnB/vWSXSswTzOl6
 08kUzg/eT7gEF/BB/d2BaT93qrJRcR7JKtxDKmMcSN1atq4pR5mn+IWayZ0jb0Lk4iPh
 RU2D9LLnoA3IusJap4PBKhqUb+JmdJJoTLPkQZmCSQpheSReF1anSd8EdP6ST4O1VamQ
 8tzyLKwWuIPQS/Gh1921nxQvXmiQmFod8h/iANCWPJpBMPk077GBzzn4VW42sFh/oXyR
 1FYA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoIv0c25k1ghSC/2/Ug94b9wk82HhvcIcJL1MDpaE1Ymdkw8VW2T76FnqiBSV3Gbmq9P87cHYA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw5F8+4CaBAs19bozFeShe6kWF5fyUKqUJdKRZk9UkVnIYiUmLc
 Qnzfeqxgk3xrhegGT9bcD8ETTSBaF2YJJSFzOXX0Rdgozg2Zo2HQqIeOn8plH02RgGQtIyPuUvo
 Fsq2cNC0dHPKRUpgaWsH6VsOQY+ozurdH5P/8lE1gkZbiwvdsPCeR+Q==
X-Gm-Gg: AR+sD132hnO7C5s5EhYGczU7ooAV6SCf8WY0SHnSMkEmtGGgF6oJ1o2KqqC2NCkh4gm
 R1ZlPbhJXmnqreUz/+D2pswnGzOlZHJ8BG/EoVCXQzy0sZH08Fvx5lw4vag9W/gLVvmcfyOdLcH
 HZqOhRtzr5run6ilJ8o1+SshJ92XcjqSPb1ncnF290VLcTRuCe1NVTJZyn6QymujOdxpjakMXUW
 Lxi04F6DzjsD2vJLeHnB+m2qlnT2nd4HusxKsYMFO7Suv9FoZeFUCBigaainKP1GdbDSA+G3bc1
 pvtLUXDT+kbrzSJxSx8vO2zEBExLAjoIRC5QcrCj2U0=
X-Received: by 2002:a05:6402:455b:b0:6a1:b0b:bc2 with SMTP id
 4fb4d7f45d1cf-6a38a9998f6mr3319377a12.10.1786747995197; Fri, 14 Aug 2026
 15:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260812-rinta-watchdog-gettime-v2-0-d8a5a7aa0df7@nokia.com>
 <20260812-rinta-watchdog-gettime-v2-1-d8a5a7aa0df7@nokia.com>
In-Reply-To: <20260812-rinta-watchdog-gettime-v2-1-d8a5a7aa0df7@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Aug 2026 16:53:03 -0600
X-Gm-Features: AUfX_mzdvBi4WFMzs7EN0TzNZp_tT54JSF7tcp1JrDXQzOLO3BcGn1whLs0R58A
Message-ID: <CAFLszTiE735wxfGe=nu8rFJn1a3tYOJYa6vjOUeDazuKLCKyPA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/5] watchdog: wdt-uclass: report effective
 timeout in start print
To: Juuso Rinta <juuso.rinta@nokia.com>
Cc: u-boot@lists.denx.de, Stefan Roese <stefan.roese@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 u-boot@lists.u-boot-project.org
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Juuso,

On 2026-08-12T09:48:39, Juuso Rinta <juuso.rinta@nokia.com> wrote:
> watchdog: wdt-uclass: report effective timeout in start print
>
> The wdt_start() function may be called with a timeout greater
> than the hardware-supported maximum. This in turn can result
> in a bogus print, for example, if the device clamps the timeout
> to 10s but wdt_start() is called with a 60s timeout:
> Started <watchdog@> with servicing every 1000ms (60s timeout)
>
> Add a max_timeout_ms field to uclass-plat data, so drivers can
> set the hardware-limited max timeout value there during probing.
> For drivers that support this feature, the startup print now
> shows both the actual and requested timeout values, e.g.
> Started <watchdog@> with servicing every 1000ms (10s timeout, requested 60s)
>
> The timeout comparison is done in whole seconds to avoid noise
> from sub-second rounding.
>
> The value defaults to 0. For drivers that do not support
> this feature, the resulting print remains the same as before.
>
> While at it, rename the string str in wdt_start() to svc_str for
> cleaner distinction from the new req_str, replace its memset with
> svc_str[0] = '\0', and use sizeof(svc_str) instead of the magic 16
> in the snprintf.

Normally a cleanup like that would be best in a separate patch, BTW.

> [...]
>
> drivers/watchdog/wdt-uclass.c | 34 +++++++++++++++++++++++++++++-----
>  include/wdt.h                 | 11 +++++++++++
>  2 files changed, 40 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon

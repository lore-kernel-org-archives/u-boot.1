Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F06BC5AC67
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 13:49:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0AE7606DC;
	Sat,  8 Aug 2026 13:49:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RmI_7AwtfGKs; Sat,  8 Aug 2026 13:49:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B7D996065E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786196980;
	bh=hzVOxWToFk0yRu1v5GLPiayWHR+zVzROEOCByZ033Pg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GCfIaddR7fJllhXXJfYADK49HPsljANqvv92gdxFE4qAqJBrsPBfNTIdvve3zT+hv
	 UNKkj33YM3Lk36SFUPTVerCc+KGLKSC3J96KoAomhihdTZVEYDKdn/TUu0I5HeWR+0
	 a2jUlNvBZTHzn+yaQUO5mZGFHmFZgL8RN7O/eIueGc8OTIo8YvaYtsUKAmu36Wx2DC
	 pduEwWWuWIJvFcsk/Cmua/a1SVrslWafzPxcfJPQe9k4a8Fq1dvVEPBaFg9nd+0qML
	 qe/HxS9QyT4/VjBBd6T6YGZ0rSLV2TJMV05BXJp4hp50aMJnLIV6Lcz0WPBAwPPxkR
	 fkxJns4bhvE4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7D996065E;
	Sat,  8 Aug 2026 13:49:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A5548282
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:49:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C01A80DE9
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:49:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CrCJuvEtMLn5 for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 13:49:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9B25D80DD0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9B25D80DD0
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9B25D80DD0
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:49:38 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a051904222so468119a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 06:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786196976; cv=none;
 d=google.com; s=arc-20260327;
 b=c8fztsG6UONv6wsVGFYK8NrX2/gyu/o03h2U57FNWRVrR1GZSq1Ng0SMU/U9cVwL1Z
 UMIJ8WrFerRwI13zJEzVmZ3BiSaDLqUt6lGGhezbAIXy51YVV6MerIUsLMMlmZBzmnTD
 XvzBJV0PsPjCpfZr6Ny+wFEODeIMFY3uV2i3wVniTrFbwcLa6VBxm/K9VjEOmipBoPG2
 9Dqbm/tIdacT3JRt5+LfxkDmTly+7fNsCQ3MweBCmpj22vvWEXL1CZcU6cqrXbgkRe+J
 d0yea/+uQxqvbQQmUoN8PGx9DkTZ8he30Mv7nmDc+MFEpibA6sJtanXPWzwIaThr2Nr4
 L8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hzVOxWToFk0yRu1v5GLPiayWHR+zVzROEOCByZ033Pg=;
 fh=eybldZBXeZ25kcSUWgn0EFj7euTPyUYAWUYWgJkJ5MY=;
 b=OIrpzjIueWuxwhIwOBWc3At6diRx/XhvswMaozoA6SZ4g9FpnF23pY2DRn3NhUFTuw
 JpO8VuvC08JNRtoGKzwS4WEUs4n/5Jl9CQmIZdt78/HgdvfpQYdMr+t8Q5gEbQHoDnzc
 6DmNP0yugfRiEDD7UfXrU1wv9aEIbdFfMPoZIkAETCmH15sEzZd4BlYZwEHBOaJgVs4w
 S2fdnbndXzOePENE3Xul59AxBHVwrYx+UY/lqBVor4ZDOzWUxs05E7/gEi7iOA57gf+m
 I4g8vaV/yZIaZ4HLIn5uciX4MS6GAzzAuPOK++pPztluWSW9fHq/yPCBSfD1BM9LC0e8
 c2Fg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786196976; x=1786801776;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hzVOxWToFk0yRu1v5GLPiayWHR+zVzROEOCByZ033Pg=;
 b=YHhF38PZ0/haOwiSUQ/yGxqZHLaCq+wB8TezOcwzNh/SipB+OoG4W1JUml2xwUEyZ/
 vlDn+Fc/6D+09ouTyFYA1hZRg9JkSI3M3/c9qeCjOl5lBJpsEUA87A6ImbaasMZXGm3T
 cqgKyOU3LcIAyR3pPzFb26WK5+zGF6PpVbLreg/NsH4+AjHTjBVFpd/QSONhpyc8dvnE
 zorxYUzIJ/LWcc6tPkP3pX205v5kfpGvIAWCvT6cVXZQgOgeHvLa4Q5jmqzEuK2EqKa+
 ZaW5/7agJJOmtEggzqQce9Bi8Z195crdjP2IxoMm2jTchbbiCRiQc3Kdr3ozlwb9wjOw
 rNBQ==
X-Gm-Message-State: AOJu0YwnapsyDvSlvJFNE+tP7hvbjQrTvUBNLqsCiTK3lCImTaQ3gWxD
 kvncn1bCotONor5OhD4bdP4NV4hJ7OOntnPRzIoamVDsDE8PkQb+JDFYuwkOj4n7FUbaZvCStwP
 gpWpOSC3gSArjaaXbV/Q/WlhaZYpeAK5nkn6VEyyQ
X-Gm-Gg: AR+sD120sZC7ow+lKv48SI4lqJvgCk83bGsPQ7dTsK2jXNAnyZ6n+XDwtL3GkikAo35
 /dj23U7qy32sNXnDFudemfJP9ep3qTnpnDqss02V93cdBk2LRax93fWbF3ZJXGAhjMziKmDzM/V
 kkfPyjzYdi2Q7OFcL2LZPhnZTM1z3S746AuULkGU1Gb5jr85KfVzTWWV1myqk/6u+B8Ag55tL2h
 BTd3XifvSiVAFW/ifb7Dvq4DhfKst8uWf0rvRu5Cgu2pHB19M2nIDzdFvcmHIhzoij379fQwlog
 DeAnwU23tv8nRuImWa34XaXB9+JhA7UFqoRbZHZouFrb6T5h3A9y0Q==
X-Received: by 2002:a17:906:7315:b0:c19:5d7c:ae72 with SMTP id
 a640c23a62f3a-c2039e9a978mr1193209966b.32.1786196976515; Sat, 08 Aug 2026
 06:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260806-b4-fit-ext-data-hardening-v2-0-b181cac15c29@binarly.io>
 <20260806-b4-fit-ext-data-hardening-v2-1-b181cac15c29@binarly.io>
In-Reply-To: <20260806-b4-fit-ext-data-hardening-v2-1-b181cac15c29@binarly.io>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 07:49:24 -0600
X-Gm-Features: AUfX_mzNp5BmS_9-YtiFneZqfEy1RfeB933lGubWMklBr2-3cXV9VZJDTzeSBiw
Message-ID: <CAFLszThReYZBXAVFRXxOWfoyRz95Xi2ndJ5VdPoODE-BGDhbjA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] image-fit: Use unsigned types for external data
 properties
To: Anton Ivanov <anton@binarly.io>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Francesco Valla <francesco@valla.it>, 
 Anshul Dalal <anshuld@ti.com>, Randolph Sapp <rs@ti.com>,
 Binarly Research <vr@binarly.io>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786196976; x=1786801776;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hzVOxWToFk0yRu1v5GLPiayWHR+zVzROEOCByZ033Pg=;
 b=JU2Rvh5XiRa8vg/pXK9xRgncdlSaTeGX1uvlLnk5Ynqvob5QVcn9+oVNFEG2KdLBH2
 CjNKOBjH9KDDbjRs0ujd4A5w3+TxANr1tLdzh02ZApgTOK1vvkKI41vRiN4lPlhJYrN8
 DNEzC56S4e2Q87fYsa8I1jN796qzbjCnZDT1U=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=JU2Rvh5X
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

On 2026-08-06T21:29:18, Anton Ivanov <anton@binarly.io> wrote:
> image-fit: Use unsigned types for external data properties
>
> The data-offset, data-position and data-size FIT properties are
> stored as 32-bit unsigned values (fdt32_t), but the accessors
> fit_image_get_data_offset(), fit_image_get_data_position() and
> fit_image_get_data_size() return them through a signed int.
>
> Switch the accessors and their callers to u32. This removes the
> special-processing of "negative" values in fit_image_get_data().
>
> Signed-off-by: Anton Ivanov <anton@binarly.io>
>
> boot/image-fit.c               | 29 ++++++++++-------------------
>  common/spl/spl_fit.c           |  4 ++--
>  common/splash_source.c         |  2 +-
>  drivers/fpga/socfpga_arria10.c |  3 ++-
>  include/image.h                |  6 +++---
>  test/py/tests/test_vboot.py    | 10 +++++-----
>  6 files changed, 23 insertions(+), 31 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

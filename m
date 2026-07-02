Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F08C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DDEF84CDA;
	Thu,  2 Jul 2026 10:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E/7sTkdU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F3C684CDA; Thu,  2 Jul 2026 10:31:47 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AF38846A4
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-697de23bd7dso2179954a12.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 01:31:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782981105; cv=none;
 d=google.com; s=arc-20260327;
 b=sRpUd2sJGYwrJO/guKC1msMZndiSgwmSQlWkA/fyrTNEiYrzYa6oCGNqdcBZRqIaED
 /JXwsA+uwvhQIFtjlOKtlm8YJamr7aVvrq3GeSzdV3NuTTaiJCUnMq/WRfEMAGhnJJd2
 xkIMxyvg7HzKxDlDTUHrdu1tz+h7CTC8X6BmWb8c+Q8qkCN4iLL9XSY+7mmzVEWjJu2O
 SDVtenfU7JBwbnDwSJATTsmuz/Sy+kMmlOdMfUcDElCiXTnA5XpiYEmT6Z6hNHWKvnem
 JrKsHqHUsCEMtPkVmYJc3Nm5VdFIqtH2K9pz5GDl7CkpSlfyRq3H5YBihbCvIth8aLtw
 dSCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BU5Zxi/aiMCaNgvQIOoUS6xBwRu3YgZpRQ20+bsvHAQ=;
 fh=MhAo4QPuXEC/Rh971JORz4rq3nvFSJ8p5JStjvc7R4U=;
 b=KEzYg45xqAL1TrWysOqpFVyY1kIlvDyP1vQK5Myi4Ug6l44Old7x2FxO+GbNnz1y5z
 dOJI5ut83WzxWqGAONRXFhKJoxk6eKpXKEpmhbf+TeoDObWYJmpmyrYx99fSNlusMMrW
 cd0rU6la0SubyYm1hPTofX9kHCd2liSe4/cu8EieThj8Kf6AdfKcLFUiNtA+xhVK6i2N
 R+nQAWYJ/zuAs4PaP0qIK5g1hPdN85MRgAW+7t+IN7FUN/wmtJ4q8dNbCfzJIXhApmA7
 pH9oAHRIt+ZtbDWgbT9d6txhw5CQgkVcLhixvyzy0aGC3+/0SgPtkfI5Hcun/36AntA5
 58yQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782981105; x=1783585905; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BU5Zxi/aiMCaNgvQIOoUS6xBwRu3YgZpRQ20+bsvHAQ=;
 b=E/7sTkdUec0YzURDi+E9ne6bFK81tbzJfJ5JyP+XT8i7ryjs/5en2Plzpky5fPMUZ+
 NPDE7jVzL79BAqLhoKcSNpf+5w1vAp0Who7eKp0y9bdiOhQI2A9r8Zztq+va2pCS2m69
 dGVVyaz6/3aaMy+X3kKT1TbXWXrWrMvexjRHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782981105; x=1783585905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BU5Zxi/aiMCaNgvQIOoUS6xBwRu3YgZpRQ20+bsvHAQ=;
 b=a9v7zoM2NuNLIc9QPEm6poxaTFCDDQxLvCJJR/3S2i0hRzh+wGgReKRIND+pYhomoI
 K6Ey518NLX8e4MiqpnRu56A/gw9pX/4AUWv1kHUd8Fb0vng0332g+p70sOTQxSaZIOv6
 XrCJo0Tz172CWzlZk56tTVeaaQVRlDhfSg3EXegt360yecesWk7ZF3/rv0D5wAiC1RaK
 1int0EacJcbky49Ub9bpptn5BNGBcHGrMoDkAMyPHtng5VZrcUKNDjYpEvCU5nPeNmdT
 6JmaHMML958l3fJg1Qu/i0XLfA6VQnsOgVwIrTLGB119fBe5lFTEy6ZGBQRrK9FAyzNY
 F9KA==
X-Gm-Message-State: AOJu0Yy4axCRzx9cHWcJHjhHz0dXJS4k5G2HzGrKKRc+WnqihSF6cl0W
 GvymTpxq7LP/g8PzVFyXDIZmz1FUgXAOIn8sgV8oTQIiP0CPV88qqia2In6fryBAzmhHKc0GRE2
 mHSF8oalRaRXRAIUXStMQtmovoiNE3D0mzNXv+1xn
X-Gm-Gg: AfdE7cmUxabA9qCqNDHaRYCqVIlzMEFQUpsadjcP4m8Eq63kwAEKKONjUxlOCggG2Rf
 tfPvBFaj2uNdHqbQ5KW+zCOQeNV2jKVQ3DulttIn7mQE0aXFF5WXK4+Uz4nV1nmylChKuEuJYFy
 wM61Ow6pHGD/6yFhZX3GPU1Vi8zCbhdnxhuD3USEfINIh9bjMHypWh/gaLVWpI/8dVabyT59ibl
 sVVCqZC9Ds0+AlmrFWfQWsxZMcI9QUjukDXc7LBzx31DC8jEoq1kiIX5KeXI/xiwGXkvpzcIw==
X-Received: by 2002:a05:6402:3595:b0:698:b74b:274b with SMTP id
 4fb4d7f45d1cf-698b74b2cfbmr475884a12.37.1782981104778; Thu, 02 Jul 2026
 01:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260701171535.906272-1-rv@rasmusvillemoes.dk>
 <20260701171535.906272-8-rv@rasmusvillemoes.dk>
In-Reply-To: <20260701171535.906272-8-rv@rasmusvillemoes.dk>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 09:30:08 +0100
X-Gm-Features: AVVi8Ceyz-njRa5yGCkhWLPnE8jsrI_qAqH2aXSNdUPnCCoU8MLNKC_MC3h9qoc
Message-ID: <CAFLszThNDGHeuy8vGJv=fg8kdQ4bLgaQyFhu_cVrC6wg6T3APw@mail.gmail.com>
Subject: Re: [PATCH 7/8] test: string: add test of new strcasestr() function
To: rv@rasmusvillemoes.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>
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

On 2026-07-01T17:15:27, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
> test: string: add test of new strcasestr() function
>
> Change the existing strstr() test a little so that the substring not
> found is 'bits', i.e. one that is actually found when doing case
> insensitive search.
>
> Then copy all of lib_strstr(), adapt the expectation for the
> strcasestr(s1, s3) result, and add another "not found" case.
>
> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
>
> test/lib/string.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

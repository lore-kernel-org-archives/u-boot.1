Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE19CD4939
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:06:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 655F486D4C;
	Thu, 21 Sep 2023 03:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hJXk1P5J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B739F86D47; Thu, 21 Sep 2023 03:06:02 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF95B86D1A
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-59bc956b029so5211587b3.2
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258357; x=1695863157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=75Xzcy99Dw9zOlKHwNcPtMNnY1hP3R/rBUmeNz7kCSI=;
 b=hJXk1P5JwThKS4nHqyrQAxLKvr08ZYk0dmnxkY1CcEXOJfACii15qlE4ps+cUHA3Tm
 oJR+54atmRCw8ovnNjhiUtFNkg8ZSuuK4f0JWyQNbauvLAssg6ufdjmteeN5A96hlQSL
 DfRPsbs1HC8zwDKkS+gHZMf1dvHLcGMPXpilA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258357; x=1695863157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=75Xzcy99Dw9zOlKHwNcPtMNnY1hP3R/rBUmeNz7kCSI=;
 b=u3QubKNvxhCZ4gxANKLUi7Jg/7zcdifXbx98XKBtCjlE3lrfjD19cOkGdpjK6RVffN
 LE0QCaBaVLXjRIi0VinC9ep+FN09UvD+zE174bXBVCcX/hlSLmt8wMhq3mifXEQDgUV8
 vLUVdWawHseIhEXhWBo0Ndtwtt5Z/E8S51/4ekBa0dAf7Rg369z2IHlbhYt+lxjcdGsp
 FWJPFMg+1GDvPZ8OolCCq9t60JDa5aPrx52rJd7xfvWmp4tZmQLMk7+IfnYEkIXtPt6I
 6ALgc1SXLAdXwhK/HhXZQAJseGFKuvelQCxE9xYU3RKmYripkBpJLXXRq1ZJbmudB5L2
 osww==
X-Gm-Message-State: AOJu0YxfDngaMEelHlRd6spYkRFIbcKeDmenrpDvDK3k2esSPqkx88o2
 t0n5Uw/zhRq81GTWnyVooBm9BXfREFFPQY3X5g+nCEMrT/URNapXbgA=
X-Google-Smtp-Source: AGHT+IGX3rL62eIwzOj8xZx42MKMuaG9BqryqDifDOiWL3OxNxAKHoZs6AY+eHZaxDJUKmc2qw6pxMby5bSPjIvnO6o=
X-Received: by 2002:a0d:c085:0:b0:58c:b8b4:2785 with SMTP id
 b127-20020a0dc085000000b0058cb8b42785mr4149276ywd.45.1695258357399; Wed, 20
 Sep 2023 18:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230919113705.109639-3-rasmus.villemoes@prevas.dk>
In-Reply-To: <20230919113705.109639-3-rasmus.villemoes@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:02:58 -0600
Message-ID: <CAPnjgZ2BF7puarV6UNRuEjwXxtZYN27WD_0QKX-qrYxdku+CNA@mail.gmail.com>
Subject: Re: [PATCH 2/4] binman: test: rename 275_fit_align.dts ->
 275_fit_align_external.dts
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Kever Yang <kever.yang@rock-chips.com>
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

On Tue, 19 Sept 2023 at 05:37, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> In preparation for adding a test case for fit,align without
> fit,external-offset present, rename the existing test case and
> corresponding file.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  tools/binman/ftest.py                                         | 4 ++--
>  .../test/{275_fit_align.dts => 275_fit_align_external.dts}    | 0
>  2 files changed, 2 insertions(+), 2 deletions(-)
>  rename tools/binman/test/{275_fit_align.dts => 275_fit_align_external.dts} (100%)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E2FC021A4
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 18:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2156D80756;
	Sat, 15 Feb 2025 19:08:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QdW1wwlG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59B7780C83; Sat, 15 Feb 2025 19:08:19 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C3C080077
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 19:08:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aba868c6e88so223797466b.2
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 10:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739642897; x=1740247697; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yd1X+O20mMcX5boYqaeslWL4gKQwo4AsYOp+3IU2g+U=;
 b=QdW1wwlGNKGr+ocVcskEGwhN8AkG9cYF8rVkn8O8zyrpoMBAy+TvefgPO+vRjfcv+R
 p0+fz4R88uQzknzRssSRoz7P1cP0oKdbICUKs/BomIPOL0+nh4q5EFy00gKlWTEiPLR8
 mPOJOPCbqSfKri/3Jv5LkAzEU3t/MUTj7S2W8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739642897; x=1740247697;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yd1X+O20mMcX5boYqaeslWL4gKQwo4AsYOp+3IU2g+U=;
 b=gil/IxJcm8FB23BXdnui+v2gl6b6G8H/zKBSAglCb0QHIRn7ndcCV8I71lxWWXLCJd
 xIH3w22PsSL7C7XmOYRI010cpWc5kXSpUn9FWAebXzNH1X7cxrK0Zq2ketPLY+gf2XkK
 49cBFTvCnX1NKJZFe2QOxK1VWbYDA17GW3IM1QqQbG9/7MR5LFyPobnyPwf+t4v0s7yW
 BecqRFcKsg5AIb2a4N2G0jy34S98Hm+ANleqkfWfUzMekNpgfb7CI5f14JQT4PhkmX+6
 xRFP6qWW57YD+shH5jSdTsZyrN93tSIu3D4SUkbrYSYLx1dULmkBa+pY1gbyY100KOLB
 NNnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9nYqvzrztlNAXKrGv4ziROnVzqxzfwiiBZJpoQFCvHukubiHbLnUXXmE492Tmap+90OOvMFc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz76neqluNItSmBbN9DWMpKwE13KL42s+JQUk5LOrw8u+Rgcwz8
 ZvwCcmdYzH8r6ubVYgw57TMtHLrUVDbu6yPP9Yc9wjzAs+8InyUeHFT7+enmCg5l25+StrakJ25
 ioa6W5a7gNzlffVxTREzc74BEwHiVeQIk6SQJhadqfANY4U0=
X-Gm-Gg: ASbGncuykr11JEYanVI4Vvex4mU1otmVab5Ij1hzOklefQOV+p07ToQ3fsB5bRjTfVu
 a/J+hO329BEhCjTbvCEEy5ql/vQwDxGUov4ipb/tn7oZhx4WLkI/tjj0jWxAo/2gd+qjRKsNgIQ
 ==
X-Google-Smtp-Source: AGHT+IH79jAHgIdVM0rWYkQLUXou19KAbUQspqeJi+Fm40n6OK58OCz1kshwbPV+Fr+j8tBmF0k+9MGJGmdyzv/s4Ws=
X-Received: by 2002:a17:906:3190:b0:ab7:98e8:dcd4 with SMTP id
 a640c23a62f3a-abb70b8a703mr306768066b.20.1739642896940; Sat, 15 Feb 2025
 10:08:16 -0800 (PST)
MIME-Version: 1.0
References: <20250215175534.203539-1-clamor95@gmail.com>
 <20250215175534.203539-2-clamor95@gmail.com>
In-Reply-To: <20250215175534.203539-2-clamor95@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 11:08:05 -0700
X-Gm-Features: AWEUYZmr78lIwNqGFprio0_bNjK3xmBHiS3ZRJlNYdbCVR1lHdoU1AB-Y1qtGI8
Message-ID: <CAFLszTjqDJdDUYVHchnrYn1e1_PTqCPusNCUWX_gBdncLJvMKA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] core: ofnode: add of_graph parsing helpers
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Svyatoslav,

On Sat, 15 Feb 2025 at 10:55, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> Add a mostly complete list of ofnode analogs of of_graph
> parsing helpers.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/core/Makefile       |   2 +-
>  drivers/core/ofnode_graph.c | 217 ++++++++++++++++++++++++++++++++++++
>  include/dm/ofnode_graph.h   |  90 +++++++++++++++
>  3 files changed, 308 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/core/ofnode_graph.c
>  create mode 100644 include/dm/ofnode_graph.h

Can you add a test to test/dm/ofnode please?

Regards,
Simon

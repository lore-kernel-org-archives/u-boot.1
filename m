Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07045D63939
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DBF2892DE;
	Wed, 20 Nov 2024 14:48:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EGBofDR5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 401E389649; Wed, 20 Nov 2024 14:48:32 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8057789682
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:48:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so877874466b.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732110508; x=1732715308; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q69m9FS025ghztgWlXNLwHc2N6djAAV9ZB0Bck/i8GY=;
 b=EGBofDR5pOWogiIwRmYPktiSLMHhI/HWf5sdC6XCmmlo+9iD7maMLszvPKgrl9a00L
 D3rJzB5kQPyz0B1tdhUiZ9bQ8cIro/Zje/oQXQ1J9qHuefHdZR0UhXZsDRzdZtoY0vbi
 MxX9opy8gjBmN3qOF+9SZBN7kL6uMbY74GIlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732110508; x=1732715308;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q69m9FS025ghztgWlXNLwHc2N6djAAV9ZB0Bck/i8GY=;
 b=v8QsSXTvFLgCn89fiRo3pOK1HMSkEql2+AhnX3eERAdYatWfkM65Yen0DAG97+8Gaj
 cjs4pihlnDPvXbb1gydt/vcziLRlQbl63K4IYmSY7h5fZcemEaXVBMRzEoynbWJhdYdr
 JVMfjnEs0wGS+6lJX82gKd4kUGE9jQ42o7bIUApOFTollR2LR2fxqxZXOzubNSaKKZz9
 YbbVCvw8/DDpzy1660+KrMOqOf2up1Pxkbcqb8Rceq29QnIPXgNf3umFUmjX3F5+1bEY
 iustCQQv2ZvBfzqIlGc6jZSLBdpHpifHZh7sEo3MyAtRrC29sPXLGRyuJdjWhuzdcG3f
 IIyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXENCzFNlwqtrSuIHGQUGiVfj6ayK1ncV06SF9TzERgVoH8MoZOMTjFAbEP+7Pw+bMrTSOlqNo=@lists.denx.de
X-Gm-Message-State: AOJu0YxNqSPegPQsid73hM0C1dASnZ0qy0uOnnMfrcrxp0fM2TzTH2P7
 NDz1q0czE5GIaX0U5mEmw3Pa0PzeKb7FU8E0DAH1rZqS+pPq7jQBL1AHCmAzj93ITcWReou2WoO
 SMsW7ax3E8Wi591uartJ6Og4AYlnmClkwBGSo
X-Google-Smtp-Source: AGHT+IHjdkyRywhnv/bBB1KRHsg6pcuh6sx2VwfzAib1ailcZ6DS3ne/jt6ZHiMdltZdd4Rbk1xjLUzWZEu/lRKZ8F4=
X-Received: by 2002:a17:906:6a18:b0:aa4:a814:3f69 with SMTP id
 a640c23a62f3a-aa4dd5304bemr294064766b.4.1732110508006; Wed, 20 Nov 2024
 05:48:28 -0800 (PST)
MIME-Version: 1.0
References: <20241110115054.2555-1-ansuelsmth@gmail.com>
 <20241110115054.2555-5-ansuelsmth@gmail.com>
In-Reply-To: <20241110115054.2555-5-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 06:48:12 -0700
Message-ID: <CAFLszTjX1Ng9fGAxSVvtGMCdnPqrw=F6tpkPf3wsbnkE91_QfQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] test: dm: Expand dm_test_ofnode_phandle(_ot) with
 new ofnode/tree_parse_phandle
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
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

On Sun, 10 Nov 2024 at 04:51, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Expand dm_test_ofnode_phandle(_ot) with new ofnode/tree_parse_phandle() op.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  arch/sandbox/dts/other.dts |  7 ++++++
>  arch/sandbox/dts/test.dts  |  7 ++++++
>  test/dm/ofnode.c           | 44 ++++++++++++++++++++++++++++++++++----
>  3 files changed, 54 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

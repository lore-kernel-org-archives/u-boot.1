Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420D3D6393C
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C634288E94;
	Wed, 20 Nov 2024 14:49:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RaQsJiC/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 545DE88DD9; Wed, 20 Nov 2024 14:49:01 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46AFB89426
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa3a79d4d59so347013966b.3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732110539; x=1732715339; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MTblv5uiYB611pFYrLvJJsnvC8XxFVZK/cxxVlm/B1k=;
 b=RaQsJiC/MZp2JgH9QoXk0OA62DE8Rh5wvD2xwT/FSp6mcQFp3Cx6xkHsgW2VXUQDrz
 PZhFNj8MOcTEt4yL7/rzFdYHaknX733Jjt33CNZov98B2GHaGXFcLaMmfecOWPwB+6ZD
 ouaQFF8wh71V+vrVrCGJopNoP/FnxhZlOOxZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732110539; x=1732715339;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MTblv5uiYB611pFYrLvJJsnvC8XxFVZK/cxxVlm/B1k=;
 b=JFHrZoNy7ecEt5NDee3pOJu8LoenU/+EJNExIwfSR/D+2hw8w1FhZLNBVs9Z64tgYj
 feB/ummQi3DDHlCEsCYWTPZYvRkgcUnCCf4hBWSxQcpKEMZ1FTF6qXCNrizhRAtyb7Sh
 2XqX2w7vf9WqFeUsYJDiI9BoElJL2fk9V3HxtYqj2a7jTYzKtPWl4htVTRxO3RR0buC7
 0cz5tNCdDextdBNycUk9MO5LUbb4de6fF810mtdoqDFNOqnJ6DjxLhHVBarNM+W3HPJ4
 ueEkpIfLZm8GxzTJI+rvLHHM97qcm509WHEslCmQUt0lUo9KOPPNfvQg1jUdcdHhl7KW
 tB0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdsuqUoORS2wXGIMTnZHIPh0BqL+nzeydpAHDHKd1zmjfU/+q5Td0A1D6LcuFEDGT3mLy3P28=@lists.denx.de
X-Gm-Message-State: AOJu0YyK6aqOMmwM72Cglp9Q5NaenyV5iisAdf8OdNyrsAQB6QX2Mvq5
 jA7MK+ChUk5T0dcC+aX0A3z1jbJyoRG2IouGL1VCostZMt2kI09IzFu8MpVTPo7lowe6Y6lDpAt
 B623BH8BzlFclV7rRg/Bvj6n64nAzAmDdhToq
X-Gm-Gg: ASbGncvWKsviqWiUD0zrRrVesnE93e6+H2VxBN7BIsD70sBzR3XbfF3B5+W0a3/2lCW
 nu2DWt2hzRN47xIHZkBSzZNVgLN3Jd3A=
X-Google-Smtp-Source: AGHT+IF84M50TFWVGAU3GqT7lGD04s6st5MXRXJK3LneEyP6SkKVipTWVIAQKSmlmgrznmTNyoFAvtWaB8MSPgUVVxE=
X-Received: by 2002:a17:907:9707:b0:a9a:230b:fb5e with SMTP id
 a640c23a62f3a-aa4dd50a474mr297070566b.4.1732110538755; Wed, 20 Nov 2024
 05:48:58 -0800 (PST)
MIME-Version: 1.0
References: <20241110115054.2555-1-ansuelsmth@gmail.com>
 <20241110115054.2555-7-ansuelsmth@gmail.com>
In-Reply-To: <20241110115054.2555-7-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 06:48:47 -0700
Message-ID: <CAFLszTjG3h3UnRSw=3mD65Y+MsUBXWm5fMS51=G7xgYqsRazWg@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] test: dm: Add test for ofnode options phandle
 helper
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
> Add test for ofnode options phandle helper and add new property in the
> sandbox test dts.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  arch/sandbox/dts/test.dts |  1 +
>  test/dm/ofnode.c          | 11 +++++++++++
>  2 files changed, 12 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

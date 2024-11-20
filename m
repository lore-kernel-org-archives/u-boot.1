Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DEDD6393C
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:48:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1883989682;
	Wed, 20 Nov 2024 14:48:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WY0SlHju";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1341E892B8; Wed, 20 Nov 2024 14:48:33 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0850D895AF
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so877882066b.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732110510; x=1732715310; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gawpRbMDkh5iruq973S6OUJZ01sE2ajn6fW9HuX/9YM=;
 b=WY0SlHjuhODY4cW3eqkAHrA9RGbZzQSmjgPCRKYU/stkAqEqXBuS2j6uzzGnUawoGo
 Y8uezGfCsGpjtZ+J5PET+Hh96pLBJweO5jpqj3himrSIktYIDd2V6TVtJ7tcwzJSIpNq
 J8HeR5PyVoDz9C5+4wSlw4US5/4WVEeztIkmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732110510; x=1732715310;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gawpRbMDkh5iruq973S6OUJZ01sE2ajn6fW9HuX/9YM=;
 b=odLhMVrxyWkP+d2mf+Xw5pkGGImQtBtX0Vnzb6X6aIqKQbH5y0nIHpPq/4thsGds4/
 G3YV2HWCerCElWLxf+y9Od+kdmHheOJokB1f0j9s8RZMTksQ5I2I5nRL+VZJmbbpngGz
 o5RWCqLs5oJpcaWWcJsLUxSA2TM2oSvtZptV/zdoBOZ4lWeenX28gV2t0q26z7LBiM7g
 JF7SAUrb09BbxPkirnWGCrtLET8oFooaHpiQCsfQpX7ZVPkw7zScEeue5raoaSKDScaD
 8rKQ5GoikbWGhv3uL+ebq9iUBOxjCHlPxovjy9z9TMeNSsYEvWR6p81tQc5mBpHkGKNe
 R2Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUum5iyB/pypsLARl29VkC9Xg18qNht+lrIkHLGtRv8kVqgglTPYP83L0zwCZTkuDtsa6QGJ1Y=@lists.denx.de
X-Gm-Message-State: AOJu0YwrOUWXVAmmECCcpNgUopQRO3YbfpmJJQMC+vIgplg9pYl0GuhW
 0lVEHQi5SWTDsLdRZpCDWEujZKgKl2dt/709eUTDFN9vPE7tIwpMQYwcCUmXvvmlvjm8ARl5HpW
 mNTWP+hZQoy070CY1eMLZtONKK50ioVNYBIfi
X-Google-Smtp-Source: AGHT+IH9PldG9siPm2Dmb05cGy45qXMrIdzUhpJ3llw2yOgoRvwTNKMtuvspVuNIv3sTk1DTOS1bhVGioHY6C/VMjOk=
X-Received: by 2002:a17:906:c102:b0:a99:cedd:4612 with SMTP id
 a640c23a62f3a-aa4dd552e60mr287480466b.22.1732110510532; Wed, 20 Nov 2024
 05:48:30 -0800 (PST)
MIME-Version: 1.0
References: <20241110115054.2555-1-ansuelsmth@gmail.com>
 <20241110115054.2555-6-ansuelsmth@gmail.com>
In-Reply-To: <20241110115054.2555-6-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 06:48:13 -0700
Message-ID: <CAFLszTgKkaFUKn7UYQ2TpQAAmstJ_5ncparuNh+pcFq2tnCt0A@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] dm: core: implement phandle ofnode_options helper
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
> Implement ofnode_options phandle helper to get an ofnode from a phandle
> option in /options/u-boot.
>
> This helper can be useful since new DT yaml usually require to link a
> phandle of a node instead of referencing it by name or other indirect
> way.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/core/ofnode.c | 15 +++++++++++++++
>  include/dm/ofnode.h   | 15 +++++++++++++++
>  2 files changed, 30 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

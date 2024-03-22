Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD985C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0689488113;
	Fri, 22 Mar 2024 12:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GuO6i8dm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B48BC881BE; Fri, 22 Mar 2024 12:41:12 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61AAA87B82
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 12:41:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d228a132acso27014981fa.0
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 04:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711107668; x=1711712468; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/ckPMc+931s1aTeZ9eqLkSf/0MbiOz7lNQ3ZG0Corz0=;
 b=GuO6i8dmnKDDj8Bic4beXzAAHSfI//y6IVEKjIfMPTmq+N3y+anfEEkcWjepqm9IBS
 rXM+ZQ50cKlr6A9rGvKPf+mEkHnAHHP6GpKVnY6e2QXZGngNWkcF5wU8Fk1m7mxktosr
 2KBgfH/k5RLff77bJWtNJUSlBIR1MZO35Sbuf+e42EIdWBGG4BFlFDX3RCskPqeMkhVf
 tnnOSwBzkB+cZ96dT2oTzR9gmc+lU4ZBgReRnAw4HPh6BrvJ4OdeVp2tnzNfEFdUpgAj
 AstmS+i7erPDDX5X416ESvYAMeHwpmlJRvt5rS62ECGlNGsKSV7ow9oh4BXz0e4NIbmu
 f7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711107668; x=1711712468;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ckPMc+931s1aTeZ9eqLkSf/0MbiOz7lNQ3ZG0Corz0=;
 b=HI4nLDKj35IPoOYRT3tXENwsXdwJdm7rhYDgWvXg5kmA26AzL1NYA8WIlYZ/5I/YFw
 g4fSrIrSvHGCQM5cTypp62ApXijCNQJKZcUGsRq4CpuhmyvSHhN1E4q4wq12G8ZAdaQo
 2mobbBMPjiXO5lTjULrxCc4hnpvcrCoVrGdllgiKgqMLssfUaYrtpU3FOd3s9Df2jIaL
 x4uhoDntZLFY6+nny6Tblbq5n9jXobCP0a2l762EdJ8NiVkwoZl/NqjmmG71zZXIeont
 NQ/+Kvs0WUX/IXe8qbwwngU1cYqzFZTfPKhmPZron0KfBhnlTzkHwwC34umXSCIg/8fF
 X82w==
X-Gm-Message-State: AOJu0Ywbn9+iQPh6Z0l9X8ED5BFb576cANrKWHvPvDqZXFdxYq4ZX0rd
 N/XGUT+w6qZtTJsd9LzPh/wU/Al2ZWjdC2CqS21Ej8Wa0jp8PZXvnNQL0Y0DfjrGi1YrVwEPs2A
 onwvFN3jmGo9aoUNilggyqfahP/GQtEizE1TYbg==
X-Google-Smtp-Source: AGHT+IGbBIGj5HkMcJLqBViZ2pyZRR09JE5rY80EU5WFROepftE80ZhYsot1sFFIEdoZZ/hGGjCA/xG9JfMOILBOTkI=
X-Received: by 2002:a2e:8ed1:0:b0:2d4:74c5:2cd3 with SMTP id
 e17-20020a2e8ed1000000b002d474c52cd3mr1623302ljl.41.1711107668304; Fri, 22
 Mar 2024 04:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240322105733.203888-1-sughosh.ganu@linaro.org>
 <20240322105733.203888-20-sughosh.ganu@linaro.org>
In-Reply-To: <20240322105733.203888-20-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 Mar 2024 13:40:31 +0200
Message-ID: <CAC_iWjK2OG8Vph4uF8rRkKZzdJzt3ArqGPGx8Zocryz=8vct4A@mail.gmail.com>
Subject: Re: [PATCH v3 19/20] MAINTAINERS: add entry for FWU multi bank update
 feature
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Yann GAUTIER <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 Patrick DELAUNAY - foss <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <monstr@monstr.eu>
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

On Fri, 22 Mar 2024 at 12:59, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add an entry for the FWU Multi Bank Update feature.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V2:
> * New patch
>
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd9b2d42e8..5409b1d78a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1147,6 +1147,14 @@ T:       git https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git
>  F:     drivers/watchdog/sp805_wdt.c
>  F:     drivers/watchdog/sbsa_gwdt.c
>
> +FWU Multi Bank Update
> +M:     Sughosh Ganu <sughosh.ganu@linaro.org>
> +S:     Maintained
> +T:     git https://source.denx.de/u-boot/custodians/u-boot-efi.git
> +F:     lib/fwu_updates/*
> +F:     drivers/fwu-mdata/*
> +F:     tools/mkfwumdata.c
> +
>  GATEWORKS_SC
>  M:     Tim Harvey <tharvey@gateworks.com>
>  S:     Maintained
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2A7C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 10:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF1FD87E82;
	Fri, 12 Apr 2024 12:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BO/1RVpV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4399787ED3; Fri, 12 Apr 2024 12:43:27 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FBF587E53
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 12:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-516dbc36918so993819e87.0
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 03:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712918604; x=1713523404; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BthMwDyNIVvVsz3gNbPNfKb3j0p2WR8DxeM9/gspnxs=;
 b=BO/1RVpVjY30vk/j213QqA9FDhXDsJjSjmy7yYv/P9IgIZ+sHxUaX1RHABWJqgNVyL
 gbvoFpSfweBh5MDhTl2xt8zha39TENwhQDpcZUO6FVHLVyrLzh/76MUjAQTNwNkwBdsU
 otVqufOXObagilugTvN8oV0M4j+SGzspgDgsjjpyJAraowGJ7nSm8o2Oz77avLprYpI1
 UceECTeXUkpJg1nsQBRYncocxqTEJMQc8/nSrdVOe/ao2I8cyBbsPxSaXPoervGxpBiM
 je5xoMyPy9xPMtE/DAYIAuhK0lZ0iMz5jI0E9LjR68OOMYlmD2VRTePJ988z/+rafMk0
 ogig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712918604; x=1713523404;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BthMwDyNIVvVsz3gNbPNfKb3j0p2WR8DxeM9/gspnxs=;
 b=K183chhsoA1NiJlco1tmELlUjo9hr3I5WFtkL6g+Ig/jiDqiKpkupI8vbRXfGxYks3
 qHhOq/cJy+k959gvnyEumCRpwH0ng3j8DD8SmyhlSx9P9E6SkdVZ/0HjzrWU2Fev/fjW
 MEu7CDOmJBqBxRtDnwPibrpT0GT+XDbtLgaa3HNqJMrhitxZgob/MUNR9DeS3j187kKh
 Mqcu3tHgIwyUhPxNDRgWOAMvZjRF6O4xmWsgHr65IDrJVZz+Vdpc0qvt660O80cO5Mcx
 wJE46IU35/A+ForE0SAug4wYxYfvHbzkcCfd1Sxo+4vb014aarjGzzkb8evAaemJ3C4a
 T7/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnCI+Pl5YgmrHxwnysc7fyuIJUjS6wOdsPpkT5YXiSx9yrYRytK/KT2jjqwadig2q65jFcjRmKaYlyShPbe1+0yK0TSQ==
X-Gm-Message-State: AOJu0Yx/UTZ/pshu1YYaqk6G6giyAgOQTqDf3vPxsSZCI7opETNf2ZPr
 LJlwjSMIX3WUB1FwAlzLYDw2DbjIsFVS5vAspCHEVvEjNd4avKR6zOL5UDOrKjsEtZriUh0tdnA
 TOa0YejEciechfDachym6erETKKgz25DuePDBOA==
X-Google-Smtp-Source: AGHT+IHnEJ7USkA5ZHkT5oQckqkd3W2cr3kmYR0bEkFxy4C+LDGuGB5rsr67kLM7sK9wYQE5rdN5T3kJ+ve7d+upNWA=
X-Received: by 2002:a05:6512:3e21:b0:518:8fd9:7a2f with SMTP id
 i33-20020a0565123e2100b005188fd97a2fmr792638lfv.41.1712918604536; Fri, 12 Apr
 2024 03:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240408223134.165877-1-j-humphreys@ti.com>
 <20240408223134.165877-3-j-humphreys@ti.com>
 <185bd37a-9e1d-4daf-8bd6-57ce598e95fc@gmx.de>
 <20240410004440.GE2493117@bill-the-cat>
In-Reply-To: <20240410004440.GE2493117@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 12 Apr 2024 12:42:48 +0200
Message-ID: <CAC_iWjJLA571vMBCeVMrtHz5G+nTX_XG9PSkhhrqPNJxA77XGA@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] board: am64x: Define capsule update firmware info
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonathan Humphreys <j-humphreys@ti.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Judith Mendez <jm@ti.com>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Simon Glass <sjg@chromium.org>, Nikhil M Jain <n-jain1@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Bryan Brattlof <bb@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Nishanth Menon <nm@ti.com>
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

Hi Tom

From a capsule update POV the patch looks correct

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

On Wed, 10 Apr 2024 at 02:44, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Apr 09, 2024 at 06:31:02AM +0200, Heinrich Schuchardt wrote:
> > On 4/9/24 00:31, Jonathan Humphreys wrote:
> [snip]
> > The series has been assigned to me in Patchwork.
> >
> > But changes should be tested and reviewed by the respective board
> > maintainers (Vignesh, Tom for AM64x) as I have no access to TI boards.
>
> I'll pick it up once you're happy with the capsule side of things if you
> like, but in my mind it's more important to emphasize that this is what
> capsule support looks like as it rolls out to more platforms, is
> everyone happy with this?
>
> --
> Tom

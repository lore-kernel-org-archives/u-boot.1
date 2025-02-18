Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC65C021AD
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 11:58:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 823AD807F1;
	Tue, 18 Feb 2025 12:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ju8C0CJ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C881C809A4; Tue, 18 Feb 2025 12:57:58 +0100 (CET)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 073E480077
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 12:57:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-867129fdb0aso3461722241.1
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 03:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739879875; x=1740484675; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+NMJD8sR0LZ1iXeZBTX5IxZ1MeySmiWpfL2OC5YAPgs=;
 b=ju8C0CJ+L4AlTQ6psG4fE3ud5hdse4PitXvHtjplbuVeL6POtI9xnTfD/JNOiGIv/w
 Kembyk5qnTTXUXoWW+VnFTaAETdvvPmTUXtg3REn/6G/kK3q02HtVfzohX1vP908nYMD
 jeeWlprN9Abd5m4FkzA83NcqZCCvFpbSTQR66PkvastGmH+6fWJTmYTsUEvvXt93OR0R
 Z1BEuVz5fIptIiq4ALeG62LhHM+igi+d/aUWRenegz2fshH/Lajb2B9U0VVoFKUR/0c4
 F2J8ADrqQkR2mPLqFektc+yNFG7oJppHArQEeCEp463DDeVbCUSQoVDoan+gZhPPI5fV
 mQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739879875; x=1740484675;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+NMJD8sR0LZ1iXeZBTX5IxZ1MeySmiWpfL2OC5YAPgs=;
 b=fNWZ3yGjQdPraEGZBD4PlkbBS8BrGtGdNLyhXlgUQ5lZipiBgl2VixffWB5ZxYbsFO
 fQvS1naZ2qtjig1r0+xcdpgH3R1JDUPrXj9ZEIyzT0V83Ntir2Y33DT4Gt5bvzf/6IBo
 sFPZ1CSI/KhswSGpv1xkFbb3GF3LJxd3JtDmo8I02prvrQ+VR996a+apt0Bgkt6ihGSM
 EV0NNo5v/78eVOQXBdaOFBGFI3n698Qxhn9t8VBVBXnYhmI4/sFWdO3Qy1WS3XR8Lw7A
 wT70EsXl5w6InStWJu3Sa7bfNBKNpLPzcJPWUcnuDMkAP7Nl07FIM3bFQVoeBnfqyNJI
 rAcg==
X-Gm-Message-State: AOJu0YzwktgLf67BEtwyAOTOuQ5aZ7Hw81L91gah2ev3OhgtRtFH7pkm
 bNJlMngtQUgo5uU5lU/oCGGN7MnU0Y94caff9x5G4V1ogvo6n6JhhKvexDJonvpF8H4d7smm/7R
 pXq4+OzxuIc2Vl0SwEs4py0MfdnCqy1b8obllDg==
X-Gm-Gg: ASbGncsWM1cYP7r3g5giSlaIx4um4e4ZjZdoO+80HWGe0LA+6hh9CFP/b+cP3l1Hjau
 6xC5WReg/S74dENswPkcoEGqWAmKnUmKR66d7yikX5bG78W+hCNSXA0J0QJ0oBRzzMHVw5xDIdw
 ==
X-Google-Smtp-Source: AGHT+IEl24x2V6hdgWh2yMwoKgoHR5zGARqtXcYnvaVlABX7wEmLfa1Z9wJXMOWBdcrNmkR81VwlTiXcosHtZljXz7o=
X-Received: by 2002:a05:6102:d94:b0:4bb:de88:d027 with SMTP id
 ada2fe7eead31-4bd3fca4be8mr7158102137.7.1739879874831; Tue, 18 Feb 2025
 03:57:54 -0800 (PST)
MIME-Version: 1.0
References: <20250213131104.186663-1-sughosh.ganu@linaro.org>
 <20250213131104.186663-3-sughosh.ganu@linaro.org>
 <CAFLszThqvkcyBQf+Pn+7NsY_ERyP-mof+ic9-81z2wRQvmF3+w@mail.gmail.com>
In-Reply-To: <CAFLszThqvkcyBQf+Pn+7NsY_ERyP-mof+ic9-81z2wRQvmF3+w@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 18 Feb 2025 17:27:43 +0530
X-Gm-Features: AWEUYZmZrrYiDEkYh-2kC7JjJJZ1XtnB_unO1fbxUGsgDWGcyWravyKxA9u21OU
Message-ID: <CADg8p96c08cq-9c1NQfMpNK-S_YH7c=isXrjKWmfq2ayW4yMVQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] lmb: handle scenario of of encompassing overlap
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Udit Kumar <u-kumar1@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Tue, 18 Feb 2025 at 17:08, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Thu, 13 Feb 2025 at 06:11, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > The lmb_fix_over_lap_regions() function is called if the added region
> > overlaps with an existing region. The function then fixes the overlap
> > and removes the redundant region. However, it makes an assumption that
> > the overlap would not encompass the existing region, and in such a
> > scenario, it prints a message and returns without making the
> > fix. Handle the case of an encompassing overlap also in the function.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
> > ---
> >
> > Note: To be applied after an A-b/R-b/T-b from the original author
> > of the lmb_fix_over_lap_regions() function on this
> >
> >  lib/lmb.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
>
> Would it be possible to go back through your dozen-or-so lmb patches
> and add some tests?

I am adding tests in the first patch of this series [1], where I am
fixing the lmb_reserve() function. In certain scenarios, it allows to
reserve memory regions on top of existing reservations. Please check
that patch and suggest additional test cases you think that might be
missing. Thanks.

-sughosh

[1] - https://lore.kernel.org/u-boot/20250213131104.186663-1-sughosh.ganu@linaro.org/T/#m64b8622d1de3973955a9b0239de1f1304bc6d831

>
> Regards,
> Simon

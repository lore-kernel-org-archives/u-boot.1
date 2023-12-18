Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D73C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 12:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0384A877D0;
	Mon, 18 Dec 2023 13:41:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CXXvSkc1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F087876CF; Mon, 18 Dec 2023 13:41:08 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CFDB876CF
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 13:41:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5d2d0661a8dso22275477b3.2
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 04:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702903265; x=1703508065;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vxz9V0XnG4nkiD7BLYW3z50drHaAOJDUF7jRzF7XLRM=;
 b=CXXvSkc1xkxGVlmZ2sWbJPCxX2Dgc48wlapxtrgXWLpbLjtfwm6rgx9VgBYHhomEnq
 dcqrCInf7+zDzSxBum0ihq3rHpRARG45qjn3uAqe8UFLBoldUkJwvLmupGIT5SqxPyF2
 nV2st4nrYnFzZdzE8GbvNK/fzuVe0dFBkd66c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702903265; x=1703508065;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vxz9V0XnG4nkiD7BLYW3z50drHaAOJDUF7jRzF7XLRM=;
 b=WfF0gjFV1wjCx84tFbJPh7uSj8Is82bavqbC+Luot02y7rRj508D+mjEHY3pbO7n2v
 GcRqgkGkh1vUaR/KU+BMgIvul83mKQpsDFtbixN30zYaBI5N9djzKITPFE0hRhJ4U+oT
 GUbHvqjvymJFfPOQtDVAkf7P/AUXACBkfFP+cwuvryfJyGBeI+in6ls8vPtnDt4H67Y7
 /Buw/UWjg5RWoKVjThp4CY9s5hNie3OGro1wkRwGkDtSQqJ9whV1b5X+P9vlp7M99iAV
 dZBCfVcxH2+mhhIy/N2TjShTE5yBw1SOSFdSNqBBU8h6aZS8WXSIdADxXRRsH2XKkemi
 eQ0w==
X-Gm-Message-State: AOJu0YzGQZdGZR1UJmXhBT+8wQ2M0D1FrW/LOjjMeaM83hq6i4SyZY77
 gHiS5WgKfD60GAMuQe+SPfUB19w1oerfAiHcZVLpfg==
X-Google-Smtp-Source: AGHT+IFltFRB5ag7DFzIIwVoOYfkqS1UoD2rCY2AsKr40FmvIaVY8ZlfbIAmTg2vF0O1mvVJc49V+KCieGfVN6VOu3Y=
X-Received: by 2002:a0d:f904:0:b0:5d7:1940:b36d with SMTP id
 j4-20020a0df904000000b005d71940b36dmr13382840ywf.57.1702903265074; Mon, 18
 Dec 2023 04:41:05 -0800 (PST)
MIME-Version: 1.0
References: <20231211085939.5478-1-jagan@amarulasolutions.com>
 <20231211085939.5478-14-jagan@amarulasolutions.com>
 <f59bcbea-fd04-864f-b95c-5b4c4872c28d@yandex.com>
In-Reply-To: <f59bcbea-fd04-864f-b95c-5b4c4872c28d@yandex.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 18 Dec 2023 18:10:53 +0530
Message-ID: <CAMty3ZArSzsRQjNc-aB=JZF_6LzkD+OQZA_E=WcFg7dtDv8TVA@mail.gmail.com>
Subject: Re: [PATCH 13/17] video: rockchip: Add rk3328 vop support
To: Johan Jonker <jbx6244@yandex.com>
Cc: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Heiko Stuebner <heiko@sntech.de>,
 u-boot@lists.denx.de, 
 Da Xue <da.xue@libretech.co>, Jagan Teki <jagan@edgeble.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Please don't top-post.

On Sun, Dec 17, 2023 at 4:15=E2=80=AFAM Johan Jonker <jbx6244@yandex.com> w=
rote:
>
> Hi Jagan,
>
> In  your patch U-boot users must add a new file for each new Rockchip SoC=
.
>
> With the VOP2 introduction the VOP1 structures and functions are frozen/s=
tabilized.
>
> My proposal would be to use a file simular to Linux rockchip_vop_reg.c an=
d port it to U-boot as is done in the manufacturer tree.
>
> Together with a simple basic rockchip_vop.c to start with.
>
> Not sure if we need a kind of DRM frame work.
>
> Question: What do the U-boot maintainers think of this DRM implementation=
 in use by Rockchip. Is that a route that useful for mainline?
>
> Let me know your ideas.

Yes, I got your point-based rockchip-bsp tree of DRM. Technically it
wouldn't required as we have created this structure before and more
likely the new RK SoCs like RK3568, RK3588 are working on this tree as
well. Why do we need DRM framework as long as this seems suitable?

Jagan.

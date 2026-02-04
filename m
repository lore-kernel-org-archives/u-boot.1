Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F30BE8B383
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 00:42:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F08A083B55;
	Wed,  4 Feb 2026 01:42:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jnBj0CUs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DA0C83B72; Wed,  4 Feb 2026 01:42:20 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E23983A47
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 01:42:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-65808bb859cso9241473a12.2
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 16:42:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770165737; cv=none;
 d=google.com; s=arc-20240605;
 b=CXEmX+N8+Ucq3l3PDwqj1jeeksHE00TNN6Rkebg3y8wepyaNaZGYPTZvmr62P4Rs6z
 4CN/Z/Abdpj7BOxmwWO3j6Ix/gdEO/elV3b21KkqEWy/Z7vCugHvnTBozO8XmXJmYdSr
 amIpVPXdQS28GeRc82IAXPgE6b6yW6BSsyvw60Od+btH/O0gSmF0P/d7MaNERRYPd3XD
 GnJaaDAByrVxfspxzcVY/mF5StH2EaQvS5q+MMJYOxZqiyDHwWQAJJrsVnh217e05zcL
 T0Ry87TgjwVnnz5MZGqrXIB5YSdDnk6cx6hWI+r3+2GJGVC0K85SBVX8dRoFcWV6TLwu
 ynnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=STyORFQLyncE+jMuiVSnOTb0iNeSfRE5CkFd5CJLwEE=;
 fh=MOjMYoQYs5n65DJdFl1ADZcUQX4bemote/AAzhEVQdo=;
 b=fjkY0H6+wPL6aITRi2dHSDFZ81y8ZmjoAz9y6yu4pVMizfT/ICWmClVA+ucCp30rlQ
 9ReiO3l8Mf35d38d6xPMlz9d1RGsYywT41qGQTl6c4XvhrEPYauej7z0IQv/1TxSe/ej
 s0ZTKYWfutJZMxqSAOn8NPuq0NGhJA63SA0hb6LCbmHv5RC1a2MnqHzPVUATShuuY4Jl
 BxfvvupBpFoeppdEbTqCN4jYN2dL0YEPMt4wDu1GGqsIp0vsHTUKbywUjia0mwma0c9S
 1zaCOdPHQnSeuGe0CkAo68D8kHkU7jgg9m/fvEz+kY3OmrPSgK9AM3Qv6yNOw/eYB0Mr
 e5Vw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1770165737; x=1770770537; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=STyORFQLyncE+jMuiVSnOTb0iNeSfRE5CkFd5CJLwEE=;
 b=jnBj0CUseURzJM6k/+ZnR5BX5BskciJDrOQdIeKNi4G6lW2GJJjXZVZOSy1g67QqBS
 BBuOGU6H0nrOjjnK8xh8bhJ0Hd9HReVtj1SUeUaiLqJ8G32WdDq9gvmVmN5MJoFGEX2i
 QCbNpsZmnIg8gzfBgGN94kskwlt7q2vD+zmxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770165737; x=1770770537;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=STyORFQLyncE+jMuiVSnOTb0iNeSfRE5CkFd5CJLwEE=;
 b=f+7iv6rarDhyy1Nu+6kn60tk+/iuATzQpTvwqHklDmKJh340Q5l19ICAivyQAGU0p5
 WhZ0ojjLp/MvPZvDoDlg9qYzNbM5RQ0uCdx494uBMnwGG5hRYpV9wStuvwN99qQdQsWY
 Iq7RFGWGJDibP1eXn0nvf9AeDgAqrVgqWC+kWLJH0yFK9e9EnNeoaZcvM1DF0OqfxX/Q
 hAJjCm4ZKDpDjmGHN1P4McFMD0WzY9Uxuf+oDbtiL/mxeo6/aNlkalalVKteWrJGBlCs
 22q4/7h94XeddVoMAULqfQzZPiT2s/PCMykSnFAGf8ruSp5qIq0YQvPz6x9cT3YjAIyr
 QbIA==
X-Gm-Message-State: AOJu0YzPOswOmFEsM2fim++PehSxwf9JvtjREDw31t1g5mvITdN+HIp5
 Wg3K4CkeWOXfMlDSbWjeaAxx8yhH+Rlh2CrlokfhgDWhp+z4Hlzf5cq43bE45CYwl0mSFgAIlz6
 roiXzikxigR3PZOFIV5Ww1pllYy8ZbgLwo+Ngnsy8
X-Gm-Gg: AZuq6aKry0799ASLgtqtB7AzZAtPk74YDGZoO1FkV/+t5igcAtTFJemf1r0b6qF0fSN
 RNQn0CfHOnoJQrCV90lbLq2YnieEdMVACxAm7V6MzBqSGLXvSComFRsNlha9hVTHv0D2tZysjB4
 Sfy434yxrRILHfdzXB1ZuINjpGcIvhfzWblIX4dU+CFzMUrpHwy1bhNuazltFvAdJ4srbWaYcfB
 ywzuraLQp18aCghVxTIlFyag3KH5zV1C4GPERflhzC6o29RPqz+Uu9nKMCuaRg8hTArp4/cY+Bu
 1r/l92w=
X-Received: by 2002:a17:906:ee87:b0:b83:972c:77fe with SMTP id
 a640c23a62f3a-b8e9ef3138amr70316366b.2.1770165737480; Tue, 03 Feb 2026
 16:42:17 -0800 (PST)
MIME-Version: 1.0
References: <20260128000340.1504375-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTi2oP-vmCoPNayrKfVi8xMide3g5mR6XdcUgpaReyPtkg@mail.gmail.com>
 <a1491909-e775-4cf9-ac8b-a7b3b84d264e@mailbox.org>
In-Reply-To: <a1491909-e775-4cf9-ac8b-a7b3b84d264e@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Feb 2026 13:42:21 +1300
X-Gm-Features: AZwV_QhUNFJlQ3ElGdS_7Gyf23boDTBsUBcvBws87pRvpWr68bDjMLNf-jFquPg
Message-ID: <CAFLszTgP7k4NhRHgmQcrhHb+08ixvgEvh9p6Gr_ea7x939auSQ@mail.gmail.com>
Subject: Re: [PATCH] gunzip: Implement chunked decompression
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Alexander Graf <agraf@csgraf.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
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

Hi Marek,

On Wed, 4 Feb 2026 at 13:30, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 2/4/26 1:22 AM, Simon Glass wrote:
>
> Hello Simon,
>
> >> +       /* Test various sizes of decompression chunk sizes */
> >> +       for (j = 0; j < ARRAY_SIZE(sizes); j++) {
> >> +               env_set_ulong("gzwrite_chunk", sizes[j]);
> >> +               for (i = 0; i < ARRAY_SIZE(sizes); i++) {
> >> +                       ret = do_test_cmd_zip_unzip(uts, sizes[i], true);
> >> +                       if (ret)
> >> +                               return ret;
> >> +               }
> >> +       }
> >> +
> >>          return 0;
> >>   }
> >>   DM_TEST(dm_test_cmd_zip_gzwrite, UTF_CONSOLE);
> >> --
> >> 2.51.0
> >>
> >
> > Rather than an environment variable, you could create a variant of
> > gzwrite() which allows it to be passed.
> This test is invoking the command line 'gzwrite' command, it is not
> calling the gzwrite() function . And I don't think the chunk size should
> be configurable on command line by users ?

Agreed.

But the command test could just use the default, then add a C test to
call the unzip function directly with a series of sizes. Going through
the command is a bit of a pain. We have quite a few examples where the
command tests are more basic than the 'lower-level' tests.

Regards,
Simon

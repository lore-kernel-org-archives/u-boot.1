Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724A7E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 15:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37F8E89763;
	Mon,  9 Dec 2024 16:01:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TdzegRDR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E02C489763; Mon,  9 Dec 2024 16:00:58 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E956A8976E
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 16:00:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa67af4dc60so218415266b.2
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 07:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733756456; x=1734361256; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qQW1J42ngwJEIcLGK298OayvnqN4xTnAu1yaz0VqdAY=;
 b=TdzegRDRbTlfXpt7lP4fQ0FxJLl7BlxfhBhEYiHLwx5Lzsj1jGMmvfLbtrsW3V1zZz
 UACozOY/WSE9aJNELVTTDLplLjadj3KxynEUNiD3VzU84dwFYl2UyhkEH7HxJCKbrz7z
 RTb9FKG0cDcbcffsmNmRWyeEeZ1iHeXMSJAB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733756456; x=1734361256;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qQW1J42ngwJEIcLGK298OayvnqN4xTnAu1yaz0VqdAY=;
 b=ua1pDnGBzSgJhnPRF6f74sqkBFwNQSEotVi4YdaTHAztp6vgn6Gql53SMJvP8/onve
 EovoVNvB7HCJtIWAg2ESTtm5sCj2g5iZYvoj06VOcEnKTFdrlAeMO22I4RB+xQB/1y5F
 l2P8jqVbpfVnBDO2dskHIeA3zafs8Ql1I5oxqW+bJ3BY92NRaHZOxL5Sc17zPu4eaSUu
 zt04Cz8i2BChyy26t9GWMq5OpyXPzFMYSFaQVP8D+dckKOucOOyHPYsZpKfNZwufQFVQ
 mbxJauZZ7OMRukeMp5N+5YPheRDh1hE7HrcuWYW19DdMyo0LfE3chrZzHzTrbgj5/ANG
 hz1g==
X-Gm-Message-State: AOJu0YyrTq/qstKNu6rd2Qsqbn+IQuCu6BOsbyf4+RBDcmmpGICxnKuA
 8NuJQ6JtkSm0+FWuE10N2PFvIvGwWstCGI+wwArHMNpPkYUR1CjRQ/hu/vB2dnI8CNtcs6VL5Ak
 7yQ+ZakEbC7bXytd3ri9xCyqsKsOunbh8xmDt
X-Gm-Gg: ASbGncu1ux98aFWeOTPej5U6Q4UW9m/hePX/HgU80/Q5Tbvio1NgbMDAWAsScFP+ae4
 NNGwudypvYX23A+dp4TDrJI81JT37igdl
X-Google-Smtp-Source: AGHT+IFefZhYooWYaIFnqdIIcuMZWZkDLzGnz4USM0fwkb+YLxw3ZjTrV7AJNU5OyUImRQLwGH6GYrYNvYaIZgo6YMg=
X-Received: by 2002:a17:907:9507:b0:aa6:9372:cac7 with SMTP id
 a640c23a62f3a-aa69372ce49mr170353066b.31.1733756455923; Mon, 09 Dec 2024
 07:00:55 -0800 (PST)
MIME-Version: 1.0
References: <20241208190741.4192601-1-trini@konsulko.com>
 <20241208190741.4192601-9-trini@konsulko.com>
In-Reply-To: <20241208190741.4192601-9-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Dec 2024 08:00:40 -0700
Message-ID: <CAFLszTgRqGYZ4GWHyuCnmVVODi3XR9iCdLv-ZZZqFsJ04NgBQA@mail.gmail.com>
Subject: Re: [PATCH 8/9] doc: Expand what we say about building the docker
 container a bit
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Sun, 8 Dec 2024 at 12:08, Tom Rini <trini@konsulko.com> wrote:
>
> First, try and be slightly clearer about what "buildx" is with respect
> to the docker build process.
>
> Second, now that we build the container for both amd64 and arm64, we
> should document how to make a docker "builder" that has multiple nodes.
> With this one node should be amd64 and one node arm64, and with
> reasonably fast arm64 hardware this will be much quicker than using
> QEMU.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  doc/build/docker.rst | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9370FE784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:44:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CEDA874EC;
	Mon,  2 Oct 2023 03:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jAkDffOb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8025874DF; Mon,  2 Oct 2023 03:23:18 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 582D1874CC
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-52fe27898e9so21890926a12.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209786; x=1696814586; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ewwJzs4vHOUAVlcpfeYT2MQq+jHa3r4VyPbROeahSlA=;
 b=jAkDffObbqIEpUy0cFW4TZRmZjR5PDitMEZLWgHYJ5Ah4gB0choJINI8x4gKH87oKZ
 bXhHRopF4Zz0ai66BMGXYiumVfL6R2XWt3E6agOE4/J/poZ99HXFvDIkyD8H3dR1QL+B
 Xbfr4HOFJMj1wx8F1c0NHRMtZO9ap1rWiLIKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209786; x=1696814586;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ewwJzs4vHOUAVlcpfeYT2MQq+jHa3r4VyPbROeahSlA=;
 b=ELC3myfTMrKsIxriHIecW4zK5/2yXH9kSro0x782riePMTy1sALreUMM9yoIF4nM27
 Jghanvzz8P3BAVjdGwvXIZz+zxjmoYhAyqmPPz32DxLXOj1MbBwrjU+ELj02JLjPvbfq
 b2D1rGOECOHGo8XIFUxp+EcI1sk6WgAUMqO7b/kJtZ1hm7R3BE6hCp9DwMgGwakewsib
 umFtBY3LFi/Uo2KN9j786QgR+bN/0wOy3nv3uCl/S/1riE7sOMv5vBSNOzXxBCv1vfRw
 RfLVI587Xt16XYrxOYB7YlwSWj15fICdAzkFLDjyn5oKx9ZqiwVrgtG9/5hlUKgpkhWF
 cNQg==
X-Gm-Message-State: AOJu0YzWlHy341CoRk0yCpWsq11FgvObkAKb4yqPZJF2p9705i8zdur4
 2HsWoYZCwLygbm4bMWf4f2V1vf08dmWqef6nBPNDnQ==
X-Google-Smtp-Source: AGHT+IHGnorIUy2mZmNwPwS+NpRxnYb0i1ORt57KEZVLPnXEYJkN60r3yGNEwFTai+rLkjnsvLkEU6AO2EYEbWBBK3A=
X-Received: by 2002:aa7:da0f:0:b0:533:e314:20dd with SMTP id
 r15-20020aa7da0f000000b00533e31420ddmr8782385eds.13.1696209786177; Sun, 01
 Oct 2023 18:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230926070043.738340-1-takahiro.akashi@linaro.org>
 <20230926070043.738340-5-takahiro.akashi@linaro.org>
In-Reply-To: <20230926070043.738340-5-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:18 -0600
Message-ID: <CAPnjgZ2rEuJVxA6inM8E+v_aFSurafGN7s+_2mNSTXZGPHcObA@mail.gmail.com>
Subject: Re: [PATCH 4/4] test: dm: add SCMI power domain protocol test
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: trini@konsulko.com, etienne.carriere@st.com, u-boot@lists.denx.de
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

On Tue, 26 Sept 2023 at 01:01, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> This ut has tests for the SCMI power domain protocol as well as DM
> interfaces for power domain devices.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  test/dm/scmi.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 106 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

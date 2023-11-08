Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90607C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:28:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88F3B87755;
	Wed,  8 Nov 2023 05:26:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e1IOKfOh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 886F4874E9; Wed,  8 Nov 2023 05:26:55 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCD938773F
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5b499b18b28so77949277b3.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417608; x=1700022408; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KCW4k4CLdEEl2cKFP3OxRCHdKWgaTm5rZnjV7SXsPK4=;
 b=e1IOKfOhH0mZGCmzy02W9aITFBVjnQV1yyri4lkGwQ2n1UyMa1ktG2SehPCgqc6zaj
 E1Gs2BWGRo7REVYAHnZ2JM51w4w7PY0d7lQnBU6iZZIPTyHm2KkALlyfZvoRw5powEU3
 eZ1Iaoqau9a503MAk5CQ5XjFJZN2bGZp+5sfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417608; x=1700022408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KCW4k4CLdEEl2cKFP3OxRCHdKWgaTm5rZnjV7SXsPK4=;
 b=SMr0BpAhGbFNfOKfQMl/5M+7MQJYFoTAnuVL4+aFBvA6gz1GXs57DrFyXdW46eCa9p
 GSqN6UfQOe9Vy7viwiq37FA6o2Ut5OtquAaVcZ6ygEqOGCypJVvnd6AAYMtLUA6sbhGA
 idzpvGnrUhRg8VhekwBrw5kXgFFTy/dHfEaUm1r26q9w16WyHiUaaabRF7xEzXe7XDYZ
 grPQvA8+IFNN3NWZA1Z8jWdRJ/gMVEm8homzF8o3IyzziLHmxbKp4WWt+Gmx+yfP/W2f
 KO9Ohi2F/8A6uAhl3ZB89FQmLqWX+T8vw/ACGB6HIgjOMcM/YK5D9c1FzoHZqBAGQDeS
 jaPg==
X-Gm-Message-State: AOJu0YymiTxGXZ3wBGEvyQF6R71+iR+on6L608WgiSaH1qQK9QE33YGc
 k7/rHn/XCnQcNFQXArqW0QlS+7cZZ71c8IWqvdHqtQ==
X-Google-Smtp-Source: AGHT+IH3D32pZXIZrX9U4oszlF4LXkqQ1AkfdiGdzXfXyPVpRDLniqAOHlioWdFmdwYFnAg+kYOn8A3VlOkaAOepK1I=
X-Received: by 2002:a81:9106:0:b0:5a8:60ad:39a4 with SMTP id
 i6-20020a819106000000b005a860ad39a4mr793656ywg.3.1699417608101; Tue, 07 Nov
 2023 20:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-19-seanga2@gmail.com>
In-Reply-To: <20231106022603.3405551-19-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:24:02 -0700
Message-ID: <CAPnjgZ2Z9DLHRkUhr-C7gU-bC=MOG5+49JELGrdOuXk5+uP49w@mail.gmail.com>
Subject: Re: [PATCH v6 18/25] spl: Convert nand to spl_load
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>
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

On Sun, 5 Nov 2023 at 19:26, Sean Anderson <seanga2@gmail.com> wrote:
>
> This converts the nand load method to use spl_load. nand_page_size may not
> be valid until after nand_spl_load_image is called (see e.g. fsl_ifc_spl),
> so we set bl_len in spl_nand_read. Since spl_load reads the header for us,
> we can remove that argument from spl_nand_load_element.
>
> There are two possible regressions which could result from this commit.
> First, we ask for a negative address from spl_get_load_buffer. That is,
> instead of
>
>         header = spl_get_load_buffer(0, sizeof(*header));
>
> we do
>
>         header = spl_get_load_buffer(-sizeof(*header), sizeof(*header));
>
> this could cause a problem if spl_get_load_buffer does not return valid
> memory for negative offsets. Second, we now set bl_len for legacy images.
> This can cause memory up to a bl_len - 1 before the image load address to
> be written, which might not have been the case before. If this turns out to
> be a problem, we can add an option for a bounce buffer.
>
> We can't load FITs with external data with SPL_LOAD_FIT_FULL, so disable the
> test in that case. No boards enable SPL_NAND_SUPPORT and SPL_LOAD_FIT_FULL, so
> this is not a regression.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v6:
> - New
>
>  common/spl/spl_nand.c      | 70 +++++++++-----------------------------
>  include/spl_load.h         |  1 +
>  test/image/spl_load_nand.c |  2 ++
>  3 files changed, 19 insertions(+), 54 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

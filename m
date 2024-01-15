Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3252FC3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 14:57:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42DC687214;
	Mon, 15 Jan 2024 15:57:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KawpinNd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B294F87061; Mon, 15 Jan 2024 15:57:17 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3174A86FC9
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 15:57:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5ce942efda5so6479748a12.2
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 06:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705330633; x=1705935433; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YPKqC4N+h2XkOF34VhTM4DLxVP7T2hqaNYlb3Hb4xOk=;
 b=KawpinNdSdi7jFAR1qySu6Z4+WK+jKfS/iDMXMR6LOGHryNDDVHl1jZyrbX4DONj7W
 apPJaXX97TFK9mhvvb7YW0UsdLwMrbyxtYwuzG7rIJri85wgvFezZK3OFCaSWIT7susj
 gK50eBSk/XwW1+/yXdWyxrG7t6KISIQsC6kKDNVEdH+afGbclaDmZw7edNHVzFoC+8UL
 xLNtS+lDRpPKY6r+sNmStaQTaEtSthhFI8M6JkrXY/48P3vGtNZN9pC3fPe/PRBgrfgK
 h/qWb+3CrBBK3+VBqzk0rSOWb2qUkC9x+nybcfnbXS4J/5dqoSdifUNg2xWhSRQeXz0O
 nO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705330633; x=1705935433;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YPKqC4N+h2XkOF34VhTM4DLxVP7T2hqaNYlb3Hb4xOk=;
 b=jX7aANhNgw538UU0PnBj+Ew5G3Kz8K8WK9U+/ehSO/6+3caBgsWSqbTCTRvRG4tYN4
 vjs2Xiqw8eW76+s51s/t41xQkvyOE/vlmLQEXrTNYRJdJSCLiJHzOAj5TfbUzLonc8D9
 eU5FnvKPN0TFzPibaG+ZKfEULlXVsr2O7FyAfcfTa38mGHQ5aCeiuw5SajC9k3Lkh/YA
 kaU15UE2pCa9s14m9vvOMFgA2FsJag7l2FbVFjXmsth3qzZLvsZYlbKmNeBtKshnlsqD
 Jmx4kur5mAqkVJL+aNWeq465ymtvppq91k8W+OC4THJFDvYwkesLZTVBMumtds4vA+1g
 WAzA==
X-Gm-Message-State: AOJu0Yz3QVWbzy1zPflmIcyHhj7g3jTZRlNwvEXfaZy5371EdBP4stGF
 1pr0kD7K8SCnTp3qfx/QZZaqZbIYWSSL8cki5tttjwt4h/YPpw==
X-Google-Smtp-Source: AGHT+IGG9QWitk3PdxeztoBst88/zMGimPWxH+/ZzZDykIhyKvtFpnBS4a5lqsBDOG+dOzT/y/km0y8U+g6ct94Z3GE=
X-Received: by 2002:a17:90a:d60c:b0:28e:e80:cfb2 with SMTP id
 w12-20020a17090ad60c00b0028e0e80cfb2mr2998147pju.84.1705330633478; Mon, 15
 Jan 2024 06:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20240112213337.185460-1-raymond.mao@linaro.org>
 <20240112213337.185460-9-raymond.mao@linaro.org>
 <20240113152732.GH1610741@bill-the-cat>
In-Reply-To: <20240113152732.GH1610741@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 15 Jan 2024 09:57:03 -0500
Message-ID: <CAEfUkU+fDjfJ02Pjyeock=MhV-SUU0raw8uSvfAi6mwxq_R=xA@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] fdt: get FDT from bloblist
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 jwerner@chromium.org, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Kevin Chen <kevin_chen@aspeedtech.com>, Sean Anderson <sean.anderson@seco.com>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,

On Sat, 13 Jan 2024 at 10:27, Tom Rini <trini@konsulko.com> wrote:

> On Fri, Jan 12, 2024 at 01:33:34PM -0800, Raymond Mao wrote:
>
> > Get device tree from a bloblist if it exists.
> > If not, fallback to traditional way.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Refactor of board_fdt_blob_setup().
> > Changes in v4
> > - Move the logics from board custom function to fdt library.
> > Changes in V5
> > - Rebase the changes on top of master.
> >
> >  lib/fdtdec.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
>
> Why was this just not dropped after:
> commit 70fe23859437ffe4efe0793423937d8b78ebf9d6
>
In commit 70fe23859437ffe4efe0793423937d8b78ebf9d6, the FDT from bloblist
is always overridden when OF_BOARD is enabled (OF_BOARD is enabled when
OF_HAS_PRIOR_STAGE is on). I think this is not what we want.
The FDT from the bloblist passed from the previous stage should be the
default setting.

[...]

Thanks and regards,
Raymond

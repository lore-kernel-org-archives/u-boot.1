Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2BBC8303C
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 06:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 801568349B;
	Fri, 11 Jul 2025 08:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tKOJqHA4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12638834B4; Fri, 11 Jul 2025 08:18:03 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAC8C8344C
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:18:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-713fba639f3so16804307b3.1
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 23:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752214679; x=1752819479; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kFcjbuSLXrvHqpa2KBbe3/sBF7SKBAQNdA0Kda9i4/c=;
 b=tKOJqHA4TY00banx6bPMIWvhjzL8ZFhJKj8tdmBq8XB/dpGNx94YXfkqgP9I+kxqdx
 0GsVxQ9H2uf+PahZVYzl/n0P4RXRXsz7EZVfJOfVGahut0vcBWoqKLZ4vWDsbx0fBbtc
 LtTxqQHDrXnNOByNZ6+7aB1hlPDxckrY5078NaX0hXZSitE1f0iYM/bx4b45uqw3mMvA
 4PLrHSQKlxaMl0vCm6uK4Oih7v35Rb98TznrRu5zqdVCE115jSzaZ0XWEPJyqDOXoaOb
 456oulFQI7GyVWcIqgXlLvuPFYx5u6JTs0hj/y+R7WSl6fmJjKD+BVX581/HuAvd7ugr
 j3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752214679; x=1752819479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kFcjbuSLXrvHqpa2KBbe3/sBF7SKBAQNdA0Kda9i4/c=;
 b=RAGJuFlTMNMgrqdqANiukw8iNyMeKzUhk/acqGAIHdt+5AkdsMWzHGuVgKnyS2BMWk
 p8GIYDqMOnHQ1Lu7VCQKxOq7iYUVD4+KSRFPbacESMTSbX2ma6ussv5GXVSY0R29Ok1S
 fIEGTuACwWrrFe/cdOgolfHLeg4ltadP06o3xrkIy3cr1se+4lprxitBNXdLIVz6VqA6
 TFIT1jq83qzgHz+sQdKKfeMZFaBswcUiAcLy/eZggbPwl/yX/jjYvp1OPEJyzNhIikTZ
 uGpUU73enp4kVhUPW9KU1ogTbdtFROEcxfD3pJ46yH4+JABH8576PdF2plkdo036ZlBD
 dnQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHcTa4QX+si+c6C49M6wDVbB7SGS+O1jVIBGB9H546H7pNE1B3pzOzzRS39nRniJfVAD2spE0=@lists.denx.de
X-Gm-Message-State: AOJu0YxvHw989taru9c7OV6BpTcp5sGT5lbvZq8kvtIqMbuts6vlogry
 HlFAvFt98F++SPt/DN/X+BobFA2q5kdDpxmOvEqWnSl/6Xs3I61mMUvGxiqiUvbHkUC7rV+yUFv
 zU4nKlrsXukkCF9ZBfmPAJUpT/7pY8hdhFt9QnN1xww==
X-Gm-Gg: ASbGncthpAAzMY1N/zV2UOlgStaiY9jPaS7zQuuNqcj6n2yGl212zIuMCWN51+353+w
 xrgy2B4PRTyqPNHf9VlbqVra1WKQNtluwUS1CqLBHijf3k4I19zzzKEaKm+hZfwF+4EPXxkvhYU
 ETLM1QCsNASqNPEter/AoOyRoKNTf79MR9kiFZqZy6YeCnieymPxUVVj7swWLQ3TUyBuzLbS504
 QyTX/U=
X-Google-Smtp-Source: AGHT+IH0TnUeMnuvJVqYYnxaBsHG/RiKJJ/DnNziuhJmr7upPPmEKbPnxEBhkYo7hkX1szqaeAwCx4du4ClIowh5KCU=
X-Received: by 2002:a05:690c:628a:b0:70e:7ff6:9ff3 with SMTP id
 00721157ae682-717d5f3d391mr39579857b3.35.1752214679398; Thu, 10 Jul 2025
 23:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250627185723.342553-1-ilias.apalodimas@linaro.org>
 <20250627185723.342553-2-ilias.apalodimas@linaro.org>
 <CAOMZO5DP=8Jebnm32mPQ6s7rcTX62dgKqyzyrdco9dHNewyWKQ@mail.gmail.com>
 <CAC_iWj+rJgUGkpEV-vYRei9R-UPj3J_2ix++K3P-ZXK8C7Vneg@mail.gmail.com>
 <CAOMZO5CDkeD633fG-pELUF+QyzW3ftP_eQ3LmrjUTuaidY1c1g@mail.gmail.com>
 <8df9cfba-662d-416e-ac21-5ae6d4448708@amd.com>
 <20250710150154.GC6424@bill-the-cat>
 <CAC_iWj+B2p-xfcdJS14LZAAjxGsxXeuBbm0CxJf_DL4E-0ytFA@mail.gmail.com>
 <20250711052705.GA5353@francesco-nb>
In-Reply-To: <20250711052705.GA5353@francesco-nb>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 11 Jul 2025 09:17:23 +0300
X-Gm-Features: Ac12FXy0kb2OQVUU7WBuV2nWQ3D8dWy_lDBiBgsDyody5zmiOMcvT_SNZNHiI2c
Message-ID: <CAC_iWjKXpE=M9VjEjr2ZBdTjzEPudXNFa1ARENVc2VyDJ0XR3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: Bump the build system to 5.1
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, sughosh.ganu@linaro.org, 
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>, 
 Olaf Mandel <o.mandel@menlosystems.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>, 
 Prasad Kummari <prasad.kummari@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de
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

Hi Francesco,

On Fri, 11 Jul 2025 at 08:27, Francesco Dolcini <francesco@dolcini.it> wrote:
>
> Hi
>
> On Fri, Jul 11, 2025 at 08:15:25AM +0300, Ilias Apalodimas wrote:
> > I can't reproduce this on my Ubuntu and Debian boxes.
> > Can you paste your Ubuntu, make & gcc versions?
>
> Our CI is also failing builds.
>
> We build within OE master, no other changes on our side.
>
> TI platforms are affected in a similar way
>
> | make[1]: *** arch/arm/mach-k3/: Is a directory.  Stop.

Can you extract the make commands used to build and paste them?

Thanks
/Ilias
>
> From a quick check, with arm64, everything is fine.
>
> Francesco
>

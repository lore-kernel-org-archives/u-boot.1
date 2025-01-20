Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60139C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 13:45:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB80B801CF;
	Mon, 20 Jan 2025 14:45:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g7/+25Lc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC814805C5; Mon, 20 Jan 2025 14:45:38 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B33A380077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 14:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-30167f4c1e3so41026451fa.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 05:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737380736; x=1737985536; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3V5EItMD1m/REiyvUDGoI3i3bZSl6jlfAPWQ9ZUTbtg=;
 b=g7/+25LcwOPncVYDeYb+nluVw7OO9sS373+zzyI/wgRus3b5oSlEtQ2B161qcafv3M
 WEKFvJtW0OhOjqtqk72HBYF792ftLMG8GzO0xhEYj1FXXKWtY69GrmygO97mKVz38a9s
 k4yXz8pZ6wKbJwGY/ZG8D8ZOigANpkp5TqRkTSA7S0gi0fLpvgkxYrRKOUJWtPeTj4d+
 HKi7W21zAZC6zczm21Vx3guLsoTUmB0AtcYz2M6ARz5fC4sOSNwdjhOmZyeczUQGxaiu
 5ADWhP+lgJ3bY1BfHB5OJiBkajCl5N/FqHCMR1/P/vGtW0i3y/kmMFhDMi8vSP09omvU
 79OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737380736; x=1737985536;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3V5EItMD1m/REiyvUDGoI3i3bZSl6jlfAPWQ9ZUTbtg=;
 b=O9AEaN1N9tewAB1BPWXMJ85UA2xhI+2ByERzEp1oU5KGqBGrVxnQWHlNJgMK91wmbp
 7cnxNg6XEROopSLVpoReQSDUvDycKqivUrAT59XXddzxj41JGa+tknslaOelptoskXer
 kvbSO1WG0TMsE7PnOG+i+yxlxBKQCQpWnQkzBX6T/oEBEpNfgcSfkcDpc93DO6+fSO+9
 ycyAe54jOLUjU1i6OZxNoiRKMrYYW53F4cakNaZvPPklrEPhyHL10VXPiZY5IEOWf+xX
 o7SWyqTdk8G0ek+l09naslk5DWZo4O15xFkU98XvrBDyaNs3RM4uyaBUOS9ha0Yv6XrM
 RObQ==
X-Gm-Message-State: AOJu0YwEuVD9SaOxPrIHaX0U5NK3/4WIo6PXM1u1gVBlx+cP86GRI82B
 vnn4VOZdx/bgGEOocOJeSoRPWJSQm3dEt4QVO0yqN6YPodUX76Ik4DsaLh6N4NLpi6OsJT2lFWZ
 3NikK4b3QR6rJFADLm+ETXL2pPIoOyA==
X-Gm-Gg: ASbGnct2/E9CzseSdHgl8LmrEiq/gIvubfEw5MO3tE5mOjwcE29gQQJ0VcE+Vbn8l3d
 LgqUIVPmiiLBJFIHybxsYv/v62xzNffBPWJCXRSM7x85uHVthr7GkJL/1x5oxmvhtFH0LJbr7oI
 tspxj0CWI=
X-Google-Smtp-Source: AGHT+IFINk8dV7hXDTdmatuI3Gf8kSrtiIDPVAG/DrwaNMfcfN5W7918NFvZwZQJLXf3pGVqqbdrXrgLtSbCY1mbgkk=
X-Received: by 2002:a2e:bcc1:0:b0:2fc:9622:794b with SMTP id
 38308e7fff4ca-3072cb66415mr53439181fa.24.1737380735801; Mon, 20 Jan 2025
 05:45:35 -0800 (PST)
MIME-Version: 1.0
References: <20250116040449.306098-1-marex@denx.de>
In-Reply-To: <20250116040449.306098-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 20 Jan 2025 10:45:24 -0300
X-Gm-Features: AbW1kvZIthYl4RNsXOaZ5k-d4dX1eikwL6uitJt1yBKivA8qpFJntEO3F6x_cjc
Message-ID: <CAOMZO5BV7G6Z5Ko2-ag9GRtjfeswsvq0w7+Ko=pJjN2rCcRVKw@mail.gmail.com>
Subject: Re: [PATCH 01/13] net: fsl_enetc: Introduce enetc_is_ls1028a()
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Markus Gothe <markus.gothe@genexis.eu>, Peng Fan <peng.fan@nxp.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Robert Marko <robert.marko@sartura.hr>, 
 Romain Naour <romain.naour@smile.fr>, Simon Glass <sjg@chromium.org>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
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

On Thu, Jan 16, 2025 at 1:05=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> Introduce accurate test for LS1028A compatibility based both on
> IS_ENABLED(CONFIG_ARCH_LS1028A) and PCI vendor ID. This is done
> in preparation for adding ENETCv4 support, which has a different
> PCI vendor ID.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Series applied, thanks.

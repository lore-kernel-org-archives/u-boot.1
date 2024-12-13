Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B72E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 05:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6576A80192;
	Fri, 13 Dec 2024 06:40:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SanjdD3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D293A801CF; Fri, 13 Dec 2024 06:40:10 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3648380141
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 06:40:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6eff0f3306fso10935187b3.2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 21:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734068407; x=1734673207; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZaXKeOu5Jo5rOXAT1jSYtBF5bPFjaehtiSfdfzKM1KU=;
 b=SanjdD3bbcnnDwu95DRp0skayDJRMyZVZmMqyjiqEFigvN1LWR58RYdKclHNaDRJVt
 fWFR4mm4Itnsla3WzVTGc4BAcGkKDd8XfWpXqPDehI7Zaxla1WU26wTzgNZnrmSCPP8G
 VQQPBIbkJTHrFupR9qKZZ91hG6peDF+ZvbLl+5vs9gNER5lFoFZMvWKHXlOQLHLM++iO
 cxEVK//EplCBv1qlRzjLEIcSZ7GC36w+vntB+5j4YyUKnqXx9JKrDNdWhMZ6p4qx3eUl
 DzI9THjkUxns2thakZWd4Q/Lcsih3ls5Ew4cAM0Luw3o2eMetO6QYw63DdTLKB37bCf/
 E3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734068407; x=1734673207;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZaXKeOu5Jo5rOXAT1jSYtBF5bPFjaehtiSfdfzKM1KU=;
 b=KqqlAwjH3RD/zvk+ARuM8i3heMzsQ+iHFlRFLTpoJappMABAkGfFcdyc2wxeYLsxJP
 bllXZ5/l/52iUNVbcxxCpIy9V6aRIkpHQAj1Btl3JhE2Abl+FhhKSwlaanEYgYJq4DHy
 8dPa89k5uLAanoIhaB2viBiRG2lwnF10Gi2F+iOc1Jiu7xitEI0jPbGGA9bZ93wKLu2z
 64WmbmKf9CLAePmDBexGGi1ZolS1jcn+KpLY3CWENN3OUZOR8pR2+oY6ayZEcSTyU0l+
 zjsHoezmDIuL7gL7VoxIDR4JATakSokm+TJsKfdrbuaVEHQouME/QwanQVqyWZ/cRWCD
 BIuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRMWERJen8QOuCqG+MLYE/JVV3EaEzquGEwKSnRjW/V/jZ8rsOGNQZLFYntwTit9h1nt81w98=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3+EH3xHYT89CWM2BeYX8vMZPV89eTH+JghOHhh3Ahw4VUfwFI
 4hHFuZGtxDN/sB1GZyZzPDhNy5YqdboGrHxORrqrb3pqg2p90Amt+iVcaDpOePqHiKbiK7gpPRG
 zvTZ6QUZHN8+8+e7OlxCW7SR+/yI7/PiRgiQ4mQ==
X-Gm-Gg: ASbGncuMKaNZ8NRz9mhelbDjcYeVeKleVJJsaOu8Ek/eymdfdRXmJfYB7kPLanPSuB1
 3EkdOYlUg19kpogPVRw81wwQUtoIO7x4Eu427iA==
X-Google-Smtp-Source: AGHT+IEsBVWKfAD1ndJ/xqIPDLiZA1JBuNQ+mGO+jq4fmHnXAeajTLWZPzGN1DWCeKuGcEuS2gkMBg3dkMCJ4xG5rvo=
X-Received: by 2002:a05:690c:f95:b0:6ef:79d1:2f69 with SMTP id
 00721157ae682-6f279b8da0amr12836957b3.31.1734068407084; Thu, 12 Dec 2024
 21:40:07 -0800 (PST)
MIME-Version: 1.0
References: <20241213005903.73919-1-sjg@chromium.org>
 <20241213010525.GN1505244@bill-the-cat>
In-Reply-To: <20241213010525.GN1505244@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Dec 2024 07:39:31 +0200
Message-ID: <CAC_iWjLykti=CG70ADm1qYpR7RzWqgSOcZjhp9SgJTh3UCdp9w@mail.gmail.com>
Subject: Re: [PATCH] gitlab: Add an rpi to the sjg lab
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sumit Garg <sumit.garg@linaro.org>
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

On Fri, 13 Dec 2024 at 03:05, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Dec 12, 2024 at 05:59:03PM -0700, Simon Glass wrote:
>
> > I have an original rpi installed now, loaded with OS Lite (32-bit)
> > Add an entry for it so that it can be used for testing.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> --
> Tom

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2DAC3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:25:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E00782AB9;
	Sat, 10 May 2025 13:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SWVLntLf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D19D82952; Sat, 10 May 2025 13:25:50 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF1BF82AC1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ad241baf856so20452266b.0
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746876347; x=1747481147; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/Pjzx6WQoETC/3ThRaAMy71lchjX9sTbhTtcGykc9UU=;
 b=SWVLntLfZlnMknDMFmXEaFQgiBoKHo8ElrPkEj67TiMv8M+acJVVxoP2uHrUAT/FFE
 DMHkbVinrAHpTZqtrmX/PrVXzSBbbYuj4dJLkseWFAnBTLnJPM2tGL21b5YvR49t9M4Z
 hVvzV0kz/wLa5cxNxkJZG/dHS/VS9sG+mU1HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746876347; x=1747481147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Pjzx6WQoETC/3ThRaAMy71lchjX9sTbhTtcGykc9UU=;
 b=vp+aVnTaGEX3jONpUOW437SFMlb8Ty3AmxmkHjOsT4eCH9GQBps6K1W2/GqCwQ9QHB
 LfDVDDxXaVa9voZlfjwRlCim3xZw3aEGJKacCWaa1InW5HlOtGWEEJa7yVtAg+SrQkGV
 5gK5Yi1yUaaamjovd7qHkOu0sUEloGggMKeVtTViPzIO86eOk49Mt/98Fel/RtBP+I4D
 yWakWLFewZN5PpbHNWYc7bp1BpvWxSaROUB35zqEqDI/F3IwgyrFVJ59QeuVjTm48mHh
 aKDkirUc8snCUJf1s29IH1onEHCCRJ7Em+AzgtLYOpRcXtTFTWimwmgtVrhJiLa+UcbP
 QUNw==
X-Gm-Message-State: AOJu0YwYVzCSCvEcNEDYErZpJTKzrFBSP1efFoDpaHPDIiRuIFKEgT+F
 RLIRlKcSSOxj+e73LXJpV/3tRNINch2pBT9ovuijixzsrKP+0+Q1IfxUDeOvh5UYy2hCpdMYvEQ
 6u9qlZma/hskQB44vWybe/iNqy9/H7ORDtRVHC5wOeTeAhGD5Xq0busHReA==
X-Gm-Gg: ASbGncufXFHVOf2uAnosgcikkg0JtPSv3f5RNiY/k53z8vUVEf6WEdvu/C9Fj7fVXBA
 yaTYZLtJcy82DYiNDMlBzxjod6ivoViwHb4wm2Sk7kppjfOLMCmRY4PweU27UWf78GELG2lY8Pt
 53jNC3gos/3U5F0At4Fbt2WFRNf38utibLhQ==
X-Google-Smtp-Source: AGHT+IFLTJq49pknHhvCmBIkDWp1KyXHBDpKojoEb4xii1juzvh4Oc7a98IqK2szbj9cBhueAsdySsAXzZih0pNPwks=
X-Received: by 2002:a17:907:3dab:b0:ace:d50f:8ee3 with SMTP id
 a640c23a62f3a-ad1fcc9885fmr951564366b.19.1746876347187; Sat, 10 May 2025
 04:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250225205003.2640910-1-trini@konsulko.com>
 <20250507221112.518041-1-trini@konsulko.com>
 <20250507221112.518041-5-trini@konsulko.com>
In-Reply-To: <20250507221112.518041-5-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 10 May 2025 13:25:30 +0200
X-Gm-Features: AX0GCFsZXLIev-WnM1yFeIElM4QMC4mAAsK6mMK86-TZz5PgcITmNVhwAIXb-Wc
Message-ID: <CAFLszTjJQYW6YHSxPxgRFRm9TdSm3na393nKjXdcoAaTWb+nbQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] test: test_net_boot: Add more comments
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 8 May 2025 at 00:11, Tom Rini <trini@konsulko.com> wrote:
>
> Some of the functions were missing pydoc comments. Add them so they will
> be included in the documentation.
>
> Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  test/py/tests/test_net_boot.py | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3F8E77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CD5B8022F;
	Tue, 17 Dec 2024 20:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b6loAnGD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BB6E801FB; Tue, 17 Dec 2024 20:47:15 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF3E180304
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa5f1909d6fso955030966b.3
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464832; x=1735069632; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r7RvaQGwY8CdG6c+rcSmmAhpsO2qWK4+bxPncq7ojms=;
 b=b6loAnGD1XZ5N9t+TwUkAJnFAfLtXzr+uusbramb0o34gvAuhHp+INZR+DmQgAOxjG
 G8p8kFcNjvsZ8lw41L4acgGGH1uYeHYI/SIPYunJm2LjIM5yo1QF/zxkrEnOG8KnAAtE
 7rtjKcyrUTGuVKGER3U+n/Ve0sZ2hh9ehv860=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464832; x=1735069632;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r7RvaQGwY8CdG6c+rcSmmAhpsO2qWK4+bxPncq7ojms=;
 b=A9s/bjUc+hfTzOEn7XGwqCRzZACObFxiUbp437Ct81CjdeFUJOLqk0FqGrQWXJ135h
 XuQF6hQPR4thE40lvARmZN6DzDk2GSKhylLQkFP3SK9KSjapNBGV0EWqHy1ijKzaFTVr
 e4Nk9OVEOIDmm8OTaavfV7n9ytLKXcoxlIpW+fgG/tcJr7NbH814qIymwLPYNcI2DpKk
 b5o0uu9wVHj8U9zbYXPBS9HwGYefnT0HDrD0qSyOCcRoUITe9ZxUTRe6HNS2NYkImhB6
 tY8HN664FhBrY5d1v2ZhTHa8FieyXBUhnM/KHLgIkgcsYRTvmvAaMqnYjqmzPlidGo2j
 ABFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXccxpmlvjAzy+tCrqUQhLl5LkBfaOjsAr6jRLnSlLHcr7vy2sWJDKZB90OCXXOiWa8vb6VVHs=@lists.denx.de
X-Gm-Message-State: AOJu0YyaVw+jzXpYEq/YanTXwkJynOrUUEL0sJkw1sLNDXgBxTqbW4+p
 OqQ4zSe04VIuLTIafrUetk78AMB6Kzkf6+DJWg02mh8cTlbO+n6lLm6ICYV17hnyZZ8wT6E61jS
 QEkxtuP0uOy98iJXSCsqorTF41Zl4/1lmPrK7
X-Gm-Gg: ASbGncugC/sz1nfE5MAc8CgJVPtJw3XVJ84OGnDCElHBMSazQZAyinCqeSAm/hlO4Aa
 PBCW9IfQFEpR3FOquSW9Ix1ac0NcWJtZGcu99hJY=
X-Google-Smtp-Source: AGHT+IEmwhe/6qc62R1olq66gHWwVkRCNTkaofpgLXPtDlpWAN7ksF9BtNAqGIZDQCdK+RYb+yyiT9d/fzZRfJJYroE=
X-Received: by 2002:a17:907:9705:b0:aab:a1a8:92bb with SMTP id
 a640c23a62f3a-aabf47121d3mr246966b.9.1734464832204; Tue, 17 Dec 2024 11:47:12
 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 13:47:10 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241211135418.563803-21-sjg@chromium.org>
References: <20241211135418.563803-21-sjg@chromium.org>
 <20241211135418.563803-1-sjg@chromium.org>
Date: Tue, 17 Dec 2024 13:47:10 -0600
X-Google-Sender-Auth: N8dlmIAzuLazf9wwEYlCRcXPVUo
Message-ID: <CAFLszTgB=_kdoYYa5tNSYTcN=Fh=D6+3d4GSzVs5xwigPH3HEg@mail.gmail.com>
Subject: Re: [PATCH v5 20/23] efi_loader: Correct address-usage in copy_fdt()
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Update this function to work correctly with sandbox

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Applied to sjg/master, thanks!

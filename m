Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3C0CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 769348460C;
	Mon, 11 May 2026 15:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="accyIGr7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92CE880398; Mon, 11 May 2026 15:30:21 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA2198460E
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bce386d5b85so204018166b.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:30:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778506218; cv=none;
 d=google.com; s=arc-20240605;
 b=EdGLPFRQvRTW4G+nktlthMfm4LDZjwTt5qPN3ofxwT36VJ9oGAFeiRqbvhf8Tn9k/N
 JmtSwx4FOsaqUudH4IOvZ4TOutRzhwi2+4ybA5+T/MIkJIPiafxOFTtMgYGA+eo1W89m
 RVxuTRrVUpW/4dFE+lWQ5WKWywe9WpL7BcTW7sYe4mS91SYw0O953TzYpiJBH9MXef7V
 57E7BWxCigxwyKnYVKB7BhLCVFykQw7CsPJsgAbhH2AghNhpDmvpLHcYMY31G80ExP5v
 V/cKNtdXRxFstewJPCF258sw0zpLMHrTOnyuFRUD+v6a1Mlr4O79Kv/QqlJz0BKfgZH+
 kojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=f8prlA/g4t0zB8R9xVqm7YfyOS5W34jKne4/iFliwLc=;
 fh=9mt7BL9T0ZGZOph0lp4xJiGBzgOSSvgEz5hYv+pLznE=;
 b=aPMNImTfDrQHfEsvyHNDW9MzIosqUlZWKNIWpoaDbd1hJ6mRalij+RMl3HnEC4dxYT
 ENQz2SekT+gWHb3mRXxIb+fw5DQxyPDOI+KW97Jag0JG3R2UwGo1i7butmpQyD+AGqdo
 zR8ukE5+jSWkUNUVooOwXUOt6AxMf/TsBDDUjAAYxt9JvXSKfYqmKccfTnZZ6hN3AvAC
 JbYcwKDJYbAwHKTDtERof5CnDK/r9hYhShN87wPv4STVBp2VEvyZEvhqfZQFmgAYs5ia
 8CaKYLqZw0nM2U93RB9gFgcJzbYc/6V1po0ofDS6BpFxHj6WiqfO/TvESi4mRuHOX2m+
 WbUQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778506218; x=1779111018; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f8prlA/g4t0zB8R9xVqm7YfyOS5W34jKne4/iFliwLc=;
 b=accyIGr79ob8623vw36G295ioCtILpST2s9AMS+cvE+A4WeSNiiYWlfUlXE8+G4PxC
 Is3y8N1kNDOHGk51nK6Sv6PAWVjzXlzzwr/OgwNF2d30cvlimThVbPnFP3klVrzYs1ro
 7ySOuWwSsLjLU5L1OxTHxVYfs7nvWRQdcBoIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506218; x=1779111018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f8prlA/g4t0zB8R9xVqm7YfyOS5W34jKne4/iFliwLc=;
 b=V318Y6vL8Iz4PWTPhQYNU0DBqgDlauOV9IiFWNmXydvZDHTML2j0iwS1ZOsAJFZV/r
 TYf3gCR9UpRJKbnRGO91o5f8Oa/J4PcfeS9otybgPo3zAllC3JfTjwIdLCbAShliSEMy
 DWp7Yso27twzZazZifW5dcQxy7jzxQDK0QsEJOq0MF8NW6pF7w9kew3nDKxaG1t1iInd
 WNXx05G6Xy0CGAHh6v7SbfoYE3Hq4Gs3Q8vZqim7f64BE0MFmCuxVCN5HJNsHtlnTeDq
 Nf9NKl0lc7JIFn0r7jySLD+rPtBhYlcIEbDINLCSCDteRJzkThXNsz5HnOucBdluy0TA
 4ABw==
X-Gm-Message-State: AOJu0YzKgcyCg7LsTM8RDQomq9HN2Cv4quIu1JuCVmmPyt+aT/HklQ4b
 LY2MCzkXIjdlCSEw4TRm9f0iWJtnTpPbse0ykYUbwTXf6zwr6VV6LbNSLYpaFbHxr65A/FImSDq
 /UdgN3fj/G8kc58f4Qqb9j/AK9jv6/IxfpRptGgcl
X-Gm-Gg: Acq92OHjqXkCupMyjehIIBK/+Kz4iL/Hit7TSHtqw3Wv9hXMQI8SS3jMEGSK77DNBjU
 f66YX94fzhfjQ5MwHLp34isH0/vfvrA8WccCpluYaVkdLg9+Sj3FZP9Wwh04As+kxa3GMdrkn44
 LJqWc34/Q54MsU5q/Am4+E6aDT5Q8vxZTVdZP8UOcgobt1Y9ofbOR8Ah46GBjofNDyzSONHTEL2
 QNSV2uUO6Pon6w4Lx6r8GzqnzkeAztmWdDQ0cMD6mIHpdAnffk9jNknOtQaswb6wAisdLk4vKX3
 +q+qSQ==
X-Received: by 2002:a17:907:806:b0:b9d:6d06:b78a with SMTP id
 a640c23a62f3a-bc56b835456mr1381692066b.17.1778506217847; Mon, 11 May 2026
 06:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260508213217.3807786-1-aristo.chen@canonical.com>
 <20260508213217.3807786-4-aristo.chen@canonical.com>
In-Reply-To: <20260508213217.3807786-4-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:30:04 -0600
X-Gm-Features: AVHnY4LFvLJYyVxA0F7yIFvbjxfUpYQb0Q6Xhst2MeDb-Z7SywMSUNDoO4H7r2I
Message-ID: <CAFLszTgC+dnTwCjzPg-Gt3J+SAP1ttZxCm3kHewrh9ZjKON99w@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] boot/fit: use fdt_for_each_subnode() in image-fit.c
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Lechner <dlechner@baylibre.com>
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

On 2026-05-08T21:31:58, Aristo Chen <aristo.chen@canonical.com> wrote:
> boot/fit: use fdt_for_each_subnode() in image-fit.c
>
> Replace the verbose fdt_next_node() + ndepth pattern with the
> fdt_for_each_subnode() macro at all seven sites in boot/image-fit.c
> where the loop only ever processes direct children. The macro is
> already defined in <linux/libfdt.h> and used in boot/image-fit-sig.c,
> so this brings image-fit.c in line with the rest of the FIT code.
>
> The conversions are equivalence-preserving:
>
>   - fit_get_subimage_count(): the depth-1 filter and the macro are
>     both restricted to direct children.
>   - fit_conf_print(): the parameter is named noffset, so the loop
>     now uses sub_noffset to keep the parent reference stable.
>   - fit_print_contents(): the count reset that lived inside the for
>     initialiser is moved out as an explicit assignment before each
>     loop, so the second loop still starts from zero.
>   - fit_image_print(): straightforward replacement.
>   - fit_all_image_verify(): same shape as the print loops, with the
>     count reset moved out as an explicit assignment before the loop.
>   - fit_conf_find_compat(): the body's "if (ndepth > 1) continue"
>     guard is redundant once the macro is in use, and is dropped.
>
> No behaviour changes outside of these mechanical reductions. Local
> ndepth declarations that are no longer referenced are removed.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> boot/image-fit.c | 107 ++++++++++++++-----------------------------------------
>  1 file changed, 27 insertions(+), 80 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B94C282D6
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FEF0810ED;
	Tue,  4 Mar 2025 16:37:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YI9LG2Bk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D250380F56; Tue,  4 Mar 2025 16:37:00 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E43E6810ED
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ab7430e27b2so946576166b.3
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741102618; x=1741707418; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=85VJHjgFLtQXwFlfpo53YL3ieaa5HUjv1+UZQAtRNqA=;
 b=YI9LG2BkT9vNBHu/YHPul/KGGSpsq8RqyTro7OUhciamAhI14hhMYVsSIqqQ5yPoT9
 Z8JVrS4w3FELsflpqZ3MnPwMy3B6nkJVLRGvouJoKrT8aPRh105ewrHCgHmIsVac2OX3
 V8/K47Nja9oBEDnCWikSn88XQUCZDNLkqQvqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102618; x=1741707418;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=85VJHjgFLtQXwFlfpo53YL3ieaa5HUjv1+UZQAtRNqA=;
 b=avJ4RmsFl+Xx8gtWP5jnmpo5VeeTpfzXWVxv2DQ5CG5eJtSVXcHSUATJxFfHAIwxOC
 IgY2tbY/94FQIW8wcNPL24BsXhqnO6mys4+4px95R+7XY1NQhdXDXHV9BZ1PhtW4K4Wt
 uTSBDDl2LlejjH1ddDnoL25dv4EqbKUk1K1Xd8MmK2ufHwTuhAfQW44Q7IWZZHVxbpNI
 zQAJJskidiuGGqRE7h5GdMC26oWaNh0LXddj5XNRvAW6hxXgkWAGAAed1NXOwLWcQST8
 ZsEs8Tx8YaWAN8hyldR7xVAM8OqFXuXh7K7t3ZQJ5Eq8ChmAgPheVfqWdv/hCTkyCkxd
 2ALA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrtTDQdHdbJxbou1x7i3adkYxgjfDnFjiC+QNDz8scSo4hfv12q8TTMVYWZ7UwgTFKPoyk030=@lists.denx.de
X-Gm-Message-State: AOJu0YwPclkOmNZuffbXzIkMBBK143zkN2/R4SQmkB1gJU2SmpydKvaz
 abqmEHKJ+paEw36VCUgzwufIbBu++h/RSGFvLeNAT46mY3GvXaYj85ejHY3D3eNuzTr/zVy73gQ
 fdad5DCtZj8N/mr1Gin5o6QhBUowKEnbHBkF9
X-Gm-Gg: ASbGncvATKpJXZZxVyT6nF+7zs3RtKkgkkspqYutwdDbN/O6G4bGxf8Uwpbwr3CdmA1
 i1II32SN1Q5m/FbVEHHoYbb3SzjP1h+m6Z1SVMQq7HaysCcPCSz6T6/Zsijn3e/uDEveDPFEajN
 C9W0kdjvMxnA3T/eQyjy0zWbpg8NU=
X-Google-Smtp-Source: AGHT+IFdvjjpSK7sDttx+kRo9W9cjsqmIAs3zjBmo/uCb0iY54XlaDqFn1RRswPh6SD8OHg9vUc8FcHqtXYvTaCY4lA=
X-Received: by 2002:a17:907:3f18:b0:ac1:d97e:3e4d with SMTP id
 a640c23a62f3a-ac1d97e4894mr724500966b.33.1741102618384; Tue, 04 Mar 2025
 07:36:58 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Mar 2025 07:36:57 -0800
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Mar 2025 07:36:57 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241018030027.842749-8-sjg@chromium.org>
References: <20241018030027.842749-8-sjg@chromium.org>
 <20241018030027.842749-1-sjg@chromium.org>
Date: Tue, 4 Mar 2025 07:36:57 -0800
X-Google-Sender-Auth: AZSohzs9cN7l48Y_5KfHF03HmtE
X-Gm-Features: AQ5f1Jrg3ey9VlYFSxP2IIjg96Oe7fx0Oi9rhtb44MhyRlaJA9HZo7lqIJ0hKYk
Message-ID: <CAFLszTitDAwdFaxWKYe7savtgoT=aCpu_AoXFPS3RNHAmGFbkg@mail.gmail.com>
Subject: Re: [PATCH 7/8] membuf: Minor code-style improvements
To: Simon Glass <sjg@chromium.org>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Ion Agorria <ion@agorria.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Show the start in end in the comment. Comment a missing variable in
membuf_readline() and fix its line length.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/membuf.h | 6 ++++--
 lib/membuf.c     | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

Applied to sjg/master, thanks!

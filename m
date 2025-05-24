Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88509C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:09:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5C5583689;
	Sat, 24 May 2025 07:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JXxsjC9X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 315C083666; Sat, 24 May 2025 07:06:34 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 085C4834BC
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-603fdd728ccso93903a12.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063191; x=1748667991; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qo3z8osGXdiqFjyWAiZQwi6I1/kSYYe/vpf60wdLCcc=;
 b=JXxsjC9XB9BV95iBJMd6GPpjqImw87hsaE0kVgR5yPettzdhGESyr2VDoCHPihMZ9s
 t7mxjm6GyQunbgNz8CVavN0IViZdtOpYoF+0oLvmQhazkm3ZMtKszYURiQdYfEnbzAU+
 P4TipUuD0d2j7A62ggy7skE1LTGp5PXWM+njw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063191; x=1748667991;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qo3z8osGXdiqFjyWAiZQwi6I1/kSYYe/vpf60wdLCcc=;
 b=LDQM4DY2DuqUU6T3EOpediG/PKWQdQssyBJC8dkU9RB9/700hLLCRThKmAzdwrAxL2
 U50l7PzWN8YRfnzaDDlzFuZwkvz1d7yzc/Dxymb9ft5W7Xj3DDnGjbFDwCaUtv2L2G/D
 BBsPtqcaRS6I9jb/I4P41hqszWxx3IthkjSvuzhWUdwgPJFqe2ctp0en6Ld0KKst/lEH
 6ywL8HMcN4OoCAE21cd9WMl5eEcMsFaA5ksr1c8GIsHXXI03qLs/0qyWFGGiKE5g7iO0
 4kMgREKn03LPFna+/rZ0ZJN1K/8NJEybzVo5V9eqiwQuNAvjFX3JdHFOMzHlgH+CLJ8J
 D1tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr4KaVnOtxbqCLU3nPNy4iBsliKIzsjSKZwoMQZ7kj7q8SnYS0yXhc7MbSnUy9M0vBvh5y2j0=@lists.denx.de
X-Gm-Message-State: AOJu0YwAXXnFdjsjXES8nNu6cF0J6bD+anYHkU6kdFpB8rHlN45bVeJB
 SIVjkxW7ItxAsy4UVlZlrtae1ahJSHV55wfyphCMg52AotRqwXKN+ORIgPv/GJ4L0bIzd8KTY6d
 683xdlG+kv4eoTERUuJRAO4dtVIQjSBAYPv/zkS5SPk4lwrnwKI/5k3u9
X-Gm-Gg: ASbGnctTh/3/x5HY/WJoiuByqDfUirvrMBZo4WiKBk7K0+nvD270h5gGpM6q/wlBiKT
 c+//iHZggqcuGg/PP4rdlVRJftIrMwvni5KEbe6v67oo09TXLX1IXa/uBVSN0Mwe9D3IkDpiHUs
 Stsgv5T/GB/RS5RGw8VXK5C9P7/Vy2W5I=
X-Google-Smtp-Source: AGHT+IELaqkTpfglLtrutEj32pxCgvFQRIxvxPWpsd4hKRm8QyBdz/YAEpW6iYwZFlZjcCLUqJapK9R4ly56lkENvPU=
X-Received: by 2002:a17:907:3faa:b0:ad5:1db5:6ec0 with SMTP id
 a640c23a62f3a-ad85b1844e2mr137002966b.20.1748063191492; Fri, 23 May 2025
 22:06:31 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:30 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:30 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-6-sjg@chromium.org>
References: <20250510110535.1453745-6-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Sat, 24 May 2025 00:06:30 -0500
X-Google-Sender-Auth: gSUL4w3MU_rxja3_QfptjHvJ8kc
X-Gm-Features: AX0GCFvAU3eYH2pbPFhSR4tU-h20OmLfheGHrBEpvinlvbHtcOqfm5aa8uHuNQc
Message-ID: <CAFLszTgb5QHOgU8U1FHYvBOsEZj4zUo=WC+bErWP+wSm8KUX5A@mail.gmail.com>
Subject: Re: [PATCH 05/25] patman: Add a test for collecting a PATCH prefix
To: Simon Glass <sjg@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
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

Add one more test for completeness, since this occurs commonly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py | 8 ++++++++
 1 file changed, 8 insertions(+)

Applied to sjg/master, thanks!

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91240D1266B
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 20:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 230EE83F2B;
	Tue,  2 Dec 2025 21:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NoyLrS2b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A25083F2D; Tue,  2 Dec 2025 21:07:13 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36AD783EE4
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 21:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-64088c6b309so10423610a12.0
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 12:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1764706031; x=1765310831; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vTrd/ji8g8SUw2KCNAPUzT9T6a7MoTCejwhcv5A1bSI=;
 b=NoyLrS2bnqG0frw2d+OIFK+gGLLcJeSr2V2n/UOe+s87P421W/sSYXr+9pp3d5mlTC
 ouv0gc9NV12GS6LWXQ60mEucJF39gbDFS/jyyoOF2MqqvOhG+/RZXrYTUS/7cKSWe/Jm
 MzmyAMQk8eX8M6/g77D6dexTPMmzjd1lE01EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764706031; x=1765310831;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vTrd/ji8g8SUw2KCNAPUzT9T6a7MoTCejwhcv5A1bSI=;
 b=pnAOGKUi+ZOZnC6yWqePzLcuj0IxsW9A1FbpcBFRrIizuvDXLoQgnn9Cv1snfOayyC
 6ecCv+I/IXzlEDErotZ5D/XmasQ3NLcrt1Lnzbz48CyO0hedy8RT7Lx0N2b4pZ7nzTom
 otdOmT2L6R7Je9Wb+5A73hp6P3RbIHc0cQnqwtbK7qMgh3vHuUbFJvOq8FEQjQmE07dy
 kc1TbOsTa0I0l311PgJqCUVq6wOIYaIfSP0vRhj0H61tfMrpQ2UxGBRqMQaGp1kaV4+u
 8hS1pg8988NC1ShtDZ6+GMq9n2/uadglAepOwPqP29Lkc5oWERQRjtnPrfGqNPJt8uFx
 Mtng==
X-Gm-Message-State: AOJu0Yw/hB3U1og88cAYbo0M+0xrO08oo5AyT7Ia81Ry9+irvMiDhCpd
 bIHLqDnyimod0qDgGDa4QTVBgB5f2A75Fxhyhvm7c/bje15iVuq2mMj6Oc+PHaBO3d3o2ys49Fp
 GAafDrPF9tWxu+iUFASVLHf0Fb1QQrQlKYNYR21G7JXrDbUJ8ZmFZyQ==
X-Gm-Gg: ASbGncvl0JNqLXG6H7FgMa0k24S9UNm2j4yfcZTbg38A5mAJeCZm+xifeKnxF0E4JJg
 VyWicUZzGLEEXnG9PdHUwplUgra3EIiREpMRmmCAzU2+w1LuHJDdzfI0h2qC2aKeJXrJ6tepYtn
 61eZ5IHp9/gIbUl5UhSghS8C5NXAmV07Ho96Za21+MkmrT6CpAz9sdVvEtupn4XV3d+Y6VNs6XL
 lOHaCPwwgCU96RBjTxHOFT7gHdvFVSQmc/Ul5lcvJlcg0dSPXwu4P1XX+0PVYAtvyMt+mWXBg==
X-Google-Smtp-Source: AGHT+IEiPC572MG5rowCAFr4KLOe2wkuZIFJktGsPEBs6ePNgTNBXK9fB4WfYozoCpboR6g8tYETkmDQxqyloCXi8Do=
X-Received: by 2002:a17:907:7f15:b0:b76:2f40:a307 with SMTP id
 a640c23a62f3a-b79d121e748mr41003066b.57.1764706030669; Tue, 02 Dec 2025
 12:07:10 -0800 (PST)
MIME-Version: 1.0
References: <20251202162250.2613085-1-trini@konsulko.com>
In-Reply-To: <20251202162250.2613085-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 2 Dec 2025 20:07:00 +0000
X-Gm-Features: AWmQ_bm6ij5-qNQJN5mnOhYwfZY0dkHzbwT9kiGXqrQm3CQKq7TdZkvFFW2brZc
Message-ID: <CAFLszTif9LL9Grq2U_KnyHt9o-iBTwPTZuepkvD-_UyfOpBkFA@mail.gmail.com>
Subject: Re: [PATCHv2] boot/image-fit.c: Resort to using malloc for USE_HOSTCC
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Hi Tom,

On Tue, 2 Dec 2025 at 16:22, Tom Rini <trini@konsulko.com> wrote:
>
> With the changes in commit 8fbcc0e0e839 ("boot: Assure FDT is always at
> 8-byte aligned address") to call memalign(...) we now always call
> memalign(...) rather than malloc(...) when allocating a buffer that may
> contain a device tree. However, memalign(...) is not portable among all
> of the host OSes we support. Specifically on macOS it isn't seemingly
> possible to get memalign exactly. To keep alignment we would need to
> rework to use posix_memalign(...) for USE_HOSTCC and memalign(...) for
> U-Boot itself. This would get rather tricky. However, given the limited
> use case in question, it makes more sense to fall back to malloc(...)
> for the USE_HOSTCC case.
>
> Fixes: 8fbcc0e0e839 ("boot: Assure FDT is always at 8-byte aligned address")
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> My biggest take-away from this is that I need to move up the plans I had
> about asking if anyone even uses the host tools on Windows / macOS from
> post-v2026.01 to instead be later today.
>
> This change is a work-around at best. Ideally, we can drop Windows /
> macOS host build support and revert this commit at that time.
>
> Changes in v2:
> - Rework things entirely, and elaborate on the commit message.
> ---
>  boot/image-fit.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>

That patch was not a great solution. There is no indication in the
commit message that it is doing an allocation:

commit 8fbcc0e0e839a8e25f636c76e59311033d3817b5
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>
Date:   Thu Nov 13 12:54:51 2025 +0100

    boot: Assure FDT is always at 8-byte aligned address

    The fitImage may contain FDT at 4-byte aligned address, because alignment
    of DT tags is 4 bytes. However, libfdt and also Linux expects DT to be at
    8-byte aligned address. Make sure that the DTs embedded in fitImages are
    always used from 8-byte aligned addresses. In case the DT is decompressed,
    make sure the target buffer is 8-byte aligned. In case the DT is only
    loaded, make sure the target buffer is 8-byte aligned too.

    Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Regards,
Simon

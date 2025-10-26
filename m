Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467ACCCD1A5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 14:27:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3A4583623;
	Sun, 26 Oct 2025 15:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OXMI2GX5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ABCB836D1; Sun, 26 Oct 2025 15:27:19 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AEF382E34
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 15:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b6d4e44c54aso665254766b.2
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 07:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1761488837; x=1762093637; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g4R0v++ClCWfulUsKiMDcX3bR/iNd05TYb4SnN9OoNU=;
 b=OXMI2GX541Jgg5p538miPrIjXAkISwAcDHkQ3+9jQwfhll4+Y7dHik1hWaCDyOc4ou
 T813Vd7Kgm6xU+K4VtJG1AC3ZmG5NutcfjcWpNOKXimbFJcAqIHHftkVplJybDrfJ6Fa
 W8PM1d6un4ePDVW6yad09l8KbXKtRRHQcajC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761488837; x=1762093637;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g4R0v++ClCWfulUsKiMDcX3bR/iNd05TYb4SnN9OoNU=;
 b=EGXGGMBuh5wkLB2MxEryCH7GM0sA64kshm6zJSwqsTIW7MA4l7nUoiXtx37YJkxtj1
 yxTMSXUg7EH+r7KcaEfpUhaydAg4kXdvqNobPQNKQeD56Xpr5kHYVf/UJGbSL9knsEgY
 83VRPGnX+a0c0ynxd633yHVO2x4C6yS3f6ou6O9sz2GV2W6KhfW1E2OcxiJwpX52VFmS
 PaHDjFKAlYDKyA1figtiEtDmAioUkmS5ErGCHxUdbXpC4dAzeUcoTLTEUpPC0KUXV30K
 5mt3uZdgFyaRST2UtOtqcV3ST2K72GmVxh3o2kZmtp2s+kgBTV3nHd5U/Vn8TtDs7Yg0
 bEhg==
X-Gm-Message-State: AOJu0YylZbj4p3WLXfWq72MWUTvVaiIBubgB64BLyBiuN8qyHMyBfnb3
 tx5GZA06WAeo5gHbXoGj7v7nVuFciBtpm2vfMKZCJy6Fs615zYqHwh2IB5Wer2CEtVE/BGpU63X
 yNriLfDgmE0arprigt8fVDJfe0CoQgjc5AcKALlaP
X-Gm-Gg: ASbGncvUgMmx0tZLG4WQfVgsGEou1KbQDjhVGJdClctUSOScXylKfiTdANBUGk1rESP
 axDgCMejYNjwabcYpy50xIb7NG4M4TiYee9+i/Y0WA3e2ouIihBtfnawouy8LP9Wc+Z51mIwLMK
 0xKC3tPyAe9ZcUBI97YxF162lnbUEdgzIyx8dQzSUz1UnL7+3VdKmCBPdxmEfj2AGDQbjn9978r
 YAOAa8DMMj1l7mxpcnlT4XjrQVieTM/48P0ddCNgbJh/FwyPMSinWGZXzucOvxVb4/0k1E=
X-Google-Smtp-Source: AGHT+IEeLpsFZ996Qj40T6KAs6oues+U+TtZBwb5hVJRooHVKQIn62wEbpljzvMypXFheZYgdJoLir3gnffwLwRqZig=
X-Received: by 2002:a17:907:da2:b0:b6d:7573:ccf2 with SMTP id
 a640c23a62f3a-b6d7573ceffmr730927366b.62.1761488836966; Sun, 26 Oct 2025
 07:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20251024151219.100970-1-wolfgang.wallner@br-automation.com>
 <20251024151219.100970-3-wolfgang.wallner@br-automation.com>
In-Reply-To: <20251024151219.100970-3-wolfgang.wallner@br-automation.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 26 Oct 2025 14:26:59 +0000
X-Gm-Features: AWmQ_blkc9dAGBzS3cv__yxmAPPrXO6AiaCfZ1D7kaU64gV-QBr4SeplcktEKew
Message-ID: <CAFLszTjTpqPVXOhbjL7wur=nLw6t6NzY8YLs+rRB+NUEEHqWqw@mail.gmail.com>
Subject: Re: [PATCH 2/9] doc: develop: Change formatting to make binman doc
 more readable
To: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Cc: u-boot@lists.denx.de, 
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 Lothar Rubusch <l.rubusch@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yannic Moog <y.moog@phytec.de>
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

On Fri, 24 Oct 2025 at 16:12, Wolfgang Wallner
<wolfgang.wallner@br-automation.com> wrote:
>
> Change the formatting of binman.rst so that the compiled HTML output
> becomes more readable. Changes include enumerations and the escaping of
> arguments starting with a double dash (e.g. --debug).
>
> Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
> ---
>
>  tools/binman/binman.rst | 39 ++++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 17 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

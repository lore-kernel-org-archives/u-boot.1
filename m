Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC8FD2CE12
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 18:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42F9988F2A;
	Tue, 22 Oct 2024 20:13:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XIcV6MV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25C3988F4B; Tue, 22 Oct 2024 20:13:06 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45EBA88D94
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 20:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9a0c40849cso919396166b.3
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 11:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729620784; x=1730225584; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=34GlaykIB53h8+pAiU4oYz/Tz0THy7V8RXpk+24uwvY=;
 b=XIcV6MV4r3nI5L8TzIyZg7fjJPIesJwmmrsaFR8vMjoaldD2Thwiv2MT4YTEyrWI25
 PAvLXDpjOmseIDw5LvMHIrSyLe9+/YNuiblAf+f9Pt7yA6n7kz+8eMtSwkxmwlrCVMrk
 7iUsiphhk4WCgsxt9f0b/lyF8hlWQJ0UZy+xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729620784; x=1730225584;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=34GlaykIB53h8+pAiU4oYz/Tz0THy7V8RXpk+24uwvY=;
 b=EEhlvtS8AMBb+h7qF1B82HUjP5wN/00L+HVi4XwzfbB616uK0aLLDAm5kwfR4cNYee
 4ICpNWK4VPri+Dj6hIUXyJC0PZfzfGKlN3UgZXE5X2w8qdDs73yIQuxz83ZuY8oA2RDx
 tbVkuwVpYXj91pUTQwmsO1JtzoSFBUHD8Qdlu/wq6G2vsjYKMba361iScA4Dv3nJ1t3e
 y66oxmPzfLqDVm33ox+dtrIWkDwC/L96E/eQUK60RpVfBRxxfqKXX0zpgxMnOkCBb01O
 og4Zf5/D0PPo6b1bySJ5hXT9NsMjmV2yJMMtl/PDC3qpcZdKoRdc7XhuOP9LJlN6WGaA
 7Qfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2RKYXnhwuB6IddCHBRbe70leI6q+xIj00kmUnhkDscFjxpjHiy+ID+Rd4vabaCW90oRhaGAQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyuNxafgVzvE6HhWOeAZ6Fc9vKSt0zVYTondZZxbSFUdaKLzEaf
 nHHK1UNApld3QTCg5ln9Fsg40b5azAivdrf2/2yEJIBaKNCXMvBGD3FCRY7UAoIC4sVAdTOHAL1
 H2b4I8v9LX76ParCjOMaJW4le5DHES0jSBNsY
X-Google-Smtp-Source: AGHT+IFyPgiK/RNQ+m+l3DrcakqlgVu5pvfLzRgjHLQUpbYWl3qop1TK6CZYP1EjAhBQI1pghAPUiH0t07Z8DHmRGb4=
X-Received: by 2002:a17:906:6a04:b0:a9a:1585:dd6a with SMTP id
 a640c23a62f3a-a9aa892dc0cmr439746766b.36.1729620783738; Tue, 22 Oct 2024
 11:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20241021180831.19120-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241021180831.19120-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Oct 2024 20:12:51 +0200
Message-ID: <CAFLszTjFzGX_NB-GsdBew6JdUDJ4odvXKnTVnrTssVSQv38gvQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: update Python requirements
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Mon, 21 Oct 2024 at 20:08, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Update Sphinx, sphinx-rtd-theme, and their dependencies.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/sphinx/requirements.txt | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

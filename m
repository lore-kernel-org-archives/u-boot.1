Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BD7C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:15:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEE4088804;
	Sat, 13 Jul 2024 17:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bXceaOcC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E0C187E13; Sat, 13 Jul 2024 17:14:08 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C7F488804
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-77d3f00778cso2204262a12.3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883644; x=1721488444; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O4PxtvIoTZtDI9yeK9ibek/zpG81uhP/1bz02Jo/GT0=;
 b=bXceaOcCGshOdg2W2TWjsDZBENyPabonBUphbS+oUeD/Xz0Fta7JPpwgPWD3Wa1u98
 pOJwgBq/b3v833y3yiq2fe35AtlLmJu9mbNg2O74ZnT8G+v2Xgf+LsRG2T7vb7rc8/wk
 xu9JoqsoxRpQsScQTE+E/gh+MfeONRBUxN13c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883644; x=1721488444;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O4PxtvIoTZtDI9yeK9ibek/zpG81uhP/1bz02Jo/GT0=;
 b=I9ysKpyhDiSDZakM9My2iu3kX8Src5QIylrxOnZJmFxi1Wym9Np8iXkTqQeRl4He9p
 mbMmsJtenR5L+/oEmiFecY/0fxvHCOh7xS7loUBF23G3H6fVqfRKI6XLRn+CExEx843Y
 ALhI6x9y2z4dDR7l87gW+isiwZ/Om/glI1/aVcHmDqZSzKvizhrCUNF7UgQb9vUIgjld
 3p3JJaMoqtpfPqRV/uf4LtamKwr6m/yN7pkhDm7d3yGQHP79fOBcNEd06qJmtdOUSGwW
 IW5aNqP9s0ojSP1ro4d5wMK7u3O4L5OQ8JqRFaJiRjtxkrlYr91EZyoJptVLdLuQCoxA
 oC7Q==
X-Gm-Message-State: AOJu0Yw332q2OYj9nzDhCY6RMRqbnio36PkScBcRgU+UMla1AvdLjXqy
 Yd6BzIAgRgOippWFf1EFps2sQtgAe+lCNIC9IEw4zWCNRxozUgBe5FpA7EZfKUDHRsCdcZq3SO6
 65Q/XRfucDBLkOrzFQIP8skxnq+RONkI22F92lc0BiFeDMuQ=
X-Google-Smtp-Source: AGHT+IHDGFXeF8rL0hYnZNy+sPS3kTKSjmf33pAk2rJFJbppxangnMp1uqXKcoukiczAlochgWmDMjuAbVjlz2gDPcI=
X-Received: by 2002:a05:6a20:6d96:b0:1bd:27b9:b63f with SMTP id
 adf61e73a8af0-1c29824d657mr12169421637.37.1720883644597; Sat, 13 Jul 2024
 08:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240708151813.2137042-1-trini@konsulko.com>
In-Reply-To: <20240708151813.2137042-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:13:47 +0100
Message-ID: <CAFLszTjBKR8Nd2TYi4XNC2aRKS6FuKVXUOsRjj4cXLkysJNePg@mail.gmail.com>
Subject: Re: [PATCH] doc/sphinx/requirements.txt: Bump certifi and urllib3
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Mon, 8 Jul 2024 at 16:18, Tom Rini <trini@konsulko.com> wrote:
>
> As reported by GitHub dependabot, both of these packages should be
> bumped to their latest versions to address security issues (neither of
> which has a CVE assigned).
>
> Reported-by: GitHub dependabot
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  doc/sphinx/requirements.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

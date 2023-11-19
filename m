Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D68AC54E76
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 00:47:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D9F387239;
	Sun, 19 Nov 2023 01:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k/1M5Eh6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5FF086F64; Sun, 19 Nov 2023 01:44:16 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B033874BB
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 01:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-da41acaea52so3073034276.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 16:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700354638; x=1700959438; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rgqPx229YKaUEKcu5yrNZPdN6fJSwe31uoefqS3hTkA=;
 b=k/1M5Eh6s68Gr7ogvX0exnQfFtYvDU7T3GKVsi+Q4GHyWlfQTbvS3pHNrRnh6VrN11
 iSF2s5GwusjfvftchKFbJPeIzu4lu5DxFM/mbucaS7Nb1B1K1Sd3IMszMDgMcCezv+A2
 DIW6g2/9c+fXwMl5r+dHKYdGcTB09ADciDmmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700354638; x=1700959438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rgqPx229YKaUEKcu5yrNZPdN6fJSwe31uoefqS3hTkA=;
 b=qPA94RlmMBlAp0gfgQ1K4OnLZHFZ/51BwILsYfW4CwYsV9QZXE71J9HD7tTWbh+p2V
 6k0f9jzcoh/7+aLwKlp/j41HazNzzlCv+tLCIizp5T4bpc7jdGHQ+A9GxZ6F8HaNeh6R
 EKNG2mgDU4Dw7rmyrSnT9NKrs+iF3Zz4ITZ0GJfwjo2jMJ87V30PZExrsP2JCAN0muEO
 FyavU+XoQ5G50D3+AywukiaHQb1OgMpDQI/g9psnc9ioVxyJ/aDQQktZ2WuDA7+dyRUq
 1ho81h3GUoDOLCKYHBr8YxvNa8WMwvud3zvsiJ3Bbkq2ngLIoOWX/j1+sOYcADA7+MWS
 erdg==
X-Gm-Message-State: AOJu0YwG4zndsvC8HXA3Lai/ZUNKVrcTe9h7HpPCwTujZr31Ai6+qE6+
 4HraHijqRL35nqYeGLkGi29Uw6J28ypQkJTJy6CPIw==
X-Google-Smtp-Source: AGHT+IESnu65unu7DCtmwhKFORnRB/h51TvAq0TgrLjFl7aBmk9+FiqR11laqCSCpkn7p3CYZHf87JIJ/9R43FGI07E=
X-Received: by 2002:a25:f821:0:b0:da0:caba:9017 with SMTP id
 u33-20020a25f821000000b00da0caba9017mr3436782ybd.16.1700354637908; Sat, 18
 Nov 2023 16:43:57 -0800 (PST)
MIME-Version: 1.0
References: <20231118220313.1271556-1-i@shantur.com>
 <20231118220634.1271886-1-i@shantur.com>
In-Reply-To: <20231118220634.1271886-1-i@shantur.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 17:43:07 -0700
Message-ID: <CAPnjgZ2LWRgFERh5bgeXNCAZjmc7CDC0shBSwcXcO8q15Y0DMg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] bootflow: bootmeth_efi: set bflow->fname from
 bootfile name
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, xypron.glpk@gmx.de
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

On Sat, 18 Nov 2023 at 15:07, Shantur Rathore <i@shantur.com> wrote:
>
> We need to set boot->fname before calling efi_set_bootdev
> otherwise this crashes as bflow->fname is null.
>
> Signed-off-by: Shantur Rathore <i@shantur.com>
> ---
>  boot/bootmeth_efi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

We definitely need to figure out a way to get this code. The boostd
tests don't go much into the bothmeths unfortunately


- Simon

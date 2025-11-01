Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328ACCCF9F0
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 09:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 278BC83A15;
	Sat,  1 Nov 2025 10:04:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E+nVKu0m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92B6C83A8A; Sat,  1 Nov 2025 10:04:17 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B10FC83A15
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 10:04:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b472842981fso426127166b.1
 for <u-boot@lists.denx.de>; Sat, 01 Nov 2025 02:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1761987855; x=1762592655; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eJn28cw2r1fhqNvrMgXxqlsf4jEVNvCLUtWT5vE0mfg=;
 b=E+nVKu0mKt1uAT5XbRuWhSL+ZCvfHOcPRHpOU7lMrlW6tdai3spQ8IG/iuCe9CzqNc
 dWn8JauaT7dbrbcnhvK0NSW2Oi7PKm0zPiLTymk0TgBstV1G8I58vdbsHzLsv27MPtRo
 urMVyPQsh+XAxiqF7awq84UrkOPyJEfuyKdFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761987855; x=1762592655;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eJn28cw2r1fhqNvrMgXxqlsf4jEVNvCLUtWT5vE0mfg=;
 b=GdlTB8eKrjDaOUI/P//IaLEBTuU8sZcn3teTkKn3VKF3A3eN9mrAgYUN6Sz3Z26Sie
 Lu0fCB+Zk0lqjeM5CkrQ//TwHvy77ZdlLF9coVDo3gVIOEupO0OWuhC7SmLrBiLJJNFX
 3ys4K1g90/w3LJ5n46bQBLjdQ5doqq3APID4Ep9SatPj86D8DZajXvFrOxj76RRXFTM9
 kY2rAdtmgwx7ep/EvHLhavcPgqCLwgziC8m7DiLL79csOxVwonFlaV/NrY73cpuAqP+t
 LoBMDk8u/lJZ/lc+VEuphC6JsEN+CKaiZjO3RTF4uxdDTbJaa0mOE7YJzUyG8FW2WKFw
 PFGQ==
X-Gm-Message-State: AOJu0Yz1pO2Fm+NS/+ZDLnmCFi6wKGDt5yWLMDME/lQBlkVPJ/jXFD19
 6M2miI8mjWPlcbRirY094wZLH+jxaFo7BAMq/9vJL2srFE+3h5FvAR4Yj5xarKlRPY3bfyIAGnM
 5I771/Ez1sLgDTSS1r01VrwlsapWIqNy1hEOPYw0y
X-Gm-Gg: ASbGnct5zfBjuYxiYf7cR2JdUqwkX+AyeUWr2EX8SitAS3lLCMRt1tUlmxYU/HGQV+w
 N1m+erfpBqM0Zw5/lxhirz5Dy6mss9bUm+TisnfHvdKPGTrnY9vh5ViJ/z/jj28a/FcO9D3T2aL
 4SSDQtj+JuTMVpnaSnWjSZCuwB5QQFOF6W1drWaZivqB6vKwBdbHPqGKdRzyYt2NMihwf6GhV9G
 If/CgueIEx7nI5JgWuA2pNfO38iUoG03tok2/GdwDLxG7fdayA9jSyBLRLs
X-Google-Smtp-Source: AGHT+IFqP4dkyRZTj2oejwW/6grX3MPlMnIF7QVJRKjwSHu9io/Ac8ntPSumA5oQl9CRlWwIVFwdj5tIh761dB+OIMA=
X-Received: by 2002:a17:907:ea8:b0:b6d:3ad4:ecb5 with SMTP id
 a640c23a62f3a-b70705eca64mr658717366b.40.1761987855160; Sat, 01 Nov 2025
 02:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20251029-btool-mkimage-docstring-v1-1-9905a95018cc@cherry.de>
In-Reply-To: <20251029-btool-mkimage-docstring-v1-1-9905a95018cc@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 1 Nov 2025 10:04:01 +0100
X-Gm-Features: AWmQ_bkxic4sgd_wh_12V3Wg-aZIOB-hgUFqpx6D2I87J_t1cDmFCO9XioLL01Q
Message-ID: <CAFLszTiR_2b-znMy+0UJhTFo1sYcsAEeGT6h_mCZiF8hfizuSg@mail.gmail.com>
Subject: Re: [PATCH] binman: btool: mkimage: fix Bintoolmkimage.run() method
 docstring
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Wed, 29 Oct 2025 at 12:30, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Commit 65e2c14d5a5a ("binman: btool: mkimage: use Bintool.version")
> removed the version argument from the run method but forgot to remove it
> from the method docstring, so let's fix this oversight.
>
> Fixes: 65e2c14d5a5a ("binman: btool: mkimage: use Bintool.version")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  tools/binman/btool/mkimage.py | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

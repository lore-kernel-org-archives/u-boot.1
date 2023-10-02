Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98101E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF4A0874A8;
	Mon,  2 Oct 2023 03:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NMoQMXay";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 008718749B; Mon,  2 Oct 2023 03:22:49 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34093870CC
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9ae7383b7ecso571246766b.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209753; x=1696814553; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTh6ay6wIk+9PpZrwwqqvmferuZfHeZZnjGTaTiI5AA=;
 b=NMoQMXayMh8LLoO1uubJQbWIhfSQ0CiQyTEpV0ilyy3hkCKKrU/3SeTwuCkjh6OTge
 IXpdxLVvfJKQMg9UITgzf3cwLD4t6Yyx+ArkgAsLmiZEg3OiVkgQubkUEW4J1ZCiZ7OZ
 vTVCjytIKL/N8yBWGz1ralG+TLc96pxqFftxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209753; x=1696814553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZTh6ay6wIk+9PpZrwwqqvmferuZfHeZZnjGTaTiI5AA=;
 b=uVMd5rcMTHy1sUXqh0zmgVji4BZ6BLkyzsKAFkNTnNnPh8fo1/n6ayvbp0mloGbwuF
 FA4jP5FbpH4t8r0oOWhFpbKYQOkk3Gy83F5owXM3DkA1KRx6HWO7PlqKG74/zv4AU47H
 sLqHRLqnV1UGZEGZJcBW6Wxj0qJCHXvEJ68w3FSdrEh2M52lCWDeFyPyUYJNOUk8gzfL
 heXV6si8J5BqLvXq48Hzjv5muC2B6iWrdFRi+sOwstzEpkykvmSyb6mfqoLNrW4bMYVg
 k9iTrapx39cU7sDk53ttf+d+JneP0m3WFfFBmrSSY8sN2QzhSOl4YmP0d4C3YURnwrvw
 Rp9g==
X-Gm-Message-State: AOJu0YxIXXvzVM0D9byjztVqqBVSygeMa/MFEXR7wPtJIeMMMSFD7ndS
 YZnUccXO6SuiW8N4yYl/hGg2rxKZ/ui2uQyRqJED1g==
X-Google-Smtp-Source: AGHT+IHVBeNq5a05kfEi2YthUdA4r8TBsR2sX4CHp4SDMcjYWfCvwBiKwUCxqw8WA302PXIAGQALfZB8r9oIJxrPJpg=
X-Received: by 2002:a17:907:75c4:b0:9ae:6196:5094 with SMTP id
 jl4-20020a17090775c400b009ae61965094mr9631182ejc.30.1696209753637; Sun, 01
 Oct 2023 18:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230928144458.2511087-1-sean.anderson@seco.com>
 <20230928144458.2511087-5-sean.anderson@seco.com>
In-Reply-To: <20230928144458.2511087-5-sean.anderson@seco.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:16:49 -0600
Message-ID: <CAPnjgZ1_s7XnT+3ghZcKrLzSL+p-4CqHjc8-SkW=W2xFcQAfFQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] malloc: Enable SYS_MALLOC_RUNTIME_INIT by default
 in SPL
To: Sean Anderson <sean.anderson@seco.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 28 Sept 2023 at 08:45, Sean Anderson <sean.anderson@seco.com> wrote:
>
> On boards with size restrictions, 1-2k can be a significant fraction of the
> binary size. Add a new SPL version of SYS_MALLOC_RUNTIME_INIT. As this
> trades text size for BSS size, enable it by default only for boards with at
> least 16k of BSS.
>
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
>
> Changes in v3:
> - Don't enable SPL_SYS_MALLOC_RUNTIME_INIT if we are short on BSS
>
>  Kconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

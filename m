Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6B5C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 06:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ED7A880F1;
	Fri, 21 Jun 2024 08:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XMXTzrBL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3D8D88149; Fri, 21 Jun 2024 08:14:14 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1B7E88047
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 08:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57d15b85a34so1831268a12.3
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 23:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718950452; x=1719555252; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Evu+sjgyFMCs5driTT6kHQFXvr9DwwMg/9znAHogQCI=;
 b=XMXTzrBLmBIgNP4KNCJ57sxuNODVN2HWJRwOh9RM/0UEQhqYgkozy7bLrU5/4ocb16
 6pWKgAvnlym0NEVeKAnQANsLBxkfC8ooU3lnvWvE83kSUk3e4R0YOa+ryL4WKZvylRgZ
 NcC/zybDxHfbdBd3OEt6hpskLh9bDwdcly0C3U1T9ECoYuNBZxmuNypnf2Z9PNZDhPbE
 wr2KPCWe2+vv+U4So7TTHcz9TC6I3XX2TpbkSJrJaZsSPWP0D5WqMLOEsgXMe7HFR8uP
 jUD97PTZJkS0xbn5R8cVK/x9x7IoteDXQJ7FD4bALXE5wg4JQlVOgb7hmRh+ZguZR3QV
 RUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718950452; x=1719555252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Evu+sjgyFMCs5driTT6kHQFXvr9DwwMg/9znAHogQCI=;
 b=d6OGST4MQy2EuG/Bc+vvGqDJUlmfsF18+KeSyeePrh2Ls4mUZ0u0BkY16wt+FpTjk0
 EdaA0FQJzsulQdlGHeRUPqKBNYM7ovA/xJYTD0IR13iWhZevJOzkSPsmT2dbXKzsjik8
 goOOSYP0E2zHlK9fHAKOkz3hGlqJINltO0ZmXkXXYQdfYry728+hbbs+TP1SXtPnwD3n
 3K34u2uRHq5B8hzlg/ejEU/3dlAbpxgo5ezF46MnJEjRXVjIXXbnATnuj/hiN++x3Z4v
 RYlibrl83Tu8DNTv9dB55tSXjh4UR7u9HzKWitcdH/soBrbFMskhnkroejTWydP+6zAs
 JH0A==
X-Gm-Message-State: AOJu0YyO3IkFbn87HimFk7W9N8pQZaS0Re3rxyFGKZ7HDcqXMurfYn4f
 aCrurMcN+0XdjysJ4oiKg4VuAkAV+U7+7p7oW3H8H50v1wX2oPNtyih3mXzWo7hO77cWmJv1RrE
 JyrV0Q2Zlk3feO6cJYdHiaj9ogdQZRjWarcwImw==
X-Google-Smtp-Source: AGHT+IGnRWU+JZCfW4ZGoGcLncahMb/DeyZopZJH6EGiG72FV2NpRpjrOVhmkfXbpCgPyyUPjuMZJnHaJrxp0eRYg+8=
X-Received: by 2002:a50:a69c:0:b0:57d:10be:6100 with SMTP id
 4fb4d7f45d1cf-57d10be6193mr3945896a12.29.1718950452302; Thu, 20 Jun 2024
 23:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240620230625.1797397-1-sjg@chromium.org>
 <20240620230625.1797397-8-sjg@chromium.org>
In-Reply-To: <20240620230625.1797397-8-sjg@chromium.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 21 Jun 2024 11:44:01 +0530
Message-ID: <CADg8p96c=xd6=6d1fijNFBwzXMszRnvo7J-qm-7co1panamP2w@mail.gmail.com>
Subject: Re: [PATCH v3 07/18] binman: Keep the efi_capsule input file
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
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

On Fri, 21 Jun 2024 at 04:36, Simon Glass <sjg@chromium.org> wrote:
>
> There is no need to remove input files. It makes it harder to diagnose
> failures. Keep the payload file.
>
> There is no test for this condition, but one could be added.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: b617611b27a ("binman: capsule: Add support for generating...")
> ---

Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>

Although I don't think this warrants a Fixes tag. It is not fixing any
issue as such.

-sughosh

>
> (no changes since v1)
>
>  tools/binman/etype/efi_capsule.py | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
> index 47da5da324b..03e55cbc4d9 100644
> --- a/tools/binman/etype/efi_capsule.py
> +++ b/tools/binman/etype/efi_capsule.py
> @@ -148,7 +148,6 @@ class Entry_efi_capsule(Entry_section):
>                                                   self.fw_version,
>                                                   self.oem_flags)
>          if ret is not None:
> -            os.remove(payload)
>              return tools.read_file(capsule_fname)
>          else:
>              # Bintool is missing; just use the input data as the output
> --
> 2.34.1
>

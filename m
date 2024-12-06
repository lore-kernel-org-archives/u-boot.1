Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B08CE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 19:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3EBD89376;
	Fri,  6 Dec 2024 20:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GbH6nFsV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18EE6896EE; Fri,  6 Dec 2024 20:16:36 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9B3288F0C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 20:16:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ee989553c1so2109487a91.3
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 11:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733512592; x=1734117392; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E0yox1t8mQ7IZ/vkjFo5933/djM+TCAVn4hMhDx2v3o=;
 b=GbH6nFsVOicpdJM7YphF//Ye5ER4AA55ifMKxXzoCv9qe0Zg4/o8Of4FbdwUaJAh3s
 EkHaeNS6BjCJILlu15O6dnYeDVCIetuV+bZoEUboxgZRs3emRXPJvh8ElaMYGHcqQMrA
 QEjjNp4QDDK+UiAJzP/9yBXFkPrwwZLDykIi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512592; x=1734117392;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E0yox1t8mQ7IZ/vkjFo5933/djM+TCAVn4hMhDx2v3o=;
 b=ivq2VE0p3DWphmi/agZJ7i4Yu6OeT0W28ooo5+eSd0suGpkFNhX/hA5dYn9aKInkIJ
 edhCiKPtm5n6D15c66Ls0juYiNnUQbIjMskRkDk9IyhyybvZl88y+mQQgqM/Vg3QD865
 SLrWl9oqS4H01DQXRLqrALWu121JFondBjPBfqjJrEzzPY47pxGQhKzqoPTc7vkEoSX8
 SPuliK6BJ3S+BEXbMBZmuKTGhYXPKbfxkp2aBMegewJAh+BLKyBMaXpOeKW5QRe8Yx8F
 ppYFyrjt25NJa5S47LCVlQBN4IB75Ey3wBJ2vB3WxuwODtwJFAvEOpq5askT1phvVKS2
 kfiw==
X-Gm-Message-State: AOJu0YywqKH+RhfsuMdb+REO55B0mFhZ0C9TVcnMKLaXK/ojKQQG3v/D
 l4XKZoRy2WpfFGLI9PcJQBTrpkqbxFIMcQWypVgQXYZICd7OUQpjgj1RRlnfub0AedmKXFauA4O
 Oktzj/44FztYXcbQnaEHk95LhbIQaPqULsnRVTB5v+BQUnts=
X-Gm-Gg: ASbGncvuVmpssysELc2vT2kxlR8+HxAdP1fITWKA+IwLqBQzt/aconwffK8EiCubQ0q
 S9BLf+dgh9Bku37AzwhN9SzvxVZObO5Wp
X-Google-Smtp-Source: AGHT+IH2z8TpHaiB8I1FGzXrAbhAUrJVi7DMB30CZ+3pF/CPESV+BxiMy5D02KrNQE8qAzztEWF/P8LS1RDFiVwc8/M=
X-Received: by 2002:a17:90b:2744:b0:2ea:77d9:6345 with SMTP id
 98e67ed59e1d1-2ef6a6c10d9mr5927437a91.22.1733512592446; Fri, 06 Dec 2024
 11:16:32 -0800 (PST)
MIME-Version: 1.0
References: <20241125175421.1181907-1-paul.henrys_ext@softathome.com>
In-Reply-To: <20241125175421.1181907-1-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 12:16:10 -0700
Message-ID: <CAFLszTh782uOFHJjf69QmH0WovHuef-bG03T6+sM=miGVhxwww@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tools: binman: etype: Allow to replace 'NAME' in
 node names
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.denx.de, paul.henrysd+nodisclaimer@gmail.com
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

Hi Paul,

On Mon, 25 Nov 2024 at 10:54, Paul HENRYS
<paul.henrys_ext@softathome.com> wrote:
>
> This change allows to replace both 'SEQ' and 'NAME' keywords by respectively a
> sequence number and the name of the FDT to provide more flexibility in the node
> name for the device trees included in the FIT.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
> Changes for v2:
> - Add a test
> - Add support to replace DEFAULT-NAME
> - Update entries.rst
>
>  tools/binman/entries.rst               | 18 ++++++++
>  tools/binman/etype/fit.py              | 20 +++++++++
>  tools/binman/ftest.py                  | 61 ++++++++++++++++++--------
>  tools/binman/test/345_fit_fdt_name.dts | 58 ++++++++++++++++++++++++
>  4 files changed, 138 insertions(+), 19 deletions(-)
>  create mode 100644 tools/binman/test/345_fit_fdt_name.dts
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Note that entries.rst needs to be updated whenever the docs for an
entry type change.

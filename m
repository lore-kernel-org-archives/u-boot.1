Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F7FC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 14:16:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DB6081298;
	Wed,  5 Mar 2025 15:15:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bzW6Y4J7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DD4F812D8; Wed,  5 Mar 2025 15:15:56 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 269648083E
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 15:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-abec8b750ebso1184002766b.0
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 06:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741184153; x=1741788953; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O6aI2Ogw0EaKMuO1YBZCKvq5tpcZMfKPsDhbkibNemI=;
 b=bzW6Y4J7Ry9n9802xtGsy2MKc7uwrpvKqmj1cKz+NF9yDhlCAg+RtZO0eyvORX/pOG
 oD+YMcYMVvf2KG0R4wv0UOjJVAADKi9woAxZXWz8qrgbTqxemnDIqUNhZA0DUH/sOU4w
 zNaVdPQLA4qZ4JiuC9q66vYseJgLLnISgj5MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741184153; x=1741788953;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O6aI2Ogw0EaKMuO1YBZCKvq5tpcZMfKPsDhbkibNemI=;
 b=obpAcnnO4I8R8HyWzFS24Lk0PnZUERyWqhVH2AW+TQX0zyWTPNiCt4UFZ8+GT2erJX
 1bpk2LWyA4PmZAT8pvevD90lDreh92SIDyRbpePM6FWXkO3oVp5D5dbuBsSQhiAEl6jj
 Fa4csKw0LTvH3MMNz2x7dwx3HnshWzkh7Pvu1SHwB98LS5vAQ095qmsmmLlxlEdmVrBj
 rRSYqgkGYFjGkQC4GmFBbdyZGZL0reP5581YIg6GnarwKVEc9Mp4guJYHJrZ4lbnv0RG
 LNsrSiVJFnXNJfUDPTFfquvYhS2UiEpCCR7W8mUHAFvgT62eAMVK7rcHrhG61tEATpS+
 hq7w==
X-Gm-Message-State: AOJu0YwD1iYAfuXh7sJ+Oq1YmgihKXuNCswsX16MpvQOPf3w1IsrrIws
 B4viswXFeSu8fCy3RPalLw7PrconUKoVcH1IXMaGveQl3MuZ5buTEBUk8054/1eSAo8rbSpVOHQ
 o+jSbzgfATVSVVfuLpnSBs27ldTXj+NwJyfnH
X-Gm-Gg: ASbGncv/ctapjj7Ke2g7+3Al7XhPZcj8TruNp24A7CdVI9HW4+VgS4FSWvmm91/MPWi
 16c/0R0Z8Iy33cP/DnEDESh1yVo4WTL04obrZF/TBMldXaGR5eumE/XTm6Icm2nsW/9BfBadRCc
 sJPkyCbcZZJ/YOwX/VGNShvHSM8Io=
X-Google-Smtp-Source: AGHT+IGxipGAtD15eHY0ZmvAR5wFY7rTLJRnnmT1vxqL8sgtHfA0Js2YTOL4E958pf8Ye/ru6fdm7sOEnYqigmo5xoM=
X-Received: by 2002:a17:907:7d8c:b0:abf:607b:d0d with SMTP id
 a640c23a62f3a-ac20dabb6b3mr275664766b.16.1741184153525; Wed, 05 Mar 2025
 06:15:53 -0800 (PST)
MIME-Version: 1.0
References: <20250226210501.72794-1-l.anderweit@phytec.de>
 <20250226210501.72794-3-l.anderweit@phytec.de>
In-Reply-To: <20250226210501.72794-3-l.anderweit@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Mar 2025 07:15:34 -0700
X-Gm-Features: AQ5f1JoHyVO6Pud1R755jOYUkxK0bZDxe1vzCWdUtGZdG_ewGU5cJLOfpW_nSq4
Message-ID: <CAFLszTgYk8k32kAmxoq1m+5BwE1FPvxe_VRca5qFfZcb9ZdwZA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] binman: cst: Build from source
To: Leonard Anderweit <l.anderweit@phytec.de>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Tim Harvey <tharvey@gateworks.com>, upstream@lists.phytec.de
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

On Wed, 26 Feb 2025 at 14:05, Leonard Anderweit <l.anderweit@phytec.de> wrote:
>
> Build the imx code singing tool from source instead of relying on the
> distro to provide the tool.
> Use the debian/unstable branch because the default branch is outdated.
> The binary is supposed to be build with docker, work around that by selecting
> the correct Makefile directly.
> Also append the description and add a link to documentation.
>
> Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
> ---
> v2: add documentation
> ---
>  tools/binman/bintools.rst |  8 ++++++++
>  tools/binman/btool/cst.py | 37 +++++++++++++++++++++----------------
>  2 files changed, 29 insertions(+), 16 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

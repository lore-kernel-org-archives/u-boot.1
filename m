Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05569C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 14:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82B0384C51;
	Mon, 13 Jul 2026 16:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X4S6kZ23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1D1D84C51; Mon, 13 Jul 2026 16:29:19 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC1B884C06
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c15bf399d3bso383310966b.2
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 07:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783952957; cv=none;
 d=google.com; s=arc-20260327;
 b=mhycpNjIgRZW05826rElXYaFegO3+PFzhaa0dlmfafdMXU9eAuC/NiYnubQNXe9y9T
 lKbmSnGicDZXeH/+xHjFFVk5EefA1KIWHzBTPnlANMgRbfvtXsgZF2N5i5G/5uJDxsAy
 fBA+IMj5wT5JgvnuNXk4j0p1DRmpKx0PisSEz21JOWY7vDzKHH0mOc0QZEozwJQaKdta
 5LWNZZJLHqJS10+FMIwG+Dc2Qo3knoHnTDY9TbCpkIYE3s4G6CH1RNJHKEchCocdKEVI
 0XajHdr9sM3WbagYyjXAywYm15sjIpYy8xsYVRzbzzc9bG3XpZV0h5V/ijbA0BmXPfYg
 o9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZsxkXd+p3q4Tp7m1wSqixvR2s2CRFoZzIHX4VArFg38=;
 fh=HADF8q3dYLaw+r1mrqoaWYTrn/W5KFtrsaZX2ttkYDE=;
 b=ZrLQZ6Qyrc2hzZkKN0GYF3uM3E1KmwL7w9gxVMVdfc0Bl7ZmAtYohwyNxNrSD5gtzC
 /JQxDVkBgXM0DxVqosayZ37qUA5NjevccjGB1i3+OjXAFPQp0/oIj4300ezYqTD8fL0U
 hguydbEcx1zuU2irteTIYf3+42wo5RnYhmFMVrJALWqfVxCx+zHGt3bmfEIeSeaKh2zf
 5hE8UivEqxDy22t1CkgevTx6PYbNpItPFlfnzWy2IzE39cfavyDPmF9Eu1Ys54wybsDC
 vg0EKPcgab67s2ACu6TqiDGniIDz0Ah/OVDWkcD+HoOf1yW9hFhc1ewggqKT2/VCiyC0
 JRGA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783952957; x=1784557757; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZsxkXd+p3q4Tp7m1wSqixvR2s2CRFoZzIHX4VArFg38=;
 b=X4S6kZ23TGTD/+UkllVe7l5zThnmaEZio/qLFfgo42/lUzGYXd0gRJIsXPmDJ0AKJd
 CFO0a4xmXVfBxgrgG6v3Ae9DUFUwi3P7q+V/Uhw5UuxdGye0lOfmfMABkmPCRTPUqJmo
 oDUrqNcUzefXaQlnGtYQRAGFhDT6kc/kv6/9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783952957; x=1784557757;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZsxkXd+p3q4Tp7m1wSqixvR2s2CRFoZzIHX4VArFg38=;
 b=qlIrbHpjXKM6EYaKSVyHrHOQBN7tqF+mcYbEzY4A4uLiarvr7R5fxLWTfcE1XyHSuT
 Ptnv1KJQkZZ3Omgt9ksxVe7U9SH/dh3R/dRtqIGeomos7gDcEkA69h6kgGCuiDy0ci7W
 7Q1Lw3gqKeumVYO3YMjyYf8O6u3zYc37o4l/Sawf2vzLtnp8x3m4sNs5Pb0udldmcTC2
 vu20nyDD9WqpJnz3W8sfjcPA76Ly4Q5HsfcRUeIMqVBKRqZlUTZQfAt1DFGFSo/2ZXmr
 +Y6sbIqkJjkEMNSCatOvethSgZ0AodCG0mPtMRztl5rzgDyFz6mM2m5w7eohZq72dX2+
 ovHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwP3GvwK7PeNuM/Hr4ep3/nszzJPjt7eAnkQDf+hjs5/xgUk/0KQmybp1njkdX+9RLZEJwZuc=@lists.denx.de
X-Gm-Message-State: AOJu0YwG5XLBOrzrvHL7ChWzas3t618UVmID03BP7tMs1feFq02ccJL2
 n2B/Qr7EPgBNlnoCSCz68mRQlkAkJoYu4EA4pPj6Kb7yrxgtpRaYOXHJQZgCXIffnrtnatx2A3e
 Cm48+rLpuoDKh7ESxWCdB7FtzhHjaWTQnpzj19pEM
X-Gm-Gg: AfdE7cmpHbL0dsTAFfaWX9l8QkduwqKQgo/YR7VZksT2MU1DVqaUfS3DcnsLb4lrHYQ
 jQbJwTd5Q7KNFBQb2p8UYASJK4bdIFik3nlufMMcfyXS1o339ZIz26PNVAEE0pH+N9bO4kjB7rg
 6cRnnypk8NQ0jo4U+2pgRVvsmDKItQ8tJalw6zvlEZmMtrMF1gclTwQ/qNs3ci+8la5MaBhbk1T
 MGN93IWmiYSGsTVTP5M538l+5OHIBl/TOvPYWUjdxAX8AZtUJrfdudsJHsaQMYK/3CJ2i4=
X-Received: by 2002:a17:907:cf87:b0:c15:c638:d03c with SMTP id
 a640c23a62f3a-c161e9fbce2mr374755866b.47.1783952957126; Mon, 13 Jul 2026
 07:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-11-jonas@kwiboo.se>
In-Reply-To: <20260708220540.3368825-11-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 08:29:04 -0600
X-Gm-Features: AUfX_mwB9MQL9ZGvUNc726QZ5_8I3Me3zbF5YS0Y1N6QtMQUyPk6chHt8Xe3_bs
Message-ID: <CAFLszTgeXz5eDB6T4DzE4FWr9JCJzZt8j==PhZa6g4AdmxTf9A@mail.gmail.com>
Subject: Re: [PATCH 10/11] console: Use CONFIG_IS_ENABLED() for SILENT_CONSOLE
 checks
To: jonas@kwiboo.se
Cc: Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 u-boot@lists.denx.de
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

Hi Jonas,

On 2026-07-08T22:05:26, Jonas Karlman <jonas@kwiboo.se> wrote:
> console: Use CONFIG_IS_ENABLED() for SILENT_CONSOLE checks
>
> The xPL_SILENT_CONSOLE Kconfig symbols are not fully respected for xPL
> builds, instead common code is guarded by a mix of SILENT_CONSOLE and
> xPL_SILENT_CONSOLE symbols.
>
> Change to consistently use CONFIG_IS_ENABLED(SILENT_CONSOLE) to make the
> common code properly guarded by the intended Kconfig symbol.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> board/friendlyarm/nanopi2/board.c |  4 ++--
>  boot/bootm.c                      |  4 ++--
>  common/autoboot.c                 |  2 +-
>  common/console.c                  | 12 ++++++------
>  include/env_callback.h            |  2 +-
>  5 files changed, 12 insertions(+), 12 deletions(-)

> diff --git a/common/console.c b/common/console.c
> @@ -736,7 +736,7 @@ void putc(const char c)
> -     if (IS_ENABLED(CONFIG_SILENT_CONSOLE) && (gd->flags & GD_FLG_SILENT)) {
> +     if (CONFIG_IS_ENABLED(SILENT_CONSOLE) && (gd->flags & GD_FLG_SILENT)) {

This slightly changes what SPL_SILENT_CONSOLE means. Previously the
xPL symbol only dropped the boot-progress messages in spl.c at build
time, but now it also gates the run-time GD_FLG_SILENT checks here
when console.c is built for SPL (i.e. with SPL_SERIAL). The help text
in common/Kconfig still says "The GD_FLG_SILENT flag is not used in
SPL so there is no run-time control of console messages in SPL", which
no longer matches. Please can you update the SPL_SILENT_CONSOLE and
TPL_SILENT_CONSOLE help text?

> diff --git a/common/console.c b/common/console.c
> @@ -72,7 +72,7 @@ static int on_console(const char *name, const char *value, enum env_op op,
> -#ifdef CONFIG_SILENT_CONSOLE
> +#if CONFIG_IS_ENABLED(SILENT_CONSOLE)

Just to check: there is no VPL_SILENT_CONSOLE symbol, so in a VPL
build this (and the other converted checks) is now always false, where
before it followed the proper symbol. I suspect that is fine since no
in-tree board enables both VPL and SILENT_CONSOLE, but please mention
it in the commit message, or add the VPL symbol alongside the SPL/TPL
ones in common/Kconfig

Regards,
Simon

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30A4E98E13
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 10:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F8F483BC9;
	Mon, 23 Feb 2026 11:30:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IuAT1uca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEAAB83C39; Mon, 23 Feb 2026 11:30:40 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C08B283935
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 11:30:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-38709eaf012so35487041fa.0
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 02:30:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771842638; cv=none;
 d=google.com; s=arc-20240605;
 b=eci65K/UqBcKHstyb6ju9T8efcrdvArxKRZBpl8WIq3TkMGlO3IK471vWn5UfzzzT2
 ouvCVXWt5ON7Nu0Ru/JX27rRcavc96gnIvFt7oJrDKCrKWa+wLQc+qoweoGlYdEaGNzX
 vwngZhYoJXrBW4P9Tx0UpY7mABu+mmdcW3zamSEUxdvNLUHnBEpWq9tb9JJIMsBG6W7G
 3XJfy2YfXboNYhGyuQ4R/isCMT6n7yra2ArajbUSXIVBkJUIej/4wtPe/oY+fDrXEczF
 AChCKfRRWZYlzdvk3+WFX2KbRKz359FhvkmI6tdePbLxpw4X/HSOvfzQkx/7g2/IhltX
 BXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oWl1PnXMBbUSaHVNcSsckpYjh23UkKoJYRyiJ/laHpU=;
 fh=aavfnXacPzGMlWFMAegE47Ir0j69hy01IrlJMb2/G9g=;
 b=cGnoI7SVi77+wY50vSSLxx2OA6JaqnJ6Tc6WToOD7EN5apKDEpm+YrSEAmjJkhUJlF
 JRl+TWyAzYGJjN++kL6J9jouBaMdkmLrCF+b27j2dst+U7c/89v3mDFpxUwAj93rACgT
 M9pPlQIDti2xWC6ZNZHXeh7c7poiB7krq/cVxDamTIUHT3BvbMKe1b6PdeDfO+J9XXUo
 YwVbJNoEXJ094KnR/ssxltCnw/qc9Sbb80MUtPJl8mkyLizyk7gvZkUDTS2+sRQ9lsd5
 QyvHw0/Ya9m64o1xQJ5wqn6BhUcOYo5CjeEugDxPpOQOfmXW6d/j74du7mlcQ1csmCOL
 uBPw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771842638; x=1772447438; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oWl1PnXMBbUSaHVNcSsckpYjh23UkKoJYRyiJ/laHpU=;
 b=IuAT1ucaxcWBqJpAkLU5o88yiXP23cCTA0a5mzEtllzDA4SXHjrPV7XHT9nRVAIbLf
 8g4gq06noYlSufREyTu7vZmmFU8HCUP6n5OIcLPxLdrOYLUl+cD4A3Mkc1F0XsYm13HS
 r4OwtXNqi+AtA4ab05OtG/YfcJiQcod0obdgOiyk2h9yOgKzHwtIwes6HMZPHueRe3b5
 OAkV8VZEuEEBrlpsX6Kus0wPtrXXFToiNaJqKTi+Z55+KfOjRrtY8jVRwuRDFjqDoy1k
 Cr+X0NaZDXwM3otTBtDxJ7YQL4vlFh2ohVl0vPdnv+xBOBUFud4UnMXgR4g/OxhcDuAv
 5r+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771842638; x=1772447438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWl1PnXMBbUSaHVNcSsckpYjh23UkKoJYRyiJ/laHpU=;
 b=DMiQHXwA6GhenFtk3DCBkJCW4PUI50iCAiuC87ekBdlIYPoiubP+9ngQuRplHTg3oI
 0cEgJRZ6ieocE5MRRvoFt/eRSVyPB6Y5gKYLBS6HMnOqCTh/DWHPhqtdhlvc3cXcn2ax
 pg+cZ9uaWJIS34O7wcO+1gpJCNcEELMu8nww73UKY0zM9azxNcnhNbL2nG5jZh/3muSX
 jEnE9HL2P2tKDo3TgvSDreeqnqOeNo30l0qW/+8XzhsS5w5v4dvJLKpT3x2kWXPT3RNq
 WYHsMojDFVphYKXflMvjOwmCoFFf6Jg1r0oINjN1wGbx6O53sazq1V6y0o69/RxHGVUg
 oxgg==
X-Gm-Message-State: AOJu0Yz1Dt7z6smk5JLFW4nXNv9n4fETOVHHjGaGD3FhsszBSRI6f+Ov
 dUSDoYh8FNaToF4G1sasQ8SvDXiPPsucHtVOJwaeVNsDtGS0cATvWsuV18eTA3HxciH92hybmq/
 IVSp+KnpTKX8Rnkm7YfmQSLTfiqncFXA=
X-Gm-Gg: AZuq6aL6K1fAvyZTSULSwSdSnWNOcnSPbo+hiSOK+rz4lBM5NFZ7eOo/y/OAQoJe2sx
 /QfOpBpmjO+vnmPoRzJEbjWWfs15eRVEbnPhjK+E7wYlBA1x/eKStqBLJzFcj/ZL8AA7ILJGvtS
 4w3uPf7Zah4NaMF172Ef4bhZTop/E+1WGAz8HR3TU6L+KdM+/bW1NHO+8T4EGYPkBfXqpxDQ2dW
 Z1S15HlEmHkn4IYuGD173d6HQvoV731jSkEJJ3Tz50eRS8biDZGpdlpiwXFydjRtJo49ShrwYC3
 /f0bklyn5bFOKMPUkPq6opcOINY=
X-Received: by 2002:a05:651c:3242:b0:387:b8d:60ee with SMTP id
 38308e7fff4ca-389a5e71eb2mr23901831fa.39.1771842637724; Mon, 23 Feb 2026
 02:30:37 -0800 (PST)
MIME-Version: 1.0
References: <20260203-exynos-mobile-external-dtb-v1-0-a16a0e57991c@disroot.org>
In-Reply-To: <20260203-exynos-mobile-external-dtb-v1-0-a16a0e57991c@disroot.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Mon, 23 Feb 2026 19:30:23 +0900
X-Gm-Features: AaiRm53Q-lIw60c9H2TMCHSZzI07Dc8gmD_uNp-UhQ0eZKdRXtzHYE60Zyi874M
Message-ID: <CALrBrZ0fFJu7fNhRR5gdY5HFrSMm+SDicw+7AwHEpAUfavr9tg@mail.gmail.com>
Subject: Re: [PATCH 00/11] Various Exynos mobile board enhancements
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Minkyu Kang <mk7.kang@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Dear Charkraborty,


2026=EB=85=84 2=EC=9B=94 3=EC=9D=BC (=ED=99=94) 22:49, Kaustabh Chakraborty=
 <kauschluss@disroot.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> This series aims to redo the way the board file works - notably it now
> tries to depend on the external device tree if an internal device tree
> is not provided.
>
> It also does away with MULTI_DTB_FIT-based device tree support and
> instead goes for a 'one device tree per build' approach. The
> implementation draws great inspiration from the qcom-phone board.
> Instead, the device tree target is to mentioned during build time.
>
> The patches are based on u-boot-samsung. It is thus expected that they
> reach upstream via said custotian fork.
>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
> Kaustabh Chakraborty (11):
>       board: samsung: exynos-mobile: simplify parsing RAM banks from
> device tree
>       board: samsung: exynos-mobile: resolve env vars without board_info
> data
>       board: samsung: exynos-mobile: disable MULTI_DTB_FIT support
>       board: samsung: exynos-mobile: enable OF_BOARD support
>       configs: exynos-mobile: remove DEFAULT_DEVICE_TREE and add
> OF_UPSTREAM_BUILD_VENDOR
>       doc: board: samsung: exynos-mobile: add DEVICE_TREE make flag in
> build
>       doc: board: samsung: exynos-mobile: use u-boot-nodtb.bin for
> packaging process
>       ARM: dts: exynos7870-a2corelte: add properties to make S-BOOT happy
>       ARM: dts: exynos7870-j6lte: add properties to make S-BOOT happy
>       ARM: dts: exynos7870-on7xelte: add properties to make S-BOOT happy
>       doc: board: samsung: exynos-mobile: remove requirement of stub
> device tree
>
>  arch/arm/dts/exynos7870-a2corelte-u-boot.dtsi  |   5 +
>  arch/arm/dts/exynos7870-j6lte-u-boot.dtsi      |  25 +++
>  arch/arm/dts/exynos7870-on7xelte-u-boot.dtsi   |  20 ++
>  board/samsung/exynos-mobile/exynos-mobile.c    | 276
> ++++++++-----------------
>  configs/exynos-mobile_defconfig                |   5 +-
>  doc/board/samsung/exynos-mobile.rst            |   5 +-
>  doc/board/samsung/exynos-mobile/exynos7870.rst |  42 +---
>  7 files changed, 147 insertions(+), 231 deletions(-)
> ---
> base-commit: 3f2ab427c13e4883cb5dddb4c54d3cedc0f93669
> change-id: 20260203-exynos-mobile-external-dtb-58d37746567e
>
> Best regards,
> --
> Kaustabh Chakraborty <kauschluss@disroot.org>
>

applied to u-boot-samsung.

Thanks,
Minkyu Kang.

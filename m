Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECC2F94CB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CD6983FED;
	Wed, 22 Apr 2026 00:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JPReIWi4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0213C83FFA; Wed, 22 Apr 2026 00:52:25 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EDD783AC5
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ba9ad0fbc3aso169516866b.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:52:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811942; cv=none;
 d=google.com; s=arc-20240605;
 b=U1IKlNQUEYBSQ4hOSi5nR36AmU7ZD/COXeK8rhhAR0MXdTLNgE+1w+MvL1u5q4Zm+/
 z1BZMojyldh/4kqZIhiyfYGTUvjB7v4qeoXXY4brr72IK2TsRL668fz/745MeNHKp8rI
 HtcRNjL8Ktjy9Fh8k1NRVkmMiVznPZNFomWce+zQ92AB1uSVXZeuwt5QVK9aN/fvrXyc
 zjVjQZzsE6o2mxrIMSYXunCQuZiIm5nY5cCi4r5nQRXdEhV82ZIG/qqnCUCUEMtoOvZK
 M0Rx2UFlab0KUoHvaWN9iNyM8cG3CUvKwa3Ok94H4uDEsvuYa/6yKYmPewK/qaX4R8Pc
 dmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9qFdnoW0HuF0ECSXGwXcBUUxknaVFNrLfdamAr9Uplg=;
 fh=T79q7iQaKgdBLSTuhvl3jRYD2v6g+8MB8Joags6q2NI=;
 b=iQWNq8Xw6YOZhqr//vsv7idir2I63ajtEf7ORB+v90oW1ArW5raDArSa7yniGA/7OT
 moiBMmmQkSUU5cuGGjNrxjrYtFSspbaFewLrrzZuURAdo8Za4qcP1D8MOz1UhX2a9qLK
 c1MB0m3OF/3o0JCY4BkmCWGebhYkih99/Uxqce/PPTQwfPXeBLnEWjoUsYiQumep6/ro
 pZav8GXB2DJGeKUTjYQBgarMjSh60AgQzddHj6Cy3ioTkwiUedSqBlxx+ryfnNHnV3PV
 F9bj+6avVRaxN8EZyf2ySBWQGqkLZk4YhRrZq+1B2LSbJgbtK+8jmCAeaOhmOSuS3nWf
 rGxA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811942; x=1777416742; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9qFdnoW0HuF0ECSXGwXcBUUxknaVFNrLfdamAr9Uplg=;
 b=JPReIWi4jKrsDVLQayxskpcC5NwIyT+4d0Pgkdr8FfbsM8WEf7xZXPYtGmNhykw2bt
 1esNeQi3sQ6EbCEyIf+AhZKZQRovUS/lly6XbX/KhoHrzMQ5IirgqjgPbcnsLOtuYmHC
 LXd/eFG9t+bNVag7jmLI+K3tPGtZHk+U+74sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811942; x=1777416742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9qFdnoW0HuF0ECSXGwXcBUUxknaVFNrLfdamAr9Uplg=;
 b=AktxfwFWsClVXA2JSmK+AVwmkQz5eyv2A3y/d20DkpkL/ShW+zfrpQ89bgejBCkydO
 t3nlf04VXmEm9p/4J3J6orNI68hczLwS2XtuIS5wqsqjCFnQFfR3Yv6SIT8jWYNJ66rD
 nRyC5qs0oZvDtkhTP5Geaze6H96MmCI7bBCvq0zlniHz3NtV7VoegzA3Xs6WhKDE9/QK
 mRiz5M9JXvaWOWteL/xxQ0yCagjWBUjLuaNqBRnNf9qQDqxhv6vY9k/6q8UmLa5D+KTo
 LHW//9tNi56yTmjD5h91fuwF5Q3VvdJjuqKbGjHcNWyDdaCAZ/O46xKVmdrxVYfQEn8F
 ChAA==
X-Gm-Message-State: AOJu0YzAS37fq+fExAfdLesJ3Z2sUy/usduzuzrwmXyxf6C8MMU1VbnD
 docOdG7YUzdDESagLREB/ZhsHZq1+vPGsbNWDtOBpuSEMfG2xVgBPDvsDy6P7+YZDNUBx0bD/hI
 C04yNYnoIXm18ZT3l+oz2L1ddSmcg1rIdiErseDra
X-Gm-Gg: AeBDietAbZDbOMgm3X1UTXD/GpFjv9zmEwyvkP/Fz93Ls5872XvRjDiFcUP19tgNARY
 nPeKa57o2UZtUjpVj7Vdg6L2qIrvlsCZwnDZn1xz9cAJdckrhj02HiGpRjXZEZkefZGvhwFFPRd
 08eAEUI360MrlKjLWpP6VQEn2csDGep1TJub1//v9GSTwazPcpIdYZUV0V3SbeCAyQM8f9ns5ny
 VvfIMfYigVqSuFcxy224oy/p4a5zRhne/BZ6L/4a+q3XpSmxZgb0mV5DAM1UpXuDjBP66YyQ9gw
 EaN3W+DA8mfDNchEf3Ln
X-Received: by 2002:a17:906:6a15:b0:ba8:5260:85f1 with SMTP id
 a640c23a62f3a-ba8526089a5mr394180766b.12.1776811942589; Tue, 21 Apr 2026
 15:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
 <20260421-ten64-add-usb5744-v2-7-eaa81288e393@traverse.com.au>
In-Reply-To: <20260421-ten64-add-usb5744-v2-7-eaa81288e393@traverse.com.au>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:52:08 +1200
X-Gm-Features: AQROBzBLZ-147PX4tOv5p5KRY7--0gkwaYn_K5KGhxRMhp7cAO5i8k7bbB0JtRE
Message-ID: <CAFLszTia9ySE61T6_F_jADGDM2XPG7MKQjgx2PXHADCBaj1wyg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] arm: dts: remove local copy Ten64 board DTS
To: matt@traverse.com.au
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Mathew,

On 2026-04-21T00:04:33, Mathew McBride <matt@traverse.com.au> wrote:
> arm: dts: remove local copy Ten64 board DTS
>
> This board has been migrated to the upstream / kernel
> device tree version (OF_UPSTREAM), so remove the
> old 'local' copies that are no longer required.
>
> However, the -u-boot.dtsi append needs to remain,
> because the SoC fsl-ls1088a-u-boot.dtsi is required
> for some devices (like PCIe controllers and DPAA2 ethernet)
> to properly enumerate under U-Boot.
>
> Signed-off-by: Mathew McBride <matt@traverse.com.au>
>
> arch/arm/dts/fsl-ls1088a-ten64-u-boot.dtsi |   8 -
>  arch/arm/dts/fsl-ls1088a-ten64.dts         | 388 -----------------------------
>  2 files changed, 396 deletions(-)

> diff --git a/arch/arm/dts/fsl-ls1088a-ten64.dts b/arch/arm/dts/fsl-ls1088a-ten64.dts
> @@ -1,388 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)

The subject is missing the word 'of'

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon

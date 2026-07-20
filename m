Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2150C44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 576074067F;
	Mon, 20 Jul 2026 18:06:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id emUl_oCyOt2s; Mon, 20 Jul 2026 18:06:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A2D440430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784570788;
	bh=76kmUotF6DPoXNHQJXDHtGf+Ark9LTipzBvW3je0WkU=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=v6vyp94zTWtj3jLx010j6HZ+v3/dKWoMcvAJ8pUnMgOKuOEukbVIy5golF7VyH7gC
	 kMA4kGpny8BSzzEOT376MkXzit7bm6rWniEV9Dmmnlg8ChiCeF3/qNaIWQFrablMkR
	 jjVJ7vkpV4AwYRRbuE74x8yUnenRgrj3hUZWTjJRwiK7xOmtFV7Og1PCgwnBotnEOp
	 A4a4doroalio38aAfLivqMmVBMIXFTSyRwntMGqENBsJ2hywiudtpid0wJbd88d8zO
	 U1SmPXnBwVUmjlx5FmppyQcjF3n62y30dPb9FJK0g3CwL5sht5twgENWM84xCxonvy
	 p0uFdhfs3Hbsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A2D440430;
	Mon, 20 Jul 2026 18:06:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D596224
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:06:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E44080CA6
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:06:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RXhTUth1TuCO for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:06:26 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E9D16806FC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E9D16806FC
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E9D16806FC
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:06:25 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F2F5842FC; Mon, 20 Jul 2026 20:06:24 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BB2680433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:06:20 +0200 (CEST)
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2cce6a0c9c3so94079325ad.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784570778; cv=none;
 d=google.com; s=arc-20260327;
 b=cWcIJL7xC7URcgdrbrtLZhF3PVeW5lvlr3fBekW5CaCb/utGldtMCBwVxZL+92HZvx
 1BCYAASvRzjenyWYLNecFgz+Rt8qwc9oqsc1bzDKcm9kXb8ukTR9/pserG9bHJ5p+Xaj
 LEwLd0d8DFGNPfjr4H0OvE2pfBALCAp5FcUFbB24wSrt6/dj5iLtsQ6rU37KglzPe/Ed
 A8h0YvAFCh2snuR9bvekdDZaXiSIkbz6sMR2dLWDSZfCnELWZVXtsi+D0YUOf385jInm
 9fIV7vLXbetpS54RYazk4Wy9Zdo3suMWTjnQravxISfuZB+qrykNSvH5S0yb/1cIkgYA
 OSWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=76kmUotF6DPoXNHQJXDHtGf+Ark9LTipzBvW3je0WkU=;
 fh=S5IsS0p2q/mDhy6CofKU3XdI4SX18ALJnocWEeQR4Xw=;
 b=Dy06eCWPmoWbt8Qk5UCtre9RbLYTJMBWIZ0ImPrOuGRTLTpQFTDfuB5FhBx9IAxMqM
 +g3tHDfB+s2DuYTTcHD9u2yibQPq4yUTFKGsLXnUzRQgMv3UMzQS0AJsgqznOFa4Ww9R
 ycS6tQD0Zx9VuRK9z8c1dlwiUgEis0Hu63PVYr3cNmNPrJ5XCLF4L/9t+qQZNO3e4MxQ
 TVfxgeBnJhiOZ71BDwZxfMPMyanpqCFdfnI8G28UDDZ05FZ809i3X1MUn2z3uj8NsmdB
 BuWktIVcpfNYRggthZJiorvnUsw7JSW/ck2Fg98lE0nY9I7lZlmuaw/N4FR8dau0zXFL
 UOZQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784570778; x=1785175578;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=76kmUotF6DPoXNHQJXDHtGf+Ark9LTipzBvW3je0WkU=;
 b=fWrZH7EsEXC/vbEUiJX7Tb0eUMLZd5aImFVlWY4hFIkZeul6x6ytMgmDZNpbW3WWCx
 +ePk9lSjCbiidHFaihS5M77qYIHD3mNDouHCJ4FGjTKMOUwxOCQQGyspm2iaTwvHPNGL
 ZX7uHSDQeh00p4cfP7n29qdF6qkZ7SiPcz1IlxU6L7aw51L+I7K6C/DSRuYIM88XT68v
 b3mkH5cvrC5cKfSGgeqIx1VubLV3f07B7Shj5I4UZ9CKT7BjXB+eUn89CwB4IKueIAMZ
 hH5lz3RuGg1nSDHPJFy69teINudHFl+td5jity+atsjsVRzU95VSajlZ3Mg0/AM1RDDB
 bSFg==
X-Gm-Message-State: AOJu0Yzp8p1YKZ30GnyVNxW9eYzbhlPDF0/2PcNpg800r1KKbsWlJxUQ
 WJkvSWI8zcxz+ifYPt7NtA68hHZ3lgzcE1A653ntiplQfbJfURwdiRGnK5nUiDRXRJAWSGimnIF
 HlJEG2WeAv1tRjKqWUgv+SxpUhFi8rLqyehfmvqLD
X-Gm-Gg: AR+sD11O/0DyOFz85JsKgHqA2BUoHWWzBxrqB8WZErlCWMw24lHjaVT31CROeQJLPMr
 P30+N0eyVDuYsVisT4BUjYxIwRwG6Sz8j7obhT4LGX2KORGBbHUM+Z7gVCixdirnPOSsf26WJXn
 Uzs5ORV8vsxvWpC7la9K/49tV4sXGpq46eHQfDURHJ9vpGVXjdr/FJJCKiMeAy3TMnhm7Kd0xrJ
 xeqsQDrsxXOqMLjgb9uaj6AibVb0WFGf2Ms84636V0f/CItJ9TGQllGg5Ci
X-Received: by 2002:a17:903:41d0:b0:2ce:6d4a:5b8a with SMTP id
 d9443c01a7336-2cf34a4c2b5mr159212465ad.38.1784570778618; Mon, 20 Jul 2026
 11:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
 <20260713-rk3576-boost-v1-5-9d23aa08f674@flipper.net>
In-Reply-To: <20260713-rk3576-boost-v1-5-9d23aa08f674@flipper.net>
Date: Mon, 20 Jul 2026 12:05:10 -0600
X-Gm-Features: AUfX_mzpHeUs0x9aum6WXj3fQD3vvfWGIlIfUQNQzkasXQMAuvPHDrrQMx6e8i0
Message-ID: <CAFLszTh2jR8CH8MZWA3NiS51ita_-rGy_HYY761NSuM42cZuiA@mail.gmail.com>
Subject: Re: [PATCH 5/7] rockchip: mkimage: Add support for up to 4 input files
To: alchark@flipper.net
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784570778; x=1785175578; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=76kmUotF6DPoXNHQJXDHtGf+Ark9LTipzBvW3je0WkU=;
 b=aUjz3YhHK6oiSaKEcNR0nuJmx4EEdETZ6lAPo9JDmL7DwfLfnEyY9y7vQ2hNb1XA91
 kH+UD4Z/y649qVWgrlLO3GwVr38BuakwZNQddvZsmaLZ9TG97mv9rymY5UDNerDv5HdQ
 lHL9m2Z6lBgMyoHJbEF7I0ae/vX/R5UBafZp8=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=aUjz3YhH
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="aUjz3YhH";
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Simon Glass via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Simon Glass <sjg@chromium.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alexey,

On 2026-07-13T10:02:41, Alexey Charkov <alchark@flipper.net> wrote:
> rockchip: mkimage: Add support for up to 4 input files
>
> The v2 image format can support up to 4 embedded images that can be
> loaded by the BootROM using the back-to-bootrom method.
>
> Currently two input files can be passed in using the datafile parameter,
> separated by a colon (":").
>
> Extend the datafile parameter parsing to support up to 4 input files
> separated by a colon (":") for use with the v2 image format.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> tools/rkcommon.c | 93 +++++++++++++++++++++++++++-----------------------------
>  1 file changed, 44 insertions(+), 49 deletions(-)

> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> @@ -257,31 +255,32 @@ int rkcommon_check_params(struct image_tool_params *params)
> +     spl_params.images[0].file = params->datafile;
> +     for (i = 1; i < ARRAY_SIZE(spl_params.images); i++) {
> +             spl_params.images[i].file =
> +                             strchr(spl_params.images[i - 1].file, ':');
> +             if (!spl_params.images[i].file)
> +                     break;

If more than four files are passed, the loop stops splitting after the
fourth, so the remaining colon(s) stay in the last file name and the
subsequent open fails with a confusing message. Please can you detect
this case and print a clear error that at most 4 input files are
supported?

> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> @@ -750,16 +748,13 @@ err_close:
> +     for (i = 0; i < ARRAY_SIZE(spl_params.images); i++) {
> +             if (!spl_params.images[i].size)
> +                     break;
> +             ret = copy_file(params, ifd, spl_params.images[i].file,
> +                             spl_params.images[i].size);

This copies up to four images for both header versions, but for v1
rkcommon_set_header0() can only describe images[0] and images[1] via
init_size / init_boot_size, so a third or fourth file is written into
the output yet invisible to the BootROM. I suspect check_params should
reject more than two files when the format is not v2, rather than
silently producing a broken image. What do you think?

> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> @@ -662,8 +659,9 @@ int rkcommon_vrec_header(struct image_tool_params *params,
> +     params->orig_file_size = tparams->header_size;
> +     for (int i = 0; i < ARRAY_SIZE(spl_params.images); i++)
> +             params->orig_file_size += spl_params.images[i].size;

A small one: this declares the loop variable inside the for statement,
while rockchip_copy_image() in the same patch (and the rest of the
file) declares it at the top of the function, as U-Boot in general -
please move it.

Regards,
Simon

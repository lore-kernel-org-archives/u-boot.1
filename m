Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D3DC44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:05:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7FFE80D30;
	Mon, 20 Jul 2026 18:05:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3LPAqZHNgOYR; Mon, 20 Jul 2026 18:05:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E889080C04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784570759;
	bh=wlyEWGv44SYwyU07Vk2GE/b7Y3Kitujp0LVDwIZ71/c=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=jKr9SzaWqEtghcltcN7L46f/yBn/EhocOJGA0h0+pWo2LMAxwmOTOyeZgB7q0rq0u
	 raFcel/SapaLEebalcGh3NxMc5nainYyyu90qVE3XDrixCyxuZqR/jQ5KuU2m6z0Wi
	 h1YSxVNIx5UTDo5PG2z272y3ahViMaAdx060szoT1bbjO3h07FAybJxRXypHPsSEqj
	 6iSoubxUIG0gyET7bK5GHnp3RZcdoRGy4GzI4TXZnD2AK07pEXHFLhOJ42i2Q52j56
	 /25PWfOKWCgI+8bpHsA/MOHp2/JNwNYAs1KA6lg/x2ziJX6sMYTOJ+gUa2IkLcTOER
	 EvQ1OTC29rv7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E889080C04;
	Mon, 20 Jul 2026 18:05:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 05CF6224
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:05:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DFEE3606D6
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:05:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K1ZwaHmHb9qp for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:05:56 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 976F56060E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 976F56060E
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 976F56060E
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:05:55 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBC5B80433; Mon, 20 Jul 2026 20:05:53 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FBFC842FC
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:05:51 +0200 (CEST)
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2caea3f742bso125397735ad.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:05:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784570750; cv=none;
 d=google.com; s=arc-20260327;
 b=Pj5NQI/anrFoop6crXnJZVJMouvtuiXakV3NSTKQTgxm02C3tP2ly/56kWVi5ZOcLT
 QkgVoGkY7JDjRskEHKaqjYnSR3vxrjV2/fxaB3eV7IpP5ohpbnr16H4sL54OqblwDT+T
 yLQbsZcSPFcU0g0HxbpEsaYaPmtz62ltanDCqgMi+fhoA6OWHOIgn07WUnQnF8yJhCG2
 HOv05HI5IViH3Equi+z08HdzQAcFYFFFhc41HFVScUUJRv46ZlLbsHDfxJ3Tk2Spn5tB
 aPvhAXxgnt2iRuGeg4cER9b7D+ckBwC5t8ebRQ5vCdV6LZn2BYFSMC373Jfwr7ePFZ+3
 rYAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wlyEWGv44SYwyU07Vk2GE/b7Y3Kitujp0LVDwIZ71/c=;
 fh=3M+mieaR+CWw/x3pF/N4zwcSAHe4ijM5/L2oT7bBKro=;
 b=h7PF7EH1CHa1bzFCeTJL/cZTrxaUkm4iwrxZpGWMlykbHvBLXtf23JcNf+tdzgy7eh
 D5VBvyNTwGdpcjthKQ8gzaBZIbqy3AfJkAnCEdznKcpadqecS3djOyDoAzF+5tO3SNTR
 G+gQDKBb6BTnQBuc1jjE5CLVLTq3xH/1VKaNv9zBI9Ji4mZ18i90yh7FQOFU0FMC/NDr
 P6TAfqeD+Ez9Bp/VYUZgVSDZSCYih7N817RdD/JorFxZ7gkxc+wQQ+ZB54EwDJGk7eK3
 Hfm8Rxq8ocp7KUmT29A20FJ8uG/+4IuDJRJgMuYjeTwBfM2lf59TZiCYDFFiLdfvY1Ru
 ukHA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784570750; x=1785175550;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wlyEWGv44SYwyU07Vk2GE/b7Y3Kitujp0LVDwIZ71/c=;
 b=qNBWISey/JBjuQs35qZ528jKUez050Ye7p5bTAmGXvHnOS0LGL8kScAE0KH+dhsXCo
 5NtLPetv0IW+Um5YYyD8KDjwpBY7XtwqR5XJChCen9ih+WCypbFiR3R4Fnv0JjTK64So
 tEYg9hmlIOJ7MkTvJW5ehIW8aOaVceg1ZOrN8/3LRqfnKSVK5aWXXVvvVo+yZMr/23Ck
 5THPiYmvL++BD+L8f++cAwD9BcEUW5vEYQCqVorEq3koyDeUuV5YwAy2BrC+Atnewxv1
 6UnHf1KD60MDzL0G3BpbIl+ErUIclHyGXF08sv5i+zMnP36o0wwr/1v83KixcH19Vst3
 +Auw==
X-Gm-Message-State: AOJu0Yzx495ITLoOtByDXlE4eiF5qCYNgBPS7mSd+pkDAq6IblVygVRr
 LLSKO5+xNfoJCxmV4/wlrSveSQ6+XADswD6RvNeR4Jzs4WjqBNtLWxEgDiO46qufC7Avw4Y0LaD
 WMR0gmGfnf7PY6QIuSFZunK/3yulHPd01WszmViC9y0IKLQ8ROvo=
X-Gm-Gg: AR+sD12IGcO3ViPrliMF3fp8DHqIBN+dYI8cU9PY4QQbnaq7N4GCI48iZh5/VduHeAe
 oXEiXopHsFuSYjGwhWKi17yljFNUOQGv+pQL5pTRv+05TEf8mU9U84HbZdU1nkJrLBWH7E9cWkY
 xF5GuGxanMPC3uncQcHPMD0ayWyaSAnPFKVsHNGVNvRhK6KSN655vQ1uNXWJ8YvASRIa8jFkXME
 J/Hy7j3gXfqJTMRYh8S2KmW1S+KHzEbyDNEC9lM4swLp2tjsZ0zMjVtgJ+j
X-Received: by 2002:a17:903:3d0f:b0:2cf:477d:8a87 with SMTP id
 d9443c01a7336-2cf477d8f76mr125155315ad.10.1784570749710; Mon, 20 Jul 2026
 11:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
In-Reply-To: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
Date: Mon, 20 Jul 2026 12:05:24 -0600
X-Gm-Features: AUfX_myjvXKUbpn2VkaQAAcbKauJHkk25wl02eB7aQcWaDbzeUTPB8igV_nxyJg
Message-ID: <CAFLszTjJUueHHf6xeKgmLMzG8NLbW0BK9x4iZfCj9PiQjN6s8w@mail.gmail.com>
Subject: Re: [0/7] rockchip: fix boot from SDMMC on RK3576
To: alchark@flipper.net
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784570750; x=1785175550; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wlyEWGv44SYwyU07Vk2GE/b7Y3Kitujp0LVDwIZ71/c=;
 b=SMgeep7xHLlK/0zP/Ap0WEjEDs6wgCQBJ/D33LgE/VUkoEMoVYk4Pyg3CEGFNSpC9c
 KwR2rmd9PoVw06WohxcorI0QGtdC74pSpAu+gKpUJk5F+HB0ZL63qDoLxZnjBKPNLW7l
 o0DYSTRGMIGrqADIoZtycxAHOmM8LMBojhH1A=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=SMgeep7x
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="SMgeep7x";
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

> The preparatory patches for the image tools are submitted verbatim from
> Jonas' version, while the "boost" code doing the actual hotfix is
> converted from using a pre-built tiny binary to a from-source build using
> the existing U-Boot build system.

Thanks for picking this up - building the stub from source is the right
direction and the JTAG analysis of what the magic write actually does is
great.

I share Jonas' concern about the final patch baking a source-tree path
and SoC-specific load addresses into mkimage (more on that patch).
Since the image-packaging logic for Rockchip is already moving towards
binman, I suspect the right long-term home for this is a binman entry
type (or an extension of the existing mkimage etype) which passes the
stub and its parameters explicitly. Failing that, the stub path and
load addresses should at least be provided on the mkimage command line
so the tool stays generic. What do you think?

> Jonas Karlman (7):
>       rockchip: mkimage: Split size_and_off and size_and_nimage

This series reworks a lot of the image-layout logic in the tool (header
sizing, offset alignment, up to four embedded images) but there is no
test coverage for the Rockchip image format, so regressions in the
existing v1/v2 formats would go unnoticed. Please can you add some
tests, e.g. a pytest which builds images with one, two and four input
files and checks the listing output? The new -l output added in patches
2 and 3 makes this easy to do.

A note in doc/board/rockchip/rockchip.rst about the RK3576 SD-card
situation and the new stub would also be useful, since people currently
carrying the vendor boost blob will want to know it is no longer needed.

> This aims to upstream Jonas Karlman's long-standing patch series fixing
> the boot from SDMMC on RK3576

OK, looking forward to the two of you getting this landed!

Regards,
Simon

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908F4D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:17:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30754891A5;
	Fri, 18 Oct 2024 01:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vc+S38y+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FD638918D; Fri, 18 Oct 2024 01:12:16 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 600F98915B
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cbcc2bd800so12200626d6.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206731; x=1729811531; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jYckMBaqkhY1Bs15zXr2caEshYCnRthoP8ibTGRAGvc=;
 b=Vc+S38y+GBEVykXVm7YED2//Fq+WLoeP1CD3T3vDPN59Z0WW+fYFlgu9khvhGww7Tk
 T6i+x4HoBaeLWKB/U1NNAkhM931LjePKWHwWZyIHewILjt+2S4B3o8R3ddr33ttCpVIY
 3uw8uIKXFKcGstO2+HnRyezHRuvuLg8fsAZWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206731; x=1729811531;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jYckMBaqkhY1Bs15zXr2caEshYCnRthoP8ibTGRAGvc=;
 b=IJXZy883Hy0dNMihzXWb+a07+rmnl74MiLSR7+KaLieJZ2VmwXNnp8TEvFpUt19GuJ
 /jXFca5/ov9MSTv1122X6kEbyUNesRjx1x4LaCyNKMyBwYUbp3GHp+QX+ZQrhRAm2ySm
 t4qthoKk9vPsWAVOCfUIJpAbVEP0uQXrbSutsfoZs8OR5bwdi3StJXBpl0lbJNF9cuqH
 sDI4Dm1/OjLdfNZQFT3yuEjraXWDksC1xYXYYVLFF0xW/PZRt5qqzdVuEAxIJmxX7SX7
 OQsd54NdhpYJigWttpzSnfKfb5WmIwKPJOl5XQ1posgrIZjTshGzcGUz4BWjJbHOkcge
 JDow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZXQ1hmIPeAyADECl5kIfGfCPiVPM0H+las7qodm9Wt6RNk1OeLajeq8gHOFwASJYyNU3n7kQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwTPapO1CPOONfi5YPY3IANQF4Y6ruWkqKEDAHgPnnL7uy+Fhgo
 +QfD5mJ7aIL00hjmirH1APkS2SncnDFFQmDardlSVP6P2GeY79vWFMYFaGrHSs2129YG8BjAP4D
 Gunw115cbr+/yejTi9ZMaE3tQa+8GYDADiYPS
X-Google-Smtp-Source: AGHT+IHvy1RtBOT07FurjLR5W4OMEqX1xJGDU3BLOyLLJxlU/Y0LlDZqkGrvyllwsZxjFLwzsMk6Cg/UA3/2450f3M0=
X-Received: by 2002:ad4:5f4f:0:b0:6c3:6477:16e7 with SMTP id
 6a1803df08f44-6cc3785617dmr83841586d6.11.1729206731323; Thu, 17 Oct 2024
 16:12:11 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:12:11 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240828201355.1111764-1-sjg@chromium.org>
References: <20240828201355.1111764-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:12:11 -0700
X-Google-Sender-Auth: hbhlGcAGRO07-6B3t8ltGHt67uk
Message-ID: <CAFLszTgMqcKtoYNO7u5s_R5JGY5UyaEphF_=HAOkXwgom=LiAg@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: coreboot: Update the timestamp code to use
 sysinfo
To: Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Rather than using a special variable, get the timestamp info from the
coreboot sysinfo struct. Return a proper error as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/cpu/coreboot/timestamp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

Applied to u-boot-dm, thanks!

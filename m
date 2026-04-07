Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB7CFF5136
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 19:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20A9E840AB;
	Tue,  7 Apr 2026 21:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uuBw+EkX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83409840B0; Tue,  7 Apr 2026 21:50:12 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 665E283936
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 21:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-4233e152457so2174392fac.1
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 12:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775591409; x=1776196209; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HweqXEyzt23/5kQpdDFIbiAZToAavLe0+IL2HH6Hp58=;
 b=uuBw+EkXIK7wzpAnFdjtNpDoCkV2i24W5Qoewh5QUAFp7jtysI9prfZnZDkj2CYhoJ
 qBdFFHidOAe9RwoZ6ndK2Ap3gl/S87/yOW4W3EE7VR8V/GNPIBhuZmpM0cj4EBBOdMnt
 SspJ+hQ2VQh3vLX3OtpHT1lfSxq3ONjW0nSOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591409; x=1776196209;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HweqXEyzt23/5kQpdDFIbiAZToAavLe0+IL2HH6Hp58=;
 b=rMqZUl0MUM8PedJmbJyD9D6EYpVgNqBDYiqT+9x6qmle+3FvmJjbryADiSSJiOFtFm
 sAxcjtYqK9j4yRXIwFhsHcb71NNmyxui8PoWK9enjf7HmweA659DB5omgmMj5uels6It
 4/1GvjSCV2xc+P7vBRlI37hcoz608SjQsviSlbtttxvWK89OfjRh2mMCWQDzSgbzMW8H
 OXa6LK/qPZZHYuP+J/LkDUf37JG0Yi7Y7Es/ze+1vvS0h6sIOFGeDpTIcKMfInWFRcx2
 Xym8R/v/WgHRQJTOSvwoESmz8U91S+vkI10ikxZVmQ3pgZOkvuAeKJ0urqkENPE7wl/z
 DlKw==
X-Gm-Message-State: AOJu0Yzl6A6HZq234Q/hyZGwTkkpskb/revpAVGnIZx2Hf0BAAjJI+1e
 YShN59y4WEC5j8ldGpgSDMgbKXhGGxmEcqVqArzAmH+C/IEpy8AsoSWKhGAc6T4nNDltV7Zn3mv
 8jFAYVwM=
X-Gm-Gg: AeBDieucx3zik4LBBvuCihx+LHtyU83aXAg/1Qx8X3i9bF2pQ6Z8NeydCVLO0zXDyNs
 jmmaNtiQ0fvBOQ1YVQokZ9d3p9AY7L1r6YC2AAlx4TlEwiV+YgAYqegGcD/6idz88elMNXmkBrh
 VuWlSaTW53z9oHsYV7l2CUjvynPsVZauphi6Izb0PHncy4SrRZY3fV18vb0+OIO7yv7HMO15kan
 DGweeMo46LQfrGSCbec2nz07zvPIVaDsOiENlZ6BgWj6Np6VfHjSqmZnoMJTIvBxttVFUNvKwVS
 6euKc5N04SgCdeBYYaxsB+d8Mmetw5dkoyvO26sJdXtN56qruN9ciwLl03gBs7llgdnHxCboBg/
 jOQTvLg+PsTwKQ4Pxo62mg7sTmhS1z9o/Etgw/0j8oFjaM0AhCO1Hn/G+uw7+m8HQBf2LPMQS3H
 Dfhi42pbx3C0cNhVsjer471C3EmJFaDjYm+BqMnEc+ZQV1Nptak4oNSZ3wMA8H3MCGM4C/M7cJU
 dCst3YAzbPs9z42bfrPeIMqkAVNuchuKcso8re+JryOjTE=
X-Received: by 2002:a05:6870:b0cb:b0:41b:edc8:7b93 with SMTP id
 586e51a60fabf-4230f6af11fmr10375432fac.0.1775591409008; 
 Tue, 07 Apr 2026 12:50:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42324017960sm9988782fac.7.2026.04.07.12.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:50:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20260323083928.1928856-1-ravi@prevas.dk>
References: <20260323083928.1928856-1-ravi@prevas.dk>
Subject: Re: [PATCH] linker_lists.h: drop never used ll_start, ll_end
 macros
Message-Id: <177559140771.2108693.7716749819467992170.b4-ty@konsulko.com>
Date: Tue, 07 Apr 2026 13:50:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 23 Mar 2026 09:39:28 +0100, Rasmus Villemoes wrote:

> These macros have AFAICT never been used at all. It's also far from
> clear what purpose it could serve - for one thing, what _type would
> one pass, other than void perhaps? The example using "struct
> my_sub_cmd" seems misplaced, as how could one know that the first
> linker list consists of those, and moreover, how would one know how
> many there are?
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] linker_lists.h: drop never used ll_start, ll_end macros
      commit: e2138cf1e6088f12ffa874e87cc8f4b198378635
-- 
Tom



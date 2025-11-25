Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459CBD0E6C4
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 11:45:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CECA683FFE;
	Tue, 25 Nov 2025 12:45:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NRLosvqa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A76E184006; Tue, 25 Nov 2025 12:45:05 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87EB983FF4
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 12:45:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c6d699610cso1238281a34.0
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 03:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764071102; x=1764675902; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xrn3G/fI5sHU0R2CSEJYqytmCZs+LaLlFPi08RykG2E=;
 b=NRLosvqaTjhJ8NE3UvS78ayAUuaK29txR8zOwCu9KsrrEjVn54ZiwuaxG7Yq5xu/Df
 akTgjKL/3k0LM7mKUGyCl4HqltJ/zkWtUcG895WoIw1DDeG9GzFnK053Ji82l98C2nTF
 hu2hg34pABH9qpsj3MJK8X4ZMkVdVM13u83o4R8v4Nhbu5tYH0x9q/t+AL8ZkJCIYY9z
 1zrjoVnDCYMZSiV4iXdWQWiz5O3fCAhFHNNrLQn1Bj2+kiHxK5lmwFC0lFUJuOMP9t6x
 WFhhAqZSvL8G3msPuGORc441Gb+PS0o5/FCWokXIs3FnuUZbkvouu3F/d7enzSV3tzC5
 vSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764071102; x=1764675902;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xrn3G/fI5sHU0R2CSEJYqytmCZs+LaLlFPi08RykG2E=;
 b=fZ0VhGHeU6V5F+XkFFWqGJrjyI5ZZd0FyL1o8KNY6v8jI/urjcg/M7A01FxCitjTl1
 hQJzoUz5JGBKpLacgK1d6bgRIkKTrAI/7p87qFPAtw49ToRnf6/8Kb4jMCnnIn8p8m2Q
 gFaClzevlq8wGinKgIjRGKgXSHHyc3q4pGkNJFYy+OMQyxIk67UtObos/sZ7NJCyFW2Z
 UPMYZgP6ZNIdvh2glwvx4kItNLj2y2B7sJGcqL+lmgVCzVq7hHPixw97+hh+Xnz8xxZb
 YbBsVOWl0ee2Qsd4HcLz8nnhCXZwTi3SGsqY7NHriYur+rtt+akvpWY7BN13d1y36x3r
 Z2kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEhUwwP+rg1iPkb8eu30mRRkctHQTOn6ca/q/dPlV80o1bx/zApPsxSNWeNuqmNMw465n/jyE=@lists.denx.de
X-Gm-Message-State: AOJu0YzmfvKAT1baMn7I4ZjxeiSWDlilsd+Rdc7R6IHLHMe03OiqNDId
 VpbDqnQW/gjtfVaczWEx9lK2yMrXT3rJKfBqSYLEVTT4zMf/9jVczqWEkik2JjKKefCUWeYRNAg
 xPgxOGiP0O8sEdnFLBSdh0FOsNLxcHvSVo9S1FF0WYqJm
X-Gm-Gg: ASbGncvCdXV0KMZI3TQtAx046uS2oCJvSrqRK1oFjcRd7WRpqvDy0kUrVsNPFY2ZRXv
 Koedt1dreUw+wqOa8TEJW2Uw5f7/fbhct/kWTd5su+Pej0cdlYxvbJAB3rQMfIpqeUQEu23SSPb
 gyfwVFHoBgC52SA93xjKAj62aRAkPOPuJdzeQtivFijvjf2r9cw4D6CbivKA4AD3cfaVApGIVGH
 Fjo2co/1dZWc66aUsTJhCdjHqIvD8c9Cccy4cK8dMpBfRdoK1ug0B3wPLHeTQY1zKXNSA==
X-Google-Smtp-Source: AGHT+IHlUkfxMc9PTANqbPpeSlPx1YlO3RNF5TbmgV56rCkDPYrTuWMzPafDzVCC960e7ikTSjLKvMvjVqQUpWANysI=
X-Received: by 2002:a05:6830:901:b0:7c7:6cf2:b77 with SMTP id
 46e09a7af769-7c79908f825mr7374211a34.32.1764071102242; Tue, 25 Nov 2025
 03:45:02 -0800 (PST)
MIME-Version: 1.0
References: <20251115113118.783-1-briansune@gmail.com>
 <CAN7C2SCQQ62=e6FEVW=jrLSj8hoWjDxUWMjQGohrpaeYjY-W9w@mail.gmail.com>
 <27fc092f-36e5-4f20-b8b6-c25e529fbe2b@cherry.de>
 <CAN7C2SCCA9CV1rSEy1fosaE=EDE70LMOLcfTsVz4nvNMsH0mFg@mail.gmail.com>
 <62d063ff-7420-462a-ad51-a47a2e53c52a@cherry.de>
In-Reply-To: <62d063ff-7420-462a-ad51-a47a2e53c52a@cherry.de>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 25 Nov 2025 19:44:51 +0800
X-Gm-Features: AWmQ_bnz70rNkldbTMd2BcQrRB-0RR3nHzDEHRzu_IA7a9Ky-aufkJmxy5QyWhk
Message-ID: <CAN7C2SCODX0Xd+onkiaim0P78csxFdBDnWXP8ZK2eTL-pUHMfA@mail.gmail.com>
Subject: Re: [PATCH v1] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

> That's a bandage fix. It would be better to have some idea of what's
> going on. If this is possible, bisecting between a known working and
> broken commits would hopefully return the culprit and we can start
> making educated guesses from there. I also see no defconfig in upstream
> with TARGET_SOCFPGA_GEN5


I have found the actual issue now might be wrong.

default:

#
# Start-up hooks
#
# CONFIG_CYCLIC is not set

Normal:

CONFIG_CYCLIC=y
CONFIG_SPL_CYCLIC=y
CONFIG_CYCLIC_MAX_CPU_TIME_US=5000

I guess defcondig files are not sync to the latest SPL design?

Brian

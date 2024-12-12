Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEC5E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 14:41:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7705801BD;
	Thu, 12 Dec 2024 15:41:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="vqqhZNZC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0F0C801BD; Thu, 12 Dec 2024 15:41:04 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8FD9801A0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 15:41:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6e34339d41bso5376857b3.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 06:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1734014460; x=1734619260;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xfGp1UY/AMNNEnsk2FFLEzIVQn+v23RjKSfrkMCFz+A=;
 b=vqqhZNZC4hO2bGTnwenglMRpCy/vjkfVihR3X6uLWdpUQ/6DknKA8jlvAVVCMjzbeB
 Xlyshhpj5uZe6Nog4Q+hUuLCxf4YU1hCCf7osW7IVilNNVHZqyRewxsEF0jn9Fo5Wk3b
 Oo21e+WMpw1T5mZiGniyE3Faixn9KAoE347W2SGFW9oS/k485RtdsmHUCcbxpX3/I5Sx
 ePuWVLoYaLtX9mhx1sIQ3drZ8cFbPy5MyglsNebaaM91vz+2+MjfouNogIo1JRoMBQTl
 BlNTeb95RvFu+z5TRxAuDOVQGRRD8tkndvoAPr1rMBSG/3R/xp6lwmmMF1d64Suolnm8
 BVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734014460; x=1734619260;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xfGp1UY/AMNNEnsk2FFLEzIVQn+v23RjKSfrkMCFz+A=;
 b=wnQXS2dlA0/56vTpuepRrOfYq9eB/EM7Zg+2heRNOC4EGLCMf4d4y9s5EtWV0bieej
 oyh/kxGhPtoGZKzfhrk6AW8eQ8G4Zd02IXPH3msS9YDjkTHgmucAclQwwYUX/GFb1igq
 yDheQzHTMFdhEBfk3e6to7zN7Myk2XNq8Xytpi+ZW1VhGq1z4b1zsKlxzXNliPngTjRo
 QnV2yH3YtK7ndClqH+c+Q8revUJfwt9q/zq7bm49OvoTpOZasJIzo9I6NYUfgkH5WWxe
 b5+g2qVZS9xTtzA7whZ3Oe0c7sqP7ZGoUr5owNZPswkPlViC5z6JjOnPq447b8SPnJfT
 gjWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWItvol7nmQNfg/4CL1sDODdldEowMRjuctfTCiR5qXKVk/eIteocBrHpwdFfqwAw5f+nOMMJk=@lists.denx.de
X-Gm-Message-State: AOJu0YzjrY86t2yVRhh8xBhmcqB8PFE9ioR3GOXmWa4BjF0tKytFNyGn
 /LxCsdrQBfR5qS/YgXOsV3OeRixrpYMD7r+Qr3f1c6ByM4DO/VQxuBL54l/ylOR07kTFIiZDYNN
 5JGwDecO9Ej+BMpHIcMXHcdgQ6NnxPMjQ4J9G
X-Gm-Gg: ASbGnctqOyUp9ChOXNxDcKXxoCprqT1kUkz53dMqshz+EoGIC1QvRAMu1AdopK/KlUn
 lqAx+MimbpZbpx3qfOLxlwQR6T0PzrVGVzQtw6uk=
X-Google-Smtp-Source: AGHT+IEpyfJMTm0q0vnbyQCuu9zoIekfTQaWsEJC6xwjy1c+3gxoEam6HUr9GYEuP6oGaLoAqK5lSQo3St3UIWC81Bk=
X-Received: by 2002:a05:6902:2709:b0:e39:7a97:792a with SMTP id
 3f1490d57ef6-e41c8abdaaemr641157276.43.1734014460582; Thu, 12 Dec 2024
 06:41:00 -0800 (PST)
MIME-Version: 1.0
References: <20241211021703.2333-1-semen.protsenko@linaro.org>
In-Reply-To: <20241211021703.2333-1-semen.protsenko@linaro.org>
From: Michal Simek <monstr@monstr.eu>
Date: Thu, 12 Dec 2024 15:40:49 +0100
Message-ID: <CAHTX3dKpz9iGz=txVEf-c0mb-Tfr4PH5QMOyPy8VM8xrHg+L4g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] lmb: Fix reserving the same region multiple times
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Marek Vasut <marex@denx.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

st 11. 12. 2024 v 3:17 odes=C3=ADlatel Sam Protsenko
<semen.protsenko@linaro.org> napsal:
>
> This series is intended to be picked up for the v2025.01 release.
>
> Since commit 1d9aa4a283da ("lmb: Fix the allocation of overlapping
> memory areas with !LMB_NONE") the lmb_add_region_flags() returns -1 when
> the caller tries to add the already existing region with !LMB_NONE
> flags (it was returning 0 before that patch). That causes
> boot_fdt_reserve_region() function to print erroneous error messages
> when it's called consequently more than one time.
>
> Make lmb_add_region_flags() return -EEXIST when the already added region
> with !LMB_NONE flags is being added, and then check that error code in
> boot_fdt_reserve_region() to avoid printing the misleading error
> messages.
>
> This series fixes all 3 found cases (discussed at [1]) for the false
> positive error messages. All unit tests pass in sandbox U-Boot.
>
> Changes in v2:
>   - Split the original series by two separate series (cleanups will be
>     sent out as a different one)
>   - Collected all R-b and A-b tags from review
>   - Patch #1: Removed the check for exactly the same region, and return
>     -EEXIST in the branch handling overlapping regions instead
>   - Reworded the commit messages slightly
>
> [1] https://lists.denx.de/pipermail/u-boot/2024-December/574123.html
>
> Sam Protsenko (2):
>   lmb: Return -EEXIST in lmb_add_region_flags() if region already added
>   boot: fdt: Handle already reserved memory in boot_fdt_reserve_region()
>
>  boot/image-fdt.c |  2 +-
>  lib/lmb.c        | 26 +++++++++++++-------------
>  test/lib/lmb.c   |  2 +-
>  3 files changed, 15 insertions(+), 15 deletions(-)
>
> --
> 2.39.5
>

Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

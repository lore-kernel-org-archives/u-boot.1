Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F763C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 14:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6458480820;
	Fri,  7 Feb 2025 15:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FUgAbUku";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08CE580207; Fri,  7 Feb 2025 09:00:27 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 688728003E
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 09:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-721d213e2aeso531910a34.3
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 00:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738915223; x=1739520023; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LDD4yJkPmBZOCvjfWLYCrUGgPpkgJlxrxND2kfdGZCI=;
 b=FUgAbUkug/tFawlSfKpv7Vk0r7LwbhJeX9yaDYngLAc8XMkDLln609yC2ZyAfy44tW
 EWb1fsmIB+t/deHjvA2Jnu4JC4FVKOKqnvMG+gR6LJOnqvkgjSmu28DGbZD3bJlxn4a1
 Q3PTqDIAxA07GGZulKOP5aG9Xl9YEkPsN7xuJdbI6fC3F6PRlkaeLXV7Rd98kJ5B94SI
 yCoPkhvGNuXIap36lngRgtEnbV6rPUQ/cA8+W+YkW5pOJYOVugqLRcDUF5pl3qKn5c9I
 Rm2GO6dHebH3JbIUArhsQyWVO6glw+T7AXtXrQeMO2Qd4R+/lcbKzPK+BJHdo1vjoTr2
 /Qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738915223; x=1739520023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LDD4yJkPmBZOCvjfWLYCrUGgPpkgJlxrxND2kfdGZCI=;
 b=lQmnIIMPUoD6Db5SWhi2Syphf5VSmcwmdwy+nWHCpHHmBQfd0l3oLVL9IHfm/SrNgL
 ISmqr3kF+QfC137NPrP62wxsff9jLMafv9+jNRZ1im6pYoid3Xnf4dKvKCl9BCTHnsNx
 OHQsfzgTCy13Rr2Gm+Wx1Ftsuvx1/oe092PoXZDo0s6e4iTiVbLMvedfPI3qEvXRJzN9
 0zApwKm8w1P3ptUx9JUqWnqoZ2lb4n4KBtYUWILlpA4tk8Vu1N2EDo37YPIrLw0oSRQP
 DhfzNPZ90WQg9x1ocRY+b4pAEeFPvrWYRJ9Hv99Y/Kf56nEjMLNWtGVZDaeSsv7HV0Zy
 5r2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj0dK3T33asC6b30TN93IVyV/904q3s3I4gX3hGlcbEnN5Fe93z4r+cZngDb1Sii8RWlctavc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6jYzOUIddSFU8UkhqgW/PR52rTInkz9Vkg+hUaMJSQGXo13mJ
 4Q+01jpN5J/X+2AOw86rtqgi7A2GCLAjm1SJfhlN+jaxt2Zvg5WJcjFtuDZtTG7BcKzjgBFYm9j
 Dd9bbP8vQS8sf2osh0n8xxg93pSs=
X-Gm-Gg: ASbGnctxeQY6/UELABk1H9Wbo2b41V61/2+0mMRBXtlQfSC6P70+BMbhcHE/XZWRuXz
 oLf/Hp+d0Rm5HXFX71MOhiXsFONVy6YFXbPXdY5BQl7VYI8moRirKT0H0NFYmtMiOCCDZF6n/
X-Google-Smtp-Source: AGHT+IECFfQCU8AoKhk16ykjcCoo0rZMVvEYq0CShfchIevcQp0s45W81J50k9GRxxAMDUZcNukrSmJKzhkYwUcnIMI=
X-Received: by 2002:a05:6871:6aa:b0:29d:ca24:c044 with SMTP id
 586e51a60fabf-2b83eb4d220mr1416353fac.8.1738915222752; Fri, 07 Feb 2025
 00:00:22 -0800 (PST)
MIME-Version: 1.0
References: <20250116230130.3337-1-semen.protsenko@linaro.org>
In-Reply-To: <20250116230130.3337-1-semen.protsenko@linaro.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Fri, 7 Feb 2025 17:00:10 +0900
X-Gm-Features: AWEUYZkBJSt-u6tKApB0wlXtS-d1urKEapvtj7305RDaxv7ipRfdnfjSP2qrXcQ
Message-ID: <CALrBrZ0W1-5f71TAguofgw3j84rdEBCigc9aQc-d2GWbq4KZfQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] board: samsung: e850-96: Enable Standard Boot
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
X-Mailman-Approved-At: Fri, 07 Feb 2025 15:27:24 +0100
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On Fri, 17 Jan 2025 at 08:01, Sam Protsenko <semen.protsenko@linaro.org>
wrote:

> Make all necessary configuration and environment changes to enable
> Standard Boot on E850-96 board. Also rework LDFW firmware loading code
> to look for LDFW binary on EFI System Partition instead of dedicated
> 'ldfw' partition.
>
> Pending "[RFC PATCH 1/1] efi_loader: Call efi_init_early() even earlier"
> patch is needed to make EFI functional on E850-96, but this series does
> not depend on it and can be applied independently.
>
> [1] https://lists.denx.de/pipermail/u-boot/2025-January/577194.html
>
> Sam Protsenko (7):
>   configs: e850-96: Enable options for updated env
>   configs: e850-96: Enable U-Boot environment on eMMC
>   configs: e850-96: Enable more EFI features
>   configs: e850-96: Enable Standard Boot
>   board: samsung: e850-96: Load LDFW from EFI partition
>   board: samsung: e850-96: Report LDFW loading failures
>   board: samsung: e850-96: Provide bootstd default env
>
>  board/samsung/e850-96/e850-96.c   |  7 ++++-
>  board/samsung/e850-96/e850-96.env | 37 ++++++++-----------------
>  board/samsung/e850-96/fw.c        | 45 ++++++++++++++++++++++++++-----
>  configs/e850-96_defconfig         | 23 +++++++++++++---
>  4 files changed, 75 insertions(+), 37 deletions(-)
>
> --
> 2.39.5
>
>
applied to u-boot-samsung.

-- 
Thanks,
Minkyu Kang.

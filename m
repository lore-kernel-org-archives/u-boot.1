Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11A9C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE34088B5D;
	Thu, 15 Aug 2024 22:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KyjTp4Cs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 279608657F; Thu, 15 Aug 2024 22:32:54 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F048188BB8
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-70b2421471aso1019591a12.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753970; x=1724358770; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qANVMzgSC5eB3A5QKkNXsHHgXJ3UJ3QRRlGiJXm8MNs=;
 b=KyjTp4CsKgzYYOsvnAWsnDYoui7szF+aQ6m6W+BuLpMvkDYm/ug4KtFsfVk8LHoFEr
 1ikXzeMxB5YMO7hnFi6R6G+UJYkCMp76INY4EeZfy9KvjI0EKjGjKtUEUIQhywjeuLdl
 pgi6CC9/3aoVMg7ms2yvpG5drH+W/i0d02Ihg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753970; x=1724358770;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qANVMzgSC5eB3A5QKkNXsHHgXJ3UJ3QRRlGiJXm8MNs=;
 b=mx8phZK2LRidcUBqt6HXo5Wh1jqXGXcbkd+U849erZHqVlZ6iIR9M1TJoXYEStvluj
 8Dbrnq7BVa5e65YtTA0fpyTzZEZTBnxwS5MLfZPJ7RP/Qk1+UTKHEfOvaoC1PhWEm9QV
 i06TDMEN1kXergVsK+3E4OJynsQ2wPA5cWyA0SSf/ttUCyXAcnnRvTa5wBlv+3+p1NP+
 VLUcb9G5PSGi1Kgei/nbmD4Lzx0R74O15U4UjPO41ux6RQP0YJwSVguEAOGqfG0tcydX
 mOqmV+Eufmn5jhfoLh/NKrX/HLNyYidmfxCSagfULlxVo2N3i2Zb0jq9yq/PLvU8x/Ld
 Y+cg==
X-Gm-Message-State: AOJu0Yzqkj5hkZAe0U8OtRoSwQFesoj0pYydbflsuxiIW5F7pR6I1pAT
 0ArvjpNjejpeQeO1Iq8qL2X/WlCgSWHmBGppBQmn0ZPk3C5kTPKVgzfggF1JSVCRvmZkX0L7VIV
 LX30msOhpagqfkRpJOgUUWla8N9EkcyT7i6LH
X-Google-Smtp-Source: AGHT+IERc3mYM96OEPd2ZIaI2MjdsXtrfZvrGtFNvgGLjAnuYvnz8q1H7RpkShvzj2VL1oONw01XfgeENgi4Sb0Ir2g=
X-Received: by 2002:a17:90b:238d:b0:2c8:da73:af82 with SMTP id
 98e67ed59e1d1-2d3dfc6b665mr1017300a91.10.1723753969929; Thu, 15 Aug 2024
 13:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-31-sughosh.ganu@linaro.org>
In-Reply-To: <20240814110009.45310-31-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:32:39 +0100
Message-ID: <CAFLszTgythBDnSSE+bx=xZzp-UFkCASnU_Lo1m8X6F4aE31eyg@mail.gmail.com>
Subject: Re: [PATCH v2 30/32] sandbox: adjust load address of couple of tests
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Wed, 14 Aug 2024 at 05:03, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The TCG event log has now been moved to the start of the memory, and
> occupies 8KB of memory. Make a corresponding change to the load
> address in a couple of tests so that it does not overlap with the TCG
> event log.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: None
>
>  test/py/tests/test_android/test_abootimg.py | 2 +-
>  test/py/tests/test_vbe.py                   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

This is a pain...can we put the TCG high in memory for now, until I do
a patch to move it to the bloblist?

>
> diff --git a/test/py/tests/test_android/test_abootimg.py b/test/py/tests/test_android/test_abootimg.py
> index 6a8ff34538..bf6a19fe4f 100644
> --- a/test/py/tests/test_android/test_abootimg.py
> +++ b/test/py/tests/test_android/test_abootimg.py
> @@ -90,7 +90,7 @@ dtb_dump_resp="""## DTB area contents (concat format):
>            (DTB)model = x2
>       (DTB)compatible = y2,z2"""
>  # Address in RAM where to load the boot image ('abootimg' looks in $loadaddr)
> -loadaddr = 0x1000
> +loadaddr = 0x4000
>  # Address in RAM where to load the vendor boot image ('abootimg' looks in $vloadaddr)
>  vloadaddr= 0x10000
>  # Expected DTB #1 offset from the boot image start address
> diff --git a/test/py/tests/test_vbe.py b/test/py/tests/test_vbe.py
> index 50b6c1cd91..edeb655c6f 100644
> --- a/test/py/tests/test_vbe.py
> +++ b/test/py/tests/test_vbe.py
> @@ -97,7 +97,7 @@ def test_vbe(u_boot_console):
>      fdt_out = fit_util.make_fname(cons, 'fdt-out.dtb')
>
>      params = {
> -        'fit_addr' : 0x1000,
> +        'fit_addr' : 0x4000,
>
>          'kernel' : kernel,
>
> --
> 2.34.1
>

Regards,
Simon

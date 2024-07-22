Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1A6C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 11:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C8D387C86;
	Mon, 22 Jul 2024 13:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rW2Y7Wlk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A180882F9; Mon, 22 Jul 2024 13:24:59 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC1FA8789F
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 13:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70d2b921cd1so571475b3a.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 04:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721647494; x=1722252294; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6BqSKvbahvU7i4Pv5Ffi6WjL87MDa47kCP0MdV7E8BM=;
 b=rW2Y7WlkQu567NPgZuMbiNscbKbtUgyVrq4cyppq8mMz0IaR7jTVWQjEhFKf57iDxK
 lIiAjFRIIltHJpXsed0rvh1k+lylWQf+p2CIrvMmslQGf49NNnot0fsK5+729N32KNZ0
 gioa7ZHX4+1srgkK4ulrdNeRuFlPksf8mHdRDNn/CR/DdGCSCzfHOIbo8Wys/aeSpGOR
 IxxkVMfODy8ovW5t3qE+2ia5ttIE1lV0j8T1SGBgkz9a/65r0r9olvJT3tUQDLihkLBn
 nPAMhJV7y2xkhhy5h6XHOVenbHmK+Qq87bt+PfRc38kE13xJqdCMkQz4uQFOB/LrChgy
 Y8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721647494; x=1722252294;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6BqSKvbahvU7i4Pv5Ffi6WjL87MDa47kCP0MdV7E8BM=;
 b=D0mNABu8350DNKzqav7BKiw1VriLEQW70tnwSNtyYs2YAfe2D0SC4vCsy03+1LJZMQ
 XCpwNOutxdAc9DY608I4EqzzED+4qFOa7xxasYN8T5EzMQd4AqbiRrTg9EKE/8939K8T
 gZw6P3jdqlbtOgY8jFbz/1sOItinFpnVjS0scp2E+RPkI8nbbbh1x5bP79tK0ijw7vUc
 3UpsAsRa/YkK6E4qbdQgZrEd+ZrNcIYWzHxSlWdCvXWlxOTzZmauGp1vaOqiQPJXGijR
 zZzQ+CrpeeBhmIEK61HKj65IeJ5LGVdk6Wd1hnP+sURDWuyrNmS//ieKhomtpUTG3EK2
 SR+g==
X-Gm-Message-State: AOJu0YzLeeqggHEXFqBWnpwknZ1ysgg7gV8gzJtcuN7ipBfGnqFFkLml
 zG0C2yx+IdCro+XABWtru2Uj4NIZzpBmn7XohsHTEjCT/RrFbJ2ooTvm41o/hEely19A4JXTSZj
 autmaqj94GL6guDK3PGgXhJMBb42Vu4E9bbIdoQ==
X-Google-Smtp-Source: AGHT+IGw6xzP5tb97AsCQ9LCYFXR4G0vkRmDqfsAQRebT6YRY6kO0PCTDJTrFShK14nfVdPeHhPKl3D175jSuJGnNnw=
X-Received: by 2002:a05:6a20:841e:b0:1bd:2894:4015 with SMTP id
 adf61e73a8af0-1c422999ce3mr11409417637.50.1721647494243; Mon, 22 Jul 2024
 04:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-16-sughosh.ganu@linaro.org>
In-Reply-To: <20240704073544.670249-16-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 22 Jul 2024 14:24:17 +0300
Message-ID: <CAC_iWj+9gq-S0GWW1osqxYx43YuYj3JDDbi+R-U=8V5FDteWAw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 15/48] test: lmb: remove the test for max regions
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>, 
 Michal Simek <michal.simek@amd.com>
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

On Thu, 4 Jul 2024 at 10:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The LMB memory map is now persistent and global, and the
> CONFIG_LMB_USE_MAX_REGIONS config symbol has now been removed. Remove
> the corresponding lmb test case.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: New patch
>
>  test/lib/lmb.c | 67 --------------------------------------------------
>  1 file changed, 67 deletions(-)
>
> diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> index 9f6b5633a7..a3a7ad904c 100644
> --- a/test/lib/lmb.c
> +++ b/test/lib/lmb.c
> @@ -648,73 +648,6 @@ static int lib_test_lmb_get_free_size(struct unit_test_state *uts)
>  }
>  LIB_TEST(lib_test_lmb_get_free_size, 0);
>
> -#ifdef CONFIG_LMB_USE_MAX_REGIONS
> -static int lib_test_lmb_max_regions(struct unit_test_state *uts)
> -{
> -       const phys_addr_t ram = 0x00000000;
> -       /*
> -        * All of 32bit memory space will contain regions for this test, so
> -        * we need to scale ram_size (which in this case is the size of the lmb
> -        * region) to match.
> -        */
> -       const phys_size_t ram_size = ((0xFFFFFFFF >> CONFIG_LMB_MAX_REGIONS)
> -                       + 1) * CONFIG_LMB_MAX_REGIONS;
> -       const phys_size_t blk_size = 0x10000;
> -       phys_addr_t offset;
> -       int ret, i;
> -
> -       ut_asserteq(lmb.memory.cnt, 0);
> -       ut_asserteq(lmb.memory.max, CONFIG_LMB_MAX_REGIONS);
> -       ut_asserteq(lmb.reserved.cnt, 0);
> -       ut_asserteq(lmb.reserved.max, CONFIG_LMB_MAX_REGIONS);
> -
> -       /*  Add CONFIG_LMB_MAX_REGIONS memory regions */
> -       for (i = 0; i < CONFIG_LMB_MAX_REGIONS; i++) {
> -               offset = ram + 2 * i * ram_size;
> -               ret = lmb_add(offset, ram_size);
> -               ut_asserteq(ret, 0);
> -       }
> -       ut_asserteq(lmb.memory.cnt, CONFIG_LMB_MAX_REGIONS);
> -       ut_asserteq(lmb.reserved.cnt, 0);
> -
> -       /*  error for the (CONFIG_LMB_MAX_REGIONS + 1) memory regions */
> -       offset = ram + 2 * (CONFIG_LMB_MAX_REGIONS + 1) * ram_size;
> -       ret = lmb_add(offset, ram_size);
> -       ut_asserteq(ret, -1);
> -
> -       ut_asserteq(lmb.memory.cnt, CONFIG_LMB_MAX_REGIONS);
> -       ut_asserteq(lmb.reserved.cnt, 0);
> -
> -       /*  reserve CONFIG_LMB_MAX_REGIONS regions */
> -       for (i = 0; i < CONFIG_LMB_MAX_REGIONS; i++) {
> -               offset = ram + 2 * i * blk_size;
> -               ret = lmb_reserve(offset, blk_size);
> -               ut_asserteq(ret, 0);
> -       }
> -
> -       ut_asserteq(lmb.memory.cnt, CONFIG_LMB_MAX_REGIONS);
> -       ut_asserteq(lmb.reserved.cnt, CONFIG_LMB_MAX_REGIONS);
> -
> -       /*  error for the 9th reserved blocks */
> -       offset = ram + 2 * (CONFIG_LMB_MAX_REGIONS + 1) * blk_size;
> -       ret = lmb_reserve(offset, blk_size);
> -       ut_asserteq(ret, -1);
> -
> -       ut_asserteq(lmb.memory.cnt, CONFIG_LMB_MAX_REGIONS);
> -       ut_asserteq(lmb.reserved.cnt, CONFIG_LMB_MAX_REGIONS);
> -
> -       /*  check each regions */
> -       for (i = 0; i < CONFIG_LMB_MAX_REGIONS; i++)
> -               ut_asserteq(lmb.memory.region[i].base, ram + 2 * i * ram_size);
> -
> -       for (i = 0; i < CONFIG_LMB_MAX_REGIONS; i++)
> -               ut_asserteq(lmb.reserved.region[i].base, ram + 2 * i * blk_size);
> -
> -       return 0;
> -}
> -LIB_TEST(lib_test_lmb_max_regions, 0);
> -#endif
> -
>  static int lib_test_lmb_flags(struct unit_test_state *uts)
>  {
>         const phys_addr_t ram = 0x40000000;
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

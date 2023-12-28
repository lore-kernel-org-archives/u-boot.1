Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A35EC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 10:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66F5F87960;
	Thu, 28 Dec 2023 11:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CwVJPPvC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDDC4879C9; Thu, 28 Dec 2023 11:20:30 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5F2387946
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 11:20:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50e7b273352so2720053e87.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 02:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703758827; x=1704363627; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wk7CQK3uW/xYXJtfTG9Va7rSylvrgAU1C+pkpml6Lcc=;
 b=CwVJPPvCZzTQR0stkIbLUTYTBLlo5wZSeJTqbimZtIplh1w23f4waWr92BFk/gZHR9
 6yeEhBz56U33aEDY51uvwXeU59APQgvkMM8xmiolV894hAgrQAxObORLfoMKRjcbmkZq
 MWKAaOQk9gAiHJ0X7WV66SXWzmJxNfXJdwHCAecF4m4GEdoizgCh4peSws3LcmnNc6cb
 6GuG0CxQ1lmnYQNJPywPf6/hMf4OAZpcJG/YoFT8SExxhlU4dIF/F/S2nHtGVAJzI35V
 QYA3gQGJJVsRpvKqITWj3BLpbX9WRgzEDQoebZVV8wiwnGbKmEsZgJE9aQoHjQ+cUAP5
 GYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703758827; x=1704363627;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wk7CQK3uW/xYXJtfTG9Va7rSylvrgAU1C+pkpml6Lcc=;
 b=cNvgV3MUIt8BdpyeKrX6yljkJjqB84JkNlTfuouAMOjkz2MB4CYmzaUwx22/0GpNpE
 tFgTSUocPh21n48yqt2TParhCvphmlOp/xeCN1wlVbuyZqL4VAv1zRwrTX/6W57eP2J5
 awm+YGs7FWH1P0dxYFE7IRwd3mhIaWHT+HTZGmXhxzqkFHCQ0G33SbR/j4AWm8IHePLk
 hvidhaUG1GYWGGK7F4c6ZwKGsxreu1yYDkh/jP2AZIJKqjvdwYKTHaCdzEZnWmricv5/
 GnrrKqHAEYMqxdbzQqQSTHFhB+6QUKnm0ug/96zFOrgmYWN/F1tFvCQ5ePW2HV6u22r/
 W4+w==
X-Gm-Message-State: AOJu0YyVr/zIm08bGhLKbupAvyV3yutPY0niOUT7ttGJoqELaOYESMWi
 ulnLSxRQFihmAF8I0PXOuoY3cQrFCBODzUz6MA8UvNiMZEsAGA==
X-Google-Smtp-Source: AGHT+IGTPO8wTzkZuc/08ismRYVxzj+UdKl6VtYP5LqGQ/3K74ZjDB7LhaqDKQ21D/8sPXG1kHkm5jPkyEiByvLIST4=
X-Received: by 2002:a05:6512:696:b0:50e:7e29:b0e9 with SMTP id
 t22-20020a056512069600b0050e7e29b0e9mr2509141lfe.73.1703758826956; Thu, 28
 Dec 2023 02:20:26 -0800 (PST)
MIME-Version: 1.0
References: <20231227210712.712937-1-raymond.mao@linaro.org>
 <20231227210712.712937-8-raymond.mao@linaro.org>
In-Reply-To: <20231227210712.712937-8-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Dec 2023 12:19:51 +0200
Message-ID: <CAC_iWj+FqqoORXp9T=+qjGcYyTEWFy3t72_Jc2oQdNo-tUbqGg@mail.gmail.com>
Subject: Re: [PATCH v4 07/12] bloblist: Checksum the entire bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
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

On Wed, 27 Dec 2023 at 23:08, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> Use a sinple 8-bit checksum for bloblist, as specified by the spec
> version 0.9.
> Spec v0.9 specifies that the entire bloblist area is checksummed,
> including unused portions. Update the code to follow this.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v4
> - Patch #7 and #8 from v3 are squashed into this patch.
>
>  common/bloblist.c  | 13 ++++---------
>  include/bloblist.h |  5 ++---
>  test/bloblist.c    | 10 ++++++++--
>  3 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 88e2a0f5c0..705d9c6ae9 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -13,6 +13,7 @@
>  #include <malloc.h>
>  #include <mapmem.h>
>  #include <spl.h>
> +#include <tables_csum.h>
>  #include <asm/global_data.h>
>  #include <u-boot/crc.h>
>
> @@ -318,16 +319,10 @@ int bloblist_resize(uint tag, int new_size)
>
>  static u32 bloblist_calc_chksum(struct bloblist_hdr *hdr)
>  {
> -       struct bloblist_rec *rec;
> -       u32 chksum;
> +       u8 chksum;
>
> -       chksum = crc32(0, (unsigned char *)hdr,
> -                      offsetof(struct bloblist_hdr, chksum));
> -       foreach_rec(rec, hdr) {
> -               chksum = crc32(chksum, (void *)rec, rec_hdr_size(rec));
> -               chksum = crc32(chksum, (void *)rec + rec_hdr_size(rec),
> -                              rec->size);
> -       }
> +       chksum = table_compute_checksum(hdr, hdr->alloced);
> +       chksum += hdr->chksum;
>
>         return chksum;
>  }
> diff --git a/include/bloblist.h b/include/bloblist.h
> index 68f97395b7..d2dcad69a1 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -174,11 +174,10 @@ enum bloblist_tag_t {
>   *     sizeof(bloblist_hdr) since we need at least that much space to store a
>   *     valid bloblist
>   * @spare: Spare space (for future use)
> - * @chksum: CRC32 for the entire bloblist allocated area. Since any of the
> + * @chksum: checksum for the entire bloblist allocated area. Since any of the
>   *     blobs can be altered after being created, this checksum is only valid
>   *     when the bloblist is finalised before jumping to the next stage of boot.
> - *     Note that chksum is last to make it easier to exclude it from the
> - *     checksum calculation.
> + *     This is the value needed to make all checksummed bytes sum to 0
>   */
>  struct bloblist_hdr {
>         u32 magic;
> diff --git a/test/bloblist.c b/test/bloblist.c
> index 8b435e27ca..49ac4b92ae 100644
> --- a/test/bloblist.c
> +++ b/test/bloblist.c
> @@ -237,12 +237,18 @@ static int bloblist_test_checksum(struct unit_test_state *uts)
>         *data2 -= 1;
>
>         /*
> -        * Changing data outside the range of valid data should not affect
> -        * the checksum.
> +        * Changing data outside the range of valid data should affect the
> +        * checksum.
>          */
>         ut_assertok(bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
>         data[TEST_SIZE]++;
> +       ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
> +       data[TEST_SIZE]--;
> +       ut_assertok(bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
> +
>         data2[TEST_SIZE2]++;
> +       ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
> +       data[TEST_SIZE]--;
>         ut_assertok(bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
>
>         return 0;
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

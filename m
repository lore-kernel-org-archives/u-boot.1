Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB03C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 10:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2DA388A7F;
	Thu,  8 Aug 2024 12:15:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gskl8xgu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89CAD88A93; Thu,  8 Aug 2024 12:15:56 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F1D288A7D
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 12:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-260f81f7fb5so474313fac.0
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 03:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723112152; x=1723716952; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VDt+SDNJW/Xz1XXHlMwx92DA6WMt7jfYVMA09I+TBjs=;
 b=gskl8xguyXctO6zH9hfiASUcPF4taitiJoc1A2p6IZfHaMwDdHYRDwtbG1BizaFBy4
 T9yJLuLsRak70xZwEv8Wi3110CqK5ibRWXV4N44NFFRjxVn4vIMrlMPLAsJtsWHgBMFO
 XzOjX7krIfeFPkU9d1b28KNi6UmMen+GZikx8i0GGQdgbRwEvpF3K68NOh3VL1t7Ft1v
 xGQ5n8Mz07Zg/WnO9QYSTioNBKzXGBmDJObLReOepHReuhtkwWOQQJ5tiFp0AIKDi4CP
 CwORFRUWQlL9gHVK4FT4w+pJJZiPFUJb1P3Jvy4dAHNpwa1cKpYkDZ1mRRv9fU5eP+WU
 NrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723112152; x=1723716952;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VDt+SDNJW/Xz1XXHlMwx92DA6WMt7jfYVMA09I+TBjs=;
 b=mViYOPS2Fl3bcp8krXSidOW4TNBBuAl0QY/DTiYb2C/OHiyswD/xZ3A+faU2byn/9q
 98Gyst7prJwoB7tGFfVAAddAlzKrQfixK5IHBttOrEUGO0IQ2sV9LlTZp5HmOrwqevKw
 yImGLgIXrxikoAlVohFSNRxVwqO2Ynp/f0jWMZd4iqi15GBl4Lx/7p9l1FO6Jsiyr7PE
 xiLVlnZ5jihS7IH2z6Erq5k/9SsZ94L5dCewrVvIOV/sEW/bhGs1VODqQufJrkw8aCQo
 bMZoAh05scL8MM3GtFzKN82W5ONkg2IlNXnhmCTxfbMETqAlJVZuHbdq/Llx6Cd5YhZr
 3MsA==
X-Gm-Message-State: AOJu0Yz76iYlxDyf28w6v4oeJsJew5eCcCvQ9xkKnMLjPc1bl25lmIvO
 6VtDBmj1ej+PV1AizDf6ReriSJVT5J7P3o47SQO2Ygjxev2FwmCNOVhX+igGbLoQJGULBnVuoHa
 n3skjjzGxcRQ8e4CmlSGmlBO3mYYM+Zx3GYrkdg==
X-Google-Smtp-Source: AGHT+IF1pYZqdTBtqMt6Ydt96eWwYuyc3W+xWkSQqswkrv94laneGPpkQ51pg94ruGJr2AIfAanVtjJu+3nq2i8Lv6w=
X-Received: by 2002:a05:6870:51ca:b0:260:f5ab:62ff with SMTP id
 586e51a60fabf-2692b7ee3afmr1308624fac.44.1723112152340; Thu, 08 Aug 2024
 03:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-23-sjg@chromium.org>
In-Reply-To: <20240806125850.2316956-23-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 8 Aug 2024 13:15:16 +0300
Message-ID: <CAC_iWjL4eEwhE4=aernD_HQzUJJbN=E3qWq9OcDBvSG6tycDLA@mail.gmail.com>
Subject: Re: [PATCH v2 22/39] test: mbr: Use a constant for the block size
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alexander Gendin <agendin@matrox.com>
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

Hi Simon

On Tue, 6 Aug 2024 at 15:59, Simon Glass <sjg@chromium.org> wrote:
>
> It isn't that important to factor out constants in tests, but in this
> case we have 0x200 and 512 used. The commands don't use the constant
> as they use a block count ('1'). It doesn't create more code to use a
> constant, so create one.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  test/cmd/mbr.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
> index 8a4d61b2928..bab92c3ba00 100644
> --- a/test/cmd/mbr.c
> +++ b/test/cmd/mbr.c
> @@ -18,6 +18,9 @@
>  #include <test/ut.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
> +
> +#define BLKSZ  0x200   /* block size */

We already have definitions for that. I prefer SZ_512

Thanks
/Ilias
> +
>  /*
>   * Requirements for running test manually:
>   * mmc6.img - File size needs to be at least 12 MiB
> @@ -228,7 +231,7 @@ static unsigned build_mbr_parts(char *buf, size_t buf_size, unsigned num_parts)
>  static int mbr_test_run(struct unit_test_state *uts)
>  {
>         struct blk_desc *mmc_dev_desc;
> -       unsigned char mbr_wbuf[512], ebr_wbuf[512], rbuf[512];
> +       unsigned char mbr_wbuf[BLKSZ], ebr_wbuf[BLKSZ], rbuf[BLKSZ];
>         char mbr_parts_buf[256];
>         ulong mbr_wa, ebr_wa, ra, ebr_blk, mbr_parts_max;
>         struct udevice *dev;
> @@ -257,7 +260,7 @@ static int mbr_test_run(struct unit_test_state *uts)
>         mbr_wa = map_to_sysmem(mbr_wbuf);
>         ebr_wa = map_to_sysmem(ebr_wbuf);
>         ra = map_to_sysmem(rbuf);
> -       ebr_blk = (ulong)0xb00000 / 0x200;
> +       ebr_blk = (ulong)0xb00000 / BLKSZ;
>
>         /* Make sure mmc6 exists */
>         ut_asserteq(6, blk_get_device_by_str("mmc", "6", &mmc_dev_desc));
> @@ -269,7 +272,7 @@ static int mbr_test_run(struct unit_test_state *uts)
>
>         /* Make sure mmc6 is 12+ MiB in size */
>         ut_assertok(run_commandf("mmc read %lx %lx 1", ra,
> -                                (ulong)0xbffe00 / 0x200));
> +                                (ulong)0xbffe00 / BLKSZ));
>
>         /* Test one MBR partition */
>         init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
> @@ -277,11 +280,11 @@ static int mbr_test_run(struct unit_test_state *uts)
>         ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
>         memset(rbuf, 0, sizeof(rbuf));
>         ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
> -       ut_assertok(memcmp(mbr_wbuf, rbuf, 512));
> +       ut_assertok(memcmp(mbr_wbuf, rbuf, BLKSZ));
>         ut_assertok(run_commandf("write mmc 6:0 %lx %lx 1", ebr_wa, ebr_blk));
>         memset(rbuf, 0, sizeof(rbuf));
>         ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
> -       ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
> +       ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
>         ut_assertok(console_record_reset_enable());
>         ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
>         ut_assertok(run_commandf("mbr write mmc 6"));
> @@ -290,7 +293,7 @@ static int mbr_test_run(struct unit_test_state *uts)
>         ut_assert_nextline("MBR: verify success!");
>         memset(rbuf, 0, sizeof(rbuf));
>         ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
> -       ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
> +       ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
>         ut_assertok(ut_check_console_end(uts));
>         /*
>         000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
> @@ -313,11 +316,11 @@ static int mbr_test_run(struct unit_test_state *uts)
>         ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
>         memset(rbuf, 0, sizeof(rbuf));
>         ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
> -       ut_assertok(memcmp(mbr_wbuf, rbuf, 512));
> +       ut_assertok(memcmp(mbr_wbuf, rbuf, BLKSZ));
>         ut_assertok(run_commandf("write mmc 6:0 %lx %lx 1", ebr_wa, ebr_blk));
>         memset(rbuf, 0, sizeof(rbuf));
>         ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
> -       ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
> +       ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
>         ut_assertok(console_record_reset_enable());
>         ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
>         ut_assertok(run_commandf("mbr write mmc 6"));
> @@ -326,7 +329,7 @@ static int mbr_test_run(struct unit_test_state *uts)
>         ut_assert_nextline("MBR: verify success!");
>         memset(rbuf, 0, sizeof(rbuf));
>         ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
> -       ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
> +       ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
>         ut_assertok(ut_check_console_end(uts));
>         /*
>         000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
> @@ -349,11 +352,11 @@ static int mbr_test_run(struct unit_test_state *uts)
>         ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
>         memset(rbuf, 0, sizeof(rbuf));
>         ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
> -       ut_assertok(memcmp(mbr_wbuf, rbuf, 512));
> +       ut_assertok(memcmp(mbr_wbuf, rbuf, BLKSZ));
>         ut_assertok(run_commandf("write mmc 6:0 %lx %lx 1", ebr_wa, ebr_blk));
>         memset(rbuf, 0, sizeof(rbuf));
>         ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
> -       ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
> +       ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
>         ut_assertok(console_record_reset_enable());
>         ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
>         ut_assertok(run_commandf("mbr write mmc 6"));
> @@ -362,7 +365,7 @@ static int mbr_test_run(struct unit_test_state *uts)
>         ut_assert_nextline("MBR: verify success!");
>         memset(rbuf, 0, sizeof(rbuf));
>         ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
> -       ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
> +       ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
>         ut_assertok(ut_check_console_end(uts));
>         /*
>         000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
> @@ -385,11 +388,11 @@ static int mbr_test_run(struct unit_test_state *uts)
>         ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
>         memset(rbuf, 0, sizeof(rbuf));
>         ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
> -       ut_assertok(memcmp(mbr_wbuf, rbuf, 512));
> +       ut_assertok(memcmp(mbr_wbuf, rbuf, BLKSZ));
>         ut_assertok(run_commandf("write mmc 6:0 %lx %lx 1", ebr_wa, ebr_blk));
>         memset(rbuf, 0, sizeof(rbuf));
>         ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
> -       ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
> +       ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
>         ut_assertok(console_record_reset_enable());
>         ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
>         ut_assertok(run_commandf("mbr write mmc 6"));
> @@ -398,7 +401,7 @@ static int mbr_test_run(struct unit_test_state *uts)
>         ut_assert_nextline("MBR: verify success!");
>         memset(rbuf, 0, sizeof(rbuf));
>         ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
> -       ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
> +       ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
>         ut_assertok(ut_check_console_end(uts));
>         /*
>         000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
> @@ -421,11 +424,11 @@ static int mbr_test_run(struct unit_test_state *uts)
>         ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
>         memset(rbuf, 0, sizeof(rbuf));
>         ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
> -       ut_assertok(memcmp(mbr_wbuf, rbuf, 512));
> +       ut_assertok(memcmp(mbr_wbuf, rbuf, BLKSZ));
>         ut_assertok(run_commandf("write mmc 6:0 %lx %lx 1", ebr_wa, ebr_blk));
>         memset(rbuf, 0, sizeof(rbuf));
>         ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
> -       ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
> +       ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
>         ut_assertok(console_record_reset_enable());
>         ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
>         ut_assertf(0 == run_commandf("mbr write mmc 6"), "Invalid partitions string: %s\n", mbr_parts_buf);
> --
> 2.34.1
>

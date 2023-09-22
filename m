Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0D6CD484C
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 18:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 974FC86B40;
	Fri, 22 Sep 2023 20:29:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LlsvKOLG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31C6C86AFE; Fri, 22 Sep 2023 20:29:05 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7EF386B37
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 20:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d84acd6dbb1so4193003276.1
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695407341; x=1696012141; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PnMOYXCXLo77a5ZezYcivMY/epllcCPjYBW5aqFvMDk=;
 b=LlsvKOLGXtzjcdNLXVm5icKqjROO1aygl96o2tj3O3jGwtncIExQph4tI8koYEFK0m
 tHEds410giY9h8WtKiYQg1Yh0CgKseLnkX1yu8Y8HKuMgyJBO3iLnB8uUbtO0dPfOfGd
 qvfijEa1BC9rhwIpvhAzwXAvkt9isXzqz6qsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695407341; x=1696012141;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PnMOYXCXLo77a5ZezYcivMY/epllcCPjYBW5aqFvMDk=;
 b=AK1NNsDGJCUGY1oi3YMShYlWzWjRIJ8bn+dAPxB4NN7sBHDFZxtU2lZYsqbEQ3iV1w
 eIohQYW6TWfjjuj/eYEPlnMC/y6PRARIph+XKFAP8EzYcbu4CcphAUrCl/UqjlsTHguM
 JwiysYl7s9vn0Uy6e7GiRTYhlsp6PgUTiRn/Zm3Lm3hXcNxVzs4cTyy0NviZmsGdVBWL
 eYHnu2QGa3JncyJQpdvqFoCts9gZ7YDYMibeX5AXUPe65WnbdgHHbFk613x89syq0APV
 CHojJ4/d7inkz38DdeKb+RSgxz/AEWhZxeJfkYh6TjsWr8Bj/k1Mhrxo0lLyVuToVtBO
 zZiQ==
X-Gm-Message-State: AOJu0YyQyADRdfDM6vjC1ydmCQF/BjPiFuCXc/rO3DMCgJ4oHlm42aSB
 hiOuBP81u67K+dUxNYP0qB4Zj7Cnel6A4YKL/4PS0w==
X-Google-Smtp-Source: AGHT+IH0dB63MTnL0kB0cWX8G3PDIIFur/g3rc7zwjtScR+0xblr/oqHUNaPNXFTjVNxa+OYWiDzKKffwAPFo1PuXS4=
X-Received: by 2002:a25:db05:0:b0:d81:5cbb:689e with SMTP id
 g5-20020a25db05000000b00d815cbb689emr2590795ybf.21.1695407341309; Fri, 22 Sep
 2023 11:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
 <20230920225811.153474-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230920225811.153474-8-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 12:27:34 -0600
Message-ID: <CAPnjgZ2pZ0TOgU8bQzOazU2x3kVLKBhjxu-RLE9FHzZAfG_=ow@mail.gmail.com>
Subject: Re: [PATCH 8/9] test: bdinfo: Test bdinfo -m
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>, 
 Mario Six <mario.six@gdsys.cc>, Nikhil M Jain <n-jain1@ti.com>
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

On Wed, 20 Sept 2023 at 16:58, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> The bdinfo -m should print only the board memory layout.
> Test the expected output.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Nikhil M Jain <n-jain1@ti.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  test/cmd/bdinfo.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
> index 2f34d877e5c..f090667fb42 100644
> --- a/test/cmd/bdinfo.c
> +++ b/test/cmd/bdinfo.c
> @@ -130,13 +130,11 @@ static int lmb_test_dump_all(struct unit_test_state *uts, struct lmb *lmb)
>         return 0;
>  }
>
> -static int bdinfo_test_all(struct unit_test_state *uts)
> +static int bdinfo_test_mem(struct unit_test_state *uts)

Since this is not a standalone test now, I think the word 'check' is
better than test. I try to reserve ''test' for a top-level test that
can be run.

>  {
>         struct bd_info *bd = gd->bd;
>         int i;
>
> -       ut_assertok(test_num_l(uts, "boot_params", 0));
> -
>         for (i = 0; i < CONFIG_NR_DRAM_BANKS; ++i) {
>                 if (bd->bi_dram[i].size) {
>                         ut_assertok(test_num_l(uts, "DRAM bank", i));
> @@ -147,6 +145,15 @@ static int bdinfo_test_all(struct unit_test_state *uts)
>                 }
>         }
>
> +       return 0;
> +}
> +
> +static int bdinfo_test_all(struct unit_test_state *uts)
> +{
> +       ut_assertok(test_num_l(uts, "boot_params", 0));
> +
> +       ut_assertok(bdinfo_test_mem(uts));
> +
>         /* CONFIG_SYS_HAS_SRAM testing not supported */
>         ut_assertok(test_num_l(uts, "flashstart", 0));
>         ut_assertok(test_num_l(uts, "flashsize", 0));
> @@ -243,6 +250,19 @@ static int bdinfo_test_help(struct unit_test_state *uts)
>
>  BDINFO_TEST(bdinfo_test_help, UT_TESTF_CONSOLE_REC);
>
> +static int bdinfo_test_memory(struct unit_test_state *uts)
> +{
> +       /* Test BDINFO memory layout only print */
> +       ut_assertok(console_record_reset_enable());
> +       ut_assertok(run_commandf("bdinfo -m"));
> +       ut_assertok(bdinfo_test_mem(uts));
> +       ut_assertok(ut_check_console_end(uts));
> +
> +       return 0;
> +}
> +
> +BDINFO_TEST(bdinfo_test_memory, UT_TESTF_CONSOLE_REC);
> +
>  int do_ut_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  {
>         struct unit_test *tests = UNIT_TEST_SUITE_START(bdinfo_test);
> --
> 2.40.1
>

Regards,
Simon

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066DC109192A
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 22:09:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B40884008;
	Thu, 19 Mar 2026 23:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bLzgObK3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9728183FF5; Thu, 19 Mar 2026 23:09:21 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0D5783FF5
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 23:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b9795ca4e6dso174183266b.2
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 15:09:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773958159; cv=none;
 d=google.com; s=arc-20240605;
 b=II+fVOvMiheH8/o8weOxqiNdXMDIse3HX3ImQXOw3nUX76bMJnOrD0LwSNM7O/Wb6A
 qUKgF/v+DDWnYyolo0WkvzaRPnAav8cpgXVI5TT+ttru8JFjK1ZaIU3himOFjuu3Tb8X
 wrOfJN+PlsqqeklaYH1I2kLAWEjTG7+WNRa2I83uEBCVtg4Cw9FRJxiPaUWz586Yl3mY
 Z0hxZzHlr0LjEJw4cXendVlYUc2MxDoTwb73cRSoJls7f1e4/vHad26T4ba+Cwq8M8hI
 gXyIgDdbYz/A8j0vXakfk087u4AKxm6JnvkCd7AJsW1kV0c1Dsh3FeLlIYQoiYHXxg+j
 2T8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xHTNhQprnxfVBU95i3jTbBSgDx/Au2zJ/BjH5xatp7U=;
 fh=e9kas99NLc6oCzp9c+m5GZrXy2MmkVdQq4dho8NMlnk=;
 b=dllBxYmbdgZ8ThtcgpgNue0TwF7Dm804Qtp+hH+MhDXWN1efUG9GOMgJLjZ7yuQdne
 aMwH9zw/EDoT2LMba1TFvtl9h9cWGNlsBT0egXmZw/8tFr4hurcsgb6BR8hq6T18tOW6
 xG1Am5ybJbKsmxfPXCzQGzUzAEF1j5zhoGrbROw9ca16CFajvO/PSSwT4O22KTChAQ1l
 B9koYG5AYY5lr95+o/Sf13x0MNpVRA1RPUEF8QoieFDHx6Fovl0nomwU5+EQk5WK3mJ5
 4YZOf/whSLbMg5jYJp9Qn6IjcLrTgGvroLX/sSugPt94lPF11QalUUU/6mDWq3tdQLRP
 S9Yw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773958159; x=1774562959; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xHTNhQprnxfVBU95i3jTbBSgDx/Au2zJ/BjH5xatp7U=;
 b=bLzgObK3xtn2tISB5daQJ27bcf5+T0lNOxWDkIz1XIqkbJuKELMRl9Re/9A1TovO5o
 XJ12yvgRCjLruD0mUR/hV2Ctja+WAqFi7H6sIm6yW0z0n4+DeeYd/YdGlQfaoKzSd8rc
 CPsYiAw7hKD/x1upkkUhtO8FugVdM0IEFPAow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773958159; x=1774562959;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xHTNhQprnxfVBU95i3jTbBSgDx/Au2zJ/BjH5xatp7U=;
 b=ptS7rsU95+bfl8kKBATrPf1nO9+i1m6nXtFK0zg8J98geZwmqJlVi2RvL9t1/xlU46
 Z8FUHwjd+UrSawr0rA8QtSQ8ze0Kv4Jt0jG3WJaCkWQltvot6mElL0svFj8tHbo86VxH
 hC0DVg9sub6SWyTOTxChabbiH80x9AO05lXnlMEJc543mMOIFvcpecCm3Nukk2FRVjyZ
 /LOPXq6pn6yXn/j7sDO7QGvEpyVpdXHYKFixCphwoRu7bQol0JxP/LxJtqQousiyla3k
 oEpguEhrEVCEoFiUrEVgqPZw4r9aFxI+dKd8/3X6Lnb4mOciic5ZpHj14TpANn4xY8ij
 tbPA==
X-Gm-Message-State: AOJu0YxFmCnpYTe3r615+eM48kR6OLcipHJLVCKm7NLYbnxpKHTDDG2j
 r1dUc+Tkxtv6XzSqERnNSrvemcgvNnViwdRmigS5kbPowTIrhiouMLAl+1mxUG6hx7zSl1IOJYQ
 Ca/+FnXmU6ySn1zXav04xWSQ4x7zPjfgqFp6PI6/X
X-Gm-Gg: ATEYQzwFeG83pA9u6uHvcgrgDDImJBksCHU8fVbCnbTOBiQZFb/o4w6gMde+NYPSmtg
 kSEdk0gpC8zNupOwM70N45KJxSHTrW58dmFOwpvzOp5paC3GM+GlotzCG/CXWTynoOMmml8UAEZ
 qC7Vk7nx5DhidxN+ZPSODUeShsvmK1FkyauQanVMaH2DVPnIj1R23YuzcsTzh22La7aljYQvMHH
 vBl8rdAgFpqooWVE9E4KT+mWbgOQzpke6MBNW8eWfCezuzTOE54yg/E+8yipQQ2+eeRfoolsPZ3
 yTKxBm9+
X-Received: by 2002:a17:907:cc1c:b0:b8f:f08a:4b80 with SMTP id
 a640c23a62f3a-b982f0baeaemr41016566b.3.1773958159040; Thu, 19 Mar 2026
 15:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1773840306.git.michal.simek@amd.com>
 <b1f57ff8f3a45d0118e01f33280b48d92b3b2397.1773840306.git.michal.simek@amd.com>
In-Reply-To: <b1f57ff8f3a45d0118e01f33280b48d92b3b2397.1773840306.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Mar 2026 16:09:05 -0600
X-Gm-Features: AaiRm50aSMyIjyIilRQie9HRItwmQzQObyhMiBEKvWu__Dn056euyo0znXJpKZw
Message-ID: <CAFLszTiU02q_cPp=xY-NVxkd0f8yk+LcCpN1oNCdygpcyi3WwA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] event: Check return value from event_notify_null()
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, xypron.glpk@gmx.de, 
 ilias.apalodimas@linaro.org, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Yao Zi <me@ziyao.cc>
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

On Wed, 18 Mar 2026 at 07:25, Michal Simek <michal.simek@amd.com> wrote:
>
> event_notify_null() returns int but its return value is not
> checked in run_main_loop() and in fwu_mdata tests.
> Add proper error checking to all unchecked call sites.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
> Changes in v2:
> - new patch in series
>
>  common/board_r.c    | 6 +++++-
>  test/dm/fwu_mdata.c | 4 ++--
>  2 files changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/common/board_r.c b/common/board_r.c
> index 76f9fc090fbe..00f29385d80a 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -579,11 +579,15 @@ static int dm_announce(void)
>
>  static int run_main_loop(void)
>  {
> +       int ret;
> +
>  #ifdef CONFIG_SANDBOX
>         sandbox_main_loop_init();
>  #endif
>
> -       event_notify_null(EVT_MAIN_LOOP);
> +       ret = event_notify_null(EVT_MAIN_LOOP);
> +       if (ret)
> +               return ret;
>
>         /* main_loop() can return to retry autoboot, if so just run it again */
>         for (;;)
> diff --git a/test/dm/fwu_mdata.c b/test/dm/fwu_mdata.c
> index b7680632f95f..643b647af0a9 100644
> --- a/test/dm/fwu_mdata.c
> +++ b/test/dm/fwu_mdata.c
> @@ -100,7 +100,7 @@ static int dm_test_fwu_mdata_read(struct unit_test_state *uts)
>          * Trigger lib/fwu_updates/fwu.c fwu_boottime_checks()
>          * to populate g_dev global pointer in that library.
>          */
> -       event_notify_null(EVT_MAIN_LOOP);
> +       ut_assertok(event_notify_null(EVT_MAIN_LOOP));
>
>         ut_assertok(uclass_first_device_err(UCLASS_FWU_MDATA, &dev));
>         ut_assertok(fwu_init());
> @@ -127,7 +127,7 @@ static int dm_test_fwu_mdata_write(struct unit_test_state *uts)
>          * Trigger lib/fwu_updates/fwu.c fwu_boottime_checks()
>          * to populate g_dev global pointer in that library.
>          */
> -       event_notify_null(EVT_MAIN_LOOP);
> +       ut_assertok(event_notify_null(EVT_MAIN_LOOP));
>
>         ut_assertok(uclass_first_device_err(UCLASS_FWU_MDATA, &dev));
>
> --
> 2.43.0
>

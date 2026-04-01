Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AFAD35144
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 06:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23AEC84010;
	Wed,  1 Apr 2026 08:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WoEvPanC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 389AC84056; Wed,  1 Apr 2026 08:54:48 +0200 (CEST)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FCD983F5B
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 08:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64fc6b21789so6981018d50.3
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 23:54:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775026483; cv=none;
 d=google.com; s=arc-20240605;
 b=PE++VasMHDOPtfqXWNQdlXsTV/N7EbFePB4IaKHS8gYzwMsVTGSOgbm7+9mRIMSLsD
 bsPRfEeJAXeJqslUR8IV3VetkCnGdeMTr9cOIgGmpBUdfnMMkKwstuBQMnb+TJ5Qms0H
 1c6zVgFTvpGKyCbEnMqFlqRWtw33Jmw1UP/M/EHjUCf5NxB22Y9TvTrGk05aNcaH2WTG
 j/h1fcpW4twCItxJPK0wGLOZKV+NiNp60/jUFbhaQ0LZt2HwXcwvu+PR8XN+y7mF4G7+
 x5eYDvL3H2pmtlPN9hN3nwlnp/DixHEXRvP/E2d3Fic2OFAjFFevs50pJ+2jFzSVbMkT
 seQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OYfpwkdxvgg4xm2NHte4di3znLGj66mwmL0L37+59eM=;
 fh=ukNuHpo9tCDodOFEVrBhVo0Jbf3YmiXGZTimQ2iWF4k=;
 b=VZ/nstmlpQ1EQRFA0cuJJk/NLVVDXShkeSBu2ZFWNws0Ap+t1r9dm3/aSm2nN6zAhu
 RDpiK7wdR2MHyUF2n4fXQ6Sv350gTZXCTcZcOFr0HUFQpW4R5B+iuwfvwMK/Buxt1gi+
 aIYqG/4TpOWSYPd1qkjyzrkVA8TqWhcSVVU84tK1/TUXZTUu1MPYKzCFSUqzi2ugqzHj
 LfNA86eZzABdpSq5BcVmY2PAh6v0bvHMBIHbwkWQzmEEMn0kCFMQpskwnl9pnrmeCqkc
 OwV0N+f0PtEEbpJB5f/mBB5NKmOKaChV78dUftva3eIQp8smK1ab/4xmZjtCpDZQcT5D
 eFsg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775026483; x=1775631283; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OYfpwkdxvgg4xm2NHte4di3znLGj66mwmL0L37+59eM=;
 b=WoEvPanC69IIMRUGYP6BYs/UgFiG8ABn5WO2Bgmg8S0poQvKfYYoxRcFKwAHKxjuJb
 8NxHLP25Aab0ReWLIWN5EMtdtzLYizk77XwucjsJ0lL322DHqwufKYBssc5otipvR2M7
 RLoLT92bw4zE/49fBmsWlTeQn9ozWaQx4FUhbQ7UoIiI++hWNrdgMvSeVrwTr6KK3o9C
 1qTMyB6lWhTgwu1xL3OLQk2k5mnco9xTP/Is1+NgIoJlxa4coL+IP3ARQYYOweZqyfQo
 iWSNjkO3SQqFBjIDZUpUI9DBUiZmGpwnZXyZeB/pDxBZZiA+yUXMYwzNGClWGvqvuk33
 LUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775026483; x=1775631283;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYfpwkdxvgg4xm2NHte4di3znLGj66mwmL0L37+59eM=;
 b=MbEvIpJWDNW5WEaPJHKB6IOsCE2iq6BH996R1XiQ3/8mzLlWVIbZERdN1bfXrGusgP
 SioAnoY1RlijbF8fsJliowGYnQm7DdfkMz5khCzlrm2wWJcqc1xnQU4yK+qCPsJShTAw
 EY7DPUw73ZVg6fTOk0XUW+z0x1fkSJoCF7hM6lUvCCHdPiqwGvYVRzX6Gz+NowVeCmGx
 vLm2ZpFBoSsU4B0LdBQRYZoRfDMrUsBEtLWXp+X1gYyqxVMh5zQo7iviX4f/sO/no2li
 Bglp86UP4/K2k55ldmFfmBpQYGfumPliX6s3Lok17/82XhEGLCsQP4qMNfzu33vg3aoj
 wV2A==
X-Gm-Message-State: AOJu0YzmZ8ATlxnoFy6T5bNfqBftQmVq/eQSRj96l9GjkUJprHyX23Qc
 6wCa4QJ7iOACTAeKKpw+pFCHsHjen7YeF1iDzH3l4ZVRBw/yRpFmvJWZSmzPr7YiqCljeRKZZO9
 mCScPNmrUIULmnMMXVKrfl4pyKYHcvmBh3fLM//jM6w==
X-Gm-Gg: ATEYQzxP2YS9ejKS60rVW6zUI3nJ1H8b1PwlU6m+ritJ7NQPb7Hd1wgsXqKFLqfUy8j
 PvwpK3JtJcO/qyLsrUgu7121kUkR1d1S3xqp3iwDf66QGewLmey5EIFK1umih5WpIdWh3s+osu+
 pIluP/VYRpS3DIMjkV0yV3XpjZqZQvj/40TYQ8IBvdVOBhwOlMTQbdMfvohrnwsU12Xm7AuDfwH
 dbC0ycY2XAafDADOIr9MArpS9BzhcyxjJtWpC5/R2hBpzSQyI8DISLVD9QwUGDCQ2cDL1codcji
 GpveVtltA8RgJ9IVK8UmxI31auhuua0lAMbPAYDCKiMuaysHyHdIjoKHWTIPO1XT5aanIn1JsEy
 1x1C/xaxq+ehSU74d4DgGrhaKq2n/j4DG942ngPxvnLNylSYV+r9OL1zb5nTj6/cMBPyU07Dp/L
 Bbzyiy2xZkanH0QcrJMO2RqoKZlJL1A4fEsS1PtPd3N2LsUPBFLGA/olkmE1RZ/P9Ook5uzppbw
 0HmT21UBEMZ7x7NBDpyKNkhdG1RPniD7UW/Z1h3t0CmcSkoo7sE3jzaokZCX3oJb9j6K6XWytl5
 nl1Y63JHLXV5p7vtjEeZP/MA+NphKz1pGToxN289anbytSAvew4VmNM=
X-Received: by 2002:a53:eb85:0:b0:64e:e90c:5691 with SMTP id
 956f58d0204a3-6502fe83061mr1688743d50.64.1775026483003; Tue, 31 Mar 2026
 23:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775023421.git.michal.simek@amd.com>
 <cb15ff67b9915de6f0153d2b9f4114f9c8d8edfb.1775023421.git.michal.simek@amd.com>
In-Reply-To: <cb15ff67b9915de6f0153d2b9f4114f9c8d8edfb.1775023421.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Apr 2026 09:54:06 +0300
X-Gm-Features: AQROBzDYn2r9Wou-XCLAnKVX-ujMN0cLRy0TSCxke4TUdoG9ITl0e70GPbRa1hE
Message-ID: <CAC_iWjKSfFM90ti9R2efzti0LZVi1EycS9RbaReip4hSkEEGZQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] event: Check return value from event_notify_null()
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, xypron.glpk@gmx.de, sjg@chromium.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Tom Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
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

On Wed, 1 Apr 2026 at 09:04, Michal Simek <michal.simek@amd.com> wrote:
>
> event_notify_null() returns int but its return value is not
> checked in run_main_loop() and in fwu_mdata tests.
> Add proper error checking to all unchecked call sites.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> (no changes since v2)
>
> Changes in v2:
> - new patch in series
>
>  common/board_r.c    | 6 +++++-
>  test/dm/fwu_mdata.c | 4 ++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/common/board_r.c b/common/board_r.c
> index 8cf0e14679c0..5d37345ca09d 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -569,11 +569,15 @@ static int dm_announce(void)
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

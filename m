Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FDB606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vt+WiJmV;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=DQkgQk17
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5C40406E2;
	Mon, 26 Oct 2026 16:07:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CoTwEwWvfEmH; Mon, 26 Oct 2026 16:07:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1C823406F9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793030867;
	b=RZAedFkU16C8AbasDzFwn1dD7SwH9TY2E0ztJ2++YOGXtfccLgKqmQIU71IaPIC4KOKa
	 Ipok7GDLwD+WLYQElVlDq4/P3/2Rmd0EFEwjnogKOyvO+kYf8/0zpiNqEa18KqxB4Nrgn
	 sxm5GaTuDyr00thXm3iX+mlSP8SEDIPnZhq5vqI8a7f/rnlW3EvygUmtTI3ga/zsXZWvd
	 ZxUOcA9vIziGqIjnzh5Uw2xun2AXfok+TjdmK9oe2xloai3iBIL5zTbHxCBqUTotlNqEs
	 TfOi0lr6r+THyT1DjYK2J2w4tJWuawi9OndlCsHZS08QPCYA9N5+nRX0QAkK5ZcX4EQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793030867;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DG50Ykrw7FreXoENOK7kttOWPZgcaOUhTefwvFVo/Rk=;
	b=bfh/J+idCjJfsY0jk66AEwI/Vn+XWYEku56+bELkHQ104eHSDFN2YO6bSQK+m88f4lmk
	 3Yx/bGSneiU9z5/znI525HOzBSuDgVnH0T6S0WFPZiUkbVC+8NrovVtby4OLlmQ5jEWlh
	 iN3Xy1CeNm7dkyjq2HE35mN1r3/loBEtvmZmTKKi4b/PfJm3l7Ci+uns/Xk/YvH4PZ340
	 O2v1POcW0cKD+6M9oq+DHKWWHfjdu+/JHsgyfmRs5I8S6trY6mEr77qfFsFKnT++6pqeh
	 +tde6TB7EDSFgM4QD+tSvHRBhOEe0JaRVtpPKeuMVeVm8KATC+MpPknJhSF5VGb0+vg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793030867;
	bh=DG50Ykrw7FreXoENOK7kttOWPZgcaOUhTefwvFVo/Rk=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vt+WiJmV9eukzd4QThbw9j3b0rTdw9mOO1Jiut/HOtl2ZLe/8o1SWUZc9oakLQKZw
	 mR9xviWseHXcEMUHrfc5CQ9gobHiNPmERw/N9hNo4qPVbiBRxz1VVBT9nayDfSsN2D
	 vqxJGRNepUUNzJR/zITpqdXdb9kp0M2QFtchhRJSUUVoXJN+7jWbjrL143h7LITMsx
	 o3Iau83RH/sWrmkNAOV2HW7Yxm9JRrYfgmVHXTW66VY04VTDzlQd40ZiYK2anvqdCH
	 yawRTMHEHbLcG/Z8g3FnWHqoSV1aO/JaTqoQgwwVdFDqEQyzyg7+RjmTUlhzK6303l
	 xcWJdblhdNuZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C823406F9;
	Mon, 26 Oct 2026 16:07:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4606CD33
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:07:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3849C40093
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:07:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JwugDm8hyUwf for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:07:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 275EE40062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793030862;
 b=A6Feaai+JPsT/1+kfognBE0AYxrD/qtwoU3D3LKRPe69hE5YsqhLsDjRTfTmHJy/Jqy1
 E+OxK1Tsupt2mtS5gFfc0OJCTUFM5wXnNEQD4BsEb0YZugF6I2NhVTLRcfpgF8+Gt1bB+
 6U7IvTsIJhfChJG7UDbDi2z2rP8TCQ5tg33jLUcvjy1n/mmEvkJL5pFTco5m5fMY14DAT
 fMCpypmeXjJ6dgxf+PRlGZyUxdhjif7Ns/HwuV1thISmHeHK2KjeGNaXWqYrnj2bCYFwq
 RIdkzXZ7VUrG2B3/xC8BphDe37ACnLnViqFMfh2488uI3sKabtp0SGmYOOxt3dRlytA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793030862;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=DG50Ykrw7FreXoENOK7kttOWPZgcaOUhTefwvFVo/Rk=;
 b=OvyXxCiOSq87TLj5xngWNwMQWnoY2pPFdQ3DMb5Yf/Btzmj6bY9CImWTIPLDMsmk7y2f
 qFp+S2U8+UhprWH9Tp7Hm9tVYvaUkgWqhrBdifTWH1+M9zTK7/U/Xcl38z9OxDnloEEkD
 hdBsxJz68RNxNrcFI8MsMVF/hPeY4O5rwfw85LGgIIaPTjqZuJYMZj0IfWXERWtZTQ8Qh
 KKHwB6KE2XD2sNQmfZlRVCWnAuo1pM/LYRSWoMsh94h3AzCTtC6RJ2QE93wST7THns0CI
 /YkrAYJJlhX9/+92VG1ecPd6DQj4MxlgZ30mH82zw43ME6wYOIjAsJbd4cduqoMI4Zg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=DQkgQk17; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=DQkgQk17
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 275EE40062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:07:41 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6b170129413so6280852a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:07:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793030859; cv=none;
 d=google.com; s=arc-20260327;
 b=fx+jk/vLB/wHC4H2uBpCYU3/YbeG+XSHKKCfvP4LRPMt9hNmbfePXCQJgW5dZ5uohD
 13EGbXd8wmMLFDBYVRAar2J0Itjd/O5Tv/T34M/pGVjPng1QxclBScIbG/6i1i+IrFyG
 fD3QOttA3avknhM7VjL28pu+SRdUdq9beaq42a23RGWsLL5mcfNujAWFizb3N4XyuBqF
 hKP9zDlfcqGCRZrx4OAZPryBEzL3rdjlVj2wRJIl9YRSxmTW1BKUnFQO94UIIvffblKu
 /mLj1qw6QIgRizL1ioHnhmZEAfLbRJs6tlbWrQ1ueEfc3RCLfvhjb+tTjwPQrQEnpUbE
 UR1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=DG50Ykrw7FreXoENOK7kttOWPZgcaOUhTefwvFVo/Rk=;
 fh=Vi46RdmyXd0SupGlsPtmZZi6NaJCBu3Vb80GVjkTlag=;
 b=eIt5VxtOGJXQQAef6SmOt0fAIDohltUmg8HybjvKGfIxvkJPetbALurFcOiapkxfSv
 /gUCk4V65AJoW0fVudime0JAzf16wqiRisGKlja+b3UaN6GXhjRgRlVSihBOEXhIXwaz
 8DzgpTOAdMPYLUmzbFDSoRNKH095UmNHV1SHpcR9BVxSnKWjUzxHZBhD1IJu+F71g9mw
 6Px1NoHGbtcWNUSQHVOQYVcGBEs8ZSeQ+CEl8en601yVIwi1BGCcwlepx9UAr3pCzzRS
 Kltb48bhuA2lqJrtMU0q4rQkSi5PI0iKG40sSvmVq6J+a/oS0Ht9vJn3PQvmS8TFXaBk
 HR+Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793030859; x=1793635659;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DG50Ykrw7FreXoENOK7kttOWPZgcaOUhTefwvFVo/Rk=;
 b=DQkgQk17RIriPws6bR+OgQB8pmaSpXXC6BwNsyRvckrEhCmHdmloOGi8Bs1VuPvpj2
 xJgRpPJdJiWiOQtLp1+COCJYkR4UwXEl4FTeosnS2QYTxZlWb6c1BeAQSdHFU7OoAH+O
 8YyKmMp9dsJ0r/OD2HJLyAliBfaE9leZVUSWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793030859; x=1793635659;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DG50Ykrw7FreXoENOK7kttOWPZgcaOUhTefwvFVo/Rk=;
 b=OenN5EmuIHeIFUlQbBPFo/DEpSLrvMS1AEJIiG2QGnOureFiNlGn0jGpyWwj6jQgAb
 CCd08h8v8QmAAmX4d8R+WvB298iuOzu60vv8xAYydKgjD7sxF8n0vFdoOiIfRSeovnIc
 1bjYE6fEVPG+2iMaAD1qZrvC7GZTwd/pqI9kHNEC8CsamAJOaGlidJFGTCRzeXSZ6vQL
 PC0LLmb0AqqCiJ/3nWriytThLg7k4Y+bRP49xyQXfBAhtfzFy5N9yLF29lqCEkjaxkN7
 ydSU6zl8Szp1OufDsD2SAVUdqYEX6pCdSBwNOpuZgGVt6fbqULbs2hPsctDHOC91YNY9
 Z8YQ==
X-Gm-Message-State: AFq9FYLT+vgHef9VWVynz2gvtIr8GaXn5ZB/G+8f6hND0E6R8DFAIFad
 ogS0lRIa8TRMzn/1Zfmuyv2Cj43SxnQPfHDs4ZbwM6wcZ5IZ9ke39uViOxm0utm+DkEyyPbDRK3
 FoI0UPqqPeYaHXqGMKLjauW2iDN/IVHutCvN23BJD
X-Gm-Gg: AYBFou2I38P7h6aNgieg+6/VFbl05gpDAtPyoLUUDpylOE/7nZFLifOnRQ1lPtdGxoR
 Bxcg6Kp5rz7S3empiEEFCvhpI5CmkpAxrKAhsN83x9Z3XvAx8bJRHr95uqZHWe+vb/hnx89qhGE
 iYOotEJY+b45TqK+6WQGbmhax6/u7tC0NxtnyOZw+FEe6e1Qq75lQBijf9ShxEk3NdgKVunXOFK
 wFwcLsEPcwbxeyIiW5C66/23chd9bkq4KnP/zqcICB239rGTtMHizZr3SzJJh4hqLDqhvh71jyc
 f9aB9luAvd0l+a/CDy54wd68LtVqNS7+800cwhuM4aiMmOLsEr712WZ+jbuLDtmtpZTg+UBs2Ap
 tcq7T6mZ3fL160jbq8tBxuofFhLOW6ITaeM8=
X-Received: by 2002:a05:6402:793:b0:6b1:c265:a5ba with SMTP id
 4fb4d7f45d1cf-6b442ff3c14mr5661453a12.20.1793030859601; Mon, 26 Oct 2026
 09:07:39 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:07:37 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:06:23 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261021-rinta-watchdog-gettimeout-v1-7-e7f3157b8bab@nokia.com>
References: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
 <20261021-rinta-watchdog-gettimeout-v1-7-e7f3157b8bab@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 09:07:37 -0700
X-Gm-Features: AclHuK-DWF7_0AiMTkDWCo2vr4ELAu8vEziMH5FUa3gRqGakdO5bMy2IG1YexIE
Message-ID: <CAFLszTgi50TT2pFmGHNUpN7qsBdD2PKWEj=wR_DCFNX4-z7p0g@mail.gmail.com>
Subject: Re: [PATCH 7/7] test: wdt: add tests for wdt_get_timeout(), wdt
 gettimeout and warning print
To: juuso.rinta@nokia.com
Cc: u-boot@lists.u-boot-project.org, Stefan Roese <stefan.roese@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Yuri Zaporozhets <yuriz@vodafonemail.de>, 
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Juuso,

On 2026-10-21T08:08:13, Juuso Rinta <juuso.rinta@nokia.com> wrote:
> test: wdt: add tests for wdt_get_timeout(), wdt gettimeout and warning print
>
> Add a test for the wdt_get_timeout() helper and the subcommand
> wdt gettimeout which exposes this helper to the shell interface.
>
> Add a test for the warning print when requested timeout is shorter
> than the servicing interval.

The warning is about the programmed timeout (as reported by
get_timeout), not the requested one, and it also fires when they are
equal. Please can you reword this to match patch 2? The subject is
also long; 'test: wdt: Add tests for get_timeout support' would do.

>
> Sandbox driver tests the success-path and the not-running case,
> and GPIO driver tests the not-supported path.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
>
>  test/dm/wdt.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)

> diff --git a/test/dm/wdt.c b/test/dm/wdt.c
> @@ -68,8 +69,42 @@ static int dm_test_wdt_base(struct unit_test_state *uts)
> +
> +	/* wdt_get_timeout() helper */
>  	ut_assertok(wdt_stop(dev));
>  	ut_asserteq(false, state->wdt.running);
> +	ut_asserteq(-ENODATA, wdt_get_timeout(dev, &get_timeout_val));

dm_test_wdt_base() is getting long. It would be worth putting the
get_timeout checks in their own test, e.g. dm_test_wdt_get_timeout(),
and the 'wdt gettimeout' command checks in another, so a failure
points straight at what broke. What do you think?

> diff --git a/test/dm/wdt.c b/test/dm/wdt.c
> @@ -68,8 +69,42 @@ static int dm_test_wdt_base(struct unit_test_state *uts)
> +	ut_assertok(wdt_get_timeout(dev, &get_timeout_val));
> +	ut_asserteq(timeout, get_timeout_val);

ut_asserteq() casts both sides to unsigned int, so please use
ut_asserteq_64() for the u64 value.

> diff --git a/test/dm/wdt.c b/test/dm/wdt.c
> @@ -68,8 +69,42 @@ static int dm_test_wdt_base(struct unit_test_state *uts)
> +	/* wdt gettimeout command */
> +	ut_assertok(wdt_stop(dev));
> +	ut_assertok(run_commandf("wdt dev %s", dev->name));

Just to check: cmd/wdt.c keeps the device in a static 'currdev'
pointer. After this test the driver model tree is torn down, so that
pointer refers to a freed device, and a later 'wdt' command without
'wdt dev' (in another test, or at the prompt after 'ut dm') would use
freed memory. The command already has this problem..., but these are
the first tests to set 'currdev', so they expose it.

One work-around would be to clear the pointer at the end of the test.

> diff --git a/test/dm/wdt.c b/test/dm/wdt.c
> @@ -68,8 +69,42 @@ static int dm_test_wdt_base(struct unit_test_state *uts)
> +	/* warning print when timeout smaller than servicing interval (50ms) */
> +	console_record_reset();
> +	ut_assertok(wdt_start(dev, 21, 0));
> +	ut_asserteq(21, state->wdt.counter);
> +	ut_assert_nextline("WDT:   Started %s with servicing every 50ms (%ds timeout)",
> +			   dev->name, 21 / 1000);
> +	ut_assert_nextline(
> +		"WDT:   timeout %dms is shorter than or equal to servicing interval 50ms", 21);

The constants can go straight in the strings, i.e. "(0s timeout)" and
"timeout 21ms ...", which is easier to read than '21 / 1000' and a
'%d' with a literal. It would also be good to check exactly 50ms, the
boundary of the <= comparison in wdt_start(), and that a value just
above it (e.g. 51) gives no warning.

Regards,
Simon

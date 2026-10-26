Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF62606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ASZxOKZu;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=QGRpv5s7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22A8980E12;
	Mon, 26 Oct 2026 16:07:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DhahwwHuykiB; Mon, 26 Oct 2026 16:07:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0209580DDB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793030833;
	b=rMQruUn7//xHw8QkNoby+Dx/qqyABxu88cV+UrMi2bkBtMxOIIPZdFrl9rHYRBcHF7m7
	 RLltHi7HOVzPRNhtJt5Po6g/GqiZFDmvPYzKBuMzoQsJoIHQWakA6wDBtC8KC58jgagZl
	 T+wZxXlhkEpe6/N/YOMsZEwG0B3fGr5rNjm97TLo+WyrYM8LfRuvSshNyvvltjeZndsJ/
	 1+zoTTBBsSfuJsQJ1cDiJAZ65xl152+2JkeJEIpGyZmtr83kC5jSv8UDtUIZZEHYc7qaS
	 YxHwQXnkTmO0XLdBfCkzrDgAQEp9YdQu7h2JfdF6n2MVCwCm3rOo87WJw6zQejeFW3Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793030833;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rYnr8nOdo/i4lhTNFq1rkYS2msOuoMfL4eU0c3n3FjA=;
	b=Wwrk14pboiemuoMX677VR1kxB8UmTxL3miCimBdOy8KG2tX98cS7INYpM04OrN8jBoLL
	 hnid6PB2G7Ku/9ekYB6sKAS5vvTAkwRmImWAHmmBI+a4ZaZgysZP5F8LVXa7LMv3CkdBl
	 QghsXA1t5M7op41e31Lw6UlN1GBpjuLLs5g4mOfIqlAvsN8flbJVMcmGGqFa+IlHsWo2d
	 FIBriFBiuqc/bRUooqdgH4EgwoJE9lMsZRPnl+5o3FsosDcIJ41sL8z7aPe0mAtj1v+mc
	 /7iUYLPHLFw8skcD1ZMGeoJZI75Jq4wD9xRVh1KwlLGs/nYNsHiDry1SDOwxJvgcwrQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793030833;
	bh=rYnr8nOdo/i4lhTNFq1rkYS2msOuoMfL4eU0c3n3FjA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ASZxOKZua3YnyOih9wtiC+jg96ZPXfxo+wBObxbt5qmMJMv6CBjY13O9LvBSenwBh
	 KqY+d57/dyZeis1QDkpcqYY2HJjGXe+3hfN27OLd8t7RjDbLxdcK+yGAHTkK55qGpU
	 IQKyhXJnXqB6D7/dltJ7Pnglh4ZVgzIzhk9A3RZHq4vi0VPem8iALDuwG3giyLfohM
	 cBa/vQoaVjeSb8yuPZjC+6r57irFt53bAbQvV1YKy/pbzRGWQzzPQgumz5MltSTo/7
	 SqesaI4i+StERQ1K4U8vL49cqxfNdcjR6OpGlPmn1MFvnuiDzxcyzYd218rppCcizJ
	 jN2FhYEKWXf1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0209580DDB;
	Mon, 26 Oct 2026 16:07:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C9940235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:07:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AF87D60612
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:07:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HkvZjqpiIFno for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:07:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C296760603
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793030827;
 b=pOSDNtJ+IKrm7X0uY7bUVzBUtSyLAfwJoPbM2fvwNr+7rjmQyKd+aNAIHCTAfD4ICNHu
 BOlSWpROz20HnwhRL9ZrAqXN79/ZYihtHpo1g+v0xdWtltgjlLsWGDEE5PvKzzOEE/hTZ
 R1pJ0dtHqyyT+omnGZAWVJCjUQ9uCb/gvrGXvKfzZleL/Vec3hWidDENL05UVHXXiY+8U
 j6lvIQ+3YJCaACchCtcpjgwTHrrmk7Njon2GhzCU4rXVTcMe/v8FxkW+qLCgrYRmNwh8S
 4nqHAVQjJeVTOOSRvWFbkELVv33RUab6zjO6UZ7SZZ4jsdb5LoJ8lD++QdA4aDUpu4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793030827;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=rYnr8nOdo/i4lhTNFq1rkYS2msOuoMfL4eU0c3n3FjA=;
 b=rVNkcNHroUDAn7pkoPW4vGUvT15gccyMr6zynwSBF4g3f1sLZPOhAfudN4e6/B+UG7hg
 yl+ciI6MYs/vQlV9iBRGMSyaI9pSMeGQYJDeICM70tD9oXU8iOLSNx4Vk+gQtsHTNwevU
 6xOFxe9JJG+1G5dbqxUcKIGbsuoQDEVYZS3TvRaPcWq+Yicspy/o9Cj+bwKJ5SF10Kygc
 kd+lBNtGPA2Ue5MHH+sD9WKfrWtb8rDdAHwkc4EtIsiwawRgWXK6iVTeAV0k9Mt1i0VXc
 I+9i0TupZA2AU9hEYDSy7yNhXEze1D/4VULdW1MMSIF6b1WpZGod+GblN2xwjM7PPmA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=QGRpv5s7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=QGRpv5s7
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C296760603
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:07:07 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cdab8873d9dso374469a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793030827; cv=none;
 d=google.com; s=arc-20260327;
 b=bVZ8MC+zhFzNTc5quuE8uEvM5QG20gpz1rYdOFq41AyAW+5GPSSA9UnwEfsAoj8Tfx
 PFUt2fd8PNPH2E0/pssjH+XMNZZIm56Em/weIxbNhA2fdnYNLfL+WVlxOf7lyNB5ZQTK
 BXsqljtbhJti99kSiFLVCf88BUwxr41XpTj/aoSBqTZy7j6IS87lHSABv1+5utJIwQMF
 +vhzj0QAYwLNeikvJsJblFaEHt2700Ik4Q/aqq31364N4rrLDzVixjt+Go99ggyGbNv8
 nSxqOj8RMlaYibnO5ooSraJGpmYMfVa/QWJbgf+CmunpkBOq0oAeSjO+ndQMJoo4TCnn
 X+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=rYnr8nOdo/i4lhTNFq1rkYS2msOuoMfL4eU0c3n3FjA=;
 fh=Vi46RdmyXd0SupGlsPtmZZi6NaJCBu3Vb80GVjkTlag=;
 b=CBzeM916EJCgORACU23V6KqPhQ+IlSbRBSlHs9MtaRNB+qe+m0em8X00hklXDtDone
 vykx6NBPPdED5blQ+AlM9rSXV5+B6QcSlOb3L03IOBD749FceBMur+2fNKXQCHVkVFZi
 4XV5PPIry7frOjILPGvujFucfE+5Z55x7+3tyxJ4z+apDfsnCR5XqTGDo3XlKOl91ZBr
 rWu0yarCyqcg8UAO/zrruYPIc3wiMpSCFatyXbyk5VWK6ifTVUlDMnmollLi58qG57iu
 FlDOfvu2ul1s8PWloxrSvN3osoiMOmo/YbZaJmFemd4R1z3UgEPb4YAQZAQCySYyma7M
 1fUA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793030827; x=1793635627;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rYnr8nOdo/i4lhTNFq1rkYS2msOuoMfL4eU0c3n3FjA=;
 b=QGRpv5s7eHFMgOcId0lPvALC3fTBr8jGMmjEeKCa7PwZo+kYo+MiK1QwHpB24RXbhF
 KUdajp3h0YJF3AKvCfPUCTAHA6cxNLwGxMFI4felWJyxOKZGGS0Hp6JCD687GAglRIWl
 Fnysv3l4h172+19c2TZ7a9lhnEjtUdDE0LZcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793030827; x=1793635627;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rYnr8nOdo/i4lhTNFq1rkYS2msOuoMfL4eU0c3n3FjA=;
 b=XyM/VCyu6+wPxf7l9sjThfHjos9GtEyNN3u/T+G5v40+QsdZ7nTjZlZoS4E6E0qqBd
 QFBrjmI3ztC5Uaj2ROPklmKnpG0/XzSkrJbwH/0LUKWYH1SNtzLZnALM7wyjcR0shzA+
 qESY+4Iijk2cse0u/+YewywTbylLNOoZeETl0n1vGpQSQd4mz92o/2H+o28p2jl2PaUk
 35aBEIhpna+4V0xCfzrSkPpLrMEGFFF9x/Q0IaMyrgv2KAKjWBWF6X6KRjUAdv3Mlnoi
 ZrUQfd1m1zG9MS1yEVHLOp9R13Sb9OmbwVR8wSGyIGjav+iV12CeQfPPkjl1UVGCpKWR
 DCTw==
X-Gm-Message-State: AFq9FYLOrlEo8tVLzF9iyxErFftLxAwr+bfeILgYo6vAvUDvWOaKQ1ve
 FvBrjgzs95H8PRlJ4mnxKp1qQUylOC4O4VuKROKjzC92hmcAybb7Z/y2SSPoVa/r3SumIxIJiTs
 KKepWBrF48VsnV/Qs1CT9PB2i2S7EvddH4G4DT6jP
X-Gm-Gg: AYBFou0JlMChpGveOy6wxwuqdVYEbwahHrV9i6gQ1Okfe3bDwCuFyDWrJf0old7q65+
 IFRQipt0CimVuK4DdyyPgEOn6QgS7yYiDjSFZ2uRJLLgkChB6kYzXXqXWWs0NyLG184YOXCNMPY
 D+m59kwOWi3Tn7CwtMn2KqOOTICpLrScmDjwxWN+pQy9+5mez03wgwLW17DPIVWaX7vI8A7gDZd
 uwquuPNwUPMRbc8aAhwV62hVzDna+AaflVZGq1WvzusogzqY2Jfpq5FFKfwn2WNkVsd+MOXF146
 4x2p46nW+sPwjc5hFIbjlZYdz5Su310J3vlzgySZoFNwgE9uzW81f8UBAhOrQ+s86SyiTBqEq5G
 I8h+Qsz5/WHqUziNHz6iOImWDm0sFfZv1Cdw=
X-Received: by 2002:a17:90b:53cf:b0:3ac:a11a:7c84 with SMTP id
 98e67ed59e1d1-3adeb126f28mr5358434a91.65.1793030826622; Mon, 26 Oct 2026
 09:07:06 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:07:02 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 08:41:08 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261021-rinta-watchdog-gettimeout-v1-2-e7f3157b8bab@nokia.com>
References: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
 <20261021-rinta-watchdog-gettimeout-v1-2-e7f3157b8bab@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 09:07:02 -0700
X-Gm-Features: AclHuK9Myn8kXberunBNonoiX5X7VD3rFRk2DtY63ecAI5fhf96xnkVCFzxzk-4
Message-ID: <CAFLszThz5iM4Qn78NOyVedon2jrDUnKn=0hN++YcFd1759tnPQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] watchdog: warn if programmed timeout not longer than
 servicing interval
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Juuso,

On 2026-10-21T08:08:13, Juuso Rinta <juuso.rinta@nokia.com> wrote:
> watchdog: warn if programmed timeout not longer than servicing interval
>
> When a driver supports the get_timeout operation, wdt_start() can print
> a warning in cases where the programmed timeout is shorter than or equal
> to the servicing interval.

Please can you start with the motivation (the board resets
unexpectedly because the watchdog expires before schedule() services
it), then say what the patch does in the imperative, e.g. "Print a
warning in wdt_start() when..."

> diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
> @@ -178,6 +180,12 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
> +		/* Warn if programmed timeout is not longer than servicing interval */
> +		if (IS_ENABLED(CONFIG_WATCHDOG) && get_timeout_ret == 0 &&
> +		    timeout_ms <= priv->reset_period)

Why only warn when the driver implements get_timeout? Otherwise
timeout_ms still holds the clamped value passed to ops->start(), which
is the best value we have, and the problem is just as real. Dropping
the 'get_timeout_ret == 0' condition would cover all drivers and
remove the new variable. What do you think?

> diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
> @@ -178,6 +180,12 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
> +			printf("WDT:   timeout %llums is shorter than or equal to servicing interval %ldms\n",
> +			       timeout_ms, priv->reset_period);

The message doesn't say that anything is wrong. Something like "WDT:
Warning: %llums timeout is not longer than %ldms servicing interval"
is shorter and clearer. Also, reset_period is a ulong, so use %lu
rather than %ld here. Please update the expected string in the test in
patch 7 too.

>
> Suggested by Stefan Roese on the series "watchdog: report effective timeout"
> [https://lore.kernel.org/u-boot/20260823071511.687900-1-stefan.roese@mailbox.org/]
>
> Suggested-by: Stefan Roese <stefan.roese@mailbox.org>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
>
>  drivers/watchdog/wdt-uclass.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Regards,
Simon

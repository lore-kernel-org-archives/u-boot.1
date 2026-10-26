Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299D6606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KtPnNTlq;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=j3pahuSm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05704406C9;
	Mon, 26 Oct 2026 16:07:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YsECaacbbH4L; Mon, 26 Oct 2026 16:07:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 45744406F9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793030828;
	b=MZ6VzZeJLmsSnMqL7TVvPFlKoUDT3pPdAcO0d8sRE82WrKRXzCi1hdgIZ7RkwO/kYCXE
	 SPHJ/52Up1QF1hHY4cjBhze68c/1hUUod3LRb1ZZKs851l5HXgOcIJn2RCN8XX5eKBsxG
	 xsGxXt4A64vvpIgD2BaGpEePdc7fr2zcpPBONCPHWDNviUSg5SB0hqO8RQbNNirdteqpt
	 BXACLvC6Hy2r9bOltXKLMPsMBOJYw47ANunqPr/d3nyTTgs9UnV/1a6tmasuDcOIy01Q4
	 xF8hvxvdzMHvycv4HdFOH2FGGTEqad9+9mnORxQzL2Dvm/ytNxG88xrdTbG2Zr2Gvzg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793030828;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bbuFKLSOybETZhFFFvc70NvhI/Cx+NFqVqnnrOjLU3c=;
	b=EMAHgSVMDXylNxVdRAAGNgdQ4ZOsuC3GcGF0VE6A/s2CR2qQDbpAJuY6s6TWVE5cvFuf
	 UcSUKYBe0goODbsxzJdhqq/d9oxIbbaPWYqIIQA/eCFVqhqOo93I9UEjYC21DIdUzmALT
	 J6yriVmtyDaVIallTaz/sbDSNH2hLHlbZh97xz/0gR2AfPy5ixRaVOrFupheyVXepMsz4
	 JiHxlsMv5okEXDUtFJQnbGKRRzP4UFQpRbKqGeHB6QKrm1Bt57FGmddNoiAikAA7+et7p
	 IM7uHIvpjN0HM6qAO2VNBUojS/JNzZljaPwrjWC8vLEfCcfyh75DsxtxyLCdaY3r7CA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793030828;
	bh=bbuFKLSOybETZhFFFvc70NvhI/Cx+NFqVqnnrOjLU3c=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KtPnNTlqcAQIdykxSexqa+zThZKxYPD0j+oxkBNcxlH3OjIjtK9Hc2MrS/vpXZQXe
	 jTSK1obHT9MyfuSCoQ8vGlXhxPoV1OfioQcf25q988UjJF3jgiOs6jUooUSkLWOa/p
	 h/MjwRZqWgOVhk2CdtDs1Ah0Eo/B67g1o3RtiwfjU4RvXRR6KHFGGpOVl3WOZl1tdt
	 NPRoZbqZNLKoZdHznVT2dBzwtEXzW9QxM9+RrG3pWO2K6Y18dESI3dOAYc9sUQDS+6
	 /1YC8A3mHtsLiOcl81WPp6zOElzDRE0Bu+BBdSt34cT1XrT/Dw3erffr/l4pINMH1+
	 3NdRwWlFRZfwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45744406F9;
	Mon, 26 Oct 2026 16:07:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 77DFE356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:07:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6990C60603
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:07:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8TIOlQeHBg0a for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:07:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9D44860612
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793030826;
 b=asa+eis3YacHCpMBLRwjUvTKpa6u9uqtPr0jQX4KYv4N6aZbUiur5O4syFN5zfzeR+Ci
 iqm8LrerCSnFaWAiEzFxJnuR9xcv3+8DnBiqTR48yYxU6IZF3S96ch6KRKG/FV7qKRnzC
 ArliXqPkXtA0WBfDqldZNHhcBlNgA2ZIYppeJTfE1NTCdCLh9xgbcGvke0iX59lxHSsyG
 EojGRzJAu79oAOVeWjWQyVRk89G/7looFUfSsGwNuiAo18+DWbIaG9183oO3V7fMkVqnX
 G1xFbGQ8zbRwBd0/+2I3WZVAakYvhs4rVCQ7jGLZLMcSDtpOgs4mV2qfe58iu837XNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793030826;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=bbuFKLSOybETZhFFFvc70NvhI/Cx+NFqVqnnrOjLU3c=;
 b=jsM4h/7L+eA//pqGynimHqYC4wFri93yCkwErIIgL41Uc2CZ935xrzJ+98iVp/zcPJ/V
 /Oyv1kL7RoBZ2I2aaAC6ZG7lY18H9imr7Z5UWtj217o52BE5BEwguLIJhhPniGPxo5f8j
 XPav5sjyS8VXm2J9o1mBjNgQgarJLwb30Rti9nmXVwbElYBVvnPZrbOvj5GOI6LpdsMba
 lbS49EE+UHMerx4Ld+wRdrauo1VGr30RuoTjOgY0AVqZBoXpLROJ6cYLhOUWwKBH8JJJa
 fWpKKbyXeFVN875OO8Vy50CEAdNr770bRoJ/RzGwtgKQyFATdotGmeDMY3TzLfUVCGQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=j3pahuSm; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1034"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=j3pahuSm
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9D44860612
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:07:06 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3ace9e6e1a5so50035a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:07:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793030825; cv=none;
 d=google.com; s=arc-20260327;
 b=UsjqykJa4s2zgx+agE4sk/5+Fpa4LOo5R8+xNaCb0Jfs1KQ4mhXxGsVCgQYupbF25h
 hSfQPf6eKdLdatR+6x0MPbZyXRtsDN54tQ3d1esrlN8NdVvU7636Zyu2eXdV0sqil2f6
 rfP/LT77EL+pQYp6Tfm9WgCl9Yu37j9GMXVOfAJzCUlvHD23x9VzbvqSt/iMm+KD9dbc
 0ON4lQopNaxv/IlRsB8AB+Nh37qEGSyqvy/aKDFqd7jrukdWwoiKR3kwbcvcWn/8im2G
 d57BbZbnynoTYp50J5QYoP6btiMeTrzYN5P6RFSyA8ZlLp64G5IfiDfsT30Q3a9mruRS
 2Gmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=bbuFKLSOybETZhFFFvc70NvhI/Cx+NFqVqnnrOjLU3c=;
 fh=Vi46RdmyXd0SupGlsPtmZZi6NaJCBu3Vb80GVjkTlag=;
 b=SsD86k81uGfymfaVNOTxRTIKjtMr7j0FwFt/HPEkBDbBqcs/kigFkwu0yvwtucWPv0
 /gngJaIFd5BAwsKx1rT8gnLK8IPnU8hP9gvT0wAS3yBznO/tK2ETnmjZ/3wZxq/66wLz
 /UEmBSYOyW8P9DfKqtKx7AmDIFOQ/xthD9K39wiXZRdXA1qjA8KSirn63v68fGhN2WVM
 wHjedXCNo7p8oPdHPBPZIAlzLe7cZMgBywduNoIhhA5Pv/x6yXyAOc7xe6inhAQGVcI0
 nKCdQ4mSeDcvUZyT414cI/QFJp8lPAY5g0VltT6FsBrRUP6zMgy2SZegxtYhVt4e6oUT
 bfoQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793030825; x=1793635625;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bbuFKLSOybETZhFFFvc70NvhI/Cx+NFqVqnnrOjLU3c=;
 b=j3pahuSm0sidGgX1IvF4Zu5aIKdggGdXCR6uGmtUofjdzf1UQNMnJqq7J8rrpKUQho
 ERD+MVzg8vmwxLBftqpR7ltW6NgOCsB5JlIN7+3ZXu4glNG5z2sEp5iPGl038nq5cVSI
 o2lvMxrCobKhiDud6IJ3PRxyyxthRtgbCd2hU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793030825; x=1793635625;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bbuFKLSOybETZhFFFvc70NvhI/Cx+NFqVqnnrOjLU3c=;
 b=J/WuAitOCChzBeZsYE2g9iTCS4S+8zJJQpJCjIo6R2tTPjHlasVEukTrSGeqYdc1vF
 Ns05DVWg94T8Dj9zVEabM5Eq2rRZ9QWBZRd8m9M1+SkS0N4A33V5pdHFAQI9IgdvCMKw
 TSQ3BJX9z7aHiY4mYFXLjyVPxxib89x+C1czxr/0+NNYhCGQB5zquaGyCokV+l3NC0Ac
 tsGqfOpPaSOV8IvphrZu71TVQmNVlG7kUgNm2+Vgl/TTlAGJziE5pV3G8zQ3+bk6JM7x
 OkxeLbFcvvbJEtFAJO4IEBYgiFlL7rna/oVU8OyFMuEx3Eyyw7qIGP7YZg8Xwnpqhb9C
 3IOw==
X-Gm-Message-State: AFq9FYI8hdQDVJJJAc7VArB6teogs4NvFIsZDZIWIoGWk7lUP7i0pv/Q
 UUrv+OQENYVWx8wyqLC1Pi25G97TJhcPqJoNNqLb0y4KJExG1O4zd0M/wppE/0cdVmBdsug7v0E
 tPx5r9gjnnmyhhECad5st3isLZsIbgyA999sspUwR
X-Gm-Gg: AYBFou3B68SuvU3PdAGTk01aolw1frHCqGGT7Mr2pyaNqFNEPy2k60nuOQ8YGVxcTi/
 N7cUw0LZlRTdrKuQLG7CVT+Wgb0fLIxQsOzP5BzKeRetzHdwblpedfglhdxlxgvpidcIsHxb4j2
 XkPCPWMdRqt+WR7HPanqFsn+4sd1H5GmVamc/moED2BoLj2y7L2gsq6SlObR5aEVNNpTE1HhdXy
 yVtAAzocc4aljyKQBvRTdGjFN+AaeAQitH28S5331Qt7GoE/zqpjTrXTKcZAnapdiFUtnGzg5Cb
 eTuxKD0FBsksyZpg8m4taVaqOXp5SPuvgyEO3+DAlZVeJ9YXUzJlGXaSCJ7iHeH9OFa9D3Chx+y
 l8BoNgOaRONefAhRFcNP+4oIJ7D1UxFuzp1i4
X-Received: by 2002:a17:90b:53c3:b0:3ac:36c7:c144 with SMTP id
 98e67ed59e1d1-3ae403a4d69mr52588a91.28.1793030825594; Mon, 26 Oct 2026
 09:07:05 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:06:57 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 08:41:06 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261021-rinta-watchdog-gettimeout-v1-1-e7f3157b8bab@nokia.com>
References: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
 <20261021-rinta-watchdog-gettimeout-v1-1-e7f3157b8bab@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 09:06:57 -0700
X-Gm-Features: AclHuK_m2NW5J2GftAupyT87_aKmk379MnmXnqVY-Dk95MoeuLd_McrzTBN4Gns
Message-ID: <CAFLszTgKunjP_4QwSYQ5uMb54Wyeh=hHQfCjJ1b+a49p_wcM1g@mail.gmail.com>
Subject: Re: [PATCH 1/7] watchdog: wdt-uclass: add get_timeout operation and
 helper
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
> watchdog: wdt-uclass: add get_timeout operation and helper
>
> Currently the wdt_start() function uses the plat data to
> check if a driver has reported a max_timeout_ms value and
> clamps the requested timeout to that value. This is not enough
> on devices where the effective value is not always static.
>
> Add a uclass get_timeout operation and helper so drivers can
> report the effective timeout. The helper returns -ENOSYS if the
> driver does not implement the operation. If wdt_get_timeout() is
> called while the watchdog is not running, drivers should return
> -ENODATA. wdt_start() uses the helper to report the effective
> timeout when the driver supports the operation.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
>
>  drivers/watchdog/wdt-uclass.c | 13 +++++++++++++
>  include/wdt.h                 | 22 ++++++++++++++++++++++
>  2 files changed, 35 insertions(+)

> diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
> @@ -159,6 +169,9 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>  		req_str[0] = '\0';
> +		/* Check programmed timeout from driver if op supported */
> +		if (wdt_get_timeout(dev, &timeout_ms) == 0)
> +			tout_s = lldiv(timeout_ms, 1000);
>  		if (req_s != tout_s)

This separates the existing comment ("If the requested timeout was
clamped, note the value...") from the code it describes. That comment
is also now incomplete, since the difference may come from driver
rounding as well as clamping. Please can you move the
wdt_get_timeout() call above the comment and update it to mention both
cases?

> diff --git a/include/wdt.h b/include/wdt.h
> @@ -74,6 +74,19 @@ int wdt_reset(struct udevice *dev);
> + * @dev: WDT device
> + * @timeout_ms: Returns the effective timeout in ms; unchanged on error
> + * @return: 0 if OK, -ENOSYS if the driver does not support this,
> + * -ENODATA if the watchdog is not running, other -ve on error
> + */
> +int wdt_get_timeout(struct udevice *dev, u64 *timeout_ms);

U-Boot normally uses a 'p' suffix for output parameters, so this
should be 'timeout_msp' here, in the op and in the drivers. It also
distinguishes it from the 'timeout_ms' input parameter of wdt_start()
just above.

Regards,
Simon

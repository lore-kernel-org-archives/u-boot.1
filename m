Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913FBC5DF87
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 11:53:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C39C60757;
	Thu, 20 Aug 2026 11:53:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dsLTQoDburVS; Thu, 20 Aug 2026 11:53:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787226806;
	bh=cSncCZF6L2yFFOw+orBxZrqZMxde5lHphQG3sGKShfQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MjXdB8/7uW52I9v2NgntLALD3LW3oU5iZ3MOjHAZ2i0hS/z40+lq+13PaNuUNb1Q5
	 q+bJfZCzaKrMP8SfFKc6byeA5epedNsa6T0xbM69wsTs+n9QaPFLyu9KHISCoyUNoq
	 bQknn/PPoFwoBm1dS2vFCZC9EnHk5TtXmWzzus8ZGYYEOwWPNqiv2Wl/e2pyyf18Ny
	 KzvdMP2nYbiy2NBojb9rkFR87fAK2JxXcFIKnNfBFlnZijadHFw95SQe4h1R7KS/wy
	 AVyONBQ65STnoAQ8xVRdhAG5xTnEwkRr/QoWCU5TE/0OFExqX2DjiXgNPqCOAQcjxL
	 ctMZC/zpKz+uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4B3860769;
	Thu, 20 Aug 2026 11:53:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 410D81460
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:53:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 32F32405D1
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:53:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9UFck6CZkagB for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 11:53:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=VNk8xopY
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 42EB1405CB
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:53:23 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c1c50c1e29bso339187166b.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 04:53:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787226802; cv=none;
 d=google.com; s=arc-20260327;
 b=gyE0cIaJuayI0FZROBdyVFQUDrNeKyTIPkFD+WAfWuM9LamIqYS2Zz/QrY8zu1yGmV
 0zGEWObfmt0IReYsrJkntbGr+LMQXOAoiMFAnZtk2FVESEl+o+lZAfZPO3/9L94xD180
 IyG9Wt8ee4+TD8iUL6vqvJXAsgTALJOJu5K0tnw9abl87yK9Ni8Kx/bZzgvokvqXRYhM
 KqHeQxKKsz7NCIWgLRm47BLxnD1Ef2nlFYqe/VVaJHvBARakGyYva95oes/HH+PHCBK4
 kVIBaN9Xw8t4neNkveIs2Oe87lh6/U4SdbMIkxlnJKzkEKA5+BUwS3kIH7B2ivrQ66lD
 sv6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cSncCZF6L2yFFOw+orBxZrqZMxde5lHphQG3sGKShfQ=;
 fh=eybldZBXeZ25kcSUWgn0EFj7euTPyUYAWUYWgJkJ5MY=;
 b=DPK0q76KhxDK5wevvLRp0eCueT1a2zAossQ1ITlp5rdIEOggUvDsU25z+Kv0WjgD+M
 RyEMS01XIvkRVENAmi+un3P9Bi7bcHprNMZULtwwvL/y7B8fCCeKCYRfK+Ad2gkVAyYd
 M1ZipUCnez090TBedYBVYpVFKc4MacaulmQUPy1Bo4xEfr8F+jNYwv9LhVtgSF6tyEg8
 saZPhKNp1jlrbUKBdnbI6fBBFW9g1hTr0X/xKPOYpwQyBvlY8WgecufcpWmVJFmnJ0Fv
 ckTHub9fftBlV/i73EHY8I6jp3nZZedZZOQjVacOZvQNuLyhFjdGjmLUESlXx518rqU3
 D8RQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787226802; x=1787831602;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cSncCZF6L2yFFOw+orBxZrqZMxde5lHphQG3sGKShfQ=;
 b=VNk8xopYcLBva7tpKmXplqhfUzdIufC4kLcAJk9JDktYbPfMthUqTfD28+BrjQaBLm
 jqDyVO2IvJSAM/V0Nr/1tCxqqAFnqvIXSj4uoZHd9+fPAJtSPUHQDhhdgxInMnKlNW5z
 Des+Ld5/kp5j4sGVSPIhGWS0Y3Wep8HLP4+38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787226802; x=1787831602;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cSncCZF6L2yFFOw+orBxZrqZMxde5lHphQG3sGKShfQ=;
 b=qX8W+fUiLmYNbLOh1/W8z09vU0DrrRFCvoqVpPx62NSgwkgNAkX1gudmbQ6qO4a8zA
 d88vcMdtlr5SJVfAGnRPL2mDBy2ngO7O20YSTYe2YgxNS3JkN37olBABZf88G7Mw+mHe
 PdbLeX8b01pSxaYKcOJVQOxQpHyEjEUJvI0wcFzjCyGM4xcJBDVFFiKUamxKIHOHoyyL
 88099QucOob117AaLula1YRkvlLOKPUwcNA0yR4hQPccXyD6Izqy3FLQVjcE5D4i/b2G
 mpH9+CvEe1mIu33ew/MHtZMBcox5Z/0/4MlXB2V7XUnXEY4CYjVLsQmRX7hQ97nY64Gj
 Wojg==
X-Gm-Message-State: AOJu0YxpRoyI1Up7pGKfr7RHxjO8oaryrMw/lEOlyNU+nOLJyow4eqfY
 EQWFxJ3G9nP5Oyv7kwekShp8GrjUTRcGRNT9Sc6xmAxOEGu1QmPmuHV4Rx8gAV+nFiGKMkoTotO
 0DlX0WGtBgB6B/E2YiL1KVTdGTzN5n21rPQK3uocHmaBhymRwNso=
X-Gm-Gg: AR+sD11u1k7CdSNMhQ1bKLeQXbKMryVYYR60pJHUzt2HkOC50xvR9Mu93wFd2S0Z/2t
 lkDr+fSQ0sg2E6LMELt11IfAT2IvTBEInogmInMeAm4aXtR0gpbCZ+k1E3HWUZuOIxPDtg9ZMPh
 0M1jmCQNF9LlcJKC0mrLRRV7rECDTIfp/KAFFZ481FHCaS2W1Lc/XIkYE0LHla0DMdHf9fx0hpB
 rwVDhcfAoO8BxuHCVosn3+2w4XGrRBPtIhWnKrwxOozgRy9jUpC6O1gzILeEc5jacZFjt5q04HN
 7JKu9QyUmKgBPWRkpX5M9fc5i+I6Mzkgx/LGtQo4BIA=
X-Received: by 2002:a17:907:9307:b0:c21:74ad:8b11 with SMTP id
 a640c23a62f3a-c23fa1eea4fmr734229766b.15.1787226801807; Thu, 20 Aug 2026
 04:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260810-b4-fit-ext-data-hardening-v3-0-17184cdb87fd@binarly.io>
 <20260810-b4-fit-ext-data-hardening-v3-3-17184cdb87fd@binarly.io>
In-Reply-To: <20260810-b4-fit-ext-data-hardening-v3-3-17184cdb87fd@binarly.io>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Aug 2026 05:53:06 -0600
X-Gm-Features: AcwNN1X0D4jLk4WemxteatTth2J96htFIxt05omfq-mWbZlEveKp3RRf3ZXYiMY
Message-ID: <CAFLszTh6dfKvMxzaRbq0Y1kAwS7OSuxXMnrg4uOtmv38sgAgvg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] spl: fit: Harden external-data offset and size
 arithmetic
To: Anton Ivanov <anton@binarly.io>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Francesco Valla <francesco@valla.it>, 
 Anshul Dalal <anshuld@ti.com>, Randolph Sapp <rs@ti.com>,
 Binarly Research <vr@binarly.io>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 2026-08-10T22:09:53, Anton Ivanov <anton@binarly.io> wrote:
> spl: fit: Harden external-data offset and size arithmetic
>
> The data-offset, data-position and data-size FIT properties are
> excluded from the configuration signature, so they are attacker
> controlled even when signature verification succeeds. The offset and
> size arithmetic in load_simple_fit() can wrap on hostile values:
>
>  - adding the external-data base offset to data-offset can wrap past
>    UINT32_MAX,
>  - get_aligned_image_size() adds the block-alignment overhead and
>    rounds up to the block length, which can wrap past ULONG_MAX,
>  - adding the FIT's device offset to the aligned external-data offset
>    can wrap past ULONG_MAX.
>
> Make get_aligned_image_size() return the aligned size through an out
> parameter and fail with -EOVERFLOW when the computation would wrap,
> check the two offset additions explicitly, and compare the
> block-aligned size (the amount info->read() actually transfers)
> against max_size before reading. Do the same for the FIT header read
> in spl_simple_fit_read().
>
> Signed-off-by: Anton Ivanov <anton@binarly.io>
>
> common/spl/spl_fit.c  | 98 +++++++++++++++++++++++++++++----------------------
>  test/image/spl_load.c | 57 ++++++++++++++++++++++++++++++
>  2 files changed, 112 insertions(+), 43 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

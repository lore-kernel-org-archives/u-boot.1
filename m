Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA8A606A31B
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CGlVS9HA;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=QWvFyTtB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0784A81289;
	Fri, 23 Oct 2026 11:05:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B3nFV0Yl9BK4; Fri, 23 Oct 2026 11:05:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 303768121F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792753548;
	b=KJ4F42e2bntfpX67CndcOSECv76xoXSA6wChmtIuiyklEUxvIcAM90S/i8TWvXhaxW0t
	 w9tbSpbXNKFgGjKKriFmeMZ08hFV/7rI7ts4OJiFIzj1D+Ssmo0MFAMj4gBne3tVZwyXu
	 uucW3QY8QOK7nkyAbuX61isfWKI+iAae33UrxuzBoyFew5A1+UOKNJYafv4on/X0wilqb
	 IfhdCC97APh98g/qVsDrXIwP1v1O26XOrVqb1ZNuRIh2ahUd/ErcuFSxkP/M7zxwf7sAO
	 e3W870YcrWoRKrPsAjLbCMA70SSGJZECkDfivboHzDUm2r8ffCNqYHl0N/vhOFNbHQw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792753548;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CL88QhjJXKWzuAXHrJ9Ig+QFmeksXJtnWlVIDLWxQtY=;
	b=VY6h9mRXHwy4R9w4eluCazdzkuz6hOqn6UHA1tDfErPoYxcwNVbqnW7lhc2umcwFwrI1
	 PCUMxGbxZ6a75xLnmgRvwqJBPDTQPUqmg3D6takZtuUlvT7RVWIGVp37D7woan/3MBFS7
	 abd2+FvyWBZ42a2UauNo9RaPEiQSoQPAejhrNQNsv/qxM1vA0HBI7jQyzBzx3yk9h1HK1
	 EHagV+EL7O1n2+V2DbxpxY2z4e7CspP1Ax1bEN1vx8nnNjMabjqeyn4XKSh2DFzMyG5dC
	 6n3xxVSwoq3HCRZwKW8GBM2lqHmTfYeE3/8UVWk84J4lsSCVjuk9IbWxN6TBLqb0BKQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792753548;
	bh=CL88QhjJXKWzuAXHrJ9Ig+QFmeksXJtnWlVIDLWxQtY=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CGlVS9HAKOxhdsDiITokX75VMleuggNzqT3KC1PVk/KLzwXoYAoFXsWH9A8pnMrw+
	 g5wxrdHStQF/g7JU8M3nf74bGRYwYsvrtsi9rFg3aVAzUJrRDPzzrXcA7D9p7HjR1m
	 gZeyG1h9ZZQFMCq2WDaPhbUdkcXv6EsQ+082Do4FMVOQMgdPSfMWNFeaJzWGJXyMq4
	 5R9z8JI0eh3JlP0W8/k4R7slJXZsyFUEs0JZs3O1oasd5rYd94DfDTTZCxcTJpluoM
	 JnPUxSG/IaY3xSAn/ZANnzF+aEL966C5uauUdnJN6My8g9TTpDPwKNgYGEYI1xg7sc
	 TSp+JOQo4qYzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 303768121F;
	Fri, 23 Oct 2026 11:05:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 39762235
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:05:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 32D2840911
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:05:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fhc1aEerrp-Q for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 11:05:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 357C040904
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792753546;
 b=ita0r/VmHzPm9mUJiqv1NquFZ7/w/J2eaS+MHu0OjeANYFwSgTeFOEdy0pxZF1PwBwUP
 0coSpavDCeuWpEItes+vEkpGQoGrrdm63A6EIvL3EFzeF10w6XF09bckRlLPQMsD/Hpgp
 xQNpEzUIWPncUbk+EXb56XeyCB8eMbqSrNsVFfWwqNLhSoVRa4YT6NTGNcCTzaM//Dto4
 CMXJnei1ZH9V2QR4ZRg+KxhOD9Fffok1g+JIAKJHHM84htBUw1/TJDIAKy9PLsIMBOCuT
 /jD8oUy201A/rwjaUQxmHkYdleGi8/72O4+H8h5CwOESUQDI8QILaQK/Z3YfR1/PS9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792753546;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=CL88QhjJXKWzuAXHrJ9Ig+QFmeksXJtnWlVIDLWxQtY=;
 b=O+fNj+BxvL3Jg21yqephlxOBy5WQryBU6T4WJxRKEcmv5jG3sidxowNSFS9Pmu6N8J3G
 eSAdrNDyMCS27xZCUl4PhuJgQWq3MCzvIDXdXkrtjspk2X9k3EBTe/4MJuGYQ4sI7/8sM
 VOzN9G+ouDrKRC4/SGg6JTM/+ZtJMTn7qYszxFV3q3KKXabK9gl5RMmWk80P3hokeX2H9
 Tx4u6lePFN7tnwg5Z7BsaNwuixNRDnW+42ZN1zfylDxCVS+/u53486rb8lW/XSlYDJSo4
 mEaUPS7e99RgxXHUU57sCgtyviXgIbaRarhFQaRZr4JvqKVNNLSBH7oUi09siJh5nkQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=QWvFyTtB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=QWvFyTtB
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 357C040904
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:05:45 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6b1afcd2d23so993783a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792753544; cv=none;
 d=google.com; s=arc-20260327;
 b=N0fNFUj4pist7JJkh827PyC2JlcrXpO8ZTjncjPhtPheSk9RTD54Co+8B5mDZiA/5c
 XqHJ0nlmt/SmMowfnExdq1TWPTj5THnYcfithXVllGowrY/fCmyJAih7PNuR1jJB9+ln
 1uCdH546MG9dOYZ4GtIq/aVf3VIydX6+IGs+ww+lNkN6SvN13o9FLbQhBVO9/4kukTRT
 7lP8T4zqd0VYyrdP7qkqcAKcqTJHYnlLhJUa2KyAuoymwp8LOcqjeSLBsoWZQhSQ9WQH
 0mP5BbXsS87dnEWfdO0Z279LYgFbcIFeTnwFW96k6K6Mseh5N9FqdNBk6s6cTQwlswUk
 7djw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=CL88QhjJXKWzuAXHrJ9Ig+QFmeksXJtnWlVIDLWxQtY=;
 fh=JBnubn7OSfLFynVu0HoHbzvPo+RL8VbQ1HqzkZfZtIk=;
 b=RchkY1sOLOZIPJsoJyAkrZDOJZEh1DtCzM+8FSNZL6rJWkYzgzZTmlCH2Q/YqmyLgp
 VeExwJ/G+yqJWL2Lz6NfiUij2LxaqdPPowMbXRD833KLTvELmF1y7tYYfy+nrwbX/FHa
 iP9dFePPmCyTxMJYRkV6+8swKIjfuEqOGmJl5s6pY9GuTl/+WhPEhv+g0o2ctwaKRATq
 //+aJHlmFJnx+5E2R3FfrnpdZmSs26U+swnJpEzpG1Inmlm0GJyxi/77JvBrdK/TCcX0
 TqH0KZUFF7WYkIyUy9UXC8c2+jkU5E5Ed9trmzpyhgjM4rYElXlli7Z0ubd7LfGHwJx2
 VMDg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792753544; x=1793358344;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CL88QhjJXKWzuAXHrJ9Ig+QFmeksXJtnWlVIDLWxQtY=;
 b=QWvFyTtBEEpxxrk4BX0APFe3wdhFvAMuRBwZFbmeh7FcSyt1dHPl4y0CriTdyOvPhY
 DHR+XqyO6p+PGvqB7DFo1MJhNCP4oGIImZLroiUEw6Xql1vnntiBvcHh+MkdBCLweIhU
 9eP5sGSrZ+x3sNgXcn6maCvqSzp079rypqNXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792753544; x=1793358344;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CL88QhjJXKWzuAXHrJ9Ig+QFmeksXJtnWlVIDLWxQtY=;
 b=WRk+MrobsDSaMDdP0ICdEk9//ICg/SqVWICTN5645eYmk6IWQCwmi5upb3rnOcKLQc
 eCcfG3Bs4bcL3O4/RCnF2PJp5b/3D+4gZZRFf6LBKflknxzWeeyqgY0rX8rqzLkPbaRB
 IpPowZiEPnJ94iD/7SAGEFQke3tou3E7wbZzEUn6rOwyHwefjxbIohdgqwzTZDH9X4l0
 VLW+plUltFuk+Shk9tKlxcAITie/xfZXA+AxR4SEuNwRCi71XP1xlaoeMukbhU4N+gub
 3Cwb41LfqAgc+Th8v7tl1kN4dMwU02jwglAyzn7vzq/c3pdR8frLhzjhJAIMrfIc1irg
 Q4UQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZI5Ymco/Iss93ucYkN0/NIkAQ2MJ7p9wUiE8cjlogPANXBhdtcLf0ctjpmIjQWeyYBhOujuQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLczUubcLhhFBj0PEW1k1X8zn21Ob7gqpeeNw+Uxa6XTRLomuVe
 i59BNYXki6b3Z5w3Cj8cl/rvc2H8OOmJBZoY90GH3oaIYl/cOAbyh9fgbdAhbZ85A0LQVUi39GC
 KjthqjEvvo8yZWmO9CorDvFl8v4TrZ1qM9dwxsEkw
X-Gm-Gg: AYBFou3XpPzIm9t8imzjyaRyAHzOgDxPBhGPNCgGTNsmrtUs8zlYMOQlEHBaXxiFbYd
 TWTVHCCZEligT8SFzMmy/Gnud1xSDSxNcatyJbJ9bM/d0lifVIggm2kkiGF76e2N3+CyadfPnDW
 8w0faDA5xEu+IkKZ0ZkCBhMW3DWC3dAnX1xFDMrVqC2BJJMIw/NQ6Q8KDuo8ej1ZbZYTR0tt0QO
 gpjq1sC1TrmYvyZWN6QlbE7t5vP+sVqsL6SX9l0w327nv8Zss/n54FWKSdMEax6sZAqC8QECqDk
 AIYvvwn0x5RVcRZMuKZs8pk4Dl4wYdzqlJGCtEfiEAU9yLuapZyNXX+YKAcUIyNATjHioNtEOpQ
 C8j7eKeTEGuJpqyULv6YP1lsoe5bwFJLLQ6M=
X-Received: by 2002:a05:6402:8d1:b0:6b1:c2d3:6a6e with SMTP id
 4fb4d7f45d1cf-6b432bd8683mr1971736a12.8.1792753543065; Fri, 23 Oct 2026
 04:05:43 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 04:05:41 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 12:34:55 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261022-test-avb-fixes-v3-5-d3a6ff9ba097@kernel.org>
References: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
 <20261022-test-avb-fixes-v3-5-d3a6ff9ba097@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 04:05:41 -0700
X-Gm-Features: AclHuK9w-RjeJhTA54xbRHN2gQ1HZRSJuvx3JnBUGtA3Z8Zow_ghD_-paVRJizs
Message-ID: <CAFLszTiMpFMy0UdCfvSiRMwzgpYD0+mBswMZ7jxqApv7869wCA@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] test/py: android: Add create_gpt_image() for
 image creation
To: mkorpershoek@kernel.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, Guillaume La Roque <glaroque@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
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

On 2026-10-22T13:30:29, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> test/py: android: Add create_gpt_image() for image creation
>
> There is quite some code duplication between the image creation for
> mmc7.img and mmc8.img. If we want to add more images, this will be even
> more duplication.
>
> Add a common function, create_gpt_image() which removes all the code
> duplication.
>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Tested-by: Guillaume La Roque <glaroque@baylibre.com>
> Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>
>  test/py/tests/test_android/android_image.py | 93 ++++++++++-------------------
>  1 file changed, 33 insertions(+), 60 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

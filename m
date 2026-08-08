Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C00C5AD2C
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 17:57:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1BC6A40497;
	Sat,  8 Aug 2026 17:57:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4fKYb015PG3O; Sat,  8 Aug 2026 17:57:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 51C5740475
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786211843;
	bh=R7gOgKsYyQmjUvFVPrU9f0CVplObDOgQ9hnZGCBzPnA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ql3H3RuFGWk8Eh6EP+HWWribg9f3J8YTMrFqe5tNoTgAXNhEvILXWxfjZgmRkpass
	 BQohW/RBJXRBtzc0rJy/JWdEnRlJf5WkHJgW1jCTverFXlXZakBSNrT9ZP4hZ3I25E
	 Dtc/j8NW8eSQZnSqMwLN8Vlml8Au4tRbiSegG3sgO34bvo9hg1bA21OnKMNVB959Ps
	 8Ph6QRJ0O1Rp/CH5xCGBX6hChCOBD0NrcGLpdW8HSyVnjMFY2yaZhNbDh1VvBSre7c
	 b0wsnt2Q+vs8woNWcgohj+wiAixz9FqBMKSTOtQndJdE4o6loQv1LFTYwRRnMUjzB3
	 PVit9cFvensyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51C5740475;
	Sat,  8 Aug 2026 17:57:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CA4340A
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:57:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D6E94046D
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:57:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4vBUGyGlXY49 for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 17:57:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8F0EC40473
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F0EC40473
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F0EC40473
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:57:21 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4aa99bdso597528a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 10:57:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786211839; cv=none;
 d=google.com; s=arc-20260327;
 b=DsCrk++/E6fAojf+3J12R7bWkrCr0ArlQxAOyt0SYRtmtkWHAjN8Z+lwatCqTIeJi0
 Lg3pIAN3BTbZwXbnjRUnPPPdII5rizui7kQ40Ez/5URSNirj09lnv5O2X2WwP5lUcMb0
 JR7rNKl0zJpe0luvzTpF81/7gInGi87TeN1oji+b5ahnHPSBhvd8TQPeVp8fqzD6LXqn
 XCSV3gYNP39IM3qiODjXuao+IkvX4BPGfd8oOq12M2RKxPxr8ov3rYPx4apwqQc6D0sy
 wViij+JtNHm1pq7QFkFag6z39Yko7EPupSP68BskDY+25qfAQxLGe1bRifXf58m4kOqx
 vRLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=R7gOgKsYyQmjUvFVPrU9f0CVplObDOgQ9hnZGCBzPnA=;
 fh=8TbiD9fEG91wSNsvqqOput+PpnqsIRDXX+RXlsylxJ4=;
 b=XiL+45gzISHDyYqB+En+b/Cx+BmpLR3bTJZOk6kyaJCnB9rNNPjGTIJ+OKXXtTaGer
 /zmiUjrrTSwoWXjKWBYb6AIMSaV9IYDhVf5DTQ2YP2+yKlblfcudD1iozTCMJonIUCgX
 uPXkL4utb8n2aF0gdNDbfO8uDqW1Qvc90y0/R5dPzx1wJIrMQ6ni44CPDhxpII3ufPS3
 FjzOkoifZ3cce+BllS1UHin009CZxGK8yG4Ty5oKMdfrI5T4MVDUVkNVd1ASclRX+c1F
 WeNQtdYneY1KvSM345OJwb+lIqfApJycT5qLzFdDpD6a78Qg2MwCqFIwAvUD3SGEKWzr
 j1bw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786211839; x=1786816639;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=R7gOgKsYyQmjUvFVPrU9f0CVplObDOgQ9hnZGCBzPnA=;
 b=iBtHa99hV55vrfL1NztnGG/6QpngA1rbKaCwjDCZYNAeU8pKJwm8xr7JTT+xLwVFRU
 s5UKye0ub9Lv1xMLMjyn6hZNLIhXXc/+0jSzkyf87E0dwvBtykaL/3mmZy8tdzo4aFan
 TZ2tuEB/LZPatkpka4PTU/WUgSijf8tBmLipf6gGIyV8DnhZfo8+bgkYwoN8DTpayHYA
 WLzP07CO/6GnL7QI8PYN+JDLOxiaoGmrXy86vP0erSr1ETl00cSsmEG4eBU7BLBoHR+4
 LZBgzEdyrkSSsEQ6ygUJ4lUAFnRmsyHBJQHWx9EQ33ZdQQxqRjQNLPJVvt8SEti3DtnR
 VcEA==
X-Gm-Message-State: AOJu0Ywxw+Xowi9V9TTWMfNx1QiiCXrqqo7OIIGG4wfxISwH/V7aL7Bv
 dunLGlN68zHmhiH+4Y19QFaVm7/ABbiqN65lbP0DcFpUbphgMcTI1XZnNehdFgh86jPNWR4do4Y
 91K3Xvn5b/WHlZslcz9w0RccMxwYOOp044mIWUlwQ
X-Gm-Gg: AR+sD130v7U9P5d6apD9R2r3c2UMDj0Lqh9G+qRAG59vzY152PYu5PMDK1tsrqPLLE8
 +gIydd+kGssaGBSdMoJlFRVKYft72XotZ2LbaB+TrVqi+NcUH/p1l8COVbp42RP2yD3C103rrLh
 PhlocsM9ox9bxXSRVH8q5rypDsnVwrQb90LfBPxeVKvhZI566toKwPkSUkLh22DbyP4Dly010nI
 KXZOae80Z+38IZgQRVtnTX4alV6VJny2oBvBGb3Z98sBu/b7OueLKhsUQKYD7BBy/81tICGNFVM
 gXlxcRKFuJwWEhVdgPBFm3bVK9xJRm5niIo9DISxqYI=
X-Received: by 2002:a05:6402:43c7:b0:698:6084:db7f with SMTP id
 4fb4d7f45d1cf-6a14f138ae3mr16160801a12.10.1786211839546; Sat, 08 Aug 2026
 10:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260729081218.550465-1-pranav.sanwal@amd.com>
 <20260729081218.550465-2-pranav.sanwal@amd.com>
In-Reply-To: <20260729081218.550465-2-pranav.sanwal@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 11:57:06 -0600
X-Gm-Features: AUfX_mxh3_fMxwmZrJ7quKLOrxZ1tm_4LD_hBk-prO8a_TxSX_IeBCmW2RjYY-o
Message-ID: <CAFLszTiGUcTjYt+4L7witP_wwPsUKcGnQMenLT9yid5ikxfwXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] gpio: uclass: log when a gpio offset is already
 claimed
To: pranav.sanwal@amd.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786211839; x=1786816639;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R7gOgKsYyQmjUvFVPrU9f0CVplObDOgQ9hnZGCBzPnA=;
 b=fwTL2n34XFzoy+awB1E17Dr/PsgHZvLANT+JBrkjUjLOagDvyBGc+hLsLQ+de+RcH7
 OCTcGET2WBEcafvZ1bsXL9ZaAfpjOVlI6PdK4GA5eh+YFG5E/V2mh90BcpUFx9sv9p5o
 DHg9ifDoV4I38QrlzlzpQJ54ZpCPL7O2yBq70=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=fwTL2n34
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-29T08:12:14, Pranav Sanwal <pranav.sanwal@amd.com> wrote:
> gpio: uclass: log when a gpio offset is already claimed
>
> dm_gpio_request() returns -EBUSY when the requested offset is already
> claimed, but gives no indication of which label already holds it. Any
> caller going through the uclass API directly, rather than the "gpio"
> command, has no way to see this at all.
>
> Log it at dev_dbg() level: silent by default, available when actively
> debugging with this device's debug output enabled.
>
> Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
>
> drivers/gpio/gpio-uclass.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

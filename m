Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54578C5AD2C
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 17:58:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDEAD6063E;
	Sat,  8 Aug 2026 17:58:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UT2Ulkz5Jr4R; Sat,  8 Aug 2026 17:58:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D32A60624
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786211929;
	bh=siOoaDGOJFGoFwvkcEp9DsDnLoSFJrXMQJx5A3xwMLg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SYJW13Sloo6fKuPNnrbDFdB1dwJDoGpIzc1mf717fhcrRdudaYfTaUfW71jVS3W8V
	 zW5ad1/uX9HnvD30SE0Ny09KEKFkwmxObSQ9gNtXGp7N3myW7OR11byebcTLkqGQRQ
	 ixsfkFstkWFGgce2wFj4rFIzxPm4b+L+p3zE+MEXrxP/So6i/vJbQbRvrS6AftL8Fg
	 XtHF+HQCiOvdueQEjCs2sKC7aYhZQeqVXcND/FF5LMvTemEyZmhwxDUp4VQfI40SsT
	 /BZbtRjfpXtl56/PFexsBUPGVuWJV+DuLEZVRh9KMwsTCfyOYeWt0KSJ5+BMsfLrML
	 JokSEODtk0oXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D32A60624;
	Sat,  8 Aug 2026 17:58:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 73F271AF
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:58:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6636380DB5
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:58:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VS-UP3823NS4 for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 17:58:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8B68A80BE6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B68A80BE6
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B68A80BE6
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:58:47 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-69c5fda04a8so826894a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 10:58:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786211925; cv=none;
 d=google.com; s=arc-20260327;
 b=le+gKMWasqG+tIR45nPPzE4bwQsMDZEDyUhLTHVto6+fFpVKEexABOM4y5KtArmICC
 mluPLCNK3C5qBcmRPW3g5DKsceeehN2GKTMi0xgR4i6SH/SaXXLE0X3/z/19epRmDSWy
 Nw6RvGmRphULVqfFSxJPyN1meJ3C/bfFmGmcIaVpYOmKis81Cyexzh43YVsm1bFSK1ht
 Z+Xh7vwwC4EgoMEILGbzYbzWPchAFT2/KMUxo+U2z3Qbn0nXnXfRSgLAgLNRNcwQ2LTU
 OibRD9fgXm+bHBr+VJsi5X7l+Cid/oIiSH+KkV6p2EV3ZwrrL1FYLaz9EiX6A1gtrx9z
 ROKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=siOoaDGOJFGoFwvkcEp9DsDnLoSFJrXMQJx5A3xwMLg=;
 fh=8TbiD9fEG91wSNsvqqOput+PpnqsIRDXX+RXlsylxJ4=;
 b=fL7pRCo+SrmS6Nj8FRf6f4mrbpn6PB1TVZn+z7EoIXxcY+EI91ll2gasAAiqhHUcd3
 LKo8rN4xEv3nxSYV4kgxUP5PZaipkyQ/NxWnQJhic+ppbgDu6WTTCKpC4Vezk1h/zUS9
 dC1kAS33wr+z/6iXLS4TPg//YrIepMFxwJSN4GMbacyEFPztUQee44Iu/JU2zNA2TvvC
 Z7SLtN01gLEiaNpNt5EU316h+S5JT6HZ5hux76dNJSyzC96sxt619Kmfv4dPS7uxC7eI
 Cah8uEGcFajclwvaMN6gmArl8EhRrRJFKqhq8dQzAGLnPmCy2jooeX0s+BdaTPcv71Zk
 8y6Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786211925; x=1786816725;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=siOoaDGOJFGoFwvkcEp9DsDnLoSFJrXMQJx5A3xwMLg=;
 b=BSZTaDyMt4bGg2GZRwx33mdyyv4GoRI7noNLh7rubtuPvt5G4SRkmlG1E4OyQhU0fM
 7+43xY8/ccwXwYyyDHMlchZXjrcTgEpHt2ZUjB6V7cUPRd2GYic9n8+ZhcPlq2Lqkdst
 pPvHfGqvefDmun3iZSCXeLcO3ID3wbRc+MDlUDMy5ymHeuq+kYarz6elZBkbHRGvtz0A
 9A/g3gpsJnmp1WXacxqa4IZwodkoLBDHDNAo+JHj61J4MzexTZzROTIQ/bZ7FhkW7a41
 Vcky6ZarHtkRqEeGZQLB3fM0rfnIoEb112WVXdWBNMG6cMqDeDY7bc/vsuH/FmYeB8i2
 jAuw==
X-Gm-Message-State: AOJu0YxsoTc1LE9mo1z96xtwjGz1eYH4olmmZZDLK3cYr2MsLABeURfg
 PNRoOP1GUmx0pd0uF4L1wxOW7KrHN07otgRtsqhPXpHwOte7X8cBQBGFJqqSer5BFSsA0BhX/qG
 2caSIuD96BjlmMkd7EhzFzBypMKqY5bEE3JgZvIqT
X-Gm-Gg: AR+sD13czFf/doQC2E5s40AfaJXZ9fm3xbRs5EGdXj86q3funDXFdx4Ehd9//cyAcSh
 +ATspZlfvkkyF6fxcG/4//ML2XDCZulyPQifZKxJckPamhfHho5V7fnfj1rbxZ8ruSEGQ7hR5z+
 Dysd9hIfZmz88GM+OYHz1LF7gS2rRxHPYslkxC/xrfayxzPCe6QmXcp1heOnwPlbAf/qnXShqV0
 G34M/rXsKz/tGqp4bxchhfnoCZawOdNVD+6V46pdwvdq6J9YwwAs4Uea1M2fLQ355PJIh7eD0ns
 CQsozXDSTpSv3wT1kEncREGMbgSoe+XcLHNnAXDUhjg=
X-Received: by 2002:a05:6402:1f08:b0:6a1:b0b:ba6 with SMTP id
 4fb4d7f45d1cf-6a14f13e483mr9876181a12.15.1786211925446; Sat, 08 Aug 2026
 10:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260729081218.550465-1-pranav.sanwal@amd.com>
In-Reply-To: <20260729081218.550465-1-pranav.sanwal@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 11:58:33 -0600
X-Gm-Features: AUfX_mzZJF1sXgX03-7P4-MKXdlzCjEfvmQ2M3vj3JCmI9QRxw19Nt2eHjNkTq8
Message-ID: <CAFLszTgSKL4SRDOpej4-rd2CPtNuLVbA=L9yfCLhy9_g5E9ihg@mail.gmail.com>
Subject: Re: [v2,0/5] gpio: improve claim diagnostics and fix gpio-delay
 offset handling
To: pranav.sanwal@amd.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786211925; x=1786816725;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=siOoaDGOJFGoFwvkcEp9DsDnLoSFJrXMQJx5A3xwMLg=;
 b=bjOelfeVnx+SXTRg/qXxxRle6jXTx1sTcqshJm4MIUEY9vJ8msNvbGVkoEWdzdt957
 f/cAEX64Ur3L5r07j+sBrwJhQvRb0bci7d0RHS/jqZ9p+cOTee5WYAIp/muyubd+GJR2
 Q0coH6GRvQ6V5+PTJ28rrSLzMvdBTYPdS9BKA=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=bjOelfeV
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

Hi Pranav,

On 2026-07-29T08:12:14, Pranav Sanwal <pranav.sanwal@amd.com> wrote:

> Changes in v2:

Could you also add sandbox coverage for gpio-delay ? You shoud add a
gpio-delay node to the sandbox test devicetree wrapping at least two
real lines, plus a test in test/dm/gpio.c that requests both consumers
and toggles them? That would cover the offset-propagation fix in patch
4, the gpio_count/bounds fix in patch 3, and - via dm_leak_check - the
remove-path fix in patch 5, all of which are otherwise not covered by
tests and might break at any time.

Regards,
Simon

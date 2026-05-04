Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6A5CD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 409A4846F9;
	Mon,  4 May 2026 22:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F/yQERq/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40B5E846F9; Mon,  4 May 2026 22:31:35 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC6E1846A1
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c80167f56cdso760777a12.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:31:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777926691; cv=none;
 d=google.com; s=arc-20240605;
 b=M4+y7ZaUxaDOj8yBF5053VZPjc210OnkSIfo38jtFm17el1n/NDHjLb4VLBGYnaHNN
 lD6Ymn8uBf3ombsqziteoFEk7oy/HKTUQ3odsGDNZSJErwGkKqI2ELMUTOJKuE3FctzC
 SjLPWY2iGVsqDjNwPVrhgGQFlqyrgBiw56B7OPMKStUaOXodJ/LrnZA5ZaD+I++qrchO
 aSdukr5RyI5c7Bn4hYFRH6Y8L10SDgVcP3+LkoAelZLq7U4cxaCiAcvC7gsm5CSGetsU
 jjABV3YS9tV4pANMziT0ziKrAaAeaOCdF5ak22muq+XoGgznq7lBF68WokHS+XHOoviG
 VOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IfEiPvEJ2j6Y3LyaCx5hLM7rdFIoVe4daE9RqMY0yGk=;
 fh=JDmMtl5m1ONTYAIDZy3RW95Kei7pwM4OcFAim19m6HQ=;
 b=EbWRdaqxJdKxE7s9WMNGyTJFM8v7pwuMxOpaF+7UnjNSxxJia2UBSJIOIAud9aa8hd
 SpM307a/3SoquSJYsfTdci4hurcO0YD4kc/7LzuN5DBXQa/mBFM7aJwQt5ZAnZVIeJ+/
 oIkQ8E67PbxT1g6cR8+SjHHU1jm0blgBaubGkmPJd/CoXFGrRPwFmknYV2Sb4tlOZy+i
 9OFa/egEpPlSdW1WpsLPynCvwe/ZQyJY4zuLvWUAHUDDT202TuUKuCJW8JGCqC/zuC3i
 llr2lctACA+L2Ng6d0UzG+XZM1pbwrNzfsVLHlysO0yGsLMM0vI89tzB8H7Lxss5h93y
 +AYg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777926691; x=1778531491; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IfEiPvEJ2j6Y3LyaCx5hLM7rdFIoVe4daE9RqMY0yGk=;
 b=F/yQERq/38/4l26RLC4zj6tQBG6E6Aam4+F7x5mm+341luWFErfTTNyZfbgw29qVBA
 jdpmN1nr6VjEjbdguAN+bfUbAM/cb6I8IlhVhd06o9+1gFLCMSIe5I8WmfvbcPGIyAiB
 bCDkYCClm8FkLIN5ajIwlK739dxr8LphZu6Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777926691; x=1778531491;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IfEiPvEJ2j6Y3LyaCx5hLM7rdFIoVe4daE9RqMY0yGk=;
 b=CNVIsQYjHoN+oVrLpNHLwN5gCVCGxV63vBmr58ntlP73hYlMFjygbH6Ta9f5gAjzkc
 Zl6dqy37uikHMaZtB14ZZxzJl/T907iaDECAFbj2ezAtKJ4MW3pVZ2xyYhXZhf/r2NpP
 UNOTitBIJTZvYggjyip9SjxaSR7byQvDsi+m61RYp8eWvYm/Tt1pwabYhkTu6O4gXA4h
 8a7IRHch2n8kr70yct4QXKsDBxezFBJBxegfDueHIxf0r1iZAXU52UEGjQOeTS3kzm/G
 Ix0rrloYhYAftlnWgWq69dIm69npD3cc6A54nIWDznP+SGx7eTPALJeAPy3zf77E4P9E
 Fu4w==
X-Gm-Message-State: AOJu0Yz0ZDJhKkm3EcbTj1AdZ8w0CbsI7tb35For6sjvi5LCxbNNpx7n
 o8E5dQTtS6KoiooMREEyd2Pztp9m9ZyXnfn9FFyiFykgXnIVe406SBC/Eoqp2ccQ/hEyBORxWXs
 GTjC+2z0KD0p9h0Nqs6Gl6/bxsJhtH4urOaFWWoUJ
X-Gm-Gg: AeBDievDc4tiI1eTsaCxZ0gKWU9u7ZY1Hk7Cb54Q7UJ8ZnBR7pGiBBzrhNwCuW7qaw8
 lHc1jq4yw5MVCIvTNTAY0HWh+2jiZPqTrLhlWP68X/I4wimIuckBtj/YKb5956AqVOvNOlFdl2I
 BqpKh8KrkKCt1wp5J8r0nI6noOCAlGL8Y+TH7xKiFcEYkUZkQBNnOukDQZC9IMRIvMocatnTK3/
 aqkYBx16KM4BtxhvtTNsH7NsgDq5cQCbMgPhCYA+hAZQq+JrbmKUswkpnJT4UTMeb7e6Oq6Wb1z
 xHR9GNvWZzLVcIPK
X-Received: by 2002:a05:6a20:3949:b0:3a0:aee6:acc3 with SMTP id
 adf61e73a8af0-3a7f1c24df4mr12093807637.38.1777926691465; Mon, 04 May 2026
 13:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-13-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-13-b19301d1948a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 14:30:45 -0600
X-Gm-Features: AVHnY4K8WcNJjScuZIhqpn3TroRU1a0EgZhlTmrTZWsU_uO87yKJMWZqDcHqqd0
Message-ID: <CAFLszTjjLL6nPm5HrPF8hv-w1=amRaunXM6-9mEKZOwCpd3Cew@mail.gmail.com>
Subject: Re: [PATCH RFC next 13/18] kbuild: rust: move `-Dwarnings` handling
 to `Makefile.extrawarn`
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, Quentin Schulz <quentin.schulz@cherry.de>
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

On 2026-05-04T13:20:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
> kbuild: rust: move -Dwarnings handling to Makefile.extrawarn
>
> [ Upstream commit 592b571f20c5b905c47a1370210456f9f90ce04f ]
>
> Original commit log:
>
>   Following commit e88ca24319e4 ("kbuild: consolidate warning flags
>   in scripts/Makefile.extrawarn"), move -Dwarnings handling into
>   Makefile.extrawarn like C's -Werror.
>
>   No functional change intended.
>
> [git conflict trying to remove KBUILD_RUSTFLAGS from Makefile, which we
>  don't have in U-Boot]
> [U-Boot doesn't build anything Rust so this is useless except for the
>  fact it allows to backport patches from Linux kernel easier]
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> scripts/Makefile.extrawarn | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

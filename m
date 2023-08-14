Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D676C04A6A
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:44:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B90A086A0F;
	Tue, 15 Aug 2023 00:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V3imQ0RQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A5FC869C5; Tue, 15 Aug 2023 00:43:11 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02B5886A13
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:43:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fe8c3b5ca0so7841258e87.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052988; x=1692657788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7fQSkk8X2dIMQbMffzAD4huaVfKwBWzwREYy5A8Wn9w=;
 b=V3imQ0RQK1ZFzrl0VNM+OqHIsTYbq6rjXATv9tQ3NYWW6V+g74fja4HlOzwmW8HPSY
 2lQIEGSu5k9EMvgNB93Tdr+5I41fb8BVpa9c0ie57EVXrbHfZ+fbcDPyucS6CWVR5KbI
 wsG3OZaj+GhfT56gkOqYL2uHZwbhRUazWp4rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052988; x=1692657788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7fQSkk8X2dIMQbMffzAD4huaVfKwBWzwREYy5A8Wn9w=;
 b=gy/nYcGx5WV+yoG8eJ8jBvRtPJBgLpzdGD0ysnVsNqwLnRCHmUocUc1UvGAcVLJ1tU
 gumMqcgubwNPnEhkFIV2Yy3vd3+1bdj5CmW2b2o4YM4/E9mqcviZJGGX9GgPcQKPt9Ei
 1LVtpJMSpGTgB4k94HQkc3umQV8AXsK+0x0s5B4lfByguzVakuaSNg3z5WlNYcDN/JAd
 2Glr4FzXZ/QdNyTjfntFhAFEJ/HETE3G1D7PZIwseOP87ka8XeJag42PRewznOquj5J8
 RaVW5waNQKlaGFhGfUsjLllNEYvEHjDiKKB5gPQReKHuuewciHeX8rkVyuQkKuKx+no5
 rbMg==
X-Gm-Message-State: AOJu0YyYTGcpMr2Zcjg2QBhn4Us0rN3YA5pYt9yb29y2OhHSJ/5dq7gf
 z5SA7dkrk2hrDkyYt2JTNPGivN0LZp9obLpJCHJk26Xous2ejNSUQnM=
X-Google-Smtp-Source: AGHT+IE1zS3OJXYrT2xHmoCaoUXp+oS7g/S0XrpO7Z3j44BPMcmBu0nukzGx+BBJ/kmf/brHL1senICnqN3SJW9PZec=
X-Received: by 2002:a19:5004:0:b0:4fb:5dd5:715c with SMTP id
 e4-20020a195004000000b004fb5dd5715cmr6585871lfb.4.1692052988010; Mon, 14 Aug
 2023 15:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230813195029.159409-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230813195029.159409-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Aug 2023 16:42:51 -0600
Message-ID: <CAPnjgZ0vTW9mPfkv4X=gPHQRkmB=TayZdbpA1TjdzJUq3UW5Sw@mail.gmail.com>
Subject: Re: [PATCH] configs: sandbox64: Enable clock CCF driver
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
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

On Sun, 13 Aug 2023 at 13:50, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Align the sandbox64 defconfig with sandbox defconfig. Enable missing
> CCF and Sandbox CCF drivers. This fixes ut_dm_dm_test_clk_ccf test .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  configs/sandbox64_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

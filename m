Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243B7CDB483
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9B6386F2D;
	Sun, 15 Oct 2023 08:45:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PLzuJFVV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77D8B86F5C; Sun, 15 Oct 2023 08:42:59 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 940C4865A8
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:42:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32d885e97e2so3401806f8f.0
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697352163; x=1697956963; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1MelmCllhONeBMeRtaRj8mbBAVmuNVcEC9XqFqt1Guw=;
 b=PLzuJFVV0IZjig2kYlTyoMbY0LzzEzSjDMD7ooUGCG2jQqDY7eksNqPjzLAvz+Zcxg
 qV4GWDKmI6qHsjNFEvcf1CqEhUtgotDaW/+hUHyC5yldnXzSXsgmNkoJDun2Y7hquAwB
 vEbyUqf11YgosNH4fm/8K9ebyQzarLOxM4//c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697352163; x=1697956963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1MelmCllhONeBMeRtaRj8mbBAVmuNVcEC9XqFqt1Guw=;
 b=d8CZp1AKPNhOraWYKJ9CdqmjDrZaNiEKqKNO/JawAtqe8LINIxH7fhFr2+1BnckNQY
 yRzz0qrLlw5Hsj2UsGYV7XyBloPo4q5gZwi09XEyNpT+PuD1A80XuOLbBUnSbCHe3uZl
 BOPnbTdRSSzs+hz4z2pSenS3zCoPvtqr08e2HfkkqwqdFpZQ71+3wND+E0lQ9VHKZc9S
 ut/fPisxnhnPSFTtdQaOgqKrskVGSW3KhovyKJZp6POmzX/6Iae/5+HYQg8bcXOj8+Ah
 W9wHU4+/sNDgJHCn4tzXtBB0OPUuMam9lBD0r85GgKKfiKKAm+I50aNIPVervFdEg48G
 cc5A==
X-Gm-Message-State: AOJu0YycUEyhSQ3fBukqhvEHf5FQldjgfxbUb1TKoyfT0mNHB3NPKrND
 PojHO3c9Bvlq9N+sQwrbLtTLvLgXrkdm970pUCTskY9xH6A+mqgyI80=
X-Google-Smtp-Source: AGHT+IGgXx1GB7nKL2fEiQHh85BcyhWspikfiAV1sC0d3f4oaO/5XSq/AcE2yUraVxPDt//VAN5lO2Ahxqu7G/2xNCU=
X-Received: by 2002:a05:6402:3213:b0:53d:eb53:4d0c with SMTP id
 g19-20020a056402321300b0053deb534d0cmr10957175eda.37.1697326519805; Sat, 14
 Oct 2023 16:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231014204805.439009-1-seanga2@gmail.com>
 <20231014204805.439009-21-seanga2@gmail.com>
In-Reply-To: <20231014204805.439009-21-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 14 Oct 2023 17:35:04 -0600
Message-ID: <CAPnjgZ1AihC7F_otXvcOvEEddXQG82PBwCfK8Ha9D2vRTegWRg@mail.gmail.com>
Subject: Re: [PATCH v2 20/29] sandbox: Support -T in spl
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Harald Seiler <hws@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Sat, 14 Oct 2023 at 14:48, Sean Anderson <seanga2@gmail.com> wrote:
>
> The test devicetree is only compiled for U-Boot proper. When accessing it in
> SPL we need to go up one directory.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v2:
> - Compare to PHASE_SPL in sandbox_cmdline_cb_test_fdt for clarity
> - Split off from fs test
>
>  arch/sandbox/cpu/start.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

BTW that function is in mainline now - spl_in_proper()

This is fine though

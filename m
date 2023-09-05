Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303CDCA0FFA
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 18:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71342869DD;
	Tue,  5 Sep 2023 20:17:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JCWG7b3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E182D86580; Tue,  5 Sep 2023 20:17:02 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5470A869C4
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 20:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52e828ad46bso908167a12.1
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 11:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693937820; x=1694542620; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PFARRGB5KNtqT+7vpGas8MVFLmOsVTDjTDF5Ew9+KP8=;
 b=JCWG7b3NXD9xv0J0RYIehD8vTHrbFUNJNaXz1XfxURXbr6339/1crigBsUamwyft8S
 S5Fcu0tl+/H0JufsmJtWnhEZsnl55IruYo0g7mxZmK47GmKlVhaAXW/wN7NIv9Q4rVfJ
 ZvY6em5zKPvxYu5lWzHEWbDNSGgx0K7TjJQAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693937820; x=1694542620;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PFARRGB5KNtqT+7vpGas8MVFLmOsVTDjTDF5Ew9+KP8=;
 b=LVhl6rmQHyv9DMY11DJyAz4KnH7BhPTwiiMxKmrzVQhQHAkySRAFxyPEM5AeHq9M0a
 k2nvtCrZEHmX1ahMV2hdv050n2CghMDagPWM6tfakrxe33W1Mm1+U+rBmSyGGPWfexIT
 x9kAoq5s8wjkGulKv9K8lzP5GX79hjmyBghuZGcBdFrxRSemIRrUB2sKvCbdti73mMTn
 POTy9kGvg6+X3rRFDCPoCZwgoT5pkX7rcJGUCyn7TqdlwO+kUmpLqukv1yM/kChDDV9L
 xTVFXxbd9O81EI7ekmhH4JKzazBx7cVRgAKX8d04K3a43MNKkOthTfz7MV/gvLv5vAVU
 4ZzA==
X-Gm-Message-State: AOJu0Yws1gJTAcz9dhWRx7qKF2QSMeB87Kbs3nC4W7Uf+pxIpJ83Kgu9
 EVK50dF+Ov23orEt4cag31L92PGQuCJH7VU1YjmKEA==
X-Google-Smtp-Source: AGHT+IHH5fvw+3ktwXolqF7nnrwGovjDVA1qMKqN14vUvYeyLjOpZ62qdYhXk/O+WKUd6IDFcR6JacdF70H0R53QUbY=
X-Received: by 2002:a05:6402:5159:b0:523:45df:55c with SMTP id
 n25-20020a056402515900b0052345df055cmr426525edd.41.1693937819788; Tue, 05 Sep
 2023 11:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230905134808.14744-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230905134808.14744-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Sep 2023 12:16:51 -0600
Message-ID: <CAPnjgZ2B_sL7TpU6w16Sb7ALqTsSJ=pfB=CFqXkZ9SEBiiyxJQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: cpu: Rename EVENT_SPY to EVENT_SPY_SIMPLE
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Chanho Park <chanho61.park@samsung.com>, 
 Leo <ycliang@andestech.com>, Nikita Shubin <n.shubin@yadro.com>, 
 Padmarao Begari <padmarao.begari@microchip.com>, Rick Chen <rick@andestech.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, 5 Sept 2023 at 07:48, Marek Vasut <marek.vasut+renesas@mailbox.org>
wrote:
>
> Fix up cpu.c and align it with commit
> 6c4cad7438 ("event: Rename EVENT_SPY to EVENT_SPY_FULL")
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Chanho Park <chanho61.park@samsung.com>
> Cc: Leo <ycliang@andestech.com>
> Cc: Nikita Shubin <n.shubin@yadro.com>
> Cc: Padmarao Begari <padmarao.begari@microchip.com>
> Cc: Rick Chen <rick@andestech.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Yu Chien Peter Lin <peterlin@andestech.com>
> ---
>  arch/riscv/cpu/cpu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A24BC27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 18:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CCD188756;
	Tue, 11 Jun 2024 20:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bnV88egg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED2638874B; Tue, 11 Jun 2024 20:52:17 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D609D88746
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 20:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6afbf9c9bc0so36328546d6.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718131935; x=1718736735; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VCwJ7YNiI0SC+G/ZXIixPJY2zMD2d+fdHhZVdR4FCHc=;
 b=bnV88eggiMhrVC34ah6d+TAlfjfvFK2I0/GYYMUu5EoqCmfUBgQu/xzSCl+3c4zeI/
 U8P+dIiloHpnsl7AmrJWe0+qsgWFPcAtbPtf/38EC2Pq3FZ6NOuDPW22gxyACrTkFZ5R
 Jln5bgYkao+7NLR09N8ppCcfi2dQ20siizr1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718131935; x=1718736735;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VCwJ7YNiI0SC+G/ZXIixPJY2zMD2d+fdHhZVdR4FCHc=;
 b=Rsn4iSCzBvYDaDx7omiVojLso+wDuPkrrM3FJpZ1C/ztOQJNzRzWaHtIe7x4W4fPgN
 8XuCAlh89CBJiQ4FgbIYkOmpcNbDwZYfq8EC10PJ+DFzyJZiI5s5GFAHWXHoKWxcn2xr
 UCGik8YJIdrnGgXs/dkoqoWcfLayI61ZZXz242eClSwWP+sirToMnPPLF561NJ1DGYdG
 N5nPirMOxmrvtrPT6ygNNN83djVpFFsJiTfzzFExP2ZWTZA6Q4ng/RRi+EC2R1g628ht
 TdTAXD9fSZdyaNra4PTZtGyCu7RhJUAYH/4osDuuU6zTq3oEZQTwwRSF+COfU2wQ6WIk
 qK0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXErK+tVqFz/u/HgdraK1TTZgIkM2xxz5XBJZRwcGSJpgOV5CsYcde8MMpkWj2Lyt0Q2WYc2bbdzZL5+oYq/QEo8Weh1w==
X-Gm-Message-State: AOJu0YydiWosRS5sDVxCp8TiJ89CJCiA2bHeEPCe8L/XYBbiGkyW5CUV
 C0mJxdLPeLi6Auom5uEwJYilH2n2+A3aRGC7al7EP8DRzi5cdNDSwYqcAasiya4a1nfXEb81jpi
 y7xspe57wpOuX6b0639HWc2y6tlpUO/IwyalFSG6YYD3S9wk=
X-Google-Smtp-Source: AGHT+IGh7yNVkmufAGbRo4lsBQwAfWZAlK5V0G2U4UMcIitgw1mIDfAkxGugrHHSTl3N86/DabU+0wwHe0ffMX10zMM=
X-Received: by 2002:a05:6214:568d:b0:6b0:7f36:8af4 with SMTP id
 6a1803df08f44-6b07f368e69mr65877446d6.9.1718131934766; Tue, 11 Jun 2024
 11:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240606-bootmeth-android-v1-0-0c69d4457cc5@baylibre.com>
 <20240606-bootmeth-android-v1-6-0c69d4457cc5@baylibre.com>
In-Reply-To: <20240606-bootmeth-android-v1-6-0c69d4457cc5@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 12:52:04 -0600
Message-ID: <CAFLszTgAmhKz8uqh+LsHR7YyUi0U_Yz6u6Xrxwmj1Bgr355UNw@mail.gmail.com>
Subject: Re: [PATCH 6/6] bootstd: Add test for bootmeth_android
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
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

On Thu, 6 Jun 2024 at 06:24, Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Add a unit test for testing the Android bootmethod.
>
> This requires another mmc image (mmc7) to contain the following partitions:
> - misc: contains the Bootloader Control Block (BCB)
> - boot_a: contains a fake generic kernel image
> - vendor_boot_a: contains a fake vendor_boot image
>
> Also add BOOTMETH_ANDROID as a dependency on sandbox so that we can test
> this with:
>
> $ ./test/py/test.py --bd sandbox --build -k test_ut # to build the mmc7.img
> $ ./test/py/test.py --bd sandbox --build -k bootflow_android
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  arch/sandbox/dts/test.dts |  8 +++++
>  configs/sandbox_defconfig |  2 +-
>  test/boot/bootflow.c      | 65 ++++++++++++++++++++++++++++++++++++++--
>  test/py/tests/test_ut.py  | 76 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 147 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CD6C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:18:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC56B88915;
	Sat, 13 Jul 2024 17:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xm6a4LQN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 450C388907; Sat, 13 Jul 2024 17:15:55 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EBDD88908
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-75c3acf90f0so2155055a12.2
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883750; x=1721488550; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kHsX/tZ9DwG3BZswwac9x6A24mB48SgeANFuKgGLbZw=;
 b=Xm6a4LQNV2zxLGQXZL6gd0huFmJgtVJrYzkh5GvpQyEcy0UPHMs0wy7ZLKjIeagn/Z
 a/SbIcPq/Dzjs8dUjmQRHx3Ku6jPxDSlZ7EdaUj+fAzwClViP6BMZNTcmOXQPKW3BA96
 847inBg9YMTkO0JvsS1evjoOFJVowKRGnathU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883750; x=1721488550;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kHsX/tZ9DwG3BZswwac9x6A24mB48SgeANFuKgGLbZw=;
 b=qXRUq7zOfjQ+syjZWdd53ACujqev8clihzAExF35shQvk7XIu38tBb0rMpGMUP5Zb0
 IWWUMKxaTVksQgIWIqWdXXYpHpEE2zLVCHVimZfq5ei673TJzltody4XL1OnVOavlD2m
 qespbq1Q9RkVEX6LvklGfp5mTH4VD0lGZk+eXXcj583PLSZihCA5RSoiUI2P3zE7744p
 b6TyqRkzFRmhLxujrHUeF0oieePy0HTotoC0n9eo2iBtqwidvYvpUJiMeS9T6sGp7Mfl
 F2TcUaOJO+twkIi4jyMkCfcabpfEF2LcAWHAvrA4JkyjgwKQLOMMc0L2gOTzm8Pdwq+I
 SVjA==
X-Gm-Message-State: AOJu0YzmO4fl0vKzY1Qti5U5jSIV1nkxjeTgJ2YKCAfSANDXrwAAjtoC
 L8xjBw2RWiXUQ+nZRo4QnUUh6bwTnkCCXKRlESAuApcMPk75AkpAIqGwz34voA3ejXrIL9aPw0g
 Ud+0TmoEfKqFt4F+ByIte5pk3HohelaiNXH13
X-Google-Smtp-Source: AGHT+IFYjdMrrfciuuznNLPHsruuEANQpZsp43bYsL4J5yhhynhJ5aSr73IfpCWPawodxNw1GuE3NS7bEvpW4XN+s3E=
X-Received: by 2002:a05:6a20:7484:b0:1c0:f23b:d360 with SMTP id
 adf61e73a8af0-1c29822092cmr15439744637.20.1720883749952; Sat, 13 Jul 2024
 08:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-15-sughosh.ganu@linaro.org>
In-Reply-To: <20240704073544.670249-15-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:15:30 +0100
Message-ID: <CAFLszThSMxe0uXOpPfQMHkdOvee9xF_ahxJqf5YM6wFaO065Ew@mail.gmail.com>
Subject: Re: [RFC PATCH v2 14/48] lmb: remove config symbols used for lmb
 region count
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

On Thu, 4 Jul 2024 at 08:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The LMB memory maps are now being maintained through a couple of
> alloced lists, one for the available(added) memory, and one for the
> used memory. These lists are not static arrays but can be extended at
> runtime. Remove the config symbols which were being used to define the
> size of these lists with the earlier implementation of static arrays.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: New patch
>
>  configs/a3y17lte_defconfig           |  1 -
>  configs/a5y17lte_defconfig           |  1 -
>  configs/a7y17lte_defconfig           |  1 -
>  configs/apple_m1_defconfig           |  1 -
>  configs/mt7981_emmc_rfb_defconfig    |  1 -
>  configs/mt7981_rfb_defconfig         |  1 -
>  configs/mt7981_sd_rfb_defconfig      |  1 -
>  configs/mt7986_rfb_defconfig         |  1 -
>  configs/mt7986a_bpir3_emmc_defconfig |  1 -
>  configs/mt7986a_bpir3_sd_defconfig   |  1 -
>  configs/mt7988_rfb_defconfig         |  1 -
>  configs/mt7988_sd_rfb_defconfig      |  1 -
>  configs/qcom_defconfig               |  1 -
>  configs/stm32mp13_defconfig          |  3 ---
>  configs/stm32mp15_basic_defconfig    |  3 ---
>  configs/stm32mp15_defconfig          |  3 ---
>  configs/stm32mp15_trusted_defconfig  |  3 ---
>  configs/stm32mp25_defconfig          |  3 ---
>  configs/th1520_lpi4a_defconfig       |  1 -
>  lib/Kconfig                          | 34 ----------------------------
>  20 files changed, 63 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

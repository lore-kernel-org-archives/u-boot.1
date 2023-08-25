Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77086C6787B
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 18:07:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4757B86B32;
	Fri, 25 Aug 2023 20:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g1nQP8q0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F10FB86B64; Fri, 25 Aug 2023 20:06:25 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11AF686B57
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 20:06:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2bcc187e0b5so18112801fa.1
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 11:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692986782; x=1693591582;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lldomzl5CaVoxreULPGgKh5pIH1agriY66tkgVLTSoQ=;
 b=g1nQP8q01GctLQE5+vmh89EggVbWCToXg5K8Tg7/RKApnOp4GsNU94IhLl+Y/ShUe9
 IFqCh4ZliQgQxswkI7rnMTZ1sIRvCqBAUvRW8Deqg0C4NNtXn1UqV/bpFiRbI5SevbI2
 X65tpzOXpcl1LrAUkySkYi9qPpMh/FN9w0EA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692986782; x=1693591582;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lldomzl5CaVoxreULPGgKh5pIH1agriY66tkgVLTSoQ=;
 b=jsVWh4K9u1PmHIaT+b8OQorWzu0lEsl3pugYNo1mS3pLidneAQQC4s2rccNKLhADtl
 IeT1qKncY5XL3ab9yEds/HHA5zGVI6bC3fK9+acygOeCbkSQ/Ogj0MZ6v575NmbdV1MC
 glFrLJBjtAG+9jr68DRuSUjDVwXNFVTfoTQjMqyT/khDSim+QMRH13Ud4UJak+wmldaW
 xzanuVlfK+9kvBvCZibqf0eUB3/Y0Y9AWsE0/m4MNRHa9xzHO6S3YW5VMOza0HKDJpZI
 Jolg8kSE+e/d2eF/tt/iN72SrJza5bgrJ/aUtTOzkxVPliiWzAqruL20uO27IWSP4pcq
 odVg==
X-Gm-Message-State: AOJu0YwU22zLIdQV/vnIaPMHfhav+yxv5qCrYKROTYU7LfKucem6JIXA
 YVDvir3+hH+JSMtX48KQzyVWf6lpBTmrkzJcvfArcg==
X-Google-Smtp-Source: AGHT+IEfTBNX/3Kqzelui0l3BAyyeIINpAWUpcIpZtrxaWqnBDI/ZVwF9ZiIoiwZL20NggIxyc9We9Qvi+5UYJqrwAw=
X-Received: by 2002:a05:6512:1194:b0:500:808c:91f7 with SMTP id
 g20-20020a056512119400b00500808c91f7mr12490274lfr.13.1692986782201; Fri, 25
 Aug 2023 11:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <08043c8d204d0068f04c27de86afe78c75c50b69.1692956263.git.michal.simek@amd.com>
In-Reply-To: <08043c8d204d0068f04c27de86afe78c75c50b69.1692956263.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 25 Aug 2023 12:06:08 -0600
Message-ID: <CAPnjgZ1ZPED+SHFUnNjUq+qpgvBpJ5OCu3HkzeYkLVycq4a=Ug@mail.gmail.com>
Subject: Re: [PATCH v2] dm: core: support reading a single indexed u64 value
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nikhil M Jain <n-jain1@ti.com>
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

On Fri, 25 Aug 2023 at 03:37, Michal Simek <michal.simek@amd.com> wrote:
>
> Add helper function to allow reading a single indexed u64 value from a
> device-tree property containing multiple u64 values, that is an array of
> u64's.
>
> Co-developed-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
>
> ---
>
> Changes in v2:
> - fix kernel-doc for of_read_u64_index()
> - add missing test reported by Simon
> - fix debug print to print 64bit value
> - convert of_read_u64 to use of_read_u64_index() as is done also for u32 version
> - fix overflow size calculation
>
> Tested on sandbox:
> make defconfig && make -j8 && ./u-boot --fdt arch/sandbox/dts/test.dtb --command "ut dm ofnode_u64" -v
>
> Test: dm_test_ofnode_u64: ofnode.c
> Test: dm_test_ofnode_u64: ofnode.c (flat tree)
> Failures: 0
>
> Based on v2023.07 tag.
>
> ---
>  arch/sandbox/dts/test.dts |  1 +
>  drivers/core/of_access.c  | 16 ++++++++++++----
>  drivers/core/ofnode.c     | 30 ++++++++++++++++++++++++++++++
>  include/dm/of_access.h    | 19 +++++++++++++++++++
>  include/dm/ofnode.h       | 12 ++++++++++++
>  test/dm/ofnode.c          |  8 ++++++++
>  6 files changed, 82 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

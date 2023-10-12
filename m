Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB5DCDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 15:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4773186E54;
	Thu, 12 Oct 2023 17:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PFfbOdOT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D154286DC7; Thu, 12 Oct 2023 17:30:43 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABDE786EB3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 17:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9b64b98656bso180028666b.0
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697124564; x=1697729364; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z2MoENPAX7DcvpCw/M+xay2reb29o0LBofFZ/Oc5UJM=;
 b=PFfbOdOTml9DW0tYrJPSkb2+n+IbGgq2KfLrtcBpOSAmMPLYNMekLLhyjuneYQ9Uom
 68+WIdegXT7nrHM/CaAq5b3jQ1s3ymNhFNVwAr3cFNhDhEKGSrB4EvagTHBIPNNHKrNs
 jLOwU0XQT6WddsihU7vzFL1UQeqY1Tb9PbevA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697124564; x=1697729364;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z2MoENPAX7DcvpCw/M+xay2reb29o0LBofFZ/Oc5UJM=;
 b=HjS8xi1KkjkodbsITLMMSt02uIAGV4eF4Q9/aeIrbbahi25SP8hm7YVm0FtSyGmroE
 XAdNFCK0wtfirHc/HaDLl5ZKxPe6hbDAyQ6IKwghlPEpc2ggOW6qD/J+wEaVmt/yrcQk
 +EqUekjiCxx1LdiXsvWqjqWQxV2cCvn2V4x0HYtqWOptvYK4ellorJMkbmxLbY8cLTbD
 02kMC3SFJYWDGtjN71XAgmgZXEdEB3ehBrM53AtCfZNwNGFsz+k/Q8PCOq1AQR7NaGwP
 nR89JKmJjd2M22ZOBaRLinyvMZY2xgKfk9C4A7NjReyIPQrsD12lhgNyJtYO7Um088NA
 7+xQ==
X-Gm-Message-State: AOJu0YxAijlMrx26mMjflnHEn6/Jz+i3pTiermOmyIOQzSMHF5nIg0tC
 Zg9vLbd5eA7BYpn3/hJ1ETCGcYAPJMmDUpcvhG6mwA==
X-Google-Smtp-Source: AGHT+IHDRno205rRz6zO+ppfcndi9tLuU05EMwis7SVgh49E+pyD/Aq81b3XN1q8c428I4ePA+vwTYSEBi5q5+x9eQY=
X-Received: by 2002:a17:906:220f:b0:9ba:fb9:d334 with SMTP id
 s15-20020a170906220f00b009ba0fb9d334mr13956686ejs.13.1697124564113; Thu, 12
 Oct 2023 08:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231012144551.679551-1-eajames@linux.ibm.com>
 <20231012144551.679551-7-eajames@linux.ibm.com>
In-Reply-To: <20231012144551.679551-7-eajames@linux.ibm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 12 Oct 2023 08:29:01 -0700
Message-ID: <CAPnjgZ3ZTwTa3ROfkRZgsVDUkD1MhHBwcoceSGCgKTxeT+Gm+w@mail.gmail.com>
Subject: Re: [PATCH v12 6/8] doc: Add measured boot documentation
To: Eddie James <eajames@linux.ibm.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
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

Hi Eddie,

On Thu, 12 Oct 2023 at 08:08, Eddie James <eajames@linux.ibm.com> wrote:
>
> Briefly describe the feature and specify the requirements.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

This could use a bit more detail. What pieces are measured? What DT
binding is used for the TPM? How is the info checked by the OS or
whatever?


> ---
>  doc/usage/index.rst         |  1 +
>  doc/usage/measured_boot.rst | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
>  create mode 100644 doc/usage/measured_boot.rst
>
> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> index fa702920fa..fb043a8923 100644
> --- a/doc/usage/index.rst
> +++ b/doc/usage/index.rst
> @@ -14,6 +14,7 @@ Use U-Boot
>     partitions
>     cmdline
>     semihosting
> +   measured_boot
>
>  Shell commands
>  --------------
> diff --git a/doc/usage/measured_boot.rst b/doc/usage/measured_boot.rst
> new file mode 100644
> index 0000000000..8357b1f480
> --- /dev/null
> +++ b/doc/usage/measured_boot.rst
> @@ -0,0 +1,23 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Measured Boot
> +=====================
> +
> +U-Boot can perform a measured boot, the process of hashing various components
> +of the boot process, extending the results in the TPM and logging the
> +component's measurement in memory for the operating system to consume.
> +
> +Requirements
> +---------------------
> +
> +* A hardware TPM 2.0 supported by the U-Boot drivers
> +* CONFIG_TPM=y
> +* CONFIG_MEASURED_BOOT=y
> +* Device-tree configuration of the TPM device to specify the memory area
> +  for event logging. The TPM device node must either contain a phandle to
> +  a reserved memory region or "linux,sml-base" and "linux,sml-size"
> +  indicating the address and size of the memory region. An example can be
> +  found in arch/sandbox/dts/test.dts
> +* The operating system must also be configured to use the memory regions
> +  specified in the U-Boot device-tree in order to make use of the event
> +  log.

Regards,
Simon

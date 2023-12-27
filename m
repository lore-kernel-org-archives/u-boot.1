Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12507C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 10:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4482787855;
	Wed, 27 Dec 2023 11:05:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EtB0CXa9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7917A87889; Wed, 27 Dec 2023 11:05:29 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2A408764D
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 11:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50e74f2e0ffso2491825e87.3
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 02:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703671526; x=1704276326; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Prw0hDnSfZGWd3pYwPF0Kx5THj14eWWAQaGFy4+vRbA=;
 b=EtB0CXa9oaVuwxYoAe+4jXNSP1/da5b/eI2/TzOyBoWnqkvFVMTTX2OD6mPESSd0n7
 obajO3kaqqYCmGKheUSrSYHd8c8eIrys0QUcRDzF41bQPpMbcECdN7R+vE5Pfm2hbB8E
 2D4tDdXKYIl9692yv8xkvxbJ3MdPEd/cvBS+9jbKCNO0KaUIe+FivRRhmkAX48h4w7B+
 6LiOe8BY5oSeFgPu+XBQlLL1RiJHVqjcxUD23sNpZagZ1TOjM8mgAvYRiJDdfDKL04kD
 RYahD3kDz/5DB9h85NvVMCvWXhBMOnOgxXYZsu7f6fIXbezT6xfzDaTeTNTDBhlUU6Xg
 TM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703671526; x=1704276326;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Prw0hDnSfZGWd3pYwPF0Kx5THj14eWWAQaGFy4+vRbA=;
 b=Vl9XvDVv11Y67SsC7NBMD3zATfid3MNZxPnTuKFrmQbaKIpHd1uCEZMDlfyzptDb9w
 ZOb3K3+ue01ZxnoZ+v6tM8SyPuUYJDjyW6uc5gNaCNw17+gxlV/S+G5jhtF0+fUfM4yO
 8dVbeWBrOkxa2tADLs0zKZ8xhUUmDovYJ57upe+DMHbkx6tOm3ijHNqwtB5aP0ZyPazR
 EOpTvQxtyc9TR4NDr7DSREW/iT4RmYuatHXyhaHCXnuqleehrP3i4NOi/dmQ2XxOpiQG
 HfCR05y4JgRZJtqOSS/MeQ4YMYdhfhFzVYmkAoQG1r/0OoI3ve7Jx/mxiDAqCdDHNxVM
 i/2Q==
X-Gm-Message-State: AOJu0Yx1gGB7EmBPyH414pVZk21iDw007O/WVnoc/yUyFbZUsJoyei3R
 K2T3CJhu1wMtyheEh23Zw9/dednSJbWpSNONJGtlzkDAuh0GnQ==
X-Google-Smtp-Source: AGHT+IEp4hOxl/p7ibANmnrwLOsbyVLjddcKbqxl7LspkGX101y8o5gcnIOuZxqkTcD3spv8g3nHKR5AYwkaMAw98Ng=
X-Received: by 2002:a05:6512:3e21:b0:50e:7be3:c706 with SMTP id
 i33-20020a0565123e2100b0050e7be3c706mr1732942lfv.21.1703671526176; Wed, 27
 Dec 2023 02:05:26 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-14-raymond.mao@linaro.org>
In-Reply-To: <20231218181901.337515-14-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 12:04:50 +0200
Message-ID: <CAC_iWjJ=nnV-F0QzcFhO+OWR73jxC1E5PXVZo3sCjEWVxKKHqQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/14] bloblist: Update documentation and header comment
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
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

On Mon, 18 Dec 2023 at 20:20, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> Align the documentation with the v0.9 spec.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  doc/develop/bloblist.rst | 4 +++-
>  include/bloblist.h       | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/doc/develop/bloblist.rst b/doc/develop/bloblist.rst
> index 81643c7674..28431039ad 100644
> --- a/doc/develop/bloblist.rst
> +++ b/doc/develop/bloblist.rst
> @@ -14,6 +14,8 @@ structure defined by the code that owns it.
>  For the design goals of bloblist, please see the comments at the top of the
>  `bloblist.h` header file.
>
> +Bloblist is an implementation with the `Firmware Handoff`_ protocol.
> +
>  Passing state through the boot process
>  --------------------------------------
>
> @@ -99,7 +101,7 @@ API documentation
>  -----------------
>
>  .. kernel-doc:: include/bloblist.h
> -
> +.. _`Firmware Handoff`: https://github.com/FirmwareHandoff/firmware_handoff
>
>  Simon Glass
>  sjg@chromium.org
> diff --git a/include/bloblist.h b/include/bloblist.h
> index 8f0286fda7..e3c86808b4 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -66,6 +66,7 @@
>   *
>   * Copyright 2018 Google, Inc
>   * Written by Simon Glass <sjg@chromium.org>
> + * Adjusted July 2023 to match Firmware handoff specification, Release 0.9
>   */
>
>  #ifndef __BLOBLIST_H
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

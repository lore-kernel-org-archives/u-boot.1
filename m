Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2917AC25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 15:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99C0B886D4;
	Thu, 30 May 2024 17:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B6i0uhk6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AB6388708; Thu, 30 May 2024 17:10:09 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EC44884D4
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 17:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-6bce380eb9bso681593a12.0
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 08:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717081805; x=1717686605; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xDiL5VIZDgz7f3PaDa+6SOqD5fUU+qf4pFuXM5rFzGk=;
 b=B6i0uhk6NeuRUElQDyJUC26xc01Ul5j6r6POfneAPssr58MGyBwu78cYbSzO827Tnb
 0sz70WskKunioyEkVpodvNHoO3LESROdvJBxOhwfE9MuaVmYzWoOE4Zw49gkqGkD+8V7
 jfgcfXAX4/QJoyzYmbfQRUqmsCKMjY41nS85N1u7E6eRmq8A76a7dkNF5exSoa5K4X+/
 6A2YSE2h/mJky9GxVrO8TuWiN1cvhNTy7hx2LZCwx5pTPaqx9HXbfAEquccw++9l5EP/
 o5zQh8N8TFIJupeuLMf1OZOCcPpGD3VioXgP8W7kVZexcR/NtixvrKZc+NNYv+KbuMfq
 QJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717081805; x=1717686605;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xDiL5VIZDgz7f3PaDa+6SOqD5fUU+qf4pFuXM5rFzGk=;
 b=ggderuE8GtswJOK0RhvjNGwWt+KIwgWY3VdVr881SMu6uy/cjPwm3db0vsuUohTRcM
 mHpVl/ynQnNw+AMzpw/gjkLygLBxCxGIxz4DeqHPOOh7jAMcPou+YF2hlR19afL8BBBn
 W9hfU7JeJXR+dlbPvYWjeiE/qoI8keV+WkXl0hWMm10GQGgs/FB9zNT/+o7lQjNK+QSG
 +9wCl3peQQnh9WzrcIFu/+e5fvQ7kdzzxkQ0Vzbyp86aQnYsRLICi5v9BK0yCBcNbRu/
 k1eUsoV9Y+LwayqnSfva8s42JwHpzj3DaaT+dzFYNXvGsAf0mjk8kJvdhmcKwMXAAZ9P
 fpPg==
X-Gm-Message-State: AOJu0YwjHdzht7nQE04F+y6W2fhdkHVDpvUc5VDTvET25GixtyscV6A0
 gjtpyXYIGgUO/ZWks3fFL4hc/VUVOZ0HhubOObnoyA7IWgo4+eyXThEezL5527xIQJfIw7YYLtG
 9QXEu/uUvVhpJF5C2KR/kcV9G7yN/UX9mLetVCg==
X-Google-Smtp-Source: AGHT+IEstCLr9Ne902sMVbonjsYGMwEBjykHHx0Xk894SBvei9lvykHY8rq/DsQRNBtH05o+RCf4mnWsjtpK5SLx7zw=
X-Received: by 2002:a17:90b:1e08:b0:2be:b9:da18 with SMTP id
 98e67ed59e1d1-2c1ab9de59amr2481994a91.2.1717081805591; Thu, 30 May 2024
 08:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <44cb3cd74693814e28201956b2ef739ef280ca16.1717053444.git.michal.simek@amd.com>
In-Reply-To: <44cb3cd74693814e28201956b2ef739ef280ca16.1717053444.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 30 May 2024 18:09:29 +0300
Message-ID: <CAC_iWjKyXj4=arL7gXN4bqodKbJfz-Z0k4mxq_sc83-OWCF+PA@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Fix capsule_esl.dtsi.in comment style
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Thu, 30 May 2024 at 10:17, Michal Simek <michal.simek@amd.com> wrote:
>
> Comment is not kernel-doc format that's why don't label it like that and
> also fix indentation to have proper multiline comment.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  lib/efi_loader/capsule_esl.dtsi.in | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/capsule_esl.dtsi.in b/lib/efi_loader/capsule_esl.dtsi.in
> index 61a9f2b25e9f..bc7db836faa8 100644
> --- a/lib/efi_loader/capsule_esl.dtsi.in
> +++ b/lib/efi_loader/capsule_esl.dtsi.in
> @@ -1,9 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0+
> -/**
> +/*
>   * Devicetree file with the public key EFI Signature List(ESL)
>   * node. This file is used to generate the dtsi file to be
>   * included into the DTB.
> -*/
> + */
>  / {
>         signature {
>                 capsule-key = /incbin/("ESL_BIN_FILE");
> --
> 2.40.1
>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

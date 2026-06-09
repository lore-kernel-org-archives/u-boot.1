Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97863CD8CA8
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 10:36:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CBC3841C2;
	Tue,  9 Jun 2026 12:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F02OfvrR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A64C484701; Tue,  9 Jun 2026 12:36:48 +0200 (CEST)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FB2883FEC
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 12:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-660e9ea23cbso2795340d50.2
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 03:36:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781001405; cv=none;
 d=google.com; s=arc-20240605;
 b=fTd4Xa2H4j74Dm+IjgjqawS4/Z4ENeCPUOSwFhwYf33nP3hDGt2Ym1cZtWQx94f1tV
 GXQofon/KQucA5Nokq4Ael6ytmI84nY+7sDmLxrD2JOtKqnAs3NDJrjYymJ91XnA8eWf
 q4HobQRg1MYMj3gV2En+RAdAWRk5liwEydUtMd1NFVpK3/HfVHl7ifWYB6z+UrYoG83z
 +C3gqREQiFC0pIpXT46UJ7ndL+Nfhmuo0jZjk989y37HcP7iSkb80eXNrO0rtMmPp4m9
 nPV4YEnLgNgLL1j640rXZTdMOCztdOLF1QA5Lfo/9++B4Dw27RbyDQCL11mmZClgASIC
 OGeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=f9+OKM9KxIdzdsop34+8HA9wfFeIstUsPZtJpBP9Ymc=;
 fh=Y1zuWHvtpDwOU1gS8Bb3URTqAOkXCS+8HRmzP4fZKxA=;
 b=GOjJop0wRu2d9f9yNxjF1/5DfAIdtWLS518t72jHZtzJOZnY1z1spGiGGgkCoTUjVV
 dKvE5g6IW4liW4YF0SVgCPjuCBTAU0mkIyWs0XcH71JLJtY8aFLK3TTvIbuRobqeyhxR
 Si+uP/L3D5QGf6/FAOr/9YvgRfjmV+HVaplqLlnDrcYjYCzdV8NKWDuQgrGMBlhRaYcL
 XQZGw7IyMKLuaEXXRhA0i55CTr1NmcxJcM5CF/eUNNP9fv8800hw++f1Ob5s3AL8XbmJ
 PweJCPID9hm8PxukgMzPBvPFYNHaQuIQ3759qSbXY11Ei0KmFJ/0AXHD+dUqS1P7BWog
 RI/A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781001405; x=1781606205; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f9+OKM9KxIdzdsop34+8HA9wfFeIstUsPZtJpBP9Ymc=;
 b=F02OfvrRqAZ/bj2C7mh0Kt8623RBNUui8Wbs974deOD/B9tsGo91pLXfAcI7Lho4Mz
 Xhv0DhfZv093ZCD6F4nMXCqGJfEU9oQrZMr70cyrg/7DHlAtd8sEqdWPAeNThVzI7DA1
 tosqRZJCVxtF4ZZ2k26cwlcfAhGkvIfMVpNa0aBnx1Jex7lyYGadhB1thzP7CwbCIqjU
 vp6gf28QEh1fG/gF4IlEZ3m9vUataC09BC+tB1p0N7Zodag4lFKbE/AfkKnLGRZSqKA/
 RSd2LdWSI3+P3ua0bu82NO0RYugaQUopRsHQLJBrlKU8Z85O38FX7XlL6w6fYZp0gjqf
 i2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781001405; x=1781606205;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9+OKM9KxIdzdsop34+8HA9wfFeIstUsPZtJpBP9Ymc=;
 b=QYU+EdZTQjyQii9P6FEWFJqRX089QoI5aA8qtVPvgLe3PDuNEqyKH4qY0JUZJfjZi7
 igPJK6vaTjKFXCZu3wT+/I0noJyQBrPfC2lNkfn2smWb5O6CI1Sdq6v0eDrL4kaf1amj
 hXbR9hyFcuY0OtqW2Ihe++50vj9lFUsdIVbsz7LtZmM0TeakTlGk8ObeveXgHHNju+If
 3BOsnJ/xd9XviFTPUpgrdUw/JDAhlvARnDy2FiPNduMlhFjOhU6I23TzTO+0HC9gVPF2
 /wAYh4ZG/8xnaLRRxz+8+xo+F/6M7zjjAVtDS6KBtgf1VV0EzWgflr0+bMyKAN8CiLVQ
 lAZA==
X-Gm-Message-State: AOJu0YwDWqC3J/bxtla9IncDlBPEH4x/tH+4c+EaLO2/7pWhz7/4/dM/
 EYexZEV9B+PGT7w0UPq0cLrwHs5WAJdobiqfaSwEHp2YanvP2Oolq6MHi+4qGWLjdn/doPGKOcx
 DmJl1wweJiTx/MivqFkqcqXQ9FLe+4v9r66pl9f5lPw==
X-Gm-Gg: Acq92OHsdJk8guMrg6M3jw7KGc1ev67YNeZaNHzoig9cZrBrvd7IbLo9ZJBROITnx39
 XxHgyVlc7zFY9rI1t6t9AVLlXPGdt0GwGZeMT+l6oQHS3RmTwh6HleNkrBFFt9iUfjQeWZQTGc9
 OP/jBNevwogELoEbaoV1bW0ZJ4dzEKIV5+Nbrz+WyrqdvVjdVAM7gXqH14h9ilfi8Gee6kcFPjb
 NClEmzZDs7ePxnQMRnYQlSwjUsqW8Z3MfgogvGO0laM6pIdSaVJkGnupKwEx3kSysHEDQd1RIeL
 EpBzCkaPipN49Rvq8N9zndejSD00QP0mf3NpLwhsXVGcAzcCm9ot9FrlUgEeGxFgQVlNSuxpmKI
 NOm309kgeQBuSKgtap3SGINRqKR/3jGoL3MHECR9FCs9oPBi5pY7nfguVnVxnL8LMKu+55IERUM
 5eCSKKvpVxfj7XbUAyqVBGcwUhBFqdRWPyftRaluLRGBfTvrlJiSVFu3gu/jjzw1PKgvvao7WRY
 FFp35g4QXj3wu4xQLzhCdNgBbWZRv5rAqi/Mxz73QCk66npKrUk0IdRQYtEgNX5F5dAP50F9s1v
 UDr3js8+TMjZh0kcjH8H9ht4Zd0MIRa3HsJFlU5mYmN0wQelbw88ctwmUSzgcld1bTjr0aSWj9t
 HKol+0L8GB/rW8d2MAYMJHzwk7II=
X-Received: by 2002:a05:690e:400c:b0:660:41fb:6728 with SMTP id
 956f58d0204a3-6610692f192mr16393107d50.0.1781001404929; Tue, 09 Jun 2026
 03:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260609101039.584994-1-padmarao.begari@amd.com>
In-Reply-To: <20260609101039.584994-1-padmarao.begari@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 9 Jun 2026 13:36:08 +0300
X-Gm-Features: AVVi8CfoE4KallRdOzfTYwqoxYGs-mqGSKm_Qs22Kcshy1wfv6dEqKrc5jXIZs8
Message-ID: <CAC_iWj+gfnGQyi6MHJaJ0zRLue8TD1_K9yVNQ898+eu5daBD2A@mail.gmail.com>
Subject: Re: [PATCH] rng: tpm_rng: start TPM before reading random numbers
To: Padmarao Begari <padmarao.begari@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@amd.com, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
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

Hi Padmarao


On Tue, 9 Jun 2026 at 13:10, Padmarao Begari <padmarao.begari@amd.com> wrote:
>
> The tpm-rng driver calls tpm_get_random() without first ensuring the
> TPM device is opened and started. When systemd-boot or fdt_fixup_kaslr
> triggers an RNG read early in boot, the TPM2 device hasn't been
> initialized yet, causing the command to fail:

Is systemd_boot called via EFI? If so the TPM should be up already.
About fdt_fixup_kaslr(), why do you need this? We specifically clear
the kaslr-seed when booting via EFI and EFI_RNG is installed, since
the kernel ignores it.

Thanks
/Ilias
>
>   tpm-rng tpm-rng: dm_rng_read failed: -1
>
> Fix this by calling tpm_auto_start() on the parent TPM device before
> tpm_get_random(). This ensures the TPM is initialized before use.
>
> Fixes: e67ffb5aa5ab ("tpm: rng: Add driver model interface for TPM RNG device")
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>  drivers/rng/tpm_rng.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/rng/tpm_rng.c b/drivers/rng/tpm_rng.c
> index 1a5e9e2e4b4..374e0ac1ff8 100644
> --- a/drivers/rng/tpm_rng.c
> +++ b/drivers/rng/tpm_rng.c
> @@ -4,12 +4,20 @@
>   */
>
>  #include <dm.h>
> +#include <log.h>
>  #include <rng.h>
>  #include <tpm_api.h>
>
>  static int rng_tpm_random_read(struct udevice *dev, void *data, size_t count)
>  {
> -       return tpm_get_random(dev_get_parent(dev), data, count);
> +       struct udevice *tpm_dev = dev_get_parent(dev);
> +       u32 rc;
> +
> +       rc = tpm_auto_start(tpm_dev);
> +       if (rc)
> +               return log_msg_ret("start", -EIO);
> +
> +       return tpm_get_random(tpm_dev, data, count);
>  }
>
>  static const struct dm_rng_ops tpm_rng_ops = {
> --
> 2.34.1
>

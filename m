Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A90C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 18:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E84F984ACD;
	Tue, 30 Jun 2026 20:48:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RtvMkHZv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D449584AF1; Tue, 30 Jun 2026 20:48:22 +0200 (CEST)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C11584A3C
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 20:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-664d910cc75so2755809d50.1
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 11:48:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782845297; cv=none;
 d=google.com; s=arc-20260327;
 b=V44HDy39L3dpc5mbIUecJDR/vxBB71NVVMZO/l1srUz4iMEwNYBNVa36BAkvcn2hCQ
 /qNRjPKi1BwXwXCezIXKtX788FrDZl7sJPOAxte1ZJomVG56z9zTUpCIfXn323LIpyUa
 4HzeNAvw66vV0yB3JW6QlvMb32vpCkDRazjh8ODHjrHt+5onap4wJdIgtVMmpRSne8KQ
 jEV97gVTyZW6khOaJ+pExdYq2MYJLmuvUopvOFz2kzoftNwwP9R4zIDb6qvu5apry6nW
 rWjIgBYIt23399c1afVBU3piUUIYAyNSF4bs/rHG/kSBxL2P9xcCaH/1gcWFpWhXBK0y
 IxVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6/4wq+GqLjyfeMfUdMCLp9MIoe02MNzsvfyh30yJIrc=;
 fh=/Nsu4KeIY/BckAkrFd38YurCorn6dwrZh11nSZtiKSE=;
 b=lQWPmloVYysFkjmMitg+gBjXBxRha+WqYdC9JnexrvuXYRNkkND8K17bfx10F3esjM
 X6ZjjA1p4LrguwNc/a/l+vSCa+W9pOFdcb8zTfYRJ7JP3G7tO89JYURy45ePuuN4Nc1o
 aQOum6LHqVcvF00UAEuXH0qRE+PFFnO2slCKk8hZD11DFvTs47CssAaD4tSCsnz/1nLw
 biEdYyns19GgqmQkX0GfaRVmIpHLqJ0ato+yDkQIqAsIq31GfjAoiBZ2pHi3Sif7vGuD
 tsA9IhCfMlHcDP9xAWpS/fEaCZyb7TbTS+XGUMM5Nn3e7HXEMRrBEuneOYFcvFht2vcb
 Fpyw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782845297; x=1783450097; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6/4wq+GqLjyfeMfUdMCLp9MIoe02MNzsvfyh30yJIrc=;
 b=RtvMkHZvSQrciuo9Ye+HWEbn4pGUFSZ2QJGweowK2GVZxj+kp45Kp4zRWhWGYW6rNf
 wndN6J0kNoDFtXgjmhL3ra/py4DPHOAEtlKEB4dgZIPNbEe1VtaxPzSgMi0USZWCwxfR
 Pu94wgirtqTw0bokB9pqXdXVDfCDKZqtn6XGmWqRKSByVUY+C2/6rIidsBMOTPmGeY5D
 bvqgRRmaaStTJcmt0Q/cL06yOcWIRQRtvcCO5dJ1axQuua+5+j8Y1exrwqb+QoWuFJQ2
 9Mi8WZsVhC6YL4gE3+eFSqkvp8g3Jgyn1jj2RNmU3N/7oOkwmDvEkl99PrPNbxCqw+Ek
 hxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782845297; x=1783450097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6/4wq+GqLjyfeMfUdMCLp9MIoe02MNzsvfyh30yJIrc=;
 b=NPGtlUD7WGUP0BsJ2K6jy739nyRyaxBgGXJFHfrCPXNbz7D7wXJYvtuurHfE84wO4l
 4xJW+HHoiUQ+qoDmgN9IU7CbxGm48n56yVHxIR1jJzKNmmXZAT6ISNvXuw5tHqxrMWlD
 oYXDIv3hyaLnNoM5+kNn+pD5srcD3lWGOau+uePsbSe3QaTkGUWbCX7PdslavIsaEo9D
 iuyH2ulR8/qfAXcOwixfAVWto3XZhG/ddQFuXfSjeP4YXpWmVwOs76I4RiDoi42E+f5d
 BVnmoCeqPJ0GgQAI2Klm2qgrmnVfnRxrBE2/MAaicdze6u/TyUok/PscHt+1xFqpZzH0
 O6FA==
X-Gm-Message-State: AOJu0YyW3VNwQin8Z91ZiDtxicKsnduO2xxNdKuxY3IKkVn4pJQXilPk
 FzE7ZWJQL6MgverRWJmUOHo4f9ZwKoezARYU8UH6KZSgVsegk432Ve8r/785skVoAM3oMwYMHpH
 cR1aeRFsugRjf9R9qOy66APpV1rUBaTO0KtycmBjyPg==
X-Gm-Gg: AfdE7cmy/HZFniJsX4hyyGnrDBKTK4GmEvUj/pUkHLGps5Qi/0162bbCOnS6YlEVapc
 /+2A2UMFfc5vFEbtNI7BF7Z0zAiioFD0KAtDQVyiD+Ii2hoO2D6G4qDjWowPnR/pihu2nPLggq5
 FlvJMk4DxVxVaQijSWUbe0+Sm9N7BpEoMMPgyW7zxC2qgpe04GLh1uidAD7M8JzDP5YYwTj/HmE
 nOzTX4vDVE5jHUJ9qdfMH62MgzSm9Fs9TOIkEYxijqXHwByHj5+PVAgw47G+/lrhdGd6BCzC/DJ
 8NKFQXEFGBNy1LbP5aaGxu1z9225U7qjmVnSKzY+rNcolMN0Q0c8PKDLk2YP6fwbVLkJaEc0CdS
 ZsBT3aeIJjF01RCMIzc1+HEeXJ69se4fZv3e7vfbzKxU0kmZRwy5JkR6Y8EFH3MgB+7spc0QcsI
 M8xbHe8z5mu2sdBWtbru1jpGsYxoCod6UGfhaWFo/Xu716cE6zmblmnL23OzzKe0ay7hZfTq7O8
 9fZMMAUeBGIFluAEZ3JZ4OBn5c8VSZuO2v+TQqmE2xi2jdglNomlxxERHrkdkKimUz/t9yyznz/
 sh0r/HOAI+gKktGXuO26pgJjfGMsl/XzAZCQDGGJXL/df9QtixZSDejyhl2uxDbB7TfcAafi
X-Received: by 2002:a05:690e:4852:10b0:664:d71f:4e95 with SMTP id
 956f58d0204a3-664f97178f8mr3597683d50.16.1782845296749; Tue, 30 Jun 2026
 11:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <0bd1a1b8bbe48fa3a9b89673c1e1357d50d0684a.1782825467.git.michal.simek@amd.com>
In-Reply-To: <0bd1a1b8bbe48fa3a9b89673c1e1357d50d0684a.1782825467.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 30 Jun 2026 21:47:40 +0300
X-Gm-Features: AVVi8Ced7rbbTShcPdTBmnEyoL2WLboYZQCFEO_BfKpr0PUBtJXZY4yJWhumjro
Message-ID: <CAC_iWjJ1i=_De=W4HnhELQV+Ptvf83y=f=Yy4YFjgeQj9=S5-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] fwu: Make boottime check failures visible
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
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

On Tue, 30 Jun 2026 at 16:18, Michal Simek <michal.simek@amd.com> wrote:
>
> On systems with FWU enabled but without the required DT changes the
> boottime checks fail. The failures are only reported via log_debug()
> which is compiled out by default, so the user has no idea what is going
> on.
>
> Use log_err() to make these failures visible.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
>  lib/fwu_updates/fwu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> index 2b11e5da061d..e9bb1b4fc656 100644
> --- a/lib/fwu_updates/fwu.c
> +++ b/lib/fwu_updates/fwu.c
> @@ -759,7 +759,7 @@ static int fwu_boottime_checks(void)
>
>         ret = uclass_first_device_err(UCLASS_FWU_MDATA, &g_dev);
>         if (ret) {
> -               log_debug("Cannot find fwu device\n");
> +               log_err("Cannot find fwu device\n");
>                 return ret;
>         }
>
> @@ -771,7 +771,7 @@ static int fwu_boottime_checks(void)
>
>         ret = fwu_init();
>         if (ret) {
> -               log_debug("fwu_init() failed\n");
> +               log_err("fwu_init() failed\n");
>                 return ret;
>         }
>
> ---
> base-commit: ea62096437b39ff9038f7169e461bfe7863ee85a
> branch: debian-sent3
>
> --
> 2.43.0
>

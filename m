Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34617C369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 14:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF9F982A53;
	Mon, 28 Apr 2025 16:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N0makTy1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F04A82A5E; Mon, 28 Apr 2025 16:50:20 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C064B82A33
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 16:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b12b984e791so4727851a12.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 07:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745851816; x=1746456616; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dKla5MYwuxY+mt0oxO3G4GwK3BpRwj8t1eQQbjGkhF0=;
 b=N0makTy1s5MwSrrvipJ19Xbb0H88dic7N9Y5ptVfWFW12hsTcSUfGv3nvH5YuwRONI
 lWxT8VoqOLDzt3YJMs1EAZhrN7sydDrEsV8GA858F4fA37/mcV6EBX8dZuDLdobKjIqB
 uTAAI51uh1cTd6HpVEZNRFxcUnvv220yw7OYzuLYR4lafjZkuSivsP8OM+elB4mcdnuY
 n8FslgMthKEuDYWPANaWAmlzO2GxnZVnkrwHYiuUEKUE6902E6ojFEltLdaU5DgmHr3v
 GAkH3mxtP1WFbZuK5cS//yDCZq7KfSrNRjOK1+/SNI0ru7xbHQ2shBexV8MBSO9ti1xN
 jSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745851816; x=1746456616;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dKla5MYwuxY+mt0oxO3G4GwK3BpRwj8t1eQQbjGkhF0=;
 b=sUfvUGzCK2nAZH25JLBvV0DG3cQSjLjDaTTFxln7NAZBbVPqRq7P9l+Yw823y8MA8U
 RWUBMCyKwwhU+R7zlHJKopF0aEYlzK3zKDOY8dG7+Q+31wcr2EgtrWo6PKo/BHvWYTzj
 5q77D6fj72lR25fqpHyQySoxKiy0KyOrC9WLR3jbpAVrQC5gFy5vpTC/ZymKZRhBWjsJ
 JhaCs92UJVR3Obtf0KerqJPsyAesjtOWn6gR6+Rm1wvCDMUD2usdL1nDH2LeO0ZXXLaX
 8Vsf6mvtuQ6zuY5Dcmt1dDzC5/iHtn8Hsd6khQqc3ks+n/ZLaPTFAdvHpfAosnDbCRYe
 NVqg==
X-Gm-Message-State: AOJu0YzG0UK0hGMiIykv9+f8NI7G5coAKGAZxh9g62fJWaq+5AFNR+ud
 WRI/9BhQkil7+qYulV1cWnaDbPzkkd5CtxK+wCbi9hRx5SSaJwbei5ElS7ZOoYxktWR3Ie0QEb1
 5NI4/IKMMBor0Tn3eA9U+FRP1Dkhfm1XdztUoGY3V32xripUFHgM=
X-Gm-Gg: ASbGnculltM7aoIfuHF4feuTM/LcEf3SYQLXBBYOZsyUQ9Qjd0n9ftlp7PVprV9PpRS
 zeQeTNXG7qhKZ8V8SftCuXD8O12ji+ZcZosLwUPlBziJOerubvo5m/fR21JsZzrmlzX/XkQileT
 +Wuyj5vavGUzlRk2o4ev4j1og=
X-Google-Smtp-Source: AGHT+IGe5UiZ6iumyaAPht/TJAE8/OieVZFy3Y9gh20Qmp+flXCIBFywp7AHmTv2mMVSMmiInZtmAXiOjbnziIS4BAI=
X-Received: by 2002:a17:90b:2652:b0:2ee:53b3:3f1c with SMTP id
 98e67ed59e1d1-30a21546d64mr170339a91.5.1745851815658; Mon, 28 Apr 2025
 07:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250331224011.2734284-1-raymond.mao@linaro.org>
In-Reply-To: <20250331224011.2734284-1-raymond.mao@linaro.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 28 Apr 2025 10:50:04 -0400
X-Gm-Features: ATxdqUEIpnKRKmF1cVnNqNtQNG_SxA7lyNCEddZF6aGmfLVsAxzUfIj3Yg57jhc
Message-ID: <CAEfUkUKYOE0Dt+Lwur25u3FmzaUeTyzg+SzWH45b+6HVJAxZ6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bloblist: fix the overriding of fdt from bloblist
To: u-boot@lists.denx.de
Cc: Caleb Connolly <caleb.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>, 
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Matthias Brugger <mbrugger@suse.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Tom,

Can we merge this series into master?
Actually my below OP-TEE patches depend on this for merging to allow
testing firmware handoff on QEMU v8 through TF-A, OP-TEE, U-Boot to
Kernel.
https://github.com/OP-TEE/build/pull/821
https://github.com/OP-TEE/optee_test/pull/788
https://github.com/OP-TEE/optee_os/pull/7352

Please feel free to let me know if there are any concerns.

Regards,
Raymond

On Mon, 31 Mar 2025 at 18:40, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> When a bloblist is valid and contains fdt, it explicitly means
> a previous boot stage is passing transfer list compliant with
> Firmware Handoff specification, thus the fdt from bloblist should
> not be overridden with the ones from board or env variables.
>
> Fixes: 70fe23859437 ("fdt: Allow the devicetree to come from a bloblist")
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changes in v2:
> - None.
>
>  lib/fdtdec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index f09c9926a7a..c38738b48c7 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1708,7 +1708,7 @@ int fdtdec_setup(void)
>                                 gd->fdt_src = FDTSRC_BLOBLIST;
>                                 log_debug("Devicetree is in bloblist at %p\n",
>                                           gd->fdt_blob);
> -                               ret = 0;
> +                               goto setup_fdt;
>                         } else {
>                                 log_debug("No FDT found in bloblist\n");
>                                 ret = -ENOENT;
> @@ -1752,6 +1752,7 @@ int fdtdec_setup(void)
>                 }
>         }
>
> +setup_fdt:
>         if (CONFIG_IS_ENABLED(MULTI_DTB_FIT))
>                 setup_multi_dtb_fit();
>
> --
> 2.25.1
>

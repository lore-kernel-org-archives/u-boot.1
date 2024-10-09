Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599DBCF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D69DB8906A;
	Wed,  9 Oct 2024 03:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HEf1jdD+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 261E989038; Wed,  9 Oct 2024 03:51:42 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9C778903B
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7ae3d7222d4so5297702a12.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438698; x=1729043498; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZzUgwlLY6P7dAegTe0qQFbSVBjaboKfyf050HWroIAE=;
 b=HEf1jdD+FMSJRAu/BzwWAaFE+qkZbRB690ix7FqY965lc/zMQY+QLIYYA9sM8WAYyC
 P4yO82HcLMkPWfbWuKn/k19zuMU+6GuBI4bU+E9GCCledkI86SfsT1npUTemZr8gbPt+
 autZ6+PxKkyia/Q+VJr+EmI46QTFLaTq2Tyws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438698; x=1729043498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZzUgwlLY6P7dAegTe0qQFbSVBjaboKfyf050HWroIAE=;
 b=b+BN2RSynQuB2nRQa15OwVUuWOsTTywbKSuXbSne53rVQD+Z4jc5YzcOAmur/9nrIQ
 bdCvUeEyU2SKzITdbL81hDNCix47HMymVpqVHhi9DiE7tUtB0t2w1UhtNAlLXJnbx0ML
 ipxIiNvzJ6B0ySZyDVbVpjqYIhYbPAngzBtmLZb5JCPe2ovSj269fSvjcdc31bdXErMD
 wy2ILu8KRNgcQdBCWpWLln8iCS2ufZgT4zNm/mGX8vWCuj645YDy6VmBfVzwg6N/8q6q
 IrFnfR3nDqmLV2IJ9MnFMxeJxjxs0p8XX5CJiKsb3UpzuDJSFf/QprmEM8VRya5anhiM
 Nkig==
X-Gm-Message-State: AOJu0YwTfnQa+27SU14Zq+RGVwEpsAy6j18M7ti6u3rWraZPJYxFGkZn
 Y+H+0N90OUF3TPpGwi+qQL7Cfy9Yu2+wcLIaiVEfcuyZ3wjrVsfhNoNKmmQ8k9iCsWVQ4O02EVm
 H61F6zm+IKxVTVdaiAGiwFlhPDQzGcHVts1i0BFJPW2zPVF23eg==
X-Google-Smtp-Source: AGHT+IGGFcXrCWzhvCT3cwZA9m9y+0WW63e/xje5Xxfniz/iqfM9dS3a1I97fGzsp4UrFa++JqixFe2svlddgebtPx0=
X-Received: by 2002:a05:6a21:2d89:b0:1d2:e92f:2f48 with SMTP id
 adf61e73a8af0-1d8a3c4991amr1568187637.40.1728438698330; Tue, 08 Oct 2024
 18:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240916082446.32082-1-al.kochet@gmail.com>
 <20240916082446.32082-3-al.kochet@gmail.com>
In-Reply-To: <20240916082446.32082-3-al.kochet@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:50:56 -0600
Message-ID: <CAFLszTjxq7MfUKjW4VETkt-SpZs+seK8F71EwG5hfOe9DsUKWg@mail.gmail.com>
Subject: Re: [PATCH 2/3] image-host: fix 'unknown error' error message
To: al.kochet@gmail.com
Cc: u-boot@lists.denx.de
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

On Mon, 16 Sept 2024 at 02:25, <al.kochet@gmail.com> wrote:
>
> From: Alexander Kochetkov <al.kochet@gmail.com>
>
> Fix error message like this:
> Can't add verification data for node 'fdt-1' (<unknown error>)
>
> We get unknown error because we decode error as fdt error
> but actually it is system error.
>
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> ---
>  tools/image-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/tools/image-host.c b/tools/image-host.c
> index 7bfc0cb6b1..ac14d9aa86 100644
> --- a/tools/image-host.c
> +++ b/tools/image-host.c
> @@ -1333,7 +1333,7 @@ int fit_add_verification_data(const char *keydir, const char *keyfile,
>                 if (ret) {
>                         fprintf(stderr, "Can't add verification data for node '%s' (%s)\n",
>                                 fdt_get_name(fit, noffset, NULL),
> -                               fdt_strerror(ret));
> +                               strerror(-ret));
>                         return ret;
>                 }
>         }
> --
> 2.17.1
>

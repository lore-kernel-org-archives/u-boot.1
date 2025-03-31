Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB4AC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 13:54:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6462881DE3;
	Mon, 31 Mar 2025 15:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vX7aOlbF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEECF81E5B; Mon, 31 Mar 2025 15:54:24 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86147801FB
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e573136107bso4228188276.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 06:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743429261; x=1744034061; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IW7zMh6wmdxAfK+CQwHPZIf8RqPjphnNfjUKhmsBdfM=;
 b=vX7aOlbFSiE8ukvR1hzk9X7NzILOCiF6el3Q5AUMCHoBmg+tRctrMauAoKfuyYY0PL
 p17aDz3GgRe6bizTQ+jWo5nRC5s2bicA0tZy9mf67hM2zMpKiWS+omBcVTKcz7IE22zv
 guE6K699RKrrCKOte2fOeNE9deIPcDuVXrCJkkbtmZoK5EGT4oRmIFER2NHOLPYc+f+O
 hYc9hqmtp+orMrfEXv68hrAc/XRxjDkllMNsXx3zNrJZGaEn4mol5Ynf12UOSV0i23FJ
 YfDmEpJ1WV6pTqk80SwHNHfgmZ9CbU6RyJoVLwAvPYnjPpWQ6brMYvtR+pinSU+PO/+i
 Ii/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743429261; x=1744034061;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IW7zMh6wmdxAfK+CQwHPZIf8RqPjphnNfjUKhmsBdfM=;
 b=Gckgvnmz+3j3y3QaEnXo8LoBrehReEihkXtJZBdVrq/ji0aZTdooT5bEKQfB2me9h6
 KCBVcEuY+jPSGEiPQWvdk1QV4Ela/siLalV/ZAlrchvWd7SvTq5tKmDYSFZpabTUOe2E
 RFsJKX2O/Z24Xmv2VL2NUQTHrW/cyWOwRz7qXhViG/93+vb9oy5cRx/uXLQ2viCzJ6QR
 aLNY2+UiihXSGk/o3TFS8uPJHTo+OgK9guWggeie98aydCI8RZXLAXFdFgCTqq767Wu0
 zZEMzvM/bDOViIhBn0I+eqTWsq63gJJk7GnCc/taksRHDg7V1jSJ+FqfqTKo1OtdcNga
 PcuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLZN1iea0bLmB/scI0rcmDoBFRIrXLoHHwIq7dCXMfE/Rz7PNUX1HBRm0F+hr4FXX1rmknLVE=@lists.denx.de
X-Gm-Message-State: AOJu0YwMbSJmMY5kOob4cvgN7ZpEnOFkc9l6PVTO8e4+hZasp1qvXOBU
 aIu6Czahx+4szIYkcWZncxrt0rnOEIq7tL2tXohnn50CtVnxFLLr+23FDTcNsHDp+yPwluzoXcf
 Al8SmgGrAyuuCE3ddL3gQOYaAO4REh3n1GEj2Iw==
X-Gm-Gg: ASbGncvhB/b40o8OJGPsroNLU3/FcoO69uYu+s/Xj9RxlTMngXEywag7T/CusbP4RqN
 VODB4X1xGnlCvanDWYPAlc/wOZPSVuE5DZUftTSvQMjDPBKQ3kSQyZ1N/OyF2yrFOWYBD7ogUdv
 VkE8PuWzIAWxb7U8ipgcCqfBpH
X-Google-Smtp-Source: AGHT+IEESzG3VVfUr+V2tlZMLX24fhQnfILgUOdT2U7nW9a+1aaVhjP18pme4W4rJEycSUXy9s+oJtXEdISl/naHD+M=
X-Received: by 2002:a05:6902:1b8b:b0:e6b:75cd:a36b with SMTP id
 3f1490d57ef6-e6b8391c052mr10436661276.11.1743429261379; Mon, 31 Mar 2025
 06:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org>
 <20250326-b4-qcom-capsule-update-improvements-v1-3-afe2e3696675@linaro.org>
In-Reply-To: <20250326-b4-qcom-capsule-update-improvements-v1-3-afe2e3696675@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 31 Mar 2025 16:53:45 +0300
X-Gm-Features: AQ5f1JrIqVmjRdqSpn_64nrW4FOBxlt8TURrsGd3g0LNHmn3jv6cXM_yjR_xhWE
Message-ID: <CAC_iWjJa-XXqzQsRszzDS6h2v4sGd+0rWr=1piOQrVp-9Ud90w@mail.gmail.com>
Subject: Re: [PATCH 3/4] dfu: scsi: don't call scsi_scan()
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Wed, 26 Mar 2025 at 19:41, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Calling scsi_scan() results in all the block devices (and EFI block
> devices) being destroyed and re-created. This breaks the EFI filesystem
> drivers during capsule update.
>
> Remove the call, since boards really should be calling scsi_scan()
> themselves during board_init().
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/dfu/dfu_scsi.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/dfu/dfu_scsi.c b/drivers/dfu/dfu_scsi.c
> index 9f95194784c1de00458843276872b1d23d023444..a234548ae46dc2a6ae1ca5770accb58f43782239 100644
> --- a/drivers/dfu/dfu_scsi.c
> +++ b/drivers/dfu/dfu_scsi.c
> @@ -341,13 +341,8 @@ int dfu_fill_entity_scsi(struct dfu_entity *dfu, char *devstr, char **argv, int
>                 if (*s)
>                         return -EINVAL;
>         }
>
> -       if (scsi_scan(false)) {
> -               pr_err("Couldn't init scsi device.\n");
> -               return -ENODEV;
> -       }
> -
>         ret = find_scsi_device(dfu->data.scsi.lun, &scsi);
>         if (ret < 0) {
>                 pr_err("Couldn't find scsi device no. %d.\n", dfu->data.scsi.lun);
>                 return -ENODEV;
>
> --
> 2.49.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E79C072A2
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 01:43:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFA4687483;
	Thu, 16 Nov 2023 02:43:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZqCMoZsf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A79987452; Thu, 16 Nov 2023 02:43:21 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5880787448
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 02:42:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d9ca471cf3aso256737276.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 17:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700098967; x=1700703767; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/IMJ66FdPJVmCpCQesDPVhDsZG1z0RLPWGk3nPQdNog=;
 b=ZqCMoZsf7/54Ctyto8QZSB9tMxTZKHMV7iBpBDP8cvMle/5xXJSgtef3N0YWh3uxHv
 mydBTsd0L23VEO1diDidVtdQ/vJQudNXNRx0cxL+U8nlo5GREsbMzz4DdJ7iD0UIvqS0
 TePoo3pznxwHzMIb7HZxBwnKdThbJCMulA4/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700098967; x=1700703767;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/IMJ66FdPJVmCpCQesDPVhDsZG1z0RLPWGk3nPQdNog=;
 b=HIuQxiuYaugC1jWGTWfMaNXD6n/km1ZAYHl+UtMwrZPkjZ9DQyGJ0c9ssZdvhyPS9R
 nq0lUBVQgkYrX2QzGxG1lDSBX65kiW4NglA3LGy4bHnU0fj8A12XfCddOkHCGS32n6m/
 KZmkMRwSTjphXMDziTu1jfOIgunPHM3VGnplNobdTxU3uC3LZ27RoozZadNdysPv6GFI
 72fpF0Ken9n/xAQ2BkGPfRgYOug0Ag8599qWr6yTrvDi1A7Wo59+9Ca/toEOxEOcAZc3
 FidgQeHRJ2XaqbIQOA34Tad3wxs6DK7D7crcKf+KieK01pAGu/cPh9Ccf3Lf5xxJOWq/
 8tTQ==
X-Gm-Message-State: AOJu0YxWqNgh5NCBIKFkRJPX0MLkduETvrXXmiwWKPlk3GjP+GHxOuzY
 LamdXQxs2pH5E53c412ndVA/dTwxoC+I3lScRpitbg==
X-Google-Smtp-Source: AGHT+IH4jd2bx+L6ffPypWWT8KYsqVvn+DpviXZr/W1H+6UAx5K47gzYbWCERHV+D6Wbh4/bzT+NEzM4/buaaqGX1j8=
X-Received: by 2002:a25:c553:0:b0:d9a:384a:d4c5 with SMTP id
 v80-20020a25c553000000b00d9a384ad4c5mr13487976ybe.33.1700098966693; Wed, 15
 Nov 2023 17:42:46 -0800 (PST)
MIME-Version: 1.0
References: <e1683a7a-45b5-4a0d-9871-bcb25b0fd601@gmx.de>
In-Reply-To: <e1683a7a-45b5-4a0d-9871-bcb25b0fd601@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Nov 2023 18:42:23 -0700
Message-ID: <CAPnjgZ3XGy6CsWpc8Mq_0y5XBF=mDTj53ag9a2mL2guXuj_T_w@mail.gmail.com>
Subject: Re: [BUG] usage of $kernel_addr_r in distro_efi_boot()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Wed, 15 Nov 2023 at 18:07, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> If $kernel_addr_r cannot be read, distro_efi_boot() falls back to
> address 0. This will lead to a segmentation fault on many systems.
>
> distro_efi_read_bootflow_net() has a fallback to CONFIG_SYS_LOAD_ADDR
> and may have loaded to that address.
>
> Shouldn't we be consistent in what we program?
>
> Please, use a field in the bflow variable to indicate if and where an
> EFI binary has been loaded.

Can you check this series?

https://patchwork.ozlabs.org/project/uboot/list/?series=382070

Regards,
Simon

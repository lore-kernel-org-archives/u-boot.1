Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88766CD4939
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BB6786D35;
	Thu, 21 Sep 2023 03:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="bToAmNgd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0DA886D1D; Thu, 21 Sep 2023 03:06:02 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5CD586D20
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-59bd2e19c95so5903327b3.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695258357; x=1695863157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BIY41yrCKSHZKVuY98pXD73eUOgnYDwVw9XqKCPPdRo=;
 b=bToAmNgdToMsSBPfA85ri7T5BLU8rRBhn9VmkkZyBiXdUZARc8LCJM7ReMIK/qcni4
 Y69kKWFZO+X8a+WI0REPCY4Do7gkRR83ecSdq3a0z/KR6dzRgzTuB8O1DrlJjsJexr4j
 hmMNCjNrdcg/mUPdXDVQ7CxDvoDIOqSmgC7Iwj8VrviOTYBoaY8PrLK8G+CE699j18wb
 s9hZHoKFRCpnvbUha/iKfT00MZWApMWMKaY/VsskW5ehDVaN6KrjYLYhYW3z7IVoGkRY
 8/8QN6xRbDB00mTgeAsROpnNDSUT4aj0HCWpnb/qMntdur2xZsiojw5YpJEVPveOyOlh
 oi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258357; x=1695863157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BIY41yrCKSHZKVuY98pXD73eUOgnYDwVw9XqKCPPdRo=;
 b=Y3VsjIOcqDEwwFoWKlmcabzQTj3JJkDows/mzKwgqO2bbf+FewJiwRydIrX4b+hpCs
 M5RP3hbYa6SSfE+P/xazvYiBgEIPuC8a4bFoiRyV9FrysJ2FA/Dlm/4bP/ccmKp3289z
 Z8HJRu6KfZGKUspERsjdzhcVdjaicl3eqGq8kTBNnDvYyOH4zzi5Z/7dsOWhoRpQ8BfE
 gV9HgH4lL2KpCEP4wjhrltuUfrIIKZZXyVmdkTFcYs2oNZZPxwIwo4sE3P35f5LQUSaE
 ZiUWwpmmIJqQ0DLHmC781MUEW4iQFODjVAMlgZUOp7mHFfXtNthygaMl2EPNoQokUvl5
 VTVA==
X-Gm-Message-State: AOJu0YyA37j8h9ChZVVyyLCjXCDFSTWe2ea1NNrgjhkyngxfrfNDPXQW
 TlxGifOpBvQsVOr0W+J6XqzfNYJeczH4XSyDYkhXKQ==
X-Google-Smtp-Source: AGHT+IGDUnQIbgP0L1z0t7yCVD4YdsitY947xSOohiRSYQCI0lntBym4CYMfk6D++jbM+shalwi8b/uChIFRqMBqtf4=
X-Received: by 2002:a81:4848:0:b0:592:58c4:1811 with SMTP id
 v69-20020a814848000000b0059258c41811mr4465696ywa.22.1695258357398; Wed, 20
 Sep 2023 18:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230911163536.20735-1-avromanov@salutedevices.com>
 <20230911163536.20735-6-avromanov@salutedevices.com>
In-Reply-To: <20230911163536.20735-6-avromanov@salutedevices.com>
From: Simon Glass <sjg@google.com>
Date: Wed, 20 Sep 2023 19:03:10 -0600
Message-ID: <CAPnjgZ0-r88tswTCnBYPSCfgLtzTu=_9675V-thvziRQ1ap4vA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] sandbox: defconfig: enable CONFIG_SM option
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: neil.armstrong@linaro.org, narmstrong@baylibre.com, 
 takahiro.akashi@linaro.org, ilias.apalodimas@linaro.org, post@lespocky.de, 
 marex@denx.de, msuchanek@suse.de, sughosh.ganu@linaro.org, 
 jh80.chung@samsung.com, paul.barker@sancloud.com, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de, kernel@sberdevices.ru
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

On Mon, 11 Sept 2023 at 10:35, Alexey Romanov
<avromanov@salutedevices.com> wrote:
>
> We use this option for test UCLASS_SM.

s/for/to/

>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  configs/sandbox_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index be46cae7aa..0745a4ecca 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -270,6 +270,7 @@ CONFIG_RTC_RV8803=y
>  CONFIG_SCSI=y
>  CONFIG_DM_SCSI=y
>  CONFIG_SANDBOX_SERIAL=y
> +CONFIG_SM=y
>  CONFIG_SMEM=y
>  CONFIG_SANDBOX_SMEM=y
>  CONFIG_SOUND=y
> --
> 2.25.1
>

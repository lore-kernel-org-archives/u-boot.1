Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D305C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:51:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 966E387CD1;
	Sat, 16 Dec 2023 19:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q1Yxaz+x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A8AB87CD2; Sat, 16 Dec 2023 19:48:57 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA49687CCD
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-591c3dc7265so277179eaf.0
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752533; x=1703357333; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wa9M7K7mt4IdvLYj9t3dbioxMeWqCHjJXkpq+qes6Ks=;
 b=Q1Yxaz+x7UcLxjTdiRzS6IMF3619ggIEJtvyzgMJ+bzysgdMG2H1D8k8g1PwscrO1/
 tIkj4BMCbizvd2zYBMLWk9gwM0YK4hBcAEKZ6ogkdo6Z87OWyu5+ohU41q3tSSIqe/Ce
 Va0bLrQezTE4W0TF9Zt6dV/HtHUx1FQiD5fiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752533; x=1703357333;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wa9M7K7mt4IdvLYj9t3dbioxMeWqCHjJXkpq+qes6Ks=;
 b=uZj1gP1V6tD8oT2Hou9ok7eNTM5HUFNDw0c7Sl8aNBCBaP1mzCjdWkqUI6N9Rpp2m9
 qSigBv5fw9/TSvLc78nzpOEepIw89uaWnFBI7BM2XmFCPAHyUxN/81q0rywHMrlrLhzS
 /65AlOt0YNwlJJEerg2xJpF7992c9n4p10GzcvmNJ6UH6AMsNFv74g4jYO72VAmtaJw6
 ZcfwwDwdCznsHsmKuq0dQiOnjeNZE70FJXVGH5ALWgQAQu6RdFGdnVwfE49Q7fbwix3C
 8lGlf190uzwbIMJ1EZzpVR9Cd7g50txMWjdY4e9TdvmNahW4wOPMukk0p49BMuWi082Q
 gTXA==
X-Gm-Message-State: AOJu0YwOPcADo/edFfHAMZsN6hYqg7XRRZDZRotJ6dzlTNmQ4XxiBLcB
 uN6keHkD7Sj39zcO4lwyIH3ZhH/PuyNODTwfbask/A==
X-Google-Smtp-Source: AGHT+IEWLnAc/YbfLmPn7NurZ/OM5LCyyP+UQxBSXWPkrQIQQ6jpLaSRYZSLte74tv1o1e1EqKEp8Upyy80y5CeZ0AQ=
X-Received: by 2002:a05:6808:38cd:b0:3ba:789:bcbf with SMTP id
 el13-20020a05680838cd00b003ba0789bcbfmr20511093oib.117.1702752533186; Sat, 16
 Dec 2023 10:48:53 -0800 (PST)
MIME-Version: 1.0
References: <20231215182658.187516-1-heinrich.schuchardt@canonical.com>
 <20231215182658.187516-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231215182658.187516-5-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:46:17 -0700
Message-ID: <CAPnjgZ2FmO+3M0fpw+Ofyi_FBnhHsn_L2JZ8BYFiEeKs6C7k7Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] aci: fix acpi_find_table() for DSDT and FACS
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
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

On Fri, 15 Dec 2023 at 11:27, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Use X_DSDT and X_FIRMWARE_CTRL if available.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  lib/acpi/acpi.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Could use a test.

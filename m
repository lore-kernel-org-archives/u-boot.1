Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E053C47258
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 13:50:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9991387561;
	Thu, 11 Jan 2024 14:50:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sUk11JOS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7857787751; Thu, 11 Jan 2024 14:50:46 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B21B871C7
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 14:50:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50e759ece35so5999361e87.3
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 05:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704981044; x=1705585844; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jbEUn/ABJiWlIMTdg4PVs2xoE+wa9K6sPVTEXaRC0jY=;
 b=sUk11JOSuYpSsaQm47E99OAQA/rJ2N7b/qb77h2cl5gzGEZVXUwZbnSkL2rxpB5Jf8
 JTlbyqIWZMNq3+WxLJXdm2h94C0aDq/sgOiK6KIaZJu0UrzFaxWToSTSR/BtRQAsGpBd
 Dov7P/SHtziTewdDkI+S/Gfc8T21zD3PO8VLhZMqXCWXQqx7PlN4Bcn/w6X44C4XRsbk
 m9p1coFromZI3wqsuxFbIZOobbEKIXymAanMVf5/hmZdh9X1bRTMbID1zo7Ib7uZI1ME
 vgUhQ7M7PrldVsOJ6XCssH31sHWWs/pD8r0hSuEOA+zPbKsmUQT/CU3MzcoI7YZAVb0Z
 Es2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704981044; x=1705585844;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jbEUn/ABJiWlIMTdg4PVs2xoE+wa9K6sPVTEXaRC0jY=;
 b=KHfyZdSuZri6R7JefTTd6Fp94lSSd28uwvcTTOEwN9IWDAffI6HNyHcxjfiiciC3ip
 o63cTLiDC2wGEU50pJHOGeXMrRa1c0CrndzXjlOcz+i42Q3BDeX53qOyxgIzXuBOfMBz
 frZ39vhJemLNG6uiPgcMSdt4AFi2UlALrhXpQPoMFTpx/xhTZNA0DXy7CgqQVCQkGM8k
 V3phEbLpRIWry/ixrRU0prgaNQhPhlD5tXxrnxNgHrrtn2062rc9mglzdAOyJGmHZ3lD
 vWf8LhLq3i5p7fX8uRpvJlIpbsgvEdGeDBph2bURWCTRcVAFEiJ96zNS9l8dFKZOS9Nm
 PySA==
X-Gm-Message-State: AOJu0YyNu0ok4A7K5FBEu16NfklBpQXT72VN5ZeyzKAG4cP7GttXxtlE
 VgTKZDhSs/acBfQeoQdkKShaLavCEfkB7rMEcDbwVD38gYckaSMQrhSsl8qzh14=
X-Google-Smtp-Source: AGHT+IEM4btT24EWcfse7S/6TNSJNUn0E5k7553VoDtBacUTf1KzGaHRG9IDurj8lFviHcTovbf2oiFxN6ZDKlA1LGg=
X-Received: by 2002:a19:ca44:0:b0:50e:7bb7:af8a with SMTP id
 h4-20020a19ca44000000b0050e7bb7af8amr462177lfj.136.1704981043638; Thu, 11 Jan
 2024 05:50:43 -0800 (PST)
MIME-Version: 1.0
References: <dffd2ee4cf2844832ebbdabefca0099cd2629ccc.1704980933.git.michal.simek@amd.com>
In-Reply-To: <dffd2ee4cf2844832ebbdabefca0099cd2629ccc.1704980933.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 11 Jan 2024 15:50:07 +0200
Message-ID: <CAC_iWj+GDQV2n2TH-3JbxSNnwRSrHLJ3=pe3JF10z8TN9_g4XQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: zynqmp: Start TPM automatically via preboot on Kria
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

On Thu, 11 Jan 2024 at 15:49, Michal Simek <michal.simek@amd.com> wrote:
>
> SOMs have HW tpm but previous stages won't start it that's why start it at
> U-Boot which will also provide access to random generator and it's usage
> with KASLR.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  board/xilinx/zynqmp/zynqmp_kria.env | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
> index 36182f1b0d85..0f940bd68f89 100644
> --- a/board/xilinx/zynqmp/zynqmp_kria.env
> +++ b/board/xilinx/zynqmp/zynqmp_kria.env
> @@ -60,7 +60,10 @@ kr260_setup=i2c dev 1 && run usb_hub_init; i2c dev 2 && run usb_hub_init;
>  # usb hub init with enabling PM nodes for ...
>  kd240_setup=i2c dev 1 && run usb_hub_init;zynqmp pmufw node 33; zynqmp pmufw node 47
>
> +tpm_setup=tpm autostart;
> +
>  board_setup=\
>  if test ${card1_name} = SCK-KV-G; then run kv260_setup; fi;\
>  if test ${card1_name} = SCK-KR-G; then run kr260_setup; fi;\
> -if test ${card1_name} = SCK-KD-G; then run kd240_setup; fi;
> +if test ${card1_name} = SCK-KD-G; then run kd240_setup; fi;\
> +run tpm_setup
> --
> 2.36.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

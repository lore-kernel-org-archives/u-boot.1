Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE54C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 05:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC1BA87F7F;
	Tue, 20 Feb 2024 06:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TtMFKKpz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62CB887F6C; Tue, 20 Feb 2024 06:43:06 +0100 (CET)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F02587F7A
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 06:43:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7d130979108so2385798241.1
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 21:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708407776; x=1709012576; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ViC+sh1BOXDX4AYCPiquhc4zvDzTJkkUske4W/ToXoo=;
 b=TtMFKKpzAR+kCpl73WXj0rlxrr7oEAYs9ThL91EIbDQtJkSaQJVqh52I8TL1ZQeOmu
 hhCoMMvLAqw3FnHLsUDoXv5FSP6xnRQfL+ifQnjMWVsNZEHO1zA32XF98kGT+0a0nSLJ
 4cL/3Y9l7TLYNw9jXaLM9xKMuJtaWYc/AliLjW/U3/oeffnv0oMje7uJKdPy4IBo/An/
 RDCoigcqjKLY7AFNnmt7ZbJi54av09W0RYCFyaUcePccR1a85tTxrFRrLxk4Wyjcs/yG
 XuEUARP4JR9zF+3BpAdab61tVLK35l9SMijjNrfrHNEpJSxVZXyvC6WBHUiOpqwxpCQ+
 Jb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708407776; x=1709012576;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ViC+sh1BOXDX4AYCPiquhc4zvDzTJkkUske4W/ToXoo=;
 b=DlZ6xtqcmPb20YZmkeb22Ov+9ngnPfvWU0kFE0knFr7IpgyQM02YGcOjsl+ibnK2nI
 grnqvxGqlvD72+IbfaPLS30iiusJJ4ndgJ+Urye0wAWP9BPVIiaKRJHaAOFHhGHQ4/6z
 0pbbUzvmwFXuZ4AtxWjAhSUsdFGb5iqY3e2OJCsrJbxcUZ0CWVdcHXdPc/LOYur+yl1y
 1tlmjhqy5FhAjunt7YPlNy8DHD2mUcSUIsi9KQDbLYRmw7waw/p36q2RMd//SOFtmny0
 1ZjKpoE2oBIujaCYjq8BIUbzFy6n973bLCzD7eyUSLdsOykracInI6mz1mkaxAYdMFH8
 8tZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdTcIAkKPVAYf/XSzEFdrEBPMUXwWaRlc+B5QlJslNxP+83VYkfv/NFSdQu6If7beJ66/+n1CF6UD2DqNkwAEBSgVLaA==
X-Gm-Message-State: AOJu0YynuAGl03zmq9av8PeKV0x0+6WzeniTFAh3TpCZ7a8mC6GUVVyJ
 5m0okqJaIxaoLt85PZhXYehPE6pt7uiBbpq/OES4E4rMsOtIsIOPgP6cr4qhLVtmu9qREjqAE6F
 bg1k8sYBBGwcHsImO9Kb4TFDIOXzt3Sq56UzG3z2iwqQB0k4/aWY=
X-Google-Smtp-Source: AGHT+IEtuc3UkJIMKdcAkTdkoOWX1LZ/nTi74daK7n3v6uwbdanTiFM6+uYy/7wqsgdK3ICxstuO/08fEt+xRa/1uoM=
X-Received: by 2002:a05:6102:5f8:b0:470:3f14:b86 with SMTP id
 w24-20020a05610205f800b004703f140b86mr5405398vsf.11.1708407776180; Mon, 19
 Feb 2024 21:42:56 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-4-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-4-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 11:12:45 +0530
Message-ID: <CAFA6WYPEFX8tCF1=CB_erg4AKiQu7Sgj_+dg6b0+5yt57Ufjgg@mail.gmail.com>
Subject: Re: [PATCH v4 04/39] dt-bindings: drop msm_sdhci binding
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

On Fri, 16 Feb 2024 at 02:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> The upstream DT is supported here, so drop the U-Boot specific binding
> docs.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  doc/device-tree-bindings/mmc/msm_sdhci.txt | 25 -------------------------
>  1 file changed, 25 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/doc/device-tree-bindings/mmc/msm_sdhci.txt b/doc/device-tree-bindings/mmc/msm_sdhci.txt
> deleted file mode 100644
> index 08a290c66931..000000000000
> --- a/doc/device-tree-bindings/mmc/msm_sdhci.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -Qualcomm Snapdragon SDHCI controller
> -
> -Required properties:
> -- compatible : "qcom,sdhci-msm-v4"
> -- reg: Base address and length of registers:
> -       - Host controller registers (SDHCI)
> -       - SD Core registers
> -- clock: interface clock (must accept SD bus clock as a frequency)
> -
> -Optional properties:
> -- index: If there is more than one controller - controller index (required
> -       by generic SDHCI code).
> -- bus_width: Width of SD/eMMC bus (default 4)
> -- clock-frequency: Frequency of SD/eMMC bus (default 400 kHz)
> -
> -Example:
> -
> -sdhci@07864000 {
> -       compatible = "qcom,sdhci-msm-v4";
> -       reg = <0x7864900 0x11c 0x7864000 0x800>;
> -       index = <0x1>;
> -       bus-width = <0x4>;
> -       clock = <&clkc 1>;
> -       clock-frequency = <200000000>;
> -};
>
> --
> 2.43.1
>

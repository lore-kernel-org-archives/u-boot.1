Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD3CD41C02
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 05:31:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A011E894BC;
	Wed, 13 Nov 2024 06:31:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Tu27jVx8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6C68894F3; Wed, 13 Nov 2024 06:31:12 +0100 (CET)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0426D890D0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 06:31:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-50de14e7d8cso2575348e0c.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 21:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731475869; x=1732080669; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Lx0rE9LYSCQpMaOflU9UbPMG9RKT4wqzOXgFwM6S4Ns=;
 b=Tu27jVx88R0dogWd/SUmpNpv+TrrHNTYHJ1wCaCmrZtJYLiMi+MsWmomJv9xB/CkLR
 rjNDKdXIKUqFoYcDSLuQPJMPyHe/DCKCe1RYHqGYioREFDmi+6Ib18WfppB3cMD01iWD
 7Z8S5J2Yfq3/Uv+Ey+bVbr5JGC4qrBzxXNCz8EvppKiUiIsnOWNyx4qApfxWZ4NPoorR
 cxvtFzvBfI0eVbbE7japovotSYJTG8Dk1G6CZG6ShYFxwJ2NDAzu/bIt2sK3kbqFK4bZ
 n/VlIOyZseGAAc+4m33yBRp/RpkMUzV4AkgoL/OmTJN1wKIpAOSrMs/HaGMcaMTieIQY
 6wtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731475869; x=1732080669;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lx0rE9LYSCQpMaOflU9UbPMG9RKT4wqzOXgFwM6S4Ns=;
 b=JDKMtTx3rIstxKeuF7G1HsmGTIHVq1VfZO9ED0allMKsuyNefIImqubAO1v9S6Kg/L
 0irjiHj+6CNSPHbd5+pgxBv8tLJ/9v7OEUd+xGzChEg/NOJTB0t1zFpPPxFrr+x7kt8c
 1a+pAEp6OfZ027fTM3PD8LGmbp/QcHNvUCdsVFDrbAAGbrXm0eEha4hpcTlX51rcqICe
 nvl12tRo8HGHTaZOkrh12mHSvRGps/F5q+v0KoK7MpXQoN89CqBBs/g7tEscvHbbSPBK
 YMP8CY+aVLkG9LQV+J92e+rwf2ePxaB96UdJs7vyz1OR05yc6k6fonboJRtgCNkuo/+2
 TeCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4EW9J8IEtDBD1t4PaO7TdAplMcMOhhWNEZJddyNVrC+AoTI4zE8Ej+L7CLDfVlLlB7Pavet0=@lists.denx.de
X-Gm-Message-State: AOJu0YzDwvkgY9asJe9wQLxVRcjvNOR2wo/JMHcDCqw1hFcg73BQA0TP
 Bx9iW1OsBIbXIlbkrT2XjnSq0K73CQ2qLIAKq8A3txtIV3/boGjZxWYKN/SMjMgHz0mUcpmujM4
 FgFt/fw4Gpar9k8Zr1y+81wv0ASVTCKhZi7kpQw==
X-Google-Smtp-Source: AGHT+IH33+UuHCtLaJf/5JJQ1GWzVTa1cYYCnM6WryW/CKZDWRUHVlQglhgtItHWXjEsdMtGFJETsRtg2T19I93JmAk=
X-Received: by 2002:a05:6102:2ac5:b0:4ad:4ef3:fb0a with SMTP id
 ada2fe7eead31-4ad4ef3fbd8mr18249137.23.1731475868739; Tue, 12 Nov 2024
 21:31:08 -0800 (PST)
MIME-Version: 1.0
References: <20241113043546.1821062-1-caleb.connolly@linaro.org>
In-Reply-To: <20241113043546.1821062-1-caleb.connolly@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 13 Nov 2024 11:00:57 +0530
Message-ID: <CAFA6WYOuRxgN-F3j0F7vSa3gUAc+0pRKpUFuKS6VYg-U4tX4vA@mail.gmail.com>
Subject: Re: [PATCH] treewide: remove Qualcomm dt-binding headers that are
 available upstream
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
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

On Wed, 13 Nov 2024 at 10:06, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Some dt-binding headers mask the upstream ones which can lead to build
> failures, or worse: super weird bugs, if they get out of sync.
>
> Remove these headers so our devicetree and binding headers will both be
> in sync with upstream.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Build tested with qcom_defconfig, boot tested on SM8250/RB5
> ---
>  include/dt-bindings/clock/qcom,camcc-sdm845.h | 116 -----
>  .../dt-bindings/clock/qcom,dispcc-sdm845.h    |  56 ---
>  include/dt-bindings/clock/qcom,gcc-msm8916.h  | 179 --------
>  include/dt-bindings/clock/qcom,gcc-msm8996.h  | 361 ---------------
>  include/dt-bindings/clock/qcom,gcc-qcs404.h   | 180 --------
>  include/dt-bindings/clock/qcom,gcc-sdm845.h   | 246 -----------
>  include/dt-bindings/clock/qcom,gpucc-sdm845.h |  24 -
>  include/dt-bindings/clock/qcom,lpass-sdm845.h |  15 -
>  include/dt-bindings/clock/qcom,mmcc-msm8996.h | 295 -------------
>  include/dt-bindings/clock/qcom,rpmcc.h        | 174 --------
>  include/dt-bindings/clock/qcom,rpmh.h         |  36 --
>  .../dt-bindings/clock/qcom,turingcc-qcs404.h  |  15 -
>  .../dt-bindings/clock/qcom,videocc-sdm845.h   |  35 --
>  include/dt-bindings/dma/qcom-gpi.h            |  11 -
>  include/dt-bindings/firmware/qcom,scm.h       |  39 --
>  include/dt-bindings/iio/qcom,spmi-vadc.h      | 300 -------------
>  .../dt-bindings/interconnect/qcom,msm8916.h   | 100 -----
>  .../interconnect/qcom,msm8996-cbf.h           |  12 -
>  .../dt-bindings/interconnect/qcom,msm8996.h   | 163 -------
>  .../dt-bindings/interconnect/qcom,osm-l3.h    |  15 -
>  .../dt-bindings/interconnect/qcom,sdm845.h    | 150 -------
>  include/dt-bindings/phy/phy-qcom-qmp.h        |  20 -
>  include/dt-bindings/phy/phy-qcom-qusb2.h      |  37 --
>  include/dt-bindings/pinctrl/qcom,pmic-gpio.h  | 164 -------
>  include/dt-bindings/pinctrl/qcom,pmic-mpp.h   | 106 -----
>  include/dt-bindings/power/qcom-rpmpd.h        | 412 ------------------
>  .../regulator/qcom,rpmh-regulator.h           |  36 --
>  include/dt-bindings/reset/qcom,gcc-msm8916.h  | 100 -----
>  include/dt-bindings/reset/qcom,sdm845-aoss.h  |  17 -
>  include/dt-bindings/reset/qcom,sdm845-pdc.h   |  22 -
>  include/dt-bindings/soc/qcom,apr.h            |  28 --
>  include/dt-bindings/soc/qcom,rpmh-rsc.h       |  14 -
>  include/dt-bindings/sound/qcom,lpass.h        |  46 --
>  include/dt-bindings/sound/qcom,q6afe.h        |   9 -
>  include/dt-bindings/sound/qcom,q6asm.h        |  26 --
>  .../sound/qcom,q6dsp-lpass-ports.h            | 234 ----------
>  include/dt-bindings/sound/qcom,wcd9335.h      |  15 -
>  37 files changed, 3808 deletions(-)
>  delete mode 100644 include/dt-bindings/clock/qcom,camcc-sdm845.h
>  delete mode 100644 include/dt-bindings/clock/qcom,dispcc-sdm845.h
>  delete mode 100644 include/dt-bindings/clock/qcom,gcc-msm8916.h
>  delete mode 100644 include/dt-bindings/clock/qcom,gcc-msm8996.h
>  delete mode 100644 include/dt-bindings/clock/qcom,gcc-qcs404.h
>  delete mode 100644 include/dt-bindings/clock/qcom,gcc-sdm845.h
>  delete mode 100644 include/dt-bindings/clock/qcom,gpucc-sdm845.h
>  delete mode 100644 include/dt-bindings/clock/qcom,lpass-sdm845.h
>  delete mode 100644 include/dt-bindings/clock/qcom,mmcc-msm8996.h
>  delete mode 100644 include/dt-bindings/clock/qcom,rpmcc.h
>  delete mode 100644 include/dt-bindings/clock/qcom,rpmh.h
>  delete mode 100644 include/dt-bindings/clock/qcom,turingcc-qcs404.h
>  delete mode 100644 include/dt-bindings/clock/qcom,videocc-sdm845.h
>  delete mode 100644 include/dt-bindings/dma/qcom-gpi.h
>  delete mode 100644 include/dt-bindings/firmware/qcom,scm.h
>  delete mode 100644 include/dt-bindings/iio/qcom,spmi-vadc.h
>  delete mode 100644 include/dt-bindings/interconnect/qcom,msm8916.h
>  delete mode 100644 include/dt-bindings/interconnect/qcom,msm8996-cbf.h
>  delete mode 100644 include/dt-bindings/interconnect/qcom,msm8996.h
>  delete mode 100644 include/dt-bindings/interconnect/qcom,osm-l3.h
>  delete mode 100644 include/dt-bindings/interconnect/qcom,sdm845.h
>  delete mode 100644 include/dt-bindings/phy/phy-qcom-qmp.h
>  delete mode 100644 include/dt-bindings/phy/phy-qcom-qusb2.h
>  delete mode 100644 include/dt-bindings/pinctrl/qcom,pmic-gpio.h
>  delete mode 100644 include/dt-bindings/pinctrl/qcom,pmic-mpp.h
>  delete mode 100644 include/dt-bindings/power/qcom-rpmpd.h
>  delete mode 100644 include/dt-bindings/regulator/qcom,rpmh-regulator.h
>  delete mode 100644 include/dt-bindings/reset/qcom,gcc-msm8916.h
>  delete mode 100644 include/dt-bindings/reset/qcom,sdm845-aoss.h
>  delete mode 100644 include/dt-bindings/reset/qcom,sdm845-pdc.h
>  delete mode 100644 include/dt-bindings/soc/qcom,apr.h
>  delete mode 100644 include/dt-bindings/soc/qcom,rpmh-rsc.h
>  delete mode 100644 include/dt-bindings/sound/qcom,lpass.h
>  delete mode 100644 include/dt-bindings/sound/qcom,q6afe.h
>  delete mode 100644 include/dt-bindings/sound/qcom,q6asm.h
>  delete mode 100644 include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
>  delete mode 100644 include/dt-bindings/sound/qcom,wcd9335.h
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

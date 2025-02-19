Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52085C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 12:21:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0197800D7;
	Wed, 19 Feb 2025 13:21:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j8C8RxGo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A08D2809A4; Wed, 19 Feb 2025 13:21:27 +0100 (CET)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FCC0800B3
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 13:21:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4be66ac7685so859110137.2
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 04:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739967684; x=1740572484; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j+E9Qytr/qGedl13/+kj0Y8WF79vQ1AhwcFzDhzrayE=;
 b=j8C8RxGoNeSQ+kEpmn7+lXL4DwUYW4lOMhi7TTbov5nqouA0iHjEakn8ihMafVi9Jv
 rmz/a8z0fPonja7LAkmzopcw2xRDEpehcDJg/QCjulDbb5zEmXqm6B8i8Gmq3tCw3Pr0
 pDdt09Rp+xSOL4jwILhphRWV7UGjcMgB199Z57jLjWyJwCt7dOmilWeXEJ2XLLP6wheW
 s1bBNgBe0iyNhOrfVMF3D4YU5WkdOPQTkkFQDeerc7BP7Ux4o3vOJW7uYHDBBGkU/KKf
 Bjkmsw/BipC1oVkerGL9/Lx1hituI3qkxefUeF2Ui68axk0rQKZLTSzTsq+DoIYwPj+d
 ZWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739967684; x=1740572484;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j+E9Qytr/qGedl13/+kj0Y8WF79vQ1AhwcFzDhzrayE=;
 b=p5PYMYjcYstFa4muHpMjIYXITAWwDP2ZODfk9BMrN8aAMk7d5liC8YM/vq56h7B6EF
 5IhC3ZhDoJZUoCKgW8F+tw+JjbVItstsSuX43wNnCUOrCznG0CCn3WglPgsMW7fDSygN
 cF5vGMz3DSctzaSEhQPRat7O0wb2E8UbxsynBw1IUXYh1sv5Zi+mAtKQxjhg4OfMDUHb
 lYXwwA+svdNE4V5AX0hE2UjwBu43F661s3lwV9P2YlVFcgfBac9SBXYbPBK0ogRV5+E2
 u/4Nx1uhZ3cxDzidrxB1EEUrZbnaZmxXJ60L/hIrUgUdcFq6YpwRxdR8YxhTdiVEhFWZ
 wV2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0YBlannZEd0JK6AOF2ecMJ1aKz6tdj6/3RzNft38hN6gvO2cOcO0OxorxTZwuBXGjtix1x0Y=@lists.denx.de
X-Gm-Message-State: AOJu0YwNpaJ95xlhCyYJtWK/OoGjXocMase1k6tqeEVIS6k5Q5wIgJEw
 KT76rS7wX1KfGx/7yLKoM2ndCQA9JdvtODzx6qFhTgPySsWQL+THGQ0bmhR7tcJQYuhemFmfmpU
 /DKQ7vEbmQFLFVEAHGVIqdC4vLEQ1XQwN1Ffr1Q==
X-Gm-Gg: ASbGnct3JDKfpwrEOPvUj+oErmC23HZqe/tkQxlIovCenOEPiFmWJ2NW6aWj8FncE5q
 8bcN5Mqv1FgP50BlQmqxtAFwuKgiXfel6lqj++4tlTYcK2POtuxlWkiByFLKo0lRlEMF4UJa8tA
 ==
X-Google-Smtp-Source: AGHT+IEhmmZ4l4iPh1jZXW6EYLZe+kNzn6WnxnZyO1gviX6mUTYTv8VW8/DbQdJo05IIOdgjK2K6x4iccYLasmLgR9E=
X-Received: by 2002:a05:6102:c50:b0:4bb:ecb9:b34f with SMTP id
 ada2fe7eead31-4bd3fd18b8dmr7420831137.14.1739967684159; Wed, 19 Feb 2025
 04:21:24 -0800 (PST)
MIME-Version: 1.0
References: <20250218085430.2422287-1-quic_varada@quicinc.com>
 <20250218085430.2422287-8-quic_varada@quicinc.com>
In-Reply-To: <20250218085430.2422287-8-quic_varada@quicinc.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 19 Feb 2025 17:51:13 +0530
X-Gm-Features: AWEUYZmMqDXpKedUixvjMwPHJh7vFexJPB3vAq_rM9UzFx_yFM1bj6dRYmNNDaY
Message-ID: <CAFA6WYMOXPLSPEihUa4i3xWkfgd7p+AWHiQmsUnv9Z7KfVwyKA@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] qcom_defconfig: enable ipq9574 clock & pinctrl
 driver
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org, 
 lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 robert.marko@sartura.hr, luka.perkov@sartura.hr, ilias.apalodimas@linaro.org, 
 sjg@chromium.org, lehmanju@devpi.de, Volodymyr_Babchuk@epam.com, 
 marek.vasut+renesas@mailbox.org, pbrobinson@gmail.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
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

On Tue, 18 Feb 2025 at 14:25, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Enable the IPQ9574 clock & pinctrl driver in the Qualcomm defconfig.
>

Does this really have to be enabled in the Qualcomm defconfig if it
can't be supported due to size constraints?

-Sumit

> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  configs/qcom_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index e4abfdf16b..865381f75d 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -47,6 +47,7 @@ CONFIG_BUTTON_QCOM_PMIC=y
>  CONFIG_CLK=y
>  CONFIG_CLK_QCOM_APQ8016=y
>  CONFIG_CLK_QCOM_APQ8096=y
> +CONFIG_CLK_QCOM_IPQ9574=y
>  CONFIG_CLK_QCOM_QCM2290=y
>  CONFIG_CLK_QCOM_QCS404=y
>  CONFIG_CLK_QCOM_SA8775P=y
> @@ -94,6 +95,7 @@ CONFIG_PINCTRL=y
>  CONFIG_PINCONF=y
>  CONFIG_PINCTRL_QCOM_APQ8016=y
>  CONFIG_PINCTRL_QCOM_APQ8096=y
> +CONFIG_PINCTRL_QCOM_IPQ9574=y
>  CONFIG_PINCTRL_QCOM_QCM2290=y
>  CONFIG_PINCTRL_QCOM_QCS404=y
>  CONFIG_PINCTRL_QCOM_SDM845=y
> --
> 2.34.1
>

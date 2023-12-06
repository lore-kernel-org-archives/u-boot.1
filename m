Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CA5C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 03:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54A678753E;
	Wed,  6 Dec 2023 04:54:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AINAeeaQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F473875F5; Wed,  6 Dec 2023 04:54:26 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39A9686D37
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 04:54:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a1db99cd1b2so3546266b.2
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 19:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701834863; x=1702439663; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2W5IWw6MbUPc6Yh37Bn5cK8FpiDayJKGOgoVTzj+2YI=;
 b=AINAeeaQr8t7x7RRthc19bPWCoYZ1VN/ZAXQVevDjTJz1EayswaJA4wMprtic+n1Ah
 VSTCoM5KeVXg4Hwq8T72kVSgf9F/Z5UjWiXSNIfzmyiVDztqj55lm58xH5e2u1v1KzOe
 TO77l/cPKOTLXlG01ms1xJ12+Op8CDwLbiNNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701834863; x=1702439663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2W5IWw6MbUPc6Yh37Bn5cK8FpiDayJKGOgoVTzj+2YI=;
 b=HTR48CJSYeaEwMl81EPuNr9Vlmj5ULbZRhsQ/cKfkEVSHBOsIZDYyWVr/dMYospWRl
 84dP2TqM54NvaxwCFeQmcjWSZw2xfjUvt8FGX2MO9j+7226fjNnsRMyoWzlND10HZtMv
 AJ7DP40J/xrdjf2w61eFMqgS1+d9ixG5QM9IvB621Lk+gfPEYMHMEcfXCI+tWslUhefZ
 W5vwxs+FlDonRwJ3pWmiBs9Jb3MibxPHec07JJnBf33cz0aj6LNh+uVw9d2Orjnj0Sij
 7wPPBjgJ06buCd5jlb3Iq02RhmPFHXeRmNB4gGVYaBBJziGDLQW2oyvaKSXYU58OX7My
 nggQ==
X-Gm-Message-State: AOJu0YzCEcw5J/PHXt9TWFVw0vjQE6qN8i/eHw6UwwVmpyZzGdTR7txS
 UVvOvGeG5SaHFP4Kvhy0AKDZpo8ag385jpfUrpYPsA==
X-Google-Smtp-Source: AGHT+IEKFk4B566o+YaXDaGs66Gudn8LtvRitZYQUzqE+0X3fGqjMQcrnbugvi0GIh3+eenF9r9ou/iXNy0NyshHYQ0=
X-Received: by 2002:a17:906:19d8:b0:a19:a19b:420c with SMTP id
 h24-20020a17090619d800b00a19a19b420cmr108506ejd.119.1701834863695; Tue, 05
 Dec 2023 19:54:23 -0800 (PST)
MIME-Version: 1.0
References: <20231205-b4-qcom-dt-compat-v6-0-61d104a8f920@linaro.org>
 <20231205-b4-qcom-dt-compat-v6-5-61d104a8f920@linaro.org>
In-Reply-To: <20231205-b4-qcom-dt-compat-v6-5-61d104a8f920@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Dec 2023 20:54:05 -0700
Message-ID: <CAPnjgZ2pLYkkFZnrQf5=T-eA-NXoe0oO1yAoZKGmXY3eDDYUBw@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] gpio: qcom_pmic: support upstream DT
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, u-boot@lists.denx.de
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

On Tue, 5 Dec 2023 at 06:48, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Upstream uses the gpio-ranges property to define the number of GPIOs,
> support for parsing this when gpio-count is unspecified
>
> Additionally, drop the bank-name property as it isn't used in upstream,
> and we can just hardcode the bank name instead.
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Tested-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/gpio/qcom_pmic_gpio.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

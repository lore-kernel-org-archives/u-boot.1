Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7401ED21279
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 10:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABEF488EF7;
	Thu, 17 Oct 2024 12:54:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QNnt0vAp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CC2188EAE; Thu, 17 Oct 2024 12:54:55 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 825D088B16
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 12:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9a26a5d6bfso124713466b.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 03:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729162491; x=1729767291; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+sLsjHzLgDvC7zkeKbWrtZmkEE6o6/cnLqqTgdJLtic=;
 b=QNnt0vApTPNulQuCawmJYi29yFoV1v8FJMLhIm5kUWO5aSLxQez4HDTvtPTQyVi3FG
 M/GaMjpwwdNKkcoxXQtzEZZMB0QWEd2kQk09M0dte7dlO0Y0CcEzfQyEpNs2yKv3Lecw
 4S6+WAtMZ57z9Pti70YMIGLte80Ul751mDJvUqP78RjaaKUJVpKeLah7XXmKZrlE+KrP
 4EKBCB/yFF72TlPWq6rNvty58IsqIxtsFHXfEEj68NhhvVgrzZe/3zMWY8t6+BM7V3Yo
 IoBeGTJrbsWJ2eraEfJkx2LlzsFYelsgwP2LJyYUAyeCVAZbTLS/i65uZ/eiRMPHCCDL
 YbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729162491; x=1729767291;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+sLsjHzLgDvC7zkeKbWrtZmkEE6o6/cnLqqTgdJLtic=;
 b=j+stLhcfHHsRZ5w8CqrStFFCCVbTaaos4IzHrtjdK+tVsijxSM73dXPmQcNLkFLzov
 pP0dlAhQLvDWKCHmb56h+MsWsKQo6lxBTyRDJZLtRNMyQRiMah2ZBv++BAIvoLEB1JsG
 v6hDvvXZI7yNlGLBIQJpANH4KKjSfz8P4OD34QQsZjLbhyjgFLtBTg8wKr8Wrg+QT0K1
 iVKR7wnMBOFtSWpiR21vZ/6R0F1flp/gbpik+tSBAyeRmqeQtHEmZqB1oN3qoQt5jrV+
 phcoyZL+7oojqnI0+X+sP7iVdFMQl7HyHdjuQqHPKSjSuIDVzFQdwT8sn/WIk703cvdg
 zgVA==
X-Gm-Message-State: AOJu0YxE4KF5mBbvRHG+AK7Yg8kcDK++Xu+2r0fNG4a2+fYQxrx8znux
 Upg9JPbbQ9CVn7eFSZKYmh5EqZ6OvCnOC7jdH4FkN4j3YWowE/uSTY507BUizoE=
X-Google-Smtp-Source: AGHT+IHGW1NIC4M9uyQu5FL1XfvMl8w3Cys/VIGfziBNYJSKyWP6HPPiLEoVIkjl8yd1Bpni8fO92Q==
X-Received: by 2002:a17:907:f760:b0:a99:87ea:de57 with SMTP id
 a640c23a62f3a-a99e3b21443mr1754155166b.2.1729162490874; 
 Thu, 17 Oct 2024 03:54:50 -0700 (PDT)
Received: from ?IPV6:2a02:8109:888d:ff00::2? ([2a02:8109:888d:ff00::2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a29895ccbsm283302266b.219.2024.10.17.03.54.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 03:54:50 -0700 (PDT)
Message-ID: <2a7a7858-939c-42bf-9c91-55ef59bb09df@linaro.org>
Date: Thu, 17 Oct 2024 12:54:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: remove phy/phy-qcom-qmp.h in favor of
 dts/upstream
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20241016-topic-sm8x50-drop-phy-qcom-qmp-local-bindings-v1-1-7928f9cbe8f0@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241016-topic-sm8x50-drop-phy-qcom-qmp-local-bindings-v1-1-7928f9cbe8f0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 16/10/2024 09:37, Neil Armstrong wrote:
> The upstream version has new defines use to build DT, drop
> it in favor of the dts/upstream more recent one.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   include/dt-bindings/phy/phy-qcom-qmp.h | 20 --------------------
>   1 file changed, 20 deletions(-)
> 
> diff --git a/include/dt-bindings/phy/phy-qcom-qmp.h b/include/dt-bindings/phy/phy-qcom-qmp.h
> deleted file mode 100644
> index 4edec4c5b22..00000000000
> --- a/include/dt-bindings/phy/phy-qcom-qmp.h
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> -/*
> - * Qualcomm QMP PHY constants
> - *
> - * Copyright (C) 2022 Linaro Limited
> - */
> -
> -#ifndef _DT_BINDINGS_PHY_QMP
> -#define _DT_BINDINGS_PHY_QMP
> -
> -/* QMP USB4-USB3-DP clocks */
> -#define QMP_USB43DP_USB3_PIPE_CLK	0
> -#define QMP_USB43DP_DP_LINK_CLK		1
> -#define QMP_USB43DP_DP_VCO_DIV_CLK	2
> -
> -/* QMP USB4-USB3-DP PHYs */
> -#define QMP_USB43DP_USB3_PHY		0
> -#define QMP_USB43DP_DP_PHY		1
> -
> -#endif /* _DT_BINDINGS_PHY_QMP */
> 
> ---
> base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
> change-id: 20241016-topic-sm8x50-drop-phy-qcom-qmp-local-bindings-f036014e174e
> 
> Best regards,

-- 
// Caleb (they/them)


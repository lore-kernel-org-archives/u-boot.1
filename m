Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D4DC5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 14:08:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C271787FBE;
	Tue, 20 Feb 2024 15:08:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MQSs6IdX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07BE787DE0; Tue, 20 Feb 2024 15:08:35 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9BB087DEB
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 15:08:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3c02b993a5aso3272739b6e.1
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 06:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708438109; x=1709042909; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/Fs1nnpD/gzP7kprgZgLhZvPJ7SwgbV1BQuinAIBRVU=;
 b=MQSs6IdXhvNeKpMvUVqW30OKkgkOpWQP86hHqsIRoQwbT65tKa4aslBZhcxTwj/SO0
 pKWL/InN00pGpIN7cC9WXB+qdALvVOQZ1IlRskN2FLkySfwPTBJqBuxQ1TJUze0PXN4O
 nav/Jms6/3W9eJMcrlFg/+NSWgqLB5xN9wVY4Dm9PgrHkDZcAIUDaxfxLIK8y2HtnB2X
 5VrpsH+kFOqsaBZZ/6ntd8nzTILOY69xH3xG1OLgt4ljHwQneb0DHKZABu+PEOhUoJ63
 ilzITcG6i2kmZyz5NeDAFz4gQHB3stIjdUz+gvj1UK1NcKaQE+Crp/PK2tF7mNSEdVBZ
 bkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708438109; x=1709042909;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Fs1nnpD/gzP7kprgZgLhZvPJ7SwgbV1BQuinAIBRVU=;
 b=b8XzfSNt7AJDL8jPuSXJVA6Za0YshIkXqzzZ7ZprOzeyPNc8/trKRP4QB35LU3u2wD
 m+PJS1lVwt8J3STsH77/EoBFMDIrW+xsRL5DYkkeZCnJB9DSUxAQtu/7+zYDKQROaihC
 nUm7/YCLAE3hlUk6mrnAtF9YGLb2IllQxUPvYYyh/B0e3bDZw/QrtnHvdNPseqbNNJBT
 6lY60RU+VVF5QHk12D8yZar0zrZW7rzwe/tl5S5kPoGxefrJUmciYc6Td9uTOh7agkRo
 ZLzrxf2s0D0r6h4l6h6qqC0oVSNC5GyEkzewDepj7Is3OadkziUoxrrTAaJDX1fNtfDq
 j6Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT5i0shc9yR8ZWfvIJOBs5FbsC1YbQbKl1eLUxyDx9OBesTtNfdJkTI+wLf6E7aJ2AD34tbYW1XjsayGNFanPoAUyT+Q==
X-Gm-Message-State: AOJu0Yzfq4YAfNzRQT35aeFG5dKdDSVkwT0BRkF8XeyRPNRXgCzwpQki
 bSTXAjugxPbW34EqAurSmy4barmPJh1lB9iHB1qwvrhQNteh+skNolPrNdNVkeEUudiBdhTxLi/
 T1QS6jSqzJjL4y6Hf4H0ik3cuJx1JyYPZJukiFg==
X-Google-Smtp-Source: AGHT+IFKKtn8lKMBOuZER8DQ5BQVlYmSvr9kf638CF3VOUmKmIG3RwVVImsv/+JkgBFnL0o2dgdaafwfPqYmGEf7XRY=
X-Received: by 2002:aca:2109:0:b0:3c0:3c3d:3671 with SMTP id
 9-20020aca2109000000b003c03c3d3671mr14404044oiz.30.1708438109635; Tue, 20 Feb
 2024 06:08:29 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-37-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-37-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 19:38:18 +0530
Message-ID: <CAFA6WYMps_7Sd2G38G=6ZuF2pwTbh=+WXbFHEt+iY1XMMOi9+g@mail.gmail.com>
Subject: Re: [PATCH v4 37/39] dt-bindings: import headers for qcs404
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

On Fri, 16 Feb 2024 at 02:23, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Import the headers needed for QCS404-evb.
>
> Taken from kernel tag v6.7
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  include/dt-bindings/clock/qcom,turingcc-qcs404.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>


-Sumit

> diff --git a/include/dt-bindings/clock/qcom,turingcc-qcs404.h b/include/dt-bindings/clock/qcom,turingcc-qcs404.h
> new file mode 100644
> index 000000000000..838faef57c67
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,turingcc-qcs404.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019, Linaro Ltd
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_TURING_QCS404_H
> +#define _DT_BINDINGS_CLK_TURING_QCS404_H
> +
> +#define TURING_Q6SS_Q6_AXIM_CLK                0
> +#define TURING_Q6SS_AHBM_AON_CLK       1
> +#define TURING_WRAPPER_AON_CLK         2
> +#define TURING_Q6SS_AHBS_AON_CLK       3
> +#define TURING_WRAPPER_QOS_AHBS_AON_CLK        4
> +
> +#endif
>
> --
> 2.43.1
>

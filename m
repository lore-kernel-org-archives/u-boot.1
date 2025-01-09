Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47EBE77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 05:40:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69B298006D;
	Thu,  9 Jan 2025 06:40:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fC2m9Oz7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22A2180317; Thu,  9 Jan 2025 06:40:44 +0100 (CET)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9895C8001F
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 06:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-85c4d855fafso147279241.2
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 21:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736401240; x=1737006040; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DycLZB5aWMkAVY6tskCG6L4zQq4+W8964z6dAV5pUjI=;
 b=fC2m9Oz72mSXOaZqi5sV51bC1MUOw0+aw00rde7PajKiqswi00mNOx7L823Q1bi5rN
 6cuEFcWVT8jzWPKmRVUXRT/ilefit3KT6InPvx5FBOm1npIRH53iAiH7v2Is5UXUIBE3
 jn08TUh6UuWN5y2ClKg6xu3SfVn2uErnBzfMBGAKac7WSoKEiux5pi10X1I1DUm2KcWV
 0W903B6RIFB1mm5B3dJdxeUKMOyOxWga4PlOf42DuZOf+GVTcFtNTBJkq+WMrbbDViBv
 NkTG8RXaV0RiC+GHcxGuNBGGiyt0U5mQFalze+atok1tRE+uAczLJFD81Tg8nH+9XP0S
 q2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736401240; x=1737006040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DycLZB5aWMkAVY6tskCG6L4zQq4+W8964z6dAV5pUjI=;
 b=HDznqYX8mJ/jeO6+IDWmJrX87KAXec9XVsjSn/BPzY88Yr3iuw9wvId1OXPNckdBNj
 17f3t/3F2uZQtc4lqgXZHeiTSq7EmeJZJQArOm+0RhENqGqQvR3qjl3fWR3Zg4PmNKUe
 nL8YR/cEO+7fL/POtMTyyvnRFKcGs/8lmIOsMq+TN5ERjomJvEK6/H9ya6bTH/UIZyzO
 tFTYg9Iur6irhMg9xYgixJSnpa1ecs6hr0XcFN2Q+LHnZh9IZOjBgSTq2s/ELurG9qSC
 ykF6dSy1xbNkm7qr+c52eo7uAoG7R1WYRp+9a9Rrl1i6LJes9PooPX+phEqd4SMg9f+Y
 WoZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSTuIyUr/S71e2iNl7UDchkgzQTwUy9o0mjtvRRd+F1AAeokKn+Y6Ls+p5a//qKZsb8OBcVSM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6QTzDKDD3sk0tRDty6fQYAqNbAQLofwVG6IvmdEYYpNFq4MaH
 Ajc+aR3zt85HIuSG6BNfN+rm3RlYvyAKkj6fgUTDG3Wh0Fqqjyv4jzmlbkzmvCEXPB/9rITFFxf
 HBHj3lLSejO3nCpcinL7W7f/IxUFlCOvNEPok3g==
X-Gm-Gg: ASbGncvW8pVmqhaUCqNzOpwGkyRXR+1f814t0F1Q7sHUxnw8ERwUBw6guBDSrKwaLfb
 NhMZZPK4wLXSuOkegflDE7WdjTZQhKFF47+5HCpBY
X-Google-Smtp-Source: AGHT+IHtR7CffUq6R0aIp86eDbHUoFGE4Rx/4w4GUMfDvrUXaBDYEFqX5OJY4mqp/CMpUe4G/DrjQm2Hr1rJKzlt8yE=
X-Received: by 2002:a05:6102:d86:b0:4b2:af6e:5fef with SMTP id
 ada2fe7eead31-4b3d0f8f84cmr4453895137.9.1736401240444; Wed, 08 Jan 2025
 21:40:40 -0800 (PST)
MIME-Version: 1.0
References: <20250109052545.2921502-1-quic_varada@quicinc.com>
 <20250109052545.2921502-2-quic_varada@quicinc.com>
In-Reply-To: <20250109052545.2921502-2-quic_varada@quicinc.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 9 Jan 2025 11:10:29 +0530
X-Gm-Features: AbW1kvZJminROOSllEx06h2VsstnbPFgbdJ5-7f-xMAZLwkP9h5QFRL8mtroleM
Message-ID: <CAFA6WYNJ90GwpoX7ZaHHWm1gDqyjkshK5F6OMvdrfd5haYS7cA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] arm64: dts: qcom: qcs9100: Add support for the
 QCS9100 Ride and Ride Rev3 boards
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org, 
 lukma@denx.de, seanga2@gmail.com, ilias.apalodimas@linaro.org, 
 sjg@chromium.org, Volodymyr_Babchuk@epam.com, lehmanju@devpi.de, 
 bhupesh.linux@gmail.com, andersson@kernel.org, quic_tengfan@quicinc.com, 
 konradybcio@kernel.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Thu, 9 Jan 2025 at 10:56, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> From: Tengfei Fan <quic_tengfan@quicinc.com>
>
> Add device tree support for the QCS9100 Ride and Ride Rev3 boards. The
> QCS9100 is a variant of the SA8775p, and they are fully compatible with
> each other. The QCS9100 Ride/Ride Rev3 board is essentially the same as
> the SA8775p Ride/Ride Rev3 board, with the QCS9100 SoC mounted instead
> of the SA8775p.
>
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>
> Link: https://lore.kernel.org/r/20240911-add_qcs9100_support-v2-4-e43a71ceb017@quicinc.com
> Signed-off-by: Bjorn Andersson <andersson@kernel.org>
>
> [ upstream commit: 7dcc1dfaa3d1cd3aafed2beb7086ed34fdb22303 ]
>
> (cherry picked from commit db6231faa8ef46e5ff5d5ece0c930a07c6358562)
> ---
>  dts/upstream/src/arm64/qcom/qcs9100-ride-r3.dts | 11 +++++++++++
>  dts/upstream/src/arm64/qcom/qcs9100-ride.dts    | 11 +++++++++++
>  2 files changed, 22 insertions(+)
>  create mode 100644 dts/upstream/src/arm64/qcom/qcs9100-ride-r3.dts
>  create mode 100644 dts/upstream/src/arm64/qcom/qcs9100-ride.dts
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/dts/upstream/src/arm64/qcom/qcs9100-ride-r3.dts b/dts/upstream/src/arm64/qcom/qcs9100-ride-r3.dts
> new file mode 100644
> index 00000000000..759d1ec694b
> --- /dev/null
> +++ b/dts/upstream/src/arm64/qcom/qcs9100-ride-r3.dts
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +/dts-v1/;
> +
> +#include "sa8775p-ride-r3.dts"
> +/ {
> +       model = "Qualcomm QCS9100 Ride Rev3";
> +       compatible = "qcom,qcs9100-ride-r3", "qcom,qcs9100", "qcom,sa8775p";
> +};
> diff --git a/dts/upstream/src/arm64/qcom/qcs9100-ride.dts b/dts/upstream/src/arm64/qcom/qcs9100-ride.dts
> new file mode 100644
> index 00000000000..979462dfec3
> --- /dev/null
> +++ b/dts/upstream/src/arm64/qcom/qcs9100-ride.dts
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +/dts-v1/;
> +
> +#include "sa8775p-ride.dts"
> +/ {
> +       model = "Qualcomm QCS9100 Ride";
> +       compatible = "qcom,qcs9100-ride", "qcom,qcs9100", "qcom,sa8775p";
> +};
> --
> 2.34.1
>

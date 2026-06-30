Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B6BC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 16:17:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F9E384A26;
	Tue, 30 Jun 2026 18:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dGqaEOY/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C1DA84A38; Tue, 30 Jun 2026 18:17:44 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D6558498C
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 18:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-493bc8fda98so7529925e9.0
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782836262; x=1783441062; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qk522ai+LkLjT3b3Xi4YtnqXwvHjFQS6pmaD8hiwlqo=;
 b=dGqaEOY/zi/Xl5WHi65zH7pxJ5An3LQl0erlPxLehvgvX1vHoDNXqbtqrh9wdCzX5a
 lCzkh29zU3PBw7wgHfk5A5R/D19iLbqy8kwJXEMRaXFMGo2SwItQEJilW76hBWnDevaP
 3qIMeSdnNG9n5cocvlYfUbEWuozftdnI1VqqmP/4LR8Hw4S408iYnY4uTK7PacmyyK5m
 j5Ed0Yq00Pppf/kPzgnxZdTcSaRKONQluh9dh+Nj4+K5reqpyp7AWQDkuha3Of4e/h5n
 LuHSVtDbvljNCzkDz5JoQ9qkUq354lnpasZ7LMmrwR5+9IcFvhcSxFIkBRYrZtRVd4TF
 5QTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782836262; x=1783441062;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qk522ai+LkLjT3b3Xi4YtnqXwvHjFQS6pmaD8hiwlqo=;
 b=MYrYcdPVNhwCMfr8yB6usvKdDNverI+tSrc7HK3LWQdZNR6rWs0NDtiPClRlK59Blo
 wIGtUFRYXt2nIe+F/3mIJ2oUz2GgYVd8qsq0czqHLk3Mi+ZLPo5hBdmjiJlp1cS+B8UL
 Wc/4j7/GNUncmKHhvxOa55EwlfQw/JpJ9ABfgrWpX/LROsW9wVQHrDriurkadq0DlN9H
 zXJJ4Fuv22fBHAiMzZJFuRqiSU2V/lJAxSIQGF2EWux02FF1/Lr0tpdYygDIPxIEwxZ1
 Eq6F3GZisDI/ltQjn0EEvWnz7zX2t2kN+DU+1Mo4/PQJmxbJyxSBW5YI74R99TCIG0oK
 PZMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kU8+LqRnn0BX/TGisQQ4ZOcbMTAlMSmG/nAaWuq3459b16tRMv+dTSbHOdyZU0W3x6rx0UJs=@lists.denx.de
X-Gm-Message-State: AOJu0YzreyuKtRyKnpOcJt+FtAD+ASOf1YEWVPDU08IlQKIIiB2hp5zx
 w8RfaG74apwV/IRv+5DRsqqCp/yvXq+avxMG2RWfz6sJeQcxpMRx91xxSPQhdBQyl+s=
X-Gm-Gg: AfdE7cn+/BxdZoSwEzB/JEjtpVA/+/ujaF1iJW9+QTmSckdJFuQc+XglHz1zElZa24g
 q0kw8Op3CA8834F6SYsLp6I2prhv0G7psiVUFN2sVa4I8wPrsSApwf/5lgDg3jgs4Aa5SuFZzr5
 2sUrvoMxIzI8wyVgLYHsdOi6SCiJx4Hey4ixX/32Su3cp64vRATFDZKd0bl/DHZY+hIX5GVWPDW
 6IDSvjgsRV5JdJyQYOh/gZ71pbSIqeIyvfVgtrK/K0tRqxaWcK1GLrKps0zaTOQw/rKf2hfFaCH
 SIC+WFv0Syhw/qdvAZ7dvqPCWQgGekdcYCcxsg+JSpRYl9b7cb0AFWH+zF+QlS5LSPh/8kG/ywY
 NBuxz07gRkSFvh9SH8KzBUqdd2sJysAMKJleWvWove0occEDDVIw6NNY2zW99b/0umZqpkxdX1q
 NftqFzL2cSoBvgkCVffLrVNRB4eYg=
X-Received: by 2002:a05:600c:3485:b0:492:1e36:1fe9 with SMTP id
 5b1f17b1804b1-493b82c654emr58924015e9.37.1782836261489; 
 Tue, 30 Jun 2026 09:17:41 -0700 (PDT)
Received: from [172.16.185.106] ([195.76.196.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4c7f90sm6013575e9.2.2026.06.30.09.17.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 09:17:40 -0700 (PDT)
Message-ID: <1fc22177-b677-4b02-b527-48727dd0e75b@linaro.org>
Date: Tue, 30 Jun 2026 18:17:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dts: qcs6490-rubikpi3: Add U-Boot dtsi
To: Hongyang Zhao <hongyang.zhao@thundersoft.com>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Roger Shimizu <rosh@debian.org>
References: <20260624-qcs6490-rubikpi3-v2-0-829dad7e6dd6@thundersoft.com>
 <20260624-qcs6490-rubikpi3-v2-1-829dad7e6dd6@thundersoft.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260624-qcs6490-rubikpi3-v2-1-829dad7e6dd6@thundersoft.com>
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

Hiya,

Thanks for respinning this!

On 6/24/26 14:45, Hongyang Zhao wrote:
> Add the board-specific U-Boot device tree overrides for the
> Thundercomm RUBIK Pi 3.
> 
> When U-Boot is loaded as the primary bootloader, no previous stage
> provides the memory layout. Describe the 8 GiB LPDDR4x layout locally
> so U-Boot can use the available DRAM.

I'm hoping we can skip this patch, since we now support retrieving the 
memory map dynamically from SMEM. I'd appreciate it if you could do a 
clean build of the qcom-next branch here and see if it works without this.

https://source.denx.de/u-boot/custodians/u-boot-snapdragon

You also shouldn't need to use qtestsign as MBN support was also just 
picked so u-boot.mbn should be built directly.

I used the Rubik Pi for testing both series locally so crossing my 
fingers you don't run into any issues.

Thanks,
// Casey


> 
> Signed-off-by: Hongyang Zhao <hongyang.zhao@thundersoft.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>   .../arm/dts/qcs6490-thundercomm-rubikpi3-u-boot.dtsi | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/dts/qcs6490-thundercomm-rubikpi3-u-boot.dtsi b/arch/arm/dts/qcs6490-thundercomm-rubikpi3-u-boot.dtsi
> new file mode 100644
> index 00000000000..8518cd402d0
> --- /dev/null
> +++ b/arch/arm/dts/qcs6490-thundercomm-rubikpi3-u-boot.dtsi
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/ {
> +	/*
> +	 * When running as the primary bootloader there is no prior stage to
> +	 * populate the memory layout for us. We should have multiple nodes
> +	 * here, but ABL does not like that.
> +	 */
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0 0x80000000 0 0x39700000>,
> +		      <0 0xc0000000 0 0x01800000>,
> +		      <0 0xc3400000 0 0xbcc00000>,
> +		      <1 0x80000000 1 0x00000000>;
> +	};
> +};
> +
> +// RAM Entry 0 : Base 0x0080000000  Size 0x0039700000
> +// RAM Entry 1 : Base 0x00C0000000  Size 0x0001800000
> +// RAM Entry 2 : Base 0x00C3400000  Size 0x00BCC00000
> +// RAM Entry 3 : Base 0x0180000000  Size 0x0100000000
> 


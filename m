Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB30CC71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 15:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA68D82B70;
	Thu, 12 Jun 2025 17:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=minlexx.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B538682B97; Thu, 12 Jun 2025 17:49:08 +0200 (CEST)
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6EB5828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 17:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=minlexx.ru
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=alexeymin@minlexx.ru
Received: by sm24.hosting.reg.ru with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
 (envelope-from <alexeymin@minlexx.ru>) id 1uPkAq-0000000075D-2ymd;
 Thu, 12 Jun 2025 18:49:04 +0300
Message-ID: <267f957f-f74d-40f9-a65a-da00ea12810c@minlexx.ru>
Date: Thu, 12 Jun 2025 18:49:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk/qcom: sm8250: Fix variable name of msm_clk_data
To: Luca Weiss <luca.weiss@fairphone.com>, Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250611-qcom-clk-variable-names-v1-0-37615b74daad@fairphone.com>
 <20250611-qcom-clk-variable-names-v1-2-37615b74daad@fairphone.com>
Content-Language: en-US
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
In-Reply-To: <20250611-qcom-clk-variable-names-v1-2-37615b74daad@fairphone.com>
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

On 11.06.2025 15:08, Luca Weiss wrote:
> Update the variable name to sm8250_gcc_data as it's in the sc7280
> driver.

Hi!
But why are you mentioning sc7280 here, while fixing clock-sm8250.c ?

> ---
>   drivers/clk/qcom/clock-sm8250.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clock-sm8250.c b/drivers/clk/qcom/clock-sm8250.c


---
Regards,
Alexey Minnekhanov

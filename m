Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F0ED3B997
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 14:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 355B989C88;
	Tue, 26 Nov 2024 15:36:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="qRfXkLi4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DD3B89A51; Tue, 26 Nov 2024 14:53:52 +0100 (CET)
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com
 [IPv6:2001:41d0:203:375::af])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07B5D895F4
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 14:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexeymin@postmarketos.org
Message-ID: <d9f56478-ce83-41a1-aa07-9ea314ee86cc@postmarketos.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1732629229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NNuuHNvcqUXhsDk5zyJx1ReWpcPV5OW1jUw7FzPpVuY=;
 b=qRfXkLi48/SyTv2Zc++RIjHSq6uZpMnqsPCV+9mhvCxbejzjwK/85hN0tc+mUb8pPaR7GY
 aPkSUCUXj8e4TfOST3QC5Z/bAuew7U1kQzRXqTh5+vCAKWBhQYNKPYpWWTY5Sh+BjfL+cy
 0DKP5DDH1JJey+Hq1mkLDsIio6mn92KU34y54b/t15Fhx3k3cacYClIVsbTFUt5eUhRJ7L
 bYuA6KbKsCoriCSO5KqX8ZnzKMpQRQhCOT98puv3FBv4sgbiMhiXRV+xGVVRLik3KXo+wl
 XS2e6Qgb7x6/MDmikHPJmgCrY7oLwN2htYJLbUBypSo2AkOkSQ8d6u/X1sqebg==
Date: Tue, 26 Nov 2024 16:53:11 +0300
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] rng: msm: add support for newer Qualcomm hwrandom IPs
To: u-boot-qcom@groups.io, Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
References: <20241125-topic-sm8x50-rng-v1-0-52b72821c3e9@linaro.org>
 <20241125-topic-sm8x50-rng-v1-1-52b72821c3e9@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <20241125-topic-sm8x50-rng-v1-1-52b72821c3e9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Tue, 26 Nov 2024 15:36:43 +0100
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

25.11.2024 20:12, Neil Armstrong wrote:
> On recent Qualcomm SoCs, the hardware random generator
> is initialized and handled by the firmware because shared
> between different Execution Environments (EE), thus the
> initialization step should be skipped.
> 
> Also support the newer "TRNG" found on SM8550 and newer
> SoCs that has inbuilt NIST SP800 90B compliant entropic source.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/rng/msm_rng.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 

I've tried this patch on my sdm660 device (which is using
qcom,prng-ee) and it seems to work fine. I now see in Linux dmesg:

   [    0.000000] KASLR enabled

Without this patch it was:

   [    0.000000] KASLR disabled due to lack of seed

Tested-by: Alexey Minnekhanov <alexeymin@postmarketos.org>


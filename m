Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BED8C369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 00:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2FB8838FA;
	Thu, 10 Apr 2025 02:35:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="qQ4ZH01y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3C47838D7; Thu, 10 Apr 2025 01:40:48 +0200 (CEST)
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com
 [IPv6:2001:41d0:203:375::ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D604C8384E
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 01:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexeymin@postmarketos.org
Message-ID: <84ec2a78-6f9b-469f-b8a1-de44132e31bd@postmarketos.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1744242045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YLVMWVn+mSk2lSraaE81s1gd/VnnzZeaSDaBER9irtc=;
 b=qQ4ZH01yb3Foqqa5spOXMpr851yvGxk2Gohd9JPkZDs4jiwLxIhbdT6xdxT94o7/55WYd5
 PJnENPcR7exzTNfpOSc9W1Oq0L7R0Ts/uFrToFxL+tEypncWmSPeRuvG8cMFQStKuUI843
 tK9bqVRGeus/Zf1+IZ4a5XfG1qX/SnlOpwiDxFHjtB7pq+qmNWmgb93rBPU2qldN8x09XQ
 ULAGyYHDZkRuHuFDTuwjamqtOxy/QVI0J6zCgRnIePI38fjIQGSbMF+7m7n2S9+jnypolG
 8Xtlc+szTcdr418r58GqynSvQmlGEMOjm4J5XdfhbfGwJfuAk25einI/5QZTtQ==
Date: Thu, 10 Apr 2025 02:40:26 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] pinctrl: qcom: handle reserved ranges
To: u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
References: <20250401-topic-sm8x50-pinctrl-reserved-ranges-v1-1-0fe88b491707@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <20250401-topic-sm8x50-pinctrl-reserved-ranges-v1-1-0fe88b491707@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Thu, 10 Apr 2025 02:35:21 +0200
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

On 4/1/25 10:46, Neil Armstrong via groups.io wrote:
> From: Caleb Connolly <caleb.connolly@linaro.org>
> 
> Some Qualcomm boards feature reserved ranges of pins which are protected
> by firmware. Attempting to read or write any registers associated with
> these pins results the board resetting.
> 
> Add support for parsing these ranges from devicetree and ensure that the
> pinctrl and GPIO drivers don't try to interact with these pins.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   arch/arm/mach-snapdragon/include/mach/gpio.h | 15 +++++++
>   drivers/gpio/msm_gpio.c                      |  9 ++++
>   drivers/pinctrl/qcom/pinctrl-qcom.c          | 64 ++++++++++++++++++++++++++++
>   3 files changed, 88 insertions(+)

...

> +#define MSM_PINCTRL_MAX_RESERVED_RANGES 32
> +
>   struct msm_pinctrl_priv {
>   	phys_addr_t base;
>   	struct msm_pinctrl_data *data;
> +	u32 reserved_ranges[MSM_PINCTRL_MAX_RESERVED_RANGES * 2];
> +	int reserved_ranges_count;
>   };
Why storing of reserved pins isn't implemented using bitmap?

     DECLARE_BITMAP(reserved_pins, 256);

would only consume 32 bytes, instead of 256+4 like here.

Do I miss something?

---
Regards,
Alexey Minnekhanov

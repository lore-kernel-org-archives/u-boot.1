Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5069CD4F5B
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 03:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D17B88487F;
	Wed, 20 May 2026 05:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EawW9ZcE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mTRDznHU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4D05848BB; Wed, 20 May 2026 05:25:20 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 112F28487F
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 05:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gKxkP6Jcqz9w0k;
 Wed, 20 May 2026 05:25:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779247517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xlu4i1V3xrvzKE9u9OSuGrGWImoGU+ptAouypl50RNo=;
 b=EawW9ZcEUSASi2NnMqSUtcMXzg9ScDm869TQPo2XoNzqvDj1wGgbR7IenjDNZB2ni8uNgB
 HaqVVT3zOYKtL6YhefEQJhOSVUzsIZDUcaK0b6v7d1FS+1Y4ty2oLq0blqHJ0HwAQ7GR1L
 a0ZQzL3WrxQu3QB3A8gXCiNfITh4Qhz39oUgns2/k2gSbUzGwXv61oZ0jomM9MrYSUc+fV
 D2u4SqiDUFtJn+JG6SxlRK/cxIv7Rf9xl8OirS7UFp2Gm5mstTqf7pyfdEw7jfXNNJMQ+7
 14PWBeRncASMNfv/e2m5wxez54p3D227ASNFAj8hoeiRgPoJoTEhDT5hJfexQQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=mTRDznHU;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <f420eff8-6524-4797-93b7-0f9a1149e860@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779247516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xlu4i1V3xrvzKE9u9OSuGrGWImoGU+ptAouypl50RNo=;
 b=mTRDznHUKMhe0Ub+HlMXXZckdTlkqsGrCtgf0ZH2tUNueR0RK3eAFJvogKgLaEtPQ2vGT5
 ydKUCcnX2hgEtOJl5nXF4D6VIfEYGCEkgorU203xsCzjX0iY2WUoux3kp+hkefb1w6WQT8
 V9gHW3WZUHM0+MQ/TStqlyBnvljW+t7WmTn81NEZbljxnjesV3low6sygt5A97Uy5y6B0T
 pBAE5QNR8zm9BKwc8LHBWR2Pv9m4YwcVftHuZVzkPdU93MQrz24lY8rFr3irkFlRWXbnXB
 +Gl1DHNKS5mTpmipU3uVOHXIc7UXVvjHZPrgQY004/pf+SROesUt6tZ8pCAzwA==
Date: Tue, 19 May 2026 18:58:07 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/3] configs: stm32mp13: activate watchdog
To: Yann Gautier <yann.gautier@foss.st.com>, u-boot@lists.denx.de
Cc: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <20260519163145.221668-1-yann.gautier@foss.st.com>
 <20260519163145.221668-3-yann.gautier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260519163145.221668-3-yann.gautier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ho4s4k41he7f541um9o4khohi3qhn194
X-MBO-RS-ID: d5a99560888be9571eb
X-Rspamd-Queue-Id: 4gKxkP6Jcqz9w0k
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

On 5/19/26 6:31 PM, Yann Gautier wrote:
> No watchdog was enabled for STM32MP13 platform. Add the required flags to
> support it. As done for STM32MP15 (in SCMI config) and STM32MP2x, we use
> the Arm SMC watchdog. The required nodes were already present in Linux
> imported DT files (stm32mp13.dtsi & stm32mp135f-dk.dts).
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> 
> ---
> 
> Changes in v2:
> - update commit message
> 
>   configs/stm32mp13_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
> index 620a6da2efe3..cc41585097c7 100644
> --- a/configs/stm32mp13_defconfig
> +++ b/configs/stm32mp13_defconfig
> @@ -113,4 +113,7 @@ CONFIG_USB_GADGET_MANUFACTURER="STMicroelectronics"
>   CONFIG_USB_GADGET_VENDOR_NUM=0x0483
>   CONFIG_USB_GADGET_PRODUCT_NUM=0x5720
>   CONFIG_USB_GADGET_DWC2_OTG=y
> +CONFIG_WDT=y
> +CONFIG_WDT_STM32MP=y
Why is CONFIG_WDT_STM32MP enabled here , is this the ARM SMC watchdog 
driver ?

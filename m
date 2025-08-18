Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B01CA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 05:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBA0E8359F;
	Mon, 18 Aug 2025 07:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="X1pugFR+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1D7D835B2; Mon, 18 Aug 2025 07:34:45 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09D7683559
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 07:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c51cd0x2Jz9smk;
 Mon, 18 Aug 2025 07:34:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755495281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=35xQb7eQLYdTainG9C2SXll5Ty6liFIHHoz0uXUud2E=;
 b=X1pugFR+Awv3GYWKTyy9T/7uvLUpfZRwKzcF5tCq7RWwhSqF2X1ERaGrzAFCuE7q2ygJAN
 +BvCq2IV/6ayUzp5Zd4GEJPpPkGlEl0mJiaPe2TMOlqTbtAjq7SCiTsoauX+SikFeBc9MG
 FLpPj5cCoLrplfYR7SZgig7ZaKcUxwYz660YxtQv5srBhhiWHRJDc0CNsmAt7d8zViBZH0
 Dfi06c1Dj62m02hgaVuAO5X4o22xFDMtwZns+SQcpb+rLb5PUHYfwiB3M3nBlAIBqE5Udu
 OKl2aahxf4nMdieDllOaoPjii4OgrGo9t4ckCLWm0QzOMDc0n/3/VEUM777jFQ==
Message-ID: <45fc506b-2464-460b-ac72-aeecc3ed56dc@mailbox.org>
Date: Mon, 18 Aug 2025 07:34:38 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: dwc3: Add versal2 compatibility string to dwc3 glue
 ids
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20250818044815.4052070-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250818044815.4052070-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 9a6a10efcfc57f4829e
X-MBO-RS-META: zwysr6unhdjzs8nc9sfc3gfj88o61ttx
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

On 8/18/25 6:48 AM, Venkatesh Yadav Abbarapu wrote:
> Add mmi usb controller support which uses dwc3 and hence its
> compatible string needs to be added to dwc3 glue ids.
> USB3 DRD IP is usb3.1 gen2 controller which support following
> speed SSP (10-Gbps), SuperSpeed(5-Gbps), high-speed(480-Mbps),
> full-speed(12-Mbps) and low-speed(1.5-Mbps) operation modes.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/usb/dwc3/dwc3-generic.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 3cda2b74b7e..538b6efe5c7 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -692,6 +692,7 @@ int dwc3_glue_remove(struct udevice *dev)
>   static const struct udevice_id dwc3_glue_ids[] = {
>   	{ .compatible = "xlnx,zynqmp-dwc3" },
>   	{ .compatible = "xlnx,versal-dwc3" },
> +	{ .compatible = "xlnx,versal2-mmi-dwc3" },
I don't see this compatible string even in current linux-next, is there 
an upstream Linux kernel patch, DT patch, DT binding document patch ?

Why does the SoC DT not use "xlnx,zynqmp-dwc3" as fallback compatible 
instead of growing this table ?

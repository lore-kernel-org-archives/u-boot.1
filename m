Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0834C25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 09:11:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29F378801A;
	Fri, 10 May 2024 11:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J/BPXzS2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9942088294; Fri, 10 May 2024 11:11:25 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 824BF87EF5
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 11:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1C95361E75;
 Fri, 10 May 2024 09:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9D2C32781;
 Fri, 10 May 2024 09:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715332281;
 bh=MvVvo0O7kg2ytU6fKsYhbQFuOzMtod79fLU6NMcCXIo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=J/BPXzS2OH78CQYwJrjHmRiAaQdM3lYRXb1ddrFAPCR4mltHNn56mSnwGNjdT7KDS
 Bkrt7wrN4FIKlxmCb6vFmI4ffa2AD3stHOlwrBsY76A76ZHIpDftu1tfodsJBDbsyT
 dL5YknFV5Ue0YiybyWHNJjORHU1UmAzJgHrIab59iuc1hED76VKs4LvtaXcDdmr+Wx
 +JbEEQzhHfU5Zh6+7GcMIG762WQvWEOEjYTdPti/Qi1E2MEgfVAviCPWa/ZxMtLYmi
 ojjKQ3ilQNe+n2hBp1KIokigrcowfbLaSp+Ca94dGkagWHyhOwlwdmAUJ0WfKJ3Yzp
 ohS2Be6f7G8YA==
Message-ID: <98ffe161-33d0-479b-972e-92f9e8b8c2ff@kernel.org>
Date: Fri, 10 May 2024 12:11:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ti: am65-cpsw-nuss: don't touch DMA after stop
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Suman Anna <s-anna@ti.com>, Keerthy <j-keerthy@ti.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>
References: <20240508183605.955341-1-alexander.sverdlin@siemens.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240508183605.955341-1-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Alexander,

On 08/05/2024 21:36, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Contrary to doc/develop/driver-model/ethernet.rst contract, eth_ops
> .free_pkt can be called after .stop, there are several error paths in TFTP,
> for instance:

Doesn't this mean we need to fix TFTP instead of patching the Ethernet
driver? I'm sure the issue is present for all Ethernet drivers as none
of them are checking if Ethernet is stopped. Just that most of them
don't print any error message so it goes unnoticed.

> 
> eth_halt() <= tftp_handler() <= net_process_received_packet() <= eth_rx()
> ...
> am65_cpsw_free_pkt() <= eth_rx()> 
> Which results in (deliberately "tftpboot"ing non-existing file):
> 
> TFTP error: 'File not found' (1)
> Not retrying...
> am65_cpsw_nuss_port ethernet@8000000port@1: RX dma free_pkt failed -22
> 
> Avoid the error message by checking that the interface is still not stopped
> in am65_cpsw_free_pkt().
> 
> Fixes: 9d0dca1199d1 ("net: ethernet: ti: Introduce am654 gigabit eth switch subsystem driver")
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  drivers/net/ti/am65-cpsw-nuss.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
> index 65ade1afd05..646f618afcf 100644
> --- a/drivers/net/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ti/am65-cpsw-nuss.c
> @@ -523,6 +523,9 @@ static int am65_cpsw_free_pkt(struct udevice *dev, uchar *packet, int length)
>  	struct am65_cpsw_common	*common = priv->cpsw_common;
>  	int ret;
>  
> +	if (!common->started)
> +		return -ENETDOWN;
> +
>  	if (length > 0) {
>  		u32 pkt = common->rx_next % UDMA_RX_DESC_NUM;
>  

-- 
cheers,
-roger

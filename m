Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDE5C2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 06:45:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4DFC81E72;
	Mon, 19 May 2025 08:45:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1747637115;
	bh=THAwZATmxuFi4H26Mvy46Ak0aEZBpwRDvfg29JNlmBI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i7CP/g82+uhV9O88Kv7pW2kVP9pvA3anOlLOZfUfQ9uoDOmzJ7vR6GwWsbgtVEoIx
	 sIPY6T8h3oisY/GmpVNEL90H3ukFG22T2JAmnWOysS2WJP91x9UZAUCBluz/odxakN
	 MBB1IVr+oy+KSxm3lxDNuKeQxHJWf1RKR/qIwmXp57s3r+B2gORY/0FrcjQwyKLVST
	 naLeHKhFe+HKdDZ5kETlN0ILoOFrTbjGuvy70CY+GWq8wiu9LCCyp3S/lOcndgytW7
	 7sWb9tFHxD7E+h2CvzygPp3pHQ5EK9oGn29RxXglYqkhsXMx09ATebp7XD9LDk5Ilq
	 EUFiHdEG6wRxA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA7A981F66; Mon, 19 May 2025 08:45:14 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D87A9803DF
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 08:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4b17Ty4DQzz9srV;
 Mon, 19 May 2025 08:45:10 +0200 (CEST)
Message-ID: <889c50b4-cfb3-493a-8e1d-df0c40b2de08@denx.de>
Date: Mon, 19 May 2025 08:45:09 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] pci: zynqmp: Fix the pcireg base
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, trini@konsulko.com, git@amd.com
References: <20250516092314.939424-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250516092314.939424-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4b17Ty4DQzz9srV
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

On 16.05.25 11:23, Venkatesh Yadav Abbarapu wrote:
> The pcireg base is not assigned to any address, reading the
> pcireg base with PS_LINKUP_OFFSET which is incorrect and
> giving random values. So update the pcireg base from
> devicetree so that we can read the valid PCIE link status
> and PHY ready status.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/pci/pcie-xilinx-nwl.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/pcie-xilinx-nwl.c b/drivers/pci/pcie-xilinx-nwl.c
> index 7ef2bdf57b5..e03ab3be912 100644
> --- a/drivers/pci/pcie-xilinx-nwl.c
> +++ b/drivers/pci/pcie-xilinx-nwl.c
> @@ -303,6 +303,13 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie)
>   		return PTR_ERR(pcie->breg_base);
>   	pcie->phys_breg_base = res.start;
>   
> +	ret = dev_read_resource_byname(dev, "pcireg", &res);
> +	if (ret)
> +		return ret;
> +	pcie->pcireg_base = devm_ioremap(dev, res.start, resource_size(&res));
> +	if (IS_ERR(pcie->pcireg_base))
> +		return PTR_ERR(pcie->pcireg_base);
> +
>   	ret = dev_read_resource_byname(dev, "cfg", &res);
>   	if (ret)
>   		return ret;

Ah, many thanks for catching.

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan


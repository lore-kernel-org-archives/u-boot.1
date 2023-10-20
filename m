Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93ED8CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 04:17:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE41C87230;
	Fri, 20 Oct 2023 06:17:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697775431;
	bh=pneRBGSYqWh/XeAEGikWXSlW/3dMH+U/p1OfLrw8mmA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CgWR6atpDgAWh+iznBbkQPzjvnIljTrB9Ri7MzbPp0H8zTXpA76ITrwi0hvN7BoWv
	 Q0+2W2lsDMmeb9tb3GQdHJ6KRF8le7UlawO5r56FK8/IZU9KuPuELeF29qs54JtJ/4
	 T+koUVICCxeS8yqwNyGBbcyOFTomBvkRQVEcCIZi8uUYVCu1aOOIjrajIE+OGyMTuy
	 F0e/yHcenCY1TF8w2/bzPJlTPFSchh09iJsGzEurgEY8AOB1eaoiDC5Zl21xBluJ3C
	 h8cwSVnBB539JxiA3SAI5QMvn6bRn5IApLLouYF4BYrH426EZJ3D5Z78KWE1duxLlb
	 JpXV5bXtDYURQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 25D2487205;
 Fri, 20 Oct 2023 06:17:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697775431;
 bh=pneRBGSYqWh/XeAEGikWXSlW/3dMH+U/p1OfLrw8mmA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=wZ1+g8NPuJ9Et2P7/+7NQnoKMwKE8/S7zuE0HppnMdY0/RT5iihQtm+qfLBoHwkhr
 4QUjwiN40oR/S+qk5V93YlBDOIWxqCB2jBtD3uzZBH6rtKnwZEbiOXaQK2vpmzTXN+
 qluxwOq2wyiu9mgqAijhtuTjxpbXeiepU2MZUAJCHsUx+bEuXj/N6JBfksTp3lj0J+
 hfzMhAA9ROMTpY3GwszbL9C0pjknRgKKn9OlHk5BqxbaFZkVFJS780lhvo3/RqvQCR
 db4S6agIoTofl5Kt+PBOijMlPIToaQmwqgkfqlYvrCn35p1GQXhPHHemM0sGgn4ceD
 gKjgpu4FnoMtg==
Message-ID: <362db620-cec7-4655-83fb-ab788636e6b2@denx.de>
Date: Fri, 20 Oct 2023 06:17:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clock_imx8mm: Add a stub for imx8mp_fec_interface_init()
To: Fabio Estevam <festevam@gmail.com>, sbabic@denx.de
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
References: <20231020004735.1913081-1-festevam@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231020004735.1913081-1-festevam@gmail.com>
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

On 10/20/23 02:47, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> When CONFIG_DWC_ETH_QOS_IMX=y and CONFIG_FEC_MXC is not selected, the
> following warning is seen:
> 
> arch/arm/mach-imx/imx8m/clock_imx8mm.c: In function 'board_interface_eth_init':
> arch/arm/mach-imx/imx8m/clock_imx8mm.c:914:24: warning: implicit declaration of function 'imx8mp_fec_interface_init; did you mean 'imx8mp_eqos_interface_init'? [-Wimplicit-function-declaration]
> 
> Fix it by adding a stub for imx8mp_fec_interface_init() to handle this
> case.
> 
> This follows the same approach done on imx8mp_eqos_interface_init().
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Marek Vasut <marex@denx.de>

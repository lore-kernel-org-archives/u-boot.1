Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18610E95A8E
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 13:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57D29864D4;
	Mon,  9 Oct 2023 15:18:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696857482;
	bh=Z/YiIVx46pj6w95rCGEg24JRE4PJ0nd8KCtZMr8VC3A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QeBIPKVJCAOFpLm5J01FoCB+XSjqWsJKwi3Myw06Q+zsAvTdwOwaDMb5MhlrxA/i0
	 sYGsdM1HyAqahlJtuBiYEe2IpNsWs3TBDPhdZhltUwc+daMa4Iz3k+pB9/BcHUp+ZQ
	 RcOx3I69T5WDxi0i/jZx8Rhb0FX1LfoW2GmyFYlwRYxRfBOraG9nH8LmzQQ+3mC1uH
	 67Jzl8qtrC+tUdsZBaLClDdsgF3NlXhZ5H+eZ10/Tvwoa3QZUgTRrC+OopFvqE+hsQ
	 eAiD1biprTqBVRp2/CQOhMNcw9xGSJsCuhzhmMZ7c3fQP8RpiI4i+cmo0w4nMxeWMk
	 baRYg6CYtLtGA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DBF2986A02;
 Mon,  9 Oct 2023 15:17:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1696857480;
 bh=Z/YiIVx46pj6w95rCGEg24JRE4PJ0nd8KCtZMr8VC3A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qAPWvQUawlTW2a1DWZR6QXVKC+4LOT6DiHcQulhlM/GPGzn6ebqW7X0+4WdaOqKLo
 IKtoOoUtu7jHUBHiqLDs05RVs6ukH2Zb4uNE+pgwXnQuC/L6nfLZFAa5qDt1IUURwo
 2Ea0N28ff0vzHTmXU79XqEjsEvGuiFB2OB/G2y6gqIv5jJKHWRsYMMw0gKQFc3+OTZ
 NxJKr6eQaHjPMV4W4e/GXXa+L/r4MBYEpG2W4b5R4kWmQZ8orSEb4B4b8VKcm5Cf7X
 PG26nMNyuQec7lAdP8XNZR8o/oNrCL2hyEGWAxdjw0cJmNVG0NtWGu64fZMNMMfc65
 PG5/eo6z6OspA==
Message-ID: <d7dc380a-ad8f-4337-ac63-8b1d70c9a085@denx.de>
Date: Mon, 9 Oct 2023 15:17:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] mx28evk: Add USB Mass Storage support
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
References: <20231009131536.3475878-1-festevam@gmail.com>
 <20231009131536.3475878-3-festevam@gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231009131536.3475878-3-festevam@gmail.com>
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

On 10/9/23 15:15, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Select the USB options to allow running "ums 0 mmc 0".
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !

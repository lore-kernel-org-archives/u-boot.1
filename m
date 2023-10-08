Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E36E95A86
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 01:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8FDA86B89;
	Sun,  8 Oct 2023 03:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696728534;
	bh=1zRpeHZw2SSs43/1x1prMfNW3SESGqFHywWz9nwSLHc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iNPHifcAg4fIwqVkBGKI77L8bcTxSy0Unm9GjQ2Z/cbwKZoIr4k1F9mNZzaXGV55v
	 oxbqChB1b9Q7kAGxIrrSM9WqVYwh7+jza3Uj3HiCcpqY7uE1XVAOLENTsRTyS2MxBB
	 Y3GyLIU8w6JXdZSZnMRhkVw/o4a6mSb+LOlkKjiH09wBdLCujdM2AXbY+vSqAeOiIP
	 q+O+e/P2+WAFBjUSwMnKtp20RuYQL9f2fCg53AaNCVFV8+segMvsDCdF7lEarICPsz
	 03e+JW3XN81cvCUxNilDLtLdkfBn73OyUMvMv1s6h+MYeGCJPZ2Kxj6qCNkneK9MsM
	 n9s2LrtIPWAgQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A167B8669F;
 Sun,  8 Oct 2023 03:28:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1696728528;
 bh=1zRpeHZw2SSs43/1x1prMfNW3SESGqFHywWz9nwSLHc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XeujK0wBX2qfR4zUkrsoamKQvZcM/HP1hSKYC7TE44cBOHLc5yQDy6TVdlI4iLh+P
 lY7fWVhg9llPpswDB3TcrVlCUtOyIn8d07uFD31/rovB25GQxl7fErpokMtUz8cauL
 wgTP34IlfNZft8d43S9iWCLpWMMctQ2MDGsu7P+RUSZRnrAk5ybZIfDObgdt3sVVZw
 +9GDDI3Zxy7Ezq1tQxyi7xPpqLPpBlwKWthtVtKKBUwMrRzrkhGQZzskhhZl5YOvk2
 ZkUmZeFvjXGyWnkO5/YaAJlOBwSEUGy/blYqqs5joOX9jflWh0hjHkcgPl6uO8CyY0
 ZA2+6owma5bxg==
Message-ID: <bd354e6c-b86a-4d0e-b6ae-88b3273a9232@denx.de>
Date: Sun, 8 Oct 2023 03:28:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] usb: ehci: mxs: Fix the USB node pointer retrieval
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
References: <20231007215648.3156877-1-festevam@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231007215648.3156877-1-festevam@gmail.com>
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

On 10/7/23 23:56, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Use dev_ofnode() to retrieve the USB node pointer from the udevice
> structure.
> 
> This fixes the following build error:
> 
> drivers/usb/host/ehci-mxs.c:143:38: error: 'struct udevice' has no member named 'node_'

How come this was never trapped by CI ?

Reviewed-by: Marek Vasut <marex@denx.de>

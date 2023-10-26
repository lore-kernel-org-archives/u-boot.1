Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAE9C25B6B
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 01:44:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F52087B7D;
	Fri, 27 Oct 2023 03:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698371066;
	bh=vgbPn8zZTUV0Y4bxaQ8cqJFa/VnJ5YtPu+30XRKF/gw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qb7Vpy2r4YMyXwMTz/dImrjIl4Ur6IRhKonTWMG/kXS+UYyU5ILO/k/cN3azPRIWK
	 reFhVHSZh37GxlPm42VBcAFVGjMdEs8pKCcs3NfD9h6uq2f4fDpoHeY7HP5aK4TbBD
	 QIfpaxdYlvkqb8MpKyMZA2HGzVnt2lYnp8PCq/gKWWeBGwx2s6hicGDHTIapBfoEUp
	 j8siGa7ISWN50bcLOk91tH68jUfbEt15bRYDuiyj7GrhwWjSV84h3RMXcBGpmna7w7
	 KuTA9DZUPrDBEXGISah7KqjsNvXdK9slI32W9twBIDtKCwRyVp/oIwBUVwxqNk34Rg
	 UPX76y5yDwLQA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 95DBC87B7D;
 Fri, 27 Oct 2023 03:44:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698371055;
 bh=vgbPn8zZTUV0Y4bxaQ8cqJFa/VnJ5YtPu+30XRKF/gw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=T29E3MVnq1q5CnHD3mz5pGauZ7Euu8RPwJxjzvtWwQI4pEI6cbIyoForkPWIJE9B2
 R8yRts3ArmHR3ouDByJt/TQFd0Rh8BfnAEV7U9mRSjV55D8uT/hSyGnO8PeoHocLWp
 TpT6FzlQ4cNhhDpsBNnXgrunFCq1Knx26wQXLc9GXDPmZsEtOofukOz+u/dW1u1D8e
 yID4e5ZqJJ/TMG3i8pD2LLWff6dBDVa+IkHdFUMDjpluiEwNnFvo7DZbgGvBmy4MEh
 4EuTGoKjQUrsf6lyDJPJQ1826cjjPqzCb+6v1BF+GWhd0oYtGXnNX2DMRyI0QmWy86
 QshtsBSPAm0Xg==
Message-ID: <917ce30e-d737-4881-92ec-4da29e1cb8ad@denx.de>
Date: Thu, 26 Oct 2023 08:40:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm: rmobile: rzg2_beacon: Auto select Linux device
 tree by SoC
Content-Language: en-US
To: Adam Ford <aford173@gmail.com>, u-boot@lists.denx.de
Cc: aford@beaconembedded.com
References: <20231025231311.8701-1-aford173@gmail.com>
 <20231025231311.8701-3-aford173@gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231025231311.8701-3-aford173@gmail.com>
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

On 10/26/23 01:13, Adam Ford wrote:
> There is a function inside the board file to autodetect which device
> tree is needed by U-Boot to properly load its own device tree, but
> it currently defaults to always loading RZ/G2M for Linux.  This is
> not correct for other SoC variants.  Add board_late_init function
> to query the SoC name and use that to determine which device tree
> is loaded for booting Linux.

Can't this be scripted in environment instead ?

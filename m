Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA91D132B5
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 12:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49E3288D90;
	Mon,  4 Nov 2024 13:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730723446;
	bh=MgofukrL/BeO2PYkFhnDNPWgmpOEsALcchVDJWMu/EA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k0NJhvVfh6H2SHeqWUTLH4p58i0QP0lRlQ8gLK1uQtEzrpGN73i3hqxqUznj4TAav
	 JaTb/DSKujXHL/ii6iQ4ZZYruF5f7u1CkprN4jfGgyUsDSSvkvqB0ciKxGkXyiQn56
	 j0Bd6VXzSdGcoChOqCEhWxUUN2EUyQWBBQeX0G8ui5bPcBaaXmbu5j+lNlBAg/MnLO
	 v2+qUtaOtHNm3hKxBu4dj0l7y3+D4NsY9QcOVl88s186ieNRQTmsbrU0vdaVNTePXx
	 SZS2Du/pRLo9YEatBFcUntS8MLfN3f3nPvn0Bk9EBgecqVo1mvNkGTha2foWL70o/r
	 W6sNzm3um5mQw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0410788E6E;
 Mon,  4 Nov 2024 13:30:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730723445;
 bh=MgofukrL/BeO2PYkFhnDNPWgmpOEsALcchVDJWMu/EA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MmFu48IwinCXS3tZpX9iSv0VX0SZ/VG9bdAfzeBYKnXx7bS0a2uM20hMTiT4uFgJM
 FWAlzdFJmUjd9By/dIZ12Sg4LQ0B/ONbtWCI3TUjtMr8TvjtMjFKkevD7HV8hOX3lf
 IwyW9zZWIQAJrGwPI4++jr2F8BuSUMmRFP7XFsWKDI7WURaLvPY8El2O1x2lw8jNsi
 3md1ZTo5KPNzNX5uzhLJ3ai8ZfLZ/8gdOWOQCnsra8FyAZMQ8gF5L3wphNS38QgiPf
 Jz6ab6cdaF253wxEXcdsC867FBuMV32RfwDj7uhoOXsMwfsnC4bLl8K8DeSs4kls5o
 K3ApFxJTIK5OA==
Message-ID: <77ef2f17-66b7-4f5c-ab99-4b15f5c1a84d@denx.de>
Date: Mon, 4 Nov 2024 13:30:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/17] (no cover subject)
To: Peng Fan <peng.fan@nxp.com>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Viorel Suman <viorel.suman@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Ye Li <ye.li@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
 Teo Hall <teo.hall@nxp.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
 <ee6519d5-30cc-485c-b87e-89665066a827@denx.de>
 <PAXPR04MB8459B83D68F7365C5C0B5C2A88512@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB8459B83D68F7365C5C0B5C2A88512@PAXPR04MB8459.eurprd04.prod.outlook.com>
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

On 11/4/24 1:20 PM, Peng Fan wrote:
>> Subject: Re: [PATCH 00/17] (no cover subject)
>>
>> On 10/16/24 9:17 AM, Alice Guo wrote:
>>> This patch set adds the basic support of i.MX95 and has been tested
>> on
>>> i.MX95 19x19 EVK.
>> I have a somewhat more generic question -- can we start U-Boot SPL
>> and U-Boot first, and start the ELE/OpTee/... whatever firmwares AFTER
>> U-Boot has started, so they can be updated just like the kernel can be
>> updated ?
> 
> ELE Firmware packed in flash.bin is used by ROM, out of control of
> SPL/U-Boot.

Used by ROM how ? Details please ?

> OP-Tee is optional, but if it is there, it could only be loaded by SPL and
> kicked by ATF
Why ? U-Boot running in EL3 can start OpTee OS, so what is the problem ?

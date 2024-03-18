Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6971C54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 22:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 778AF88046;
	Mon, 18 Mar 2024 23:37:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710801478;
	bh=tVX9A+ihDq2eeIE/THjfvgBMqXE+VgRjWRpLGhZ9u1Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eTBR1CedhFyEDPB/y7qGM6WBGHYYAmg8CJMGlel13cKYMuPDnyLwr6z8RshGg4u4e
	 alPnGNfwr9+slj/yymlohjR9KlhPhPP6AW8Hn7DbQDWmdrJkFMzTihLR2fkAxRfc5X
	 NwImx09uo8jtatPyyILXeUbBwdfjCb9K4X/Vesd21TI88OWP/MRcNxzopDnu0ZL2fN
	 zQEg3PZ0bHkxzbaBjMdQ2II6XLm8cy8DF3pqxj/Ary+yrQrhcGasMJpr3MGjHAVzc7
	 wAOzLYjys/okY1kI0nVnRixMti662df+TKI1T2kMC536xpasAHgmBy6xDunq7ETWmi
	 8n2ci2JKa4dxA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AB4608802D;
 Mon, 18 Mar 2024 23:37:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710801475;
 bh=tVX9A+ihDq2eeIE/THjfvgBMqXE+VgRjWRpLGhZ9u1Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Y9H0fE+/+oD6w2y/miPpX+hwi36m94kLIk0IsZ60s7+wjWnHCc3ux6iAptXRFda1e
 FcGWuSHsma1If3oxcTZnRJDHmzPCZ0HywoW8iXQ8ULr9DstIBhy878b7UMX2omB8eP
 E4yEDI4ABdL7OXN6/8A8fV7blGuu7o5CljZ2qm2nJScCZtBaCfRtLyTnjP3SpRFciQ
 VvIUh0t1mpd8ZG6lZc3gcEtfshn22xdObN3+UL1W9B7gvz5ghZKE0aupCrY8/1N0CD
 +WmX94HK1lPclv2wTCDu8jp2TfvFeR2NWAwEzODE4GnvXRgv2Aw2mtYG/JJDJ5Vi51
 HSBOvWoNJ6ONg==
Message-ID: <2b075ffe-526a-4d44-a407-ed540124b5ec@denx.de>
Date: Mon, 18 Mar 2024 22:48:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] configs: imx93-phyboard-segin: Add fastboot support.
Content-Language: en-US
To: Mathieu Othacehe <othacehe@gnu.org>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Shiji Yang <yangshiji66@outlook.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Stefano Babic <sbabic@denx.de>,
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Yannic Moog <y.moog@phytec.de>,
 Primoz Fiser <primoz.fiser@norik.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de
References: <20240318171637.12664-1-othacehe@gnu.org>
 <20240318171637.12664-4-othacehe@gnu.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240318171637.12664-4-othacehe@gnu.org>
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

On 3/18/24 6:16 PM, Mathieu Othacehe wrote:
> Enable the `fastboot` command.
> 
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

Reviewed-by: Marek Vasut <marex@denx.de>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3F5C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 18:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF91180F6B;
	Tue, 15 Apr 2025 20:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="kyGn54lj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22C2681F54; Tue, 15 Apr 2025 20:14:06 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A89F8809A5
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 20:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f7e1=XC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744740842;
 bh=BVR35a5dt+Gzhdh8WDESdLnLSZQj2IjFIoFBIjxDGOM=;
 b=kyGn54ljCvBwxrqXOzvemFKzDDecdPzUZxQs/aIdDeWT31bnhu/EavKVkaYWh6eujaZDJtK31
 W53/N3tFZcofop4TE1HhU4KEaup/LowGj+Ui6pJNqhoGeiBoC9LVsOHCsb7QrUTReeX3KVYByyK
 YUNzq9z7ZSsd1Ax2S7rcAOpsMUTWM2MlaSM2U30G2N1ADda4vcyGZXPFmZBNFVJnBZMSvDbBABq
 EfxemFjzmZvZDDOqluIWC+w94+vkOYJhmLwt0PqPbVbyG9buLfSU7Cy0rad8cze90XlE0+Qx8mW
 axN6xRXf5lJUygj+XJQdw4Ka6O89GNq73kgRaWTi45bg==
X-Forward-Email-ID: 67fea1e0f405d8e4e042fa86
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <794c3f69-fd66-417d-82ab-16ac0c2ec7ec@kwiboo.se>
Date: Tue, 15 Apr 2025 20:13:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] net: dwc_eth_qos_rockchip: Add support for RK3576
To: Heiko Stuebner <heiko@sntech.de>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, quentin.schulz@cherry.de,
 detlev.casanova@collabora.com, u-boot@lists.denx.de,
 sebastian.reichel@collabora.com
References: <20250414200111.1357867-1-heiko@sntech.de>
 <20250414200111.1357867-13-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250414200111.1357867-13-heiko@sntech.de>
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

On 2025-04-14 22:01, Heiko Stuebner wrote:
> Add rk_gmac_ops and other special handling that is needed for GMAC to
> work on RK3576.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Ethernet works on my boards, using normal dhcp cmd, and also wget + dns
using NET_LWIP=y.

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> ---
>  drivers/net/dwc_eth_qos.c          |   4 +
>  drivers/net/dwc_eth_qos_rockchip.c | 154 ++++++++++++++++++++++++++++-
>  2 files changed, 157 insertions(+), 1 deletion(-)

[snip]

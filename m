Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73786C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 17:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0207F82B1C;
	Tue, 15 Apr 2025 19:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="CRPQMgAI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66DC982B07; Tue, 15 Apr 2025 19:49:54 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF07A82B07
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 19:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f7e1=XC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744739390;
 bh=1jgx29nh3iotEjBq1ZMYr7ySRkXCrk4wAj1wq1jdP9s=;
 b=CRPQMgAIMDET++6RTpeizw/O/Ibk12xOSgAUXl75031XGEIgW4F3qRu9wi6SLv00vuayoiNBB
 gEFSKXMjIlXM/9ZoeqC531bOgcBl38RXNA/XYJN7FUOYCN0w9K1AsBLKvpIguQb9s9E9GApnfB7
 ImQarLIWyF+DF2ijh+i5kOlSQ3d8cHyAjZGXd85DNklVSeAWFddwm+9wR6NrGKf8B5UH7Ns5gHp
 5qaNbBLXZ+jX7QnvBkUq/jF7+ypd34dOFeOWzB94Pk7nS4FvqP5brm3zMckR7oGzVyr3aTnOY65
 UfkeTb1nwp7z0iRbt3aeC63snxCnU9ovTSLwnM6PQ6yA==
X-Forward-Email-ID: 67fe9c39999e81140c54a9c8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <10f73fc4-a66b-4628-9f51-fd69e7225e7e@kwiboo.se>
Date: Tue, 15 Apr 2025 19:49:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/16] ram: rockchip: Add rk3576 ddr driver support
To: Heiko Stuebner <heiko@sntech.de>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, quentin.schulz@cherry.de,
 detlev.casanova@collabora.com, u-boot@lists.denx.de,
 sebastian.reichel@collabora.com
References: <20250414200111.1357867-1-heiko@sntech.de>
 <20250414200111.1357867-9-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250414200111.1357867-9-heiko@sntech.de>
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
> Add ddr driver for rk3576 to get the ram capacity.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Correct DRAM amount is reported on my boards.

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> ---
>  drivers/ram/rockchip/Makefile       |  1 +
>  drivers/ram/rockchip/sdram_rk3576.c | 35 +++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 drivers/ram/rockchip/sdram_rk3576.c

[snip]

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85160C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 18:08:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E264380944;
	Tue, 15 Apr 2025 20:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ONZ9s8Pz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D340C82A27; Tue, 15 Apr 2025 20:08:51 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82802807B1
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 20:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f7e1=XC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744740528;
 bh=+i2f8wqiVed6lQgIm/asZxPLOkThjuVHhSFKZr1zMhk=;
 b=ONZ9s8Pz0EnTqL8BJDRRhpITX/JKtmji2o2d5KsflgR8JqN07g9P60k7xWR4NX5TwXe6k1Ypc
 MjOCQMjHDfibKdwB7J4I7dPHrrA/wxgQMdLfgfhhqzgc3t0nUfC/p/tqi+GMkth8whXXRDLVRem
 m34DyRBvXvL9bCWtHATd7acIkiwOQHpQf3u3Sadf8tJbLtADhHISYLq23tzhHJVyB9ExgXbaCSV
 z0B2zL4cwqjxrgnGbclWfkgOLfcv/2I7VYgKlRHBhfRNdsJvB6FUIpe8NIiJqwsUFmDYWZw7l0f
 Y9Dt+CdgeH+JejXYXoY5vtTVtP6VeUyA+cKHb7NCPUjQ==
X-Forward-Email-ID: 67fea0aaf405d8e4e042f8e9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <aa4e1e39-0528-4c9e-8ab0-1d998d4b8a93@kwiboo.se>
Date: Tue, 15 Apr 2025 20:08:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] mmc: rockchip_dw_mmc: Add support for rk3576
To: Heiko Stuebner <heiko@sntech.de>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, quentin.schulz@cherry.de,
 detlev.casanova@collabora.com, u-boot@lists.denx.de,
 sebastian.reichel@collabora.com
References: <20250414200111.1357867-1-heiko@sntech.de>
 <20250414200111.1357867-12-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250414200111.1357867-12-heiko@sntech.de>
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
> The rk3576 uses a different base-compatible, as starting with this
> generation, the clock phase tuning is done via registers inside
> the mmc controller and not from inside the CRU.
> 
> In U-Boot we do not tune at all, so no other code changes are
> necessary.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Reading and writing data from/to SD-card work on my boards.

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> ---
>  drivers/mmc/rockchip_dw_mmc.c | 1 +
>  1 file changed, 1 insertion(+)

[snip]

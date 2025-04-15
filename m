Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B33C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 17:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18C3482B07;
	Tue, 15 Apr 2025 19:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="BDbrxTp7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D48E082B1C; Tue, 15 Apr 2025 19:57:07 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 854D2826AD
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 19:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f7e1=XC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744739824;
 bh=Z9/c1xxByaNxFqIb9PRe3SsCK6E4c6oEz69HqSfhfV8=;
 b=BDbrxTp7myGzaKYKN06/O7U2nvzeq9nilJSQjH5XcM+qJqBVF53WG5+oKxSzj0+5+N4lp2a3t
 Z0VYyXoa/zifdqT8ocJBiTkVzyIooML0Yt+Aw/zt1iwGkAhaQNVC6tfz1s51Oy0UO+lwv1Ej4US
 rEEw7vxzepZkh/AR0QCWYJ4A6JTSYQq9AL/twe4oMxc0g36T1pzrYjvxKdnOPTPwpa6xBtGfsqz
 XdjSI2aqhwDC9b1IoTMaeNHf5WiojaszojWZ11l1Im6aaglftfcA/mLm5jk9JMy2hd73Si20mgg
 cQb7XPzEBb9ltQimjAJRw/BmEnvihDlwKdwrxQJfbxng==
X-Forward-Email-ID: 67fe9dec999e81140c54acc7
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c2cb076a-2154-47d3-a7da-989182822783@kwiboo.se>
Date: Tue, 15 Apr 2025 19:56:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] rockchip: otp: Add support for RK3576
To: Heiko Stuebner <heiko@sntech.de>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, quentin.schulz@cherry.de,
 detlev.casanova@collabora.com, u-boot@lists.denx.de,
 sebastian.reichel@collabora.com
References: <20250414200111.1357867-1-heiko@sntech.de>
 <20250414200111.1357867-10-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250414200111.1357867-10-heiko@sntech.de>
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
> Add support for RK3576 compatible.
> The RK3576 OTP uses the same read mechanism as the RK3588, just
> with different values for offset and size.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

I can read correct data from OTP on my boards.

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> ---
>  drivers/misc/rockchip-otp.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

[snip]


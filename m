Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5D8C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 17:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1488C82102;
	Tue, 15 Apr 2025 19:40:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="YMEjgJVT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B279982A27; Tue, 15 Apr 2025 19:40:10 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C57281E14
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 19:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f7e1=XC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744738807;
 bh=nZSID/Jfffl6+n12FXwxYEOXE8HogSwqNt96tPrHpCg=;
 b=YMEjgJVT6opRvIS5eBJmlmBxjFAc6inuUqkO7Ivn6O+5IEefXShwSk66nCECiGWDDpO9CLAOE
 fHcTs0juVSTk2lD2Ao3ahtI7ZDqrCDytzS/HXCy3wsYMS56SAhYia5fZKkfQ90sX8e1/zsq3x3S
 TcAR6T9gFeYj716b/6PDyHki7DCs0iKsydBQWhY9DSqA/AHZrPlmjECKHT9KgMZSvBGSh2Xj2i5
 I1iVG4amafCJ64Egqk9cuBcvM/ao4oD/hJ0WPN8WsMy6WCkSsoTueCRAvrYIqlsZxNFMnYrMUxA
 xeewJfuE4A6kg0TMkr4WGNyfDbMfNjzaT/2Rr7Ccg+kw==
X-Forward-Email-ID: 67fe99f3999e81140c54a5b9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <2e74c3ef-b54a-4648-9371-882648c2ad44@kwiboo.se>
Date: Tue, 15 Apr 2025 19:39:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] rockchip: mkimage: Add rk3576 support
To: Heiko Stuebner <heiko@sntech.de>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, quentin.schulz@cherry.de,
 detlev.casanova@collabora.com, u-boot@lists.denx.de,
 sebastian.reichel@collabora.com, Xuhui Lin <xuhui.lin@rock-chips.com>
References: <20250414200111.1357867-1-heiko@sntech.de>
 <20250414200111.1357867-3-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250414200111.1357867-3-heiko@sntech.de>
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

On 2025-04-14 22:00, Heiko Stuebner wrote:
> From: Xuhui Lin <xuhui.lin@rock-chips.com>
> 
> Add support for rk3576 package header in mkimage tool.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  tools/rkcommon.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> index f158d156228..a0caa029cc0 100644
> --- a/tools/rkcommon.c
> +++ b/tools/rkcommon.c
> @@ -136,6 +136,7 @@ static struct spl_info spl_infos[] = {
>  	{ "rv1126", "110B", 0x10000 - 0x1000, false, RK_HEADER_V1 },
>  	{ "rk3528", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
>  	{ "rk3568", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
> +	{ "rk3576", "RK35", 0x80000 - 0x1000, false, RK_HEADER_V2 },

Works and matches size of SYS_SRAM (512kB) in datasheet.

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

>  	{ "rk3588", "RK35", 0x100000 - 0x1000, false, RK_HEADER_V2 },
>  };
>  


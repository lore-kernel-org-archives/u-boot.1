Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD1EC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 18:07:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86BA280944;
	Tue, 15 Apr 2025 20:07:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Z0OZ1WO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D37C81F7E; Tue, 15 Apr 2025 20:07:34 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA517807B1
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 20:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f7e1=XC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744740450;
 bh=w2xgIN/ZTKy4js6ljPNiPHuMa+x5GmqKoShKj54XGWk=;
 b=Z0OZ1WO5ZJFw0v0oU+C07tZt2HUM6FL3wFGBdog8+tSNIxe9GuOA2Bkl+vneZYu/uomt6bo7R
 EcOZprL/lKiMsiwtTSyRnintiRdFhIZFyhrVfAeI2nD2nA5xbrZ37thQZgdxVx5RmRA1Aq8YKhj
 FjpqaUxkwA8xeeOvzFEYxJwu/t+7lsLr7nTG/rJ35PEPvrg6powz+otUk7C4OZkZ8q3q9yZfo0b
 6ihbjkyIpV57BZMxjovGFjcgx7WAfl45QRJu2pIS0934onr5+B0O9NPcv7q40eYsgOaCf7qJ2zf
 1cU9PaXfGNFhP40EftMHgVkUzjmtszR/0aK3yOU/0SWQ==
X-Forward-Email-ID: 67fea058f405d8e4e042f833
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <e0399d22-3f06-4c68-b418-83d377d36cbc@kwiboo.se>
Date: Tue, 15 Apr 2025 20:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/16] mmc: rockchip_sdhci: Add support for RK3576
To: Heiko Stuebner <heiko@sntech.de>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, quentin.schulz@cherry.de,
 detlev.casanova@collabora.com, u-boot@lists.denx.de,
 sebastian.reichel@collabora.com
References: <20250414200111.1357867-1-heiko@sntech.de>
 <20250414200111.1357867-11-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250414200111.1357867-11-heiko@sntech.de>
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
> Add support for RK3576 to the rockchip sdhci driver.
> 
> It's pretty similar to its cousins found in the RK3568 and RK3588 and the
> specific hs400-tx-tap number was taken from the vendor-u-boot.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

HS200 mode work by default on my boards.

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> ---
>  drivers/mmc/rockchip_sdhci.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

[snip]

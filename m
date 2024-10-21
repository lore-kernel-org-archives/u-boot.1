Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9724D3C933
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 04:15:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F1C888549;
	Mon, 21 Oct 2024 06:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729484118;
	bh=/NJnt0xIhfpRiqwtrFjZCTwLgRQ0v5a/B+15uCV7oJI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=VAdJxhDzlj6BFvaC0QgEvoqkFXSf5XHvtxQo9pvL7cjvVswYxnHQQOD7VNvNZbl3B
	 /ew4yT6faXa5FarF09+sjVSJmg3/wsKqvejjAMvDI0Yom+hHj2zfivArm9T8xLDR/M
	 hv3LRG9kTCCUpWYuV+505eUnfdMNXrq0y6Xc020bu54ayq6opaS0Mp0ZBgUSeZg76e
	 uS3ykFpgIvzDfr6vDTrUXy87qfWQSztJdppX1CfA94fuEhrAZGnOHQcLD+p06Rb5lJ
	 sgWPalFT76xrMAaSF2fb6TwT6IVNaikHDe2QsQKq1apYOS7gHQ42UYFYpCdXgDwa7c
	 Y/3rTxHlXl2qQ==
Received: from [192.168.1.107] (82-131-200-27.pool.digikabel.hu
 [82.131.200.27])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B02D7881FD;
 Mon, 21 Oct 2024 06:15:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729484116;
 bh=/NJnt0xIhfpRiqwtrFjZCTwLgRQ0v5a/B+15uCV7oJI=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=IcFMs4bZFo1kPgly4GviHV5sSNlEuiHlL793WyAzJhjQQ9olL2KL1BuG+34D3tx0O
 zrHM8xKfIbdODBr7NPjoKa6tqxqEbtk91W7I6JGcqQJdhD68BVA60CqVdlA6MDAqQZ
 zMTIQuQSHqF1oZ836wK4pTkTacncOThYOZIF9CvJ9+SxwtZCoa+/qo1oL3TtBy7wPR
 XWn8YzdZSGq4kp7Eax3qG3PYArWhd29Ott9pKxLQJTwx2xPDJlnl9WnI7yznYQK6qH
 1S8gsdmCo45IBXDwmgbW65jXj5TYdt5hpqGC/oBTfoodKzfYTkbHoPYsVEBV1b/wEi
 hE14S/W1IuSNA==
Message-ID: <476dd140-d157-5e22-3a70-d06c079e32c7@denx.de>
Date: Mon, 21 Oct 2024 06:13:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: i2c-gpio: add support for i2c-gpio,sda-output-only
Content-Language: en-US
To: Alex Shumsky <alexthreed@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20241015202931.15270-1-alexthreed@gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20241015202931.15270-1-alexthreed@gmail.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Alex,

On 15.10.24 22:29, Alex Shumsky wrote:
> Some I2C slave devices are read-only and don't even answer with NACK.
> For example FD65x segment LED controllers.
> Make them usable with i2c-gpio,sda-output-only that are already supported
> by Linux 6.3+.
> 
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> ---
> 
>   doc/device-tree-bindings/i2c/i2c-gpio.txt |  2 ++
>   drivers/i2c/i2c-gpio.c                    | 10 ++++++++--
>   2 files changed, 10 insertions(+), 2 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

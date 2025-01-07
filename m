Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7E8E77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 12:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF5B18007D;
	Tue,  7 Jan 2025 13:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736253787;
	bh=M0Cmt65MNuagIMUXtYERbJ0BagbTXdMU5D1FU2DvA4E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vXyafo7ySXotcgzmnjzHg2bCBNo+ycHXaCuWkmEeh7JU4L7ZMabrIasrTBsYp4feZ
	 tLt9QywOElj6GeqgMDWS7ZxtcVUht8+5aIXD3gv+zq8D1rLzmS1SnJV0xjtY76Q0yk
	 ayMgZODVhVe90qBXXMuiOG6gGhoVTdU0R+bQ4aIDCdbXvS5coG4IvDTNGduemitaQ1
	 kHZiYLsXdpjct8ZsLGHdarb2FzvsAnOXCTzqmfr0QEdpjjk62i6O39TKvRBKnf+6ve
	 ch9Kvrxbk2M+ie5KfGa4ZppfEIdQdTPWT4Vd7M2EGhEJOZuTmjsFwvPhjQE2KFR72i
	 ZYxcCS7a5Uibw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1E268036D; Tue,  7 Jan 2025 13:43:05 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4F3780079
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 13:43:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4YS9gl650vz9tBr;
 Tue,  7 Jan 2025 13:42:59 +0100 (CET)
Message-ID: <3899adc0-c009-4375-bde2-929e4344ede8@denx.de>
Date: Tue, 7 Jan 2025 13:42:58 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] watchdog: rti: drop hack manipulating WDT clock rate
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>, u-boot@lists.denx.de
Cc: Jan Kiszka <jan.kiszka@siemens.com>
References: <20241121080326.1913067-1-alexander.sverdlin@siemens.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241121080326.1913067-1-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4YS9gl650vz9tBr
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

On 21.11.24 09:03, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> The hack itself seems to be copied from Linux rti_wdt.c, but the WDT reset
> principle is different in U-Boot. While Linux relies on correct frequencies
> and timers and doesn't check the actual WDT counter value U-Boot driver
> seems to be more robust: it does compare RTIDWDCNTR vs RTIDWDPRLD.
> 
> Now the root cause of the original motivation to manipulate the clock rate
> is said to be understood and fixed in Linux commit cae58516534e
> ("watchdog: rti_wdt: Set min_hw_heartbeat_ms to accommodate a safety margin")
> which simultaneously removed the hack itself.
> 
> While is fix part of the mentioned patch is neither applicable nor requried
> for the U-Boot driver just drop the hack setting WDT clock rate to 90% of
> the real rate. This has a nice effect that the WDT timeout is now as
> requested and not 10% shorter.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Applied to u-boot-watchdog/master

Thanks,
Stefan

> ---
> Changelog:
> v2: 2 typos pointed by Jan corrected
> 
>   drivers/watchdog/rti_wdt.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
> index 99168d0cad03..f806e24e53da 100644
> --- a/drivers/watchdog/rti_wdt.c
> +++ b/drivers/watchdog/rti_wdt.c
> @@ -186,14 +186,6 @@ static int rti_wdt_probe(struct udevice *dev)
>   
>   	priv->clk_hz = clk_get_rate(&clk);
>   
> -	/*
> -	 * If watchdog is running at 32k clock, it is not accurate.
> -	 * Adjust frequency down in this case so that it does not expire
> -	 * earlier than expected.
> -	 */
> -	if (priv->clk_hz < 32768)
> -		priv->clk_hz = priv->clk_hz * 9 / 10;
> -
>   	return 0;
>   }
>   

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de


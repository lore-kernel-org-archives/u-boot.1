Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FD1D1356D
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 16:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AD6A890A9;
	Sun, 27 Oct 2024 17:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DxKyy3RK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JDp3aZ5Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FA9588C10; Sun, 27 Oct 2024 17:32:16 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A68A8907B
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 17:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Xc29J5Wkqz9st0;
 Sun, 27 Oct 2024 17:32:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JJyZgb0IcByXfZdJPnk5kDGE/FcOXtM7mpruFvprFCg=;
 b=DxKyy3RKX07hzCGTKmFKVnhhimUJLGUtmwQ84U2V+Mx0GwS01k4MBeemNk57odHfNzDIhm
 KSHz3WawCm4Su2YPaUP2OIDZRgvHECf/eliXQy33fUvuP9WEoTNTgP+avKZ/zhrpvnmHbp
 YXrnLkPJ+kEoi25sKitPYOW0wnhFtEm4t+UOuHv1FPaEGnARj+H4fRUPFvNttGjrgADjAO
 sFYT/2Ku7M1TTjmPNsc7k7APGRBmbnU7Zb3YpROf1SNfYMVwYVPAP2URsrCqBwCGXpPhrH
 pWhrZTvYCBN+tCRa5jgujzCn7wI5LmdwolGpcq+BIKv832gQ4Xhxizhd5o6QHQ==
Message-ID: <ff3ff3f4-c7b1-4a8b-9a0a-0153404bc56b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JJyZgb0IcByXfZdJPnk5kDGE/FcOXtM7mpruFvprFCg=;
 b=JDp3aZ5YZOYuQ0xLoZpwwcqYMHQhC8sl4NQQAF/MRh3HJeMGBvzyeP3gaNxYnccEZoiYIu
 nQPCjHbISOcwySIlcPM4L3OEylKhCuCqRZdAXZcFE+OGBNGppuyIxiEYANPL1z1SozS7y8
 a+o1xvYFmR6efom7jzkZrCrRziDVCcO1G0azjbEPG+dvteBOnlk4TatFJUgvvdlBgDkdK5
 k3MrPBkLdJM1JNHOzUm00UeOtkn2psWs7wp9HElLRS5U+nCeCiS7u7xHtLZ4Q6UBrpccLn
 tXcMKvf55fBKRNu5MJTxYNWM04jSpufH9MdriM2ec5WREm3YbYhiQPFrYDe8qw==
Date: Sun, 27 Oct 2024 17:18:24 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 06/14] net: phy: ksz90x1: Handle ksz9131 LED errata
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
 <20241024152448.102-7-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241024152448.102-7-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 17tiaa1uqqzxsprnzef3iitkjqwfhiib
X-MBO-RS-ID: 0814059cf00d657d018
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

On 10/24/24 5:24 PM, Paul Barker wrote:
> Micrel KSZ9131 PHY LED behavior is not correct when configured in
> Individual Mode, LED1 (Activity LED) is in the ON state when there is
> no-link.
> 
> Workaround this by setting bit 9 of register 0x1e after verifying that
> the LED configuration is Individual Mode.
> 
> This issue is described in KSZ9131RNX Silicon Errata DS80000693B [*]
> and according to that it will not be corrected in a future silicon
> revision.
> 
> [*] https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9131RNX-Silicon-Errata-and-Data-Sheet-Clarification-80000863B.pdf
> 
> Based on commit 0316c7e66bbd in the Linux kernel.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>   drivers/net/phy/micrel_ksz90x1.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel_ksz90x1.c
> index c48ae6e88f30..4f99b115a3c7 100644
> --- a/drivers/net/phy/micrel_ksz90x1.c
> +++ b/drivers/net/phy/micrel_ksz90x1.c
> @@ -436,6 +436,26 @@ static int ksz9131_config_rgmii_delay(struct phy_device *phydev)
>   	return ret;
>   }
>   
> +/* Silicon Errata DS80000693B
> + *
> + * When LEDs are configured in Individual Mode, LED1 is ON in a no-link
> + * condition. Workaround is to set register 0x1e, bit 9, this way LED1 behaves
> + * according to the datasheet (off if there is no link).
> + */
> +static int ksz9131_led_errata(struct phy_device *phydev)
> +{
> +	int reg;
> +
> +	reg = phy_read_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG, 0);
> +	if (reg < 0)
> +		return reg;
> +
> +	if (!(reg & BIT(4)))
It would be good to have symbolic names for these BIT()s , please add 
some #define ... macros .

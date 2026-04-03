Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3BBD7309A
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 04:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF7D783DC9;
	Fri,  3 Apr 2026 06:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="A/Xz6ft0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3D8F84020; Fri,  3 Apr 2026 06:43:48 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7BFF83D8A
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 06:43:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E07F9112FCE; Fri,  3 Apr 2026 06:43:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1775191426;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=YPkIj73xkd0P1kbscPUiLtvoUiYsBhkDg3hk1b0FcBc=;
 b=A/Xz6ft0fgk3EEJ6c7hnH/S1IHtJNfpYTdUoOIZ0qMmHp+yfYp+h3/qDmCgbF2C89FO9so
 ay88EOmTIPOZYsPJBxYKLEUuTQxv5hSY6nxqwEfcW8p1qZdpbhBB+9aICYg4nBapHDPHah
 vZH4+6wQLj3FK8GPa2tzFSPTvFdAUzRFdeoDnraiK1i4c3OJh7xJEnFCFa4lQZfoCGmT/a
 P7DF+hN5hm47+tx5V+jTfp+y50TK+WfMoZh86ehBdGFo0JDT1a1gT9spPz3GQfb1tJcWxb
 Qr8AtcvSMVa2KmWVLtHqgKwWvOUWUdJ3nNasX7CxdUkkwEpeDRPjuvrvk6o9xQ==
Message-ID: <f33fd3f7-fbab-44d4-bce8-e33d8d03b933@nabladev.com>
Date: Fri, 3 Apr 2026 06:43:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@nabladev.com>
Subject: Re: [PATCH V2] board: dhelectronics: imx: Use second Ethernet MAC
 also from fuse
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20260402143753.40142-1-cniedermaier@dh-electronics.com>
Content-Language: en-US
In-Reply-To: <20260402143753.40142-1-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/2/26 4:37 PM, Christoph Niedermaier wrote:
> Currently, the board specific code evaluates only the first Ethernet
> MAC address fuse, regardless of whether the first or second MAC
> address is requested. When the function for determine the second
> Ethernet MAC address is looking for the fused MAC address, it only
> reads the first MAC address fuse and increment it by one to set
> the second Ethernet MAC address. That is not the expected behavior
> when two MAC addresses are fused, because this causes the second
> fused MAC address to be ignored. Change this so that the second
> fused MAC address will be used.
> 
> In addition, the handling of the MAC address for early prototypes
> will be removed, as such SoMs were not used by customers.

This ^ should be kept.

> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

RB goes above SoB line

[...]

> @@ -84,19 +84,8 @@ static int dh_imx8_setup_eth1addr(struct eeprom_id_page *eip)
>   	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom1"))
>   		goto out;
>   
> -	/*
> -	 * Populate second ethernet MAC from first ethernet EEPROM with MAC
> -	 * address LSByte incremented by 1. This is only used on SoMs without
> -	 * second ethernet EEPROM, i.e. early prototypes.
> -	 */
> -	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom0"))
> -		goto increment_out;
> -
>   	return -ENXIO;
>   
> -increment_out:
> -	enetaddr[5]++;
> -
>   out:
>   	return eth_env_set_enetaddr("eth1addr", enetaddr);
>   }

Please keep this ^ hunk, the rest is fine, thank you.

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19530108B8FF
	for <u-boot@archiver.kernel.org>; Sat, 21 Mar 2026 07:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F05083E48;
	Sat, 21 Mar 2026 08:11:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="CzVE49eR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C68A83FDB; Sat, 21 Mar 2026 03:40:43 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8505583FA4
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 03:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 28E31111E8D; Sat, 21 Mar 2026 03:40:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1774060841;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=5AOrKrIbesfzNfg7yRGjOMAjTs3Mstu0lXWhxRgi7jI=;
 b=CzVE49eRR0E4SfpVTwwAHNWcgwTLHhqlLi2xB7H8Lt3d0NPgLdIo7x/rNNHKjpW7yWk8zU
 VOaS8q/RvPSsqxqKVrUXo9wzexzyiv9STlEM182dM6JE+sr2oV/Y+TD+/kT/NfH2kD5FSG
 QCmPhzkz5x2GJo3dMToLCs8VgO8mNGFRPmMI2+AG5gWBaC9zLnsTxLSJMwYmtUex6tlNlC
 SVM7zk4SQymwVL+RUMCaUDqTBDHIX2rbOzVxMnDnyhng/0qSenu1QTh+AVTMD45io1OqIN
 WOCyXdo1klVReA8deCKJTz6cTUS9hef0bkNq0UQWxUEilCGUJozvJfWsUUzf3g==
Message-ID: <382f338c-020f-482d-80b8-5a39ad724843@nabladev.com>
Date: Fri, 20 Mar 2026 19:22:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: dhelectronics: imx: Use second Ethernet MAC also
 from fuse
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20260320102918.4011-1-cniedermaier@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260320102918.4011-1-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Sat, 21 Mar 2026 08:11:56 +0100
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

On 3/20/26 11:29 AM, Christoph Niedermaier wrote:

[...]

> +++ b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
> @@ -50,7 +50,7 @@ static int dh_imx8_setup_ethaddr(struct eeprom_id_page *eip)
>   	if (dh_get_mac_is_enabled("ethernet0"))
>   		return 0;
>   
> -	if (!dh_imx_get_mac_from_fuse(enetaddr))
> +	if (!dh_imx_get_mac_from_fuse(0, enetaddr))
>   		goto out;
>   
>   	if (!dh_get_value_from_eeprom_buffer(DH_MAC0, enetaddr, sizeof(enetaddr), eip))
> @@ -75,8 +75,8 @@ static int dh_imx8_setup_eth1addr(struct eeprom_id_page *eip)
>   	if (dh_get_mac_is_enabled("ethernet1"))
>   		return 0;
>   
> -	if (!dh_imx_get_mac_from_fuse(enetaddr))
> -		goto increment_out;
> +	if (!dh_imx_get_mac_from_fuse(1, enetaddr))
> +		goto out;

The ordering in this and next hunk seems bogus.

If read from the (new/second) fuse slot 1 fails, the code should attempt 
to use fuse slot 0 content incremented by 1, just like it did before ...

"
if (!dh_imx_get_mac_from_fuse(1, enetaddr))
   goto out;
if (!dh_imx_get_mac_from_fuse(0, enetaddr))
   goto increment_out;
"

>   	if (!dh_get_value_from_eeprom_buffer(DH_MAC1, enetaddr, sizeof(enetaddr), eip))
>   		goto out;
> @@ -92,6 +92,13 @@ static int dh_imx8_setup_eth1addr(struct eeprom_id_page *eip)
>   	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom0"))
>   		goto increment_out;
>   
> +	/*
> +	 * If only the first MAC address is fused but not the second, use the
> +	 * fused MAC address incremented by one, for the second MAC address.
> +	 */
> +	if (!dh_imx_get_mac_from_fuse(0, enetaddr))
> +		goto increment_out;
... this part would then be unnecessary.

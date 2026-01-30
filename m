Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035B0D73EB2
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 02:15:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8884A8418A;
	Fri, 30 Jan 2026 03:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dXpf1ys/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BB7684199; Fri, 30 Jan 2026 03:15:46 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8175A840DF
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 03:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f2KNt3rSmz9tnB;
 Fri, 30 Jan 2026 03:15:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769739342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Thw3ndHKmiuV+RTHjvL5wuJZ7Cm4zxguVvuQuEpFJcc=;
 b=dXpf1ys/G4nRw6wsjHLfgy4WLU7TWyYAUOiWos+a/feipGGB2SJ787Nt538yQeS1ovpjPJ
 2WdvYDBluiXUvQwegot0+qfQ/C6UfngfXjWhNVRM5S0aUZxXePy5i3eWik6KTcjFTapwMs
 HLobvpsZkEIKHaohzl3YMrnE3jJqwoY2CjaWcjQsigESbr/RHVDvVxO63AQut7r80hDXbJ
 X+R3WL5+Ag05dov6ST9cag5kYTs4BO4/UCQ/qqAi5sY76HWTzEugeyEYCKl6Ul8kySa6iR
 itKDQMqIGEdGK7p2M3CTf9k0DQx6QCyPUKsVMOjKC8IMEqU+nVrtAkTOJMs55g==
Message-ID: <93cc5788-600f-4145-be86-a1a7ea8b0ff9@mailbox.org>
Date: Fri, 30 Jan 2026 02:23:54 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] usb: eth: asix88179: Use negative ECOMM return value
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: Khoa Hoang <admin@khoahoang.com>, u-boot@lists.denx.de
References: <20260130002941.2336252-1-jonas@kwiboo.se>
 <20260130002941.2336252-2-jonas@kwiboo.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260130002941.2336252-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 50ca9c6a88136c3b036
X-MBO-RS-META: jxcz4u6bjhmaeoyafg3woytsqp9zjyoq
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

On 1/30/26 1:29 AM, Jonas Karlman wrote:
> The ASIX 88179 driver asix_read/write_cmd() return a positive error
> value instead of a typical negative error value. This return value is
> checked in the asix_read/write_mac() to control a debug() print and can
> also propagate to probe() and write_hwaddr() ops.
> 
> Change to use a proper negative ECOMM return value when read/write a
> command. Also update to use the ETH_ALEN const instead of 6 for
> consistent use in asix_read/write_mac().
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/usb/eth/asix88179.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
> index 69d3073b669a..8915ef1fdc36 100644
> --- a/drivers/usb/eth/asix88179.c
> +++ b/drivers/usb/eth/asix88179.c
> @@ -235,7 +235,7 @@ static int asix_write_cmd(struct ueth_data *dev, u8 cmd, u16 value, u16 index,
>   		size,
>   		USB_CTRL_SET_TIMEOUT);
>   
> -	return len == size ? 0 : ECOMM;
> +	return len == size ? 0 : -ECOMM;
>   }
>   
>   static int asix_read_cmd(struct ueth_data *dev, u8 cmd, u16 value, u16 index,
> @@ -260,15 +260,16 @@ static int asix_read_cmd(struct ueth_data *dev, u8 cmd, u16 value, u16 index,
>   
>   	memcpy(data, buf, size);
>   
> -	return len == size ? 0 : ECOMM;
> +	return len == size ? 0 : -ECOMM;
>   }
>   
>   static int asix_read_mac(struct ueth_data *dev, uint8_t *enetaddr)
>   {
>   	int ret;
>   
> -	ret = asix_read_cmd(dev, AX_ACCESS_MAC, AX_NODE_ID, 6, 6, enetaddr);
> -	if (ret < 0)
> +	ret = asix_read_cmd(dev, AX_ACCESS_MAC, AX_NODE_ID,
> +			    ETH_ALEN, ETH_ALEN, enetaddr);
> +	if (ret)
>   		debug("Failed to read MAC address: %02x\n", ret);

This print likely needs to be fixed too, it prints unsigned hex while 
the value is now signed int.

>   
>   	return ret;
> @@ -278,9 +279,9 @@ static int asix_write_mac(struct ueth_data *dev, uint8_t *enetaddr)
>   {
>   	int ret;
>   
> -	ret = asix_write_cmd(dev, AX_ACCESS_MAC, AX_NODE_ID, ETH_ALEN,
> -				 ETH_ALEN, enetaddr);
> -	if (ret < 0)
> +	ret = asix_write_cmd(dev, AX_ACCESS_MAC, AX_NODE_ID,
> +			     ETH_ALEN, ETH_ALEN, enetaddr);
> +	if (ret)
>   		debug("Failed to set MAC address: %02x\n", ret);
DTTO

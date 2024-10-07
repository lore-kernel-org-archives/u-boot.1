Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33041CFB440
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 12:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DC3588AB9;
	Mon,  7 Oct 2024 14:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BkPZtdT9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 736CB889E1; Mon,  7 Oct 2024 14:27:16 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B868788AB9
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 14:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 320F8A41C98;
 Mon,  7 Oct 2024 12:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFB9C4CEC6;
 Mon,  7 Oct 2024 12:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1728304032;
 bh=GvfT/pu2NLfMnQit16QNTldftK67flmSz7p5NdE7ic4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BkPZtdT9N3/xrnsv0JnCmTIH6vJctujJqqXggrCGngOls6p1CSlItHql5HVt4xlzU
 2tp7o/EiQXEy5hfWoftKEAvojAUgaVnhtYXph6M+pagOClNqB6pTnDcHgOgnxWW64n
 4VDoE4Ydfd9on5tn1QjSNK8RzCGX0i8lYoq4RaQPga8Hdf4+2qx80HzKMrE8bBUUYf
 GLjmkyom3W0Sevp6X3ySmpryj9xyfKtuTkJXd2aPDcLQGMJEIDfwQyw22D4w80xzr6
 akKrT0LGsZvvDmfNQ9FT0oYpbGMoGbFKPvevHjeQnoPV3QRzgbSsmpwqCQghUheDzQ
 3HSgm3hpicFcA==
Message-ID: <27da3912-1414-4221-b8f6-27833947d15c@kernel.org>
Date: Mon, 7 Oct 2024 15:27:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: gadget: cdns3: Fix cdns3_ep_config() by setting
 ep.maxpacket
To: Siddharth Vadapalli <s-vadapalli@ti.com>, trini@konsulko.com,
 lukma@denx.de, mkorpershoek@baylibre.com, marex@denx.de, vigneshr@ti.com
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20241007121927.1680039-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241007121927.1680039-1-s-vadapalli@ti.com>
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



On 07/10/2024 15:19, Siddharth Vadapalli wrote:
> The function cdns3_ep_config() calculates the maximum packet size based
> on the Endpoint Type and the Gadget Speed and stores it in the variable
> "max_packet_size". This value is then programmed in the USB Controller
> for the corresponding Endpoint. This may result in a mismatch between
> the maximum packet size programmed in the USB controller and the maximum
> packet size seen by the UDC Core via "maxpacket" member of "struct usb_ep".
> Additionally, since TD_SIZE is calculated in cdns3_ep_run_transfer() on the
> basis of the maximum packet size stored in the "maxpacket" member of
> "struct usb_ep", it may lead to an incorrect value of TD_SIZE when compared
> with what the USB controller actually expects (max_packet_size).
> 
> Fix this.
> 
> Fixes: 7e91f6ccdc84 ("usb: Add Cadence USB3 host and gadget driver")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>


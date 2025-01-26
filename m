Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B8DC02181
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 11:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8175C80F10;
	Sun, 26 Jan 2025 12:49:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737892152;
	bh=m0A9OrD7AS/3vG0Z8QL/CxWjhyi9ImTmbGMgj66nHa4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iAnbHA3pxMMQe+B/hSmyB8kkNSpRAyFgcrBvAo9bT+YvkyaU9EF8d05F8nWdqtYgH
	 Jxx0mwt40g1CgQzhkyUFaaS2tBbk/KtthItnZ0rW9TeaeFqCHym1ExfL1XQYSaVV/v
	 YZObR5xOEznOEn9RRYh378v8XjR3ocCpO4D7m7NzfTys0oGYRMvnvzimGvaRxo5ixQ
	 AklsaSU3tkwcyOzeEau/lYH9Xm88IBSqQ6MWHmJPNJ3mj83xR1mrSb9zHdZVCSUZww
	 a6900tDcJhFYZhgT4BkfKrXhI3wDaa5qaf9qZo//89MYR57Ve8qS54FXNDp4vtZ4z1
	 HQE1554mzH0Yw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68D3E80F53; Sun, 26 Jan 2025 12:49:11 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 185BB80EEF
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 12:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="hnpcuRLg"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 07582101ECB2F; Sun, 26 Jan 2025 12:49:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737892147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m0A9OrD7AS/3vG0Z8QL/CxWjhyi9ImTmbGMgj66nHa4=;
 b=hnpcuRLgzShoHnkvQ/NT7xbeV3uQZSOJGRDjUEcGkO/vZaHa0NMBabuV1ZyGdaksx35gWB
 nXSFgD4m67i2D+/0i45+Ae4HBwoPPaMRc8HNuw9CuaWVRVA6NUoha4q6mqr2b3ymUj6Fu9
 ttwBA75Y5tO0iOvnm2qZ+QQzKSOSD69mK2UVTr8g0p+jOLE2dA20ZuHmLlSw/rgfJdVzpn
 ihiMvwWFEfiHWmfJcjA9V/7LF1xs/Dz9w28zIaIV4eblBm40jE1dcORugkHGYruXGNsXiZ
 8YmDhYFHlUcZ2xwt51H5aEX1wEAQezkuvyxQFD4qIRudlAWpu9O3p4f5BE5/fw==
Message-ID: <24b2d49a-1737-43bd-b726-5fc0a7e4adca@denx.de>
Date: Sun, 26 Jan 2025 12:48:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc2: Refactor register operations with clrsetbits
 macros
To: Junhui Liu <junhui.liu@pigmoral.tech>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250126-dwc2-clrsetbits-refactor-v1-1-68c27e1b6f84@pigmoral.tech>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250126-dwc2-clrsetbits-refactor-v1-1-68c27e1b6f84@pigmoral.tech>
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

On 1/26/25 9:29 AM, Junhui Liu wrote:
> Refactor DWC2 USB gadget driver to replace manual read-modify-write
> operations with `clrsetbits_le32`, `setbits_le32`, and `clrbits_le32`
> macros, which simplify the code and improve readability.
> 
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !

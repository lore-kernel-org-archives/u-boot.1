Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A068E7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 19:46:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8952C800D2;
	Fri, 13 Dec 2024 20:46:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1734119207;
	bh=Af7RqKvjIe5iZd4S1MPVGbjTMuL4udHF8UU3tCxFAzQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XLzyf02BWfw1TaHY7b05WkxuFEU3lvYOFaNzM9YUVpHNIbkLXuWlZSxGCP5lDSyVs
	 WLTpOvqgYN3rA6tHnmxlQ9szRb9TOe7Qyjsmne1G/p2sbNt9ryZ5s3qQ40+89d8cO+
	 jqXHeboDqr2z657zR88s0EI3/1K6UK29b/czW67e+lqEK4Op6XBB10lfmWF0gIHG4d
	 ZXjw1YIhb2JSdmfkmEbrWGaYu8dD+38syIIzj+ad38e3LbbCt5m2ofMtLDSe6ibuEx
	 L/qbDf/OxvHjOx5NJ34IRLB0VsrKMccRKu44cUWfq5818+bORXSuHpyLFuU3CeCvHH
	 jBCX+fJQO0now==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E6E0800D6; Fri, 13 Dec 2024 20:46:46 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EEB880086
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 20:46:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Up1/oVLL"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C05F71049DA08; Fri, 13 Dec 2024 20:46:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1734119202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Af7RqKvjIe5iZd4S1MPVGbjTMuL4udHF8UU3tCxFAzQ=;
 b=Up1/oVLLrZWRiOz+wUdxgeyXWLD6VOA4YePpI7IMV86nWwlBTkFmvNo/EDtpXkWazXB82F
 PFGccDjk4YFocFwwOqcuy3vgKTZ5UVdPc/JAUF4dAM4l6OmBv98DHQaysnkgefU8ThTLhR
 UQB5St18ZVCiuIbQIYxLQgTlpwDf/QtS3djvd45VFtYdxQoxgCKOScTxhusdYWPEdiiQLv
 mpot1Vq2cq+jFacvIe2w/rfDLeKUZo5aUOtvqdZHHJ5+U7R/D1favEdnPOsAXsEc1nDrfg
 KE6i8rK3kjGGUnS7l0ZBLk70tJqqoeKRsJqJB7N7sSHfWWp6YkBQjl4uc8vwFQ==
Message-ID: <642a8d5d-54ca-4668-9805-c1081d960c8a@denx.de>
Date: Fri, 13 Dec 2024 20:45:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: dwc3-generic: set "mode" based on caller of
 dwc3_generic_probe()
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com, bb@ti.com,
 trini@konsulko.com, hnagalla@ti.com, mkorpershoek@baylibre.com,
 caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 jan.kiszka@siemens.com, jonas@kwiboo.se, j-humphreys@ti.com,
 rogerq@kernel.org, nm@ti.com, devarsht@ti.com, ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20241126120322.1760862-1-s-vadapalli@ti.com>
 <20241126120322.1760862-2-s-vadapalli@ti.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241126120322.1760862-2-s-vadapalli@ti.com>
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

On 11/26/24 1:03 PM, Siddharth Vadapalli wrote:
> There are only two callers of "dwc3_generic_probe()", namely:
> 1. dwc3_generic_peripheral_probe()
> 2. dwc3_generic_host_probe()
> Currently, the "mode" is set based on the device-tree node of the
> platform device. Also, the DWC3 core doesn't support updating the "mode"
> dynamically at runtime if it is set to "OTG", i.e. "OTG" is treated as a
> separate mode in itself, rather than being treated as a mode which should
> eventually lead to "host"/"peripheral".
> 
> Given that the callers of "dwc3_generic_probe()" clarify the expected
> "mode" of the USB Controller, use that "mode" instead of the one
> specified in the device-tree. This shall allow the USB Controller to
> function both as a "Host" and as a "Peripheral" when the "mode" is "otg"
> in the device-tree, based on the caller of "dwc3_generic_probe()".
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Marek Vasut <marex@denx.de>

for next

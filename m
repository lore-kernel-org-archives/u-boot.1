Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BE0CDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:25:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05C7786B84;
	Mon, 16 Oct 2023 11:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448174;
	bh=XbxAeVPL2qfyPtIcCsCsJVQsUTQRnXnONk0EqaZiXoE=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=X+qg27A3AWSgW24s00i5ERxoYjXvdRKmGQgskF8Rf3Z5OT1+k4fqxNT5idkrrbsUW
	 NP8kT8TnZ2ke+LW2z484l0GGxFP2xY+CA0S5tGh+Ev+xUo6Ge8K6+KjFb4A60kk12U
	 EgcZHl9AXbjZc4xfNlxn9wjmgjjPSov33q36CSsJ82eMyEdgaXDr9hG7pi8mW2lU+U
	 7k8uHjR82MR2y6E8Byq7OrtQ3HPlyf1TnXRj/edpQbTPUwEKlsIPUysc/G16LJOmdw
	 B8HVx9WopCaBuSuTSf2zZJ4HkGWzg0mSH/JXIfSCU0nYPDpjE8gFLCM4lv3p0bPvFm
	 C+WbEBzfNTSBw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4FF586DC8; Mon, 16 Oct 2023 11:21:57 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E3EC86AB3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BSv2VnVz1r2sg;
 Mon, 16 Oct 2023 11:21:51 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BSv2Fvzz1qqlS;
 Mon, 16 Oct 2023 11:21:51 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id zQ5jzVrmpYuK; Mon, 16 Oct 2023 11:21:50 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:21:50 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Tim Harvey <tharvey@gateworks.com>
X-Patchwork-Id: 1821581
X-Patchwork-Delegate: sbabic@denx.de
To: Tim Harvey <tharvey@gateworks.com>,u-boot@lists.denx.de
Subject: [PATCH 2/6] board: gateworks: venice: add imx8mp-gw71xx-2x support
In-reply-to: <20230815220115.2000851-2-tharvey@gateworks.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016092157.B4FF586DC8@phobos.denx.de>
Date: Mon, 16 Oct 2023 11:21:51 +0200 (CEST)
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

> The Gateworks imx8mp-venice-gw71xx-2x consists of a SOM + baseboard.
> The GW702x SOM contains the following:
>  - i.MX8M Plus SoC
>  - LPDDR4 memory
>  - eMMC Boot device
>  - Gateworks System Controller (GSC) with integrated EEPROM, button
>    controller, and ADC's
>  - PMIC
>  - SOM connector providing:
>   - eQoS GbE MII
>   - 1x SPI
>   - 2x I2C
>   - 4x UART
>   - 2x USB 3.0
>   - 1x PCI
>   - 1x SDIO (4-bit 3.3V)
>   - 1x SDIO (4-bit 3.3V/1.8V)
>   - GPIO
> The GW71xx Baseboard contains the following:
>  - 1x RJ45 GbE (eQoS from SOM)
>  - off-board I/O connector with I2C, SPI, UART, and GPIO
>  - Front Panel bi-color LED
>  - re-chargeable battery (for RTC)
>  - PCIe clock generator
>  - 1x USB Type-C connector supporting USB 2.0 host mode with VBUS
>  - 1x MiniPCIe socket with SIM, PCI/USB 3.0 (mux), and USB 2.0
>  - GPS
>  - Accelerometer
>  - EERPOM
>  - Wide range DC input supply
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113F9CDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4560C86DCA;
	Mon, 16 Oct 2023 11:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448196;
	bh=Iw/vG0aql4dQ7unPiaKpr6e0O8nn6UM/Yucv8D2SKrA=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=mbIMNgfeFdSQ4cEJw60FDaerhab95DdNIuEuYxYXY/T+gunsB6M00IM5fys24a8EU
	 NLVprzUe2NBFRLE7oUFRGzfEMWXjLmIauUsmGTZMsvdobJJY0+kxtym6B5c4EoiExp
	 PqJQAiVIri1jN7H2UCEgcnxH7og6JItkybq/VGBJz0AUP7cHoKja8E6vzTyJEKCVs1
	 hNr1j3zXH4GIG+7zRUu5PYVBgCyY+ZceUmsU7PlbOD9+GgYQavyDND0Q6hVZY8u9zn
	 wwSgonPvUQgf10ZStcmI9RaRQJ3d9+NPF5yWeTuR38yMoUttK0qwLVl1MreiI4+ous
	 Ms+CxLaC2SM7Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE14086BB3; Mon, 16 Oct 2023 11:22:18 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C78086B79
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:22:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BTF6mmVz1r3fB;
 Mon, 16 Oct 2023 11:22:09 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BTF6fW1z1qqlS;
 Mon, 16 Oct 2023 11:22:09 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id uQMr7DCFGz3x; Mon, 16 Oct 2023 11:22:09 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:22:09 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Tim Harvey <tharvey@gateworks.com>
X-Patchwork-Id: 1821584
X-Patchwork-Delegate: sbabic@denx.de
To: Tim Harvey <tharvey@gateworks.com>,u-boot@lists.denx.de
Subject: [PATCH 5/6] board: gateworks: venice: add imx8mm-gw7905-0x support
In-reply-to: <20230815220115.2000851-5-tharvey@gateworks.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016092221.DE14086BB3@phobos.denx.de>
Date: Mon, 16 Oct 2023 11:22:13 +0200 (CEST)
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

> The Gateworks imx8mm-venice-gw7905-0x consists of a SOM + baseboard.
> The GW700x SOM contains the following:
>  - i.MX8M Mini SoC
>  - LPDDR4 memory
>  - eMMC Boot device
>  - Gateworks System Controller (GSC) with integrated EEPROM, button
>    controller, and ADC's
>  - RGMII PHY
>  - PMIC
>  - SOM connector providing:
>   - FEC GbE MII
>   - 1x SPI
>   - 2x I2C
>   - 4x UART
>   - 2x USB 2.0
>   - 1x PCI
>   - 1x SDIO (4-bit 3.3V)
>   - 1x SDIO (4-bit 3.3V/1.8V)
>   - GPIO
> The GW7905 Baseboard contains the following:
>  - GPS
>  - microSD
>  - off-board I/O connector with I2C, SPI, GPIO
>  - EERPOM
>  - PCIe clock generator
>  - 1x full-length miniPCIe socket with PCI/USB3 (via mux) and USB2.0
>  - 1x half-length miniPCIe socket with USB2.0 and USB3.0
>  - USB 3.0 HUB
>  - USB Type-C with USB PD Sink capability and peripheral support
>  - USB Type-C with USB 3.0 host support
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

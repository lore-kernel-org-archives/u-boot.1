Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E30C46CA1
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:28:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3D0186F09;
	Mon, 16 Oct 2023 11:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448186;
	bh=uHLyGL7iqrmdqiLN+TP1T0A9zBI3UabIN6V3WhDgaAM=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=R83E5ofKWn8gDThiPuUuPQNOpXAurI33NW1lperY2EFK1LJnEtPuQB8Au2VLEYBhp
	 0JZJ20sDKtporIQgSM1F0/NrgS9FiKtpI4jIYlqPardUZft9FD1gpFs4t4ZJrqhVR4
	 a8HqFH7/vl0fZMGVnl63ETfzaWwd/189SWE9qhBD0tPrEj/XixzWiUULrznrYSHUTD
	 gvPQZ+1+pbi59s5sXsBgPc+ilXps7+oFQxbMZcBcRhCEcpgCnkAF/bqbPOP+bPx7MU
	 IX6W1eHSuvWT7PYot/WwYW+//RIDghRDIrxKrofn6XFH8nQbJVeisyjwu45seIcl9P
	 7k+d/YEToXYOQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC7EE86EE7; Mon, 16 Oct 2023 11:22:18 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D58986BB3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BTB20tmz1sCln;
 Mon, 16 Oct 2023 11:22:06 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BTB1kTZz1qqlS;
 Mon, 16 Oct 2023 11:22:06 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id f_Rz-NrOQ1oH; Mon, 16 Oct 2023 11:22:05 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:22:05 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Hiago De Franco <hiagofranco@gmail.com>
X-Patchwork-Id: 1842106
X-Patchwork-Delegate: sbabic@denx.de
To: Hiago De Franco <hiagofranco@gmail.com>,u-boot@lists.denx.de
Subject: [PATCH] toradex: colibri_imx7: Enable nand/emmc detection and set
 boot variant
In-reply-to: <20231002115749.15160-1-hiagofranco@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016092221.DC7EE86EE7@phobos.denx.de>
Date: Mon, 16 Oct 2023 11:22:06 +0200 (CEST)
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

> From: Hiago De Franco <hiago.franco@toradex.com>
> Add detection of eMMC vs NAND devices on the Colibri iMX7
> board. A GPIO is configured to detect the presence of an on-board resistor
> that is configured differently based on the flash memory used. Depending on
> the detection result, the 'variant' environment variable is set to '-emmc'
> or cleared, indicating the type of storage device.
> This enhancement improves variant detection during system initialization
> through USB recovery mode, where U-Boot is loaded directly to RAM. This
> allows variant detection for an accurate device tree selection.
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================

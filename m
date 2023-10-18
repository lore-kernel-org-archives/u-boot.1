Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F026DCDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 18:18:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C65758701B;
	Wed, 18 Oct 2023 20:17:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697653074;
	bh=mGT9Q3gr+arAaWxhuzeQZFIf1LZbSPShnD6/AMLfflQ=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=C7IVYhm5gQIhSK7XvBlwpFJo/gYgpxFoETxktUCb7Ep+hb8XceLQZRD3Jv8WX9dp5
	 jY5EIZP/undRV2icfsIIqrOVCPUEMP/qTZQCVyhQk3bloIE5UQWxyPjiz799HCrp8Z
	 wkLjjd1EW8S2dTAB+qxbWtt4lefFj6Nq5sET5UKyN3VXgQxmG/WqjR5c80SRwsx4kt
	 5MJbpJ9RHX9Alxp1BjpTJDZV99kwY75cP6dZqqzH5xJv7LkKGMti+nMdedNcy08MH2
	 5D271UuX6iud3B3IrwWdnjQx68xbpPBo5jwJvKSLIBZBUpinMDlJxTuo8DA30e/Esq
	 I62CZB0md8NBw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE31E8701C; Wed, 18 Oct 2023 20:17:53 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11F2787017
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 20:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S9fGR624wz1sBq3;
 Wed, 18 Oct 2023 20:17:51 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S9fGR5x9Dz1qqlS;
 Wed, 18 Oct 2023 20:17:51 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id 0H9PRIYVflEq; Wed, 18 Oct 2023 20:17:51 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Wed, 18 Oct 2023 20:17:51 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Marek Vasut <marex@denx.de>
X-Patchwork-Id: 1849460
X-Patchwork-Delegate: sbabic@denx.de
To: Marek Vasut <marex@denx.de>,u-boot@lists.denx.de
Subject: [PATCH v2 1/4] spl: mmc: Introduce proper layering for
 spl_mmc_get_uboot_raw_sector()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231018181753.CE31E8701C@phobos.denx.de>
Date: Wed, 18 Oct 2023 20:17:52 +0200 (CEST)
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

> Introduce two new weak functions, arch_spl_mmc_get_uboot_raw_sector() and
> board_spl_mmc_get_uboot_raw_sector(), each of which can be overridden at
> a matching level, that is arch/ and board/ , in addition to the existing
> weak function spl_mmc_get_uboot_raw_sector().
> This way, architecture code can define a default architecture specific
> implementation of arch_spl_mmc_get_uboot_raw_sector(), while the board
> code can override that using board_spl_mmc_get_uboot_raw_sector() which
> takes precedence over the architecture code. In some sort of unlikely
> special case where code has to take precedence over board code too, the
> spl_mmc_get_uboot_raw_sector() is still left out to be a weak function,
> but it should be unlikely that this is ever needed to be overridden.
> Signed-off-by: Marek Vasut <marex@denx.de>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================

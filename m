Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72591CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 16:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D762786E2F;
	Mon, 16 Oct 2023 18:46:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697474793;
	bh=Fy+aDZEW1Qk3NY14rpwVjRjmITTsDiR+pDPzpwDQgDg=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=KDPOPFBsDmQV95Uve8pDZBpmLtuDY3prTQVeaaKDWsD9OuoKP3dKYlNebd6ravuoy
	 wdSbt3FyYRZsl+8GglUQRdhCQ2pRaYLTqwSSnwyZM2ADJ7c+t2e/ifn66P1VIgwVG4
	 ghITlPmRDBGtmt84AoLP9sHZR7EI6V+fgyCuO6g+6CRaM3hwdUiGiCqOKWARAd2tmd
	 LS8vDFklvlElKJyCA0gM4Qh8mAhExquBtOnVK40oC/7zeVywErs6XslbulhjUFZkLS
	 uXZqR4hCgZklVqCExDZSERYzKssWxjiBZ0O241hFhuUVx24T7bUQNAd5VTwxteaY/w
	 sFhzDFgacv3ow==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B43486F0F; Mon, 16 Oct 2023 18:46:24 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01F5686E1A
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 18:46:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8NKW5Zjbz1r1sM;
 Mon, 16 Oct 2023 18:46:07 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8NKW5V5tz1qqlS;
 Mon, 16 Oct 2023 18:46:07 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id dcqjNp4RI-4v; Mon, 16 Oct 2023 18:46:07 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 18:46:07 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Marek Vasut <marex@denx.de>
X-Patchwork-Id: 1837757
X-Patchwork-Delegate: sbabic@denx.de
To: Marek Vasut <marex@denx.de>,u-boot@lists.denx.de
Subject: [PATCH 4/5] arm64: dts: imx8mp: Drop i.MX8MP DHCOM rev.100 PHY
 address workaround from PDK3 DT
In-reply-to: <20230921184420.45186-4-marex@denx.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016164624.3B43486F0F@phobos.denx.de>
Date: Mon, 16 Oct 2023 18:46:08 +0200 (CEST)
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

> In case the i.MX8MP DHCOM rev.100 has been populated on the PDK3
> carrier board, the on-SoM PHY PHYAD1 signal has been pulled high
> by the carrier board and changed the PHY MDIO address from 5 to 7.
> This has been fixed on production rev.200 SoM by additional buffer
> on the SoM PHYAD/LED signals, remove the workaround.
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

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606BFC47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 13:12:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1B0A87B66;
	Thu, 11 Jan 2024 14:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="LzAQZfsP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4678287A99; Thu, 11 Jan 2024 13:56:32 +0100 (CET)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA1FE87AD3
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 13:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yA1tuoCF952dfrNi2bW6rjcOShH5944h9LWXpWuY/nk=; b=LzAQZfsPHkjMFP02VojeKR5F6L
 SRtJOGNchZEHYb0HMW2YnHZCrwm1OYc4Lf/v5/TXz9SKyjxr3UJNEdEByJVOO4IR8++ZoDLCeCPI5
 p+W3kcFctPwVYYRCqD4Dm+tM135cSwNjEbqOMGm1XWPI1ayEgqQi9hf7z5tM9OZIL/dpYZrG+2NzK
 HZES5fFTOyHJ402qHj0BpZlR7vihSlb64VZ5rbG6WTHh9/O29Invb9f/UzyIIxjfYsl/043zF9rcR
 XN/+mydn8A0voSlFPtjrka7VIIbQlYRUuGmXSvMmaE6tf21uRBONdi/OVNjlcnMUkg0wPgEFcoH0N
 eYmTPLZQ==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:36540
 helo=localhost.localdomain)
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1rNubi-00BMKF-1H;
 Thu, 11 Jan 2024 13:56:26 +0100
From: Primoz Fiser <primoz.fiser@norik.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	PHYTEC upstream <upstream@lists.phytec.de>
Subject: [PATCH 0/1] i.MX9 thermal trip fixups
Date: Thu, 11 Jan 2024 13:56:24 +0100
Message-Id: <20240111125625.2815180-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Mailman-Approved-At: Thu, 11 Jan 2024 14:08:34 +0100
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

With recent introduction of i.MX93 silicone revision A1, the thermal
grade fuses are properly set for the different CPU temperature grades
(e.g. Industrial or Automotive grade).

Thus read thermal trips from fuses and fixup Linux device-tree temp
trips accordingly to the CPU temp grade.

BR,
Primoz

Primoz Fiser (1):
  imx: imx9: fixup thermal trips from fuses

 arch/arm/mach-imx/imx9/soc.c | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

-- 
2.25.1


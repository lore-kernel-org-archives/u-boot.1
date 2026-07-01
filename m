Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2521C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 09:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 188C284B20;
	Wed,  1 Jul 2026 11:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="poQx8NA3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEE9784B5D; Wed,  1 Jul 2026 11:11:31 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B908E84AE9
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 11:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=+2ZA7dRfBb6ZaUFiNY34rMrhQYY7ORSD6QbzBYGaUNg=; b=poQx8NA3DkQqEZNT5L1XkbsGuG
 F2OXnyNVEUR7qoY+eR9d4u++BVvS+7CSnSyqgETDGRxaVkBD/Q31Xc6UJTpuRbvGwUW/oiWoIqYK/
 ztLmynv4LTNE840C8uG0QePixWAZNoudrYiJ6do8jNRJ5z+8HBVmSPi57/YbO2OUzjbUSyGwO5M+B
 gVgE/P+9bR2uaTbKR0J+kru7nnIJ97ocOBq+kf4SXf4/cr6r5b1hsBaxnctqBxXo1DMJQSKjqPLr8
 jtJab9iJol2KJ4tfnnNvKLyic1OvLMQIaM9fqren+hvAkCjdWtdhZ+RG4I1VF56WsfwgpnSBjtjgF
 zcdopXeQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1weqye-000A4Q-1z; Wed, 01 Jul 2026 11:11:28 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1weqyf-0007Md-09; Wed, 01 Jul 2026 11:11:28 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de
Subject: [PATCH 0/4] TQMa6UL: read module data from EEPROM
Date: Wed,  1 Jul 2026 11:11:15 +0200
Message-ID: <20260701091122.1479350-1-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Reading TQMa6UL module data from the module EEPROM
using the tq-EEPROM-sysinfo driver.

Max Merchel (4):
  sysinfo: tq_eeprom: select NVMEM
  arm: dts: tqma6ul: add eeprom nvmem-layout
  arm: dts: tqma6ul: integrate tq,eeprom sysinfo driver
  boards: tqma6ul: select TQ_COMMON_SYSINFO

 arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi | 18 ++++++++++++++++++
 arch/arm/mach-imx/mx6/Kconfig                  |  1 +
 drivers/sysinfo/Kconfig                        |  1 +
 3 files changed, 20 insertions(+)


base-commit: 298d44464dc63a4f3f5489150acd7958f359f9bd
-- 
2.43.0


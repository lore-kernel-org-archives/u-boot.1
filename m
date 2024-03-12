Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C713C54E66
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 09:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1CAA87F56;
	Tue, 12 Mar 2024 10:00:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Tp9QOq3A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A73B687DE6; Tue, 12 Mar 2024 10:00:11 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7382787F10
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 10:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710234007; x=1712826007;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LrKLYBpT5WWvjnaJaXfH2VhkmaLVCgL4JqaQg7kwqyY=;
 b=Tp9QOq3AzmvIku/q8meatATZ1degscOEzOGiqMGOOz17BTiSUBgRZcxtLdzbvHzd
 /ZC3w0bHIvhvf2c+M9Qk9VFl4GYxoJDPQGx4wfN/5Ugay8hvQPuhl8najVuTNmgb
 wui6OPhd62xbzuegtMPaWHUKXhoHzKSi6qXMxhcvivE=;
X-AuditID: ac14000a-fbefe7000000290d-fc-65f019979dcd
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 64.97.10509.79910F56;
 Tue, 12 Mar 2024 10:00:07 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 12 Mar
 2024 10:00:07 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <trini@konsulko.com>, <t.remmet@phytec.de>, <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH v2 3/5] configs: phycore-imx8mp_defconfig: Use redundant
 environment
Date: Tue, 12 Mar 2024 09:59:55 +0100
Message-ID: <20240312085957.902398-4-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240312085957.902398-1-l.anderweit@phytec.de>
References: <20240312085957.902398-1-l.anderweit@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWyRpKBR3e65IdUg8fLxC0eXvW3mDppM7vF
 272d7Bbd79QdWDx2zrrL7vHqwCp2j7N3djB69He3sAawRHHZpKTmZJalFunbJXBl3Hyxm6Wg
 kb1i6sdWtgbGGWxdjJwcEgImEgv3r2ftYuTiEBJYzCSxt/c8I4TzmFHi+qZnrCBVbAL6Eitf
 LmIBsUUEXCR+Ld0DZHNwMAuYSUz4nAxiCguESMyfZAtisgioShw5JghSzCtgLXH82g5miFXy
 EjMvfWcHKeEUsJFYPdERxBQCKjl6IwqiWlDi5MwnYGuYgaqbt85mhrAlJA6+eAFmCwkoSdw5
 9YsNZuK0c6+hpodKHNm0mmkCo9AsJKNmIRk1C8moBYzMqxiFcjOTs1OLMrP1CjIqS1KT9VJS
 NzGCgluEgWsHY98cj0OMTByMhxglOJiVRHhf67xNFeJNSaysSi3Kjy8qzUktPsQozcGiJM67
 uiM4VUggPbEkNTs1tSC1CCbLxMEp1cDYmPiWqWTmvP87shhijtnqay7imh/e+aHwfVphpZf/
 jGV/zpzaPzfjbrjxw55Np01jIyM3dk80fGK5L7Tlad969cvnZP/UqUpwcRdLPzsxv/qtV6XS
 3AT/brFvtS+sj989u+rjll9GNWL1N858zGf07u5WuqSd+fdI/+RE3r8yMyx5rO1P1L5XYinO
 SDTUYi4qTgQABossQVwCAAA=
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

Add support for the redundant environment.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
 configs/phycore-imx8mp_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index fd492eba3c10..6c67f14b5559 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -19,6 +19,7 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK=0x960000
 CONFIG_SPL=y
+CONFIG_ENV_OFFSET_REDUND=0x3e0000
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
 CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_FIT=y
@@ -77,6 +78,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-- 
2.25.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF61C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 23:04:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE3538909C;
	Fri, 26 Apr 2024 01:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714086220;
	bh=ryzjauw8QZpjUei/CAxyZrr5PIqB58VPgTf1WGJm30Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=grGiRAPuA7sCoiDftcfyKvVsheDgJFpySjJm28XT1UC+CJUXdq7dwYHhvjcdxUNVu
	 5J24Vp5Ib2MYRZawQADYcTLTw46MXALNzPAHdEznCOn0EzS9IcfxUCpXy8R7wEJ95Z
	 6o0xrxSoEDb9AwEN70Cpy/woW6GBCnbVwG4tO4wxd7Y3Iw5YLjLyCGW22Nk3O+7jjq
	 zXjHe+vpNdMaaYO1hq7rwo5Ko1WoJpI12AUj03V8qKq/2WG3bvS517m3ATTRH2HNO/
	 oyA3Xjau+Sg6kg9UZaYuyg/xXtSlMRmedr6TQSCKloLGrHPwjvoNePk02aikn0LUSR
	 IcTAmkbODt3rQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3677189081;
 Fri, 26 Apr 2024 01:03:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714086219;
 bh=ryzjauw8QZpjUei/CAxyZrr5PIqB58VPgTf1WGJm30Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ApIrP4l+ZKfJDVEpu2SJmo02WNl9MbnSlWu5npD1zZxV9Yy8asQFNfrnXKdxz6ymr
 nyR7qhcQ3Hzq6psgmrR5pf9/juhadwoVWyiQtg6XwJhqC6o035BPlyIYQJLINXZgFy
 +/VjwgAj8Hionz5M6NXRZJkxe/aEILZfv+chnPC4okynlsjJIgs1mGdA5qyUCP0jME
 3v7MONk5LI1NeQMRrpeiASQ+bmOY0hM8CFP01jtG3sepkeEBWawTqk00J8GSxkdUVN
 xviM/mRwUbz6N6qoACwC16burDqP9ifMPN3eMoF59krQ+xou0rIeHHx9ooXCAPfRTf
 LOmLGeWzvce0g==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Angelo Dureghello <angelo@kernel-space.org>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] crypto/fsl: Differentiate between CAAM and DCP in Kconfig
 entry
Date: Fri, 26 Apr 2024 01:02:09 +0200
Message-ID: <20240425230314.497203-3-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240425230314.497203-1-marex@denx.de>
References: <20240425230314.497203-1-marex@denx.de>
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

Differentiate between "Enable Random Number Generator support" and
"Enable Random Number Generator support" in Kconfig entry, mark the
first as CAAM and the second as DCP, otherwise users cannot easily
decide which of the options is which and enable the correct one.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Angelo Dureghello <angelo@kernel-space.org>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Gaurav Jain <gaurav.jain@nxp.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/crypto/fsl/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/fsl/Kconfig b/drivers/crypto/fsl/Kconfig
index 9f58731bb67..9ed56632fcd 100644
--- a/drivers/crypto/fsl/Kconfig
+++ b/drivers/crypto/fsl/Kconfig
@@ -69,7 +69,7 @@ config FSL_CAAM_JR_NTZ_ACCESS
 	  driver is used.
 
 config FSL_CAAM_RNG
-	bool "Enable Random Number Generator support"
+	bool "Enable CAAM Random Number Generator support"
 	depends on DM_RNG
 	default y
 	help
@@ -88,7 +88,7 @@ config SPL_FSL_CAAM_RNG
 endif
 
 config FSL_DCP_RNG
-	bool "Enable Random Number Generator support"
+	bool "Enable DCP Random Number Generator support"
 	depends on DM_RNG
 	help
 	  Enable support for the hardware based random number generator
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D961C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A320F8821D;
	Fri, 22 Mar 2024 12:43:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711107820;
	bh=Ap7wF8V9fIlvJoLnngdGeMb4HnAYX13TVmv+N3zOWZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LZX9KutqoFQ4D5HmgmZg7lhIIpSWVg38m9BVRo7fy/34/Uq8MAEM1ViYt3Gn7U6hZ
	 UCrJCaF7G1ZfQC+7fwA2ihH3ZFl99PN3S1ld0w444ItDioVeGqvQyI6mHeOfV9lJY7
	 Q8u2/eUI+blSoNMDNV+FB1yCpswswzA+ImCWe4N63NT4vOTJdcQd/qv5KSi2IuxSq0
	 4fTjtaIm83iAdFomOI2JbMDXdvD4jHoOe4Kl6hRqn9CaOT6jQO/wEwbTPKEUTDzMk1
	 svEgSCkqNTCDR03R3VYhGey0Viv5mpevW4Q5Yaw0fhY4g7cxlgZ9PL5tC134Y/hJbY
	 faIqAYKMotWKg==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AECB5881EA;
 Fri, 22 Mar 2024 12:43:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711107816;
 bh=Ap7wF8V9fIlvJoLnngdGeMb4HnAYX13TVmv+N3zOWZU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=B+Nt2spGFCVQIeFDKsDzA+8rW/wC6C0bvstRMeosb82YX2h4HrVKRyQeUt0VlgXtD
 sQ3KhoZrqR4lDi/J/RI6S+8lq5XeqTYW4pIXwtDIBXuDqeaM60sLL04bxn3nvHygUK
 fWSdmPr7Te8PpI7GlMvvL8Y5KNliyib0H0uet7QIBuAWsX2k6RDArJx7qrVk9U7LFD
 HlG254Ff3ssKFZMJu86KHnF+TFUGitxRu8ZewK+CwieBDmOlKEIY2IRYaDOseSsRHt
 wpKo53kaunr1mo9nPDTrbZftjdFbfQREqOWrRCgqW/b557LmW33+vtvqObfqQE48Gk
 0NLlXElQNlk6w==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>,
	u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/12] dts: xea: Remove outdated comment
Date: Fri, 22 Mar 2024 12:43:08 +0100
Message-Id: <20240322114315.2720727-6-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240322114315.2720727-1-lukma@denx.de>
References: <20240322114315.2720727-1-lukma@denx.de>
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

The comment in u-boot specific adjustment to XEA DTS is not valid anymore.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---

 arch/arm/dts/imx28-xea-1-u-boot.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/dts/imx28-xea-1-u-boot.dtsi b/arch/arm/dts/imx28-xea-1-u-boot.dtsi
index 2903be2089..6cb6c66924 100644
--- a/arch/arm/dts/imx28-xea-1-u-boot.dtsi
+++ b/arch/arm/dts/imx28-xea-1-u-boot.dtsi
@@ -4,10 +4,6 @@
  * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
  */
 
-/*
- * The minimal augmentation DTS U-Boot file to allow eMMC driver
- * configuration in SPL for falcon boot.
- */
 #include "imx28-xea-u-boot.dtsi"
 
 &mac0 {
-- 
2.39.2


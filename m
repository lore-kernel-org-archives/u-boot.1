Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296A4C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 20:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC16B81F4E;
	Fri, 14 Mar 2025 21:09:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=os-cillation.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=os-cillation.de header.i=@os-cillation.de header.b="h7bfCF8C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DE8381F49; Fri, 14 Mar 2025 21:09:09 +0100 (CET)
Received: from os-cillation.de (mx.os-c.de [213.165.83.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C67F81E92
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 21:09:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=os-cillation.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hd@os-cillation.de
Received: from core2024.osc.gmbh (p578a635d.dip0.t-ipconnect.de [87.138.99.93])
 by os-cillation.de (Postfix) with ESMTPSA id 04F40C026E
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 21:09:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=os-cillation.de;
 s=202409; t=1741982945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UTkx11zlMPyMP9Q8GD+9wA+a4io7r8fo02KbPDEJnNQ=;
 b=h7bfCF8CFtRvw2/x9/vJiZe4Kp7ezP0UOGN6VBcRoUgbKYhCesjrF62efv4xn+RdcDjbdd
 oSLFuiCoGQNxflz8+zxYe9OcK8bxQJVG4AveLvQD7H+Y61WD5iFULvWN1rl+Voa3guIU/p
 1MK8ZZxX2CKmiv9UidP5M5wKT687wm4HiYghhnIy7dJ+wWrBin/cY82MH9rYnxum0OqJOy
 7rVGO/zx2ThYB9uYWyiZHQfmfEIZREFTIAmyT6ECT7szdltHmMe0BkScgtmJ+TymTt9snh
 QC9Rrecw24320ltRnd2r7ehGJ1m/jxoMtv6RnjM50n9TKTTlw19gXlkP6lCMbg==
Authentication-Results: os-cillation.de;
 auth=pass smtp.auth=os-c@schweissgut.net smtp.mailfrom=hd@os-cillation.de
Received: from hd2022.osc.gmbh (hd2022.osc.gmbh [192.168.3.45])
 by core2024.osc.gmbh (Postfix) with ESMTPSA id 7BC2720032D;
 Fri, 14 Mar 2025 21:09:04 +0100 (CET)
From: Hendrik Donner <hd@os-cillation.de>
To: u-boot@lists.denx.de
Cc: Hendrik Donner <hd@os-cillation.de>
Subject: [PATCH 0/2] Do not use CONFIG_XPL_BUILD in device tree
Date: Fri, 14 Mar 2025 21:08:30 +0100
Message-ID: <20250314200832.154758-1-hd@os-cillation.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2849ff05-ef67-4471-aece-422daa57040f@cherry.de>
References: <2849ff05-ef67-4471-aece-422daa57040f@cherry.de>
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

As discussed on the mailing list, move instances of CONFIG_XPL_BUILD
back to the initially used CONFIG_SPL in device trees.

Hendrik Donner (2):
  imx8qxp: Do not use CONFIG_XPL_BUILD in device tree
  imx8qm: Do not use CONFIG_XPL_BUILD in device tree

 arch/arm/dts/imx8qm-u-boot.dtsi  | 4 +++-
 arch/arm/dts/imx8qxp-u-boot.dtsi | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C469BC282E5
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 18:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFB5180E94;
	Wed,  5 Mar 2025 19:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=os-cillation.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=os-cillation.de header.i=@os-cillation.de header.b="XRYQSFr6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7F4480ECC; Wed,  5 Mar 2025 19:37:01 +0100 (CET)
Received: from os-cillation.de (mx.os-c.de [213.165.83.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99AC880BAA
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 19:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=os-cillation.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hd@os-cillation.de
Received: from core2024.osc.gmbh (p578a635d.dip0.t-ipconnect.de [87.138.99.93])
 by os-cillation.de (Postfix) with ESMTPSA id 53474C023B
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 19:36:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=os-cillation.de;
 s=202409; t=1741199819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=P2cJIxCTMbamsk/xgJzjR9BGjX/aJFL3NerY6oAfMCA=;
 b=XRYQSFr6aSyhHVFBEU2oiaxiq4iQHJPiXNhC6g+3qtWh02XmtR5G0vmWep7oNGwDkoR9ON
 q9u0mQrmhijm6ctm5p8BRMHN4dfcpGrVG/00Ns+Dpc7lZuFfxb+8rsTewQHa9SV6OYtCzx
 ouGdG+oGdRx5XlkU4qJzjP3bad4JgyyVTzkHoILo+bwp7uhXvpaboLJuhxvfZJ1G/3fdTm
 uHA7eW2AQiqxqmI4yI/9yh3BL+iTGJ1E26WXYXZZcObRKS5o/KM047zMcDhVWTDZiDIcGx
 kSAdSmWYNpNjb/ysATPc+PIEBqVCip1aFMkKjJOGKGEnLRHtjLJUWQICbUQQag==
Authentication-Results: os-cillation.de;
 auth=pass smtp.auth=os-c@schweissgut.net smtp.mailfrom=hd@os-cillation.de
Received: from hd2022.osc.gmbh (hd2022.osc.gmbh [192.168.3.45])
 by core2024.osc.gmbh (Postfix) with ESMTPSA id DCD78200059;
 Wed,  5 Mar 2025 19:36:58 +0100 (CET)
From: Hendrik Donner <hd@os-cillation.de>
To: u-boot@lists.denx.de
Cc: Hendrik Donner <hd@os-cillation.de>
Subject: [PATCH 0/2] Build fixes for CONFIG_XPL_BUILD in dts files
Date: Wed,  5 Mar 2025 19:35:41 +0100
Message-ID: <20250305183544.40525-1-hd@os-cillation.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Mar 2025 19:54:15 +0100
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

Just 2 fixes related to CONFIG_XPL_BUILD usage in dts files with binman.
The second patch works for me, not sure if it is exactly the correct
approach.

Hendrik Donner (2):
  imx8qm: Fix build when using SPL
  Makefile.lib: Set xPL build related defines for DTB build

 arch/arm/dts/imx8qm-u-boot.dtsi |  2 ++
 scripts/Makefile.lib            | 10 ++++++++++
 2 files changed, 12 insertions(+)

-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FDAC77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 20:47:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1854C803CC;
	Tue, 24 Jun 2025 22:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1750798046;
	bh=f1EiU5cJcageFDzPDkXwDBKhctQF8z+/ZgXEldXfPC0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=t61+0Qs2/qTorCnY8eSWFBoZQ2MmCJZspvqf5A+IC9GYYBkDK3ZtIbBnb1S+aaOFy
	 SgV+g1iAQAnMd+DHAT7HQBt5JfPxITxfzKam57qUqP/jdwxj6mdozMjYiGiUNrQOHi
	 VNDSiVeytsfIftF+X5QS57a22CZuDaBGZt4h7RPX2Okf5mWQZHiuoE7L/mGWs3VWDc
	 18YL6UMLuJjIAIUkJVTpszGAfwksdqXSEgQDoJ+jxwt+TyAFPwHydjLhGE58+PHVS+
	 CSaYwTYalntO3HZxA73RsilQrWiAWw1364gcwANW6nEHmWcALzEDSPT8UkcqWxLYrm
	 VOPX5Xkl7/Z5w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9036582D5E; Tue, 24 Jun 2025 22:47:24 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8B638006D
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 22:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lukma@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="MQIHO/ai"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 679D8102779C2; 
 Tue, 24 Jun 2025 22:47:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1750798041; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=f1EiU5cJcageFDzPDkXwDBKhctQF8z+/ZgXEldXfPC0=;
 b=MQIHO/aium4ic89MMounZCoewpgIzEKEXZ4QurnmZ+dpAO0iLSKgsFvxz0J9W2aNLQNTiN
 djFcIhNDDoIxQoaLOXPsoAt5WnHayAbrvqkTh/ijvAliVMvIsxsT3k1SEIK8ghliyu3anY
 wU/ZLTAO3YfJfzh0oLKaIVtd1DDnKSGvvmYxIjmd6FqQ6qplu+xMy/UeS/WW4evk+jskVj
 edlVsq9BPXFGxqnTE6V1zjbgEwWPNQQD3VK7nsAO6gWaxGCqoJPXB1mG3uMZiztcyP82XC
 JXcbYGw+grkKMdGOzmW0GDPlTheCR9XYz5Bkos0ot1dUPCCfi9rmpLHV+o5F+A==
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 Tom Rini <trini@konsulko.com>, albert.aribaud@3adev.fr,
 u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 1/2] config: nxp: bk4: Increase size of
 CONFIG_SYS_MALLOC_F_LEN (to 0x1000)
Date: Tue, 24 Jun 2025 22:46:59 +0200
Message-Id: <20250624204700.972663-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The commit c69103218ee4 ("i2c: mxc_i2c: add DM_FLAG_PRE_RELOC flag")
has enabled by default the i2c initialization in the pre-relocation
phase.
It turned out that vf610 based BK4 board had too small SYS_MALLOC_F_LEN
pool size.

After increasing it to 0x1000 the board boots again.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 configs/bk4r1_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/bk4r1_defconfig b/configs/bk4r1_defconfig
index 3ed587a1060..8bff1653859 100644
--- a/configs/bk4r1_defconfig
+++ b/configs/bk4r1_defconfig
@@ -4,7 +4,7 @@ CONFIG_SYS_THUMB_BUILD=y
 CONFIG_ARCH_VF610=y
 CONFIG_TEXT_BASE=0x3f401000
 CONFIG_SYS_MALLOC_LEN=0x402000
-CONFIG_SYS_MALLOC_F_LEN=0x800
+CONFIG_SYS_MALLOC_F_LEN=0x1000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x200000
-- 
2.39.5


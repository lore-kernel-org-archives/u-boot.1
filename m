Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67755C47073
	for <u-boot@archiver.kernel.org>; Sun,  7 Jan 2024 08:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2393E87A09;
	Sun,  7 Jan 2024 09:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SDh1xPuo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA5F287A0A; Sun,  7 Jan 2024 09:27:18 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7DBF87A08
 for <u-boot@lists.denx.de>; Sun,  7 Jan 2024 09:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 075B73FAF3; 
 Sun,  7 Jan 2024 08:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704616036;
 bh=hOdWL1YcXl2IOmivoLBfwTgGReeDsmGSBjHYGMO1uu0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=SDh1xPuoXDLsJ2BPWaPvaC5WzFcUmRJpzRFLmWkbuASpzLtAI7txzyi+uN7Zj7kkQ
 6m0tXxBKGOrosSmcDWZKtxP/qmMeRbY3H0n2WxvAtuNr/Ow7dBR6Azw2TNy71ieLBR
 GS6wZSG0dIkmr0u0U+QHjNcpXE7BUg2dMVe3q2UiLVguTkxQw/cWJ2hvxbZKxzRGWo
 WY9fH+uvKbz+NlayjYKJrXVsiAmqi3nMN9oW+1bzc1y9siH/Xsv2g0bRx1aHZtXZE2
 Mwey575+UYd6HbJ+lIQHXViDSPrghWDL1BP5t2OAyejWSSsdip/U7Sd9nkGKkBfK4D
 6cvUEr1vwHTkw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] sandbox: missing return value checks in eth-raw-os
Date: Sun,  7 Jan 2024 09:27:12 +0100
Message-ID: <20240107082713.41539-1-heinrich.schuchardt@canonical.com>
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

We should check the return value of fcntl().

Addresses-Coverity-ID: 131108 ("Unchecked return value from library")
Addresses-Coverity-ID: 131109 ("Unchecked return value from library")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/sandbox/cpu/eth-raw-os.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/cpu/eth-raw-os.c b/arch/sandbox/cpu/eth-raw-os.c
index e59b96be5f..4ef2af0c36 100644
--- a/arch/sandbox/cpu/eth-raw-os.c
+++ b/arch/sandbox/cpu/eth-raw-os.c
@@ -105,7 +105,12 @@ static int _raw_packet_start(struct eth_sandbox_raw_priv *priv,
 
 	/* Make the socket non-blocking */
 	flags = fcntl(priv->sd, F_GETFL, 0);
-	fcntl(priv->sd, F_SETFL, flags | O_NONBLOCK);
+	ret = fcntl(priv->sd, F_SETFL, flags | O_NONBLOCK);
+	if (ret == -1) {
+		printf("Failed to make socket non-blocking: %d %s\n", errno,
+		       strerror(errno));
+		return -errno;
+	}
 
 	/* Enable promiscuous mode to receive responses meant for us */
 	mr.mr_ifindex = device->sll_ifindex;
@@ -172,7 +177,12 @@ static int _local_inet_start(struct eth_sandbox_raw_priv *priv)
 
 	/* Make the socket non-blocking */
 	flags = fcntl(priv->sd, F_GETFL, 0);
-	fcntl(priv->sd, F_SETFL, flags | O_NONBLOCK);
+	ret = fcntl(priv->sd, F_SETFL, flags | O_NONBLOCK);
+	if (ret == -1) {
+		printf("Failed to make socket non-blocking: %d %s\n", errno,
+		       strerror(errno));
+		return -errno;
+	}
 
 	/* Include the UDP/IP headers on send and receive */
 	ret = setsockopt(priv->sd, IPPROTO_IP, IP_HDRINCL, &one,
-- 
2.43.0


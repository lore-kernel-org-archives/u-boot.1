Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E4AE909D3
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 16:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88E5883E36;
	Tue, 17 Feb 2026 17:39:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="IOCUiWqc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C686683D0F; Tue, 17 Feb 2026 17:39:21 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E6D983D77
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 17:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 778791109FF; Tue, 17 Feb 2026 17:39:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771346358; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=W0BpR465/LD6BWeckRAm8afLxeL9MyMTtIZlM4OaPQE=;
 b=IOCUiWqcggNU/o7TXslZg3aDs+V0HjZFyT/Evt7WQ1bYTMDWAJ6OI9i6LmYAVpsfUTiy5S
 SOSwg6X1nVRRqSpmWtl7IQd/mt2muw9bpDMp9KG74VtyAvOhGA4GJzJ5tmyrx8WPpj+paM
 ljb5PS37v8ZIQWczDnl308yZ7ylXNsE1ekGqb1b6/qchjJcO61J0vR5/bMF+4NpPJrSEWG
 PouOYiRqqoY2SU8+Y6ypKd+O6wztdN+aW5Z7McidwaKqWJvxrykiILYzieAI0UnYeq8vWv
 nm5Q5cgrrTgSITLd/VM1/+8TtrMuJ0KX8OZfxn+W5Z41u5hkCzZd4SCLHVFmEg==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 05/11] imx8qxp_capricorn config: add wget command
Date: Tue, 17 Feb 2026 17:39:05 +0100
Message-Id: <20260217163911.31878-6-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260217163911.31878-1-hs@nabladev.com>
References: <20260217163911.31878-1-hs@nabladev.com>
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

From: Walter Schweizer <walter.schweizer@siemens.com>

Enable the "wget" command to allow download using TCP / HTTP protocol.
This is faster than TFTP download.

Signed-off-by: Walter Schweizer <walter.schweizer@siemens.com>
Reviewed-by: Heiko Schocher <hs@nabladev.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>

---

Changes in v3:
Improve the commit message as Marek suggested.

Changes in v2:
Added Reviewed-by from Peng

 configs/imx8qxp_capricorn.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx8qxp_capricorn.config b/configs/imx8qxp_capricorn.config
index 62babf2626f..b5c9fdbc9b3 100644
--- a/configs/imx8qxp_capricorn.config
+++ b/configs/imx8qxp_capricorn.config
@@ -73,6 +73,7 @@ CONFIG_CMD_CPU=y
 # CONFIG_CMD_CRC32 is not set
 # CONFIG_CMD_BIND is not set
 CONFIG_CMD_WDT=y
+CONFIG_CMD_WGET=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_DM=y
 CONFIG_CMD_FUSE=y
-- 
2.20.1


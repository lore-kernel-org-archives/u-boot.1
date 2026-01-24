Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5466ED715C7
	for <u-boot@archiver.kernel.org>; Sat, 24 Jan 2026 05:56:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0319683C67;
	Sat, 24 Jan 2026 06:55:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="GyZ3W597";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8511283C19; Sat, 24 Jan 2026 06:55:10 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BB3B83B91
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 06:55:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4F06010F17A; Sat, 24 Jan 2026 06:55:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1769234102; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=kurCJgzOpx20WA+/KdPMO5FCnXoBWismbJ50q4Puifs=;
 b=GyZ3W597IpZHCG22uTKEozbMqBPbnd/AAjTJwTgH8b2knTLm/5nQ+9whhHvY30PhsjbmOO
 vB3ZLhtdirlQgXkShTvkgA+qbdS0ocjlknQTB9kAGYwDGLkdyfA4SkAleS/sL7stWDVi2Y
 V9x/y2rg72eSYBoEjGg+KyiNH2cc+3DReK8V9NBIAGZvWDUxbMpECVEWD3Ykb6nHAFO+lg
 sF37pzI2QMrqs7VFG3JfcTtvr2aKKj66amJ5Eabv1l2Et/Vsi8ZMoTmbe+ZlSfMC8tdgV3
 R2TlAMdorku4CoOdOQiDWesXV0OB4dg8rbTW5nwFOE3z7gI6pISOrmYA0DTdbA==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: [PATCH v1 06/11] capricorn: config: add bootcounter command
Date: Sat, 24 Jan 2026 06:54:47 +0100
Message-Id: <20260124055452.8799-7-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260124055452.8799-1-hs@nabladev.com>
References: <20260124055452.8799-1-hs@nabladev.com>
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

enable
CONFIG_CMD_BOOTCOUNT=y

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

 configs/imx8qxp_capricorn.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx8qxp_capricorn.config b/configs/imx8qxp_capricorn.config
index b5c9fdbc9b3..626634cb09c 100644
--- a/configs/imx8qxp_capricorn.config
+++ b/configs/imx8qxp_capricorn.config
@@ -74,6 +74,7 @@ CONFIG_CMD_CPU=y
 # CONFIG_CMD_BIND is not set
 CONFIG_CMD_WDT=y
 CONFIG_CMD_WGET=y
+CONFIG_CMD_BOOTCOUNT=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_DM=y
 CONFIG_CMD_FUSE=y
-- 
2.20.1


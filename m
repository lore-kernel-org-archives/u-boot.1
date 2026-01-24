Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B83AD715CA
	for <u-boot@archiver.kernel.org>; Sat, 24 Jan 2026 05:55:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0DEE83C02;
	Sat, 24 Jan 2026 06:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="h85yxn1U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D15683C08; Sat, 24 Jan 2026 06:55:05 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50EC583BE1
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 06:55:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5057C10F25C; Sat, 24 Jan 2026 06:55:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1769234101; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=jiJRmgfQfOsHL54dcoDZOQQ7+fBkYeyJgefUktycN6s=;
 b=h85yxn1UgxjREX5WDfSr181+QByS6B+G2v6oHAon2SYOooZ29gD8bvKLqSiKz2WVlV3DVm
 9Wr7ln4XsRIgMfLFdgj5ect7sh4Xwff7vvJjfj4nOa2t7oJZCtpIfuv8a7gsk3H+MMcRnc
 9O9Mxnc2lnaa0o/mAurxJIafJZ9X93S+F5yexybqHmjstLQqzE0yJr3BW3yN1O91lHlRj9
 RXhWn52pprLTWCB7pMQ1MMI9s2OoZ9XBhmfQ4xtzvnJmleE62MB7aqLlJDXzxjelQjPjtM
 NkPVNcCfawnWAiw6r7MA1NgIUgddn3VLh41MGqpiOUqUrhFaVd71jmMlVes3Ig==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Tomas Peterka <atheiste@seznam.cz>
Subject: [PATCH v1 05/11] imx8qxp_capricorn config: add wget command
Date: Sat, 24 Jan 2026 06:54:46 +0100
Message-Id: <20260124055452.8799-6-hs@nabladev.com>
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

From: Walter Schweizer <walter.schweizer@siemens.com>

Faster than tftp.

Signed-off-by: Walter Schweizer <walter.schweizer@siemens.com>
Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

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


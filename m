Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891ADEF99E1
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 04:58:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6243283E72;
	Sat, 14 Feb 2026 05:57:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="Xqai/ZG9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E275B83E83; Sat, 14 Feb 2026 05:57:15 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1518B83DC9
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 05:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 470A91101EB; Sat, 14 Feb 2026 05:57:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771045033; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=kWc0EmrP3+19JhxYtZA8XnPlYHkhtp44YTl7m6oq5t8=;
 b=Xqai/ZG9AwYQMG1FmQD9GOxudaEIaZaDVn0OQnnajR8PiF+G215iTwkWQW4p/+7Rx2tiRw
 IRwe6ODROJiUMEyUe7ZlEoRwkTHCjWUM41Yzi0OjDlO0QBRpk9qhA4EgKoyA3YHY5Igz/b
 yvt7GFXJy/FzFdyY3Z7aB7PpFu/eqI8cWDjCumWrQYUAWEvkff0+/mm9R3cxA2/CTzaTTF
 l9aZFWBnsp/rFt1WCgGiTgMNfUplMAIIRd7WTu8gtGX8/UXSZr+Q5YO7j12MJX1yAeckzQ
 S5pSBawyVy1PtIUbzFL7bVFDDiAbeeriQWcs+5WHEP2Ojfljl5kHTfUYXpD4tw==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Heiko Schocher <hs@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: [PATCH v2 06/11] capricorn: config: add bootcounter command
Date: Sat, 14 Feb 2026 05:56:58 +0100
Message-Id: <20260214045703.28051-7-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260214045703.28051-1-hs@nabladev.com>
References: <20260214045703.28051-1-hs@nabladev.com>
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

Enable bootcount feature to count the boot times

Signed-off-by: Heiko Schocher <hs@nabladev.com>
Acked-by: Peng Fan <peng.fan@nxp.com>

---

Changes in v2:
Added Reviewed-by from Peng
enhanced commit message

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


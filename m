Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28BBCA0EFA
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 13:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E65B883102;
	Mon, 25 Aug 2025 15:55:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="ctJalhkH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA62C83093; Mon, 25 Aug 2025 15:55:50 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5476831BE
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:55:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0D13AC994F; Mon, 25 Aug 2025 15:55:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1756130148; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=WbJ4thc5m7Yy/4QdyIaMNlSziJ+dQiBlndQCifoGRmE=;
 b=ctJalhkH6rAA7rW3sqAkngkQ9Bkpu/trDWhgemtKDPcsfe2VziDgF9OXLfOvPE9au+MkqD
 Oe4jkQax1mWBsYuyfiqin02n8xoasEJuDnWf3jMTWuoQ0Bteb2PK7Gv6ZBhAlM1rRaISfU
 RW4WIEeLew80lJH7TEpwkWgQqY5ugN74b4WBNYgjk8OEyVBZ8wqqS/PXntYFVmPg0wcczF
 gV6HSGHSX+zjNfrTu37F1Ro1M+dhunGTny7z1xYCxLxGhbIUvJAVnqpbh7yJC8cGK7YVma
 lY0svcqVeLqKjaTNNu9x17AXl+ojqolohhFYT991HtlNDAEpembHOpnKlHnniA==
From: Frieder Schrempf <frieder@fris.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Eberhard Stoll <eberhard.stoll@kontron.de>,
 Annette Kobou <annette.kobou@kontron.de>, Marek Vasut <marex@denx.de>,
 Oualid Derouiche <oualid.derouiche@kontron.de>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 09/11] imx: kontron-sl-mx6ul: Enable CONFIG_ENV_IS_NOWHERE
Date: Mon, 25 Aug 2025 15:54:33 +0200
Message-ID: <20250825135504.193004-10-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825135504.193004-1-frieder@fris.de>
References: <20250825135504.193004-1-frieder@fris.de>
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

From: Eberhard Stoll <eberhard.stoll@kontron.de>

For some cases it is beneficial to not store the environment in
persistent memory, but instead use the default environment and
keep it in volatile RAM only. Allow this by enabling
CONFIG_ENV_IS_NOWHERE.

Signed-off-by: Eberhard Stoll <eberhard.stoll@kontron.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 configs/kontron-sl-mx6ul_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/kontron-sl-mx6ul_defconfig b/configs/kontron-sl-mx6ul_defconfig
index fed29e77936..052d7a76610 100644
--- a/configs/kontron-sl-mx6ul_defconfig
+++ b/configs/kontron-sl-mx6ul_defconfig
@@ -64,6 +64,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="imx6ul-kontron-bl imx6ull-kontron-bl"
 CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-- 
2.50.1


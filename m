Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E87CFD313
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 22:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8DD783BF4;
	Sun, 23 Nov 2025 23:58:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="axhoeafn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19FD583BF4; Sun, 23 Nov 2025 23:58:30 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4438383B7E
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 23:58:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4F3FA44974; 
 Sun, 23 Nov 2025 22:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763938684;
 bh=/ZImyBFkTHGZyfTmbl388FXqThNzybE2uc/HLdGosXI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=axhoeafncAqVun/AjvoFOhXByt93SVH0AShEtp+eE/rUKJKFlqeJAZO39avVzx6uU
 4VeK+EgLVMPbfO9BFRwRaBwSU2OrHYe7WIOgaNpasvFrplQVZvbTb3nrmKM4h36sGV
 g/HfRb3lqgLlL0Cq0/9DfXvp4U8AMt+sB2+Aet18dLg3hfo1N8nMTuvK2c6EBA/Wq7
 rvi1uzS9N4kFydzA+QyePNDNtzYcoFfm1UaBQ2U63Qzh2kTNykmVLn/aY6RpC01y8y
 1QB3YZO2SypE7HkGG9u+el7Xp46dYx8tPUfRSS1uyqDAZPbZK+xIOBtDGpKkVFPD6m
 Y86+swgASEV4Hnqgl5uFXJ2oMfyzsiI7/Kawn/OaUhZ+AvNHQABekfykWaFrhWyTVL
 SdKAQe+W3wKNdrQrnsp+BsIYxWMnza2UV11/kccXwTZ2QHZBD5ui+HEp9Q3rBJvFDS
 76ZgXENh2KWue/7IeP/qJPSaSwftnJF9m9JzGmIz5VmJLl6xAlsN0hSyUvFvSjcKjQ
 AbXtdfDEMmrPB1i5v+Dj0k1lKpegUlZH7EHwbskt+RZtMPcQT5kOT7UEgb7CD1M4r2
 D1ClI1SET0DRSRCfzKKSz7c1VXK/Ets6I9pWZ/SPyI5+y5Ze6DbM8FOmmaBNKTIaO+
 VCCAlDYdrUgfKbSFR2W+fuhM=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Paul Burton <paulburton@kernel.org>,
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heiko Schocher <hs@nabladev.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Richard Weinberger <richard@nod.at>,
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 09/19] ppce500: increase SYS_MALLOC_F_LEN to 0x800
Date: Sun, 23 Nov 2025 23:57:01 +0100
Message-ID: <20251123225711.227016-10-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
References: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
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

If CONFIG_CONSOLE_RECORD_INIT_F=y we need additional memory according to
CONFIG_CONSOLE_RECORD_OUT_SIZE_F.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 configs/qemu-ppce500_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu-ppce500_defconfig b/configs/qemu-ppce500_defconfig
index 3e734e57c4a..24999ca705f 100644
--- a/configs/qemu-ppce500_defconfig
+++ b/configs/qemu-ppce500_defconfig
@@ -1,5 +1,6 @@
 CONFIG_PPC=y
 CONFIG_TEXT_BASE=0xf00000
+CONFIG_SYS_MALLOC_F_LEN=0x800
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="qemu-ppce500"
-- 
2.51.0


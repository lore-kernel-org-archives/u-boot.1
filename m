Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288F6C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 21:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F4C3877D9;
	Tue, 12 Dec 2023 22:02:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="n9DckZNB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4E9D86DC3; Tue, 12 Dec 2023 22:02:40 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E293E874D5
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 22:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sjoerd@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1702414955;
 bh=Hphr83/FCr8HRZEjHk78dmQwx/e3dRk15hs+ujGFEFA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=n9DckZNB4pzwYNCg15FrBS3zJfKVEuFpeT87C4b/Sl1iQh2uPRUSu5Z6YUHZlhLVJ
 e3cP/aS4Ep+4qp0pW8iNSDMOJFitY6ZuHyMddAvGESR3qdzP3x2ytH6euxlpa1X+9h
 Y2bvmRO8tVhTraO8X91ZuVbnq5KisMLw1AVyyiFyz8EIDYQZGXbcIkAxo/YcuSN6Ot
 3CyGdXzWkpinRzsMOhrRZiiCI6h4LOYKQBoL1dNtXKg1GsIDyCvWh6qhFev4UhhYIe
 32UJEGydtsHV9xsMhMR3v8IeGBHc6/x93vbp83xEhtcJ+RT/00n8tSP1OCqDiZPZ5H
 bAfAyBi1R4xgA==
Received: from beast.luon.net (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sjoerd)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4610E3781477;
 Tue, 12 Dec 2023 21:02:35 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
 id D060B984A541; Tue, 12 Dec 2023 22:02:34 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
To: u-boot@lists.denx.de
Cc: Nishanth Menon <nm@ti.com>, Martyn Welch <martyn.welch@collabora.com>,
 Dave Gerlach <d-gerlach@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/4] board: ti: am62x: am62x: include env for DFU
Date: Tue, 12 Dec 2023 22:02:22 +0100
Message-ID: <20231212210234.509309-3-sjoerd@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231212210234.509309-1-sjoerd@collabora.com>
References: <20231212210234.509309-1-sjoerd@collabora.com>
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

Include standard TI K3 dfu environment

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

---

Changes in v3:
- Add dfu via environment rather then config headers

Changes in v2:
- Minimize config changes to just DFU configuration

 board/ti/am62x/am62x.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/ti/am62x/am62x.env b/board/ti/am62x/am62x.env
index e53a55c38fb..0651b9cd7cb 100644
--- a/board/ti/am62x/am62x.env
+++ b/board/ti/am62x/am62x.env
@@ -1,6 +1,7 @@
 #include <env/ti/ti_common.env>
 #include <env/ti/default_findfdt.env>
 #include <env/ti/mmc.env>
+#include <env/ti/k3_dfu.env>
 
 name_kern=Image
 console=ttyS2,115200n8
-- 
2.43.0


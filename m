Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10086E677F8
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 10:26:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F44788FEA;
	Sat,  2 Nov 2024 11:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="VtWdJFyk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C14BA8901D; Sat,  2 Nov 2024 11:26:24 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7414E88FC4
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 11:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4E2C03F9D9; 
 Sat,  2 Nov 2024 10:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730543181;
 bh=cfGGlKN2vfxDrL2c5jY4wu3j2RMvPmmE6RedvzcaZUo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=VtWdJFyksbk9qf5OZqo/K9y96uwHoUZrK3fYFOisOX/Llb9AmKq8y/RHrvHNPFt7X
 tAdMxdvpbILjzjF/eERXileAAgjBINWt907Ec1EN9vuwXUOOeXBSvwawREdltcyj+/
 YxTEgWKlceCg8dIclu5C9lar34cBw5ARsWLSD+xII9lKeGfCwIOQaowSqQl0+Yq8zn
 WGnFiIf1ukCJC2I2qYjS0uqQfzlNqsTxD+bqmgH5YjTZl0up7pC3ub0LeSF4+p1oKk
 Wv8KVoJ8D2Ps0JKKlGS5CvPkwuC72OeIFBf+ozNFtg0yMtydEFmWuczkgeG1eL6oLM
 eU8ovIHmQDU1A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] MAINTAINERS: add lib/tpm* to TPM DRIVERS
Date: Sat,  2 Nov 2024 11:25:46 +0100
Message-ID: <20241102102546.107412-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

All TPM code should be maintained.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index df046192ea0..ff115970103 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1690,6 +1690,7 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-tpm.git
 F:	cmd/tpm*
 F:	drivers/tpm/
 F:	include/tpm*
+F:	lib/tpm*
 
 TQ GROUP
 #M:	Martin Krause <martin.krause@tq-systems.de>
-- 
2.45.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA74CD1297
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 10:10:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46B6A83EE2;
	Sun,  9 Nov 2025 11:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pojzW7/a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27BEC83F15; Sun,  9 Nov 2025 11:10:37 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CF2783E8A
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 11:10:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-110-120.46.114.pool.telefonica.de
 [46.114.110.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 98091409EE; 
 Sun,  9 Nov 2025 10:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762683029;
 bh=ykT3MtrMN5Vg2uyeCJjlm2CrwnWMMhBqwxBQnOPtqZQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=pojzW7/aszyc2fbYkyAC3+pIIHBCny2bcOB0yZaSwEsgqYGqUXvUDnOEwHNxqE49N
 mgqxQd+Vf/I5E0AnDm+bHFV8AnimTsZ7jse/kXj+BBJ3i5WwcdxR154ugACLuB+857
 njsPPuocWxZOAVDUEhHpovnEP4rE4HhPiislsze5YLmx1AKG65DWcHZIOunn28Pmkp
 BOUgbURfXlL9k/DJnt3rIrCSz1cE8OVPcU/FWKUagGX5DJkYCZoAGSwWQlrOnt800t
 EYHeIwksMHhMmOlI1WIZyZuruZc4/DbEJpD2pPzrqW6f9HaUfSq4xRVYeOcjPCOEhS
 PqpH2B67o5PV94zN7iCWqVNx87yiBLuhSVbw4r8kZ9GVe4Z6DIKAZcno3eK8LlxVrX
 jDqKrnd+6pQl3S+NmUnflVZ0wKS+FWfr1M8OdmxNrUAfHKzRdKA/009cBONAtZ2IDU
 saB6llacseeqmokTKAvO+dqwoZ+z0ToYr5tDpOsffwow4K0TqvGmw68fjVCO06OKbB
 WejnI2sX23hEtiACa0yn9ycpAyqVDYzsg588lcRFeHPNH7knVTUplFrpuXpdAEv0Xp
 doo748/cUhIaDbxdrIk3a6BFUaCSTewrNeXRejmOKm92l1UI1QMM0LXLNMz171n/eC
 l4XCP7MXsrf5l148CzXhxeYI=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>, Peng Fan <peng.fan@nxp.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/9] test: cmd/bdinfo: make no flash assumption
Date: Sun,  9 Nov 2025 11:10:04 +0100
Message-ID: <20251109101010.306268-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
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

The location and size of flash is device-dependent. Do not make any
assumption about the location and size.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/cmd/bdinfo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 09f44ee41ed..214b237152b 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -161,9 +161,9 @@ static int bdinfo_test_all(struct unit_test_state *uts)
 	ut_assertok(bdinfo_check_mem(uts));
 
 	/* CONFIG_SYS_HAS_SRAM testing not supported */
-	ut_assertok(test_num_l(uts, "flashstart", 0));
-	ut_assertok(test_num_l(uts, "flashsize", 0));
-	ut_assertok(test_num_l(uts, "flashoffset", 0));
+	ut_check_console_linen(uts, "flashstart");
+	ut_check_console_linen(uts, "flashsize");
+	ut_check_console_linen(uts, "flashoffset");
 	ut_assert_nextline("baudrate    = %lu bps",
 			   env_get_ulong("baudrate", 10, 1234));
 	ut_assertok(test_num_l(uts, "relocaddr", gd->relocaddr));
-- 
2.51.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F356F3D32A
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 17:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 841EC83F8F;
	Thu,  5 Mar 2026 18:01:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="mf0j7mI1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32F5983F9A; Thu,  5 Mar 2026 18:01:36 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBF8F83F8F
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 18:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1772730071;
 bh=haNFbTVUH0jnrNBxQ6rF4fELQAtlxbSlsPM4wYVqH8o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mf0j7mI1piIt7HHNb6SpuutjTZ9jFHzeZkVH/omTpOtsARwH2lFY0z1Zxf/u4oQpA
 yIKXGpmdnDUdQms7gl1jYX71qZBnhiGUtayFw1A6cN0LW9NbQRMmbRPaNYAjxAdWGt
 Cbx4DWn0h5q8aeOm6KzRNTAfM4yTqvdvwZm9FDxKCLSocfhAs5UzUU5oV0mnmZVa8F
 AU5mnjblZ3xBTQPx0ejhDqq/rP+0xeKLG3z7zxCODJrlfMOyCESxNO5bDOPWiwi1fw
 zIWujisgLXjwWw0L7PtmuXm2J5c9MN3P/dTTRhr6C20tzrWY4LkUr+YKdb58whRlgH
 RL+4ocPhDpuxQ==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 63D64B22022D;
 Thu,  5 Mar 2026 18:01:09 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [RESEND PATCH v4 1/3] board: starfive: visionfive2: Add Orange Pi RV
 selection by product_id
Date: Thu,  5 Mar 2026 09:00:20 -0800
Message-ID: <20260305170043.33994-2-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20260305170043.33994-1-e@freeshell.de>
References: <20260305170043.33994-1-e@freeshell.de>
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

Add XOPIRV identifier for Orange Pi RV to dts selection callback in SPL,
and to fdtfile environment variable default value selection in payload.

Signed-off-by: E Shattow <e@freeshell.de>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 board/starfive/visionfive2/spl.c                  | 3 +++
 board/starfive/visionfive2/starfive_visionfive2.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 2d9431d2976..684605278c0 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -131,6 +131,9 @@ int board_fit_config_name_match(const char *name)
 		    !strncmp(get_product_id_from_eeprom(), "MARC", 4) &&
 		    !get_mmc_size_from_eeprom()) {
 		return 0;
+	} else if (!strcmp(name, "starfive/jh7110-orangepi-rv") &&
+		    !strncmp(get_product_id_from_eeprom(), "XOPIRV", 6)) {
+		return 0;
 	} else if (!strcmp(name, "starfive/jh7110-pine64-star64") &&
 		    !strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
 		return 0;
diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index 6c39fd4af35..d59622f6b64 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -63,6 +63,8 @@ static void set_fdtfile(void)
 		} else {
 			fdtfile = "starfive/jh7110-milkv-marscm-lite.dtb";
 		}
+	} else if (!strncmp(get_product_id_from_eeprom(), "XOPIRV", 6)) {
+		fdtfile = "starfive/jh7110-orangepi-rv.dtb";
 	} else if (!strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
 		fdtfile = "starfive/jh7110-pine64-star64.dtb";
 	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110A", 7)) {
-- 
2.50.0


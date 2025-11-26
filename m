Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D085CCF9F5
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 22:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ED6A83A98;
	Wed, 26 Nov 2025 23:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="b87zj1dU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71D6783A9F; Wed, 26 Nov 2025 23:18:01 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9782E83A64
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 23:17:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1764195392;
 bh=cQIadE8rav5PEG4WJhAK9orAT8v45e69yV+wQ/AjPNs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=b87zj1dURToxGjQufAq5nX8wzO/DAFkqCCm37HQzXYL47tNnYoVUd2fBXVaV2miyY
 v8AYPc2WepFojTjc2dBwwbA1XY7R5VAgzfSdQgp1P8PfH1cj0etEYIDGKPhuCY3T6A
 rhlfjb/RCuvqRmh5YNs5jdCv+xE669L8Djw0LwuJW2Y2t/Z3uUKOzfJoNEJ6r0I1Mi
 23mPafKhUq4T4DgbbCK5EsWlX0Ub2Vq7/FQQzdLVoOPaQQg05GKopT2Q1clJquigD5
 lICbRZyRTMDtptVfMC6tv+B0zYFUtc8p/pQ0ecnDJMSUilaIzFeBvbzDOBtEvdIX7y
 ZEd7TblCmE1AQ==
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id C06F8B22131B;
 Wed, 26 Nov 2025 23:16:30 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Icenowy Zheng <uwu@icenowy.me>
Subject: [RFC PATCH v1 2/4] board: starfive: visionfive2: Add Orange Pi RV
 selection by product_id
Date: Wed, 26 Nov 2025 14:15:27 -0800
Message-ID: <20251126221552.87574-3-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251126221552.87574-1-e@freeshell.de>
References: <20251126221552.87574-1-e@freeshell.de>
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

Add identifier for Orange Pi RV to dts selection callback in SPL, and to
fdtfile environment variable default value selection in payload.

Signed-off-by: E Shattow <e@freeshell.de>
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


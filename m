Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045D3C0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 14:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0CB8826AA;
	Fri, 31 Jan 2025 15:13:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="FQ8Ccwm+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89EC58213E; Fri, 31 Jan 2025 11:09:10 +0100 (CET)
Received: from mxd-2-a0c.seznam.cz (mxd-2-a0c.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:a0c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47D2E80F70
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 11:09:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=atheiste@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-5745ddfd69-ntdxp
 (smtpc-mxd-5745ddfd69-ntdxp [2a02:598:64:8a00::1000:a0c])
 id 69ab4db5da3a78af691af992; Fri, 31 Jan 2025 11:09:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz;
 s=szn20221014; t=1738318146;
 bh=D+txAMV5BnWWK8QjjzsDF4MEFZglebTzGmD8KUuh8T4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding;
 b=FQ8Ccwm+r/BPIYTIEQCBY6A3Gyxf6MJBxOy67D78hDIYFen/9iNK1CEs5+zL1PXkr
 WAm8wy7kqkssSn55Pez67TRZ42HWNWbvhCOSwkMrfPREJK93oXP42y3mbLAStasCsp
 GQiXTnh/B0WG29a74HLpFAUQPDEL76HWivXd3b5lxYwCqS8GgcZd6uPY8vadhUwUuR
 94e5ktYeGIQimTV4NYsReSWvOWq0I90KNMdOCH69Xqdrld8exiW1c0TeCIAkbantKa
 zSPTaT0i8dPbb+110uOAPizRb/ak0yd6A2Qqms1hIWDSj4xAT1yMps57eTTZSNQ+rB
 1dnh2o1ZBRYYA==
Received: from triton.localdomain (236.157.230.94.awnet.cz [94.230.157.236])
 by smtpd-relay-6c6fb99fbb-fn9wm (szn-email-smtpd/2.0.27) with ESMTPA
 id 0b6e54fd-6f91-47fa-9a17-34de3b1c316c;
 Fri, 31 Jan 2025 11:09:03 +0100
From: Tomas Peterka <atheiste@seznam.cz>
To: u-boot@lists.denx.de
Cc: Tomas Peterka <atheiste@seznam.cz>,
	tomas@dronetag.cz
Subject: [PATCH] feat: Add CONFIG_BOOTCOUNT_ALTBOOTCMD to Kconfig
Date: Fri, 31 Jan 2025 11:08:44 +0100
Message-ID: <20250131100845.31380-1-atheiste@seznam.cz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250130164758.GC1233568@bill-the-cat>
References: <20250130164758.GC1233568@bill-the-cat>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Jan 2025 15:13:17 +0100
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

Add CONFIG_BOOTCOUNT_ALTBOOTCMD so the developer is able to add
custom altbootcmd via Kconfig when they enable BOOTCOUNT.
---
 drivers/bootcount/Kconfig | 3 +++
 include/env_default.h     | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
index 0080d2a165..99b6c7534f 100644
--- a/drivers/bootcount/Kconfig
+++ b/drivers/bootcount/Kconfig
@@ -183,6 +183,9 @@ config BOOTCOUNT_BOOTLIMIT
 	  counter being cleared.
 	  If set to 0, do not set a boot limit in the environment.
 
+config BOOTCOUNT_ALTBOOTCMD
+	string "Alternative boot command when BOOTLIMIT is reached"
+
 config SYS_BOOTCOUNT_SINGLEWORD
 	bool "Use single word to pack boot count and magic value"
 	depends on BOOTCOUNT_GENERIC
diff --git a/include/env_default.h b/include/env_default.h
index aa3dd40f3f..60c39f9853 100644
--- a/include/env_default.h
+++ b/include/env_default.h
@@ -115,6 +115,9 @@ const char default_environment[] = {
 #if defined(CONFIG_BOOTCOUNT_BOOTLIMIT) && (CONFIG_BOOTCOUNT_BOOTLIMIT > 0)
 	"bootlimit="	__stringify(CONFIG_BOOTCOUNT_BOOTLIMIT)"\0"
 #endif
+#ifdef CONFIG_BOOTCOUNT_ALTBOOTCMD
+	"altbootcmd="	CONFIG_BOOTCOUNT_ALTBOOTCMD            "\0"
+#endif
 #ifdef CONFIG_MTDIDS_DEFAULT
 	 "mtdids="	CONFIG_MTDIDS_DEFAULT		"\0"
 #endif
-- 
2.47.1


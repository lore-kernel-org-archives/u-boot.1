Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C749FEA83E
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 09:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A99D83DA7;
	Wed, 25 Mar 2026 10:58:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="E9csZDSx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29CDD83AAB; Wed, 25 Mar 2026 10:58:20 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1DF583F14
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 10:58:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=oKBHjKgo871tXYOg2RSCmvd5kutHuj3QQSpGP4/ZcVI=; b=E9csZDSxwvzKeqYICaHAZultLX
 PFF8G60qwE707DGR3of2u8IShwAmk+VxkPNNQTDKkgCfxQ04gBZ+KbQH7bnWbTKTWnUYX4xgkjMjJ
 wfztnxUNvKnx7+VfVh2lVRvvL3QGaCzfiRNyojY3113ZWzLDmZO7Gmh0Zeg8c+kpttYw4ycj6Y274
 vpKeRJMDmupb4yWz2fNbvqGKHrn2F5Ia7zDgO0f0nfzTeDPSvV2ysGkqPjmNlo723PMhwEjHHduI6
 vykj/VIrvIcmqyh2fxOTn9m7lW8+TLHUf3ROtKtXkDUXloHrKUi6iuCdlbottaHNoXXm+ZxkfaE28
 RVrpXkzA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w5L08-0009m2-2H; Wed, 25 Mar 2026 10:58:12 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w5L08-000HPv-1Q; Wed, 25 Mar 2026 10:58:12 +0100
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Steffen Doster <Steffen.Doster@tq-group.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>
Subject: [PATCH v2 3/8] env: add env_set_runtime() helper
Date: Wed, 25 Mar 2026 10:57:56 +0100
Message-Id: <20260325095801.47706-4-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325095801.47706-1-Alexander.Feilke@ew.tq-group.com>
References: <20260325095801.47706-1-Alexander.Feilke@ew.tq-group.com>
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

From: Nora Schiffer <nora.schiffer@ew.tq-group.com>

env_set_runtime() is equivalent to env_set(), but does nothing when
CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG is unset.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Signed-off-by: Steffen Doster <Steffen.Doster@tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 include/env.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/env.h b/include/env.h
index 01c3eeae7e2..193aff8f23b 100644
--- a/include/env.h
+++ b/include/env.h
@@ -160,6 +160,25 @@ bool env_get_autostart(void);
  */
 int env_set(const char *varname, const char *value);
 
+/**
+ * env_set_runtime() - set an environment variable if
+ * CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG is set.
+ *
+ * This is equivalent to env_set(), but does nothing if
+ * CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG is unset.
+ *
+ * @varname: Variable to adjust
+ * @value: Value to set for the variable, or NULL or "" to delete the variable
+ * @return 0 if OK or !CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG, 1 on error
+ */
+static inline int env_set_runtime(const char *varname, const char *value)
+{
+	if (IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG))
+		return env_set(varname, value);
+
+	return 0;
+}
+
 /**
  * env_get_ulong() - Return an environment variable as an integer value
  *
-- 
2.34.1


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6E3C5DF8C
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 19:48:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0B7980D56;
	Sun, 23 Aug 2026 19:48:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gcLaWc0OS3sk; Sun, 23 Aug 2026 19:48:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787514522;
	bh=4wDHaYsObFYpP7eTHMicHkhcTriacVR8wGobV+kLhR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FYPvJB7DOhfrHW7QcWer01kBGJlVky8Sasa/VBWiNHn4TcLYS9tpKmHjq0Uq8178l
	 G7NWHBaMyR/htX0mMP02xaN61tKNy4JZCnBDPJYStHDyNh6ojI9fjCj8yS7KJZ25pl
	 hKokAkgKAjml8xbK0V5e4fKXIC9Y4ib83B7gm7XM/iBw1oP4sQFW8YfaoF7CDYHMux
	 c+XFq7Xkf6nCpcbK+T2+E5Ny3uzFX5phKBILBzP5Q9w1rRNt9daF0mltWlVF+7+myg
	 oTPvs7e0Kdhqb++cvGe+HtH4oHpv/kEll/k6Zi3TfGJPhfx4NShK4sKQZPXjGRAODn
	 +3wwLI2QPMuJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B65BC80D77;
	Sun, 23 Aug 2026 19:48:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CC93435
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2DB6040533
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:48:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2kxUIE5Slk2a for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 19:48:37 +0000 (UTC)
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 23 Aug 2026 19:48:34 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=Ii/WBD++
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.226;
 helo=mta-64-226.siemens.flowmailer.net;
 envelope-from=fm-294854-20260823194728069ccca0cf00020768-tsnl0i@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 724CC4052B
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:48:34 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20260823194728069ccca0cf00020768
 for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 21:47:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=4wDHaYsObFYpP7eTHMicHkhcTriacVR8wGobV+kLhR4=;
 b=Ii/WBD++9oRbole9vFwUYQ2BbDOmp6K3XLBDHF9h5u7q7rKwstcYibZMRK4UuQBcKrv/4m
 rqe0wA1akMNQjVJMvCUlozAgGpDf0XA+reW96YOfRY/xmyVdxsXvXFSlEHdHXuS8M09W3RPq
 hdU5IuzY0GUY8kcSw9gsg7WSUXzNY1b29X27qFmslRYoTKTXq3zm5/ty8MdG6VjeDFnvWoGv
 I0zM9DWyds5wbWi+jQ5kT+/sKO/i/15AwiFeffAYh4ROTGlTxexgvX14lYjEDZhdFeL95Hx5
 pggq3HKXhShBvYiXbBrc4pG6w0JGsleM+C49LhDAJ9BzVAqH2+egBLrg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v2 2/5] tee: optee: Add support for enumerating services that
 only need RPMB
Date: Sun, 23 Aug 2026 21:47:23 +0200
Message-ID: <1794934500e5580309f4a8cb064bd035cb9b23d4.1787514446.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787514446.git.jan.kiszka@siemens.com>
References: <cover.1787514446.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Up to OP-TEE 4.4.0, all services that needed a supplicant where returned
by PTA_CMD_GET_DEVICES_SUPP. Since then, services that only need a
supplicant for the purpose of accessing the RPMB are only enumerated by
the new, separate PTA_CMD_GET_DEVICES_RPMB. U-Boot so far lacks support
for that, thus no longer finds such services, e.g. fTPM.

Perform the separate enumeration during probe but, as that may fail if
the MMC is not probed yet, also provide a callback to trigger a retry
when another MMC device becomes available.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/tee/optee/core.c          | 22 +++++++---------------
 drivers/tee/optee/optee_private.h | 21 +++++++++++++++++++++
 drivers/tee/optee/rpmb.c          | 19 +++++++++++++++++++
 include/tee/optee.h               |  6 ++++++
 4 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 2871760a7b7..ed8f2b6ec74 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -27,19 +27,6 @@
  */
 #define PTA_DEVICE_ENUM		{ 0x7011a688, 0xddde, 0x4053, \
 				  { 0xa5, 0xa9, 0x7b, 0x3c, 0x4d, 0xdf, 0x13, 0xb8 } }
-/*
- * PTA_CMD_GET_DEVICES - List services without supplicant dependencies
- *
- * [out]    memref[0]: List of the UUIDs of service enumerated by OP-TEE
- */
-#define PTA_CMD_GET_DEVICES		0x0
-
-/*
- * PTA_CMD_GET_DEVICES_SUPP - List services depending on tee supplicant
- *
- * [out]    memref[0]: List of the UUIDs of service enumerated by OP-TEE
- */
-#define PTA_CMD_GET_DEVICES_SUPP	0x1
 
 typedef void (optee_invoke_fn)(unsigned long, unsigned long, unsigned long,
 			       unsigned long, unsigned long, unsigned long,
@@ -195,8 +182,8 @@ int optee_bind_services(struct udevice *dev, u32 tee_sess,
 
 static int bind_service_drivers(struct udevice *dev)
 {
+	int ret, ret2, ret3 = 0;
 	u32 tee_sess;
-	int ret, ret2;
 
 	ret = optee_open_enum_session(dev, &tee_sess);
 	if (ret)
@@ -204,13 +191,18 @@ static int bind_service_drivers(struct udevice *dev)
 
 	ret = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES);
 	ret2 = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_SUPP);
+	if (CONFIG_IS_ENABLED(SUPPORT_EMMC_RPMB))
+		ret3 = optee_bind_services(dev, tee_sess,
+					   PTA_CMD_GET_DEVICES_RPMB);
 
 	tee_close_session(dev, tee_sess);
 
 	if (ret)
 		return ret;
+	if (ret2)
+		return ret2;
 
-	return ret2;
+	return ret3;
 }
 
 /**
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 25b6b3c3218..daff3e04493 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -9,6 +9,27 @@
 #include <tee.h>
 #include <log.h>
 
+/*
+ * PTA_CMD_GET_DEVICES - List services without supplicant dependencies
+ *
+ * [out]    memref[0]: List of the UUIDs of service enumerated by OP-TEE
+ */
+#define PTA_CMD_GET_DEVICES		0x0
+
+/*
+ * PTA_CMD_GET_DEVICES_SUPP - List services depending on tee supplicant
+ *
+ * [out]    memref[0]: List of the UUIDs of service enumerated by OP-TEE
+ */
+#define PTA_CMD_GET_DEVICES_SUPP	0x1
+
+/*
+ * PTA_CMD_GET_DEVICES_RPMB - List services only depending on RPMB support
+ *
+ * [out]    memref[0]: List of the UUIDs of service enumerated by OP-TEE
+ */
+#define PTA_CMD_GET_DEVICES_RPMB	0x2
+
 /**
  * struct optee_private - OP-TEE driver private data
  * @rpmb_mmc:		mmc device for the RPMB partition
diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
index bacced6af6c..f7312d7171c 100644
--- a/drivers/tee/optee/rpmb.c
+++ b/drivers/tee/optee/rpmb.c
@@ -191,3 +191,22 @@ void optee_suppl_rpmb_release(struct udevice *dev)
 {
 	release_mmc(dev_get_priv(dev));
 }
+
+void optee_rpmb_available(void)
+{
+	struct udevice *dev;
+	struct uclass *uc;
+	u32 tee_sess;
+
+	uclass_id_foreach_dev(UCLASS_TEE, dev, uc) {
+		if (strcmp(dev->driver->name, "optee") != 0)
+			continue;
+
+		if (optee_open_enum_session(dev, &tee_sess) != 0)
+			continue;
+
+		optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);
+
+		tee_close_session(dev, tee_sess);
+	}
+}
diff --git a/include/tee/optee.h b/include/tee/optee.h
index d1194493780..755533b2c0b 100644
--- a/include/tee/optee.h
+++ b/include/tee/optee.h
@@ -74,4 +74,10 @@ static inline bool is_optee_smc_api(void)
 }
 #endif
 
+#if defined(CONFIG_OPTEE) && defined(CONFIG_SUPPORT_EMMC_RPMB)
+void optee_rpmb_available(void);
+#else
+static inline void optee_rpmb_available(void) {}
+#endif
+
 #endif /* _OPTEE_H */
-- 
2.47.3


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D903C5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 09:30:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DC7460779;
	Fri, 21 Aug 2026 09:30:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aVS69sEqYRYZ; Fri, 21 Aug 2026 09:30:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787304613;
	bh=eNZz5g3FHnnlOHGFr4ZQIEajGuVhvGT7+NQG+LOu/c8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yrpKjRK0LAWvb19Cp/r6hKiB+afMEvR1ah3/t+K6AWfaMxjKupWBRUR447llG7Sut
	 cypXE67EuZVaTs0gtfGOvQIMw2qyNOQ9UWXbuZzX4sl08r4fe2g+PWkDm5hpr4tnVH
	 fpXlcmqKx5IPqQfhLRP3LkYPURPud+wsuV5jj9VRnF9aDAhVFkW0hPDmhM2DxQP+sY
	 MQxf5I6OS79RXQWfAvJY0yiZ63NMZUT4KoKvXv+iuMKb+RUO+m3qcymIbS5jcztsbO
	 5yfGtDYFbU/QR712tV+Nmueb/qI7B/uFpuoyfPXQLr9Vk+cYsX7HIQMN8065NAzlX6
	 LwhR7PXgjjUfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8B0A6068A;
	Fri, 21 Aug 2026 09:30:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EDC03263
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 09:30:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D414E40931
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 09:30:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gFqeGCDD-p5S for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 09:30:11 +0000 (UTC)
X-Greylist: delayed 64 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 21 Aug 2026 09:30:10 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=PDKi1ZqK
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.226;
 helo=mta-64-226.siemens.flowmailer.net;
 envelope-from=fm-294854-20260821092902fd52911f410002073f-3px_xf@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2251040912
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 09:30:10 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20260821092902fd52911f410002073f
 for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 11:29:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=eNZz5g3FHnnlOHGFr4ZQIEajGuVhvGT7+NQG+LOu/c8=;
 b=PDKi1ZqKrYUxi4BUsLDAYIe57+cHwtpTJNycoQ4+latbz2VjU3S0Dp6ZJfr1ym9OrOB7av
 R0oiGYPKI3luIxwWqcL72ZOi203NjEE276CybRScNz/O7+zi/pPYN35fBKReJjE7VzPC+LGH
 ZLTu0chkLT7wenDshTz6PBz1ZQtMe9cOU/ys448ZZAcoLVsgn8uHGbwRX2htRdONZZEGswIY
 e1leGJfsaK/fCL5Llp8WzQEk35ItBOCLVLUIoOaX/RYIL8SnONBPYIf7CdhvdfJ/biXR3XZ/
 L3yEKR9PHihqQt7Y6ZoHLxCD6b3o9Swx6sH38cvuewUsz2OF/5S4tsPw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [PATCH 1/4] tee: optee: Add support for enumerating services that
 only need RPMB
Date: Fri, 21 Aug 2026 11:28:58 +0200
Message-ID: <bfd9927ca141783a9f73f82a10eca75699222e1d.1787304541.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787304541.git.jan.kiszka@siemens.com>
References: <cover.1787304541.git.jan.kiszka@siemens.com>
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
 drivers/tee/optee/core.c          | 32 +++++++++++++++++++++++++++++++
 drivers/tee/optee/optee_private.h |  2 ++
 drivers/tee/optee/rpmb.c          | 11 +++++++++++
 include/tee/optee.h               |  2 ++
 4 files changed, 47 insertions(+)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 4d67c948ec1..5600d5a4c7d 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -41,6 +41,13 @@
  */
 #define PTA_CMD_GET_DEVICES_SUPP	0x1
 
+/*
+ * PTA_CMD_GET_DEVICES_RPMB - List services only depending on RPMB support
+ *
+ * [out]    memref[0]: List of the UUIDs of service enumerated by OP-TEE
+ */
+#define PTA_CMD_GET_DEVICES_RPMB	0x2
+
 typedef void (optee_invoke_fn)(unsigned long, unsigned long, unsigned long,
 			       unsigned long, unsigned long, unsigned long,
 			       unsigned long, unsigned long,
@@ -210,6 +217,29 @@ static int bind_service_drivers(struct udevice *dev)
 	return ret2;
 }
 
+#ifdef CONFIG_SUPPORT_EMMC_RPMB
+void optee_bind_service_drivers_rpmb(struct udevice *dev)
+{
+	struct tee_shm *service_list = NULL;
+	size_t service_count;
+	u32 tee_sess;
+	int ret;
+
+	ret = open_enum_session(dev, &tee_sess);
+	if (ret)
+		return;
+
+	ret = enum_services(dev, &service_list, &service_count, tee_sess,
+			    PTA_CMD_GET_DEVICES_RPMB);
+	if (!ret && service_count)
+		ret = bind_service_list(dev, service_list, service_count);
+
+	tee_shm_free(service_list);
+
+	tee_close_session(dev, tee_sess);
+}
+#endif
+
 /**
  * reg_pair_to_ptr() - Make a pointer of 2 32-bit values
  * @reg0:	High bits of the pointer
@@ -852,6 +882,8 @@ static int optee_probe(struct udevice *dev)
 		ret = bind_service_drivers(dev);
 		if (ret)
 			dev_warn(dev, "optee service enumeration failed: %d\n", ret);
+		else
+			optee_bind_service_drivers_rpmb(dev);
 	} else if (IS_ENABLED(CONFIG_RNG_OPTEE)) {
 		/*
 		 * Discovery of TAs on the TEE bus is not supported in U-Boot:
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 1f07a27ee4b..b5a58df5b96 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -79,4 +79,6 @@ static inline void optee_suppl_cmd_i2c_transfer(struct optee_msg_arg *arg)
 
 void *optee_alloc_and_init_page_list(void *buf, ulong len, u64 *phys_buf_ptr);
 
+void optee_bind_service_drivers_rpmb(struct udevice *dev);
+
 #endif /* __OPTEE_PRIVATE_H */
diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
index bacced6af6c..f4a66641755 100644
--- a/drivers/tee/optee/rpmb.c
+++ b/drivers/tee/optee/rpmb.c
@@ -191,3 +191,14 @@ void optee_suppl_rpmb_release(struct udevice *dev)
 {
 	release_mmc(dev_get_priv(dev));
 }
+
+void optee_rpmb_available(void)
+{
+	struct udevice *dev;
+	struct uclass *uc;
+
+	uclass_id_foreach_dev(UCLASS_TEE, dev, uc) {
+		if (strcmp(dev->driver->name, "optee") == 0)
+			optee_bind_service_drivers_rpmb(dev);
+	}
+}
diff --git a/include/tee/optee.h b/include/tee/optee.h
index d1194493780..c12fda3cc73 100644
--- a/include/tee/optee.h
+++ b/include/tee/optee.h
@@ -74,4 +74,6 @@ static inline bool is_optee_smc_api(void)
 }
 #endif
 
+void optee_rpmb_available(void);
+
 #endif /* _OPTEE_H */
-- 
2.47.3


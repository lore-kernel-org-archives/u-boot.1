Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F0EC79FAA
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 15:05:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80A2280C47;
	Tue,  8 Sep 2026 15:04:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dkkn9IvUjcCz; Tue,  8 Sep 2026 15:04:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8F6F080BE5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788879897;
	b=fJ+IK6CrAXg6r3yobRQM7poNABnEFUv2FgwicaGQ1ta4D6rkdQFKIYx/WgOcTG6K/0u8
	 ect8Tt7Vy//SCo1YMmg1nTftWO0Z3fuITG0pDEUJdRN/JLzk4EK3g2xOmqOpP1EgTprhc
	 F2wJhSv0zOMRB8ytU8YPN9Y9/NyxW7fb8PNKNqsRqcWbO+25VMYQVO45JWD7dq4QUdej7
	 YXx6zyZlHz97KNnDjyaQJMxAdkDKtKIq8BMNyO2/VulTpDqhHeqxn31J46Y+dKPvwAqBI
	 RpiA0j9EDH/oTH4V4SXLOwTuLlwO4IbsgY7rtcTBTxpwEAnH2g1FvV8TUXns6HC6cZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788879897;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/zgOyXvFvyecZ8TwXYiepa2+arPc2L8hXxb5ocy3csU=;
	b=S5JexymWhS9VM2b9uwHsApMuYPbCW1kbprze4HXYKWWdQm2qiPCA+zLMFkbwPVnz3B8W
	 617/cbqGR/N4AlmFBqpPCKZcZRR0I68lvhgNyhiHcRX5c0XwHoCA/lYlnHANlaEE4wn+F
	 GYESYlv031e7789qQlzmdssHw8tn5QH285dwYY6UJVo5W80SWEnBbNYcS2DCLwS1pFft+
	 N+RemTFOnbjhvkUfQtFoGEUDoQv0RWO2dr4VW/2TQJ+DviJgB7sj3QXaROYCuaTmosh/G
	 M7KfJFG/zmxrx1ebV/SZpYnLGj3DiorY5bzXpfLDBI+w58Nz51p4e0RMtP1LnO65sqw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788879897;
	bh=/zgOyXvFvyecZ8TwXYiepa2+arPc2L8hXxb5ocy3csU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tvx7HlGhH+c33ebp8jvzj9P/jpzwzqWsK4e26uZltfeeO3uW2xrmoJGiXGy7lr+L3
	 vBn0M2uWbY3jMYcT3wHDJNoO28ryit5JdfzuRqIYLFeQ7ISxe0VmEs0cPvWImyB/fC
	 KR0JrfRNOb/ZiNV8u4sz8Me4SbuRz+nxB+L93IKSX3zubgBaGpA5qC2U+GsQPp4doK
	 sYdC3yBS3kLXv7OEBXq7YzpQq+I0fwovNbO5rDV4N5gkMk9OM/X65xe35844+2G8u5
	 5oV+AD+mwp94wKFunC2497K7sV8/GBEX4945lgwezZblz9PROBVAqBbk8w/7AheRoa
	 kzjHdBzRC/97g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F6F080BE5;
	Tue,  8 Sep 2026 15:04:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AF50AEB
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C3DE60712
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:04:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KVWpsJygknxD for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 15:04:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AA465606F5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.225
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788879887;
 b=nwXWMza2b8fEyWGOFEVFvtV0ZkpUmPj7jZtJOjqqpCZPhBOr5c4HddE2xfqeyfYOZVvR
 2zH5Dls4y0Gfqmr6j8luLKvQ2kpQFZ9PZnrm2Ig8iS/i5yNjUSEMMhqU9iKzknT9Cc3Ai
 XoxFq9bYB3MnKYbw/4Zh4mtZ81mi+sNPPOsZ3DwCr2MTgC7rumDgVMs32Doc8pux1ov6u
 FI/5VzipKk+7GebZu9iez6ETsVf8mHL5aUBK9NkaLCge8hXHPnl3EYtEP1uQg9RWeHl41
 XsE/nqVYkjIHbFE262xlPOAFxZXV5tjKLI4PJ7BAlXhIAbMU3P6Axfv6kX8tIF3byVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788879887;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=/zgOyXvFvyecZ8TwXYiepa2+arPc2L8hXxb5ocy3csU=;
 b=X7fewSO5LmD05Gyq/aCK+piZ2Hj6mY4oZehKq7SFR0gcq9tkKN5Zbt6TvgpeXkzmqfXn
 YTLx7JIAYb3eS3YeuFo/QzJxbtP3cIY4Qmo7O39tmphw1zAomMEtk3IjhvoE7uTeJ41pm
 kks+4yjJTz3asi43a/0W0wtiliSjtuOorQ0qz8IuyH81S86e57h8psdXe2L0AfgqK0H0r
 hYqFX+CXGMgN/6Nnnu7eqyVCKUiXWILd9Q73neVRfKEbuLHO8I7wKV/jRRpj4g0wUYg8C
 O/foJkGIUhrbO6cErmWzetJi+k8V4ANmVh3Qh3q8Wry5x/CxiaFg7ztEnJ3q4YsYPvg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=cQT2LKTM; 
 arc=none smtp.remote-ip=185.136.65.225
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 08 Sep 2026 15:04:45 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=cQT2LKTM
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.225;
 helo=mta-65-225.siemens.flowmailer.net;
 envelope-from=fm-294854-2026090815033907255701720002075e-lv1i6x@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AA465606F5
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:04:45 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 2026090815033907255701720002075e
 for <u-boot@lists.u-boot-project.org>;
 Tue, 08 Sep 2026 17:03:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/zgOyXvFvyecZ8TwXYiepa2+arPc2L8hXxb5ocy3csU=;
 b=cQT2LKTMYXHLtL8+fq3KHKo4MM0Lyze2tlx2ZU4u5yLNEKHnQGSKKB3U2sqCYCSfFrZssb
 NiUIrwtO6oHX08TsX59ZZvEWA/Ath61af5OMirzaHk01FZmYKnH20dLC6+7sOkJ8mYg4n4yx
 spcWU04Gsqirf1xBx4Z9QheHGgmd9mjETEu+PqR+dZb1IwhyR0k7eATgCA45WqtXOqWYuvC7
 ythOyTHi7khIYL3C6sFcSA2GGYkuyPl3SAyVMSdpjxGqDzAKjJl+qtT+gu8Gsdw8TQ8Kk38d
 mnLHgOw4N+ZLkl9kHpKblL/0Z+09eb8Pt+jVjILCOsN3nYomVG+Aq8+w==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v3 2/5] tee: optee: Add support for enumerating services that
 only need RPMB
Date: Tue,  8 Sep 2026 17:03:35 +0200
Message-ID: <e398326082d600cb35ab3d1062be6505168d934c.1788879818.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1788879818.git.jan.kiszka@siemens.com>
References: <cover.1788879818.git.jan.kiszka@siemens.com>
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
 drivers/tee/optee/rpmb.c          | 20 ++++++++++++++++++++
 include/tee/optee.h               |  6 ++++++
 4 files changed, 54 insertions(+), 15 deletions(-)

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
index bacced6af6c..7ae6045511b 100644
--- a/drivers/tee/optee/rpmb.c
+++ b/drivers/tee/optee/rpmb.c
@@ -191,3 +191,23 @@ void optee_suppl_rpmb_release(struct udevice *dev)
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
+		if (strcmp(dev->driver->name, "optee") != 0 ||
+		    !device_active(dev))
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


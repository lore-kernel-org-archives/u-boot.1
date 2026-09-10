Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA81C79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 06:57:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A5F040866;
	Thu, 10 Sep 2026 06:57:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z8H8N_1JGKLP; Thu, 10 Sep 2026 06:57:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 94F6940A1C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789023456;
	b=NH2oAh5+TU+9bIS6mp+JjFXi3qOWEoL1l/6kF4xWNJoIj7AxDQzo3F+HZpxAw0UKivdW
	 HjkXNB4CTTo47rRxE2f63FRmhmiNO5dbaEU8rqc34v2DiSBaaJZVQHGqYnwGbS8R22VTZ
	 p1d4T7jDoV01PlWZkjZQIP9UdPo4JlrHEqfcLwTo+sUV4olFp9R64i3XXJPOn5y8k+sDI
	 8T8MUQpcrP1xrbMncU+gd88sR1gs5LK6LML76B0UQVCtvHtUJGsCFrgmv7+Gxb8HZAt15
	 UZhrqY8f008ISVQUOv7KC96DzVAMAWo6mlbsIS9YLSX1Etwlxo2Kgd1YYCvDX3d3kEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789023456;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dw5ihbCVJe8T8SHdqa2pwo7poZXehSlQRfdxPdTq+qA=;
	b=Zrx5HhvmJfPj2PS2ZTDwZ2g5dLvGe+d2yS8tcc5Nhk81dnQXL9F4TNDp2MzuDUVF05aZ
	 S7cJdlkUtZJsncOaw8lYkc2PxmnHY32lox8ZhjordIxiwSAs2MNDlDD7htGc5yzmnVbvj
	 1l6ePoTuyAofegQEuD9491gdyoDL81DAz6LsxBN2t5o89iwGt9uk9nRc6wgps1OouMXMI
	 hyfj0+3n54G8HcwvdR+rStwzDrrofTtR7s5ZiaT06yr4j/GjTRYFDQ5RC1eUdhbmDp/W0
	 TghfWV/YGq1JThy7cgGqQEtG550WWMFFzNW9PEGpwCyz253Ot65jgcTB3Yihsr2V9zQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789023456;
	bh=dw5ihbCVJe8T8SHdqa2pwo7poZXehSlQRfdxPdTq+qA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fHp8zqVhuCMr3G1TbClyE+33O+Vu5K26Ujb2DqKBf2nW9shVmzzom5iBVXpMLqdMt
	 BIQMhoswANnMC+/ULQ3TtSDA7twrQcMpK+fkcEDuk7DEec0W9CSRCyhxnGB8ep9bdo
	 kj5x1BWI5LtCgfTt6li4HaS3x/gKBx3mO45k179H9a0F77XNjTVkR3KDfCx8SVJHI0
	 ldBTweK2KA2LIVGej/HcEgFyLlvcaSTsmjZY0K0//5Hrux0/4u6trb+rwNpa6HFSgv
	 zZerGmF75OatWHl66aUuM8RRAyd1M3IJwinHsj0/PssChMatNytNbMROskJEj6GMe1
	 IVNGLWXG0rKLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94F6940A1C;
	Thu, 10 Sep 2026 06:57:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 269461EA5
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2239A80F11
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:57:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6icdbuUlRcqd for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 06:57:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 638B280F0B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789023450;
 b=MJbIP4XSYMyLMDgi6fkQPWOgQit4pX0rMqcY+opMX0Fg7JmmLbHY1hHpYb0aSVpv7Gz0
 r+9cQVD3vdtX1vRaa8QlKR+OLe6N9IYr5jcbXLyruFFH4RLje8Bn74VEL5bw7ydx2knSv
 r8t1Y5RC17m1ClflNKIIYmvo3Q1jO6690rtzlrPHhVn8FiaSqgXsteQ4dw73hNU8O2HbM
 3xeLuJyPSYDPBaVA54ECanIvCWyz3rv+AsKjgM9pQgsIVctniYI453F3ApOxWuIPcsAvN
 Yho7vUjBhnzA6IDAcPxlzAbLhlVpuH1I0iiXRoy0mySVwCVz77lGrZUH1rmmiMtGMCQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789023450;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=dw5ihbCVJe8T8SHdqa2pwo7poZXehSlQRfdxPdTq+qA=;
 b=l2hVyJ/tAXj1wSCL6ldiQSuLxJ2FPmD3/ExVU3OdrXtMej04LT5fKI6x8MNqWUTk5o/N
 DoiTmHJ/+th0Qr0Gla+Lku4BypBmpyy4PHIC9Ia97HqpcwtEM/vMOH1Oi4zNTliya9Wq8
 GSN2L5YYYWgyx6Ui+Q1Hg2SMdrwOb0VUE3+0tfXwbxiPt4Gz6sufLUZ7WSbwW2oNme8HT
 Wco8DndvKEUzr88udm2Dx1EOzjZKB+oZsvL2G86AjEcJCpQkqitS+BsaRlrX9OxNYGps8
 AR8LY62ccChUHNgCzwQIePFesSDHPWMAxph/Se1peFUsdeB0fwutwxOe31GJxnIo3nQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=X8mwj18Y; 
 arc=none smtp.remote-ip=185.136.64.227
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 10 Sep 2026 06:57:29 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=X8mwj18Y
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.227;
 helo=mta-64-227.siemens.flowmailer.net;
 envelope-from=fm-294854-2026091006562328f15f7ace00020736-qs537_@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 638B280F0B
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:57:29 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 2026091006562328f15f7ace00020736
 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 08:56:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=dw5ihbCVJe8T8SHdqa2pwo7poZXehSlQRfdxPdTq+qA=;
 b=X8mwj18YUzrtaXas0jKromrDJ50xFztdBWEQm74Hn1ot7MC7MCy5hd/UUsqMYwzfXtj09n
 ThO1gBp4W0KVbl7UExiEYxyH5zmCBt2fLLWq6pBM0l9A9T9VFWyHE/hK/VmAs1E/iGqLRYYB
 5SMxrKjxvVP4umgX9XyjQzp8eNG7KgvWm24Z6JxfssbICobPJibQ+MRuTUDGaWKYC30QSTLq
 relPqeQrZQLFs1OktJmwHEdhSfoJMM7WwCH6fBQqeNfu1InIoU+aEUAfxXPeJUb0xMJQZuDm
 FCAJEjtoUMyM4SeoLJCzcppsi4iSg7ciRc3iUYfBJlMOHbOGx7MRjcNg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v4 3/6] tee: optee: Add support for enumerating services that
 only need RPMB
Date: Thu, 10 Sep 2026 08:56:18 +0200
Message-ID: <1a6e9dffe86b43d3c62ba185859d30a376fb61cf.1789023381.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1789023381.git.jan.kiszka@siemens.com>
References: <cover.1789023381.git.jan.kiszka@siemens.com>
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
index e8ba8f6cddd..7c481ceb804 100644
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
@@ -201,8 +188,8 @@ int optee_bind_services(struct udevice *dev, u32 tee_sess,
 
 static int bind_service_drivers(struct udevice *dev)
 {
+	int ret, ret2, ret3 = 0;
 	u32 tee_sess;
-	int ret, ret2;
 
 	ret = optee_open_enum_session(dev, &tee_sess);
 	if (ret)
@@ -210,13 +197,18 @@ static int bind_service_drivers(struct udevice *dev)
 
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


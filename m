Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2648DC5DF8C
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 19:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8FCC80B1C;
	Sun, 23 Aug 2026 19:48:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v7fexhHfci6u; Sun, 23 Aug 2026 19:48:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787514517;
	bh=8omY/zACGPcCL9zjWnTPYi0ZtA1TBRvorDfOYMW4DhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LOkgOEmaY9AgonGtt2sSmOAEl/zMVPsAekMn8gBdtCiJJqgHm+vAt8WDpdxVdxtYn
	 XWjL/tT3kSQrIA9U5DyGwDFW747y4kh+qThV2gmj+bTAf+nH1pfEEtkgUhgOoAVdFo
	 Atv4QkRzglOIWocdni7IVbkxcI/q560PEIZ43crsx6r/z5cQNwYywKGurdm5/s23Kw
	 2dwBEvChA7sPIrGnd+/Z03U3Skd4dDVWtRTJcWvBSz59fcZOT5+Y2lh7voiti+Pnyy
	 csrXvk0lBWxMzwzpLTQ9WUVnE3swOr/gMQ/himDsVdXHo0ZXivLmNAmDg3HMuNyEZP
	 wLtLPZ5aNjhWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 091C580B0A;
	Sun, 23 Aug 2026 19:48:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C6203279
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:48:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A9A504055B
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:48:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jms6L3NKCCoh for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 19:48:34 +0000 (UTC)
X-Greylist: delayed 62 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 23 Aug 2026 19:48:33 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=IgMu+fPl
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.225;
 helo=mta-65-225.siemens.flowmailer.net;
 envelope-from=fm-294854-2026082319472855dbca396c0002076e-xcyfdb@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE98A40528
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:48:33 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 2026082319472855dbca396c0002076e
 for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 21:47:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=8omY/zACGPcCL9zjWnTPYi0ZtA1TBRvorDfOYMW4DhI=;
 b=IgMu+fPlXbUXQQaSAAFDiC0+3Wof7zQLWvShVeVVKNNMKx0laI9f6oVe//H93rUFidqRp0
 Gp4Y+PV5HHXIyK0I9jQOzrmkKzKu6CrH/1GMwVgAl2813nONZNUmtORAI3ra1M83ozoOu2hM
 7ZJmrE/FQvmCI4tnMaPN0qPqYeIuWXRtC/vwm1aRaDAM3BN7Bo6BEhyzSx80+0QNIeklOsxB
 Hd0pKyvtrcvclf+JaeLEBA914Rne216pcm1gK2h5uUbkzUKlf862ySwGIiEGEMRVArj1cMY5
 VoywheExUlvP0HaiFc7cUIUdgWrkcormlUUndsrpcto2YJacpfRqe96g==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v2 1/5] tee: optee: Factor out service enumeration and binding
 functions
Date: Sun, 23 Aug 2026 21:47:22 +0200
Message-ID: <70c9bcf676e253ed8c86699237c74e41c86eb34a.1787514446.git.jan.kiszka@siemens.com>
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

This already avoids code duplication between the different enumeration
commands. It will furthermore allow to implement a third one for
services with RPMB needs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/tee/optee/core.c          | 33 +++++++++++++++++--------------
 drivers/tee/optee/optee_private.h |  3 +++
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 4d67c948ec1..2871760a7b7 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -156,7 +156,7 @@ static int enum_services(struct udevice *dev, struct tee_shm **shm, size_t *coun
 	return ret;
 }
 
-static int open_enum_session(struct udevice *dev, u32 *tee_sess)
+int optee_open_enum_session(struct udevice *dev, u32 *tee_sess)
 {
 	const struct tee_optee_ta_uuid pta_uuid = PTA_DEVICE_ENUM;
 	struct tee_open_session_arg arg = { };
@@ -176,31 +176,34 @@ static int open_enum_session(struct udevice *dev, u32 *tee_sess)
 	return 0;
 }
 
-static int bind_service_drivers(struct udevice *dev)
+int optee_bind_services(struct udevice *dev, u32 tee_sess,
+			unsigned int pta_cmd)
 {
 	struct tee_shm *service_list = NULL;
 	size_t service_count;
-	u32 tee_sess;
-	int ret, ret2;
-
-	ret = open_enum_session(dev, &tee_sess);
-	if (ret)
-		return ret;
+	int ret;
 
 	ret = enum_services(dev, &service_list, &service_count, tee_sess,
-			    PTA_CMD_GET_DEVICES);
+			    pta_cmd);
 	if (!ret && service_count)
 		ret = bind_service_list(dev, service_list, service_count);
 
 	tee_shm_free(service_list);
-	service_list = NULL;
 
-	ret2 = enum_services(dev, &service_list, &service_count, tee_sess,
-			     PTA_CMD_GET_DEVICES_SUPP);
-	if (!ret2 && service_count)
-		ret2 = bind_service_list(dev, service_list, service_count);
+	return ret;
+}
+
+static int bind_service_drivers(struct udevice *dev)
+{
+	u32 tee_sess;
+	int ret, ret2;
 
-	tee_shm_free(service_list);
+	ret = optee_open_enum_session(dev, &tee_sess);
+	if (ret)
+		return ret;
+
+	ret = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES);
+	ret2 = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_SUPP);
 
 	tee_close_session(dev, tee_sess);
 
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 1f07a27ee4b..25b6b3c3218 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -27,6 +27,9 @@ struct optee_msg_arg;
 
 void optee_suppl_cmd(struct udevice *dev, struct tee_shm *shm_arg,
 		     void **page_list);
+int optee_open_enum_session(struct udevice *dev, u32 *tee_sess);
+int optee_bind_services(struct udevice *dev, u32 tee_sess,
+			unsigned int pta_cmd);
 
 #ifdef CONFIG_SUPPORT_EMMC_RPMB
 /**
-- 
2.47.3


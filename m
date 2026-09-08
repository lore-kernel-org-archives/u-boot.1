Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0B7C79F9E
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 15:04:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CC1180BDB;
	Tue,  8 Sep 2026 15:04:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OG01g3WbNEkI; Tue,  8 Sep 2026 15:04:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0D5A480986
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788879894;
	b=nleHo1DYg3j/9km5i3hemK3+IOB/BkJupTj5D9621LFzN3fIeR7xulcpBEvXgq8+UXUe
	 6664P8brzj2+LbXtc0QiBl/CCgHls/+Kq3z4c4leVGA0/95pgFAQaIwV7fvl62C7A0fyu
	 1pi9UAJKnDcpD2G9tXNtEQlY9YQVa/BYminbz/Hetxv/epM/BXMvui+w6vunSjgLy1lb3
	 3E/jOWHMuWykZD6+lY6cxMVI0/jV1NHpplbQRTkwps0pqhibAQvQlwt5SQD0qU5F62Qan
	 /I6J6InZBsaRzmxBLteYNNxwws7VwnUnS5idMUQsbvRtiGQXQ6kPOhoD/Yn01r++xRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788879894;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8omY/zACGPcCL9zjWnTPYi0ZtA1TBRvorDfOYMW4DhI=;
	b=K1jpgAHhoa7gNkR12wIXNwmBDOAJ6YVVGudqY/dPFOab7/RjGaT6zN7aD76IEl+OGSHd
	 G60zx5J8ZdVltTuyIOv5dbED4BYNMpQJVao5gn7ntI9N/L3U0Gpa3GiEtB6pNJU7mvu1m
	 PC0rqOG8AKN4dJKysabQhRHKHbfDi5c7et9DGe/VQY0t5EzimkfO4X/+4+nHnQ5BtwtXo
	 X+oOF2gHfJCnR9oZDqdOLo0dPg3VIB1ZNHMmDm++iahICdXJy9Hm88uPuSSVKiP/DDNOZ
	 njVBAy2Ze5FrcPmq/EP39XVql6xRZ4GJ5900oVP6nGzBct/Z9+En/EpFYEdaYQi33/g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788879894;
	bh=8omY/zACGPcCL9zjWnTPYi0ZtA1TBRvorDfOYMW4DhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a/KLr4XRUDG8tN+8nmkkFM9v5a2QpkT9X6OyMPtgvhcNUQWr6VF0RsbXDgoMKc2wm
	 46eCLm1Dn7INJnSu66guNO8au4qyUcgz/eSZPR7l+J7Gn3RaFomp4AmqFUNnOzhxb6
	 9sgJ/ghMnHV1ByiETMJz5RpzWuponDmcSskq2+Y6XydDszLuIMaktP+qOvIEyqRS2R
	 YoW/JzmOAkZ1Kymgf4cSc4wMWpwKumB2JQst95qAtS1ArDgsUpND463/wAQLd/qQbv
	 Qtb9uK6nFby19bMSIYlv2LupfHhW3RBecurwwtvTFOUgxmhofD/ApOjFz9TMNKmcih
	 SFGSMMfSYmEZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D5A480986;
	Tue,  8 Sep 2026 15:04:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CBF9D61
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2ADB660712
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:04:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zBgdRyJn_dbS for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 15:04:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E989860717
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788879888;
 b=nA4OX1dH9a7q6zhqn2IMAvWOmdcjiohHO5gXSDB6kWKkDqBG/mfJd17m07jKCRsMWWfZ
 EzaCuqv8FyskimYK7JGeeJdbHQXpeIwN7N3l9qtHmEmzECxvXQfNVmDcmHPHmZrfPj0hF
 tjJN1QkNr7VaD3LMSCjuAq3qfWR5a+P4ZXZoGol6FyDGV/GpfnNXnvx0PDbs85fBgHwEd
 6SzuFCyDofzuZ4SgiYWhdAdq8nBq+FEpBK5v3G5ses3lJJjATj9z+k9LVKZzDFStQtljf
 dWbD43lrvlQxH+hB8vPdU48aUP+IJP0r871ejFW6z1ehG17yvfN6GV3eiHFJvaK0AAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788879888;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=8omY/zACGPcCL9zjWnTPYi0ZtA1TBRvorDfOYMW4DhI=;
 b=JT1fBhAcsUUI12a7iSDNkAJRdcmKNzXsqVQDwV1Ik153GdFuYXcByLjw6CSjFSCWrrHM
 /uHBatK7fZsrLmgo+3L4BLVovVoOwuxFWRRUBrQeAhBKIJgL73fGVVjtefPzAUwvhCfHo
 lhyhxm1M2xZ21w5O6jRrG0Yj0Xy+MFno6/DSELhUYWOcV8e9aTi6qJTk9WRTad6MZWuxn
 nFKqdZNAEVPUvfMiI/vrcFvaXYxzr0cwhj4e9po5oAJqpGErB5jm/S0/KMScgC/n7exaj
 yolOLjehQC3pQcPhSyLf40PrUAXk/nW0oJTER3A/TR642fFQPA1ex+iZQHNif72eIMA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=jxuDe1lO; 
 arc=none smtp.remote-ip=185.136.64.227
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 08 Sep 2026 15:04:45 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=jxuDe1lO
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.227;
 helo=mta-64-227.siemens.flowmailer.net;
 envelope-from=fm-294854-20260908150338fc7b7f079700020733-dpyzaf@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E989860717
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:04:45 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20260908150338fc7b7f079700020733
 for <u-boot@lists.u-boot-project.org>;
 Tue, 08 Sep 2026 17:03:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=8omY/zACGPcCL9zjWnTPYi0ZtA1TBRvorDfOYMW4DhI=;
 b=jxuDe1lO2lHdU8meRrgg7e55yC6Das/DHzjzlP06lN+EFiSkP55DByayKn79egL+JaGdC8
 RLcftPtiS817fU5iBtmx7ygp86Ts8W30tnDwNqsCGV+YhgFLoJpZe2a8qvKZEeLLE/b5/3/w
 fSgdLXvqJCT8xQKGXkxmPlXAAKFCSDHvXZtKE44+zLti/JrI0jLH7QVWzlDPN/NHO5dJPVlK
 8vVnJ/Dsdi2vZ+jpO5r7WXXfSjiDeaQQBPN2aPfv6tmMVaaGU12mbqoFar5HYQA4w93gl+i7
 v2FBd/ZxuWppkjDgzf5eIJXaUr7lwQeFZDmOQ4Idjgfe4xbN6zhssvGA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v3 1/5] tee: optee: Factor out service enumeration and binding
 functions
Date: Tue,  8 Sep 2026 17:03:34 +0200
Message-ID: <be1c09bab90ef372999f78b8e369d8c0eb2d6246.1788879818.git.jan.kiszka@siemens.com>
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


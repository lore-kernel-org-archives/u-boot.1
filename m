Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AA8C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 06:57:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCE6780F2B;
	Thu, 10 Sep 2026 06:57:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dOlLpHuomT1c; Thu, 10 Sep 2026 06:57:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 11C3F80F27
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789023461;
	b=lUedoFgleTUprVvE6ZwzJOlg+93AXwHm2AvkXisenII4eq7jz+h/Xyqx554qMeLrMb/r
	 jDUtvFlLbeh7Qm12YIUDN5o9hckCJQbRC4tq8N6jmvPfm3rYZyN1rxccl/NfqUFeO92qt
	 4SJ71KGDdwfjNJQTAcTnVXrZbyViQX5eBTHCvkk2T/vSSDj42qbNKBbXeUk4vyWmx4vzv
	 PSZ6nOrS9hT+jCDx9QHoO72FVb5SI9shTcQBWDEXixHQ3YL51eshEFPoZiQxTQ+eVJC2T
	 q6UOwmhoc3qEUhdXS4JQfTQcVKBVc23884czMri6zR/aU6myGOb8nioXY8HGc8aJrWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789023461;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JdKEScWLAMwNxg1mnvGwgSUxTxfFZM1WFiCI4JJt2+g=;
	b=qI6UYk3x9vB7fBwRjaxL74/6zbNWu7zjHavV0WYbBZnL1INoORuaQRENtamj4XsKeUuX
	 JJorTCl0BQ/7I+/QeKNO8kpd/BiIW3q04mNoMGFCLd4pH7mpTp0zKlP9oQYGQnJqRrxVX
	 Rr+4Ni4ETtQC+J/OI2bYayTqxwy4q+b6B0Js7gxAiEEQqZ5Sl1rzdpLUk97ExvIxWyP32
	 3ncoRQi8QutJUtIQR5vtTBSPGNz62U0ppIRGw9qzL4lNZnMniWX3kaVhFTl+b/xgc4emr
	 evfciMIDPY7kaQxGxM62iz6uK0wFODI6/e7vojQbZbYe9zUveoHXNyFWO10is3UR5kQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=W8jojEo3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789023461;
	bh=JdKEScWLAMwNxg1mnvGwgSUxTxfFZM1WFiCI4JJt2+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OL4v8m8Dzzdgb8aAIGNkd+c1VdGFW+/bvksGUfvAu6etpbuuHEbIaPCu3YMkbD9LB
	 V4UiMjzidr9HqThJQrOEr0aT6GyOBqIc/3UXI51BpKw2bIIRrr4ej68b/gjR1+M/Rb
	 qjeRvqL0143IfZkBHmgj9IUgT9XziqB6MWVik0J6nCnr5RoWFAl+WhJ9KnF3FhvKSi
	 9Waka3Pz34SI+BaoQzznTcrpoK0twgOuK6K80I5wYUFwyyd10c5AzRr9IXNQMLLTvO
	 2D63l211UPULcA9qoBUn9fUu3mYIZPcE8SLrSFYJJslZUWFT5IXpraeCllehrBP1Ax
	 RHUmo02dCrrQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11C3F80F27;
	Thu, 10 Sep 2026 06:57:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 38F361F8D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2851780F03
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:57:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6zOAGuLOIxpF for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 06:57:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A2CA580F12
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789023450;
 b=iNnpnLhR0cSxhimBXojHMGsTi+fJTt0F1+m5UCgaGbC4zsGNWaCgjFfe3Fcilo1c3Vgi
 66HZv3mLAOL2zdiTJzTPB/EWte3dSEucF2wKY7QlKpNo7g/eusmqdP+B564RE7WqNB4mZ
 LxlHhYRyUCsSvBfE9eSI9Vas8xwDeWRgW87NyHEGNE5PsUWG2Rz3szowRTUsA6s7eGNcd
 Qmeba76oYASG+y8pBTxi3eQ+n6ymfpgMMAFlTZjg/g3wQ2EgPoJjAPvLXC669EvZJj2wc
 T4cRJ7undRc8uN72xPtgvFu/retC8yreUUQnAt9vERi3P67M4K5X6UUJWR9a9/79EMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789023450;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=JdKEScWLAMwNxg1mnvGwgSUxTxfFZM1WFiCI4JJt2+g=;
 b=LSok39NoxgMdqWmyFgEGMa0lwJBlQgOYkmGrw+X1GciYl58azYF1ahoHvQNsv4EeDxe/
 XHX76pdgbIa+7K8eJrrVYVy/4sFiy+7vRIij1aXS2aoe7Drnrx/s+9ZfnC+q+T+3nlwxy
 UPhvCu1pz2AKsn3cSOctUGNYms1HYJCVoxKHDO6nhYQjxoiRQCvUxqqaUWkltXvveljQO
 KwuDfXaYf3sdT7jotmOXg7B2PqcFISm/+wkb9NBk/oftWHoqh1rVRWkO1oHfDxmTxCi7U
 zzNLeVQyxLMQ4rVbLQyAsOUbW6GTB+cqSCMc35kEB7pyaLgFT2M4Tfffx2buasty9+Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=W8jojEo3; 
 arc=none smtp.remote-ip=185.136.64.227
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 10 Sep 2026 06:57:29 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=W8jojEo3
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.227;
 helo=mta-64-227.siemens.flowmailer.net;
 envelope-from=fm-294854-202609100656228a16b1031500020774-bqmc7p@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A2CA580F12
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:57:29 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 202609100656228a16b1031500020774
 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 08:56:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=JdKEScWLAMwNxg1mnvGwgSUxTxfFZM1WFiCI4JJt2+g=;
 b=W8jojEo323U+9bw5FDlqcM8WY2YYapIOMW3+hFtv6IwRoo3f4aW/yjclWQuEo7zDZ1OP97
 ngJ7cG6FgU8y6w4bHxZSMsvUCZC8MduHflqqZ40XeHBTDztH3ebo8ZPZRURjspLy6yPtxFNK
 tjVyULiaGZzpGW8Rj1/FaZhZm6Jh2ZLhGP4r32WEaa7EzZ0Iredbz1LWjlovBvkQBCH5exIW
 BpcAVE57+EFhicY+V5AAe4EB4mAcysju8EPMjqXynHVKY0ezcD5d6lv7GW48KUoz6lKZpUV6
 6eFk29BNpUq29MGJfC4T379spDThcwOrD0u435K69YOSn8+g5+kZFbWg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v4 1/6] tee: optee: Factor out service enumeration and binding
 functions
Date: Thu, 10 Sep 2026 08:56:16 +0200
Message-ID: <29956c47723aef641f02791d48c0ed7702ab2e97.1789023381.git.jan.kiszka@siemens.com>
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

This already avoids code duplication between the different enumeration
commands. It will furthermore allow to implement a third one for
services with RPMB needs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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


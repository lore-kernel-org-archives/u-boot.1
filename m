Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B5AC982D2
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:19:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F6FC60B6D;
	Thu, 17 Sep 2026 17:19:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ur0ibo_dgE6N; Thu, 17 Sep 2026 17:19:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EB5EA60B83
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665569;
	b=YC/dKHhDvEm1Jv8qx9zrQcUvo7FWGHk55KVX5DSP7nkekNZtT+bhqhQstkv9E6er/eTB
	 2P4PXS/w9C3TZQcSVVH7Ra37CNHIfkyNUe7fNzc6EG0mdNUKpZ1JjHH5xAG2Iwx7bcDvh
	 xgDvo/oEt1mY1ccdJrxwrW0LkjckUvw/WMf/qjYRFdsyXf54HUWemQv022gIz9hQdesJ9
	 LBU/qmeomWKGntiMJWncppE1OBTLu8EV9MR4ZtVPbyFrf/HVFqv0r1yGK4xw3DDq/eVrl
	 3iylol+4J/19u86/+Cq2tpveG88NR71tEoLD41GdqPVU5que6y/plXPEfG0b+3+wDGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665569;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sihYj5Pi861jvR1R7arEtkqQ2a7OC86cf+EU4EG1URw=;
	b=OEx9/ODhY3yak5fUonRroUT0yGJU2+tfSazy7vULKy5evO2uaT+qwtZktd3n8VvoFtMF
	 ss8q8Z3GfwGnJN/xYCQl1JZohMhVL1VWubZTc+D++6Rd15FLBNT1GCJUE/obzb0wmceGW
	 ph/lDA3tliGM43OIMMYcsK1X62iCtNoC0ELgSoysLoDDtZV47hOHyJXtdm4J/QUL+s9Z5
	 XmJOx5VHk6643JjNcXpOmt/4jWZyR+aze+nuw7Sx7zzwqh+g2G5x4Y0hgQhSSXyK5jcl8
	 DoOB+BZ7k44uPjTJCWTdiWelws7qE2bvpH48UNPA8GAcp2MgBLUSDeNleX11I6F1IQA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665569;
	bh=sihYj5Pi861jvR1R7arEtkqQ2a7OC86cf+EU4EG1URw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g+7D9dPN4ON03VAs5A5T1pXCE+THWwQJrL9KbTw0jjVs+yDQWgvM6zRjrU0XLhbmp
	 nEfmgnZ/Q8bfMJNDIT0NczR/MEcItlwBhRWHOQrcE7y0X3SGE+rUqMeMeewOP/CqE8
	 zAehrhvzpsKJqAqr7qzmEDT0rwdAkgzsGUeSaJEnn/SKTqZL+l39OsamNDr91YRLU0
	 iXGKdczoIh/dmZN6KoU5+nhInwLD1oHFImuSb7lzFcntiGrXZm9HeAGQ8q33nkSCuI
	 OQ2+yK/00tw0F612PwxkBVXaAYW0DeDND7ZdR7Sb3s9PeU66M0fWcQ53D4zo1IlTnm
	 j46vfGoRl5XEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB5EA60B83;
	Thu, 17 Sep 2026 17:19:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A3E4422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2CA5240446
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SR-VUbsWq8KS for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:18:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8D0E240427
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665523;
 b=OA6BZEyaPMtoOgq4qCVaD0AAR7QKtJGCCUXG+IV/O3HBa8kRUot7DLy+47tTJ0xvOVAD
 X46JNFGmzNyQjrSu9arfFx0Ui9YmYrSI84UtQ+8hiGYz6zXj4lgiy7uK7l/pPCCboHjdb
 cLTWmxWUleTzoJAmpwyI46NNNSNxLtXeGKYpXBIC2n/pZnPZjdHabeX1wDBPt7f83VRR0
 Mnq5YWWkiWX2BQffgseYcSvv4LkdCavJWDY48HcFkwoZxeOnsyEEd9xRqyTtwfBKqbtE6
 vETLu3lXBb/UzWP90Ms3dRonVCpaYOzgvAHo7T8vOEmGX2a3qDDFwBVP2hCONpks7Pw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665523;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=sihYj5Pi861jvR1R7arEtkqQ2a7OC86cf+EU4EG1URw=;
 b=rFLOjhgsxJio3wyWVsXH03eh9yYpwSXGd4eiwKXZqMbK/XFjxArh8brE/6RO5oIj1Jmu
 LaQtdxTqEHdsDGUylqAmI4JJ0W2H9HJP8DSiS8H38ZculGypb6+ps0axdfOqZxoqn0pEi
 OhVpELAvJuqzLytXzJyrt/RoGdq9Mm+Dk3n1XlJzvd5hN5YcmYKurH8j/tDMmXFepEN77
 LzRnAe+CIaWIBMnPFVHQlzdk18qXYeGui5A+DjQDUysEdkrRyZtsuYP9pjUDS0Ac7NXO3
 1ZlXZAptw3NEJ/cd7XnHy421OZFPI69twMRItw0CTBX29KnXD6UmsAXDwoPc4I5gqSA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=I0aH9SVT; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=I0aH9SVT
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8D0E240427
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:43 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 709C31596;
 Thu, 17 Sep 2026 10:18:38 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D70F33F7B4;
 Thu, 17 Sep 2026 10:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665522; bh=sH8h6mIYvqdUEmDb5heIdVINGNar9GvmrobPan1kbYY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=I0aH9SVTW6jqHjzrKIKAV+0RqUNpQd5Ckpl8OiKW3dist3/PNTpQbDHeAY0ezblqC
 JiI2ZKsHRJqPSYA7w/29VEUXQseGlx02wFrSICqVR0nu66kswNUEYJuttKP1DsmolM
 YkfIV5r9x7i9ZC51+MHipibPmRqivc0tX65OQ6Gg=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v6 03/24] arm_ffa: sandbox: Replace the emulator error log
 with debug log
Date: Thu, 17 Sep 2026 18:17:49 +0100
Message-ID: <20260917171810.4122899-4-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
References: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 17:19:15 +0000
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Set the log to a debug log and reformulate the message

The message is about showing what the emulated FF-A ABI decided
based on the user arguments. The log is just for information purposes
and helpful when debugging.

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/firmware/arm-ffa/ffa-emul-uclass.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
index 6198d687354..1cdd188b6fb 100644
--- a/drivers/firmware/arm-ffa/ffa-emul-uclass.c
+++ b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2025-2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -655,8 +655,7 @@ void sandbox_arm_ffa_smccc_smc(ffa_value_t *args, ffa_value_t *res)
 			args->a0);
 	}
 
-	if (ret != 0)
-		log_err("FF-A ABI internal failure (%d)\n", ret);
+	log_debug("Emulated FF-A ABI feedback (%d)\n", ret);
 }
 
 /**
-- 
2.43.0


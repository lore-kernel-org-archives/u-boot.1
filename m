Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7761EC79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 06:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A9C440A21;
	Thu, 10 Sep 2026 06:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ezojgr-0fQyy; Thu, 10 Sep 2026 06:57:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6654240944
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789023466;
	b=Zc3Ei/1cYrUr6eTR7x38yucbtNBoStpjf+l4GIDHF0Ik5eyDk2btH15biRH8ox/433zq
	 6t2tvAnzwx8LsVvBdJFkTdDQ4IabFQ4sWDpr+UfzkvBnbvCgPcvvNsVCAiIYDLVhcU/lR
	 xam6crpTOMSZypLaLPg2dPd59/TI3GQvfoFRcMTmwLv2LRD0Th6PIYMQf6AWLa9xRvMvY
	 YqLFfQKhOB+6PTi8N6oYUFqkp2rf+kyZGm35zwCh0vH6Ovf83N9CBKt48Sn2UveUNEgEN
	 mSRqsuNBwoSvBIEL0aUs5EWW382voz7Pw3dmF+84J33pv1EIJify2qyyf6mQJMyLWHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789023466;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=G1fY8U63nje64VVx0XCdA0l8k5Fts2JRQXMEAKXNPlw=;
	b=LmTCczyfZQEVuUx1f0bvKWKXPwbApGxn0QTWHBWoFpwJygrAa74CqB9omIsn5GJGdMCc
	 I/VvfywukHmPN/prkB8unA5CbN8M1zuy2zB7WvpxZIn8dk00YVxsoYmddEc6O83yg57Io
	 dvnddvV/pPUNiqNMB/jT1l5dYGJfPw0ebqpCD4EhesWnLk0tRQDqqJSEE3hR5S4X4QHij
	 MpdbhgRtO8ZorTaDWpdhml1jVW6txkpHujYPiedZzpMwsEUlkC/sEp7jydUfS6HhG/sjm
	 /s+veisRKsFO4kuawJFWBLyj35n0yhM/mqgRaHvtYN9f2KZPWnR5RuB7M4K9JVviK3g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789023466;
	bh=G1fY8U63nje64VVx0XCdA0l8k5Fts2JRQXMEAKXNPlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mRt6yhjVke2qTox0JOuFo8CecqdgvIaJ5VW9VSxp33RywTUbgAa/2id1cjKvPKs7d
	 GzNv/dqa6C3Xt+kEwuNFsDH9aVfoCSiVXu0cUxMFZBBar5+oP49O4Jvb35Rmk79MVz
	 L8cXHmUlYVhn3kyF/7gFD3xZ9SycOKbjwXtKj36w6CFSUBATEX/eQh95UMtN6iYN8T
	 FYQ99KetedCVGDu8QOpgkdlCpvBqbCgl6iSYU4gHBwLm4qZbyqqPUGBfEgNJCEHBs/
	 pz1S9lO1X1I0n0K+1H0U5bT00HIlt9LC3aouCuOKDjTxwEEnLPn52gA0ZDnnMut0D1
	 klZZLEbtFPinA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6654240944;
	Thu, 10 Sep 2026 06:57:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F2792E3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:57:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1093F80F00
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:57:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5iIzu6LP2e4z for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 06:57:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 031BE80F13
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.226
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789023452;
 b=QLJy7Cr89S0TD1ZOnGTrUKm6rAychgb6q5CJDvvXIU+pfferqoa7zU1oUlukD8bsEWUj
 XPSwJWzLMYzOsq77olkJNrinPoL/ofbJHph9RCgQsV4ojgpCtR/XiYCNaqPtiN8gSTdBP
 E2SoadPXRqhrpYDDQi0khKN44BkbwQF9GdcY3zoE1LAmq1yIZIIsJBEvgko36Hgr3Az/n
 Wei9dgrVOqlaooS84s9L6IsX1UXS1OjTDRwhJREWajasrPZgmPDBMzgV/ywkXH8Zv1ttA
 X7IUrHrsFNzLgKAO6yMqbVnNfNzDM6SvP6q2pCFhPdQ+YDt66dL8w6p/UWqoc2xHo+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789023452;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=G1fY8U63nje64VVx0XCdA0l8k5Fts2JRQXMEAKXNPlw=;
 b=BO6yW8ILAAsX7z412U3t1v1/s5bE++zeS59BymRMAe0ZXpsDxYcHWbHnN8CA7y1P1ElH
 eCspq2c2c/BR8jyONo1yg/UzoWz7jVpo+2/ybB6ni0kVUjG5MfSti7sRbhNSseaBtsuoF
 pTjXGqPqwK9zymfPCfxW6lAo3Z09zZgGCj9XJN6HOTmc0LEZ+t61/LAwMwduf2+jgghLg
 ce2CSPVP0ylYS5faE8n9NHdjsp1762l1pXihkAWQcglxH56ZXgXf/p7uN4S8rQoGk2noS
 gw8O4WzyesZq8LjfVK49p0+PCibWeJ5cX+X+0d1SdFm9ABVLaUm10trQO2+WFJPw0gA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=aVp4m9bG; 
 arc=none smtp.remote-ip=185.136.64.226
X-Greylist: delayed 64 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 10 Sep 2026 06:57:30 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=aVp4m9bG
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.226;
 helo=mta-64-226.siemens.flowmailer.net;
 envelope-from=fm-294854-2026091006562382ca2574e7000207e7-nkqlvd@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 031BE80F13
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:57:29 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 2026091006562382ca2574e7000207e7
 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 08:56:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=G1fY8U63nje64VVx0XCdA0l8k5Fts2JRQXMEAKXNPlw=;
 b=aVp4m9bG21QvhxHfrWU1tcjn0IC/zYQC1HIjYw0v8f0QiVzzKM1hC49fZc1dlTb+sL6mab
 fG8OXlmPfAKWRtURA9B0Dw2/cSuEqe4lsG7AB076QMDs0D3SvU36g8+jMzkvBEEl/rpaMC81
 sgXy2Dujq9DmkOMohIPY+/MwZy/M+FvDHtc1c+gZohquIV/0ICgTg/337yEIxU3vFcVLfpfY
 5zRanSQ2VxHPxj77s4LZ9madVN4WO6Y118TEWsfXsGtus2w80pREp6eH/HT8ac7em5Nmf6DI
 Zdj4fLFFlztnK1PCJzp2YMSuodVqPe86Cx+oJ/a1ElZfl9pt1tJs6vJA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v4 5/6] mmc: Call back to optee after a successful mmc_init
Date: Thu, 10 Sep 2026 08:56:20 +0200
Message-ID: <05f13f7b9b886c7ea0b826fae352a59cf07b63eb.1789023381.git.jan.kiszka@siemens.com>
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

This is needed to that OP-TEE can re-enumerate services which need RPMB
access that may have become available now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
CC: Peng Fan <peng.fan@nxp.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/mmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 670e92ee12b..2463e50cd3c 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -27,6 +27,7 @@
 #include <linux/list.h>
 #include <linux/printk.h>
 #include <div64.h>
+#include <tee/optee.h>
 #include "mmc_private.h"
 
 #define DEFAULT_CMD6_TIMEOUT_MS  500
@@ -3168,6 +3169,9 @@ int mmc_init(struct mmc *mmc)
 				mmc->cfg->name);
 	}
 
+	if (CONFIG_IS_ENABLED(OPTEE) && mmc->capacity_rpmb > 0)
+		optee_rpmb_available();
+
 	return err;
 }
 
-- 
2.47.3


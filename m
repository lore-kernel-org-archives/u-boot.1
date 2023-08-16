Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40BEC001E0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 15:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A595807C9;
	Wed, 16 Aug 2023 17:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="T+EswpWP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="k5l3oMX6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8653B86A02; Wed, 16 Aug 2023 17:06:31 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B07869F1
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 17:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RQs0h22Dtz9tFp;
 Wed, 16 Aug 2023 17:06:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692198388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ElHclPz5n9Empgv3fPXn448XOl/zO0CDl18D8mzcp2E=;
 b=T+EswpWPjfgnE4R/r5sLwEPBos2piCZ1TEEoavVF7DST7mQON162I6FTjkiFjv4ALc66CL
 NBW+HgNgnQPEpbManeN7DO0rbkwnmCLWxHuzf2Kgh4Y0qZ68/LhtTvtn6Gqf5sEaB3GYJX
 Y4I567Lac1pET5QWKLS7cs+DcjBHjtA4CPTgrRuCpxP+y/EyAWo/NIWGtLfyl9ttVq2L0T
 VYWYzvq0SlTN7/fyjKMwHjpnK5ccuE7DC8jBt86xy0nuDijh61Q/8RTCxoSHF7bMC7MZYS
 i2Ar3WezzlYh9pYEvpS+tX/dF5NHxM9jqajATpV5R+YAQNRYVHrryyNwlQT/AQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692198385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ElHclPz5n9Empgv3fPXn448XOl/zO0CDl18D8mzcp2E=;
 b=k5l3oMX6TKa0kBsl+SKIYHE3fd9ujJvYYyERSvbFKd0Q4D02lqqlpG34VG4Dpw7wrXi4eF
 D90jejAPoYukUmGuwXkJ5Om8XeLjcYbSKQLcctyIo770GDgC12irkuQ2EFpHBI1coG8ksN
 3U6SPzymS89URJssBfQXwAYRKrLP+XaBPEEgD7sevIkY0fEVy5e9dYIym7akSTwnqzENyA
 HONXSa77qk9S3mCqdU8Mk78556GaGZaqDvtlzfNoG75XX2k6gqesTEbnYqtmJEAcIfVUUK
 BJ7KE9ihLA78q8feF88nCm0xonr8Oin29LRPIw8uUGwDTcFQSmIu7gjJwDajWw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>, Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 6/7] ufs: Use utp_transfer_req_desc pointer in
 ufshcd_get_tr_ocs
Date: Wed, 16 Aug 2023 17:05:54 +0200
Message-Id: <20230816150555.245028-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
References: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7dbb84848ca59ce60aa
X-MBO-RS-META: qe8ppx753zts9gjofj7mme7cmmadt8zb
X-Rspamd-Queue-Id: 4RQs0h22Dtz9tFp
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

Use utp_transfer_req_desc pointer to reference to utrdl queue
instead of referencing the queue directly. This makes the code
more consistent. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: Faiz Abbas <faiz_abbas@ti.com>
---
V2: No change
---
 drivers/ufs/ufs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index da1009e2c14..041caee714f 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -858,7 +858,9 @@ static inline int ufshcd_get_req_rsp(struct utp_upiu_rsp *ucd_rsp_ptr)
  */
 static inline int ufshcd_get_tr_ocs(struct ufs_hba *hba)
 {
-	return le32_to_cpu(hba->utrdl->header.dword_2) & MASK_OCS;
+	struct utp_transfer_req_desc *req_desc = hba->utrdl;
+
+	return le32_to_cpu(req_desc->header.dword_2) & MASK_OCS;
 }
 
 static inline int ufshcd_get_rsp_upiu_result(struct utp_upiu_rsp *ucd_rsp_ptr)
-- 
2.40.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36908D29C40
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 16:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B16A080B98;
	Mon, 19 Jan 2026 17:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="bjjWvOtO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF96E839E2; Mon, 19 Jan 2026 17:08:02 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6E2E8003E
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 17:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 52F754E420E8;
 Mon, 19 Jan 2026 16:08:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2943860731;
 Mon, 19 Jan 2026 16:08:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9AF1E10B6B190; Mon, 19 Jan 2026 17:07:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1768838879; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=5kYpoZriOsxx+XoIvUAa6ZhP6fsjNGqSHQ7dhxZ9ojI=;
 b=bjjWvOtOEtVslTfbAMlb0Rk6d6FeJse8NBJHBWVAkq7IxevxDAkUYsUisd0peGKl3r6PE1
 ZWuhCpOV/HPVlxiEAFdzD3IA5lcTfo0tu3wlpSIHQWbTIxg8GM8KspdxbhbthUMdUzeKnZ
 PsVYTxAgPX1fVB0ZArKWLySmCtbASLFwPgChq5GAxFeEuW6YQDlOnrpcraV91ZqD4PuZ6U
 qCXQQdWQqEiKxj4ekqd+ROg9TIMj/gNVBqVIaX8/Fzu53N1uqyuLXroUNJsNex5g/5dOvz
 2RMrwuWrizKVWkArrGUgqZbqYFrMDuMY8/ds0ZWRO2OejvVsyyDpg0OjOz9Vkw==
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, thomas.petazzoni@bootlin.com,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 2/2] fwu: Mark failed bank as invalid during rollback
Date: Mon, 19 Jan 2026 17:07:42 +0100
Message-ID: <20260119160746.1330877-3-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119160746.1330877-1-kory.maincent@bootlin.com>
References: <20260119160746.1330877-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

When boot_idx differs from active_idx at boot time, it indicates a
rollback scenario where the firmware update failed and the system
reverted to the previous working bank. In this case, mark the failed
bank (active_idx) as invalid to prevent future boot attempts from that
bank.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 lib/fwu_updates/fwu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 0f5ef2ba515..37c613014d1 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -766,6 +766,12 @@ static int fwu_boottime_checks(void)
 	if (boot_idx != active_idx) {
 		log_info("Boot idx %u is not matching active idx %u, changing active_idx\n",
 			 boot_idx, active_idx);
+
+		ret = fwu_state_machine_updates(FWU_BANK_INVALID, active_idx);
+		if (ret)
+			log_err("Unable to set bank %u state as invalid",
+				active_idx);
+
 		ret = fwu_set_active_index(boot_idx);
 		if (!ret)
 			boottime_check = 1;
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D289C47DAF
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 12:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7676C877BB;
	Fri, 19 Jan 2024 13:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SL8mihlA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82F1A87A2A; Fri, 19 Jan 2024 13:49:22 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A6718746C
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 13:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EA7B861908;
 Fri, 19 Jan 2024 12:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98897C433F1;
 Fri, 19 Jan 2024 12:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705668558;
 bh=IwiRNNeeYKUNf2tOiXrJUuV4qcMzFgBzg0dmquUN/wk=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=SL8mihlAA2vw99XTCC9dLPGpZxB147aecVkLSGnIogtmjaV7ouNGrPp3F/6jbKYtI
 S4ncdcvNTQDsAsKHVg7aEZ3+Dszdm7sK8PrhJOTQVZlzEer78LhgGLcVQ3KWM6MYPg
 5nuKDZLUb0A4PW4MQHjfmDxktiDmmH6dbwEAyYv5RdnHhRqu6YA0OCw/aRj+v7ndr5
 jo5WbbvCU5Je9DuDxLNCu0pMoL1VeVi4DmMgDsRm6uOZmWal/wx5DxKrRacwU+qniU
 c3QsW+KqqlXew/yhPX76TTSKJrkQmRBWehXNN8v9EKEZgUp1VVapZIRJnAB7N4yY+q
 kp/hBboOYbjnQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 894DFC4725D;
 Fri, 19 Jan 2024 12:49:18 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 19 Jan 2024 20:49:17 +0800
Subject: [PATCH] reset: reset-hisilicon: also handle #reset-cells = <2>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240119-rst-v1-1-894c88985f5a@outlook.com>
X-B4-Tracking: v=1; b=H4sIAMxvqmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQ0NL3aLiEl2DpGQLA0vzJAsT80QloMqCotS0zAqwKdGxtbUAsn+tFFU
 AAAA=
To: u-boot@lists.denx.de
Cc: Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705668557; l=1371;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=xdBog517xIp3ODBZpffzQFiYeYTTPeK84K24y7OXYd4=;
 b=CDLD3UbrtRppheSP7oKn3pv3H6J5Ce/xmkzn4jKRK1N0Fragon/JyuwysHPmPiREo067cEDg0
 cXViLvoqxblCO3XHWLorgzF3/WFID6v+59d1UQlcEUuYujPUoERTY5m
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Yang Xiwen <forbidden405@outlook.com>

It's also valid to have #reset-cells = <2> while the third arg defaults
to ASSERT_SET.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/reset/reset-hisilicon.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-hisilicon.c b/drivers/reset/reset-hisilicon.c
index 8152cec227..85e02b296b 100644
--- a/drivers/reset/reset-hisilicon.c
+++ b/drivers/reset/reset-hisilicon.c
@@ -49,7 +49,18 @@ static int hisi_reset_assert(struct reset_ctl *rst)
 static int hisi_reset_of_xlate(struct reset_ctl *rst,
 			       struct ofnode_phandle_args *args)
 {
-	if (args->args_count != 3) {
+	unsigned long polarity;
+
+	switch (args->args_count) {
+	case 2:
+		polarity = ASSERT_SET;
+		break;
+
+	case 3:
+		polarity = args->args[2];
+		break;
+
+	default:
 		debug("Invalid args_count: %d\n", args->args_count);
 		return -EINVAL;
 	}
@@ -57,7 +68,7 @@ static int hisi_reset_of_xlate(struct reset_ctl *rst,
 	/* Use .data field as register offset and .id field as bit shift */
 	rst->data = args->args[0];
 	rst->id = args->args[1];
-	rst->polarity = args->args[2];
+	rst->polarity = polarity;
 
 	return 0;
 }

---
base-commit: f7cca7ccc5117eaafcc2bde91ad1bed6fee7cfc3
change-id: 20240119-rst-0bc8097b847a

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


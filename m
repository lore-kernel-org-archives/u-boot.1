Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDF8C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 09:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38F88883F2;
	Mon, 22 Apr 2024 11:48:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ltts.com header.i=@ltts.com header.b="xdl3O9VL";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="prBLD12J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A132B883F4; Mon, 22 Apr 2024 11:48:50 +0200 (CEST)
Received: from c180-43.smtp-out.ap-south-1.amazonses.com
 (c180-43.smtp-out.ap-south-1.amazonses.com [76.223.180.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83994883F1
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 11:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ltts.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=0109018f05353fb6-8b802241-003e-405f-9692-222be61ff00f-000000@ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1713779327;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=EJkF4KgZT87JdnZrDevfhKLBCd+6ohttHlcNqsRRg6s=;
 b=xdl3O9VLXf/6Q8tl4CH937pBCkkp7mKp6aocQsP85YyxX5sX57owDh+9Nhl1a2UO
 yuMP7rupOs/DgnmAgEqSE3G6CYwgk5kFIIJ12a/SJOPAkbfL2MvxKDeBGaNHdAigzQK
 7uH3brtbptw9tQYFAntXtvghKOQ8lD76OGORp0NL81LRB1MuxCbRltVSvz4kY1DzhNt
 1NYmSqFagP9whOdryccW0itmyw1S9TnloPqIgZpoCeLL8pz+4lHxeG4glN0UZtQ24oC
 aHT3J11HmJ2IhoRllH4btpinu1hmjRIOMfyQ/2mTZt2k08pQfRTd6iexKQ3VyABrHwZ
 tarBCtFWBw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=zpkik46mrueu52d3326ufxxchortqmoc; d=amazonses.com; t=1713779327;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
 bh=EJkF4KgZT87JdnZrDevfhKLBCd+6ohttHlcNqsRRg6s=;
 b=prBLD12J6H5UvOn+irwnW0zdI+UWUx4Gbd/GfWl9wodfB9WKv3q9KF/ff4c2HMdW
 nWUVe8m5LM43HnJ9co7mtyIKA3BWa833eha56j0gHKV5eM/21Uzhwv+WcUi78MopYsF
 NmBIYmKjTPYsxu3oUbpzHongTDI8mkqR2S/SMUdw=
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: u-boot@lists.denx.de
Cc: d-gole@ti.com, dan.carpenter@linaro.org, jh80.chung@samsung.com, 
 sjg@chromium.org, trini@konsulko.com, m.nirmaladevi@ltts.com, 
 Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v4 2/5] power: pmic: tps65941: Add TI TPS65224 PMIC
Date: Mon, 22 Apr 2024 09:48:46 +0000
Message-ID: <0109018f05353fb6-8b802241-003e-405f-9692-222be61ff00f-000000@ap-south-1.amazonses.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0109018f05328901-68599362-7b54-47e2-b54f-aa081ca231b9-000000@ap-south-1.amazonses.com>
References: <0109018f05328901-68599362-7b54-47e2-b54f-aa081ca231b9-000000@ap-south-1.amazonses.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-south-1./RC/PI2M8xOxQmTMPi0M1Q8h2FX69egpT62QKSaMPIA=:AmazonSES
X-SES-Outgoing: 2024.04.22-76.223.180.43
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

Adds compatible and data field values of TPS65224 driver in
TPS65941 PMIC driver.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/power/pmic/tps65941.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/pmic/tps65941.c b/drivers/power/pmic/tps65941.c
index 727b42747a..ef63eb733a 100644
--- a/drivers/power/pmic/tps65941.c
+++ b/drivers/power/pmic/tps65941.c
@@ -75,6 +75,7 @@ static const struct udevice_id tps65941_ids[] = {
 	{ .compatible = "ti,tps659412", .data = TPS659411 },
 	{ .compatible = "ti,tps659413", .data = TPS659413 },
 	{ .compatible = "ti,lp876441",  .data =  LP876441 },
+	{ .compatible = "ti,tps65224",  .data =  TPS65224 },
 	{ }
 };
 
-- 
2.25.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DE2CD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 15:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A0A4848A1;
	Tue, 19 May 2026 17:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="agRrNu3p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD10C8488B; Tue, 19 May 2026 17:21:11 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4A4D84870
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 17:21:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-439bdb1d75bso2395118fac.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 08:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779204067; x=1779808867; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gBBtE9L2RkfdYrx5mVjo8AQiFYiIUmnPfONdjRkDH5c=;
 b=agRrNu3pJFtpPMNJFuamWLMjdcomskd/Ms59RIGRd8gyaGuLWdS5vktXEZz73Kduc0
 GY9ygJ6RSYwHCOVCkYqfozp70ownecM4w67IyM5ohndPEzNctM414hXdqdAqMaKdkxIP
 SpjIuh5kkwxcbnonfudDQ8KaJ6S9y0kAdP9lM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779204067; x=1779808867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gBBtE9L2RkfdYrx5mVjo8AQiFYiIUmnPfONdjRkDH5c=;
 b=Wdik2nQM9e5BqiJtGpyqaw3CbvHSCMKtXLMzT1nudiPrzumsU61ilqIF0betqKAzFX
 DZiK/htGjz7Ykhfndef3szFDMPBhm1WWX4oxG7dBnll7r7EMHk7uAbEPXsA0//nViEyN
 /KWib4cbxPRYZ9Q0sfqgBycvUtR+gvlIPvSOfvmY/IK5u1yQd+QLIa2Rf0leR6rsnXRa
 FI53BB6ulOTCb98A3p65NEdzHZJTHABL0m2uC+FoTuSCg4sjgUGyBeBVCbCjzFGYBvdq
 SRiJQ++oYg6hujhgyUaTdrhU36VXj0G/apuVGAgNmgmYHtYARQA0NY8e4vcKmlwJ/+Hh
 DM7w==
X-Gm-Message-State: AOJu0YwULmp7Sb7OCJjiye3dM+PKe+FRdQ5yAJtlDpqexvB2w3sqMO6z
 eqDrwGZl7dn45F9ebQN8jjGPp8hCd9JD+ayJqfGpLaimNGUmpTg9UDZD25rfVTpbS5GTwR9mQAw
 q4NzeH4zY5R+w
X-Gm-Gg: Acq92OHNlsq6BIeS7t1e9tkuAlbiMTpRkSrckhrD1OFyo9qLiy4H4bOVK/W+/CWHAZZ
 eKMU1En/cpNkc5E49UYiWIl/ZQDsjWB74De2Ql9E1TSH0KKI9nkqGEH5oOAk3x9TBAJpXp7OaGO
 dpOG2oZWekrr80KlS6kr/BxTSPDcTbxlg2SYIGtTKP6+2wupDg/Cz9py98qN0sfuU7RFEt5Gv02
 wlPLuKLFKpGFybRxLxfCQefW32S8ELBdP+8R88rwxwBZegx6bAQBnP+jaq0k8nkpEnv07ZqRfw8
 YFtp1llReuclLJBH5wKe2ZVXKBxFOBbnsII3ygy5bQFJ6eZb/vbpNICeMbnvmswQPiMaIMqguw7
 pVYfSNunwITAlNbz26q2fWPZRIf6VQV9AY6F3CfJadL2Rp2qSmwpPIJBBszxQSWKhrJghYojZ6i
 ZS1m+42NfgxQFNe9BnItj+JOiZ3aEekcSYgW/5uPY0D4oCJjJcymhYzdI+4Hgy11EkdYHogOPEK
 TLumnOpC8Xdy3BTkr/0PZ+0EZNA+TZDbneXvttoEahUtI7cyxdr+BSNJ7OAsXpkkXjtc3WBY7H2
 0m++s2t7KA==
X-Received: by 2002:a05:6820:2206:b0:69b:e750:15a2 with SMTP id
 006d021491bc7-69c94318cfdmr11301111eaf.25.1779204067519; 
 Tue, 19 May 2026 08:21:07 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a9576cdb2sm7170167fac.16.2026.05.19.08.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 08:21:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 3/5] ata: sata: Drop empty bootdev_ops structure
Date: Tue, 19 May 2026 09:18:18 -0600
Message-ID: <20260519152101.716714-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519152101.716714-1-trini@konsulko.com>
References: <20260519152101.716714-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

We don't need to provide an empty struct here now that the caller can
handle this being empty.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/ata/sata_bootdev.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ata/sata_bootdev.c b/drivers/ata/sata_bootdev.c
index a5ca6f6fd5bb..7d5ef3c94bfa 100644
--- a/drivers/ata/sata_bootdev.c
+++ b/drivers/ata/sata_bootdev.c
@@ -37,9 +37,6 @@ static int sata_bootdev_hunt(struct bootdev_hunter *info, bool show)
 	return 0;
 }
 
-struct bootdev_ops sata_bootdev_ops = {
-};
-
 static const struct udevice_id sata_bootdev_ids[] = {
 	{ .compatible = "u-boot,bootdev-sata" },
 	{ }
@@ -48,7 +45,6 @@ static const struct udevice_id sata_bootdev_ids[] = {
 U_BOOT_DRIVER(sata_bootdev) = {
 	.name		= "sata_bootdev",
 	.id		= UCLASS_BOOTDEV,
-	.ops		= &sata_bootdev_ops,
 	.bind		= sata_bootdev_bind,
 	.of_match	= sata_bootdev_ids,
 };
-- 
2.43.0


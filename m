Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C72E7E0D0
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:12:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE05383D0F;
	Mon,  9 Feb 2026 19:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GQvSwOqg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34F0583C61; Mon,  9 Feb 2026 19:12:06 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3236683C65
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:12:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-59e499a40easo2784037e87.2
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770660722; x=1771265522; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5nqTUtmL+Ys3cAGmGaCCmd9jpWvO9ZIjUZckO7XTvUg=;
 b=GQvSwOqgcI80760mHFR0SMMGOck+L0LulHr1STYe7tXZO5u00z7/iw0PB5VJbr0HgR
 5gSaCJfV7ix7Wg9vnmvhCPYFc3lh3HnbVntJJKfvoKbHAxQHFSB2gWCnB+3K4cWJr895
 hJA1kK4X0b1n8Yt8m1GmmLDzjtz5gevtRMnNzpU6TfC0uL9ph1lamXvTJAcbmR46VTOu
 xI9h1SBvITt/cd/uOYcDZMyUr3TCd8IIIZBimVR2xIJSOUsPuKY29C/74Vcdn5l64wnr
 VpnmU86tmRD/T5velFADg9AUj7FyheuZ1WClPFTn/RnKjTkDQwt685AXJQOwbCsFZN6x
 621w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770660722; x=1771265522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5nqTUtmL+Ys3cAGmGaCCmd9jpWvO9ZIjUZckO7XTvUg=;
 b=LiBdnhcvvZBmQYRoyAb/aWhbVJ+AYxr2t3BdFxaGPovp5ql+HBz9FHN1LRsXn9h/Kv
 oplaZJjsFOrSmhioNduowUhZyf8irjrPqJ0QOTl7sz5WLygPRhb8V58SfTlfONrXxav0
 ZSRwkFhzJSIEBpWhhwKZrOt2F9vyPH0JtLCcLhFGXyaUD7lnh8VsEyh6vPNsAnPl35Ax
 hy0oHajWJC32uMgzR7CyOGcNlH2c5/kFEpK6PUUpHOTES6eNCzMlN6ICyeTTbNFWViM/
 OLaXFWtVXe35cOK7fC8zqpb1QpzYtyywB8hyvnartBsv0R3gO4sw32MU3wG5DtglRJSz
 XqcA==
X-Gm-Message-State: AOJu0YxWwwjB9f5Z5GK9sgVhPi3XwBj31eAn9FSMi1afg9ZqF0jWK54H
 msFjWPBIf4IS5QzEa+FZ3t3qZFV4Yk9EiaVRjUuY02KExe988NvxheKA
X-Gm-Gg: AZuq6aKo2ugQcpuZAc+yo2kqovEQJMDO6y4mXbFcFQkMm5Jk9pOfPdckGTpLIeVU/xX
 qWfYqeEqW8+NiMLo0UcjXF9GjxXPe5XWsTZWBBVAC4WIj+QWT22uiG/oNwgOC5Alk1fhJYNhlUA
 pFSfNUnWScPD+PncMb8Wi3gR0DS35nAkwetSPbY13lZQFhpkdY65wU8jbVAWPPLyg/JdihhiuA8
 R4fKpZ2ELKCqTaLWzidQR6g07ESg1IABH41vTerPgrgsXf1fCvcx4z5CPB81roEymgQid3h7c7I
 CZybPXgi/Bqqpr3V+n9GBBnKEOGIgpvNEYhtaf5G7GwnndsMIOl8xjwD4fYkM7dJ3R2WbJaYZF9
 cQfgr6rFPOvbtdrYXpY/l3fsgDNBZg/BqdfOo5eeck+4EH82DE3msx0Id5WQml11czTGKX1XsAG
 IY
X-Received: by 2002:a05:6512:3b29:b0:59e:2242:fbc with SMTP id
 2adb3069b0e04-59e4514a1famr4135415e87.22.1770660722273; 
 Mon, 09 Feb 2026 10:12:02 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e44e25e4bsm2792801e87.88.2026.02.09.10.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:12:01 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/5] power: cpcap: make regulator node names case
 independent
Date: Mon,  9 Feb 2026 20:11:47 +0200
Message-ID: <20260209181149.32714-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209181149.32714-1-clamor95@gmail.com>
References: <20260209181149.32714-1-clamor95@gmail.com>
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

The Linux kernel CPCAP driver uses uppercase regulator node names, while
this driver uses lowercase. Since regulator names can be case-insensitive,
update the driver to support both uppercase and lowercase node names.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/pmic/cpcap.c                | 2 ++
 drivers/power/regulator/cpcap_regulator.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/pmic/cpcap.c b/drivers/power/pmic/cpcap.c
index 2fbbc7e80f0..b9d783773ed 100644
--- a/drivers/power/pmic/cpcap.c
+++ b/drivers/power/pmic/cpcap.c
@@ -14,7 +14,9 @@
 
 static const struct pmic_child_info pmic_children_info[] = {
 	{ .prefix = "sw", .driver = CPCAP_SW_DRIVER },
+	{ .prefix = "SW", .driver = CPCAP_SW_DRIVER },
 	{ .prefix = "v", .driver = CPCAP_LDO_DRIVER },
+	{ .prefix = "V", .driver = CPCAP_LDO_DRIVER },
 	{ },
 };
 
diff --git a/drivers/power/regulator/cpcap_regulator.c b/drivers/power/regulator/cpcap_regulator.c
index 15426675066..0fbce57048c 100644
--- a/drivers/power/regulator/cpcap_regulator.c
+++ b/drivers/power/regulator/cpcap_regulator.c
@@ -229,7 +229,7 @@ static int cpcap_regulator_probe(struct udevice *dev)
 
 	for (id = 0; id < CPCAP_REGULATORS_COUNT; id++)
 		if (cpcap_regulator_to_name[id])
-			if (!strcmp(dev->name, cpcap_regulator_to_name[id]))
+			if (!strcasecmp(dev->name, cpcap_regulator_to_name[id]))
 				break;
 
 	switch (id) {
-- 
2.51.0


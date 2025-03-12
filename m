Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22605C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 13:01:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C21781335;
	Wed, 12 Mar 2025 14:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SRm6yIBg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33F1180756; Wed, 12 Mar 2025 07:57:24 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9CE4801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 07:57:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sbellary@baylibre.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso44981025ad.2
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 23:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741762640; x=1742367440;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EI4BJTn7dDxBBNHi30ajgG1L4j1CjJA9lDC1PrnAHc0=;
 b=SRm6yIBgiKlXBqGRjMQnMYrFcr83QkNniy49Z6EwgTrNeuIP9hO6AgxkJzZ6gB9Lgl
 Lsomwh4sPuoE+J7eilQy3oPvNTZs1LsToM5y/K52pGx9UHGJ0VxpEg3tFfNucJ63fu+y
 67sy2A7IPdn+30a+q2bPojWpv51MRAKHTZ4gENLfbiVJuG0cuTRV6XJih+uBKMiRle3B
 aV0SoaV9UkVLtqjEtG54Atfnhq4hY+YQSSXBzeCHeSw/pfjcEuizAYxVskRws9r6xuKH
 IDFETj7w6GCUC7FDzcRD5uNh7JD9U6oGm0lgN/dSxM3jy45HKzxBi/+xVCBrHrTCKODx
 NK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741762640; x=1742367440;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EI4BJTn7dDxBBNHi30ajgG1L4j1CjJA9lDC1PrnAHc0=;
 b=Viw8Ye9afsyS109AB6vu7O63EARrvBb35H5gTiq9kKntl6pybz3OArGWVFlUE/3bEt
 1gLTolvdrdSHfh2Au50XL+tE1KT9RIZUsE65nI7d9DkGz7UkCG5HAf670FOhonpCOzKr
 ikpUHBzEmvdMGnp9I4lJ2WRB6D/1hIL29tHboYBiOIoUmedtnvODM0NVhBqb8B56aPqF
 MWhXvBFgZtBmoST2RbIOfiyV7LFQe/kxx8KuHrRBbhVLnmJU6KtL4sl5whfwvPR9gRcG
 AYJ4XbkWvn0fcCn+jfgJlVoJE5Uj/MdiXb88TXeXdoidnQofgj7ELlYas8HGBXPz8FNx
 U2WQ==
X-Gm-Message-State: AOJu0YxfPSQoTxDJoxjDzKLHh2AI2JattWLQnF5xItpuX2N4R8Eii7H5
 0hTwxdri403My3dxNnDLlGuySAO+BTZH+h4QpjuwfP4jW1Y1RXxftwqdURS/cYIGCMI9XJ7vca8
 y
X-Gm-Gg: ASbGncsnKJR2o7ko9KBvyVCqviGh3e7A9AsQjgTO3YYRwATxgoAwyGE/UnZxctmb0P+
 mDoMyrl6aEsDXmY29o4wHL3fLqQk6/PtqrOefwQAoRSfqcNmTNMPLaKp8AHlmXqXIBOh4Oal/VQ
 oOfDNt0yGbtD3SpO5LHQrg4Dn18z1mrgr29wkRq5kGh6RROESrYtqR7v3KQgY8Q2CEJyMbmAXw8
 PwpZpDus1pyBaVmxBCCkeWCZnj5SMU2LV/sQ06vZIlJSbecfBV6+apSNvEKsC2O1jE3F2leM5rc
 Xg0cAlbmGQ4wXPX/PSsXugMNl5pGlyDAjFcLvGEI507nBPujU2UjX0NznoNf23n4rFwKJNnGhHf
 zbBZrG/c=
X-Google-Smtp-Source: AGHT+IHQUUwgIKZI8Sq3YbI8VSBghCjS1yaCQh1Zzj8ml0qZHFXu8v0DXePg7u8rrS4OzfnyJ2FqVQ==
X-Received: by 2002:a05:6a21:3947:b0:1f5:5b77:3818 with SMTP id
 adf61e73a8af0-1f55b775bb6mr23703628637.27.1741762639849; 
 Tue, 11 Mar 2025 23:57:19 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com.
 [76.88.115.8]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af51c7aad09sm5778894a12.17.2025.03.11.23.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 23:57:19 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: u-boot@lists.denx.de, Anatolij Gustschin <agust@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Andrew Davis <afd@ti.com>
Subject: [PATCH] video: ti: am335x: Fix tilcdc clock names.
Date: Tue, 11 Mar 2025 23:57:09 -0700
Message-Id: <20250312065709.1434207-1-sbellary@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 12 Mar 2025 14:01:40 +0100
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

The commit 211b3d726378 ("arm: dts: am3x: Non-functional changes sync
with v6.3-rc6") changed the tilcdc clock names.
Fix the tilcdc driver to use the new clock names.

Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
---
 drivers/video/ti/tilcdc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/ti/tilcdc.c b/drivers/video/ti/tilcdc.c
index 493e2f18cd2d..340c79299bac 100644
--- a/drivers/video/ti/tilcdc.c
+++ b/drivers/video/ti/tilcdc.c
@@ -234,7 +234,7 @@ static int tilcdc_probe(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	err = uclass_get_device_by_name(UCLASS_CLK, "lcd_gclk@534", &clk_dev);
+	err = uclass_get_device_by_name(UCLASS_CLK, "clock-lcd-gclk@534", &clk_dev);
 	if (err) {
 		dev_err(dev, "failed to get lcd_gclk device\n");
 		return err;
@@ -252,7 +252,7 @@ static int tilcdc_probe(struct udevice *dev)
 		return rate;
 	}
 
-	err = uclass_get_device_by_name(UCLASS_CLK, "dpll_disp_m2_ck@4a4",
+	err = uclass_get_device_by_name(UCLASS_CLK, "clock-dpll-disp-m2@4a4",
 					&clk_dev);
 	if (err) {
 		dev_err(dev, "failed to get dpll_disp_m2 clock device\n");
-- 
2.34.1


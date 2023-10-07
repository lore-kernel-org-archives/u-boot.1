Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AA4E9413C
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 00:50:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F13986D30;
	Sat,  7 Oct 2023 02:50:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jqZ5kQgu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66BF886B35; Sat,  7 Oct 2023 02:49:59 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D504986E79
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 02:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d81b42a3108so3067867276.1
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 17:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696639795; x=1697244595; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DhHYcdEMuw/rKuSwUvJxMrGp0kUMd4v68C2+I89Fhss=;
 b=jqZ5kQguWCuLFlPm31bDUcF3aAOU5xF7pxU64gvmOxPUFM+DRdznkAuggu31iYqR7e
 +QnBvNMGeXFKyXWSXhVKm2s4rMYOSMSTIfruuKWD/ezs5CtEmMY4hE/+iJCBXjViCJak
 eVlfAaye222s8v6PtSXTsbCmzU7F+cT37nLXxKDPNtLj61Igk27KIZEeB+rDd7KBgYdw
 6v5jvZP7DMCRbm/pma6q2fk8hua9NGT6mKN+RegmgKE7kpzaI3mVdEta7JlTgZzv9lCy
 wbFy+V0IWd9LlJADSB+p8ptrLuAZtppps6uqOFsFbCkplsjyKyYpqpw15QXt6bfFtXuI
 /yLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696639795; x=1697244595;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DhHYcdEMuw/rKuSwUvJxMrGp0kUMd4v68C2+I89Fhss=;
 b=i+pYmVNMU4pRedIIqZdxHSKS++br4vAbUt2NL2yFAc3K/Q9Kpj/oRiBwQtWPhCrBs9
 pWXDtDBpwwqwANLllZrmpYFZ209wYJ7X6QvGjlvvkhCfvMNJwYvA4OJYUsTvQtw7MGNJ
 KWVQBrZPza/ZHYIf4Ejk/HA3jx7Lu7APZAhVi1GKXHZhdqe3VTFPW0XiT/vqgipF6TKP
 1of/7Dk/73DClA360OM/k+4xhm9YJvLHUNRiGYkxFmmSyjjuwO8MBZS4EIysZdv1D6xk
 NrIJcQqpSIehnQTbIak+9jUCyHZfIw6PcN0YyzR72wYmBBwYQ85QJdJE4A/2o7MbTnHt
 /PoA==
X-Gm-Message-State: AOJu0Ywot50DIbvUHE1KmpSS7425NKUA508Vcceq2AGh8otE/8FEh+r1
 FlaV1TnMFmSNHvksy7bP5lY=
X-Google-Smtp-Source: AGHT+IHEeZiE20n5AxK/MsYKF6e8j41xpd3IDUIHmpuzDrID6XfiBzQ/f9wYPtUtXCsxMpi3eTamtw==
X-Received: by 2002:a25:850d:0:b0:d74:6cdc:290d with SMTP id
 w13-20020a25850d000000b00d746cdc290dmr9170930ybk.36.1696639794712; 
 Fri, 06 Oct 2023 17:49:54 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a258244000000b00d746487d6f7sm1378078ybn.35.2023.10.06.17.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 17:49:54 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH] bootstd: sata: bootdev scanning for ahci sata with no drive
 attached
Date: Fri,  6 Oct 2023 17:49:36 -0700
Message-Id: <20231007004937.11600-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.2
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

It's normal to have no SATA drive attached to the controller, so return a
successful status when there is no block device found after probing.

Note: this patch depends on the previous patch
https://patchwork.ozlabs.org/project/uboot/patch/20230917230649.30357-1-mibodhi@gmail.com/

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 drivers/ata/sata.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
index f126b84e05..59c40a829f 100644
--- a/drivers/ata/sata.c
+++ b/drivers/ata/sata.c
@@ -79,6 +79,11 @@ int sata_rescan(bool verbose)
 
 	ret = uclass_probe_all(UCLASS_AHCI);
 
+	if (verbose && ret == -ENODEV) {
+		printf("No SATA block device found\n");
+		return 0;
+	}
+
 	return ret;
 }
 
-- 
2.39.2


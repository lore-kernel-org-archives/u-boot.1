Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE212CD6E6B
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 08:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48E1E848D8;
	Fri,  5 Jun 2026 10:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ifpIDqau";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FAC08484F; Fri,  5 Jun 2026 09:33:35 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4322846B1
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 09:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boewingloh.linux@gmail.com
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-46019b190b6so1203577f8f.3
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 00:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780644813; x=1781249613; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=tsPQ3YFIzMfyDDY5TbqCHOWOsVg+dPUQTsZph/00bCo=;
 b=ifpIDqauazV9GQZOMk3BNiaFcYGUe6GKxCX8CfABKirNGxtaIljFjkMQ8/HN7zApqa
 awbraV+LRVZ8V5vEZW1HxfdxcpRA6H+RrIQwSVMaFtyipkKDqAW0SZ+RHRY9Cku/3mD9
 RBrCpcXDkl7cDFxAgz0vikwDNETwtyUEk48K/bwTdL/fO0+7Dp3r46TXY4ysmofkqCgs
 5/6m48ByC4VQItYM8gsMyNDpDTvhBZCsGQBJ3qBL/VLSGZKOQ6dkir0YdASZcN0p76jY
 WBUKJp595Q0xbUjEnPQCASJUIql+iBi6Ke3IwfqSqmeQKiJXVCl7jm/K+wvUUrxDngCA
 GFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780644813; x=1781249613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tsPQ3YFIzMfyDDY5TbqCHOWOsVg+dPUQTsZph/00bCo=;
 b=lneczNnMMebJTaLXd0iX9/mfV8w2FStbMs4kWYPtZd0IVqB08/mIazxMOLhi48CYut
 /QyLM2oZ/1Guh7BVQbSbxYrZtopL7aH2orkD4Y3yJYoFGDPPKRuWaH3rMcmi85rn4zQa
 /cXSKPpcA4eYpT5CJ3hIKg4fWiGJxy2UvFQ16F4VmdjMEm0eEXLi8RMPYR2v6Fp8Ke3K
 j1TVOnXffdbtwLdX1s/t0kPpjadrpisBqeUrSm9U8uOjYrSUkkqvQzu2fXq+ePY6VcrS
 Wv5d0xxL0gSOd7J3QMGgq6zpTfnqdHwuuaNjT/p1QjjZ8lgznOrpmbF13gRrz0DYLfa1
 FUMQ==
X-Gm-Message-State: AOJu0YzgwHw/e50HZ8xp7Nua3AYmP6XVd95+3G9/SOV89Perb3LZTy8w
 +W6G11Xg3BXw597YXmhK+cPD5FTyR+qAB2hBGBWmlF+XBFGnOHPJBUfnYRWX0Mgzrqc=
X-Gm-Gg: Acq92OFP3UzpoPWx/T4z9wNXkcGhU8F0WlWm4QMC3JuL3Re0NM8CF84jH5SVrIcR43b
 hme7CIYIMtM7Yt9zgEpD5EM8gGuFNvtUxswlGWGAFbOyBnKcJhMPk3SHRDGrR4jP61am6Wh7w1H
 JMcs+h2a+slWZNPaOlSwcOPC4uzPcAn7I7rp4ExTH8YpmSWT78GaRE76xDyI/OGpA10fhQQgUg/
 k3V2VUmpFTEBKsS70oyvL51uYcns3wvfWC7GuhrWwTwlqkhB4tdfqHML/DKyxczevO/dqhEYvZm
 4+FeGyijAzfs6Qe5Ci10rdeM0nQ5cA4q31G3bIREIWqjEeoXXZvqkPpD0NkP3XgU8hSdr2koZOB
 1ztyJscN5+sE0FYKam8/7wqX0DieoKwHSqQymJPPZXmcsoA8+6wIgvU4zShM8kOuAKQ2NGG9LTg
 ZNfSKNO2IrCDRvR7mSxEosJytNxgYbAzx92MnaYyGVKEvIMbjug6bVFiKG+9YoLsPTCEZ353+B0
 feZBo9n72spq/eRfw==
X-Received: by 2002:a5d:604b:0:b0:43d:69ff:6898 with SMTP id
 ffacd0b85a97d-460302e6f06mr2991884f8f.9.1780644813057; 
 Fri, 05 Jun 2026 00:33:33 -0700 (PDT)
Received: from BADEWNB000569.beckhoff.com (p57b12faf.dip0.t-ipconnect.de.
 [87.177.47.175]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f344558sm23185342f8f.18.2026.06.05.00.33.32
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 00:33:32 -0700 (PDT)
From: boewingloh.linux@gmail.com
X-Google-Original-From: f.boewingloh@beckhoff.com
To: u-boot@lists.denx.de
Subject: [PATCH] smbios: Fix wrong sysinfo ID for Type 3 enclosure asset tag
Date: Fri,  5 Jun 2026 09:33:31 +0200
Message-ID: <20260605073331.19749-1-f.boewingloh@beckhoff.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 05 Jun 2026 10:05:46 +0200
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

From: Frank Böwingloh <f.boewingloh@beckhoff.com>

smbios_write_type3() uses SYSID_SM_BASEBOARD_ASSET_TAG (Type 2) instead
of SYSID_SM_ENCLOSURE_ASSET_TAG (Type 3) for the enclosure asset tag.
This causes the enclosure's asset tag to be read from the baseboard
sysinfo field rather than the enclosure-specific one.

Fixes: bcf456dd ("smbios: add detailed smbios information")

Signed-off-by: Frank Böwingloh <f.boewingloh@beckhoff.com>
Cc: Raymond Mao <raymondmaoca@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/smbios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index 906d2753517..afde6401ae5 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -679,7 +679,7 @@ static int smbios_write_type3(ulong *current, int *handle,
 	t->serial_number = smbios_add_prop_si(ctx, "serial",
 					      SYSID_SM_ENCLOSURE_SERIAL, NULL);
 	t->asset_tag_number = smbios_add_prop_si(ctx, "asset-tag",
-						 SYSID_SM_BASEBOARD_ASSET_TAG,
+						 SYSID_SM_ENCLOSURE_ASSET_TAG,
 						 NULL);
 	t->oem_defined = smbios_get_val_si(ctx, "oem-defined",
 					   SYSID_SM_ENCLOSURE_OEM, 0);
-- 
2.47.3


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56800C71136
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 18:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72DCC82CB6;
	Wed, 11 Jun 2025 20:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OS9S1MEA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D96B82B0F; Wed, 11 Jun 2025 20:17:47 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61A8282B63
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 20:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55BIHcKQ2655450;
 Wed, 11 Jun 2025 13:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749665858;
 bh=YzL3Y8wg6lFLfYNBA+GazYwxEIThd6E+wRa0oaobIBo=;
 h=From:Subject:Date:To:CC;
 b=OS9S1MEAuToCB/IVldmJQHs3+OD1fqTT5rxbgKSoTCDnqLiyMRGs0OcKTWkIwqmXj
 Od5Bs7EsGpzp8W4hvtUHw8nlJNB64Dwqd7qXpbdblfEleseh27Y+Rq7ftnRoW8nVAM
 tZc7H/lpSHjrZLGaOH4wu+EnfjMFx04LItMu9w2s=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55BIHcWW1323479
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 11 Jun 2025 13:17:38 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 11
 Jun 2025 13:17:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 11 Jun 2025 13:17:38 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55BIHcad731484;
 Wed, 11 Jun 2025 13:17:38 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH -next 0/5] add a few entries into missing-blob-help
Date: Wed, 11 Jun 2025 13:17:31 -0500
Message-ID: <20250611-missing-blob-help-entries-v1-0-c6de1844117f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADvISWgC/x3MwQqDMAyA4VeRnBdIC5uyVxk72JnWgIvSiBTEd
 7d6/A7/v4NxFjZ4Nztk3sRk1gr3aOA39poYZagGT/5JL+fwL2aiCcM0Bxx5WpB1vRboQxeJ+tB
 R20Ltl8xRyv3+ACqXFb7HcQKJwDKIcgAAAA==
X-Change-ID: 20250611-missing-blob-help-entries-2b8f00ab8077
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.14.2
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hello everyone,

Now that TIFS and DM firmwares are marked as mandatory items for a 
successful build[0] we should provide some more descriptive help text on 
where to get the firmware in the event they are not found and add links 
to more information about them.

We do need to expand the regex to allow the '.' dot in 'ti-fs-enc.bin' 
so we can add it to the list which was the lesser number of lines 
changed than renaming all these entries to 'tifs' or 'ti-fs' which the 
current regex will match.

Happy Hacking
~Bryan

[0] https://lore.kernel.org/u-boot/20250506-non-optional-v2-1-f58b12aab913@ti.com

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Bryan Brattlof (5):
      binman: alphabetize missing-blob entries
      binman: add ti-dm entry to missing-blob-help
      binman: add sysfw-inner-cert to missing-blob-help
      binman: allow '.' to be included in the missing blob tags
      binmain: include ti-fs-enc.bin into missing-blob-help

 tools/binman/control.py        |  2 +-
 tools/binman/missing-blob-help | 67 ++++++++++++++++++++++++++++++------------
 2 files changed, 50 insertions(+), 19 deletions(-)
---
base-commit: 59d00e20fced23e6463aa09db889dd548baee677
change-id: 20250611-missing-blob-help-entries-2b8f00ab8077

Best regards,
-- 
Bryan Brattlof <bb@ti.com>


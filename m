Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5F1C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 11:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B82282CA0;
	Thu, 12 Jun 2025 13:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ncENihKA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8688D82C4D; Thu, 12 Jun 2025 13:39:08 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2016D82B7C
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 13:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55CBd2ZQ2909001;
 Thu, 12 Jun 2025 06:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749728342;
 bh=lPlmdrrOtOhApyNBAMZ3HIM34tBkcVb5P8n1nx18QZQ=;
 h=From:Subject:Date:To:CC;
 b=ncENihKAKKweXgQ7kEVmHJPvZDMxOtlKze097drTjl/ONrI4tN9y+dRz70/ZU54MQ
 hrSxLzCX/qU2JXO/K+T/Ma+MloYaYzHsV2dO6zuqrMZqOYm30o359Dd6g70D/GHYof
 bJ0YTS/uoEgRTzogqQBa3JFUxeSwpy7Dyj0NKQj8=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55CBd27K2552837
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 12 Jun 2025 06:39:02 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 12
 Jun 2025 06:39:02 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 12 Jun 2025 06:39:02 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55CBd2iG1922406;
 Thu, 12 Jun 2025 06:39:02 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH -next v2 0/5] add a few entries into missing-blob-help
Date: Thu, 12 Jun 2025 06:38:49 -0500
Message-ID: <20250612-missing-blob-help-entries-v2-0-36f1c8078155@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEm8SmgC/42NQQqDMBBFryKz7pRMsCpd9R7FhdFRBzSRJASLe
 PemnqDL9z///QMCe+EAz+IAz0mCOJtB3wro585OjDJkBq30Q1VEuEoIYic0izM487Ih2/hToDb
 NqFRnGlXXkPeb51H2y/0GtLxHaHM8S4jOf67HRFf5hzwRKuyrgakpS6J6fEW5926F9jzPL/Lzv
 mbGAAAA
X-Change-ID: 20250611-missing-blob-help-entries-2b8f00ab8077
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1499; i=bb@ti.com;
 h=from:subject:message-id; bh=5htzNwtPcNLuh2clz2avkgM5guOdzo2ZKUg/XiSZDho=;
 b=owNCWmg5MUFZJlNZhtBqBgAAZn///7/Nz2956e7/0r//t+/v8uuv+223rO/f9X/569Xv19+wA
 RmYIeoGgNGgAAAaAAANAA0ADQAAGgaBoAAAABoPUaaNAbU9QHqNNNpNpkyQygMjI0BkaaAaMhk0
 AAaaBo0DIDBABoaDRoYg2oHqaBoaDQ0aAaAMg0DQaA0HIepppoyNGgGQ0ADagGgNGRoGgAADIAG
 mQZDT1GhpoAaaBpoA0eoBkAMgYmjQAAsMHUE2hF3ooeIBHOYZQGjPHoIYmKnSuwYHo0JJ1EbWjX
 T4XQJFhX5uY3UBIpddwkOUXhe3HHO7NNkQFNLtauQDrbE6pQA2+OrIfhrxB+rWW+9MBGxIClzN4
 U5OgxA1eWhu7rSOOdlevwQHsteXYF0mN5sLAyDbt2MN+4e6G2dwZKDSOd4JAFSzYGskQgZX3/4P
 zetIx9Zf6XhVwKoGwyysFNwNS9r2VRo/CJY1+5spM1oUQt540IQYIh7TMU2euH8cFpEOQiQ8bUC
 cCBDtH9mY32ekHQ1XMSAwUyMwiiCU/sKddAy5YlB8feWEteHolD8xSEmkEpu9QkYF4C3O429Fi4
 inKITfPXJZ6b8ISxcYA3YQCxPanewq5H0FSNSMKOo+gQIYYyrDtFjHrZE7i0bmcRKyYcz5NB0/K
 lAFLF0Ewq6grr/F3JFOFCQhtBqBgA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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
Changes in v2:
- Keep all missing-blob-help entries alphabetized
- Link to v1: https://lore.kernel.org/r/20250611-missing-blob-help-entries-v1-0-c6de1844117f@ti.com

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
base-commit: ae297ca722ffdb0ae7d76e3fde637f91d4d79e81
change-id: 20250611-missing-blob-help-entries-2b8f00ab8077

Best regards,
-- 
Bryan Brattlof <bb@ti.com>


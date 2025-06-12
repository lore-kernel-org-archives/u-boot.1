Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48000C61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 11:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8965F82C65;
	Thu, 12 Jun 2025 13:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="zCiK1BS2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47C5782CA4; Thu, 12 Jun 2025 13:39:10 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A0AC82C30
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 13:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55CBd3aO2850818;
 Thu, 12 Jun 2025 06:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749728343;
 bh=RqDoZbBTpG58oovpOOxCV/2+6U+I1qSZvJbw34zJhgI=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=zCiK1BS2bD9+5UwT6aglYkKB2DDwK3A8MRojqyEEfRi9FxnuFzDKPvxA+HEtoz+Bp
 OjVCyQYIW6V7LHs9JE1t+vqy19V7se0uZwDxASzJVSOuhFlHoGdYKhA0cA4H8JCddc
 63Eyd0FKwVrYeiXd0m1+yPPKUMwiHlGXBvMAMIv8=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55CBd2TC1780249
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 12 Jun 2025 06:39:02 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 12
 Jun 2025 06:39:02 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 12 Jun 2025 06:39:02 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55CBd21Z1922428;
 Thu, 12 Jun 2025 06:39:02 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Thu, 12 Jun 2025 06:38:51 -0500
Subject: [PATCH -next v2 2/5] binman: add ti-dm entry to missing-blob-help
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250612-missing-blob-help-entries-v2-2-36f1c8078155@ti.com>
References: <20250612-missing-blob-help-entries-v2-0-36f1c8078155@ti.com>
In-Reply-To: <20250612-missing-blob-help-entries-v2-0-36f1c8078155@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1361; i=bb@ti.com;
 h=from:subject:message-id; bh=TwPhRDM0spGFPR5X/+2NsyBcKX2ThWJ9DxhAC9cetXw=;
 b=owNCWmg5MUFZJlNZrjR5pQAAYX////bpwq2tKf36ubx9/37e99m+37+fi/ev6f//9X/r6O6wA
 RtWMd6oAA00AaDQNDQANANA0AaGgAA0Gg0ADQAAB4oBoGQfqmj0j1NA9Q2U9IgMRkwgyDIyNNA0
 A00DTENNBoB6jQANNGBABpo00PUPUaGho0AAZMgB6jQaNGGQnqHpPSGj0jRoaNA0ZADEDQA0AaN
 GQBkA0NGmTQABoDJoNNBoNA0NND1AaGnqAgng6B1SkQXqZdCZdXjEosvHvB/MVMjkO+M4B+AaAZ
 w9Lh3NWkiRSq9FP+A6SACzp8jkTaW6mS/IhDrGK1wuGnHwwKwVQI4CgtEnztB2PTqtCl6WiHTGe
 GZoLliET1hQlYDlF5yARbhzxOSFHjKOxmwDF+hE7I5gyJh/TsAwb8a7nXJjS3hFXMwChmvsh909
 uO0ewSoykvmsZPUwXauGAdEY4EGfp2u2A0PLFqQFkodBSAlcR3dGZ8rEbx6LsVdpCEpRZLWqQ5z
 vziaC0J5MYDmf79BFXh+oKH2jh4ohUFX6XtKoNDIZM3poL6L9UjpErFmwt9+1K3BXkJhyUZ1kVL
 m/5H+/pQBOahFa/9bQE/ymAtSKAoYsUiFe/h4A4mziFIwRkl/nGwkeU6IzFKcoJhZnCx9k4JZzY
 n/cIh/WEcSexv8XckU4UJCuNHml
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

Now that ti-dm is marked as a mandatory component for a successful
build, adding some helping text about how to resolve a failed build will
be needed. Add some text around what ti-dm is and links to more
documentation on how to obtain the firmware binaries

Reviewed-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 tools/binman/missing-blob-help | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/binman/missing-blob-help b/tools/binman/missing-blob-help
index b73b16f18491c2b45300ee4734d0f57eebb5635b..e28eaa2015443f256a469df4ead87793e23ba219 100644
--- a/tools/binman/missing-blob-help
+++ b/tools/binman/missing-blob-help
@@ -50,3 +50,13 @@ Please read the section on SCP firmware in board/sunxi/README.sunxi64
 tee-os:
 See the documentation for your board. You may need to build Open Portable
 Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin
+
+ti-dm:
+You are missing TI's Device Management (DM) firmware which is critical to
+provide resource and power management services for your board. Your board
+will not boot without this firmware.
+
+Have a look at your board's documentation to find the latest version of
+the DM firmware binary and how to include it in the build.
+
+    https://docs.u-boot.org/en/latest/board/ti/k3.html

-- 
2.49.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26762C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 11:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1B2882B7C;
	Thu, 12 Jun 2025 13:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="r6D2JMxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6124982C67; Thu, 12 Jun 2025 13:39:10 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6717A82B97
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 13:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55CBd3Qr1675384;
 Thu, 12 Jun 2025 06:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749728343;
 bh=k6ZY+Q73bY5cYIBQbi6xAFb2VgAzgNTjN6a8g/chn3E=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=r6D2JMxAlW/b3khZWVc5aXWwy4a7HxGPx44F4szFNw0F9i9qljTTMWlTC7Y9KG5IQ
 fcOkcE6sGse8/8+mJSF2CVD9E1x+b5TJLAUpXcQZ2iFEdc++grnsulFv9UtfoskZXr
 ISy8xecyiS2bw7Q3bNvx1hFzS1LSqeag/TckOjxo=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55CBd2TD1780249
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 12 Jun 2025 06:39:03 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 12
 Jun 2025 06:39:02 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 12 Jun 2025 06:39:02 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55CBd2SZ2099287;
 Thu, 12 Jun 2025 06:39:02 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Thu, 12 Jun 2025 06:38:52 -0500
Subject: [PATCH -next v2 3/5] binman: add sysfw-inner-cert to missing-blob-help
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250612-missing-blob-help-entries-v2-3-36f1c8078155@ti.com>
References: <20250612-missing-blob-help-entries-v2-0-36f1c8078155@ti.com>
In-Reply-To: <20250612-missing-blob-help-entries-v2-0-36f1c8078155@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1516; i=bb@ti.com;
 h=from:subject:message-id; bh=qYWLSFPAb2HZ3+MUdgR0uDjY8IMs3oulgrh81vRFAqo=;
 b=owNCWmg5MUFZJlNZIu3yQwAAY////r9fT3uz3s3+9+f+H2j+fnF6b+2lOXvn8Prr/3793+ewA
 Rs2hD0gGgAGgA0AaaBo0Bo0BppoNA0DIAGgAGhkaBkNDTRoBoMgeppk9TZG1TyhyaDQ00aaAyNG
 mhpoNGRpo2kAMgAaZAyBphMjQG1NoJ6QANGgNMQaA0aADIGMUNqBo00PUBoBoDQ0aADJoGmgAAD
 IGIyYgZNGCADQ0aMg0yYIZGTQNMjAgQThrgIxBRJkTFDpYIO3bmzgn3YBiwCK4GRjYcehGag7LW
 +YJXE5R/eGLN7z2P0MsabocPhwPFCBSOJyCWtJJq7BwuK+NlzkQuIwhALrHI3QU3/YzPdXfiX9e
 dt1rvQlkSGDZU2L7eu8jDEXZxVqEyagj5MenoEO851FvlnoA+l814HwDmEPnnlgzGZ+YrRuJw8b
 ZftbHm1UsJn7KVhXcr1dES61L0dIoepDeccq4lLNdwerKlcGeiymF/9sgR60VOsXQ3Ya2AX1XjT
 5+ZegxaGpFMkTOOdDPmmNMFxIBf5ZDvWOGmiDxWv1YhBtDPG+KURSllBNXQqL8HTQ9OsdfbnCXt
 /oNumCbdTRFp/dDZkWisQYFGBwgFxpEnQYBcLzQF02RuKRxJVcrPISwBwfjs53ZoT3X0RJAYZYK
 5wCa8k61KsS/+LuSKcKEgRdvkhg
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

Now that the inner certificate for TI's Foundation Security TIFS
firmware is mandatory to a successful build, provide some guidance on
what it is and links to the documentation on how to obtain the firmware
blobs.

Reviewed-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes from v1:
- Alphabetize the sysfw-inner-cert entry
---
 tools/binman/missing-blob-help | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/binman/missing-blob-help b/tools/binman/missing-blob-help
index e28eaa2015443f256a469df4ead87793e23ba219..3b16a9b1679c4d3003da08c8a49c7acee2293538 100644
--- a/tools/binman/missing-blob-help
+++ b/tools/binman/missing-blob-help
@@ -47,6 +47,16 @@ scp-sunxi:
 SCP firmware is required for system suspend, but is otherwise optional.
 Please read the section on SCP firmware in board/sunxi/README.sunxi64
 
+sysfw-inner-cert:
+You are missing the inner certificate for TI's Foundational Security (TIFS)
+firmware which is critical to authenticating the TIFS firmware during boot.
+HS-FS and HS-SE parts will not boot without this certificate.
+
+Have a look at your board's documentation to find and include the latest
+TIFS certificate blobs and how to include them in the build.
+
+    https://docs.u-boot.org/en/latest/board/ti/k3.html
+
 tee-os:
 See the documentation for your board. You may need to build Open Portable
 Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin

-- 
2.49.0


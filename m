Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE69C2BBCA
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 09:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1195D88581;
	Fri, 28 Jun 2024 11:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kr3fy8mc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE165885A2; Fri, 28 Jun 2024 11:33:51 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 028CA885B6
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 11:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45S9XhYo028169;
 Fri, 28 Jun 2024 04:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719567223;
 bh=aHKi1HbmOFBuxXN9Tb9osd12dwuaOfCraI6Fs22zKiw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=kr3fy8mc8LdGcLMqY7P6N/nh+WxA/ySJMfF67GLUKyoPTGP2mhCZnqIRRtAJPLKWU
 uOmEqV0ZdXAmmY+6tsDhCmxpGUOdxuo0hxnP/N0jiAB6O0jJBM7aJVxNUjOZmj5EIx
 tyC+DgchoDXsH3Q6g0PosK1nZHRNGxTd//CgXtQc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45S9XhZG127867
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Jun 2024 04:33:43 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 04:33:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 04:33:42 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45S9XFWB088895;
 Fri, 28 Jun 2024 04:33:39 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishant
 Menon <nm@ti.com>, <c-shilwant@ti.com>, <m-chawdhry@ti.com>,
 <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vibhore Vardhan
 <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>, Dhruva Gole
 <d-gole@ti.com>
Subject: [PATCH V3 4/4] doc: ti: k3: Add TIFS Stub documentation
Date: Fri, 28 Jun 2024 15:02:52 +0530
Message-ID: <20240628093252.1864609-5-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628093252.1864609-1-d-gole@ti.com>
References: <20240628093252.1864609-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Add documentation to briefly explain the role of TIFS Stub in relevant
K3 SoC's.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 doc/board/ti/k3.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 88821a15e4c6..f45a285db21b 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -192,6 +192,11 @@ online
     device resources such as power, clock, interrupts, dma etc. This firmware
     runs on a dedicated or multi-use microcontroller outside the security
     enclave.
+  * **TIFS Stub** - A small piece of code that helps restore the remaining
+    context and resume the TIFS firmware when resuming from Low Power Modes
+    like Suspend-to-RAM/ Deep Sleep. It is loaded into the ATCM (Tightly
+    Coupled Memory 'A' of the DM R5) during DM startup. This applies only
+    to AM62x, AM62A and AM62P based devices.
 
  OR
 
-- 
2.34.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD432C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 00:10:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 167A58768D;
	Fri,  3 Nov 2023 01:10:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jSZpHC/1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AE6C87663; Fri,  3 Nov 2023 01:09:48 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF7B887622
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 01:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A309G8j011612;
 Thu, 2 Nov 2023 19:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698970156;
 bh=c+k+aZrj69APAX1nNJI3WC6XihhBokF+o71gpYs0yPM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=jSZpHC/1C/lI5AQIQcPbQ5KT0VazVY1+RIBCzLQC5KqLvHp+m2ME1RPLyWXf3+45y
 Az7prGGOom9bNpy0phvhbZXYifsPGbHFSh4v0Vuny0lvLKeEgShADxprfrii/et4v6
 KAlmVUxG1tR8UCigP99OPAlJaHOevht8YoQnk0f0=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A309Gnc108230
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 2 Nov 2023 19:09:16 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 Nov 2023 19:09:16 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 Nov 2023 19:09:16 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A309Gc2005679;
 Thu, 2 Nov 2023 19:09:16 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 2/3] doc: board: ti: k3: Use ::prompt for gdb commands
Date: Thu, 2 Nov 2023 19:09:14 -0500
Message-ID: <20231103000915.2413501-3-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231103000915.2413501-1-nm@ti.com>
References: <20231103000915.2413501-1-nm@ti.com>
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

Provide more friendlier documentation with prompt (gdb) option

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 doc/board/ti/k3.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index e9bbe7c09794..c20e33d00412 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -926,7 +926,7 @@ command.
 
 To connect to your desired core, run the following command within GDB:
 
-.. code-block:: bash
+.. prompt:: bash (gdb)
 
   target extended-remote localhost:{port for desired core}
 
@@ -943,13 +943,13 @@ To load symbols:
 
 * Prior to relocation:
 
-.. code-block:: bash
+.. prompt:: bash (gdb)
 
   symbol-file {path to elf file}
 
 * After relocation:
 
-.. code-block:: bash
+.. prompt:: bash (gdb)
 
   # Drop old symbol file
   symbol-file
@@ -960,7 +960,7 @@ To load symbols:
 
 In the above example of AM625,
 
-.. code-block:: bash
+.. prompt:: bash (gdb)
 
   target extended-remote localhost:3338     <- R5F (Wakeup Domain)
   target extended-remote localhost:3334     <- A53 (Main Domain)
@@ -980,7 +980,7 @@ breakpoints. To exit the debug loop added above, add any breakpoints
 needed and run the following GDB commands to step out of the debug
 loop set in the ``board_init_f`` function.
 
-.. code-block:: bash
+.. prompt:: bash (gdb)
 
   set x = 0
   continue
-- 
2.40.0


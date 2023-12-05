Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11621C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 15:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53C13878DA;
	Tue,  5 Dec 2023 16:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MF1/Kou1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E150586F28; Tue,  5 Dec 2023 16:55:43 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B17FB87896
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 16:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B5FtakM126358;
 Tue, 5 Dec 2023 09:55:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701791736;
 bh=ePoRsoxftqjCt+SrHmF85rhuSrUYvwUpd0teQ4GFRmU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=MF1/Kou1W0hGsuBIM4b+WZ0lWRF8cF9nD0QwDDuVvrC9+VtecQ1qnYsZPlAWsgZFt
 OoBrkl/wI4QOgdu4acGsfJs6sZym3Kejb+ao3b+Uyh+Pz152W56FGSmLEKvAljAR3w
 m7I9skhFHV8WEc+r1z6gky2gcr4QXLnnkNnQ8jUA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B5FtaCw005983
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Dec 2023 09:55:36 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 09:55:36 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 09:55:36 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B5FtZ0K018428;
 Tue, 5 Dec 2023 09:55:36 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v5 8/8] doc: spl: Add info regarding memory reservation
Date: Tue, 5 Dec 2023 21:25:23 +0530
Message-ID: <20231205155523.721784-9-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205155523.721784-1-devarsht@ti.com>
References: <20231205155523.721784-1-devarsht@ti.com>
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

Add details regarding scheme which need to be followed in SPL and
further stages for those regions which need to be preserved across
bootstages.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Reviewed-by: Simon Glass <sjg@chromium>
---
V1->V3:
No change.

V4:
Split this to separate patch and add more details regarding
memory reservation scheme that needs to be followed at SPL.

V5:
Add Reviewed-By
---
 doc/develop/spl.rst | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/doc/develop/spl.rst b/doc/develop/spl.rst
index 814530d348..0a3e572310 100644
--- a/doc/develop/spl.rst
+++ b/doc/develop/spl.rst
@@ -173,3 +173,31 @@ cflow will spit out a number of warnings as it does not parse
 the config files and picks functions based on #ifdef.  Parsing the '.i'
 files instead introduces another set of headaches.  These warnings are
 not usually important to understanding the flow, however.
+
+
+Reserving memory in SPL
+-----------------------
+
+If memory needs to be reserved in RAM during SPL stage with the requirement that
+the SPL reserved memory remains preserved across further boot stages too
+then it needs to be reserved mandatorily starting from end of RAM. This is to
+ensure that further stages can simply skip this region before carrying out
+further reservations or updating the relocation address.
+
+Also out of these regions which are to be preserved across further stages of
+boot, video framebuffer memory region must be reserved first starting from
+end of RAM for which helper function spl_reserve_video_from_ram_top is provided
+which makes sure that video memory is placed at top of reservation area with
+further reservations below it.
+
+The corresponding information of reservation for those regions can be passed to
+further boot stages using a bloblist. For e.g. the information for
+framebuffer area reserved by SPL can be passed onto U-boot using
+BLOBLISTT_U_BOOT_VIDEO.
+
+The further boot stages need to parse each of the bloblist passed from SPL stage
+starting from video bloblist and skip this whole SPL reserved memory area from
+end of RAM as per the bloblists received, before carrying out further
+reservations or updating the relocation address. For e.g, U-boot proper uses
+function "setup_relocaddr_from_bloblist" to parse the bloblists passed from
+previous stage and skip the memory reserved from previous stage accordingly.
-- 
2.34.1


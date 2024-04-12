Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58663C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 15:53:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAACB88020;
	Fri, 12 Apr 2024 17:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="6fg0QKFr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C88B68803B; Fri, 12 Apr 2024 17:53:19 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D60E587DDF
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 17:53:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4832881ce4=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43CDJZaf017054; Fri, 12 Apr 2024 17:53:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=selector1; bh=SiB5GQy
 PiAuiNdoql0Tm8yOpMzRfI6JOeOxBORvBkJc=; b=6fg0QKFrGWHfAxeT3u3L6k9
 +atcLouSyN+lB8/Jx5zdkiRg6Abe2WDKX3CjwpLjfYW+RuxGrxGG+gJocgIs1DU+
 ecun9K+wgsgFcGs2fIc4OFU8yIH6PctdV3OZwsiIkYxKHrH7ab87ojxhA46ArezD
 snIEJ4TBlhaJ3lH2K2BK5xKOzRhinuH9UZml3Y1tCXile0lh9w0zxsf/6PqT/b7c
 zqqyO6SKQbKzy1XIt503kXFfK7y99yeZCb9p6wnQne9g7mrkNFLOvEi3XFUzlNQH
 30KJsLKYyUR7zERW2GKvCiA21nsu+xbppJjAEGLEREH+QFTzkKTZkitEuMrBqIw=
 =
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xauh5j0dt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Apr 2024 17:53:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 20D844005D;
 Fri, 12 Apr 2024 17:53:11 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DCB4421A22B;
 Fri, 12 Apr 2024 17:53:10 +0200 (CEST)
Received: from localhost (10.252.26.170) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 12 Apr
 2024 17:53:10 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v2 1/2] lmb: Avoid to add identical region in
 lmb_add_region_flags()
Date: Fri, 12 Apr 2024 17:53:05 +0200
Message-ID: <20240412155307.735631-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.26.170]
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_12,2024-04-09_01,2023-05-22_02
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

In case lmb_add_region_flags() is called with the same parameter than
an already existing lmb and this lmb is adjacent to its previous lmb with
different flag, this lmb is added again.

Instead breaking the loop, continue, at the next iteration, we are able
to detect that this region already exist.

Issue reproduced on STM32MP157-DK2 with SCMI DT, bdinfo command's output
shows:

Before this patch, the last LMB [0xde000000-0xdfffffff] is duplicated:
...
lmb_dump_all:nnn
 memory.cnt = 0x1 / max = 0x2
 memory[0]      [0xc0000000-0xdfffffff], 0x20000000 bytes flags: 0
 reserved.cnt = 0x6 / max = 0x10
 reserved[0]    [0x10000000-0x10045fff], 0x00046000 bytes flags: 4
 reserved[1]    [0x30000000-0x3003ffff], 0x00040000 bytes flags: 4
 reserved[2]    [0x38000000-0x3800ffff], 0x00010000 bytes flags: 4
 reserved[3]    [0xdaadf000-0xdfffffff], 0x05521000 bytes flags: 0
 reserved[4]    [0xde000000-0xdfffffff], 0x02000000 bytes flags: 4
 reserved[5]    [0xde000000-0xdfffffff], 0x02000000 bytes flags: 4
...

After this patch:
...
lmb_dump_all:
 memory.cnt = 0x1 / max = 0x2
 memory[0]      [0xc0000000-0xdfffffff], 0x20000000 bytes flags: 0
 reserved.cnt = 0x5 / max = 0x10
 reserved[0]    [0x10000000-0x10045fff], 0x00046000 bytes flags: 4
 reserved[1]    [0x30000000-0x3003ffff], 0x00040000 bytes flags: 4
 reserved[2]    [0x38000000-0x3800ffff], 0x00010000 bytes flags: 4
 reserved[3]    [0xdaadf000-0xdfffffff], 0x05521000 bytes flags: 0
 reserved[4]    [0xde000000-0xdfffffff], 0x02000000 bytes flags: 4
...

Fixes: 59c0ea5df33f ("lmb: Add support of flags for no-map properties")

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

(no changes since v1)

 lib/lmb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 44f98205310..b6afb731440 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -285,14 +285,14 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 		adjacent = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
 		if (adjacent > 0) {
 			if (flags != rgnflags)
-				break;
+				continue;
 			rgn->region[i].base -= size;
 			rgn->region[i].size += size;
 			coalesced++;
 			break;
 		} else if (adjacent < 0) {
 			if (flags != rgnflags)
-				break;
+				continue;
 			rgn->region[i].size += size;
 			coalesced++;
 			break;
-- 
2.25.1


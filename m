Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7331E7D273
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 10:10:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D96D986C35;
	Tue, 26 Sep 2023 12:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE53186D5D; Tue, 26 Sep 2023 12:09:59 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32B0E86BCE
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 12:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-Spam: true
X-QQ-mid: bizesmtp77t1695718725tab1ix31
Received: from pek-vx-bsp2.wrs.com ( [60.247.85.88])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 26 Sep 2023 16:58:43 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
From: Bin Meng <bmeng@tinylab.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joshua Watt <jpewhacker@gmail.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 14/15] disk: part: Print out the unknown device uclass id
Date: Tue, 26 Sep 2023 16:43:44 +0800
Message-Id: <20230926084346.2237483-15-bmeng@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926084346.2237483-1-bmeng@tinylab.org>
References: <20230926084346.2237483-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz6a-0
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

It's helpful to output the device uclass id for unknown devices
during the debugging process.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 disk/part.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk/part.c b/disk/part.c
index eec02f5898..493e04943b 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -310,7 +310,7 @@ static void print_part_header(const char *type, struct blk_desc *dev_desc)
 		puts("EFI");
 		break;
 	default:
-		puts("UNKNOWN");
+		printf("UNKNOWN(%d)", dev_desc->uclass_id);
 		break;
 	}
 	printf (" device %d  --   Partition Type: %s\n\n",
-- 
2.25.1


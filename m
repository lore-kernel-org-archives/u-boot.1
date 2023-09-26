Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97A5E7D268
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 08:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E44F86D55;
	Tue, 26 Sep 2023 10:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D487386D76; Tue, 26 Sep 2023 10:52:32 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CFFB86A14
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 10:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp72t1695718341thg9s52e
Received: from pek-vx-bsp2.wrs.com ( [60.247.85.88])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 26 Sep 2023 16:52:19 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: vLOCICHxEeC8Y6z0yJvLN+jlyoq/EHq0DETd4QlO55GW+bZ+R/Jg3U/xX4htv
 W0PWKVHuLypE2bn4/DnWM8nPEbtxlBeYo8ELCglRCXd/9V65yGGLfkXMDOQpTvhckNoNvJx
 6iDNxPWjZYbY/9gg/nmD5GuAa5PmSrDRLgbvqzPD9RFhHuGvdUzWwANo44IdSx+NSHEDrfL
 dUSI2x97ST7TpXN+P1c9WbG3mbUmkpSjXBrKfDbzndM4yGVNzUxUpNt8VxQUHrPOaIJoOxS
 MwnZRMwG7lIuAispSMOC/3iKl6W2nLFqfIH8UbfnP/G0A7gim6+hDMxJcqNsORmhOew8/vj
 zQqc+wnJShw/FsleRYwmmfE5a8AnJuVwZfgVrg8
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16433338305475135893
From: Bin Meng <bmeng@tinylab.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 08/15] cmd: blkmap: Make map_handlers[] and its .fn static
Date: Tue, 26 Sep 2023 16:43:38 +0800
Message-Id: <20230926084346.2237483-9-bmeng@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926084346.2237483-1-bmeng@tinylab.org>
References: <20230926084346.2237483-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
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

These are only used in cmd/blkmap.c.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 cmd/blkmap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/cmd/blkmap.c b/cmd/blkmap.c
index b34c013072..ef74ebc003 100644
--- a/cmd/blkmap.c
+++ b/cmd/blkmap.c
@@ -25,7 +25,8 @@ struct map_handler {
 	map_parser_fn fn;
 };
 
-int do_blkmap_map_linear(struct map_ctx *ctx, int argc, char *const argv[])
+static int do_blkmap_map_linear(struct map_ctx *ctx, int argc,
+				char *const argv[])
 {
 	struct blk_desc *lbd;
 	int err, ldevnum;
@@ -58,7 +59,7 @@ int do_blkmap_map_linear(struct map_ctx *ctx, int argc, char *const argv[])
 	return CMD_RET_SUCCESS;
 }
 
-int do_blkmap_map_mem(struct map_ctx *ctx, int argc, char *const argv[])
+static int do_blkmap_map_mem(struct map_ctx *ctx, int argc, char *const argv[])
 {
 	phys_addr_t addr;
 	int err;
@@ -80,7 +81,7 @@ int do_blkmap_map_mem(struct map_ctx *ctx, int argc, char *const argv[])
 	return CMD_RET_SUCCESS;
 }
 
-struct map_handler map_handlers[] = {
+static struct map_handler map_handlers[] = {
 	{ .name = "linear", .fn = do_blkmap_map_linear },
 	{ .name = "mem", .fn = do_blkmap_map_mem },
 
-- 
2.25.1


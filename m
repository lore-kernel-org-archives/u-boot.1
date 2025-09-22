Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FF9CA100F
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 16:29:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A370832F9;
	Mon, 22 Sep 2025 18:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="S9Me/aol";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFC84833ED; Mon, 22 Sep 2025 18:29:44 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6CF48004F
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 18:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1v0jPy-0001ET-5Y; Mon, 22 Sep 2025 12:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
 references; bh=40VSdORnbvaYS2BXnJM1kSvv7j8FJ4BnSKupj0hbpZ4=; b=S9Me/aoljagHet
 yYA+Ndwhj4MmM7fEAhXA0J0y0a+fdhYJrotCKr1Xd7wbPGMHDR0VxqBdAImEe4Z+I3sLixsS1D3u0
 yU8+pLnqYtWeNFqLOUsKloWUkWCqQjzXuEjbCqCYIvZMc1ZH5WUxarYr7ZtHRRLmO8igG8uW4t7OF
 Ell3HcSr5Xa5X64i9rummPkc8+J8G4Wb75iwPlBgxtWs2QXZWuzu5oZQsfxeMXrF581pTvfnlVKa2
 r65EXmP700kdOqzyIxb6Q3Xbm1LSnvoBuDMekBHWVF1kypFNgdV7BV1/ndrDW3a7HvArhVDgSonwX
 rkz6ClfSQBsrpUsoqwPA==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Paul Barker <paul@pbarker.dev>,
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Mathieu Othacehe <othacehe@gnu.org>, u-boot@lists.denx.de
Cc: anton.reding@landisgyr.com
Subject: [PATCH v2] board: rzg2l: Check the DTB pointer passed by the TF-A.
Date: Mon, 22 Sep 2025 18:29:00 +0200
Message-ID: <20250922162901.22908-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On the RZG2L platform, the advised
TF-A (https://github.com/renesas-rz/rzg_trusted-firmware-a/tree/v2.5/rzg2l)
does not pass any DTB blob to U-Boot.

On the other hand, the RZG2L part of U-Boot expects a DTB to be passed.  It
means that if one flashes the latest TF-A as well as the mainline U-Boot,
it will crash trying to dereference the NULL DTB pointer before outputing
anything.

Check if the DTB pointer is NULL before trying to use it.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
v1: https://lists.denx.de/pipermail/u-boot/2025-September/598712.html

Changelog:
v2: Keep compatibility with TF-A passing DTB blobs.

 arch/arm/mach-renesas/cpu_info-rzg2l.c | 2 +-
 board/renesas/rzg2l/rzg2l.c            | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-renesas/cpu_info-rzg2l.c b/arch/arm/mach-renesas/cpu_info-rzg2l.c
index ab95ce76388..a9cb9f72dd3 100644
--- a/arch/arm/mach-renesas/cpu_info-rzg2l.c
+++ b/arch/arm/mach-renesas/cpu_info-rzg2l.c
@@ -30,7 +30,7 @@ static const struct tfa_info *get_tfa_info(void)
 {
 	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
 
-	if (fdt_magic(atf_fdt_blob) == FDT_MAGIC) {
+	if (atf_fdt_blob && fdt_magic(atf_fdt_blob) == FDT_MAGIC) {
 		unsigned int i;
 		for (i = 0; i < ARRAY_SIZE(tfa_info); i++) {
 			if (!fdt_node_check_compatible(atf_fdt_blob, 0,
diff --git a/board/renesas/rzg2l/rzg2l.c b/board/renesas/rzg2l/rzg2l.c
index 509c5dbb156..3c8f8d04cbd 100644
--- a/board/renesas/rzg2l/rzg2l.c
+++ b/board/renesas/rzg2l/rzg2l.c
@@ -22,7 +22,7 @@ int board_fit_config_name_match(const char *name)
 {
 	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
 
-	if (fdt_magic(atf_fdt_blob) != FDT_MAGIC)
+	if (!atf_fdt_blob || fdt_magic(atf_fdt_blob) != FDT_MAGIC)
 		return -1;
 
 	if (is_rzg2l_board("renesas,r9a07g044l2"))
@@ -36,7 +36,7 @@ static void apply_atf_overlay(void *fdt_blob)
 {
 	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
 
-	if (fdt_magic(atf_fdt_blob) == FDT_MAGIC)
+	if (atf_fdt_blob && fdt_magic(atf_fdt_blob) == FDT_MAGIC)
 		fdt_overlay_apply_node(fdt_blob, 0, atf_fdt_blob, 0);
 }
 
-- 
2.49.0


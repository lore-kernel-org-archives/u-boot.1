Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A2EEE14C3
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EE2F869F6;
	Wed,  6 Sep 2023 23:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tJqIHHBp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yRWZhOcK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A8A28685B; Wed,  6 Sep 2023 23:30:52 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 455FE869F6
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RgwXT1djrz9sn0;
 Wed,  6 Sep 2023 23:30:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tRY+Co0bU4/5FfDHp0cv16kRkZfpAPoSbV4C6umT1Jc=;
 b=tJqIHHBpjPmFJrEsAPXpmOC+zMKrAiPvDl9Uv9n7uHBqRHIl5wHeycWo8TohV+m/uJ0BOQ
 Dq22kNcw5zaR5JXpC7z3RvkSrcndPHlHdEGSqQzLNejJv/CNacsy1alfi7ofGmb+l0LzPU
 2RsMil6hK8xuj0fxNZQAsfJtbtKabHlDSuB0ox/orUm+nEpdVGOodFWpgsPCn/mod4VRo0
 PkCecGAuof4x7TSXIWZj8HHNeswPDumbqqfxPd/Q2bEUWOa0XP/0dJa4L304SYeGPRkVii
 tQJ3vEA20FhRKQTXrA36snQ14oMo+/09K8Ndm3u9IUn+RGdN0qsLNjnM3V21uA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tRY+Co0bU4/5FfDHp0cv16kRkZfpAPoSbV4C6umT1Jc=;
 b=yRWZhOcKtQO+hjUTHcsiKXoRfpGJEnWj/YITuL5/225sRmHxnWJzW2kKB1ZSsJyFxrS7H3
 vp2okpEwIeR/Jjs30aR2PVcOfNKVsz7XGJHPxM09MQR5beZhE2sZORtkk/YDHidVINwSTl
 ervaGB7KuukpyVskN2NAzDl3myCesUUQwTMeLzVgX99NVmsnrlg4OlZh9LOVOmHGlLsvt9
 +cXkseXaTD/OZ2NJCDD3f6VLArjMpcqGALhwdeOR7Sfw2oKUp4QhiUtxHHL9pGe1TaNRUw
 IRmX3COaKmBNNJlwHha7rtPSYV00HeomCe7iQJLCVgz9PyxyWvp25bpnJA9bUQ==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 14/35] cmd: onenand: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:29:54 +0200
Message-Id: <20230906213015.203437-15-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4a3pch6doc11ogcm6d1fjwxwigjnh3cz
X-MBO-RS-ID: d8d5f6a3c5ac9bc59ad
X-Rspamd-Queue-Id: 4RgwXT1djrz9sn0
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

The last user of the NEEDS_MANUAL_RELOC has been removed in commit
26af162ac8f8 ("arch: m68k: Implement relocation")
Remove now unused NEEDS_MANUAL_RELOC code.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 cmd/onenand.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/cmd/onenand.c b/cmd/onenand.c
index d633f19d3bb..3ec11246f6f 100644
--- a/cmd/onenand.c
+++ b/cmd/onenand.c
@@ -560,12 +560,6 @@ static struct cmd_tbl cmd_onenand_sub[] = {
 	U_BOOT_CMD_MKENT(markbad, CONFIG_SYS_MAXARGS, 0, do_onenand_markbad, "", ""),
 };
 
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-void onenand_reloc(void) {
-	fixup_cmdtable(cmd_onenand_sub, ARRAY_SIZE(cmd_onenand_sub));
-}
-#endif
-
 static int do_onenand(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
-- 
2.40.1


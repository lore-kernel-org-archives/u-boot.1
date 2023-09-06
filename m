Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EB5EE14C3
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7E5B86A34;
	Wed,  6 Sep 2023 23:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jt12En1e";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="o6OKRS8j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7D97869F7; Wed,  6 Sep 2023 23:30:52 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15953869A3
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RgwXT64n1z9t0P;
 Wed,  6 Sep 2023 23:30:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/NxKHzktUlTXQT1WC+iloISorjmP2YOMdxhX2tdqJl4=;
 b=jt12En1elkd12iB6ngq5lzRYoz5MRln4cqjsZ08AHZoLygfSIU/RigvGMETLKxBIJqyEa8
 CX1EHgW5LQcvi9xkPq72M4p7UDv+2VKUFdtXFGLkeuFdKFklz5xQP5yJQe6DFPl1PlwkZS
 ijLjBbA2KMtkMVurCYrPb745cn4cZcLUAD5dBvnpalK9z1Ttp2000rmTF0lk1RieRwuOkj
 1TEfwrnLJN3kgJJuaQyY8tDukGV+IqhZDEY3jd17ZBXkkJImNHDgYgJZKEGafxG5oEMxel
 uyxieROK6Lz+7t/vQ2728CvsmjtM5kBCVGBlC+iK9DHVqXftTHe7HndjohXWVQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/NxKHzktUlTXQT1WC+iloISorjmP2YOMdxhX2tdqJl4=;
 b=o6OKRS8jru+BRx7SCRDfqZ4TPSp2XcKNYFq7juBh1Tu7YJKrYT3FVH5CDMqNd9FA9/6xrZ
 yOKFz1bi8DHAZLv/1kD5OhbTX5JSlpiT3WRILoACVxiGYkEMC1ZOm4fZwDTTaJ/i/rjXZG
 /mt9sjzZ9Gz6+XcTJCxtn/Q+woMKetj+PsAqNv8yVMDtGK+brmfoHnAhCOKj9vc7rUHrkC
 nNAyNGDgz+t/qH26vPYGgkZiIoYNpCENUoPHzSO9psrld1ccf6XYWMhSMAi9F+EkbUGnrZ
 0XTaI8pVKxNl3ru3a4bpmAN986VVx4bkw6FUERyZzYVYLMbjPSWXunqmrq22sQ==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 15/35] cmd: pxe: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:29:55 +0200
Message-Id: <20230906213015.203437-16-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ceey895oqq9caj56xrj4nhf5gfrmzhxb
X-MBO-RS-ID: 56c52d1e03567215c26
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
 cmd/pxe.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/cmd/pxe.c b/cmd/pxe.c
index 7bfb1b9b280..704589702f2 100644
--- a/cmd/pxe.c
+++ b/cmd/pxe.c
@@ -299,24 +299,10 @@ static struct cmd_tbl cmd_pxe_sub[] = {
 	U_BOOT_CMD_MKENT(boot, 3, 1, do_pxe_boot, "", "")
 };
 
-static void __maybe_unused pxe_reloc(void)
-{
-	static int relocated_pxe;
-
-	if (!relocated_pxe) {
-		fixup_cmdtable(cmd_pxe_sub, ARRAY_SIZE(cmd_pxe_sub));
-		relocated_pxe = 1;
-	}
-}
-
 static int do_pxe(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct cmd_tbl *cp;
 
-#if defined(CONFIG_NEEDS_MANUAL_RELOC)
-	pxe_reloc();
-#endif
-
 	if (argc < 2)
 		return CMD_RET_USAGE;
 
-- 
2.40.1


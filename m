Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED222EE14C3
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AF9F869B5;
	Wed,  6 Sep 2023 23:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IiYzhy5P";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ykhoccK9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B11D86682; Wed,  6 Sep 2023 23:30:43 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C488C86682
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RgwXJ489Tz9t0Y;
 Wed,  6 Sep 2023 23:30:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJPlXf9DBT7sMZmmy19aSEgw0y8tkORSUbM8dNFoeRM=;
 b=IiYzhy5POJfRGkjSSx1xvKLfUaUExPqrlLcw7VxnYOOGCilDSyzoTqcacy/YXnMzLmibYn
 aVaFI5pfyOrQB7G16/I6S36dEw9qDt0RihK99BptD5b3M/3K83pvj34FE2kmVsWicQE9qj
 Wk8djzrr7vo1EuE5SScDd8wXRspZiNjNDT15sRS5FqaFjGrGB4+M7U/hjHZs3xgkNpkT2H
 zMY2kNZkIXtpxIzjrwCECZGGsI2Wr5egBMUHqXcmnU6MV4sQuJ6AgGFCEudsDd8eXCf68D
 /LdlLwgBF3Yh3wV3HM7IVjFPM4csHZ3X3YB7846+W+oo/+Hq6a+K62EkDFQpBg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJPlXf9DBT7sMZmmy19aSEgw0y8tkORSUbM8dNFoeRM=;
 b=ykhoccK9AtKIBO1O+cAObCqPqM9mKX/17Oyby4KXkCpez8dJYxl3CMwy23K8lp2KXreJV6
 TUHnI/m5+cnTj46HOR0vajoocwwLB2ROAK49jbVh6xsJ5rFLP0I+osVAhMjdCzOeEAn6ln
 oyvsJNQAs+Hj77Mcr/7dOiVM9BHutVUzSElJw5ordCDnHvf9cexqdsk01XP16FLRAVwRNu
 XQRipHVnDO6dczS7/3kHK5zvEZHFGMNUDPrOqT6lZSAcNNzFTeXaXYgkyYuRtRg/qA6Y4G
 CbhVL2vRiqEWsUtbKekdh7cJZ/zPDhim2kqCt6Zul1OXdmJFNm9KTayB3DgG0A==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 01/35] boot: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:29:41 +0200
Message-Id: <20230906213015.203437-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: pf89cg848kf7tmq97m9ssa6etwwgjt4w
X-MBO-RS-ID: f2e317e82705cd17045
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
 boot/bootm_os.c  | 14 --------------
 boot/image-sig.c | 28 ----------------------------
 cmd/bootm.c      | 14 --------------
 3 files changed, 56 deletions(-)

diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index 99ff0e6c02d..9c035b5be88 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -609,19 +609,5 @@ int boot_selected_os(int argc, char *const argv[], int state,
 
 boot_os_fn *bootm_os_get_boot_func(int os)
 {
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-	static bool relocated;
-
-	if (!relocated) {
-		int i;
-
-		/* relocate boot function table */
-		for (i = 0; i < ARRAY_SIZE(boot_os); i++)
-			if (boot_os[i] != NULL)
-				boot_os[i] += gd->reloc_off;
-
-		relocated = true;
-	}
-#endif
 	return boot_os[os];
 }
diff --git a/boot/image-sig.c b/boot/image-sig.c
index 1aa0b586450..b5692d58b24 100644
--- a/boot/image-sig.c
+++ b/boot/image-sig.c
@@ -57,20 +57,6 @@ struct checksum_algo *image_get_checksum_algo(const char *full_name)
 	int i;
 	const char *name;
 
-	if (IS_ENABLED(CONFIG_NEEDS_MANUAL_RELOC)) {
-		static bool done;
-
-		if (!done) {
-			done = true;
-			for (i = 0; i < ARRAY_SIZE(checksum_algos); i++) {
-				struct checksum_algo *algo = &checksum_algos[i];
-
-				MANUAL_RELOC(algo->name);
-				MANUAL_RELOC(algo->calculate);
-			}
-		}
-	}
-
 	for (i = 0; i < ARRAY_SIZE(checksum_algos); i++) {
 		name = checksum_algos[i].name;
 		/* Make sure names match and next char is a comma */
@@ -87,20 +73,6 @@ struct crypto_algo *image_get_crypto_algo(const char *full_name)
 	struct crypto_algo *crypto, *end;
 	const char *name;
 
-	if (IS_ENABLED(CONFIG_NEEDS_MANUAL_RELOC)) {
-		static bool done;
-
-		if (!done) {
-			done = true;
-			crypto = ll_entry_start(struct crypto_algo, cryptos);
-			end = ll_entry_end(struct crypto_algo, cryptos);
-			for (; crypto < end; crypto++) {
-				MANUAL_RELOC(crypto->name);
-				MANUAL_RELOC(crypto->verify);
-			}
-		}
-	}
-
 	/* Move name to after the comma */
 	name = strchr(full_name, ',');
 	if (!name)
diff --git a/cmd/bootm.c b/cmd/bootm.c
index 37c2af96e08..7968415b6d1 100644
--- a/cmd/bootm.c
+++ b/cmd/bootm.c
@@ -123,20 +123,6 @@ int do_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	int states;
 	int ret;
 
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-	static int relocated = 0;
-
-	if (!relocated) {
-		int i;
-
-		/* relocate names of sub-command table */
-		for (i = 0; i < ARRAY_SIZE(cmd_bootm_sub); i++)
-			cmd_bootm_sub[i].name += gd->reloc_off;
-
-		relocated = 1;
-	}
-#endif
-
 	/* determine if we have a sub command */
 	argc--; argv++;
 	if (argc > 0) {
-- 
2.40.1


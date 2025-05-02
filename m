Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C24FC3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD9F282161;
	Fri,  2 May 2025 16:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZmsdIeF+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 883E282153; Fri,  2 May 2025 16:47:30 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F9B38212F
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:47:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-861b1f04b99so85430339f.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197246; x=1746802046; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FXs61OHB7Mt0XJuz061j++BPl33SACn75f/DCNBjOAQ=;
 b=ZmsdIeF+qX0fXeffC7X+oRflDJgzPHSHqMPYQUyBZ5um7vDV52RBmdSEnR3xQsfh0F
 slD8fw+JfCuVtUMq9Sh50gDsMO5sT6wJzEpOEyqikUY0ez3tbYebmxYahd+NTalgQzzn
 zwaGZRnVM0VAuPmoh+7Y/d5HFFDjGywHdvZmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197246; x=1746802046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FXs61OHB7Mt0XJuz061j++BPl33SACn75f/DCNBjOAQ=;
 b=p7Bz6TlzZZM0znzxZiD0F58fh1KiGbCfcDlqohNjRkLJVUoIdJ/W+IhLdA6eFaOv2k
 Y16Vfyuu3XzSEVL2JNLY3qaCuo6yWnOzHURZ4CbFh7iGwlPjGtuqxctdU/X8PtJyhWWe
 lvhbgURXur1eNOoJbViyBGbK9OUoLjBBfUN0D0LodY7RqP38TKSSzMR3CXjNByg42AuV
 1tujhOBHdPE/A+qITEhWwq9QHcRNztxe/Dpv/0yfvgJTyQyTN91FYzdsroOIpkntOjO5
 sKxF6Dg6UjhQ3uhx4vaVe7dmzikVGQIzpCthrrx+ATRpPMojJsZFPAD4yhTlKE9mGj2g
 2JqQ==
X-Gm-Message-State: AOJu0YwtFhaE91ak/u/rfnz5PVTot+MqppYs/xJtr3Mxqpo5nMF23CTX
 2c8M9xk/lAYO3BnlevmkT98Kmk8Un8O0gSkp4jmNAXAPd8dFHSf5BBOuuqa+VE3ehlVMEFBTUWc
 =
X-Gm-Gg: ASbGnctECNExJiMWiPPKv+1YkqWCfZMLHHVx7VwnN15RjZKc0T0p8XOOEe4pNCzuuIi
 9lR6k51uIidcJIGUlli3kkjl6aQrywhIhud46kBSrSOm7f4UsDDukDuO7MNBnBd8v5TxkxRu/6C
 vM4/X5ZSkwuCFYIUMDb1uJw3sB9lOM4B675cABsfisbeUhLRK1+5CQ7J9iE38rlXlgmcSUTNSP4
 IdTfG8d+VVURwjZrNMlZjliIX9H6eaT+hsGCkGEY3S9CKSzPByeZmmJ45Fki/xuPhoKUxFgFonn
 53JzVuycTePBCkBf5gCK4+QntRJfcu+/e6OtsIp1kZIM3i5EndIA4NbiyDnCc2ZAXE98bfqD6QW
 k0w==
X-Google-Smtp-Source: AGHT+IGg5jmz6c8HzJjX9tBJOQHl3UpZf6VynfHGaqa8OLp7Ftbhoxhv1dlb7zCiiMSInW/GH36hXw==
X-Received: by 2002:a05:6602:358c:b0:864:58a2:1f0a with SMTP id
 ca18e2360f4ac-866b349adf6mr403879639f.10.1746197246037; 
 Fri, 02 May 2025 07:47:26 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:47:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 01/60] sandbox: Provide an option to skip flattree tests
Date: Fri,  2 May 2025 08:45:59 -0600
Message-ID: <20250502144718.313633-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

When OF_LIVE is enabled, sandbox runs tests with that and with flattree.
When debugging tests, this is often just a distraction.

Provide a -F option to skip the flattree tests in this case.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/cpu/start.c         |  9 +++++++++
 arch/sandbox/include/asm/state.h |  1 +
 include/test/test.h              | 11 +++++++++++
 test/test-main.c                 |  4 +++-
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
index 2940768cd1c..d3bb8ff429e 100644
--- a/arch/sandbox/cpu/start.c
+++ b/arch/sandbox/cpu/start.c
@@ -459,6 +459,15 @@ static int sandbox_cmdline_cb_native(struct sandbox_state *state,
 SANDBOX_CMDLINE_OPT_SHORT(native, 'N', 0,
 			  "Use native mode (host-based EFI boot filename)");
 
+static int sandbox_cmdline_cb_noflat(struct sandbox_state *state,
+				     const char *arg)
+{
+	state->no_flattree_tests = true;
+
+	return 0;
+}
+SANDBOX_CMDLINE_OPT_SHORT(noflat, 'F', 0, "Don't run second set of DM tests");
+
 void state_show(struct sandbox_state *state)
 {
 	char **p;
diff --git a/arch/sandbox/include/asm/state.h b/arch/sandbox/include/asm/state.h
index dc21a623106..b0dfc87f1f9 100644
--- a/arch/sandbox/include/asm/state.h
+++ b/arch/sandbox/include/asm/state.h
@@ -102,6 +102,7 @@ struct sandbox_state {
 	bool disable_sf_bootdevs;	/* Don't bind SPI flash bootdevs */
 	bool upl;			/* Enable Universal Payload (UPL) */
 	bool native;			/* Adjust to reflect host arch */
+	bool no_flattree_tests;		/* Don't run second set of DM tests */
 
 	/* Pointer to information for each SPI bus/cs */
 	struct sandbox_spi_info spi[CONFIG_SANDBOX_SPI_MAX_BUS]
diff --git a/include/test/test.h b/include/test/test.h
index 0f2b68a5dee..cadf39a0c9d 100644
--- a/include/test/test.h
+++ b/include/test/test.h
@@ -288,4 +288,15 @@ static inline void test_sf_set_enable_bootdevs(bool enable)
 #endif
 }
 
+static inline bool test_flattree_test_enabled(void)
+{
+#ifdef CONFIG_SANDBOX
+	struct sandbox_state *state = state_get_current();
+
+	return !state->no_flattree_tests;
+#else
+	return true;
+#endif
+}
+
 #endif /* __TEST_TEST_H */
diff --git a/test/test-main.c b/test/test-main.c
index cabc736a524..aa3eb5a3d8e 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -550,6 +550,7 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
 	 * - the FDT is still valid and has not been updated by an earlier test
 	 *   (for sandbox we handle this by copying the tree, but not for other
 	 *    boards)
+	 * - the -F option is not enabled (on sandbox)
 	 */
 	if ((!CONFIG_IS_ENABLED(OF_LIVE) ||
 	     (test->flags & UTF_SCAN_FDT)) &&
@@ -557,7 +558,8 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
 	    (CONFIG_IS_ENABLED(OFNODE_MULTI_TREE) ||
 	     !(test->flags & UTF_OTHER_FDT)) &&
 	    (!runs || ut_test_run_on_flattree(test)) &&
-	    !(gd->flags & GD_FLG_FDT_CHANGED)) {
+	    !(gd->flags & GD_FLG_FDT_CHANGED) &&
+	    test_flattree_test_enabled()) {
 		uts->of_live = false;
 		ret = ut_run_test(uts, test, leaf ?: test->name);
 		if (ret != -EAGAIN) {
-- 
2.43.0


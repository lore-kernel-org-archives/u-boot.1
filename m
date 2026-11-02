Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C539A606ABA6
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dNPGqtgZ;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=vDG5W+07
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A18D4607F5;
	Mon,  2 Nov 2026 16:21:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NCybF1ZmUBUK; Mon,  2 Nov 2026 16:21:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B5D9F60820
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793636472;
	b=iYBXQD2hr9lZ+KHp03Bm29YlF7Mu31Vy7vL1gT9wyE3UIabCiWW8XZfCmHrmExPgaGf6
	 QgxU5HDDsTAJeieqGF02JScuOr9ZwNevUq2PisdAEa3QVZe7Ihq1CccaWZ8tY23SodE4P
	 6dK0vPsxJer+IyX9ipu6W6wSjZGHpVcCBCZzG14ZXFYeRkweVQE/waGDOwuIWdG/khGFD
	 cwMaVUsqEbo+2YEbis+OyB2jrL09L7n9zwX7LMa0LlnIShOiEZ+SN9QaUyt13+edV2Q/P
	 QiM8vVW6aCd4uLJ27NPnDylHaa5lS7+WBFGclxNrrWLuUrRjMU+X6TngnZLd01QBDQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793636472;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ad5X0DCgauXaDZ/couTbTc+i2M8p1s0xiJniJQdCDuk=;
	b=K/SZLqLvhIKY4JwSbvKNG43OeLLlSEAhxfWh7e5d71V4Y3s0ZMVhjZGfIsWIoDEiZHUu
	 CWzNvqgFaHVyUQlU2G/zx6V2I+Mo0DFu0vlQeY+2B5S0v47BcP2/L55YyuZGTAP3L3pD6
	 4uPjIZYUqbQBhnRzj5xO/VoA1Tqu6wWVAjfVxc7q7ZTe5eruJ+Y/MTem2BS5ETVLlgpFk
	 OXXPpS7SHXrj7JcPT7THrtcMWElxAdyF/WNC4BSwZ7xFKHBAr9XN3lJEkF+ZSV95LnpSI
	 pkmMHDwoeujUDh8EFxjay2bz/Lfn1QMISOCzHkjadWj1/usQXsJLOfdQCHvPwNnVTOA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793636472;
	bh=ad5X0DCgauXaDZ/couTbTc+i2M8p1s0xiJniJQdCDuk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dNPGqtgZGp9xe6/HXDOxDSi/GGrflRhC4jggKHDrb2C2RrSW6xKhiv5II377hfWiR
	 mYMC+5vqmND4ZTnOmnuYG2fBj5fHtmfI0mDHA/DnffUTGvAd9U+qDKnhlWmDzPHEGW
	 Ohisz9ZDl8Ajv6jXmduWVByFEJLtNwPFO64VC+x6KLYqPpEJSMweWJEVwFAbGpDyec
	 z8FMBWyJitQbr7ftAHqFpKm/SVwFYIrTUUOOig+rXppC/khQf6cK9h4k34J4FxikcE
	 GaH66WAbZEoitb9eDQNNS/OFRX6v7m2NaCoVtigR4vcbIGmGkv0V0JIif7tBc1qXbJ
	 v43qltGaAEpIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5D9F60820;
	Mon,  2 Nov 2026 16:21:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3282B435
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 17CF9406CE
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NtxdJrLOAImx for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:20:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 425F9406A5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793636455;
 b=R0X55suFyXPCK7FU2fWAPB9Lvwh+G5s8jSVLl35Z8Cm7WTkMaxoqoZpTYP5DZu+cHoie
 byrxbnnxvj490x0Rc+ye4FPR3WySRec3GaE14n1f6qFaQ+QaKER/5FMX3wOgi7RzUH9RO
 5Y7IIHO+80/1Ztm7H/9u9lpZQZIQ6qBz4hWfcUMrZEejtHjxmC7+90skA1V2y1Ly1omGS
 4Ifq4AjsUJsN6r2fpaleA2mQ6wO72ufyvRU9eeWxXKPDOZLwhlc8vHdyb+SWgKYjfURDm
 Nrglj2/7NUUfeP3O1o1XPdDl+k7gQcFUJmuV4ORe7tWq7qkFTksK3YgmHvDOgLTUtHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793636455;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=ad5X0DCgauXaDZ/couTbTc+i2M8p1s0xiJniJQdCDuk=;
 b=Et/UvBbmlJ0hdI/fn5U6YwYV4/JPVPfjh6YoQA3q6Qg+TZ8IZWGi52ZjWHbxA0QqyZbu
 r8RlrXM6wADessCutj2hJH53mTLC7N96lkQ+eXbAM+mHZl1wk1ALZCOhQRkxCxV2WpWsA
 2OC45gBDiv2CMo+ETjgnKtm17ekjpVPu68vAanCgkYZJ16iNJIKdw249AKRv+Y66lA+Sh
 +hvhMZ4i7OFrGplYf4eWgpyDigQCP928D/nGkBume8uLIBVZPZDKGljyCEpFintmtwejU
 aGshWtcBugeiSlIPRSDn8BLgdjwYNs3E9BaqpN/C8BmwIHnSQcuSGU+Ad4Dam23Gttw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=vDG5W+07; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de
 header.a=rsa-sha256 header.s=mail header.b=vDG5W+07
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 425F9406A5
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:53 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793636449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ad5X0DCgauXaDZ/couTbTc+i2M8p1s0xiJniJQdCDuk=;
 b=vDG5W+07v4oGK12hEsjUjENF6JzSKQVQ+FYumGN+O7I4NBqiB9CAAkk6mwkYQFNZLmSe3E
 9NcEbzuXtOUyCUBiNahj82PEzG/k0NVGLVnwPwPfOUkrdnSFo2pEZrZ/YQA5pgtBsqfpnX
 bzs2RGjw+J3N+jaiylEmP8fI+qRTVqZPmFlaxdsFL1MApvfFYoklthhR2OzgDOnRNFtTZ5
 aKYMJrTWfz8zxw30Ff60IkZbsf0tGODt/MtGAsFw/hdmOaTRXV3ihm6ueuiPZOggC1DHTd
 AL2Lg9xDz3z/qHe/KnHMdB2fYPnuM03czZWFHlM4FDQqx7UP2/Qj6xldqG/8DQ==
Date: Mon, 02 Nov 2026 17:20:23 +0100
Subject: [PATCH v2 06/12] test: boot: Test booting a RAUC bootflow twice
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-main-v2-6-4537bcb19d66@kontron.de>
References: <20261102-main-v2-0-4537bcb19d66@kontron.de>
In-Reply-To: <20261102-main-v2-0-4537bcb19d66@kontron.de>
To: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Francesco Valla <francesco@valla.it>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5538;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=/b3CmdO/ETcYT0DA5SWtD/beKqhr78kw2SH7TpPkWHo=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIevFjljNQzUTDJ3Tv/gu2FYjdlFIeEflw/66+OhzpZ5/q
 y2WyBt0lLIwiHExyIopskjxW7y2NYv1kT9WHQUzh5UJZAgDF6cATOSeIMP/ItWTl5z4JfTa5FYx
 bc/aYWp42tRlYYjlDYaM6+nvDCzOMzKs85dZsn3V5L72Q7b6q5RunnNp9l7i8iS2Vrxi+4WcPn1
 +AA==
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Add a test that boots the same RAUC bootflow twice and checks that each
attempt uses up a try and that the boot script is only listed once
afterwards. Before the boot script of a failed attempt was freed, every
attempt added another copy of it.

The boot script of the RAUC test image now runs a command set by the
test, which lets it fail, as a successful boot script frees the private
data of the bootflow, so it cannot be booted again.

Booting saves the environment, which sandbox keeps nowhere by default.
Set CONFIG_ENV_FAT_DEVICE_AND_PART to the first partition of mmc10,
which has a FAT filesystem, and select it during the test. No other
test uses the FAT environment.

Assisted-by: LLM
Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v2:
- New patch (Simon)
---
 configs/sandbox_defconfig |  1 +
 test/boot/bootflow.c      | 84 +++++++++++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py  |  4 +--
 3 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index a3fa5246082..289fbcf2d34 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -166,6 +166,7 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SECT_SIZE_AUTO=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_REDUNDANT_UPGRADE=y
+CONFIG_ENV_FAT_DEVICE_AND_PART="a:1"
 CONFIG_ENV_EXT4_INTERFACE="host"
 CONFIG_ENV_EXT4_DEVICE_AND_PART="0:0"
 CONFIG_ENV_IMPORT_FDT=y
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index d2d4edb0add..20c371d984c 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1734,6 +1734,90 @@ static int bootflow_rauc(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootflow_rauc, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
 
+/**
+ * bootflow_rauc_run_env_fat() - Run RAUC checks with the environment on FAT
+ *
+ * Booting a RAUC bootflow saves the environment, so this selects the FAT
+ * environment, which is on the first partition of mmc10, while running @check
+ * on mmc10.
+ *
+ * @uts: Unit test state
+ * @check: Checks to run with the RAUC bootmeth
+ * Returns 0 on success, -EAGAIN if not supported, other -ve on failure
+ */
+static int bootflow_rauc_run_env_fat(struct unit_test_state *uts,
+				     int (*check)(struct unit_test_state *uts))
+{
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(BOOTMETH_RAUC) ||
+	    !IS_ENABLED(CONFIG_ENV_IS_IN_FAT) ||
+	    !IS_ENABLED(CONFIG_CMD_NVEDIT_SELECT))
+		return -EAGAIN;
+
+	ut_assertok(run_command("env select FAT", 0));
+	ut_assert_nextline("Select Environment on FAT: OK");
+
+	ret = bootflow_rauc_run(uts, "mmc10", check);
+	run_command("env select nowhere", 0);
+	if (ret)
+		return ret;
+	ut_assert_nextline("Select Environment on nowhere: OK");
+	ut_assert_console_end();
+
+	return 0;
+}
+
+/* Boot the selected RAUC bootflow, which saves the environment first */
+static int bootflow_rauc_boot(struct unit_test_state *uts)
+{
+	ut_asserteq(1, run_command("bootflow boot", 0));
+	ut_assert_nextline("** Booting bootflow 'mmc10.bootdev.whole' with rauc");
+	ut_assert_nextline("Saving Environment to FAT... OK");
+
+	return 0;
+}
+
+static int bootflow_rauc_boot_twice_check(struct unit_test_state *uts)
+{
+	/* Start with the default tries, also when running a second time */
+	ut_assertok(env_set("BOOT_A_LEFT", NULL));
+	ut_assertok(env_set("BOOT_B_LEFT", NULL));
+
+	/* Let the boot script fail, so that the bootflow can be booted again */
+	ut_assertok(env_set("rauc_test_script", "false"));
+
+	ut_assertok(run_command("bootflow scan", 0));
+	ut_assertok(run_command("bootflow select 0", 0));
+	ut_assertok(bootflow_rauc_boot(uts));
+	ut_assert_skip_to_line("Boot failed (err=1)");
+	ut_assert_console_end();
+	ut_asserteq_str("2", env_get("BOOT_A_LEFT"));
+
+	/* The second attempt loads the boot script again, but only once */
+	ut_assertok(bootflow_rauc_boot(uts));
+	ut_assert_skip_to_line("Boot failed (err=1)");
+	ut_assert_console_end();
+	ut_asserteq_str("1", env_get("BOOT_A_LEFT"));
+
+	ut_assertok(run_command("bootstd images", 0));
+	ut_assert_skip_to_line("(1 image)");
+	ut_assert_console_end();
+
+	ut_assertok(env_set("BOOT_A_LEFT", NULL));
+	ut_assertok(env_set("BOOT_B_LEFT", NULL));
+	ut_assertok(env_set("rauc_test_script", NULL));
+
+	return 0;
+}
+
+/* Test booting the same RAUC bootflow twice after a failed boot */
+static int bootflow_rauc_boot_twice(struct unit_test_state *uts)
+{
+	return bootflow_rauc_run_env_fat(uts, bootflow_rauc_boot_twice_check);
+}
+BOOTSTD_TEST(bootflow_rauc_boot_twice, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
+
 /*
  * Test the BLS bootmeth against entries that live below a '/boot/' prefix,
  * so that they are only found via the second bootstd prefix. The Fedora
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index a33f188d984..36d0f14973d 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -590,8 +590,8 @@ def setup_rauc_image(ubman):
     boot = FsHelper(ubman.config, 'fat32', 8, 'rauc_boot')
     boot.setup()
 
-    # Generate boot script
-    script = '# dummy boot script'
+    # Generate boot script, which runs a command set by the test
+    script = 'run rauc_test_script'
     cmd_fname = os.path.join(boot.srcdir, 'boot.cmd')
     scr_fname = os.path.join(boot.srcdir, 'boot.scr')
     with open(cmd_fname, 'w', encoding='ascii') as outf:

-- 
2.56.0


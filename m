Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEE9D66BA1
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 20:13:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E259B83C51;
	Wed, 17 Dec 2025 21:13:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OvOmS3sT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="g+ZR8tnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C692683C08; Wed, 17 Dec 2025 21:13:35 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B744F83B49
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 21:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dWlNs3WHYz9v94;
 Wed, 17 Dec 2025 21:13:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766002413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TgJ6AxG+Ba8udzIDbZjLlJD0ZQJA975b/i3VFLmU7XY=;
 b=OvOmS3sTnse9P0wE4Lm29ajC3DS+JxNH43DxjPxJiXRLMapqEyQbX7DE1nx+ftEFgywIBg
 JN9qAc0Nlmgv7y9oPfjyQyIIrQurshBWT0kr+4HtvcGVySo/2gDYYw/Qm//YG4c3Zy+xeF
 B7UBsUxVZSQNcJXl9jHwkDw5/waUfhaA4SxLk11ilMaNlEpaBTzz8R4xtVbe/4BKB69Fq+
 I1XUr+dfkUu77gDIjRZBtROt2Pecde+cJKwRmN2HI7M7PE8T313CxMQpkihFYSBRhwehFZ
 GEG1UonVpLJkogofflqb8/HFvOefcWMQzgHZ5hZvtY6lmVyJZcZD4ARG8gqtTA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766002411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TgJ6AxG+Ba8udzIDbZjLlJD0ZQJA975b/i3VFLmU7XY=;
 b=g+ZR8tnUnS+2uuyARo2UmDw0m/8PWWjZVEBnbZ5s7d7TAWPLToDFeEFlZGHKWQz7rVbNoV
 fg4BNTGEkEW9LncRbR6Wr1JktNacsdTdteEyzO9AudIVbJy8PCvzhoGOUJhMv0lJSbH5aj
 6PZP6kSnbdtzg3o5kpeTGYALIJFl3n67fv2BdPpolrIGFVZnhwGcBOdHRD4yNyOSKqahxO
 OJSbdWPeq2URFrDB0Jk0nm2IIeNy7HHL6DNMQ9FwJc+4M1YGxsWz40FWwJyxNuIMC5EGF9
 h5JF4t4uZfZAKcV54SgFg4yhDbXai/Pg7BnMoRhlcl/2NdzpLH4b/igPzgXWzw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] env: Add single to redundant environment upgrade path
Date: Wed, 17 Dec 2025 21:12:33 +0100
Message-ID: <20251217201323.756419-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251217201323.756419-1-marek.vasut+renesas@mailbox.org>
References: <20251217201323.756419-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 10563f02b234f5d8dc4
X-MBO-RS-META: mokznnotz5a8fsz6feagdhpwhi1ufynf
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

Add support for converting single-copy environment to redundant environment.
In case CRC checks on both redundant environment copies fail, try one more
CRC check on the primary environment copy and treat it as single environment.
If that check does pass, rewrite the single-copy environment into redundant
environment format, indicate the environment is valid, and import that as
usual primary copy of redundant environment. Follow up 'env save' will then
store two environment copies and the system will continue to operate as
regular redundant environment system.

Add test which validates this upgrade path. The test starts with spi.bin
which is pre-populated as single-copy environment and then upgrades that
environment to dual-copy environment.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 env/common.c              | 31 ++++++++++++++++-
 test/py/tests/test_env.py | 73 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/env/common.c b/env/common.c
index 05e78d63874..f97536af7f2 100644
--- a/env/common.c
+++ b/env/common.c
@@ -473,14 +473,24 @@ int env_import(const char *buf, int check, int flags)
 #ifdef CONFIG_ENV_REDUNDANT
 static unsigned char env_flags;
 
+#define ENV_SINGLE_HEADER_SIZE	(sizeof(uint32_t))
+#define ENV_SINGLE_SIZE		(CONFIG_ENV_SIZE - ENV_SINGLE_HEADER_SIZE)
+
+typedef struct {
+	uint32_t	crc;			/* CRC32 over data bytes */
+	unsigned char	data[ENV_SINGLE_SIZE];	/* Environment data */
+} env_single_t;
+
 int env_check_redund(const char *buf1, int buf1_read_fail,
 		     const char *buf2, int buf2_read_fail)
 {
-	int crc1_ok = 0, crc2_ok = 0;
+	int crc1_ok = 0, crc2_ok = 0, i;
 	env_t *tmp_env1, *tmp_env2;
+	env_single_t *tmp_envs;
 
 	tmp_env1 = (env_t *)buf1;
 	tmp_env2 = (env_t *)buf2;
+	tmp_envs = (env_single_t *)buf1;
 
 	if (buf1_read_fail && buf2_read_fail) {
 		puts("*** Error - No Valid Environment Area found\n");
@@ -498,6 +508,25 @@ int env_check_redund(const char *buf1, int buf1_read_fail,
 				tmp_env2->crc;
 
 	if (!crc1_ok && !crc2_ok) {
+		/*
+		 * Upgrade single-copy environment to redundant environment.
+		 * In case CRC checks on both environment copies fail, try
+		 * one more CRC check on the primary environment copy and
+		 * treat it as single-copy environment. If that check does
+		 * pass, rewrite the single-copy environment into redundant
+		 * environment format and indicate the environment is valid.
+		 * The follow up calls will import the environment as if it
+		 * was a redundant environment. Follow up 'env save' will
+		 * then store two environment copies.
+		 */
+		if (!buf1_read_fail &&
+		    crc32(0, tmp_envs->data, ENV_SINGLE_SIZE) == tmp_envs->crc) {
+			for (i = ENV_SIZE - 1; i >= 0; i--)
+				tmp_env1->data[i] = tmp_envs->data[i];
+			tmp_env1->flags = 0;
+			gd->env_valid = ENV_VALID;
+			return 0;
+		}
 		gd->env_valid = ENV_INVALID;
 		return -ENOMSG; /* needed for env_load() */
 	} else if (crc1_ok && !crc2_ok) {
diff --git a/test/py/tests/test_env.py b/test/py/tests/test_env.py
index 48e31f19b3c..b968321b12a 100644
--- a/test/py/tests/test_env.py
+++ b/test/py/tests/test_env.py
@@ -477,6 +477,21 @@ def mk_env_spi_flash(state_test_env):
     utils.run_and_log(c, ['cp',  '-f', persistent, spi_flash_img])
     return spi_flash_img
 
+def mk_env_spi_flash_single(state_test_env):
+
+    """Create an single-copy SPI NOR image with foo=bar entry."""
+    c = state_test_env.ubman
+    filename = 'spi.bin'
+    spi_flash_img = c.config.source_dir  + '/' + filename
+
+    try:
+        call('( echo foo=bar | mkenvimage -s 8192 -p 0x00 - ; dd if=/dev/zero bs=2088960 count=1 2>/dev/null ) > %s' % spi_flash_img, shell=True)
+    except CalledProcessError:
+        call('rm -f %s' % spi_flash_img, shell=True)
+        raise
+
+    return spi_flash_img
+
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_echo')
 @pytest.mark.buildconfigspec('cmd_nvedit_info')
@@ -574,6 +589,64 @@ def test_env_spi_flash(state_test_env):
 
     """Test ENV in SPI NOR on sandbox."""
     c = state_test_env.ubman
+    spi_flash_img = ''
+    try:
+        spi_flash_img = mk_env_spi_flash_single(state_test_env)
+
+        response = c.run_command('sf probe')
+        assert 'SF: Detected m25p16 with page size 256 Bytes, erase size 64 KiB, total 2 MiB' in response
+
+        # force env location: SF
+        response = c.run_command('env select SPIFlash')
+        assert 'Select Environment on SPIFlash: OK' in response
+
+        response = c.run_command('env load')
+        assert 'Loading Environment from SPIFlash... OK' in response
+
+        response = c.run_command('env print foo')
+        assert 'foo=bar' in response
+
+        response = c.run_command('env save')
+        assert 'Saving Environment to SPIFlash' in response
+
+        response = c.run_command('env load')
+        assert 'Loading Environment from SPIFlash... OK' in response
+
+        response = c.run_command('env print foo')
+        assert 'foo=bar' in response
+
+        response = c.run_command('env save')
+        assert 'Saving Environment to SPIFlash' in response
+
+        response = c.run_command('env save')
+        assert 'Saving Environment to SPIFlash' in response
+
+        response = c.run_command('env load')
+        assert 'Loading Environment from SPIFlash... OK' in response
+
+        response = c.run_command('env print foo')
+        assert 'foo=bar' in response
+
+        # restore env location: NOWHERE (prio 0 in sandbox)
+        response = c.run_command('env select nowhere')
+        assert 'Select Environment on nowhere: OK' in response
+
+        response = c.run_command('env load')
+        assert 'Loading Environment from nowhere... OK' in response
+
+        response = c.run_command('env info')
+        assert 'env_valid = invalid' in response
+        assert 'env_ready = true' in response
+        assert 'env_use_default = true' in response
+
+        response = c.run_command('env info -p -d')
+        assert 'Default environment is used' in response
+        assert 'Environment cannot be persisted' in response
+
+    finally:
+        if spi_flash_img:
+            call('rm -f %s' % spi_flash_img, shell=True)
+
     spi_flash_img = ''
     try:
         spi_flash_img = mk_env_spi_flash(state_test_env)
-- 
2.51.0


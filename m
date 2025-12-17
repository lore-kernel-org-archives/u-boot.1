Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08B6D66B85
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 20:13:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EF5183BC9;
	Wed, 17 Dec 2025 21:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MPZN2tK1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="d/nlXy28";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B2983C4B; Wed, 17 Dec 2025 21:13:34 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A61CF83C08
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 21:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dWlNr39Gtz9tZ4;
 Wed, 17 Dec 2025 21:13:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766002412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YUj+eZ3CzGC0a6wI5QwYOLpkIBM7A1wRSd7+s0WmfTk=;
 b=MPZN2tK1wlCRYv69KzfE9GPY2NiwQ6GjjtFiEG1zI8ewEAVBAEua6w+3lEOpJJmk7kjBEm
 tk4/4ZBoM14NM11Amx25B62wsO0r3GcT3TXCzh48btuVClM0CiVJ80/J6FfmjWGoKiIPdA
 Jh7FEeIDy0NPIScshF5/pj0gR5CIFT2649vjfwGoOyCdQVV8k/LMT4h++Y27dlTuyw1UJZ
 cD9gGz4uy+PpIfi2TNLDzwsdroDB+nCrksTba33T+NaRBJcmh32E716JOfAiGxOUzfNgnk
 uvPBxnZrvApEuudaGO6YKtftnLK5DVv9KoBadBbZR8tUVt/y08r1JKcwsfS3kQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766002410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YUj+eZ3CzGC0a6wI5QwYOLpkIBM7A1wRSd7+s0WmfTk=;
 b=d/nlXy28OtCexMO6Mu4+DS594ve3RjNeSECjvb2olg6z+lwNztNDilKRV+zmGqMwAyde31
 8ha7ub7wS5XDNwoWBfmyvOIT6lRa3wXM8n3E7kNY/JKhxQXG3mi4WXNBOtJs9qcNIFLDn3
 nBSYwInw1GnQdjDwyrho2BlmF5hG5JrdmjG/tkvACjF4abmr58/FX4LsRu7sj7dMpRw50b
 2TI0qvUQ9/P8wcItUOq9l32khAxD9sp37Jg4Ln0lqiXBxKd7dLRmZOGsTw49sljeDyvjEW
 Yvp5f/HF+C4DPSJUtBf8+FId2L1hrROTXJzgB920aMZoULT4yxS0Qct9+VhD3g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] test: env: Add test for environment storage in SPI NOR
Date: Wed, 17 Dec 2025 21:12:32 +0100
Message-ID: <20251217201323.756419-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251217201323.756419-1-marek.vasut+renesas@mailbox.org>
References: <20251217201323.756419-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 294f22524ecf580fd5d
X-MBO-RS-META: kndgq6q3w58irptcg7znghyeta784czm
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

Add test for environment stored in SPI NOR. The test works in a very
similar way to the current test for environment stored in ext4 FS,
except it generates spi.bin file backing the SPI NOR.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 test/py/tests/test_env.py | 99 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/test/py/tests/test_env.py b/test/py/tests/test_env.py
index 383e26c03b0..48e31f19b3c 100644
--- a/test/py/tests/test_env.py
+++ b/test/py/tests/test_env.py
@@ -457,6 +457,26 @@ def mk_env_ext4(state_test_env):
     utils.run_and_log(c, ['cp',  '-f', persistent, fs_img])
     return fs_img
 
+def mk_env_spi_flash(state_test_env):
+
+    """Create an empty SPI NOR image."""
+    c = state_test_env.ubman
+    filename = 'spi.bin'
+    persistent = c.config.persistent_data_dir + '/' + filename
+    spi_flash_img = c.config.source_dir  + '/' + filename
+
+    if os.path.exists(persistent):
+        c.log.action('SPI NOR image file ' + persistent + ' already exists')
+    else:
+        try:
+            utils.run_and_log(c, 'dd if=/dev/zero of=%s bs=1M count=2' % persistent)
+        except CalledProcessError:
+            call('rm -f %s' % persistent, shell=True)
+            raise
+
+    utils.run_and_log(c, ['cp',  '-f', persistent, spi_flash_img])
+    return spi_flash_img
+
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_echo')
 @pytest.mark.buildconfigspec('cmd_nvedit_info')
@@ -544,6 +564,85 @@ def test_env_ext4(state_test_env):
         if fs_img:
             call('rm -f %s' % fs_img, shell=True)
 
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_echo')
+@pytest.mark.buildconfigspec('cmd_nvedit_info')
+@pytest.mark.buildconfigspec('cmd_nvedit_load')
+@pytest.mark.buildconfigspec('cmd_nvedit_select')
+@pytest.mark.buildconfigspec('env_is_in_spi_flash')
+def test_env_spi_flash(state_test_env):
+
+    """Test ENV in SPI NOR on sandbox."""
+    c = state_test_env.ubman
+    spi_flash_img = ''
+    try:
+        spi_flash_img = mk_env_spi_flash(state_test_env)
+
+        # force env location: SF
+        response = c.run_command('env select SPIFlash')
+        assert 'Select Environment on SPIFlash: OK' in response
+
+        response = c.run_command('env save')
+        assert 'Saving Environment to SPIFlash' in response
+
+        response = c.run_command('env load')
+        assert 'Loading Environment from SPIFlash... OK' in response
+
+        response = c.run_command('env info')
+        assert 'env_valid = valid' in response
+        assert 'env_ready = true' in response
+        assert 'env_use_default = false' in response
+
+        response = c.run_command('env info -p -d')
+        assert 'Environment was loaded from persistent storage' in response
+        assert 'Environment can be persisted' in response
+
+        response = c.run_command('env info -d -q')
+        assert response == ""
+        response = c.run_command('echo $?')
+        assert response == "1"
+
+        response = c.run_command('env info -p -q')
+        assert response == ""
+        response = c.run_command('echo $?')
+        assert response == "0"
+
+        response = c.run_command('env erase')
+        assert 'OK' in response
+
+        response = c.run_command('env load')
+        assert 'Loading Environment from SPIFlash... ' in response
+        assert 'bad CRC, using default environment' in response
+
+        response = c.run_command('env info')
+        assert 'env_valid = invalid' in response
+        assert 'env_ready = true' in response
+        assert 'env_use_default = true' in response
+
+        response = c.run_command('env info -p -d')
+        assert 'Default environment is used' in response
+        assert 'Environment can be persisted' in response
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
 def test_env_text(ubman):
     """Test the script that converts the environment to a text file"""
 
-- 
2.51.0


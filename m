Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60938C88E7B
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 21:33:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27E5680BEC;
	Mon, 14 Sep 2026 21:33:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HieLt9n_ZTIJ; Mon, 14 Sep 2026 21:33:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3D12180BDD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789421614;
	b=pgjDyqZXf6LZitYKRbnz3U6lvHhAC64VTPrO8LFKyQx9gAUSWAEuoopucOcAHpvtKTVw
	 jclLVVWqwPE6srvSzuiJdFif0cyZTEV+uCu1+Y0g2mwYg1jhrsa4LhghCjTqFoEQF0KY4
	 eyDaGtElx2uevwHGxSUeFdjLc5HBf0AI8Zx6bfU7EYsPJXVAYqSyTgxSSnwM/yo6zakF5
	 fPybjdyy2VTzJ8hbssRVYuShHCu9HEqre5KJv6UTLP2JjwC/+Pi8WO0hnlhlTWDVdCnVC
	 PkIcIDh7JRV7qbuEc+5lVgUD6K9KHEWym22opmujVZgbxgLlxEYq/WWrbpaG7LZw7Xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789421614;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nko5PKMmgVKuF5Xni5BSj6WukofxW9eJ750XjAXhB4A=;
	b=X5ddRcsIdZSislX0QngKPzT8xGmXGERoKsThCET25+wUqiH+KCc15rsIplGNAJxKMAEC
	 VVHy9Gd7JDrioZuAj9o24eXfsEd6q6iCj4vV/0nnbDDJacYN2nXcyiz49HdTi603EVWhG
	 kRveVUcnGi8UHmXL9vq/I+3GRRPrhtb6SojhLpYCalcns4CJrHCVbR7qN20GmuyXbLVPW
	 xvzsd/odvGTCVx9lLn0mchpiuEPwSXWuMqzPwSJPQtuxRSV9dqafF0USe6MSWCZaObxdn
	 fIeuRv+Fqg4QgCHw+OF5GwjuquMLMIMXl3/MmXYsr7vpa4LSpiyr7eyIeHB6o0GfOJQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789421614;
	bh=nko5PKMmgVKuF5Xni5BSj6WukofxW9eJ750XjAXhB4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j5FrghDekw71ygttY/Ab3otPYnsjChue8/1hcGhW0UHehbBFQHgoYDphmXG30KZRL
	 7v5svsI9tlRo+HdQyceb65S1/q+P2gRzskZvG6k1pLnmukm2OaiDmxA1k4UG+gAO52
	 4FwnuCpr3xeOZk25Ule18RpOdnCKtRX243TTZDUT7tCxTwozw81i99ZdgZSht6XH0R
	 5JdECbuH5w5h8O0pO6wDnptl03xy63Q+GyyO0GmJ/0MfC0JRfn7z0m8iEb9VIpXAWa
	 Klqd2CbkCqQi7IM6AD2dRUFb8U6i6dOHuHylSwLCbX8wM2z4ooHXW2CpD82f5VrbBU
	 Oy9XLv4Fv8UlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D12180BDD;
	Mon, 14 Sep 2026 21:33:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D9B8362
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:10:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 104DD40076
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:10:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IOeagmSthHhY for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 20:10:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4860640055
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789416645;
 b=RayX3hCZaf4fO/IoaYfDbxYm+g8lRbZ+u9V+KlYzS82yGXENxc8S5ZYNH/gDo9MRSV40
 l9IdhEnDrng7dzmobB6UOFGKHcLTB+oTA/DDwhBMGVNWXMp8RbmD5LPeZ0TVIqTmzbyAz
 Nvuy2hBDjzsutWp6LfAY9ZUFB4EFClBhOg7oX+syHii54OMz+BYfvD3E8fnECM2ImJFz3
 AZEsg1zA3FmxFm28z8UrjCxzeKLXpqEE9M3KHo+/3Nlx3HsVE+uXuKo9QwAbfy88GY4mN
 ezp4Dkoj1S9H8M6DP4eKdTsQ692GTphqGou3Weun4m8ifK/JMMl07QdH9gALf0Uiw0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789416645;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=nko5PKMmgVKuF5Xni5BSj6WukofxW9eJ750XjAXhB4A=;
 b=i27Sa6UA1/UACFd33/1GJEnRtbOeunnZMASlIZE4OmMPK7czxSkJFUbKNVYuKymgYxuH
 F4DDLSN2s1rXw9k/m4lEL2iQ0h4z23P9RTJ9IAFUgx9cArAo1TuRi3QiaWLNG9/HOmiuH
 OlbrwATUxN+BiSyjRLCLNVK/I4ayi+PhvMyyQmr+mU8WG1Zvu5qxwkdQN80uOPS5DqbEQ
 KaceTU5hD0hXDMuE7pbM4n3jvwGbEBBdbwJDynAU+om45R8VhMiDvNKs/snB0gJQxXEPN
 F40iitjEFMU7LSwjXf4huju3pVlGzeA5pGm56kE8A1wuSWl5sxsV8JpQRxgH3XNJd5w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Jb7GPiUs; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com;
 envelope-from=0xiviel@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Jb7GPiUs
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com
 [IPv6:2607:f8b0:4864:39::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4860640055
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:10:44 +0000 (UTC)
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccc09d65so2439757a91.3
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789416644; x=1790021444;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nko5PKMmgVKuF5Xni5BSj6WukofxW9eJ750XjAXhB4A=;
 b=Jb7GPiUs8r5YK0XvcbAqM+V7VoODL5oQ+gfePIOHe9OR4o5eN3AUu64nCLAiNiTV7J
 F19ne2MRaAs3ZnBl52QHuug4qglcpdnLLWql3Z1SK8+CwCzm81qBN9F5iZQMmtKBh7Px
 TldaOTtWuy3KyhU5WyGAYAqdkeZXUN5zs3iWG2UZK4UGTi6RSPylh54Zui1MtW/uTw9d
 891X3I8Xizm1djLtq95GHwhR1XPoRlWpdQubXHF/0FrnkjeRt/jCw4TxCq11+H/4Gz4T
 nN3HU0fZ2zwHPG/wlrhOfTUFPbgCTdaL9dKduTaNhjvnbNNW0OlYcauYX5yz+bbnR6Ly
 ROqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789416644; x=1790021444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nko5PKMmgVKuF5Xni5BSj6WukofxW9eJ750XjAXhB4A=;
 b=Rsjd3tfKBL7LjG5zHoBt8nCl6GNDgAFZGp5VwZ57kiR78pW+ErNB8Vi/wfwm3l+MyJ
 Ov7Fd2h/R+o8fjGUcycLl+VtIaPZ0cKhGMhbjbJ5Fik+QPBbNpdw1X5Yu8ROm9Cnz2Kt
 IoeEh667zNyuqr6jV98XDc7G/X9CZlo7s8Ay0Oto127bYJK2kqJKumWfs1pPAKDNtVr9
 FzlRSzKGwhtzCxqhKvIuM1K6y2DEt0e7Ct+8xLwvi9QiUXo+vAc7z9wlA6u/Z0fc8W9y
 uQOUegRZVQyeSsLbZUNx+ESrKCcX8WMWh5G6y+PkzvzuDsLm8gH6tqeNQnbfQ/GpxiXj
 a1aw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwT1dj9KUIvSWLbyWAlES10kkY4Givl+xpmooSPVx6f7rDUW/wJR8vJGhkn71I0oiLAWtllVMk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nqlq6FjdA3+OHy4xXURrWtyYNoubuA0U1bNBx9+Ih3E4mw366C
 01Z9nVgUnbzwFDlRYAFgP1eSbyHbd5yVFxTvmNZ5epU51C6+npMHNRxv
X-Gm-Gg: AYBFou0UbA5X0k/qeE8ZprXBSyMVHRJ/9RtSbazuHN/S2TJthBw/tP8MPBCHtl5fiUv
 9wKfsR7vAeGerrx0cfFvcjbZn20eCp/GLma2a8cK67DzT3qYUC0PMqx9HWCQ/0Ug/CcdwG7Yi6K
 v1eljW2JgfC1XBy+jvrqk6O9O6BkI8pnyxmEdBqKhZ3Ulyq5M66n+36g2p7wT6HrEwHjv4sKZWQ
 1JBZQx2Pe+gpVj/2835M7yMHZUbAsrDs1f/kL/D1dLfKCuGK3sLka5Yb0bFFWahk00wZbUw3Vag
 1lTFdCs8Q7um/qDW/PKNCjiBC84s6j+6s1jFInDHP0vZIE0nmjS3wtGlByS0R+uJ9gGH3JmwUgE
 4zwCWipFHGyzOZ8lzAIPWrctk90BF+q/+ViD62EwpzreYbhn83MNkzVvM1afaCr8r0ysgNeFka/
 YT9oBuPLQXSGJHAOh3NDYNzTDfxSJjKgCPSzZ3fwFTaY9rG50OwTGqT7le/UO+pIlMQstyNWrUb
 N//xfmom5wSfSynXG/UrV4E5QncWqvLTHza/vAnNGmNnLTenvfCh3+mrDtvHc8Zx8GEjQvFG4sn
 0Bt1BHV9kpeYcN/LULOxYRXdgm3LNJAlxM4fs3Y/2Pjx
X-Received: by 2002:a17:90b:1c90:b0:39d:f660:fa9c with SMTP id
 98e67ed59e1d1-39df660fademr4648384a91.10.1789416644101; 
 Mon, 14 Sep 2026 13:10:44 -0700 (PDT)
Received: from 0xiviel.ip (122-63-135-80.mobile.spark.co.nz. [122.63.135.80])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfd9c557asm1005407a91.2.2026.09.14.13.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 13:10:43 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: trini@konsulko.com,
	u-boot@lists.u-boot-project.org
Cc: ludwig.nussel@siemens.com, jonas@kwiboo.se, sjg@chromium.org,
 daniel@makrotopia.org, anton@binarly.io, Eva Crystal <0xiviel@gmail.com>
Subject: [PATCH 2/2] test: vboot: add coverage for a control FDT with no
 /signature node
Date: Tue, 15 Sep 2026 08:09:05 +1200
Message-ID: <20260914200905.280557-3-0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914200905.280557-1-0xiviel@gmail.com>
References: <20260914200905.280557-1-0xiviel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 21:33:29 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Build a control devicetree with no "/signature" node and an unsigned
FIT, then check that the boot is refused when
CONFIG_FIT_REQUIRE_CONFIG_SIGS is enabled, and that the historical
fail-open behaviour with a quiet console is kept when it is not.

Signed-off-by: Eva Crystal <0xiviel@gmail.com>
---
 test/py/tests/test_vboot.py | 96 +++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index fd91b3f10a..a864a541f2 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -846,3 +846,99 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
     # keys created in test_vboot test
 
     test_add_pubkey(sha_algo, padding, sign_options)
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('fit_signature')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtget')
+@pytest.mark.requiredtool('openssl')
+def test_vboot_no_sig_node(ubman):
+    """Test a control FDT which contains no /signature node.
+
+    Both required-signature gates in fit_image_verify_required_sigs() and
+    fit_config_verify_required_keys() look up the "/signature" node of the
+    U-Boot control devicetree. When that node is absent there are no keys
+    marked 'required', so nothing downstream can fail the image, and a FIT
+    whose signatures are absent or invalid verifies successfully.
+
+    With CONFIG_FIT_REQUIRE_CONFIG_SIGS the missing node is an error and the
+    boot must be refused. Without it the historical fail-open behaviour is
+    kept, so that boards using FIT_SIGNATURE only for image hash integrity
+    keep booting and keep a quiet console.
+
+    This works using sandbox only as it needs to control the device tree
+    used by U-Boot.
+    """
+    sha_algo = 'sha256'
+
+    def run_bootm(test_type, expect_string, boots):
+        """Run a 'bootm' command in U-Boot.
+
+        Args:
+            test_type: A string identifying the test type.
+            expect_string: A string which is expected in the output.
+            boots: True if the image is expected to boot, False if the boot
+                    is expected to be refused.
+        """
+        ubman.restart_uboot()
+        with ubman.log.section('Verified boot %s %s' % (sha_algo, test_type)):
+            output = ubman.run_command_list(
+                ['host load hostfs - 100 %s' % fit,
+                 'fdt addr 100',
+                 'bootm 100'])
+        assert expect_string in ''.join(output)
+        if boots:
+            assert 'sandbox: continuing, as we cannot run' in ''.join(output)
+        else:
+            assert ('sandbox: continuing, as we cannot run'
+                    not in ''.join(output))
+
+    tmpdir = os.path.join(ubman.config.result_dir, 'no-sig-node') + '/'
+    if not os.path.exists(tmpdir):
+        os.mkdir(tmpdir)
+    datadir = ubman.config.source_dir + '/test/py/tests/vboot/'
+    fit = '%stest.fit' % tmpdir
+    mkimage = ubman.config.build_dir + '/tools/mkimage'
+    dtc_args = '-I dts -O dtb -i %s' % tmpdir
+    dtb = '%ssandbox-u-boot.dtb' % tmpdir
+
+    bcfg = ubman.config.buildconfig
+    require_config_sigs = bcfg.get('config_fit_require_config_sigs', False)
+
+    # Create a kernel image filled with zeroes
+    with open('%stest-kernel.bin' % tmpdir, 'wb') as fd:
+        fd.write(500 * b'\0')
+
+    # We need to use our own device tree file. Remember to restore it
+    # afterwards.
+    old_dtb = ubman.config.dtb
+    try:
+        ubman.config.dtb = dtb
+
+        # Compile the control devicetree. sandbox-u-boot.dts holds no keys,
+        # and mkimage is deliberately not asked to add any, so the resulting
+        # blob has no /signature node at all.
+        dtc('sandbox-kernel.dts', ubman, dtc_args, datadir, tmpdir, dtb)
+        dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
+
+        # Confirm the premise of the test: no /signature node is present.
+        out = utils.run_and_log(ubman, 'fdtget -l %s /' % dtb)
+        assert 'signature' not in out
+
+        # Build a FIT whose configuration signature has no 'value', i.e. it
+        # is unsigned.
+        ubman.log.action('%s: Test unsigned FIT with no keys in control FDT'
+                         % sha_algo)
+        make_fit('sign-configs-%s.its' % sha_algo, ubman, mkimage, dtc_args,
+                 datadir, fit)
+
+        if require_config_sigs:
+            run_bootm('no signature node', 'No signature node in control FDT',
+                      False)
+        else:
+            run_bootm('no signature node', 'Verifying Hash Integrity', True)
+    finally:
+        # Go back to the original U-Boot with the correct dtb.
+        ubman.config.dtb = old_dtb
+        ubman.restart_uboot()
-- 
2.53.0


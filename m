Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AA0606A322
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZVzlKQ2X;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=kZDhlZhw
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30A7A407FB;
	Thu, 29 Oct 2026 10:05:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uLUuEAhE9otQ; Thu, 29 Oct 2026 10:05:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0D5F3407EE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793268313;
	b=gSnfAP8oMcgb2cZjCpJrEdtG29dRhOndQ57MFeIgbix0BWcQQUa9YbdHa9EWV0mY9982
	 I0Pil2RIrkK9V7Rf+96MOJ1tsOI6+Og6OufvSSklWOuwygkpm1slWRzCHlyzWCN4b9C8/
	 bObiBHHU9uCnDzAMlosiHpU+CfU1tuwUhrOizxhgErF6YyMfaoHOkeOJK47FAOt4JIeYl
	 R5fMSh5W28uH5DkcuU3XRV0mO+pKH3J4vmPpzX6h8CuIfuDcEdFjRrn83nOxEmU5OR2sm
	 4uen2UEM1fsAuPgkQ2eaw4uFlVgM5PS+YwijtMki9u2ClyYRIed+HVHmg9KhiwJELeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793268313;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ylMFrknlpgjUahODTyrN+BGplp8Ytzo9pjXGjONolB0=;
	b=cMHTNnsRqT0WmFLFxeLJMeP8O1I9e14VEJUcWgA4HEp6blQqb228DWyQsDRgxsBty/tM
	 FoGrnidyxFGH9+pqiwk/BDYKa56RMl97/kSCFFSr6OZ6P6zKLjq3gV1rf6BIFpAg8VmSg
	 i3ZpkEX/gQv3FamXU1KNo5OZcjNGjAYlTRE1LC6BGYz2clVRvAZ1ylnNvDMW/S9d01MDc
	 J8G8Dw2rEW3NTWgOXT7zh9JGESamF8uSMh+YTmZqzfa9choN4OcMaE7HF74e9qf9Wt/44
	 iGB+VwgrU1gIifqAcDJh9JmqlzD7Er56nUjZBMS6g6GjR/Be97aBKPX1BNM0Y1wQMPw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793268313;
	bh=ylMFrknlpgjUahODTyrN+BGplp8Ytzo9pjXGjONolB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZVzlKQ2XDTmY/QCF74WeniHz5iks2DkuTCJ09XFIKbzwbLvmNx/ZCG1C9LJ78Wjuf
	 qnxvaAYPS2IAxzseNxCNRCbg/MTmsCRB2XUCzP4NfHhjUDzkFeb5+atiYY9Wx1j3bZ
	 UxdfDlY2vTuYZLckYgefMRyVHE4ZqK+XKWtm+RtkGc6YV7G7krjr8TxHEf5DlG5+IG
	 jf+BzC90LGzbh3mDILn+CiI5Vf0DkcQcUuUQpTOovtTH1EzXnsUAX2iVOzJIf0xxfF
	 oNzXy+9KA0aK79m2TJxTjLFmf/3e6A9tWJchdYgfNuwFQ9dMd2f/sw0Ezm2ptuUD0C
	 jo4U6k8KnXoxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D5F3407EE;
	Thu, 29 Oct 2026 10:05:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F064972
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:05:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 610C960677
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:05:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zsPsCUQgbV_X for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:05:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2AD07606CB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793268306;
 b=T72mSxDLN5rpDQoRtEkk/4PBRIhcWTGA4iKz5ICEcpzSd56xD2OwrUi6A4IePGah824N
 jJd1IA51pC9/heNc9c1H9eveiG9aVRW9HBlsug1/Dp0BFf07B+w/ViO6JmeEUAFK0YTmh
 DEtnXo3koQYVPyprNgkRPyI6LlUVG+LCC+w9VhftcKj1PnFiJfcFB6u1a/ndLpg5hE82w
 5OcH1UgNHrDlbtx36wZPagt5W4y7nAajjzdBMP/KnHAVkKaZds6i7tf2YGwPrsTz3lPQD
 LnnT8/zTi4Dh/4GKmb2LXS7RFQgdx52fL4EQbb5FrfV5S1wF852eqPv/qt/SzQnWTLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793268306;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=ylMFrknlpgjUahODTyrN+BGplp8Ytzo9pjXGjONolB0=;
 b=CeUCIiJEfQfE9Go5/wLlI3g4+oomoQG8a+bW9K44nJESKxFUzlN3MXjtaN7BQi/XVOpU
 uAtwdO5cM+St7NsfBerSgBqGlimkXQkL+8LmhgTxmNpPaL/DDt9emnw7zoCoPumIUYPv5
 fjnVtn0hN+MGpKTXOVSqrcrZA2kgCupDn2tuxOwX4ZXB1yCTRpVhpb8cF/Ho2TG8dty1Y
 +7h6dfoOsAOmc3iPUC52CQiG+SE9UhyXv3gUpPxJqNT/CMPRCTqAXJP6JDug5yjgO3f1j
 gWxjsU/G2auTAPMJxk0go3rm6vpL6pKN1oshJuujsOoV2YG67T0WJvSuBifwbGma8vA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=kZDhlZhw; 
 arc=none smtp.remote-ip=185.136.64.227
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.227;
 helo=mta-64-227.siemens.flowmailer.net;
 envelope-from=fm-1328817-20261029100502bca7b90408000207e8-yjsk3d@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=kZDhlZhw
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2AD07606CB
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:05:05 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20261029100502bca7b90408000207e8
 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 11:05:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ylMFrknlpgjUahODTyrN+BGplp8Ytzo9pjXGjONolB0=;
 b=kZDhlZhwSnxNKpD0s7r+hrMU8zeAZv7q+bEFxFa6HNhrbC4PIyVWelqQ7vBbokSYlGif4w
 ZhrhuprJraQZmUBpxlqdzInCZTP/Rqa1S2RRnnD7tsc8paSBM9etE8W8SvdUjHwsRTTTAOmS
 2txLoQ6FEzlXEIBeczwf0HilYQ97HNMXYoW4jOoUfYz6RgJmmM5dgFA7j2Z5JgU4Ou8gXZ86
 EKyLe1UnIv3sB4ZI1TOW4UDKjf81YVOvXJf4NM1CiTmxk0guwOsfXzJ8t6iHSnjsIEya3LmP
 tGcwaLkNMkNFckZsrzKpXfzi4EMKIur7Y8m7Rdt5T5/lzaOu6CiNTBtQ==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Anton Ivanov <anton@binarly.io>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v11 5/6] test: vboot: refactor run_bootm
Date: Thu, 29 Oct 2026 11:03:56 +0100
Message-ID: <20261029100455.31820-3-ludwig.nussel@siemens.com>
In-Reply-To: <20261029100455.31820-1-ludwig.nussel@siemens.com>
References: <20261029100455.31820-1-ludwig.nussel@siemens.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

- split off a generic part of run_bootm. The helper function is for
  future use in similar commands
- moves u-boot restart below section opening for better log structuring
- only look for expected string in last command. This way a failed
  assert() doesn't dump unrelated output.
- use f-strings in the refactored code while at it

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
---

(no changes since v6)

Changes in v6:
- Add missing return value documentation to run_fit_commands()
- use f-strings for the refactored code
- drop not needed length check for command list

Changes in v5:
- new patch

 test/py/tests/test_vboot.py | 55 +++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index a39cf698b54..0ecb804832a 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -151,6 +151,39 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
                                  tmpdir, '-I', tmpdir])
         os.environ['PYTHONPATH'] = pythonpath
 
+
+    def run_fit_commands(commands, expect_string, fit=None):
+        """Load fit image and run commands in U-Boot.
+
+        Asserts that 'expect_string' is contained in the output of the last command
+
+        This always starts a fresh U-Boot instance since the device tree may
+        contain a new public key.
+
+        Args:
+            commands: list of commands to run
+            expect_string: A string which is expected in the output
+            fit: FIT filename to load and verify
+
+        Returns:
+            The joined output of the last command run.
+        """
+
+        ubman.restart_uboot()
+
+        if not fit:
+            fit = f'{tmpdir}test.fit'
+        # run commands that just prepare for the actually relevant one
+        ubman.run_command(f'host load hostfs - 100 {fit}')
+        for cmd in commands[:-1]:
+            ubman.run_command(cmd)
+
+        output = ''.join(ubman.run_command(commands[-1]))
+
+        assert expect_string in output
+
+        return output
+
     def run_bootm(sha_algo, test_type, expect_string, boots, fit=None):
         """Run a 'bootm' command U-Boot.
 
@@ -166,20 +199,14 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
                     we are expected to not boot
             fit: FIT filename to load and verify
         """
-        if not fit:
-            fit = '%stest.fit' % tmpdir
-        ubman.restart_uboot()
-        with ubman.log.section('Verified boot %s %s' % (sha_algo, test_type)):
-            output = ubman.run_command_list(
-                ['host load hostfs - 100 %s' % fit,
-                 'fdt addr 100',
-                 'bootm 100'])
-        assert expect_string in ''.join(output)
-        if boots:
-            assert 'sandbox: continuing, as we cannot run' in ''.join(output)
-        else:
-            assert('sandbox: continuing, as we cannot run'
-                   not in ''.join(output))
+
+        with ubman.log.section(f'Verified boot {sha_algo} {test_type}: looking for "{expect_string}"'):
+            output = run_fit_commands(['fdt addr 100', 'bootm 100'], expect_string, fit)
+
+            if boots:
+                assert 'sandbox: continuing, as we cannot run' in output
+            else:
+                assert 'sandbox: continuing, as we cannot run' not in output
 
     def sign_fit(sha_algo, options):
         """Sign the FIT
-- 
2.43.0


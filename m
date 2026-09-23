Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72606C98307
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 11:51:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00F9B80F14;
	Wed, 23 Sep 2026 11:51:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UjoySfDbTtzr; Wed, 23 Sep 2026 11:51:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5852780F24
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790164277;
	b=WFMAXFPhdsiNmkyqkWmjA6Fja5UWcxeTKc/4d+YZuSjLIl0o3z0rY0wEcQY4+xD1HonY
	 wrx6qMICaFD3zRRtuOSgeo/x0wIM90an8DD6fg26x5JdluTnIukEBfyOmV/9mIO2T/Sxo
	 zTy7bM8cFE1rIlxVlXmPT8OPvDx3KZ+s1A3O8BJNJY31tRh4ugj1lLxWw5wbRfc7TVjGa
	 qizD5YS/pTqOwxz+AunWZ2cZilyWu4dwlWL3B08nbchn+Vbtl6Rq6A2ffWjrG0gKkvB7q
	 tjckK02ENvCkdxrjAyngZHmG0LjVoJssrsoWc441HYvWYDSTzlO/Euf3AoRpAmbK7xg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790164277;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ylMFrknlpgjUahODTyrN+BGplp8Ytzo9pjXGjONolB0=;
	b=LsmmuzWEVvajaH/szjwn9KyIpdN0XRWaMwDrGwzuw0aE+2QARdjlDzoWjl3Ymn9qRZ0Z
	 MZTG+vMFJWBNeqNrkwhUjuJxSS/xrmSzbrZ0CX0oIDUgFFG0xl88KitHLGsDZREXjeqsj
	 6NhEhwptqPIb77GB4W/op9DFYpn9CCSyPcTrWrKqZZUzXeLwa9R7NBXfKcKDggN/9bTsh
	 T1ApxqY9f5urpOHbwG4xV7FTJpIXxMXEWqse5Hz9V7IhA0wDpdyswJpvXR+yTk/Dvsy+G
	 iKfYa6AsPbm/FUjXA7qqF+W+94DAdRqqy+yZ5uOA/Zp95qSR+dvzH465CqQ36vJLJWw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790164277;
	bh=ylMFrknlpgjUahODTyrN+BGplp8Ytzo9pjXGjONolB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bgu1HLCXZuQ9P+hod0LhynG/YxYG0pk6vmxjWVLBlddv6JT5QFayLXo3BPh3m4ITA
	 hz32Tm+kl+2poK+wmeBgbwUPuHQhgrjZyF6YgFUGMMqSs+ZFjQkmbUkDMmPgtyXqdx
	 5om+urb/rUEdn1JZDo5RT9nsAEJJwiSpgWfvwB/IGE6XUhJ2xm1vW1WqquzdRhfuAt
	 eA7L1haHTSAwK4pbaMD5wTV78CEnH799/vDs10HzcHu5tCyw8D33bZXwGEuqo0dk94
	 Q/f8fEt2Ae9xPaZySYaGWk4CjS5GT8598gA4NmEIM86BFWSHwnBSADApreSRnF7zKu
	 BtlZJsMAZICew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5852780F24;
	Wed, 23 Sep 2026 11:51:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B0CB535A
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A312D406D7
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:51:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zj_d_LhYWqud for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 11:51:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B1315406B2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.228
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790164264;
 b=Ur/NTafKvO7lWBgUdD+eYMxZv9nf2SoMKhJpvy3fqvYmNykrHR/FXOvd7cOUF1ca4sBc
 sNnTPAMY66iAp2maDbNeqpIAH61iAMuICODHg6ytYhuwoq/Kf0PwUfKuIYIl3w2L0Aybf
 hXGyveq0kGsfjeac0II63GYnrGXnz8j3163q2VthjCbKxvWJaEI7XT7Ldmo056978qn4g
 Xlzm1zN4mtqx+a3Hanu+d+PhNcJ/RsxHU8VolhcR8uVfnCVi4rTUT0yxvACaojvvgpB6b
 eDXAIGxz8dUfbjyRRJCjdCaw78V7q2GSdJUVH2AV9cu1tvxa8mMQjG6pVdD1S5PHdGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790164264;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=ylMFrknlpgjUahODTyrN+BGplp8Ytzo9pjXGjONolB0=;
 b=bLCHmqf4F6N4Y2Fr3a6SeaL87BynMuTdLoud3IsyibbsnI7gAZLJ7SoTbF3FL+RfWmEB
 VR2/1i6s35mrIPLWj+hE2+5ouHwXLYYAeAjwKQxhN0IUSIjHhZjVw4Hbyw6rtSorAaR6t
 EgGofwYjJtc+Lz85RNfVsX59ZyPCc1T5nBtizmQd1hAp3tJtcVvtjDaTom9fM/FhzW58k
 UxORWnwNot4ZwwR/29XCGLB73+yND1Yxt3uQQcbpyqmWY8EUA1oe/PkAzY8YBuRnouUww
 I+OAXdpzwT85xUIHFTgvaiLfYIjMjshu/zh0NfO4JOc1/NE9VAkBmjCG2w300gDagdg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=O4qO4z8X; 
 arc=none smtp.remote-ip=185.136.64.228
X-Greylist: delayed 66 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 23 Sep 2026 11:51:03 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=O4qO4z8X
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.228;
 helo=mta-64-228.siemens.flowmailer.net;
 envelope-from=fm-1328817-20260923114955f05957b674000207e3-hqqql_@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B1315406B2
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:51:03 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20260923114955f05957b674000207e3
 for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 13:49:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ylMFrknlpgjUahODTyrN+BGplp8Ytzo9pjXGjONolB0=;
 b=O4qO4z8XZ0w5kRjSWvP/F20RtdelNmJYjdcZeJOBM1u1kqxvlhdSD6V92e/nU8SymSu4C2
 Hxd1Fn5jqRk3yUIyHS1wFcypWtApxiCXXMuAwxbN5zzrmso5cOQyMMfzhrfC5pYqEStnLUIw
 rR6QNSgEQnzbEGK4JgVWcIKA3eUTE3wkciSWBzKBGOVIHlj4m5FqJkBEOzo454ql6yqxD7AJ
 SgilcNR7ThURwPSfZWM6yx2hhk6oS25dTj02wNfHAYy4zn9C3cv/vxIJoxo4rhEejIZrEwyQ
 AYhxF4kybV+P6TGF/iktdX9RAGziZftK1t9mkJJmIHCOtBFwjAZM3KRg==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Anton Ivanov <anton@binarly.io>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 6/7] test: vboot: refactor run_bootm
Date: Wed, 23 Sep 2026 13:49:33 +0200
Message-ID: <20260923114940.349985-3-ludwig.nussel@siemens.com>
In-Reply-To: <20260923114940.349985-1-ludwig.nussel@siemens.com>
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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


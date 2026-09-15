Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF73C88E7B
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 12:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 512674066E;
	Tue, 15 Sep 2026 12:53:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KL6rNMj6EafG; Tue, 15 Sep 2026 12:53:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 839DA40663
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789476826;
	b=J8loVdyQmXm0kUsNVmPxGTt+W89v0xOMf9483nNJtW3s4hjUPt1ZWh1krfLayNlPRCaO
	 EZwwscjxXDNh/BwJX9UU/zW6b9NMc/41/vb4ztUnQwMjynN4jePGShnf4+BTguhLbtY2I
	 AlT1/tCwxdKuldmgXLZKiWi8D/51fzSxTwrr234+KR1WH+kCNOy7YP0XO4sR1m96X8w0k
	 eZ3Qrp1g/2cCmGaefoV///LPWKUAEoQJrZZnGA3HQtVZRAGp9ENn/peBn8tktMNvNfVM7
	 Yt8a37WliD+YcGuhhoV5X1d4wwoMCxXwImDgBhRTviWYDBruNCdu1mIYzWHa3Ilvm8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476826;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HAeA9BfaKX6ydfAr01sw86PjpLddr4h3awZ4DdqL09o=;
	b=gWCcHxRfG4JLjoDyRfqNGjBh9SXr8ZUY7fSsjQPLJp5uGGB0rzDO+DDJtCgasW9jVxmc
	 p7iR1M+uZ7dpoDrHwMhVwc+Plkdi7hkOt6JnX/R6NKBDKH+cf/Ju4lwFn6jwFRxUCWHQV
	 WtP13za9xeXdfLfLVMYWd8CoD9OFG/kLVYdxhT5RLLVTaN4C9xD5H04brQcoCKzECcrZr
	 VVekNrWKVRi1xeWOSnm4xhMzTdGzGhLFLuIKmul0q3xxMa6L5/C2Qf5QrqYi96WSQJg/o
	 1n7yoG4JZagNsAOGI9uXROd6UFr8XdwtjCEmOw10cBeHbj0VJ9aRNGal+fjaFkgdtzw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789476826;
	bh=HAeA9BfaKX6ydfAr01sw86PjpLddr4h3awZ4DdqL09o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oxUrKCWCbAvoVuqdUjZ7aLAMCtcb4yjuV6myDnevVab+eZ3ESDI3KYe1W8s5fiGhy
	 4X/z/Fjrl+SIkr1yn32TTjd552ebJn4rQ4GkMH/nWgJAqJ/u+z4t2PzLLyJ0lf4n4+
	 M0EFXEt5bwfMRbc9QmXlBXyXaoMM7rRS4QWYKYnamXMFJ3E6EvN+AYgoc+tzCex+wB
	 ZGa1x2LjRYvxVu5gZ9LokmkEaYNgDSlEZH3HHpV7E0SJ/4fGwUm6LgAwrPalq2kjJG
	 CbJzyDBBjvreTqrvXohMO/N1d2DXGqo2l/wdOxfaKoFBaFfPq+0QlMDLGYGUO8EcQO
	 kVsMYkERKbp4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 839DA40663;
	Tue, 15 Sep 2026 12:53:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DDB36493
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DBD3A4002B
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jLzQIdQJYo_F for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 12:53:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 243C3400DC
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476812;
 b=NRgY1lWfUpYQ+oIt2MIS93082RVwhWjSmsJmXvrOWsA7dvclH9G+NFKISpohDao+iA8l
 p22/AmzPFPYobQJ1SvrSxtNnpcHGk5C7/Mkzswqn9IuPIobQciRtize/RFY89ubpJcNvm
 sOS7/U/PSq9FcRuTP8BE9+OifEvJIuQPPbSS1xze27e18v2rzPrDKQlPFKQTn4g9LjnxF
 9NMboQoUkmUYCNt1sBELtOY6vrzNb1F2K40S9LWXQZDqyUtx+7c6oMKQkp9EsBuVZSkPu
 4Mw+1lQ2AtDKM6hb8z1pXbaoRFSiG+DmeQFDEZOP/pSGHX8bqJbpTDvbMn/+PKgjxog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476812;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
 X-Flowmailer-Platform:Feedback-ID:X-Virus-Scanned:X-Virus-Status;
 bh=HAeA9BfaKX6ydfAr01sw86PjpLddr4h3awZ4DdqL09o=;
 b=UM9OKyo3uXwK19b8AzTX604t+7PRs4yL5whz817BBhHGui6AeTNPQzZtsfUGcO9JbF11
 gdSDeG7N6lAa/QoQB7R1ABSMr1+wSpg7RDGNMq9Hfm3yhX4exBebwZfb543XRf5YdTgLE
 Y0zaERcyd0inmG4RX6I0F1OvqECdEa4mYHqHmOzCAfqWtc0P0YsCILjO+0flAT2T7FBFM
 QEdDB88hNZ1ZITHEfPYjb77JgSr1/viTsgLnyIZQxuJvmRaJItCZq76U57CbVROZ9gNbL
 7Sfq+yi5gDTH67uKGWwqcqnzHAx4hKxRfBDfPoi5eq7E3vZbSrqkhtT00E3fZXpzOFg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 spf=fail smtp.mailfrom=siemens.com;
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=s06zSxfF; 
 arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=ludwig.nussel@siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=s06zSxfF
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 243C3400DC
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:31 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E21C80117; Tue, 15 Sep 2026 14:53:30 +0200 (CEST)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EF10847E3
 for <u-boot@lists.denx.de>; Tue, 15 Sep 2026 14:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.b="s06zSxfF"; dkim-atps=neutral
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 202609151253272f53e623860002072a for <u-boot@lists.denx.de>;
 Tue, 15 Sep 2026 14:53:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=HAeA9BfaKX6ydfAr01sw86PjpLddr4h3awZ4DdqL09o=;
 b=s06zSxfFWM/WYX1vlS7DdpqA3O1RAw1br6V58XjepnZ5DqDS98sZpdHwKHze3ZKpALgKmH
 1pf0aKoqIWIv2aoS5yu8V6Okm54TH7SNC5DVasMYIUBytXrGKatXnSYKpUz6/JkrzbTuNSi9
 ehS4d41mwu2HAf0quU27Fsb4tdyJ/6fVBC9UfRZadaMXMcNfibIS6vVNOIHOmHwK5b+F6kOJ
 NKfRpcwjxhdYfwG16jjPgqrRR5cexNFE3Y7YBB3KgECH8ETDOFX6aCJWs1Jb/nWg3EmHhTqS
 pNJArdJ7vIdfdloPJrCoDOz3YPq0OdTaJ7GiLyHufdJ9p9VBOYFJSKPg==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH v9 7/8] test: vboot: refactor run_bootm
Date: Tue, 15 Sep 2026 14:52:18 +0200
Message-ID: <20260915125317.180911-3-ludwig.nussel@siemens.com>
In-Reply-To: <20260915125317.180911-1-ludwig.nussel@siemens.com>
References: <20260915125317.180911-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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
index 6459c7c313e..df5db157a52 100644
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


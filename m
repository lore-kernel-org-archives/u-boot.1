Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D43606A321
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KYT3Z3mG;
	dkim=pass (2048-bit key, unprotected) header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=uV75ywZG;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=2c8Po9vJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0ED4480F55;
	Wed, 28 Oct 2026 10:31:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nzNEZNC-0lsk; Wed, 28 Oct 2026 10:31:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2825580E2A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793183509;
	b=msnMdHcT8Fi6jXfBXXwU36AS+Vo7ZHfR4h5JCoJ3kPEs1mMs/2gU3NXAJDyEE0hphrxp
	 gl4m8tZmYfFF6KdYHKBR4LYjpLlPfqoKWJkfqcppWTDnOs7+wzs/hnQARFo6rQrfm0M56
	 ORXcZh8ss1AGqYa2n2XtgY6sHtBeeF6CZI86Nnnh4x0bCe8zPprYYQ9nOc1XcdTfhwJaU
	 H+mvXh+kR5D1kS5ZOrhWacY6BDkFxFkzgfFuEgoAc4GEVq+lgaGUZc5YppO9hTgM6oY4G
	 z5/Kzaa1BGQryWU0WkPN32mXPXWEqTLGxeHE5jNj1/P6g0XEPS1iY1ooR01HM4sGi6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793183509;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ro/2ln5hO9tSsvGSqR6s0afsiG3xVW0VuHa04bz1uA0=;
	b=dzHevFBgYsV98ExtG8WLWdUMmIttYkqcXY2Z1uO21zTew/Q5WF/xriCiDJWl07YGxCWq
	 uSN7LEvpJbQyzQ+zBI+QZsrB8SQfdk3pJokL9dwYenaxwlR3zVRr06dKflG2LIXCi0VtS
	 kUOBqc2mwScfy+QawR5vrIZnIk0TIx30iZWIRdZwHlII+uzSIcg36zHsJ7GtFeuIF4yPh
	 3HBmkkKLfn7j+tUUvRf0emVCpTObAU4wHvYJj545TZ4ZbT2rFoLqsSg71f/1OQQB9sB55
	 LdJ6n9CAaedPnvbL+1UrLzwzy8o3QJMa4UAlfxCBFBDn6ZYqDutPj21cCAwWYxexJ+A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=embetrix.com;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=uV75ywZG;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=2c8Po9vJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793183509;
	bh=Ro/2ln5hO9tSsvGSqR6s0afsiG3xVW0VuHa04bz1uA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KYT3Z3mGT5ZEOf7D8JFRTaj5AvfpArPkWMQAZQGLLx4/egNUqcz8nvApN0Yrn1/fN
	 ehZDbMMTGkkWdVJagB7CbLcPphJSri0IxMJxXwLqnzcl8b/RW71qN7cYG0Vy7BihXP
	 zwkytCc0XXqyY+uSlfgg0GjuMEs9u7IAx7LtPSknHi0FJzDYfCi00u4akZ/xeYkWm1
	 nPYzy5Dk2tUYghCJ1kSHP5/nCo9pxEK5ocIPNC53uGsb0tgw6SXH/MQCFT9Ot3+uIn
	 oyx5KZKTg3SQv7J74ijiEw1J6ZOE1GcW+1vIaqTqOg1QgpuVJ2OZ7gmMLxU5F0jFYs
	 mmHuH81POnoIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2825580E2A;
	Wed, 28 Oct 2026 10:31:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CD360356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:31:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AF20880CCC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:31:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VqU0qmje7pyq for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 10:31:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3ACD380DDC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793183494;
 b=I5m/fU6LbDnoHCDPlD+QLzAeHFXD+/jFrBiVBrbwAb2GjEOtLoUaiKdaEc9YC5xh1cwE
 S/5alkZWiW90bvt82R6V8NNtqVSg5vjVOFpMmd/AKU9VUAY2sx3wo/0p/l1Mj1KaWBW90
 FFfEk01OcNIiIGSsspo3EAX7+qIlv/nJvrVs7t1PFRX8utWnrtJY0JVZBYME6VHpKExoJ
 lZyfzb5pk5WnEGoIFOyM8H7nWR/Y45cC8lAYpqqkbJ1Ylz808hJ614BxJIwwnig8O1yxY
 GdveGne2UnRCQBtnMuzfqUKScCdNQmHtO11yuXhcYCsC5qZSBNK77Zj1vI4HALOSYZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793183494;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=Ro/2ln5hO9tSsvGSqR6s0afsiG3xVW0VuHa04bz1uA0=;
 b=FIbL+VOa3Wb6LOOc74stp+B4l9qcmNDvSpd5ifkNcOmc6Ch1/e5sH1TqcORdvGVIY9Wv
 JPQXREKRPabd7HM0hvgNtR+Bc5FH7s4VAY8e0YNEWh3bhWuuDRaxWpKxeehhjd7bDebc7
 kzum2xhP5CHtAyC7pvAuZnxLM0qANCIxp6Ozm2AN+8zf8B30rAuiyI+pawhMZu/NQqbQ8
 lELk1BT5lidTuiWflrpYilUs9DkL3grgTiHnaxXGtjVj8Z8ANAoN0uLG6rQJPKp6rycYn
 rUx0AUauCwiHIXxhNotNbM2mY6NKqi8PTgg/t8sMWcpV/0fZlqozpc31s5MAVb609yw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=embetrix.com;
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256
 header.s=rsa1 header.b=uV75ywZG; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=2c8Po9vJ; 
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=2a02:2350:5:505::1;
 helo=mailrelay-egress18.pub.mailoutpod2-cph3.one.com;
 envelope-from=ayoub.zaki@embetrix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=embetrix.com
 header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=uV75ywZG; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=2c8Po9vJ
Received: from mailrelay-egress18.pub.mailoutpod2-cph3.one.com
 (mailrelay-egress18.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:505::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3ACD380DDC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793183489;
 x=1793788289; d=embetrix.com; s=rsa1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=Ro/2ln5hO9tSsvGSqR6s0afsiG3xVW0VuHa04bz1uA0=;
 b=uV75ywZGGZAFGiiFyBtOutthp0/bHhRO7TAs5Jf1Z6dNQGMMLM1LgMpyP27gdlT7C81h0W4sbkFQr
 87PEx2yczS/nUvBu8FcBsrvsO7w9ZvlIygvwjYoqcpgv4K9MF5xtm486iG4MVsNr6Byj1/f0tGSuWV
 T/CB+kjv2t5PMjTtl7z+qoJppm+NldzYcXOxPN8f2ijs1PTsm8zSgWZo4AJCMn8za61pRjgaCt5BHN
 3dh1b+H6ov5CfjbbQgg7U63GkCueggBgthF/3HeyrEQTlXka+4dseimnpLcF+wgf0igeUkiRQx94jv
 LN7j69zx1JLH3dtwNGSAK0TOB16CEmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793183489;
 x=1793788289; d=embetrix.com; s=ed1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=Ro/2ln5hO9tSsvGSqR6s0afsiG3xVW0VuHa04bz1uA0=;
 b=2c8Po9vJKh6TL+FpWy3f2XjlIUZTdg8d3sfhi7TY4H3DSzgXXwmNYe/fTU5jntxpkBnqn6HPIQZf2
 iDEpkwiDw==
X-HalOne-ID: bb23e4a9-d2ba-11f1-9e47-5b5978544972
Received: from xps-13.fritz.box
 (dynamic-2a02-3102-8c10-1ae0-c98b-5300-3c35-71e4.310.pool.telefonica.de
 [2a02:3102:8c10:1ae0:c98b:5300:3c35:71e4])
 by mailrelay4.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
 id bb23e4a9-d2ba-11f1-9e47-5b5978544972;
 Wed, 28 Oct 2026 10:31:28 +0000 (UTC)
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, Tom Rini <trini@konsulko.com>,
 Ayoub Zaki <ayoub.zaki@embetrix.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH v2 6/6] test: fit: Cover private key filename fallbacks
Date: Wed, 28 Oct 2026 11:31:02 +0100
Message-ID: <20261028103102.414657-7-ayoub.zaki@embetrix.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028103102.414657-1-ayoub.zaki@embetrix.com>
References: <20261028103102.414657-1-ayoub.zaki@embetrix.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Test RSA and ECDSA signing with each suffix alone. Test both suffixes
with different keys to check which key is selected. Verify each image
signature against the expected public key.

Check that an invalid or unreadable preferred key prevents fallback.
Check that an unreadable fallback key makes mkimage fail. Check that
missing-key errors name both attempted paths.

Check that explicit -G paths do not fall back to another suffix.
Missing keys remain optional.

Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
---
Changes in v2:
- New patch covering RSA and ECDSA key lookup and signature verification.

 test/py/tests/test_fit_key_fallback.py | 121 +++++++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 test/py/tests/test_fit_key_fallback.py

diff --git a/test/py/tests/test_fit_key_fallback.py b/test/py/tests/test_fit_key_fallback.py
new file mode 100644
index 00000000000..b7031340324
--- /dev/null
+++ b/test/py/tests/test_fit_key_fallback.py
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2026 Ayoub Zaki <ayoub.zaki@embetrix.com>
+
+"""Test FIT private key lookup and verify the selected signing key."""
+
+import os
+from pathlib import Path
+import subprocess
+
+import pytest
+import utils
+from Cryptodome.Hash import SHA256
+from Cryptodome.PublicKey import ECC, RSA
+from Cryptodome.Signature import DSS, pkcs1_15
+
+
+@pytest.fixture(scope='module', params=['rsa2048', 'ecdsa256'])
+def signing_keys(request):
+    """Generate distinct preferred and alternate keys for each algorithm."""
+    algo = request.param
+    if algo == 'rsa2048':
+        return algo, '.key', '.pem', RSA.generate(2048), RSA.generate(2048)
+    return (algo, '.pem', '.key', ECC.generate(curve='P-256'),
+            ECC.generate(curve='P-256'))
+
+
+@pytest.mark.buildconfigspec('fit_signature')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtget')
+@pytest.mark.requiredtool('fdtput')
+@pytest.mark.parametrize('case', [
+    'preferred', 'fallback', 'both', 'invalid', 'unreadable',
+    'fallback-unreadable', 'missing', 'explicit', 'explicit-missing',
+])
+def test_fit_key_fallback(ubman, tmp_path, signing_keys, case):
+    """Only absent preferred keys permit fallback; -G uses the exact path."""
+    algo, preferred_ext, fallback_ext, key, other_key = signing_keys
+    preferred = tmp_path / f'dev{preferred_ext}'
+    fallback = tmp_path / f'dev{fallback_ext}'
+
+    def write_key(path, private_key):
+        pem = private_key.export_key(format='PEM')
+        path.write_bytes(pem.encode() if isinstance(pem, str) else pem)
+
+    if case in ('preferred', 'both', 'unreadable'):
+        write_key(preferred, key)
+    if case == 'both':
+        write_key(fallback, other_key)
+    elif case != 'preferred' and case != 'missing':
+        write_key(fallback, key)
+    if case in ('invalid', 'explicit'):
+        preferred.write_text('Not a PEM private key\n')
+    if case in ('unreadable', 'fallback-unreadable'):
+        unreadable = preferred if case == 'unreadable' else fallback
+        unreadable.chmod(0)
+        if os.access(unreadable, os.R_OK):
+            pytest.skip('Cannot make key unreadable with this user')
+
+    mkimage = str(Path(ubman.config.build_dir) / 'tools/mkimage')
+    datadir = Path(ubman.config.source_dir) / 'test/py/tests/vboot'
+    fit = str(tmp_path / 'test.fit')
+    (tmp_path / 'test-kernel.bin').write_bytes(bytes(500))
+    utils.run_and_log(ubman, ['dtc', '-O', 'dtb', '-o',
+                             str(tmp_path / 'sandbox-kernel.dtb'),
+                             str(datadir / 'sandbox-kernel.dts')])
+    utils.run_and_log(ubman, [mkimage, '-D', f'-I dts -O dtb -i {tmp_path}',
+                             '-f', str(datadir / 'sign-images-sha256.its'),
+                             fit])
+    nodes = ['/images/kernel', '/images/fdt-1']
+    for node in nodes:
+        utils.run_and_log(ubman, ['fdtput', '-ts', fit, f'{node}/signature',
+                                 'algo', f'sha256,{algo}'])
+
+    if case == 'explicit':
+        key_args = ['-G', str(fallback)]
+    elif case == 'explicit-missing':
+        key_args = ['-G', str(preferred)]
+    else:
+        key_args = ['-k', str(tmp_path)]
+    cmd = [mkimage, '-F', fit] + key_args
+    result = subprocess.run(cmd, capture_output=True, text=True)
+    output = result.stdout + result.stderr
+    ubman.log.info(output)
+
+    if case in ('invalid', 'unreadable', 'fallback-unreadable'):
+        assert result.returncode != 0, output
+        if case == 'unreadable':
+            assert str(preferred) in output
+            assert str(fallback) not in output
+        elif case == 'fallback-unreadable':
+            assert str(preferred) in output
+            assert str(fallback) in output
+        return
+
+    assert result.returncode == 0, output
+    if case in ('missing', 'explicit-missing'):
+        assert str(preferred) in output
+        if case == 'missing':
+            assert str(fallback) in output
+        else:
+            assert str(fallback) not in output
+        for node in nodes:
+            props = utils.run_and_log(ubman, ['fdtget', '-p', fit,
+                                             f'{node}/signature'])
+            assert 'value' not in props.split()
+        return
+
+    def read_binary(node, prop):
+        values = utils.run_and_log(ubman, ['fdtget', '-t', 'bx', fit,
+                                          node, prop])
+        return bytes(int(value, 16) for value in values.split())
+
+    # Distinct keys in the 'both' case prove that the preferred key was used.
+    public_key = key.public_key()
+    for node in nodes:
+        digest = SHA256.new(read_binary(node, 'data'))
+        signature = read_binary(f'{node}/signature', 'value')
+        if algo == 'rsa2048':
+            pkcs1_15.new(public_key).verify(digest, signature)
+        else:
+            DSS.new(public_key, 'fips-186-3').verify(digest, signature)
-- 
2.53.0


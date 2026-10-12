Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BF9CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 12:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE7D840629;
	Mon, 12 Oct 2026 12:36:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vIBvdMiIYdzR; Mon, 12 Oct 2026 12:36:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B07D6405E9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791808618;
	b=bMgmFXzCLrVVEH6jrnv4N1XZ20HKuFxnLMxUq+CFEiq9e3en9tqrhR9XjD1tygsY8GOD
	 zhGJl4NgLoA1V8PmO3dtmXUKfht2w8wqadE9ZY3mOr0rvmekGWPqCBjoKaAPp0nK8ccm9
	 ynHLkaaRVvYZJQXZ8AFiZN8KaTn/roYYFqAk4m72QyJHYA46aIWahOaufJYnvU0ZWsm5L
	 Dgyyrd3C0gwrM+KLA3cQczLl8lcMDgLcvvmGAm82EQ8Y6VGeY5WyfYZBCCnBfXoEI4fes
	 l1+hX1dNilqq2/NbwOKALrwkjzjYekB0G+4zhb6hD6+O6BOixdi++Gg7Fk0n/+DyCDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791808618;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Jtq5Gckf2C662m3SvXDypoNtPyrjpNoSuqWmQZ1hu0w=;
	b=SNx2u3515d2fQizfjEtYQaWyOzWOUjrRpPoFBd/kbUWaRmeHzOU7DYqk+b/6CLoXDWCZ
	 Y4SSWsS9mJKmgG/snQm/YKs6RkbglwI82Id7QAGuHTvIqsTuILOBaFiWhjAkcRcOEhaIe
	 UkZR9NDgDmEQWKFd3FHo32IbPngmPXOe1JX+a507MEDH92ZDR65bxQQ3nlPqD8j8leopQ
	 +0sBt6VM859x9HA6BS4Las7uosxK1qWZUJ4t3BM5QM1W0Qh7hSpskfgruxLocdHZMeYFx
	 ZGFUFSuicn477ZtAxfm3/K3kDAZo46ScrKGp7PRyp7frLcfFbAHfLuYWY0/sNA+adng==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=sigma-star.at;
	dkim=pass header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256 header.s=google header.b=Jub8BIH1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791808618;
	bh=Jtq5Gckf2C662m3SvXDypoNtPyrjpNoSuqWmQZ1hu0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XRskQQ7Y1uCjH87bEOjM8dOmTH5TPO+GMfmOyhfB2g4i0+XqdEEn82iLfQsjWsSjh
	 2Kt9D27qrIOoxEoyghMQoYRbsp50AY4Pa+jjAnZ1Yl1n/ycajEo9eOrl2gd2JMCwAi
	 WK2hkdOS9hizIoeYUDQfEA2fElqS+TShffB/1tjYHidLRm3L9EqT4KooXMzHroFpq1
	 Vvs49CGJYWGSPRNB6jw+jAaEcVNUtXt37oFZQ+L7s+dkjNMfC4NPbavFNZWAIlPW2I
	 zfwgMVxCsKNNVsYrB6s9Nyn/d9pfyBK8Y2qSdmkWxZDuPv56mvuu9efd+2850V3avX
	 729TbCdkhu/wA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B07D6405E9;
	Mon, 12 Oct 2026 12:36:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0386C380
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:11:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC2E3405AB
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:11:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fehZ7aSomxmz for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 10:11:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A075740599
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791799863;
 b=lup4DBa41zasAUZvQf7EIzOWAS2irKbV10JntC5nELSCfsqVrvz0oPf0BOQkpG7xWOF+
 Keaj4N+gg3spQwUJZeXJT8QkiEfzJ1Es8C+hkR8VlkIu4vdjEAnGbf8+PesJr8Ik+W4nP
 8b0LIL51L7A/HY3Yfva+C2asaq9/I2PorUC+BbdmiMaNLawUYTvg9Sluw8TJheRsK1f3y
 RXe+00P3RvaLCkOxJ2Z6asfqj+NJCjZ3Sv4iyGh49hXLUjRZ0LZNdBWxelmWMFr/a5E1n
 Dqy8K35BytXfEx2TSsZQrtsIHoW8OwIrymlJ4KXyAOQ63KlhtytRqMsDc/DDI2ZZbyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791799863;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Jtq5Gckf2C662m3SvXDypoNtPyrjpNoSuqWmQZ1hu0w=;
 b=nL/XKf/ws3X4lYm+9K48TXQvRpQmFz/UjvJCKGRz3w0PpAHody25/QXnl7CdWecn2qx3
 BhQNGMMhneAPr17RmUf+dtDD0OWf/NL0dYNkRbgLtaWkJiK6Pht3M6C+yQwvCFH+8f+O8
 8v8bFjdZvqO3mre06IScuKx58i2MyFA/8AbDc7dv84SEKH5b/0vdjuKfcXzyVPIkoJLua
 weypm2oA7Zfjqag86hkWjQChS3CUqEOlk1Hd/iY1OWr9K0JS6bBfVJCZVT6gTTOE5ErQp
 tHtm/HFT3qK+5KcIMe88gnhTcUNWV6Pi/8ABobs8AB/IzH72Zv1joH9Zf64MmARfiSQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=sigma-star.at;
 dkim=pass header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256
 header.s=google header.b=Jub8BIH1; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=lorenz@sigma-star.at; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at
 header.a=rsa-sha256 header.s=google header.b=Jub8BIH1
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A075740599
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:11:02 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-486e70f2457so709873f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 03:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1791799860; x=1792404660;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jtq5Gckf2C662m3SvXDypoNtPyrjpNoSuqWmQZ1hu0w=;
 b=Jub8BIH1Wu44yFY7dOnyiAF0+AF8WshYIMVl9Kc+Ml9AXnSuWBO48qYix+JkP8uTkj
 Bfe95+FjVaEMqS2XNHSciaU4AV4/lWXcw9DsszQbvYVSnAhEO/bGXensrS5lml60lh5i
 +gQrzg2dJDc7I2Gbo/Kemj8f0r4TMhGwN5/QnDiLkJoI+A2XHZbecDXhbUSyCgkvULYk
 6vZS3hlRlplCrL76GmcNvfqlMTctiG3F+Zjh3kSnFx/hbXQNSC2hgsyq9DDyBoSb6AmM
 eS52Hjfr97j443t5ePZdZhJccE331xMrJRbx4RLu5zZPHfbN0yyEetz97uXDgBsIoUcD
 mCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791799860; x=1792404660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jtq5Gckf2C662m3SvXDypoNtPyrjpNoSuqWmQZ1hu0w=;
 b=0FZGmFXVlfSsdUMT+AlTm+PR5oLI1bH2ZNez13crqV+hhXLI0SUqd+bM0J0J9VuyXW
 8iV/eagJJ8Dqkv6aqngdjFUkjRuLg7rgjPplg/N/yybDL/zMcCA22fG1+eS32qOCZwtu
 ChmchwwgOCpbd+GEcsKTVKGjqi/ez86y0hjH2tga4EN9yAQ2VsCz6Ag5A3LGtRg3oZ3L
 wG9QDKFcjEJfJHa+N1/bmqNRNGSlHNMFkpmI+SiqauwPuhtFuPojTe7WFivK+wvJ1B64
 IbpAs1p50gMdx17Dxw3/To5gsI9hAXH8iDYshqzHK6nfOnIYKme1mzzBP9kVlulpqmxs
 u7Eg==
X-Gm-Message-State: AFq9FYK5URLCRBQUoEkk+lxRWOycfIgrSowCWJ4vdVHb7VFLWksfhNT5
 j0Z8M0ZP2r6SiHMj/0wMxWj6OgFNGbLA8en1ct/bEFmlENJtkBBdOsWTVC6DivGquYQAET2vdK2
 jPVslNcpROg==
X-Gm-Gg: AYBFou1gPY1tX0yIGGwLqKsEmOsMVXauFeeno0wOtjW0ydy9lRFvhXAggA7g5AUB/hP
 p40WOa3NcYzbHWTc33pv0DQT+tjZYuIGiGSxYPwdUBkUksVcaziESvqIkyFTsSmoO+MlXS8OL+X
 br/uD5VgniLYC03g33aEcmb8bTdGZY2YFm5Eu+RWD+HVrU9zsaFGgNgx5vMgaVKoy1HGMq+GdHH
 0EEKRMrSqvbu90JeQkNUgy1pwsx48bnHH8Lomeb13Cq+jtVLq+m30CM+V1DvgJlZbX5otssxL5S
 czWCiyeXV5xuZ/lDmfb9soKKK4A17/HRXTmmSU9Aba8AzeGVMBFzscS7csTMf0PFNwPW2OYWUE+
 1G1urPO+X/Gl8KdaV8YJTbB/7/jyfAPiaGHTjduOGV9wclAYDahd+mTtS09rJwc+08fmlMlpYNs
 KifAkPm60CaFPnQp6qj3RjveI/HGw5eyi1PePtJ84DuDw22CD+o36l3KIcN2al9KhsCUBVGumSe
 1wf+jyxXg==
X-Received: by 2002:adf:fc8a:0:b0:488:77bc:a741 with SMTP id
 ffacd0b85a97d-48dbaaec9d3mr14000611f8f.51.1791799859915; 
 Mon, 12 Oct 2026 03:10:59 -0700 (PDT)
Received: from losig.fritz.box ([2a04:9546:1c54:8601:c375:8df8:9c4c:d013])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9abd57fsm18064559f8f.37.2026.10.12.03.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 03:10:59 -0700 (PDT)
From: Lorenz Kofler <lorenz@sigma-star.at>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 upstream+uboot@sigma-star.at, Lorenz Kofler <lorenz@sigma-star.at>
Subject: [PATCH v2 3/4] binman: tests: Share SoftHSM token setup
Date: Mon, 12 Oct 2026 12:10:53 +0200
Message-ID: <20261012101054.2104707-4-lorenz@sigma-star.at>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012101054.2104707-1-lorenz@sigma-star.at>
References: <20260917065545.1989088-1-lorenz@sigma-star.at>
 <20261012101054.2104707-1-lorenz@sigma-star.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 12:36:48 +0000
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

Factor SoftHSM configuration setup into _SetupSoftHsm(). Use it for
tests testPkcs11SignedCapsuleGen(), testFitSignPKCS11Simple() and
testFitSignPKCS11Object().

Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
---
Changes in v2:
- New patch: share SoftHSM setup between tests.

 tools/binman/ftest.py | 89 +++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 50 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 4002f6837f4..f5eb895475f 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5937,6 +5937,38 @@ def testPreLoadEncryptedFit(self):
         self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_SIZE)])
         self.assertEqual(is_signed, True)
 
+    def _SetupSoftHsm(self, softhsm2_util, prefix, private_key,
+                      token='U-Boot token', label='test_key', pin='1111'):
+        """Set up a SoftHSM token containing a private key
+
+        Args:
+            softhsm2_util (Bintool): SoftHSM bintool to use for token setup
+            prefix (str): Prefix for the files created in the input directory
+            private_key (str): Filename of the private key to import
+            token (str): Token label
+            label (str): Private-key object label
+            pin (str): User PIN for the token
+
+        Returns:
+            str: Filename of the SoftHSM configuration file
+        """
+        data = tools.read_file(self.TestFile('fit/softhsm2.conf'))
+        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
+        softhsm2_conf = self._MakeInputFile(
+            f'{prefix}softhsm2.conf',
+            data + f'directories.tokendir = {softhsm2_tokens_dir}\n'.encode())
+
+        with unittest.mock.patch.dict('os.environ',
+                                      {'SOFTHSM2_CONF': softhsm2_conf}):
+            softhsm2_util.run_cmd('--init-token', '--free', '--label',
+                                  token, '--pin', pin,
+                                  '--so-pin', '222222')
+            softhsm2_util.run_cmd('--import', private_key,
+                                  '--token', token, '--label',
+                                  label, '--id', '999999', '--pin', pin)
+
+        return softhsm2_conf
+
     def _CheckSafeUniqueNames(self, *images):
         """Check all entries of given images for unsafe unique names"""
         for image in images:
@@ -7593,14 +7625,8 @@ def testPkcs11SignedCapsuleGen(self):
         pkcs11_tool = bintool.Bintool.create('pkcs11-tool')
         self._CheckBintool(pkcs11_tool)
 
-        prefix = "testPkcs11SignedCapsuleGen."
-        # Configure SoftHSMv2
-        data = tools.read_file(self.TestFile('fit/softhsm2.conf'))
-        softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf', data)
-        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
-
-        with open(softhsm2_conf, 'a') as f:
-            f.write(f'directories.tokendir = {softhsm2_tokens_dir}\n')
+        softhsm2_conf = self._SetupSoftHsm(
+            softhsm2_util, 'testPkcs11SignedCapsuleGen.', private_key)
 
         # Find the path to softhsm2 library
         p11_kit = bintool.Bintool.create('p11-kit')
@@ -7616,16 +7642,10 @@ def testPkcs11SignedCapsuleGen(self):
         with unittest.mock.patch.dict('os.environ',
                                       {'SOFTHSM2_CONF': softhsm2_conf,
                                        'PKCS11_MODULE_PATH': softhsm2_lib}):
-                softhsm2_util.run_cmd('--init-token', '--free', '--label',
-                                      'U-Boot token', '--pin', '1111',
-                                      '--so-pin', '222222')
                 pkcs11_tool.run_cmd('--module', softhsm2_lib,
                                     '--write-object', cert_file, '--pin', '1111',
                                     '--type', 'cert', '--id', '999999', '--label',
                                     'test_cert', '--login')
-                softhsm2_util.run_cmd('--import', private_key, '--token',
-                                      'U-Boot token', '--label', 'test_key',
-                                      '--id', '999999', '--pin', '1111')
                 data = self._DoReadFile('capsule/signed_pkcs11.dts')
 
         self._CheckCapsule(data, signed_capsule=True)
@@ -8359,26 +8379,10 @@ def testFitSignPKCS11Simple(self):
             self.skipTest('PKCS11 engine setup not functional, '
                           'did you install libengine-pkcs11-openssl?')
 
-        prefix = "testFitSignPKCS11Simple."
-        # Configure SoftHSMv2
-        data = tools.read_file(self.TestFile('fit/softhsm2.conf'))
-        softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf', data)
-        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
-
-        with open(softhsm2_conf, 'a') as f:
-            f.write(f'directories.tokendir = {softhsm2_tokens_dir}\n')
-
         # Generate pubkey DTB with random RSA4096 key
         _, _, private_key, pubkey_dtb = self._PrepareSignEnv()
-
-        with unittest.mock.patch.dict('os.environ',
-                                      {'SOFTHSM2_CONF': softhsm2_conf}):
-            softhsm2_util.run_cmd('--init-token', '--free', '--label',
-                                  'U-Boot token', '--pin', '1111',
-                                  '--so-pin', '222222')
-            softhsm2_util.run_cmd('--import', private_key, '--token',
-                                  'U-Boot token', '--label', 'test_key',
-                                  '--id', '999999', '--pin', '1111')
+        softhsm2_conf = self._SetupSoftHsm(
+            softhsm2_util, 'testFitSignPKCS11Simple.', private_key)
 
         # Make sure the private key can only be accessed through the engine
         os.remove(private_key)
@@ -8434,26 +8438,11 @@ def testFitSignPKCS11Object(self):
             self.skipTest('PKCS11 engine setup not functional, '
                           'did you install libengine-pkcs11-openssl?')
 
-        prefix = "testFitSignPKCS11Object."
-        # Configure SoftHSMv2
-        data = tools.read_file(self.TestFile('fit/softhsm2.conf'))
-        softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf', data)
-        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
-
-        with open(softhsm2_conf, 'a') as f:
-            f.write(f'directories.tokendir = {softhsm2_tokens_dir}')
-
         # Generate pubkey DTB with random RSA4096 key
         _, _, private_key, pubkey_dtb = self._PrepareSignEnv()
-
-        with unittest.mock.patch.dict('os.environ',
-                                      {'SOFTHSM2_CONF': softhsm2_conf}):
-            softhsm2_util.run_cmd('--init-token', '--free', '--label',
-                                  'U-Boot prod token', '--pin', '1234',
-                                  '--so-pin', '222222')
-            softhsm2_util.run_cmd('--import', private_key, '--token',
-                                  'U-Boot prod token', '--label', 'prod',
-                                  '--id', '999999', '--pin', '1234')
+        softhsm2_conf = self._SetupSoftHsm(
+            softhsm2_util, 'testFitSignPKCS11Object.', private_key,
+            token='U-Boot prod token', label='prod', pin='1234')
 
         # Make sure the private key can only be accessed through the engine
         os.remove(private_key)
-- 
2.55.0


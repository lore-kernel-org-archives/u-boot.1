Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B391C982CF
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 13:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82A1A60B1C;
	Thu, 17 Sep 2026 13:41:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QAHgel0zAwQL; Thu, 17 Sep 2026 13:41:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A682860B05
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789652477;
	b=CpHRLLsOrn9QgLWOwssUfRuLhPlfaR7jwzn+rfaNPhpZ+p+mhha2s5inNknrlF4UvMBU
	 xFessmcsfj8HUPo/hO+QAUyRN3yJ2spDDz2hNS/1/ejDqIRKUwtoGZpvrdv5X3w+MFaOI
	 Ke3/90I7C8ZeHkTtRlILHYLtbm4tVWienoDOj0SZ4KzXfq1Au3OWeuFPefWPKJFA/+lmT
	 6zpKR+tZ7ewpG02YlZQK+t33R2Ra7hco1WAojsmdq3jZUYiWYhUPM0xzIcEplibbX6ir7
	 wlZMgFArjm16+oUuJz53PcX0LZ8ugyzcr3ZQCtrFcpjlv2MZuGT8x0/PeMIU4afQ/tA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789652477;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9IBUmHqLbm9/L1Ws1A52zuGIk7l/BNSYqo3hyLs4gbg=;
	b=RYkeTi3CIAr1Yahg+9lGbo86Vap6xb6aTpbYzh7+D+IfjXNnwJhOu8mvnCP2/ZkzrYpd
	 8V+vHy2HopC+CtaQEVYnrG0p/kftpB8r4SyO9EjEty/gKUHsKdHQBj4j5ZyY7s2EMxwnI
	 9eed6P0bpy++ofLGlNE7CGYb36Yj/9LqdVYqwE1ru6EGNntbtTBJfo+sNR+HVbGA/sLpS
	 V5O7nmiWXDupwkBmR64i/nwkRGteCxBZ0ZifUipri9iD3jCJOcHAyg+CRb293OOQ6jmP0
	 Jsu2ZZtRii+RRMR+RZ/oMXyWW7S6nXowR9PesC1VNAv/FGMLoDxRuQAE8+X8uAbZoLw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=sigma-star.at;
	dkim=pass header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256 header.s=google header.b=Xm2wTHFZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789652477;
	bh=9IBUmHqLbm9/L1Ws1A52zuGIk7l/BNSYqo3hyLs4gbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W6a3fN57jYpfCBMECIOp7S7HUF1e+WXJFNHxF+ndMobCcyyMD4Mpqol1TKZV3ItO8
	 SbQkER0djPv+jEYEsrfGzhzWszRyJEJl+w56CCKI62lA/6JSHQ7TDEyAaVAc2R5LG6
	 3d9MP/ZIsfF39MvOdhXAeK5GAki/8NSlJXDezg0dH5L9d3gFg1L/5WtAOJ0DF+qG7h
	 J2FKbkWYBdfq/H7yf403Tb/I8h8eOtwpnYa86Yp+oN/phwVpVHpW4O6CRovMJ6mafy
	 omTPJ/lBNzCqkQhRw2ko8ZGc/8Ri4nGoiOKQPwBvZqMpMeHrK1T/pyiSzO3fkn01KJ
	 aYqe7Sq1Ntwpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A682860B05;
	Thu, 17 Sep 2026 13:41:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B31613D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 08D886062C
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:57:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hilcxy4P8bNJ for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 06:57:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 476B860623
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789628220;
 b=D6p54uRUR4gzXNET+2TqWvc/l8uyOJLPtXi++jn8Vrbp3zmfbzFj0ZvT92Sbud3klJEy
 lJbp2WaCzOUAakULJMcIkg2umHcSltF4gLPYyRz4njoUGpj0IxSmf8DImgw3K0pZobsF+
 ClsQ/Wg8sLdbsnrzrkxzgSalvnUIysvkoWgoyz7Wajcce2IV/KmgOhNGckpMGiNoRp0bR
 ksg2Nskj62bsTpEckMY3ilxA0+znbYdbwgT36naZ/YaSMMBkzdXLn0FMcqmVd7QMCIYMn
 Z9LclaycgVXWGFvURDjuSO4jbE9qW0VscLHlwWUzDgW5E8BimOIP6VvGnH+QQcpnMpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789628220;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=9IBUmHqLbm9/L1Ws1A52zuGIk7l/BNSYqo3hyLs4gbg=;
 b=DD+Zx1nhFKA9EH3hxqi9zihApn4YQKmK3RTTyxu7HlxlfI/I3YmRpYoaVWJBwPjIataX
 too+8p9X+Ijs+X7BN04PaRLXKXkyRXL6tjD1u2SDeKQLORNNIx+4ZcqMgjMZFmGqFJpr+
 ecIvb27mHVI8kj8GfzUIZ7QBZtcg5qPcrOlpoEpnyZERDepa8tS58sfXz5TtEYgpe7kJh
 RcxX7REejEHHJrXJgJDitDYbUAbcm77UVzisrip0O7AcSadwestVUSHE8aiMNQOpCzXy/
 fqkDTESfEVDjgxg7EW/YN/jg3bndtquNcAMpGkk4JI9OeGWC9/5fYNUi2S82c/MxAtA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=sigma-star.at; 
 dkim=pass header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256
 header.s=google header.b=Xm2wTHFZ; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=lorenz@sigma-star.at; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sigma-star.at header.i=@sigma-star.at
 header.a=rsa-sha256 header.s=google header.b=Xm2wTHFZ
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 476B860623
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:56:58 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912d3931so3374465e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 23:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1789628217; x=1790233017;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9IBUmHqLbm9/L1Ws1A52zuGIk7l/BNSYqo3hyLs4gbg=;
 b=Xm2wTHFZOBt6GdAsZcCIZRSwRrXniR2sKJXA4CYtzsDLdnC4+suz12TcM+vBg/Vwpz
 hy1CbcF/aDWpZuVbPJ7v4+J6a2Bk533jIkoHCrziWe9y+WUzTsuMuayQS0PYsoe6O/vJ
 8dzurIrlgD6JPszrwpLwPziLyjGUGsHumKPIYBk3tqxuV/kXEqn0NzVdD18RIr76U1Vz
 8VF1F97Pmo+6KSQ3XNRP8hkTnMYLHksL6IzoUn2qUDPapjdAw51KcBNj96CJRPStNA/W
 VVI9pZ00oQzuK8YsnbN9pYYypvJK7p/B5voTZWrvBCMJo76uIAn1uFDF4TMn2DeJEsCO
 JHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789628217; x=1790233017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9IBUmHqLbm9/L1Ws1A52zuGIk7l/BNSYqo3hyLs4gbg=;
 b=Au18VqMSsThLJ0VmGNDagvmyO2tiDPLdIQxHny7ZHlzAcxQifCCl4r4imhBfUhuATf
 saCRPH4QXdDxOW8Z1JFdwaXcfyUXlDThZrFm292gdHHCymKamRO6jw6peyzzAY5KuC9m
 mlL5vHQK79doIazesObp/sqRGFZ381fOO1C6Llp9cVOHsLW2ww+nOnjWAlN8wQ3/uEa5
 qi3BWM7PHg5BO88nS0C+KttWkSq2Ft2M/uYPnpD8xuyBZt6ngH2Qgr4/UKa/NIjs3GzK
 PlXLvZhClZbs/IYf8eSbzFHzAjLfrzh3LYNHfbvP6wKk4sDcH8hGtzlOggF6hE6fKHvP
 ciRg==
X-Gm-Message-State: AFuF++kJhN9jR9VkNjhkpELvNE4BsXOZHD+I6QNDjdYFrIoB17+1GZWt
 s3fH5CLPYi4/1ZGr29DyyesKzZ3GLVF2L6THkos49bj1nhRgW/Hkp0rVERoa5RxtgsvdiLYPW4A
 IzHSIv3EoVg==
X-Gm-Gg: AYBFou0ezSosb5wRuWKDv+dx8f2LnbBz8aCyfWA4QRepp/dbBIgl2npGM4VZcUB4Ods
 D+ljUap5UtFCD3R6FW0p7GfPSWGOHOQpl0D2jVr8CxbvSmkaHMUx0GC6BydtDZpxiBhoGkwrYls
 LJtCI2pzU9N9Mu87GO1YifloXZLsmS32awgWcQam269XgORE7zq4AQK4/Z7X9T3uCYEWWBRmnjn
 4tnRk2FXJhQT+diL4+SO+0OCLJu7ayOsLIGwGJb+LoLRME682a2JngUVmc4JjSwSDBTuMXeay4z
 cvKVKb1ehhllc8fsJFKYloE9rJbaF+pX8ImsVyp3mzKBPcMyXWdCK+nqXN+2Oisk9CggVfnciNR
 C0/1pMDZRgKgfi5JaFBbu703DGYdhfAVsrgFAe1/djgBGfkLiYoG/2Y8sFUAk9oDt9bcqT2WNZ6
 tzKNOfWA57+kd5z2f1HGPjQXrcsalZ/7Wcd0tFOa3udZKX1dldo7WizSXcAw58jdbAyFWQBMnIv
 byOvhQKpy0pNrntADUibQ==
X-Received: by 2002:a05:600c:c1d7:20b0:499:8704:242c with SMTP id
 5b1f17b1804b1-49f1d51694amr47216145e9.0.1789628216869; 
 Wed, 16 Sep 2026 23:56:56 -0700 (PDT)
Received: from losig.fritz.box ([2a04:9546:1c54:8601:c375:8df8:9c4c:d013])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd256105sm47522705e9.14.2026.09.16.23.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 23:56:56 -0700 (PDT)
From: Lorenz Kofler <lorenz@sigma-star.at>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 upstream+uboot@sigma-star.at, Lorenz Kofler <lorenz@sigma-star.at>
Subject: [PATCH 3/3] binman: pre-load: Test signing with an OpenSSL engine
Date: Thu, 17 Sep 2026 08:55:45 +0200
Message-ID: <20260917065545.1989088-4-lorenz@sigma-star.at>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917065545.1989088-1-lorenz@sigma-star.at>
References: <20260917065545.1989088-1-lorenz@sigma-star.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 13:41:10 +0000
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

Add a test that signs a pre-load header through the pkcs11 engine, with a
key imported into SoftHSM, like the existing FIT signature tests. It is
skipped when softhsm2-util is not installed.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
---
 tools/binman/ftest.py                         | 79 +++++++++++++++++++
 .../test/security/pre_load_engine_pkcs11.dts  | 24 ++++++
 .../security/pre_load_engine_pkcs11_pss.dts   | 24 ++++++
 3 files changed, 127 insertions(+)
 create mode 100644 tools/binman/test/security/pre_load_engine_pkcs11.dts
 create mode 100644 tools/binman/test/security/pre_load_engine_pkcs11_pss.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 63fbf50089f..8238ac151ce 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5922,6 +5922,85 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_SIZE)])
         self.assertEqual(is_signed, True)
 
+    def _SetupPreLoadEngine(self, prefix):
+        """Set up a SoftHSM token holding the key used by the engine tests
+
+        Args:
+            prefix (str): Prefix for the files created in the input directory
+
+        Returns:
+            str: Filename of the SoftHSM configuration file
+        """
+        softhsm2_util = bintool.Bintool.create('softhsm2_util')
+        self._CheckBintool(softhsm2_util)
+
+        try:
+            tools.run('openssl', 'engine', 'dynamic', '-c', 'pkcs11')
+        except ValueError:
+            self.skipTest('PKCS11 engine setup not functional, '
+                          'did you install libengine-pkcs11-openssl?')
+
+        data = tools.read_file(self.TestFile('fit/softhsm2.conf'))
+        softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf', data)
+        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
+
+        with open(softhsm2_conf, 'a') as f:
+            f.write(f'directories.tokendir = {softhsm2_tokens_dir}\n')
+
+        with unittest.mock.patch.dict('os.environ',
+                                      {'SOFTHSM2_CONF': softhsm2_conf}):
+            softhsm2_util.run_cmd('--init-token', '--free', '--label',
+                                  'U-Boot token', '--pin', '1111',
+                                  '--so-pin', '222222')
+            softhsm2_util.run_cmd('--import', self.TestFile('dev.key'),
+                                  '--token', 'U-Boot token', '--label',
+                                  'test_key', '--id', '999999', '--pin', '1111')
+
+        return softhsm2_conf
+
+    def _CheckPreLoadEngine(self, dts, softhsm2_conf, padding):
+        """Sign an image through the pkcs11 engine and check the signature
+
+        Args:
+            dts (str): Filename of the device tree to build
+            softhsm2_conf (str): Filename of the SoftHSM configuration file
+            padding (str): Padding used by the device tree
+        """
+        ossl_conf = self.TestFile('fit/openssl.conf')
+        with unittest.mock.patch.dict('os.environ',
+                                      {'OPENSSL_CONF': ossl_conf,
+                                       'SOFTHSM2_CONF': softhsm2_conf}):
+            data = self._DoReadFile(dts)
+
+        image_fname = tools.get_output_filename('image.bin')
+        is_signed = self._CheckPreload(image_fname, self.TestFile('dev.key'),
+                                       padding=padding)
+
+        self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
+        self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSION)])
+        self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_SIZE)])
+        self.assertEqual(is_signed, True)
+
+    def testPreLoadEnginePkcs11(self):
+        """Test a pre-load header signed through the pkcs11 OpenSSL engine"""
+        softhsm2_conf = self._SetupPreLoadEngine('testPreLoadEnginePkcs11.')
+        self._CheckPreLoadEngine('security/pre_load_engine_pkcs11.dts',
+                                 softhsm2_conf, 'pkcs-1.5')
+
+    def testPreLoadEnginePkcs11Pss(self):
+        """Test a pre-load header signed through the engine with pss padding"""
+        softhsm2_conf = self._SetupPreLoadEngine('testPreLoadEnginePkcs11Pss.')
+        self._CheckPreLoadEngine('security/pre_load_engine_pkcs11_pss.dts',
+                                 softhsm2_conf, 'pss')
+
+    def testPreLoadEngineMissingOpenssl(self):
+        """Test that a missing openssl is reported when using an engine"""
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('security/pre_load_engine_pkcs11.dts',
+                             force_missing_bintools='openssl')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: openssl")
+
     def _CheckSafeUniqueNames(self, *images):
         """Check all entries of given images for unsafe unique names"""
         for image in images:
diff --git a/tools/binman/test/security/pre_load_engine_pkcs11.dts b/tools/binman/test/security/pre_load_engine_pkcs11.dts
new file mode 100644
index 00000000000..468dd30059b
--- /dev/null
+++ b/tools/binman/test/security/pre_load_engine_pkcs11.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			padding-name = "pkcs-1.5";
+			key-name = "test_key";
+			engine = "pkcs11";
+			header-size = <4096>;
+			version = <0x11223344>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_engine_pkcs11_pss.dts b/tools/binman/test/security/pre_load_engine_pkcs11_pss.dts
new file mode 100644
index 00000000000..4e09e97cb09
--- /dev/null
+++ b/tools/binman/test/security/pre_load_engine_pkcs11_pss.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			padding-name = "pss";
+			key-name = "test_key";
+			engine = "pkcs11";
+			header-size = <4096>;
+			version = <0x11223344>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
-- 
2.55.0


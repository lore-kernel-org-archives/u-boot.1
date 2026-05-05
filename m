Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C0FFF8855
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 18:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 975FC849E0;
	Tue,  5 May 2026 20:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KgcKmxvt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0397849EA; Tue,  5 May 2026 20:13:21 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C132D849DF
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 20:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-434d9df81a5so580829fac.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 11:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778004798; x=1778609598; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqK/GDDP8wLoMufy2/fY6nS1KowmC2c502gH0ke8gAo=;
 b=KgcKmxvtvfT0iawMREUTOpJxJv4D3Fa36h0DuKEkd1ybz0T0LXx+4wsdkrcVAkb8gw
 r++tDln9/r8S7Xq++E0DrxjHOAkfHtyC5wPOlGCHRcN+scF8KYPmy585P9I+ZL+rhA1B
 4xgxkVeW+6X7qRSKzk2FqB+XFQ4TwF4Q28AwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778004798; x=1778609598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QqK/GDDP8wLoMufy2/fY6nS1KowmC2c502gH0ke8gAo=;
 b=Ouu1wwEV1penwMgYj46E24rUiGLB8x/psXGmOEUKoUhZQ/qs0VtbDg/HRf2jtWYhcy
 2XI4yaQR9j1W9dnEFN+dA/1ZeE67vzb6paIMvI1qTA3m0aq9z0kKMtjYUXIHBWtOBrMt
 8K6XF6hqJjN982/1KDsonmFjNyuLOejJEolaqWsovPh4W11bPdkf+6gp8bhEW7MDWo7B
 zXqmYO1HySZIRYaPye3XgItAUoGP+Wr/8mWgqDv7HN6r4Ll6dSoS8nuiscyQteR5l9IG
 yKypG1OnsMKbFJF9oGcbMUsOdngE1dvlQTSoRU+Jg5a0RLHdFjhgcp58OI4pjMVpegPj
 HWvQ==
X-Gm-Message-State: AOJu0Ywt+E8f9pqPEPepkb+RxrrfPtNTSSAKufJTJxxT8mIQdpVnjAEI
 HCMBew8gouc3zZ3SS/BARCN2+BkW9tiydX7ewD5MhABdDgoL6pcfELeSurQQo9/tzdcnIwPtF+m
 02RRxWA==
X-Gm-Gg: AeBDieuc4VCiUVUVn0+6QRkHhLwnw0MXzA/WwkLWuXjU2upAb6a4zRgTL/L1Ypk+I6Z
 ODM56hTf6dIiSzc6J3u6TocS5wyx7/BALz5TOcchMMVjFHtyj0XhN4u/aYEVFOsmzBMCcUVbLe1
 eDql1moajHox9xG/g08tXIc4cLCQ6+TakoqGmJt5OrOUIUjUCnazr9Mih4drI6J44sGUmYOEqlU
 w6qn1pXBHbWLghuiU9XRH+6OHMlGsDwDrzC+yoLDBP3hbC5EVvRbkYr+SB045UlcowwPKFBJCyv
 ZVhdvzRDmbu630dybqwv978yzNN0KVPPiA3xqfKsT24Mt1kB2oS7J4n6PMNKDF8XzWJ5L/YnYxM
 b2n6C7SV0mR3cKsqpZLBJ0avJjK0LSg9q98ktdvplI3pWMlt0lg3gheWoGmOnP8axmXIqtyMBaT
 FaV/Pj8CrvUIpxgq1xSzcxn/unOt5GXSPZVhUiG/k=
X-Received: by 2002:a05:6870:c18e:b0:41c:890d:d776 with SMTP id
 586e51a60fabf-434f68b5743mr243459fac.7.1778004797851; 
 Tue, 05 May 2026 11:13:17 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-434549540b2sm14585754fac.6.2026.05.05.11.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 11:13:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v2 4/4] binman: Use bintool wrappers for PKCS#11 tools in tests
Date: Tue,  5 May 2026 12:12:55 -0600
Message-ID: <20260505181300.223439-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505181300.223439-1-sjg@chromium.org>
References: <20260505181300.223439-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The PKCS#11 signing tests in ftest.py call tools.run('softhsm2-util', ...)
directly (and the equivalent for pkcs11-tool and p11-kit), even though
the test setup has already constructed the corresponding Bintool
instances. As Quentin Schulz observed on v1, the bintool wrapper for
these tools is currently used only as an "is this installed?" probe.

Route the eight remaining call sites in ftest.py through
<bintool>.run_cmd(...), which the Bintool base class already provides.
The change is test-side only; no production binman code calls these
tools.

Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- New patch in v2 (per Quentin's review): replace tools.run() of
  softhsm2-util, pkcs11-tool and p11-kit in ftest.py with the
  Bintool.run_cmd() wrapper that already exists

 tools/binman/ftest.py | 46 +++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index ca5149ee654..273d0ff0379 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7560,7 +7560,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self._CheckBintool(p11_kit)
 
         p11_kit_config = configparser.ConfigParser()
-        out = tools.run('p11-kit', 'print-config')
+        out = p11_kit.run_cmd('print-config')
         p11_kit_config.read_string(out)
         softhsm2_lib = p11_kit_config.get('softhsm2', 'module',
                                            fallback=None)
@@ -7569,16 +7569,16 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         with unittest.mock.patch.dict('os.environ',
                                       {'SOFTHSM2_CONF': softhsm2_conf,
                                        'PKCS11_MODULE_PATH': softhsm2_lib}):
-                tools.run('softhsm2-util', '--init-token', '--free', '--label',
-                          'U-Boot token', '--pin', '1111', '--so-pin',
-                          '222222')
-                tools.run('pkcs11-tool', '--module', softhsm2_lib,
-                          '--write-object', cert_file, '--pin', '1111',
-                          '--type', 'cert', '--id', '999999', '--label',
-                          'test_cert', '--login')
-                tools.run('softhsm2-util', '--import', private_key, '--token',
-                          'U-Boot token', '--label', 'test_key', '--id', '999999',
-                          '--pin', '1111')
+                softhsm2_util.run_cmd('--init-token', '--free', '--label',
+                                      'U-Boot token', '--pin', '1111',
+                                      '--so-pin', '222222')
+                pkcs11_tool.run_cmd('--module', softhsm2_lib,
+                                    '--write-object', cert_file, '--pin', '1111',
+                                    '--type', 'cert', '--id', '999999', '--label',
+                                    'test_cert', '--login')
+                softhsm2_util.run_cmd('--import', private_key, '--token',
+                                      'U-Boot token', '--label', 'test_key',
+                                      '--id', '999999', '--pin', '1111')
                 data = self._DoReadFile('capsule/signed_pkcs11.dts')
 
         self._CheckCapsule(data, signed_capsule=True)
@@ -8230,12 +8230,12 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
         with unittest.mock.patch.dict('os.environ',
                                       {'SOFTHSM2_CONF': softhsm2_conf}):
-            tools.run('softhsm2-util', '--init-token', '--free', '--label',
-                      'U-Boot token', '--pin', '1111', '--so-pin',
-                      '222222')
-            tools.run('softhsm2-util', '--import', private_key, '--token',
-                      'U-Boot token', '--label', 'test_key', '--id', '999999',
-                      '--pin', '1111')
+            softhsm2_util.run_cmd('--init-token', '--free', '--label',
+                                  'U-Boot token', '--pin', '1111',
+                                  '--so-pin', '222222')
+            softhsm2_util.run_cmd('--import', private_key, '--token',
+                                  'U-Boot token', '--label', 'test_key',
+                                  '--id', '999999', '--pin', '1111')
 
         # Make sure the private key can only be accessed through the engine
         os.remove(private_key)
@@ -8305,12 +8305,12 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
         with unittest.mock.patch.dict('os.environ',
                                       {'SOFTHSM2_CONF': softhsm2_conf}):
-            tools.run('softhsm2-util', '--init-token', '--free', '--label',
-                      'U-Boot prod token', '--pin', '1234', '--so-pin',
-                      '222222')
-            tools.run('softhsm2-util', '--import', private_key, '--token',
-                      'U-Boot prod token', '--label', 'prod', '--id', '999999',
-                      '--pin', '1234')
+            softhsm2_util.run_cmd('--init-token', '--free', '--label',
+                                  'U-Boot prod token', '--pin', '1234',
+                                  '--so-pin', '222222')
+            softhsm2_util.run_cmd('--import', private_key, '--token',
+                                  'U-Boot prod token', '--label', 'prod',
+                                  '--id', '999999', '--pin', '1234')
 
         # Make sure the private key can only be accessed through the engine
         os.remove(private_key)
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932A8CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 12:37:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5261580BA6;
	Mon, 12 Oct 2026 12:37:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9QezY_Hlstz2; Mon, 12 Oct 2026 12:37:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5F26380DB4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791808620;
	b=N2q1ntRu9x2eKnZOJCipnhdvBez4CWul4F5kYDakfmXr0nMDGVg+xSnaNS50g19zpOcM
	 G49QDmYmr5Y3EC8VqxOJAWeqQj7/OietVmp3xbiixCAg18Pl0FQ0RgR7Rz/W/J5KlEbfC
	 /ICQE5IwubQDPzn3XRnWoo2fYIxXpTP6VcRZPHUtMLKsMgFSOZbwJn6Oc67+58D2Dy5pN
	 DOepI9Ywg292IIvVGDtl/t/zyzGXW9nW0+8xvEBYunYY5PJgwvAtbq6znqV8ab2MfIYMl
	 wc4bNwawbGeeoITlbq5Ghbm0HGkg9WHDjuRcqb0FwPeZM+AZFjPk87l57YPbRIXGcrw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791808620;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kATTCWJEbWLsix9n48IfPKskHbGbQwJ1IQEx0mjuLnM=;
	b=KECsDJvDkHwtM0H89biOmbO9HvMVOFKZAUDUYyng+Ybs65b8vlDsSeyo229rQ7sK02LG
	 +TokXjo2rjwXQFK5NX9B6zF8SLw6FHKE06gjArNKjKbpN2gzGwXYn2HayZ3xNlOi/T/3M
	 CuIWzAC/3qFW5i+F3tTCMbEeYKpJAzjFCt0XsVZZUtwFUL3sJI4LzVkeO6JbSbwNj3jXc
	 gQjotoA5+OzpZOkiwAjiEP64CYxqkep7eRsniRX1SZVcwVUMMDLwwYkQlmksCgpNWQvIm
	 lio1flodow1MC4NkrdaLh4cC5yYpOrCDE3os0VS6Ho6JGV56zillAZ9ZJn2AE7PW0VQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791808620;
	bh=kATTCWJEbWLsix9n48IfPKskHbGbQwJ1IQEx0mjuLnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ikf4tNyu3KZSyie0kxmSf/huCuq3x8qyRxSsPy+felZwIpD4XsaBTzffMjNSDhvmJ
	 5lK1wavWIFAwGDxYa8Va9BgMxTkCdm6q6K/YrtdnzdDsZ94iV0SbPESySSwAX38MxY
	 cnbDpew0AiDIFfCqTpEcPFn2kh26CXOLkaJSJJOytPeQs5xm6+6DQ5ReP3USuPe3uT
	 uSnpF/Yn1J2u2XdZdVvObpp8tC2sgqkLxd6Gw9w7/s9+4A6zlc1aNHLEO6khUbyxOG
	 v7cz/jlK5J6Pbw9Uy8sBtGUonS4C2r6x4qu6z+oJtANWS3ALoYqIdJW1ro9UXvZunG
	 Lq59BJ7wI68mA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F26380DB4;
	Mon, 12 Oct 2026 12:37:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 75A62380
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:11:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A9AA040182
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:11:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id laNfUgTSDVI4 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 10:11:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 39A1F400D0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791799864;
 b=YC12/hauxlfRNfFttFs37eyRXT9N8xEclKpy9n6blIuiA9wA0wXljhb0F2/M85fRHgrL
 IpoMjd0rszqLnvt8ZiTgJnNIB5ykd5+X+0bR5seza3cwcx/IWzKWLUdC+g9mBNyvR0gmL
 z1FCR0+rgjNQRo98eYAR9OXDtbed0Vk3BpAh1/8eJurHXDHRsqb77gooAYYg9Ntgb88Ju
 auZZyQLJwxFTkb2v9/dwE0HCfNANx3DKbvVGvJllIhwHpd9ilLAQfP+OSXF0/bote37CF
 ptHBTarFpxPJK7YKfqysa9ZDGBnq8+U9lfYgp25jVdLDIp2XOxhSh3K0Z/vLr2a3FwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791799864;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=kATTCWJEbWLsix9n48IfPKskHbGbQwJ1IQEx0mjuLnM=;
 b=Mwtx2rqVoooga5m0OBK8dxzOzZkRA9U3lq1Op+sXL5UuHAMmDTMCMbH0oWe94gowEaHn
 voYAvmBNPLj5vmbyuZeUiuXL08vmz1lyv1LtDA0IG9gBKhj+x3MVNEVk8JaZ2BxLNeJ12
 NnUcSIEk1xSHg/O0VCOlnHAvoOpEhGjho49iyLeStP5IK9x+LnEjLTVblMF4CFCL6Ojuk
 PjYez7Wt9hM8dAJ7vk8mmehdTXmz7IQfpxZlyntm1acyJehH30Dc+gCRJaXB4UxG6gDc4
 TTHOQBlgr5scz8cDWQADr9DhYL772j7iPLkIChlIMI5El1WwWz1X7Jl/cYoNMGDZQOA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=sigma-star.at;
 dkim=pass header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256
 header.s=google header.b=vOouJegv; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=lorenz@sigma-star.at; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sigma-star.at header.i=@sigma-star.at
 header.a=rsa-sha256 header.s=google header.b=vOouJegv
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 39A1F400D0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:11:03 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48c4207ac26so1665336f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 03:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1791799862; x=1792404662;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kATTCWJEbWLsix9n48IfPKskHbGbQwJ1IQEx0mjuLnM=;
 b=vOouJegvJHtKdC6hIevYUdsrq2dIY5lNfA9nT6EBUezHTQAA2oY0FkAEAOnoDEmoUt
 925evnqnIhYja5ETi4C0gFibCjYoFljV5s5hsqUR7EK9Ob8QQhYJZ2rNKLMtppw84B7M
 Igq0cZQ6FP5UmREGJHEM7FmKw5J1Tcp79J5kuPVxDYQqaPafQ4ESRf+F6/AVzVgdSWmj
 yyH2rjusGrdTGFQmDlKYelDpQvuaW+OPvcCcZRBjMR5KfepouwtRu72joe1DLxeDgKte
 L+1Pxjgy9r3v38lwjq3aMHX5tefmlJw8+3Ivkiv5LGQtOJiaLntk+aLNFaT3Qoongbt6
 7/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791799862; x=1792404662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kATTCWJEbWLsix9n48IfPKskHbGbQwJ1IQEx0mjuLnM=;
 b=yfw0wTIGpJ6Og+i/E3SpvMU78oE4t8FxXwA8PBJScqQLCar+6Eg3Sqr3q9kYkbs/s1
 BhW4V3ikj52AuavY7C9s6D1Ls0qgRYm9praDVQHNXr/PsbgcEfXeMAJDfrFoRl2kAILC
 QsxPUCDL5NjlR35EUqjmBGFb7/bmcdzaZnvs7MQs/lP4n6Hwwtdt5XCa8HLGloX8FjwJ
 xz/4rvbQehSnbRSZDBkx2Cc3O6wbn6Puf1SvSy3lPL1mNohjtMtsdmpnpJVjTc7JdIAH
 1TWZU0vkxdH2tQ7fwSp46JPZQ0e/ww7dKvlAzV/BothhWqW813sF6qdj6513igVIjwoV
 We+w==
X-Gm-Message-State: AFq9FYIiJYv1OpMzI0U+NAclOMbw/8skVHAnpk3ojNR9QP1LZDxGqgMt
 vFKcEZAhdzSaOkN/KXEs6f2CoP5RYmi1eoxF5fTVNsvbyaBCPV/0NqX56GPXF1o0n1njXGIV/FL
 TK+EsqDLmkw==
X-Gm-Gg: AYBFou0LCCSGZJk0CMbnPekxQyxwMV7vTpALtUlZbzL4rqcQ8WQT+yFYkVbsNTz4aBZ
 s1iZe18F8KC+O/CorRhaHc2UIyghhgnXo5toiuPqyyo1HYZQnkFY60YHZ3kbtXxZKtJA3qKUc0k
 w9Uq1r9GXftCj4Z4uMQgCXOPzdshi8aV3wWBGOC9LCowtc3UV+8E5YH7SIHvpxE6EfSACv0nS2m
 Yk8TETX0YP7AOsFXoJO1nM1MAFT/ugAezNFGGB8792U8BzRc3kM9LNaDnk+KlF+0xDt98cNBf4C
 aEakuaONQF8Tw+yorZTw0nOMJSIPcoUrp5NWQ5DpgDrXqNIt9c2Nz6QAXkccD8m+vTqtu6FLgmi
 qT8kImHaNuppOw/OM1vTH9DKd7oIyrM2CqWVZxaU3ZFDVx7oJKdnnhfW3UQFn67GbpCPZ3Ys4oQ
 eKibH+NQ2DQ2m/TsH1EZJAwAA29eoVm1zV1T6dufNrz/2mE0RR1kvYassfNU49JO/YckKq3Kbbu
 WDwkDKuJKkoyPsCdVKgeA==
X-Received: by 2002:adf:e189:0:b0:48b:efb:4a64 with SMTP id
 ffacd0b85a97d-48dbaaefefemr15823358f8f.37.1791799861546; 
 Mon, 12 Oct 2026 03:11:01 -0700 (PDT)
Received: from losig.fritz.box ([2a04:9546:1c54:8601:c375:8df8:9c4c:d013])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9abd57fsm18064559f8f.37.2026.10.12.03.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 03:11:00 -0700 (PDT)
From: Lorenz Kofler <lorenz@sigma-star.at>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 upstream+uboot@sigma-star.at, Lorenz Kofler <lorenz@sigma-star.at>
Subject: [PATCH v2 4/4] binman: pre-load: Test signing with an OpenSSL engine
Date: Mon, 12 Oct 2026 12:10:54 +0200
Message-ID: <20261012101054.2104707-5-lorenz@sigma-star.at>
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

Test pre-load signing through the pkcs11 engine with a key imported into
SoftHSM.

Add tests for:

- PKCS#11 signing with PKCS1.5 padding.
- PKCS#11 signing with PSS padding.
- Reporting a missing OpenSSL bintool.
- Rejecting a missing engine key name before signing.
- Rejecting an engine signature with an incorrect size.

Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
---
Changes in v2:
- Use the separate SoftHSM setup refactor introduced in patch 3.
- Use one device-tree for both paddings.
- Add tests for a missing engine key name and an incorrect signature
  size.

 tools/binman/ftest.py                         | 88 +++++++++++++++++++
 .../test/security/pre_load_engine_pkcs11.dts  | 24 +++++
 2 files changed, 112 insertions(+)
 create mode 100644 tools/binman/test/security/pre_load_engine_pkcs11.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index f5eb895475f..c498e4c4959 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5969,6 +5969,94 @@ def _SetupSoftHsm(self, softhsm2_util, prefix, private_key,
 
         return softhsm2_conf
 
+    def _CheckPreLoadEngine(self, padding):
+        """Sign an image through the pkcs11 engine and check the signature
+
+        Args:
+            padding (str): Padding used by the device tree
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
+        softhsm2_conf = self._SetupSoftHsm(
+            softhsm2_util, f'pre_load_engine_{padding}.',
+            self.TestFile('dev.key'))
+
+        data = tools.read_file(
+            self.TestFile('security/pre_load_engine_pkcs11.dts'))
+        data = data.replace(b'padding-name = "pkcs-1.5";',
+                            f'padding-name = "{padding}";'.encode())
+        dts = self._MakeInputFile(f'pre_load_engine_{padding}.dts', data)
+
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
+        self._CheckPreLoadEngine('pkcs-1.5')
+
+    def testPreLoadEnginePkcs11Pss(self):
+        """Test a pre-load header signed through the engine with pss padding"""
+        self._CheckPreLoadEngine('pss')
+
+    def testPreLoadEngineMissingOpenssl(self):
+        """Test that a missing openssl is reported when using an engine"""
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('security/pre_load_engine_pkcs11.dts',
+                             force_missing_bintools='openssl')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: openssl")
+
+    def testPreLoadEngineMissingKey(self):
+        """Test that an engine requires a key name before signing"""
+        from binman.etype import pre_load
+
+        data = tools.read_file(
+            self.TestFile('security/pre_load_engine_pkcs11.dts'))
+        data = data.replace(
+            b'key-name = "pkcs11:object=test_key;type=private";', b'')
+        dts = self._MakeInputFile('pre_load_engine_missing_key.dts', data)
+
+        with unittest.mock.patch.object(
+                pre_load.Entry_pre_load, '_sign',
+                side_effect=AssertionError('signing should not be attempted')):
+            with self.assertRaisesRegex(
+                    ValueError, 'key-name must be provided when using an engine'):
+                self._DoReadFile(dts)
+
+    def testPreLoadEngineInvalidKeySize(self):
+        """Test that an engine signature with the wrong size is rejected"""
+        from binman.btool import openssl
+
+        def sign(input_fname, output_fname, key, hash_name, padding_name,
+                 engine=None):
+            tools.write_file(output_fname, tools.get_bytes(0, 128))
+            return ''
+
+        with unittest.mock.patch.object(openssl.Bintoolopenssl, 'sign',
+                                        side_effect=sign):
+            with self.assertRaisesRegex(ValueError,
+                                        "don't have the expected size"):
+                self._DoReadFile('security/pre_load_engine_pkcs11.dts')
+
     def _CheckSafeUniqueNames(self, *images):
         """Check all entries of given images for unsafe unique names"""
         for image in images:
diff --git a/tools/binman/test/security/pre_load_engine_pkcs11.dts b/tools/binman/test/security/pre_load_engine_pkcs11.dts
new file mode 100644
index 00000000000..eb4957c35b4
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
+			key-name = "pkcs11:object=test_key;type=private";
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


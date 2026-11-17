Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FBE606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tDKoB5Ha;
	dkim=pass (2048-bit key) header.d=e-labworks-com.20260707.gappssmtp.com header.i=@e-labworks-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rkrbYXbm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6FD26083A;
	Tue, 17 Nov 2026 09:40:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NpBDm67rrkwJ; Tue, 17 Nov 2026 09:40:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0F61560825
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794908413;
	b=foASNv2Ky4bEDpZ2LxOJNelEgr74UGjlPbblIgVNMdNyGd/QUHfCE53XVpM/eUXTk3RQ
	 Kv7EgsU+uBl063C1XNLHkI36GYN946v2PclgkHfxfYZw8YPHNaKKEONBqLkfwKOGdqQ+4
	 JU87P7kQWPyADyoHd0zYbO2pf1SJKsg6FVV1CHjWjVlfWNe8Gxfj19lklZROad5VnlWPS
	 aCABqNTUbB+uAHRKIXAhF1aJtAKyf3QZG1mTuqkrp0E2PMlNJ4Kw+aREID+3Z2SnAvGzM
	 s2idpRA2/MwPi03/Q/PylDOzZyxkABVoffCCzmTagQ6B5uLDGFop3ILTPGMXyXh6xYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794908413;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QTtthPE1OmdajwuCAjOd9ZlG8VzXnfsPuwvaX1wzjV8=;
	b=kNBw9yrnV8FOrStAg7Al0Ub5M0X29DWh3I9QjzCnfLFgalPLrMTpGAc+7AqngXVgdiOh
	 joPsZk8zyMU6f5zg6BFGre6dzel4SOuBs/sjxuYHQGG94nB9ZPJBjRuPPMlmDjXaWQrcB
	 knNh8vNtEhmYfsEtdq8LiMMOjRcjz2TYyC6rSvfCC37BKGiZox4CArk24YpR0lkuA+/Jp
	 lG0vu94mPuUcxwxXJUMKBYhjzpBaaHC/CUY1IVrIM06CBIA+OkrKiOi0OjC+hX4DgdWCY
	 SiHIMg9C4E/AGn4MDfOx+jvGtW+YCG+V3akg1OCVrQOWQiGHIBSRl+2bddAW8Db3k7g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794908413;
	bh=QTtthPE1OmdajwuCAjOd9ZlG8VzXnfsPuwvaX1wzjV8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tDKoB5Haz/lXEBxAUCzCn+wEUf6V+KajMzrI7Rjx390Mi4hZkEARRun8H4rbidXgv
	 yHAJmESedf5xAizep4BWo9XYvIadoNFfR0NSaftELjQzZr1wVD/zpvJXxhO6wOgy8u
	 AyLnkXZzOonIQo6OfZVtR60qdNKJbuoOpDDv9LS5hfP1GjrcZH5XC0QV/JKUgjsa8l
	 kA7FSWbKCUUIatwsOtWk0/QHW01+aNwbmxl9W5T7JQGsVkSU7PhzZouCV/0zr8gltX
	 udJyMiBS8qNZ+Wyho33yD5DZg4BM3uSDuPtW0cTQOrWBSbHRcTbttTm6/ydoUxjqXt
	 EtlU8++uuRSxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F61560825;
	Tue, 17 Nov 2026 09:40:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 091191E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:40:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 99C7E4074E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:40:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wMGulgdv3qD0 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 09:40:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 36FAB40600
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b134"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com;
 envelope-from=sergio.prado@e-labworks.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=e-labworks-com.20260707.gappssmtp.com
 header.i=@e-labworks-com.20260707.gappssmtp.com header.a=rsa-sha256
 header.s=20260707 header.b=rkrbYXbm
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 36FAB40600
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:40:09 +0000 (UTC)
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-67db1f6f50eso2422381d50.0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 01:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20260707.gappssmtp.com; s=20260707; t=1794908409; x=1795513209;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QTtthPE1OmdajwuCAjOd9ZlG8VzXnfsPuwvaX1wzjV8=;
 b=rkrbYXbmY83NaGOgWOLKNqkNsLrFDphjdnEyYgfx9thOy/3iEBKU2O2wX+Xm6tdO7r
 3gM54zd8lKw+O6ba7fNZ4uwjh1MJjM1WWU9U02z1mo0m8M1gUCRgC0VjIksv/TP2zDlB
 rT6/bNEeVniz+vn/Pk85o8nOrsJzZz3jz8D2tS/z/8XbEp07UukY9qsC2oM4e0UGbeqO
 kXdROaRv8VP44G1y1Wn0VC/j9AIJ000B/dss5TIC3XybzkXYYLCcXV0TDJwpYvFSsqqP
 UKzHK2SH5R+egsSWzH44VEltdpCqPO5nwgUObHGjNJnU613MrHS5Ha03kwNbYbetKP26
 pQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794908409; x=1795513209;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QTtthPE1OmdajwuCAjOd9ZlG8VzXnfsPuwvaX1wzjV8=;
 b=Ihpe+osO4m9iv9DhRLwiVBTU+Pe9Us7gnHVHy2kwA806iLr+6twbT5Yy/qHfKbowET
 5l6NQHaivEAIj2UOJwFQWvC4LoXl1ihpx0vi7qjkEvSBhp+Nh7CjQk6tyDRtdVkScLUY
 F7l2t0oLrs1zgrBvoooRlHshQc8eTXKDUEgEB3TltKtHphCUW8yyhkFXym6ytCwcsNYL
 1dJwMKDS7AlqHkBvTkcSPL6NnKJQKdF+HBRgjdDHDnUS8P4uyKviGuRpvIk3tjcEiupB
 LqPOStWc1HDcWD91dXKfsToDqGKqbwaTUocLvPPjnCeUq6tWZS+70rxL/j+tUCHFgczv
 2cqQ==
X-Gm-Message-State: APuU4Z96DbEbYp2ceIj1d+a5udCwIddtkkKtO2iFm3drLCPLYdilbTCE
 t1GTQ3QDTwGHtKkhBT3C7hwwONw598l0dp41ajDWKfAe1Rp9kETLDYxF82WRunz74jvWMNw6xhC
 hB4K7
X-Gm-Gg: AZFdTZevGlB3/UxtTigm3ubrJMBUatgK5HT8dEsuD2oU73cqDUHlRH1s/wAnhuhoGnv
 G6lVmwzs3iWbe493EkhQ0t5FEwny9NmI+75B+a7y9SHzEKsYmnqFLJOLeXz1nVypqHDKJj/KOe0
 eUqsm0TbQnM7g33N8SlO2tpS2DkOdeJIRsY1TM2Xg0IYIL+RTfaBhi2gMbXTqoHuoDJla4zs6H/
 weX2+bQCjlpKy82UJyw8i/MrRVhJJYywuM+5on5Hg2UTCivaQcIVw1mawJC7R9fALQgP/J0YoQN
 bziFCwJNuM9F9wb0vTcp6Hz6yNERc+91UuAOoUugWYB2/qU47z7KYh+gl3YTEw5otL8a7dJlkdT
 v3dX9gE2fojw0cZ6WbupyX4+M8Xd5Qu31lNl879y7fDnXRJT+SYrpnXZjcOZ+WKqqFG3N3BGdjU
 1DTj5d5MavlZOVBdj6W/3Pg94YVbwCDqmAdowcQ8Ri7er1q+SI1UnJkjIOLBIV7rf2UJgRiJWmO
 Jge6nBtQ7O1M9YqxaMr8agmaAQPMyNv/IV5FwWHLAcpBYMK9uAEevEn/Nbm4ZfBqIVvaMC6tB1D
 iAs7pUuXxIERW3GeVgDK0tckm8MgQdGzrTU=
X-Received: by 2002:a05:690e:4894:10b0:677:a8eb:7e8f with SMTP id
 956f58d0204a3-67d89745f03mr5009588d50.63.1794908407891; 
 Tue, 17 Nov 2026 01:40:07 -0800 (PST)
Received: from desktop.. ([2804:7f0:6400:b6f:6eee:9e47:df40:7cb1])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4ed01d566sm18364057b3.38.2026.11.17.01.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 01:40:07 -0800 (PST)
From: Sergio Prado <sergio.prado@e-labworks.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, alpernebiyasak@gmail.com, festevam@gmail.com,
 sbabic@nabladev.com, uboot-imx@nxp.com, marex@nabladev.com,
 jeremie.dautheribes@bootlin.com, trini@konsulko.com,
 Sergio Prado <sergio.prado@e-labworks.com>
Subject: [PATCH] binman: nxp_imxcst: support PKCS#11 URIs with percent-encoding
Date: Tue, 17 Nov 2026 06:39:53 -0300
Message-Id: <20261117093953.3812080-1-sergio.prado@e-labworks.com>
X-Mailer: git-send-email 2.34.1
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The CST configuration file is generated with configparser, using the
default basic interpolation. Setting a value that contains a '%' not
followed by '%' or '(' raises a ValueError, so signing fails when a key
is given as a PKCS#11 URI with percent-encoded characters, which is
common since token and object labels often contain spaces (e.g.
"pkcs11:token=my%20token").

The values written to the CST configuration file never use
interpolation, so disable it. This applies to both the i.MX8M and the
i.MX93 etypes, which share the configuration code.

Add a test to check that percent-encoded PKCS#11 URIs given as keys are
written unchanged to the CST configuration file.

Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
---
 tools/binman/etype/nxp_imxcst.py |  4 +++-
 tools/binman/ftest.py            | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/binman/etype/nxp_imxcst.py b/tools/binman/etype/nxp_imxcst.py
index 718537fda40e..47854202b3b4 100644
--- a/tools/binman/etype/nxp_imxcst.py
+++ b/tools/binman/etype/nxp_imxcst.py
@@ -78,7 +78,9 @@ class Entry_nxp_imxcst(Entry_mkimage):
         Returns:
             ConfigParser instance
         """
-        config = configparser.ConfigParser()
+        # Disable interpolation, since values like PKCS#11 URIs may contain
+        # percent-encoded characters
+        config = configparser.ConfigParser(interpolation=None)
         # Do not make key names lowercase
         config.optionxform = str
         config.read_string(template)
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 567ffa96b2b4..b9478123e2e9 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -8155,6 +8155,29 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")
 
+    def testNxpImx8mCSTPKCS11Uri(self):
+        """Test CST signing with percent-encoded PKCS#11 URIs as keys"""
+        ivt_data = struct.pack('<I', 0x412000d1)
+        ivt_data += b'\x00' * 20
+        ivt_data += struct.pack('<I', 0)
+        ivt_data += b'\x00' * 36
+        self._MakeInputFile('imx8m-ivt.bin', ivt_data)
+        csf_key = 'pkcs11:token=my%20token;object=CSF1_1'
+        img_key = 'pkcs11:token=my%20token;object=IMG1_1'
+        with unittest.mock.patch.dict('os.environ', {'CSF_KEY': csf_key,
+                                                     'IMG_KEY': img_key}):
+            with terminal.capture() as (_, stderr):
+                self._DoTestFile('vendor/nxp_imx8_csf_pkcs11.dts',
+                                 force_missing_bintools='cst')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")
+
+        cfg_fname = glob.glob(
+            tools.get_output_filename('nxp.csf-config-txt.*'))[0]
+        config = tools.read_file(cfg_fname, binary=False)
+        self.assertIn(f'File = "{csf_key}"', config)
+        self.assertIn(f'File = "{img_key}"', config)
+
     def testNxpImx8mCSTFCFB(self):
         """Test CST signing with FCFB-format input (normal auth, no unlock)"""
         # Create fake FCFB blob: magic(4) + padding(4116)
-- 
2.34.1


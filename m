Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D860606A32A
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cFsOEB/Z;
	dkim=pass (2048-bit key, unprotected) header.d=e-labworks-com.20260707.gappssmtp.com header.i=@e-labworks-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Ed2ilesW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F6E66081F;
	Tue, 17 Nov 2026 09:16:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yuvKlKRQ9PrL; Tue, 17 Nov 2026 09:16:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 41C7C60828
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794906978;
	b=j9uo4Kk5KO5lXvkUw90H5pBwVuvZ9wiFDfelmSsD+4TMW/Q1ecXteBJU+6Yt6cO4dCaA
	 anRxLs0ETbbRX/uouNOP3/RYS1LkOEIcus+RJc9q/2yqTG29ifB09h3kR31BpnnxsDcE/
	 uqecGyechR3z2nq+9/DYvQ5TyyXuDVJxBSmo7cVgLDwfsk//KqeBv6ssXmiG+FLb+cPOV
	 rB5aWF8pCH+OpAS205UfjKJxRInf3TKKnHrXcvr5y6XtENshRtwNVPcwi3iIaeEhmhR2k
	 50L10u8dzdr/jAloSd7IZZut1nhblZPohR/qC3gPrb0zVZq76lFGq4b+uqVf/JaFXYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794906978;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BNA2gmj3v3kjsAGytDPfpqnZzdPmgYVIQWaEKuZFHFo=;
	b=Az4tsULk4XTAVyRfsrYfOMGh1kQ9LUp5zZcN8G++RllB1LSZQHsMKHu0lCkDnW0bmgCr
	 wFHhkyVKDjpAAcA4Yydmg42NbJjC69TFGEFbgXrVh0D3tFBRpTAlcsXbB9xjfu3GA2wjv
	 MizbhRCUsTjxHFxy/ezLnnI6EhGwr/7kZT+a3lUACjRNENQGZQX+35KcvNpXJZXP3XrR/
	 29nOMY1eKMB26K0/M8kx950e/zrU3gM3yaXINfzerUQUa55l6thbTM5CFeYelSzH1OesB
	 Bp3HyAJd2HVofvd9U2HxCX4LLVo3kHwdC531Vn71ziqx3MwuaJZah3uhkd/vqVs4aBA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794906978;
	bh=BNA2gmj3v3kjsAGytDPfpqnZzdPmgYVIQWaEKuZFHFo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cFsOEB/Zke9fy/Ijdz0fYTlogLwSokOe+963BylXvWOL0+p5Q2cqAc5gTkVWxaRbW
	 PkLpNSAT2JU5psdfcpgz151aq9R+UH4mMLAalWViUT3daj4bovSfgfitPcOXFvsDes
	 8iy19xGudIC340N0iEycmM759svgJ9w63QGRTeVmm3qv9VC+Q8ytgrBfKV7GSi1H/m
	 cQ9gLsZ9UOs6y/G1P3UeLEARoKnbX/LGFgC4RatB1q0p3vTZWW7c0BPNrMENX9gkec
	 vm14VLD56o6NezwjBJcgaz52yQoKZdM5uN+/JcWazr5Hx7FbB8yzATQ/8holLGuNf5
	 oqHI3H4NOUubQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41C7C60828;
	Tue, 17 Nov 2026 09:16:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BA1681E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:16:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A388380F87
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:16:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XozioAlZ2cVm for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 09:16:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 49BB280CF8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1136"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com;
 envelope-from=sergio.prado@e-labworks.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=e-labworks-com.20260707.gappssmtp.com
 header.i=@e-labworks-com.20260707.gappssmtp.com header.a=rsa-sha256
 header.s=20260707 header.b=Ed2ilesW
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 49BB280CF8
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:16:14 +0000 (UTC)
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8b4f4095a7aso2619027b3.0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 01:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20260707.gappssmtp.com; s=20260707; t=1794906974; x=1795511774;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BNA2gmj3v3kjsAGytDPfpqnZzdPmgYVIQWaEKuZFHFo=;
 b=Ed2ilesWiCdp3688ID2qxfrREQfzGXo11iSvKRJrhspAnWAEOxzOG5tzripbKKx9qk
 TPGqx322xuP3NlgSDvRkKAO2EFW6XOLKSg3IOqWbfOYy4/DuEq+V6cP59FKd73uN5RyP
 1Scol+cPFGztk6Z1KXgKUMriBwRZnIG+IhYvH+9uGPp43tZ5BuziV3BpujVY+plm7vG/
 MmS2VGa+PBXsrktnuMis2bSGqh9N1Qo9RGelpNcAVoP77avGEAuRPUDMZ1Pkch0AVCyk
 hXbRd149YLnc6iIUjkof4dKsbv8n0u/FWwY2lffIfIGluUyH3V25WST5P6wKMeHDjQKP
 hWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794906974; x=1795511774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BNA2gmj3v3kjsAGytDPfpqnZzdPmgYVIQWaEKuZFHFo=;
 b=KPzB5uw4Oq/tgRSoU/udAcVNH1hSikPoViqB4xs/f1SPfyxjgSH45f3Xc8kBfn142O
 peI/fW3MBfJLiQLazJ2ou8WkbgMjg7j6Khfb1ZKODbReilkzYA8+aZ5bRO4wj1tUqOdu
 nVq3CH3jlBxIlsM7JA8d3evH9WNcN35dj4u0XDoOQV66BFWoel3De53e7kFw+SJ/QdAz
 R8QAzQh8duqT5g+rIU5jIAkNxSH6WuU4QCJwk8omguuwdcVgStHjMhAfm80qpKBkgxAF
 /49nDSMeguu0w6ykjGxjYWtl2+SiU/LuL3eqKi2RRmKId6xPNb1360pFH+NozSHrRtFP
 ZKLg==
X-Gm-Message-State: APuU4Z8HOWUk+j6mCoRZh8HQASeq0Y4yi2XnqZtMEotgZWwZomraNa2z
 97bKpWL1fGR74QLrKXdEycFXI3crs4EhKL8iwSsJi1eYL81Z8iC6s8VdfYcMOObJCKOtuubSMja
 KybR2
X-Gm-Gg: AZFdTZd/Ti70/z+7CWS208YEaq5i6Uy9tvcrDbdhSDYjT7o4Yn74G6tTTddGJvWk/YK
 3ht/EZwZSCZz3BoQRGDs3syzO/3PT5eKLfd4SnPJs3gBq2EP+nf206Xip0aQnOVbms/SdB6HioQ
 Dw/DbAFljlWDh3stRys38XmPpFWiTZ+FywLdp8JhiFCIrkiFFnJWFDetjvoupmgLFvhqRDG2sI+
 pTQdZWE9Hp6tEA+MjEuIvfHagXd86jtnS0ndtbbGV1ZwrcVdZZKCv/km4QCL5Jdo4K6u32FSeMO
 FuyzCqRZ2HzEARbRD70VHUK1UtdDKBcf41KqfwjERZ6zKj8zqbyRy4qjvLYBWbOVLboRbdg+cAW
 vWnImv8ozZp+NJ0ya+rEJT0OdY+77qMgGY3ss5gUz1LIp9OwhcmAh/5f6T8gSENXxg2VV4ZqIA2
 gmLuC9Eq6h2kVi3zFTNlMajbHXd0tD+crXGVvYk3yL+3iYlj+UmXSAGfSqedbmyVLCVoQEAJReV
 mLLY/nB1ndm/RTprUAGn+hao6gWI90hwDK6CktTYf+u4ItlSLFJe4ulrAqKPhjJleVIJ4OpAjrK
 bYQWpKCjRM2rkYY11AxiaVDrJIpWlmKh/cY=
X-Received: by 2002:a05:690c:6b01:b0:8b4:da4e:ef09 with SMTP id
 00721157ae682-8b4da4ef7d6mr32044107b3.1.1794906973836; 
 Tue, 17 Nov 2026 01:16:13 -0800 (PST)
Received: from desktop.. ([2804:7f0:6400:b6f:6eee:9e47:df40:7cb1])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4ebd4d125sm19600367b3.19.2026.11.17.01.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 01:16:13 -0800 (PST)
From: Sergio Prado <sergio.prado@e-labworks.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, alpernebiyasak@gmail.com, festevam@gmail.com,
 sbabic@nabladev.com, uboot-imx@nxp.com, marex@nabladev.com,
 jeremie.dautheribes@bootlin.com, Sergio Prado <sergio.prado@e-labworks.com>
Subject: [PATCH] binman: nxp_imx8mcst: allow enabling fast authentication via
 environment
Date: Tue, 17 Nov 2026 06:15:21 -0300
Message-Id: <20261117091521.3743071-1-sergio.prado@e-labworks.com>
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

All the signing parameters of the nxp_imx8mcst etype can be set through
environment variables, which lets a build system use its own key
material without modifying the device tree. The fast authentication
method is the exception, since it can only be enabled with the
nxp,fast-auth device tree property.

Add the FAST_AUTH environment variable, which overrides the device tree
property. FAST_AUTH=1 enables fast authentication and any other value
disables it.

Add tests to check that FAST_AUTH=1 enables fast authentication and
that FAST_AUTH=0 overrides the nxp,fast-auth property.

Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
---
 doc/imx/habv4/guides/mx8m_spl_secure_boot.txt |  2 +-
 tools/binman/etype/nxp_imx8mcst.py            |  6 ++-
 tools/binman/ftest.py                         | 49 +++++++++++++++++++
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
index 163e6c600a21..774c7a49d8b4 100644
--- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
+++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
@@ -180,7 +180,7 @@ Note that environment variables override DT properties.
 +--------------------+-------------+------------------------------------------------------------------+
 | nxp,img-crt        | IMG_KEY     | full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem |
 +--------------------+-------------+------------------------------------------------------------------+
-| nxp,fast-auth      |             | enable fast authentication method                                |
+| nxp,fast-auth      | FAST_AUTH   | enable fast authentication method (FAST_AUTH=1)                  |
 +--------------------+-------------+------------------------------------------------------------------+
 | nxp,srk-crt        | SRK_KEY     | full path to the SRK Key SRK1_sha256_4096_65537_v3_ca_crt.pem    |
 +--------------------+-------------+------------------------------------------------------------------+
diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
index 02ef9c255860..860b6323fbdb 100644
--- a/tools/binman/etype/nxp_imx8mcst.py
+++ b/tools/binman/etype/nxp_imx8mcst.py
@@ -80,7 +80,11 @@ class Entry_nxp_imx8mcst(Entry_nxp_imxcst):
         self.loader_address = fdt_util.GetInt(self._node, 'nxp,loader-address')
         self.srk_index = os.getenv(
             'SRK_INDEX', fdt_util.GetInt(self._node, 'nxp,srk-index', 0))
-        self.fast_auth = fdt_util.GetBool(self._node, 'nxp,fast-auth')
+        fast_auth = os.getenv('FAST_AUTH')
+        if fast_auth is not None:
+            self.fast_auth = fast_auth == '1'
+        else:
+            self.fast_auth = fdt_util.GetBool(self._node, 'nxp,fast-auth')
         if not self.fast_auth:
             self.csf_crt = os.getenv(
                 'CSF_KEY', fdt_util.GetString(self._node, 'nxp,csf-crt',
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 567ffa96b2b4..07c89f685621 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -8252,6 +8252,55 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         config.read(cfg_fname)
         self.assertEqual('2', config['Install SRK']['Source index'])
 
+    def _ReadNxpImx8mCSTConfig(self):
+        """Read the CST configuration file written by nxp-imx8mcst
+
+        Returns:
+            configparser.ConfigParser: Parsed configuration
+        """
+        cfg_fname = glob.glob(
+            tools.get_output_filename('nxp.csf-config-txt.*'))[0]
+        config = configparser.ConfigParser()
+        config.optionxform = str
+        config.read(cfg_fname)
+        return config
+
+    def testNxpImx8mCSTFastAuthEnv(self):
+        """Test that FAST_AUTH=1 enables fast authentication"""
+        ivt_data = struct.pack('<I', 0x412000d1)
+        ivt_data += b'\x00' * 20
+        ivt_data += struct.pack('<I', 0)
+        ivt_data += b'\x00' * 36
+        self._MakeInputFile('imx8m-ivt.bin', ivt_data)
+        with unittest.mock.patch.dict('os.environ', {'FAST_AUTH': '1'}):
+            with terminal.capture() as (_, stderr):
+                self._DoTestFile('vendor/nxp_imx8_csf.dts',
+                                 force_missing_bintools='cst')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")
+
+        config = self._ReadNxpImx8mCSTConfig()
+        self.assertIn('Install NOCAK', config)
+        self.assertNotIn('Install CSFK', config)
+        self.assertNotIn('Install Key', config)
+
+    def testNxpImx8mCSTFastAuthEnvDisable(self):
+        """Test that FAST_AUTH=0 overrides the nxp,fast-auth property"""
+        fit_data = struct.pack('<I', 0xedfe0dd0)
+        fit_data += b'\x00' * 60
+        self._MakeInputFile('imx8m-fit.bin', fit_data)
+        with unittest.mock.patch.dict('os.environ', {'FAST_AUTH': '0'}):
+            with terminal.capture() as (_, stderr):
+                self._DoTestFile('vendor/nxp_imx8_csf_fast_auth.dts',
+                                 force_missing_bintools='cst')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")
+
+        config = self._ReadNxpImx8mCSTConfig()
+        self.assertNotIn('Install NOCAK', config)
+        self.assertIn('Install CSFK', config)
+        self.assertIn('Install Key', config)
+
     def testNxpImx8mCSTBintool(self):
         """Test the cst bintool run() and fetch() methods"""
         cst = bintool.Bintool.create('cst')
-- 
2.34.1


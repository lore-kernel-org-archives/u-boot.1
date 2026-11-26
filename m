Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE0B606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 05:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OoTdb4pm;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ZXcOMFfH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 153C46069A;
	Thu, 26 Nov 2026 05:01:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WQNGVU3yVyw8; Thu, 26 Nov 2026 05:01:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 30BB8606D9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795669309;
	b=L6badCMYkfg01JA46ucylW96uKbyV5Wl2VdfvQBXZQAufQxSrxS62Hrj39tpKnXIjFX4
	 jwr3jwR+eiOpJpDb0bVHEhdv3aphNK3ZAm+5WyEdXFr+5j0/4zbOFmrw2OgGFBOmYjyPl
	 kcbUUj9qVRKIrKXRzhfRqPGWnKhOVgreTt426Rkw+9+5uHsxXn++o9I/yjpdMSyduQHuc
	 is7qnvms5FIC9aTThTRvUfk0ad0dbrN0SAcG3nNYC5ZIKVJeB4aaz1hD4GQ2tVTXM+iUZ
	 /SoSIifEXLu3+3zJE+H0tZp50VCsUf1F6UHt7JVX0O8E61JMGIPKEYHaQ2Rp27mcc6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795669309;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=f05PB5ngA4hdOXibkSmBFAFsniPdVZU5yFIASAsBtbU=;
	b=U9QeBPx8m3X8RS0y0NPnV+T7Jnppp9NdJPJGOeuPRDr7BI3j7zg6PC+YDHZNJWv6hcVB
	 RTlbnOUk6i4JwlNkg2N7Xdjjdar2U1F10erJbK/R+asXzAhYGSkfA4Hvmbd6E6chnJ1jO
	 l+9Ya2Xb7UJVp3ICaAHnhhytLkwwDWIA/4MfOXTtyENIBfVWloS4qjZwyJBFCMzviKq3j
	 BOtrdrRPZfVus5sV4Z2VxAdARW1/JbxJsTWWrBFo5Otwk/nLJQFzo/zyXpz53kuJ8Jgl9
	 ItzL5Y6bc9+ftYKWH2JB768iz9sM2BfrI5SBcauFCRvnYmDe1pcixCABZwflFlpCKxw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795669309;
	bh=f05PB5ngA4hdOXibkSmBFAFsniPdVZU5yFIASAsBtbU=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OoTdb4pmKjfwmqYOj5tslKnvFcPNLziBBOtrIMkmwvUFA8m4rzgOz8RVQFQs2JZyi
	 pdDcb0oexKcS5qrdF5hupfHE4WsmV2Wqe2Nn7zQsFJydciWYDwTR79lqwkeorwVpWS
	 xcoLCLO4HvPXY5n/s96oWbOJd5t36L1+slWsitdFQon/735ciqMJ5QNxqH+I327C42
	 IV411XnZpvzMDc7oA+SCpSkeZdDvVDq69RkZtWCz6l88wTHhgV1Cj7IWwIgiY3wHpb
	 z4GZ3ugv5FKk3TgDRAuUirGX8FpROYVTbGuHYJo4N/BiPMP61UwWVF6ljI28SWinKJ
	 makQYSvlsWntA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30BB8606D9;
	Thu, 26 Nov 2026 05:01:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 450241C9
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 00:32:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3669E80BC0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 00:32:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z4UVI8rof914 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 00:32:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 187E780B08
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=67.231.145.42
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=67.231.145.42;
 helo=mx0a-00082601.pphosted.com; envelope-from=prvs=97907298e0=cyan@meta.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256
 header.s=pps82601-s2048-2026-q3 header.b=ZXcOMFfH
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 187E780B08
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 00:32:22 +0000 (UTC)
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6APM1Wuc988654; Wed, 25 Nov 2026 16:32:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=f05PB5ngA
 4hdOXibkSmBFAFsniPdVZU5yFIASAsBtbU=; b=ZXcOMFfHMLtvd719G5U4lwvUS
 r7GjzPtAo0wUUqgmrirCgl6CWAeW8AYdj0ZjNskhhbYmqiBDPNAszL5rgUADNIaq
 WxEOADfSAtKdDPG2EY+4WDNzNVUhgPiB5vkRZS3ISHc2xbaL3P3K9gi6XMMXSlge
 EuTzciGuJ9E2ZzKEz3P6lgHNW2JYlZSx5iPD/AWZVsMgCsHIPk/UuOX6Oh24ECvF
 wTJ6TvxNXl0QrMq3ykgEmOErZ2yIcIkmmXcKWjR5KBv9Tgr98svZb4BT1aYuG0fh
 cTxrR7q8UOkU4naCymAXCdGOS92NJAV36RQbKPSNlZlqynqAVueSno9g5RxsA==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j5k9fr0tu-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 25 Nov 2026 16:32:20 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::30) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Thu, 26 Nov
 2026 00:32:18 +0000
From: Yann Collet <cyan@meta.com>
To: <u-boot@lists.u-boot-project.org>
CC: Yann Collet <cyan@meta.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] binman: lz4: Request independent blocks when lz4 supports it
Date: Wed, 25 Nov 2026 16:32:14 -0800
Message-ID: <20261126003214.3331492-1-cyan@meta.com>
X-Mailer: git-send-email 2.53.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=I9nw19gg c=1 sm=1 tr=0 ts=6b077e14 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=VabnemYjAAAA:8 a=aaHtXAMnGqx2OJG4q1YA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: aLVkCNz0agUQlfbCzZ6wXqjbCvdUsh_y
X-Proofpoint-ORIG-GUID: aLVkCNz0agUQlfbCzZ6wXqjbCvdUsh_y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAwMSBTYWx0ZWRfXypSgd5WKwP6v
 yso/0LFcbWHa7XxuP1OxJ8700lOvnrcESTI5v9W1DJB3voJxJqRBgSjmnLD49FcA8T9NKVgiP0N
 zzwxENPtFYefMydrqinfprwciEark1Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAwMSBTYWx0ZWRfX0/21KqVlEKbc
 6+sohhP72SqfI4mWY4ME2swocqqYQ9ZuFICIiEsC+gMcJwvIFySbh6VtVULdyJD1GgPhJmEyVUP
 j7NiuXdqE5JNRr61v5HM4UzW42ymDryIZcx7t3avI3aOvnAn/tfbpiGWriWJstA0cBfHjHyMhaE
 ILAErBkkHQIZxyBl36dqMgzdQ7N66WbQY5jpM8CByGWmnJaQTQmb51+znQnJETumOEjHNu+Flb3
 SwLXN3um6XibRG0FEvK5lqarCuPcouKo/PjnXbIErnhB1U5EMoDRXg47fF1QOMhv1AmoFqqRuoI
 2tZjeCOXzjcsC3u5dvMXurx0zt/ssVLQd1hWBvxHQrNUE+l40OEffAlNQTjrnbHpDUTfRQksw+U
 gJX5GEIPsS8XvCGlM5YoMaRsLd2pF2REwkfthQYCZTQH/mkTR1se6Idvf/+8u+Cn/G9ObyL2Nxp
 /+KImDufWWfnT5TCTJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_05,2026-11-25_01,2025-10-01_01
X-Mailman-Approved-At: Thu, 26 Nov 2026 05:01:45 +0000
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

U-Boot's lz4 decompressor (lib/lz4_wrapper.c) rejects frames with
linked blocks, so binman relies on independent blocks being the default
of lz4. lz4 is considering linked blocks by default: request independent
blocks explicitly with -BI, so that the output does not depend on that
default.

lz4 supports -BI since v1.9.0. Older versions reject it, but produce
independent blocks by default: only pass -BI when the version of lz4
supports it.

Signed-off-by: Yann Collet <cyan@meta.com>
---
Independent of the lz4 version regex fix in Andrew Goodbody's series
"Fix 'make check' errors": works with the current regex and the fixed one.

 tools/binman/btool/lz4.py | 15 +++++++++++++++
 tools/binman/ftest.py     | 12 ++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/tools/binman/btool/lz4.py b/tools/binman/btool/lz4.py
index fd520d13a..39f0aa6d5 100644
--- a/tools/binman/btool/lz4.py
+++ b/tools/binman/btool/lz4.py
@@ -91,6 +91,10 @@ class Bintoollz4(bintool.Bintool):
                                          dir=tools.get_output_dir()) as tmp:
             tools.write_file(tmp.name, indata)
             args = ['--no-frame-crc', '-B4', '-5', '-c', tmp.name]
+            # U-Boot's lz4 decompressor requires independent blocks: request
+            # them explicitly rather than rely on the default of lz4
+            if self.has_block_indep():
+                args.insert(0, '-BI')
             return self.run_cmd(*args, binary=True)
 
     def decompress(self, indata):
@@ -108,6 +112,17 @@ class Bintoollz4(bintool.Bintool):
             args = ['-cd', inf.name]
             return self.run_cmd(*args, binary=True)
 
+    def has_block_indep(self):
+        """Check whether lz4 supports -BI (independent blocks), since v1.9.0
+
+        Returns:
+            bool: True if lz4 supports -BI
+        """
+        m_version = re.search(r'v(\d+)\.(\d+)', self.version())
+        if not m_version:
+            return False
+        return (int(m_version.group(1)), int(m_version.group(2))) >= (1, 9)
+
     def fetch(self, method):
         """Fetch handler for lz4
 
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 567ffa96b..808533f4d 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -6334,6 +6334,18 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             version = bintool.version()
             self.assertRegex(version, '^v?[0-9]+[0-9.]*')
 
+    def testCompUtilLz4BlockIndep(self):
+        """Test that lz4 requests independent blocks when it supports it"""
+        bintool = self.comp_bintools['lz4']
+        for version, expected in [('v1.8.3', False), ('v1.9.0', True),
+                                  ('v1.10.0', True), ('unknown', False)]:
+            with unittest.mock.patch.object(bintool, 'version',
+                                            return_value=version):
+                with unittest.mock.patch.object(bintool, 'run_cmd',
+                                                return_value=b'') as run_cmd:
+                    bintool.compress(COMPRESS_DATA)
+            self.assertEqual(expected, '-BI' in run_cmd.call_args[0], version)
+
     def testCompUtilPadding(self):
         """Test padding of compression algorithms"""
         # Skip zstd and lz4 because they doesn't support padding
-- 
2.53.1-Meta


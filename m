Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574FEC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:30:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53A1588A67;
	Wed, 17 Jul 2024 16:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="VPko0+8o";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="XdOh+XcF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0876088A6F; Wed, 17 Jul 2024 16:29:55 +0200 (CEST)
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com
 [103.168.172.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0920688A7B
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:29:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfout.nyi.internal (Postfix) with ESMTP id 3FC3D13800EA;
 Wed, 17 Jul 2024 10:29:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 17 Jul 2024 10:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721226591;
 x=1721312991; bh=IFnC+SZgTQ8NKmKgjp3lssLIw5tdXo51kJEuxDVFBu4=; b=
 VPko0+8oNiPb0z64o7EJOlyXPapNRO4gaL63i1UBUpRPMAFThP+tB4UPYeABCyt9
 WOYw6JvfkgNTKAIj0j9fpvtTBdfIuN27LxFGiH1M1+OgLEd8YpForSdO4aHTvSus
 YLoml4IzA0zaDlSkKMcUJ7At4Rz2FqRqgU4iKYBe250L+M4KO2af06VIcRBisRmX
 WIMopcM7PbBBegfCT8Wahc+AHiUfbLFMDIz+cfwNXeDjsjkL01GC7tXgRe2BLSDN
 Xw8InIt8FMsp7SKnG/dFPeSyFO90JMIyUMpaODk4KKg3GiKVwLXFpKbDryfHsBD/
 qvnOknqzJsgVU0KneG2p1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721226591; x=
 1721312991; bh=IFnC+SZgTQ8NKmKgjp3lssLIw5tdXo51kJEuxDVFBu4=; b=X
 dOh+XcFOVumMnvSIcJvpeAl7FxBRkKzZ5cJOt8mXZsA1wBq89b7c+uZnCsj4zdil
 8KSv2ASesuRcZeQ9mZN85McjtkBa8gpVj+u3GezEPH6JyxnI9AkHKH4wKQBODD50
 TCdh1C7icD4hXxG40EoL4MxLQAfPEpp9H5CUbeAgwipZMAyKw7DWRmEJl2u7gjx+
 +xvyd9svZIdDKCLxG7Hg3oNbPhAjH0WlblUcsOSsIGYF7zry3Z03kiqS8iIB/Iez
 EAiTsy/FYxY6qLHiGUl8GiXnxdpWOsriW+mRnLdtErJKWnuZDnT+p9F6cwqETZ7A
 JxCwQOHTlSfDdOtgM9YvA==
X-ME-Sender: <xms:XtWXZu_2B26caRnHt1NwSb0K3Q1mvZCbntMX553r-tRu_ae5xi7Hpw>
 <xme:XtWXZuv5iC8qd_BZX9JIExtSDwdkSbcHWYajzBh7X-CI9GTnl_nRUc0PqrEOZSkah
 kBMxit80sfpJaSPubU>
X-ME-Received: <xmr:XtWXZkDj33MQq0jP3dvAavLGGVvTT8aRyXi6vdtlUxopePwAkFkGrOSeoomR7g5dzbJX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefhueev
 geffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:XtWXZmeuYsCMgwQM_zwGMGsddG2Zsx_Aj3nahWPXmGUIV21SiXwBbA>
 <xmx:XtWXZjOQ7Oc7pL8eHBWfIh2ybNEMEYvx6hjQLL-OJTdio56-SP7-aA>
 <xmx:XtWXZgnUMfMCvFeNaAq9CkZsDFdmvpQO3-4UM8Cz78Hy-B-3aTnlSA>
 <xmx:XtWXZlvvoAkmrZsB9_Sg5nW-2MEJKZ5YgOD2GqLwlggm7aZaBRhAuw>
 <xmx:X9WXZufUoHSJxp2LUItueitmLtJ1a_VQ1gXUtM6mqFnz2YOMWGShNDbB>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 10:29:46 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 17 Jul 2024 22:29:16 +0800
Subject: [PATCH 05/18] binman: Workaround lz4 cli padding in test cases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-docker-image-v1-5-7c7fc6251e7a@flygoat.com>
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2179;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=OnnSYSkdr8dAjpIqzJB7QFtJjP0NEIDJ+qPT+aGBXcs=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTpV11Mj5Tmcrx9ExXyfl2nrfrd11ybdFXvXdd9bDhhq
 tPSMh7+jlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjI2nSG/57GPsWqaYePJO0+
 8WKb4KLAdXY2kccUymufNsfmH+/nuMTwv9JZ9euRKsvO/FmT5//RWfPn3+JVz3lddEo/hF2vUA2
 /yg0A
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Newer lz4 util is not happy with any padding at end of file,
it would abort with error message like:

Stream followed by undecodable data at position 43.

Workaround by skipping testCompUtilPadding test case and manually
strip padding in testCompressSectionSize test case.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 tools/binman/ftest.py                           | 7 +++++--
 tools/binman/test/184_compress_section_size.dts | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index e9ad145e790d..0143d5e41737 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -4518,6 +4518,8 @@ class TestFunctional(unittest.TestCase):
         dtb.Scan()
         props = self._GetPropTree(dtb, ['offset', 'image-pos', 'size',
                                         'uncomp-size'])
+        data = data[:0x30]
+        data = data.rstrip(b'\xff')
         orig = self._decompress(data)
         self.assertEqual(COMPRESS_DATA + U_BOOT_DATA, orig)
         expected = {
@@ -6118,8 +6120,9 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testCompUtilPadding(self):
         """Test padding of compression algorithms"""
-        # Skip zstd because it doesn't support padding
-        for bintool in [v for k,v in self.comp_bintools.items() if k != 'zstd']:
+        # Skip zstd and lz4 because they doesn't support padding
+        for bintool in [v for k,v in self.comp_bintools.items()
+                        if not k in ['zstd', 'lz4']]:
             self._CheckBintool(bintool)
             data = bintool.compress(COMPRESS_DATA)
             self.assertNotEqual(COMPRESS_DATA, data)
diff --git a/tools/binman/test/184_compress_section_size.dts b/tools/binman/test/184_compress_section_size.dts
index 95ed30add1aa..1c1dbd5f580f 100644
--- a/tools/binman/test/184_compress_section_size.dts
+++ b/tools/binman/test/184_compress_section_size.dts
@@ -6,6 +6,7 @@
 		section {
 			size = <0x30>;
 			compress = "lz4";
+			pad-byte = <0xff>;
 			blob {
 				filename = "compress";
 			};

-- 
2.45.2


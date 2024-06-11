Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7463C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:06:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A93E1887C4;
	Tue, 11 Jun 2024 23:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="snPIeCzn";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="EHg6I0GB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFB0B887DB; Tue, 11 Jun 2024 23:04:40 +0200 (CEST)
Received: from wfhigh4-smtp.messagingengine.com
 (wfhigh4-smtp.messagingengine.com [64.147.123.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7EDE88709
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.west.internal (Postfix) with ESMTP id BCB7A180014B;
 Tue, 11 Jun 2024 17:04:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 11 Jun 2024 17:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718139876;
 x=1718226276; bh=0uQWuWEB7E+7xm/AsWfcsykK3sQ9ITG0ymcAfAV097U=; b=
 snPIeCzn8BsN9r8VdrvRydfTdojj0EfJTLSfhT3bccTjKCzOi54kcteGmQ/+m7kx
 ZlMi6nm2NRwEDOvkWTo1ann6/5zvKe33NY7hqQClEYyDHiCcE92i+SUWKSrvcEmH
 XmlcBLgjRcI6RV1j8/bTB7fpAkr3Feub94BkSSGzCjbn911Zc4vUD80ih7KIz+UP
 oMLKxSsyqMgzFy6/izsWBiQ9RtpZ6ZXhcLz6EDedeN53drS5ILwikrSTELJXgwBK
 JSmvenxA+yJs+M+W6NBUUb1eXx90uYACIm6sM9iLhUHa0cXf6HSMDQj61NzzwopT
 udbf6/0HvN45qOAxsdxQbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139876; x=
 1718226276; bh=0uQWuWEB7E+7xm/AsWfcsykK3sQ9ITG0ymcAfAV097U=; b=E
 Hg6I0GBRJAor4xlp5aOuY6VUnafSc/R0e6U8uZ4Y/hMQh84mgrEg20OI7Qal44rT
 8bKkv/rhEsKZpvV+fAII/dpoNwcWwrYyQCs8lWN1kYgOGBS+ZIMZxuL1yO4DwMYK
 kwJBAtpJARjRQSvrFmF7y8wkE6iBE9sSPkUvbBRrkqKKddSSH0NfxDw59PPpj67K
 w55aKo7gkeU3YhsoaaSGK9l8ID4lGATesniANcaqdecyrPxKfmeUyCE5jFQVBJKu
 jtUHyh720XSiDnhMnviENikx/ILX2WBKtfvOTy/KxyHrcrmRN/2bm8hVXY9ghdZ/
 9nJt/XdnJo41Mr1TbDFZQ==
X-ME-Sender: <xms:5LtoZlcOuYCoPWlYYXdOPN3WcYNe9ce7ea9j4kLQrByCB02bxMjSXg>
 <xme:5LtoZjNh1wNYKEzeNesJe3Opad3mj68W6D4EwnCA4WnNQJc8HcG0VLL5-EHXglUjD
 Oin-OVlznszIOdhAdI>
X-ME-Received: <xmr:5LtoZuiMbPB6sUJWKeInDNgdp4dixRIFr3uGN5Puz2SPHC9qj9DQ1vc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:5LtoZu_akz_QyJ1V5bQUeVZM3uUJh3MCGWosH40x6i2tYw95bfhmxw>
 <xmx:5LtoZhu2PjvParVvMBOdPjlEEKnpd6Tte040t335MQf2Tq0ULYmTLA>
 <xmx:5LtoZtFnGl2TOzTn1HZzI42RIncveSBI-H6EGUUZJfkQ-C6z2Golhw>
 <xmx:5LtoZoOLzcKYN097w8T1ffaE_9eeyu2W3rQBNq_71s4BCOjVLtlcCw>
 <xmx:5LtoZnB_ePVYGcmvswN6rUW_Jf4De8rSkXp63mW_6J_W03Y5XQl4Vf7n>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:04:35 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 11 Jun 2024 22:04:08 +0100
Subject: [PATCH 09/20] binman: Workaround lz4 cli padding in test cases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-docker-image-v1-9-51472eb70357@flygoat.com>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
In-Reply-To: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aaron Williams <awilliams@marvell.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2179;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=mwVTwnupW1WfFnCqDiV7ERFSAjb34yuouzpsJgMHUxY=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSM3Wcf3Dt60Ney65lSoV+iT5TxrffKX+c051y85bp+S
 cPnDjHPjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZiIDQsjw+k4rbz6ngzF6etu
 3pOcXP9rctzpS2GRMxk1pl9R6gjNvs7IcIRpiVb83uNqc8M76h/ZvP+rpqL8M5Ob48MdrZ8h1s8
 YeAE=
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
index 99fc606bd855..1107084bc058 100644
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
2.43.0


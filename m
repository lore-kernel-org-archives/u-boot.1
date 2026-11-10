Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3841160A2609
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KPbuI40v;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iS5Iiq9o
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1745B40896;
	Tue, 10 Nov 2026 12:24:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Aswssy5sJqJn; Tue, 10 Nov 2026 12:24:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 551BB4085D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794313463;
	b=aTs7E73+RqOFmXnfikKDlNWtQvaQsfoZ609fk5c7bBZ/2Fz9uK2gRgSt+nnlwlt6XAul
	 KIb+KbP+we050qGhCnqZu6PS7eAIQpRD9NokxLRp1fA5zrkjR35tEncIiM0R/nC19RnMc
	 9nPcHwZT5cDG3E8IIlTEVJxNPe0vA6tF2VFaotPK4/nZOf+6MHJPCWLr5EfX0o9swNzqJ
	 yoKw0dGjx8fM2g1rXOmn+5AYLLB/cm5Xls4tmN3mcSAxEDS6jIxb7SxwoNug9H+1babYv
	 kMPlrKqxxHVA+2TmAr0SZpxhpR7Un8rN1cyIF7EjBCvVo0PFRIRiWLi+Tj7fVHaB2Xw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794313463;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=NPS9iFdRJLtKK5WPFBx+oHYTrFL2ypgGKldkwgflcL4=;
	b=TKg33Wm4eg1dkBDmsKcqtmQ3goTXZqvbgjv1dMwIhAJnCwM/EJfxMKmLEGu5qAhv9WIw
	 crzcw2k5a9UOJKZcL+jRFKrkZcfeqHVHMoeDgbjYRhmxce1Xq2DPIqjVsEtW6HbI0QHKB
	 x1Wr04TrGmhU6H1v8ncB3IgPFX7QXnWNg+IsHkNAZYtwR16bjoMdvKr93jhXhxkuCzDVL
	 6Z4OHXshBWnoQ/JSfayyJsZl8vc+WVHKP713xPaoHYu2lBPRhJk2mLc7UMMEfKnLkY9Y8
	 274twcWWHeB1q+epSZqeSZhzCbJv6eB3eOyN9zqvQzFQfG5KyEUMEyA9QHRyH8XE3tQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794313463;
	bh=NPS9iFdRJLtKK5WPFBx+oHYTrFL2ypgGKldkwgflcL4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KPbuI40v7jxtVhOF+Myd7zoL86Sl4nUQ3FatH+ZnJ6fmRtlPSrKGkuUozP7dgY70K
	 HeXno7HgyZVej0yldJQj0Q5590/kXUPpYUZcfYuljJjys0h2fkE+Uy7E7icfJsL6n1
	 oegEEBEYZ+jWfgrP0i6fqjubH7wHiLUZ3bNWQa1OrUiLecC8vX77Xh7LogfmyTnmZF
	 TlP/cCwht/+hnF0JFPRpORECJUssNfz6xEc4wcf2zGJJJF8VTIGq0TM+kV5Gwx13tP
	 s3eX2rof4AbLp0z/7lBF8gMuT44uAypnRaTT8eZQ83/XB5XQ8Jv2kWHwbkZkYvF/U6
	 P5Lwd8bgiOgAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 551BB4085D;
	Tue, 10 Nov 2026 12:24:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 42CA01A6
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4080C40176
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KuTc-PrlxJaj for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 12:24:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4C83A40347
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=iS5Iiq9o
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C83A40347
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:14 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso11546115e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 04:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794313452; x=1794918252;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NPS9iFdRJLtKK5WPFBx+oHYTrFL2ypgGKldkwgflcL4=;
 b=iS5Iiq9oV/7/5c6y3293FP6v+j9JpvdO6GQ7HJ5b1ZbNS8LGp5+iEAEqRKLT+D6haJ
 R3DO5Xo0JzIvGhP3DtRP4J3f7KwQrJeVBUxG8CNponPSqDCN0GpqY+g2IEgFfpKO8Srh
 r2pHfcmRGrd5oy5/ZM0bY0RmRlBWFDKQZeqiSyxNXJ/ZV5B8doFBvdfFHVKNAZYtxFvu
 I0jF8iEira7REaJmyCc5jb4X9rAPEEE/7sLd5y4Ynn0pIZQcDGL5xgBFiap8pb/HOljy
 MH5mtY3GR1IUnsT6Nc+gBX7NSZP/mu9YFYobyptIwexQ3bJ5O56lWUtOK8oWPovaazI5
 aozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313452; x=1794918252;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NPS9iFdRJLtKK5WPFBx+oHYTrFL2ypgGKldkwgflcL4=;
 b=c7OqBmQRQnr99Q3/TTMPEGg45oB0Ko1cvd5RudM7jda4IIRBArqYoyb2kUKVRALWDJ
 i+9uvyAUSieJh9uFjd6qbB4xqeugr6qXjv8NqWAC8y/T8mil0NgOHUHg4TAWvTC18jNn
 cAC4H5D/2GkzrUh7tyMQDAI0Q87DGnST5mP4pYvhre7TOYFO8o4iYqf7hcmzSy5i1NHk
 EUM5u5699HOLbMiWSryZ1erK1nmpk2CNUDF+gV0Fwx0HUiptTi83utzTM5TekeTl4DXA
 /+hpJ3pTof3N57eNDmy2LZ0gpBhus0rHhO6FCjSpEHTz+qPrtNvb510lmDHT2YaUvc08
 yfhQ==
X-Gm-Message-State: APuU4Z/oJnM5EujidP0Hed6SowQ42VBRdWaKHkCl6AiKohh3eGit9JKZ
 2OJcFcU+kzXBdm4bqn+UDl5WctBegPx9YjVrFOpWQ9Ufa0hZ4uYy5fFDpYFW95MUmAA=
X-Gm-Gg: AYBFou1N2J2jBWVvTnrvfi/8QjdWzflxwE/DefJ+e3JJzkKwW5Bf+D5EzHpKSVLXm2Q
 IRFdU7f4q2o68fvUMHWHsjREXKdhKXRw6h4kWV0l4CQ5TN+V120O/nE2f1UsirlZ7mxaggOBNcd
 0Yv5p3EHI5GC8XkG5g3lWPFaWfwKZ0HIg0ZYC+QAVWb9N+LSGj36U98u9tcw/8X+wBJHFXuPzFS
 H4WHBR9Je1PuUWZ0LKBrvmY3cOmAraHzo+ZomTwybhTI5YXt+rWgwaByET+Vl1kkeBdfDimvtDV
 AfAN8LvDialSKox0x/aZQX/Tifp+6rbTGwtuUZyVF0HiR3ApKg0VuS7RUTmU57JAY+TO7zxOu01
 kcdadQnyqKnrXZVMgAL8/YWyWpys7e54II5c6BJe6OHtXagtYZzgabaM1NTzggzw/TVvaKOkWnz
 YICyB5yB+lvZQZXWt11HVjr7XOCRyKOYTqvjk983vDo59RcD8VltzXO+g0MS0J8N3DZSCIzgSxq
 8vEZ52Pe/eh+YRb5r7E32EqNIUoI1dl/BKOOr7Y0m4gE3Um2hbzMHk9wzqEpmPvz/Mf04//q8aB
 292f+o0uONt5dSpIQMHg2Qs/qufom4OCc9p522Ri4Wfy7hoL
X-Received: by 2002:a05:600c:4687:b0:4a3:5a55:f454 with SMTP id
 5b1f17b1804b1-4ba02347a5emr38388255e9.19.1794313451973; 
 Tue, 10 Nov 2026 04:24:11 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:e16:1f01:e865:f651:6131:9a7d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fea9eesm99279315e9.11.2026.11.10.04.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:24:11 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 10 Nov 2026 12:24:02 +0000
Subject: [PATCH v2 05/12] dtoc: test: Fix coverage by adding test
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-qcheck_fix-v2-5-1c76e0b68f29@linaro.org>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
In-Reply-To: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
To: u-boot@lists.u-boot-project.org, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anshul Dalal <anshuld@ti.com>, Alexey Charkov <alchark@flipper.net>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.16.0
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

Use of 'indir' in EnsureCompiled() was not being tested and resulted in
less than 100% code coverage. Add a test and supporting files that
depends on the use of 'indir' by placing an included file in a new
directory. The dts file will fail to compile if the new directory is not
added to the search path with the use of 'indir'.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 tools/dtoc/test/dtoc_test_include.dts                  | 13 +++++++++++++
 tools/dtoc/test/newinclude/dtoc_test_include_file.dtsi |  7 +++++++
 tools/dtoc/test_fdt.py                                 |  7 +++++++
 3 files changed, 27 insertions(+)

diff --git a/tools/dtoc/test/dtoc_test_include.dts b/tools/dtoc/test/dtoc_test_include.dts
new file mode 100644
index 00000000000..b5ef647c1b6
--- /dev/null
+++ b/tools/dtoc/test/dtoc_test_include.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test device tree file for dtoc
+ *
+ * Copyright 2017 Google, Inc
+ */
+
+/dts-v1/;
+
+/ {
+};
+
+#include "dtoc_test_include_file.dtsi"
diff --git a/tools/dtoc/test/newinclude/dtoc_test_include_file.dtsi b/tools/dtoc/test/newinclude/dtoc_test_include_file.dtsi
new file mode 100644
index 00000000000..f975005d023
--- /dev/null
+++ b/tools/dtoc/test/newinclude/dtoc_test_include_file.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/ {
+	new_node {
+		intval = <2>;
+	};
+};
diff --git a/tools/dtoc/test_fdt.py b/tools/dtoc/test_fdt.py
index 66d346b1272..a63c860eae1 100755
--- a/tools/dtoc/test_fdt.py
+++ b/tools/dtoc/test_fdt.py
@@ -1105,6 +1105,13 @@ class TestFdtUtil(unittest.TestCase):
         finally:
             tools.outdir = old_outdir
 
+    def test_ensure_compiled_indir(self):
+        """Test providing directory as indir"""
+        indir = os.path.dirname(find_dtb_file('dtoc_test_include.dts'))
+        indir = os.path.join(indir, 'newinclude')
+        dtb = fdt_util.EnsureCompiled(find_dtb_file('dtoc_test_include.dts'), indir=[indir])
+        self.assertEqual(dtb, fdt_util.EnsureCompiled(dtb))
+
     def test_get_phandle_name_offset(self):
         val = fdt_util.GetPhandleNameOffset(self.node, 'missing')
         self.assertIsNone(val)

-- 
2.47.3


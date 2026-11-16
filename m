Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531AF606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KdADfCNx;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rCbAvoUE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FA16607B3;
	Mon, 16 Nov 2026 10:59:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mZx6XVB-UYFC; Mon, 16 Nov 2026 10:59:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AEB8060614
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794826788;
	b=qFrLaCQQZjlpXhY08pTif1NAgpJUjh2WxNIg1qUIyWN0xq5OvwBbjIRY8r4RnKcZq+De
	 +POHg0L5NOTUBSofViSXGNoH7GWt5ys61w5qL0o/5PVBEMQWFWwds3uJ3Ohr0ClOSO5Pq
	 GTtraY261gXD8qimEY0mdfOaQ6AZWTOHz6c3BbXfv1f5l6NeLk/yUBCzsy/6k1RUGFYFF
	 yVpSg7I7eWWJRexjpLvb6MD2R0mF2CXSVtOMTtwkmOTBs2zFV+cM0F2iDdLCezZ1ueMUI
	 dei47cc5RWYdFeLhxo85oCbf6qQhzTnnR6CLyPO5D9hihaxrRXaIdFAbw5LNE5lFxOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826788;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=KMpzTtsHp+uVchak09AcrO/xVSIY+rKeAEM5/va9oPQ=;
	b=MPPUcnGm1+juleHOWutbWmPcF2e1GN70/oPD8TscH/uTQZpLDiyeMAolsx7CbNHJkHHa
	 nH6p5vuEMLO+ZP6R/BMQm0KGpUy6kCQTmFbq2IXpMDf2pXENB4rzQfZ/EV92DnZWBpT+g
	 LJIlQeztrVDkX/swTlEqHXpjK1qVsK5xDLpuA/spexWvmyAUdXgc6WL/zcw3QJwlH+Q/Z
	 5ar0Q+rSlZUBq26aQU3cKUVcfEVZzWGxaLbhysLQT0FyA+e0giSgjboaR7Q8QV4HdWvtq
	 3qhQ2UvIY2SpEep/c+o+S6kZUMkTn27KQCcBqo9JPihTKgm4cSx1mxm0WeHx5OrCh5w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rCbAvoUE;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794826788;
	bh=KMpzTtsHp+uVchak09AcrO/xVSIY+rKeAEM5/va9oPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KdADfCNx3k10DcndRhawesqYbV609eXDqCC4hoZMMn6EqWtpE0aEkrCwqO+POTfHb
	 CJ+WP+RigFxOF/rfblU5d7FIOTypfkHbN0uIZL3HgQxBq9gyV0IxGA9i730/qzisz1
	 aKDeKjvro58u58qy2e7mlqCGtPFgiXz9SPyXHbJeNVN44cT+R0NqZWNzcFBCnDhUZJ
	 CXGIANd6v/pbQxgEX3POlT8IdiXZWtI0EzrliZV4bJCeEgMiUurhwSzxFVxSWqJ7PN
	 a5QIJEGh8v5HcKkk6qQQADecfuUdygEnTU7xyj3hU0UgnkJ1peZZXbv9ERREv5hmjB
	 W7Ms7G35/rVow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEB8060614;
	Mon, 16 Nov 2026 10:59:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 020E14DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E3525607A1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Xd4g7ZPZAjJ for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:59:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3CE716078E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=rCbAvoUE
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3CE716078E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:33 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so23470245e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 02:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794826772; x=1795431572;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KMpzTtsHp+uVchak09AcrO/xVSIY+rKeAEM5/va9oPQ=;
 b=rCbAvoUEE943z1Lw+f+QxtJkJbbFIZ23e6XTyDXltZb9SqGnjy5NQS4KqyjW2k45uh
 /w5miyA5hWwjW4ir7c9/BMSjioVJIQlT6DrFWo5DLiXAVGMUljYiuqPFGFlSyDsEFAt7
 iBbvD1eB2Wm4vzMS13bu1uUgvm4hX66NY2Zl4UbTPXf7A3i10h10wMrziXRB5IwONef5
 I1o1kw/SmN8LZe/9YhlvHZb9quezwMQY3WiZJNrE6frOL4outGo2qLjxYNylXFwmi1Hr
 WWPGFEDLnsmudzX7C/5vB/hwE/PNU2ToNmBvxboe0DnjK8n7A6iCDvQxkbBy1+X4nlpa
 Y3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794826772; x=1795431572;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KMpzTtsHp+uVchak09AcrO/xVSIY+rKeAEM5/va9oPQ=;
 b=k7zuIEL8S92enNWlqBLOWabc4xtDwEZRtWI76Kr0h4IIoJOf8UI1iqQHiDYhSmXQwN
 UbzX0RLU9FAxyc8+OqlB+m4BGXfnqkyiwQgoejnTBCzqFG8AgN2eJKtVOyuKtYIxaIhe
 CA4m3/JkeAvOfaT2NBRI2JxYg7jfspa8HYiN4S+wnu50aP1bKC5EfzUvMnUjFLhEe0OU
 AKEL0hU6WRYbo5cKKnsytEbbI7iob/8qoGPIi3/GzjOpPOOXWGmRxKW/u86L7gDn6nS3
 L2Zi/yczui5WDPaiyCOaLCmds8l22jfH/Fkla9AGcthkkYxMCAaGs4Z2pzeCQ55LqeJh
 wZag==
X-Gm-Message-State: APuU4Z8NVHCFWjZ4tXs9Q0tYQrkzvSgOFr7UEdN4/1KVO/EbSq+YEUmu
 0ilymOb2kH5BOrn5ojzIpHu6iwqpPxvj0t8Klvd0WplM8pwhESJCSyQcComGVN+7WzQ=
X-Gm-Gg: AYBFou2rXTbCRI+a0I192vlvVnEAPL6m3Cdg6+BU4bKVeziSd6SpluGV7faxE0yKfbZ
 rLL3MokaN5lLEPlNLvM6JF/hjoaPO6H+urUIQxLzy2DseX03+6FJmS2dVyw2HixxrhOB402R/dF
 ePZrrHnky5Qw0MwljiBgm+jyDRyDr5cQzqFWmhxTasxs8jSivXEBdcMSXKFnUvaSeAqFQ8mju+G
 FF5qEVPrhSa2cg57H+ESHcTqyU97AokncaUByjG2cXQQF5GJVYboU79G5gD+35EU82kDDw/Z4Wd
 scEZohoPAZDXtV2WZ+XnCSnqq9wV+CYYJwHLFYWOkfJY0MN+b5MNuIhBuM6MtF63xi1IkuR99aL
 X3k7fS8EoyADzhGFt9nmeiJ5g6dBAcQoBEMePkCRoBXzDvhymgmbXAeHYMkE2dOo1BbIzJndhFl
 cFovTyrnnHcsJKh4g9E4nnU//DpU6itjPghrgM3kW8vb/ol2kAxSBSBtpdHHGcn4ZN10Y6ESl6j
 SuAy2/d8x9Bh3ZTSAZufbEV1TV+yybxD+FeSB+eEKEpqdmFpnZHhnZerCUdbog1rMXBn7/mTDL9
 hljnztU2/p3eKiusQFTZbxezbOVcvJb/yzOG6BIxpYwkND5k
X-Received: by 2002:a05:600c:3b16:b0:4a2:1960:6fa with SMTP id
 5b1f17b1804b1-4bb55a6116bmr221189695e9.4.1794826771860; 
 Mon, 16 Nov 2026 02:59:31 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:ee3:3401:d23b:e87d:8bff:70bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb64ec7b58sm219594065e9.5.2026.11.16.02.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:59:31 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 16 Nov 2026 10:59:28 +0000
Subject: [PATCH v3 08/15] dtoc: test: Fix coverage by adding test
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-qcheck_fix-v3-8-b6cf7e96944b@linaro.org>
References: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
In-Reply-To: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
To: u-boot@lists.u-boot-project.org, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use of 'indir' in EnsureCompiled() was not being tested and resulted in
less than 100% code coverage. Add a test and supporting files that
depends on the use of 'indir' by placing an included file in a new
directory. The dts file will fail to compile if the new directory is not
added to the search path with the use of 'indir'.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 tools/dtoc/test/dtoc_test_include.dts                  | 13 +++++++++++++
 tools/dtoc/test/newinclude/dtoc_test_include_file.dtsi |  7 +++++++
 tools/dtoc/test_fdt.py                                 |  7 +++++++
 3 files changed, 27 insertions(+)

diff --git a/tools/dtoc/test/dtoc_test_include.dts b/tools/dtoc/test/dtoc_test_include.dts
new file mode 100644
index 00000000000..cb19389d889
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
+#include "dtoc_test_include_file.dtsi"
+
+/ {
+};
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


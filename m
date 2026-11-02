Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE62B606A327
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qFUEHtCg;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gk5chGCV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 643EE607E4;
	Mon,  2 Nov 2026 09:58:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jGygfJH0iBsI; Mon,  2 Nov 2026 09:58:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2EAB76080A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793613534;
	b=MLuQBzcwIotjonluEb+ORKWbpXZ8tWsqY3GJXiv23uwM8ASMGAXhqRS3l3YlsREs9R4q
	 1eZrhVz6gl1aujz149IGMvnqwIfIJmHxJGA6VwMGQOsHMjo1c0hIQOe2QJdkj2kplCAB/
	 YK4uPm4ZTQbrVGUtukwX6awUroxjBzs/ge3H/HxliYw+DouKh/j79eXMirbFaTr8vrCEW
	 UwAvY5GwWuC5KbC1idvgkfqyGtbnzZ//u4vs837ha8uoILIiGkU580R4eMjbRX2EYE26n
	 IQ9eFWS/HNiyuFUFKTpPPvyFr+VUfdq/32jNGWTCuJHgGB4eNmMY1xydkE8hC2tHYQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793613534;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Ysjp6DCaXvg1llbv0gQ9GjVzxsxrlaNreWWGyZ7MxP0=;
	b=ZPPrSjhi+ugqo1LShIiJEpoxoSj21uI5vF8zKHrjB9JBmOPbywRdE/W2IrEkI/B4PNbB
	 QkZzLV1+v7ysU2ajXbx202TNMA2R3WSqi89fjKMklBJGTwPbHqxRT2e4lacUtR/aVpWFQ
	 2do1DV8TWBNa0hF7/CSPBOpeNoScWqs2Bk0zR6CnAP0sEfkwxbqdnWv1flj+veYObDFoa
	 L5256dUJGZ0l9nrgwJFbgoBrUqR4krorOCY80sy0uvbSfyUJIhDL2dSUB0iYY/yFFfOoc
	 LzidQoTDe0AzlzW922U7K9q/0zgaL9mFTM/51sUbTIATyG/EawaO9RpQzkrX48/1uUg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gk5chGCV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793613534;
	bh=Ysjp6DCaXvg1llbv0gQ9GjVzxsxrlaNreWWGyZ7MxP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qFUEHtCgEgDD3LitHq41Z9SRYoUeNdKYgALC+zxCXrcx025rdOrBcmUGe27qn9dvt
	 m4xTtqsdINo2A1pszOnnKXXdTWolDQLvmt0z+0iCjvvEbWfvq74M5iIRdE37fbxtIL
	 SO5Osc2J2KSJWou7nV1lfVGa2VSeJ62nQYh1TRLj/lm7PiyQILGAtfMWQphSlGvpWg
	 WMj6YP73//9iceZW1B7HFmfITenL4Y5dA4RxYpIordy8El4omuw8KgPMEtXoNM3VkL
	 A6pJr50ioURyK7QGZ6JeSEuLY0e2HXYeQAID9AQJUQDXbp303e/4jmUjKtRRgKr/EN
	 gSizGVPjj82dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EAB76080A;
	Mon,  2 Nov 2026 09:58:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 97A14D3A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:58:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 83C9B607A9
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:58:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ewUYQFHKdYIR for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 09:58:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6E7AE6076F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793613524;
 b=jdopWjL9Oro5JR0FZh70qDsz9lTH5TSZooD/2rj99tbLjdLHKBSlyo+xQFklA2EcT7b0
 17lvlYJX/STnd+3rLM1eKYsuWhPghyuXh8cS6q4UZi1O1Ez2BLvqYSKpqbED0Y/bTENzu
 7pSte84W15Pg8NHYc1SuTjNZJG6PeSMllUa7/U73+/gK6dekLrGLCBuuSW3N1EsrM2Xem
 onwvjpNHQG+P/hHdb+Q3BaLRUlCjael92EUmOmEotd3X9iK7wCnQeYzHDH4t5D2P6zGgA
 Dg6THHaTinc85iPFpVxOM6YRjPZlC8rKb0X9KwnF/Km4sNsBhJt3KvMCQLtnX27mINA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793613524;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=Ysjp6DCaXvg1llbv0gQ9GjVzxsxrlaNreWWGyZ7MxP0=;
 b=oIWzBsPPnuCvNdoyn0j7udLgF+q1zMhelErQ/zbUg8Fn+8xjyQ+QPzvjAyb6GLMRu7WC
 ip2loJwzcsewu0wRhBbQ9DDz2HrHqULvi3kBBDkr0UGG57+DHpZ4xSZeCD0YG9JJ1h9TE
 KFgMNmwBu4ioCzNmIgGBKzWARpBgTxajWUibEwhUn3+/9RATqqoGp/1XfjcHYyx2ngfBP
 5UV3u90pMHBmiZrRN34ld/hQZWamFPWyXLJW+0KPimOdY2NTJLajbmQhxcwHxajH8IcRg
 NKkgS3pMMocf6kNPg29K2KNhH9e28TlVUO7MEM6VrBJslj+ete6btzZpDPdqrl3DssA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=gk5chGCV; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=gk5chGCV
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6E7AE6076F
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:58:43 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so23493205e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 01:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793613522; x=1794218322;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ysjp6DCaXvg1llbv0gQ9GjVzxsxrlaNreWWGyZ7MxP0=;
 b=gk5chGCVFugqj4Jmekk+PC5srUGDuypTBtgzc1JcOswQyB1tbyMdSiYETkJ35SlHF8
 vjJLRNK7xWr4BcT/D3gU58p6DYAQXS6gX4bOZzVLEyn14nVRsjCJ1GSXKmoiLnNvo2qp
 MgBVstw6WXVADQyScscTdrFWNk81Lq6/QEWG3hvR+4ujyeyTNrxzU9lI12SmULWsC5E+
 SFLj17YjhhxOBPisE+VESGJ1JJIv0xGQy6OLaGxVgpHXKnOnjXITH/oyOl4E3lrGg2+f
 oToEuRGUgtAWOGxCoK/23bZWOlaRKfEQCCzz1NIvSbUCPfSkdU0WJb6DGOYMlKofCtdp
 cYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793613522; x=1794218322;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ysjp6DCaXvg1llbv0gQ9GjVzxsxrlaNreWWGyZ7MxP0=;
 b=ibqfLRZP43kJWryMx0doC2c75VUmi1jjE2TyI/XCNWpkbpTGUESU7DCRsxWn3kw980
 O3qALX0yOZzBwqYN0Eahd8AvvDRhZjuJAIsRTzQedTbOvqfRmzyV0F+emD8JoNBGubFz
 nXuYrY0AgtU0yHNcbZzMlzuf0DpgAAOJKZ1es/AYtc9qtoHX1+zyBQSQ3gAlYm9y6792
 0LMgSGTw1VxUpTxN+5tOXRAM7Uqcwd7V8NIb72IIvw9Wbc0Wh5rWRotaQ+Yp7/SDcfz4
 eqjd9+qRdkK7bLhMQKCXj0yd6o9QQPp4MzHn8IT/b8GRq/nI1C3E2PbGlz584hAwfMx8
 DeSw==
X-Gm-Message-State: AFq9FYIECJF9FSsH6sRWkrB/INHbb5qE++KPPKEa7aT0/rZHeqquwK5U
 PVFnDPzPZALx112z76tpT4hRb3mHiWPHhF8iQa2N5Gmlti1+HXdkcQRktAabnnNw9eRk3tCUs0Z
 e56J/cGLPUA==
X-Gm-Gg: AYBFou0Pw4LX47toi0l0gNcDMvEe8ZlhdoxjabN6idKoXvppZN6qRFfIHFBJqg1Ny5+
 i0Ja//8ZKXXsZk34jlbmv1shUA7Q0mo/H65MaA+xfYUQSbTYqOvwhR3Y02Udj1I4DvPp1v2VqOI
 ujFgAT3FiDlRpWTPgbezYA6pdRr8bXSHTq9rC7DhRwrGFswF89xx8gY3zPGHx2WSbBaXUoqZF33
 hynFebZnUQUyFHq+DV7iqxi8GZR5YWaChfkCC0bC7+iUTVBidIUTh7kNzX0TZzE5HSV4rslEB8b
 pI8cb5tEtG9jV4CX7ZhZgR47AzM+YQ/AC0mwbm4mkuQ6l4/wAnd2I/STuSD0RthkKBDxXOVPby6
 a5tDbPHX2zG0njsVrg8KWXHZfJl5HcyEG+gtYQtVXI9NrkHkO7tSeiHnQzLk16wZQMdfzL9NUAH
 jfDftZ0Ppd2nAABTaqb0BpQP7dEw8URqDsfh2WnZz+8LHBiJoFocfkb+Ao6Lsru2OY9y49trnN+
 64DRI32cAYgG7G9aZ6mnOVeBksylr591Ktg9u1ThYdk0YT+RF+imaE2wbG3ZWhRxY0Jpc13Opw0
 ckjeL4yWCMuJUaepT0yqg7fjJIELUFgOMXQKrWDKpI4NQ3O6
X-Received: by 2002:a05:600c:1387:b0:4a2:729:f7ce with SMTP id
 5b1f17b1804b1-4ac17d16afbmr220621905e9.8.1793613521992; 
 Mon, 02 Nov 2026 01:58:41 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:e16:1f01:d3e0:4b17:611f:beac])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba7168sm20744682f8f.55.2026.11.02.01.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 01:58:41 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 02 Nov 2026 09:57:50 +0000
Subject: [PATCH 5/6] dtoc: test: Fix coverage by adding test
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-qcheck_fix-v1-5-f1f547c4a731@linaro.org>
References: <20261102-qcheck_fix-v1-0-f1f547c4a731@linaro.org>
In-Reply-To: <20261102-qcheck_fix-v1-0-f1f547c4a731@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Alexey Charkov <alchark@flipper.net>, Anshul Dalal <anshuld@ti.com>, 
 Francesco Valla <francesco@valla.it>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 tools/dtoc/test/dtoc_test_include.dts              | 71 ++++++++++++++++++++++
 .../test/newinclude/dtoc_test_include_file.dtsi    |  7 +++
 tools/dtoc/test_fdt.py                             |  7 +++
 3 files changed, 85 insertions(+)

diff --git a/tools/dtoc/test/dtoc_test_include.dts b/tools/dtoc/test/dtoc_test_include.dts
new file mode 100644
index 00000000000..19450a3942f
--- /dev/null
+++ b/tools/dtoc/test/dtoc_test_include.dts
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test device tree file for dtoc
+ *
+ * Copyright 2017 Google, Inc
+ */
+
+ /dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	spl-test {
+		bootph-all;
+		compatible = "sandbox,spl-test";
+		boolval;
+		maybe-empty-int = <>;
+		intval = <1>;
+		int64val = /bits/ 64 <0x123456789abcdef0>;
+		intarray = <2 3 4>;
+		byteval = [05];
+		bytearray = [06];
+		longbytearray = [09 0a 0b 0c 0d 0e 0f 10 11];
+		stringval = "message";
+		stringarray = "multi-word", "message";
+		notstring = [20 21 22 10 00];
+	};
+
+	spl-test2 {
+		bootph-all;
+		compatible = "sandbox,spl-test";
+		intval = <3>;
+		intarray = <5>;
+		byteval = [08];
+		bytearray = [01 23 34];
+		longbytearray = [09 0a 0b 0c];
+		stringval = "message2";
+		stringarray = "another", "multi-word", "message";
+		acpi-name =  "\\_SB.GPO0";
+	};
+
+	spl-test3 {
+		bootph-all;
+		compatible = "sandbox,spl-test";
+		stringarray = "one";
+		longbytearray = [09 0a 0b 0c 0d 0e 0f 10];
+		maybe-empty-int = <1>;
+	};
+
+	i2c@0 {
+		compatible = "sandbox,i2c";
+		bootph-all;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pmic@9 {
+			compatible = "sandbox,pmic";
+			bootph-all;
+			reg = <9>;
+			low-power;
+		};
+	};
+
+	orig-node {
+		orig = <1 23 4>;
+		args = "-n first", "second", "-p", "123,456", "-x";
+		args2 = "a space", "there";
+		args3 = "-n first second -p 123,456 -x";
+	};
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


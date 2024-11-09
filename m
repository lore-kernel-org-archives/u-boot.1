Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86996D5E379
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 18:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ECCD89232;
	Sat,  9 Nov 2024 19:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wd8DlQjK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C323D8921A; Sat,  9 Nov 2024 19:01:20 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D89A88930E
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 19:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-431ac30d379so27431465e9.1
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 10:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731175277; x=1731780077; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TkNJV6j4tv5OhZYy5NCEzsQ83VSVdI0VffpugCcxGvs=;
 b=Wd8DlQjKhD0AgeDbgEg+pndGxWCnpl+XBYF1naT2Nkm889limdCv4hdojEHprDgrUB
 S5D+rI38cdINeLsmBE6JxNONVIvV5vhrDuLfSoQ5mVBIx6oBWtKy/UZJRgJdDxUUyEfx
 rFF+41xrHFm1/JbR510dblZexvd3OmCshVpyMlFrvsV11YMlJLVIvyB6c7R+5OzumZ3j
 91tFYjeuna+ZOJXJeccQwUWWS3SAMc8iSOhEacFP5e4cXJ1i025ZxCN+gnFiRFwlMwtN
 4koksQ5B0wkkBsMQMoenOjn6du57kReINT7lS0l1NbJJ8uY1aHZrnGWfgmMmyCmlbQ/7
 Ov0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731175277; x=1731780077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TkNJV6j4tv5OhZYy5NCEzsQ83VSVdI0VffpugCcxGvs=;
 b=fV4HyRxVg/6xZ1qm6wGrPhpN2Jqm0VYWTg8uRdFFcP22UFsnly1yCCfDeGqcImqqdg
 3szOzjb8soReGJ0mqA21vVTV3qYHXmd5CVBLujEs1L/TRhkQjyZ2N9XFdx1o6qZ5jmjo
 d+tlcObgmG8m0jeLyGLTrKlTQzrx7Ay9yVwTQzCVVj6Sjnqx+Y9Q8+vyrWzQyUliWwzy
 veySyu82zXORlXuI2rMu7KCyuWXjGNRLaqLDyBru0nUqh7KpypabN21dzGFdZ4w6yXub
 RS+732WLZHAn8KN5Ot/a/UmH+Ukl3Fg6r33o9WJSRLORBWMrClXOJ8z5K7cUG5RSxFUy
 Jtog==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/gQbV4zM0fylWqLyIWpPq+ekoBNo9x7tTT21BrhS5Uy3vkxQEEKTQYaDMjcTZHXXfCzhIOe8=@lists.denx.de
X-Gm-Message-State: AOJu0YxWwetU561JoA+tORxkaiRY9/QlFfBqxYn4fQtxJk7OYCHRJ5dv
 P5J0w/4YpW3POO4WDMM/9LpD39e+I+f3VUwwAG2VnH/d7/nRJJo2
X-Google-Smtp-Source: AGHT+IFOdUmXkkwsSE+vFyrkLZIA08p6mL2cRBceXdT8ZtAd9qOqm1fykI5J9Wo31Tm7VCqgbIWW4w==
X-Received: by 2002:a05:600c:3d0b:b0:42c:af2a:dcf4 with SMTP id
 5b1f17b1804b1-432b75196e5mr58077795e9.27.1731175277198; 
 Sat, 09 Nov 2024 10:01:17 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432aa73a2d8sm146095025e9.41.2024.11.09.10.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 10:01:16 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH 5/8] dm: core: implement phandle ofnode_options helper
Date: Sat,  9 Nov 2024 19:00:30 +0100
Message-ID: <20241109180038.10344-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241109180038.10344-1-ansuelsmth@gmail.com>
References: <20241109180038.10344-1-ansuelsmth@gmail.com>
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

Implement ofnode_options phandle helper to get an ofnode from a phandle
option in /options/u-boot.

This helper can be useful since new DT yaml usually require to link a
phandle of a node instead of referencing it by name or other indirect
way.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/core/ofnode.c | 15 +++++++++++++++
 include/dm/ofnode.h   | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 774b428c43f..3a96bf4f0c5 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1871,6 +1871,21 @@ const char *ofnode_options_read_str(const char *prop_name)
 	return ofnode_read_string(uboot, prop_name);
 }
 
+int ofnode_options_get_by_phandle(const char *prop_name, ofnode *nodep)
+{
+	ofnode uboot;
+
+	uboot = ofnode_path("/options/u-boot");
+	if (!ofnode_valid(uboot))
+		return -EINVAL;
+
+	*nodep = ofnode_parse_phandle(uboot, prop_name, 0);
+	if (!ofnode_valid(*nodep))
+		return -EINVAL;
+
+	return 0;
+}
+
 int ofnode_read_bootscript_address(u64 *bootscr_address, u64 *bootscr_offset)
 {
 	int ret;
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index eea6b13217c..890f0e6cf40 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1720,6 +1720,21 @@ int ofnode_options_read_int(const char *prop_name, int default_val);
  */
 const char *ofnode_options_read_str(const char *prop_name);
 
+/**
+ * ofnode_options_get_by_phandle() - Get a ofnode from phandle from the U-Boot options
+ *
+ * This reads a property from the /options/u-boot/ node of the devicetree.
+ *
+ * This only works with the control FDT.
+ *
+ * See dtschema/schemas/options/u-boot.yaml in dt-schema project for bindings
+ *
+ * @prop_name: property name to look up
+ * @nodep: pointer to ofnode where node is stored
+ * Return: 0, if found, or negative error if not
+ */
+int ofnode_options_get_by_phandle(const char *prop_name, ofnode *nodep);
+
 /**
  * ofnode_read_bootscript_address() - Read bootscr-address or bootscr-ram-offset
  *
-- 
2.45.2


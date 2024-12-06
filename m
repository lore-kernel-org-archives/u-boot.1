Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874B8E7717D
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 22:55:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB7AD88ACB;
	Fri,  6 Dec 2024 23:55:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PLRVeI+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C06F98870D; Fri,  6 Dec 2024 23:55:39 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 513E389578
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 23:55:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e398484b60bso2568698276.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 14:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733525735; x=1734130535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4uiql7sFnLdjODsO1+IMSzCjQKghuwLZZfDPhC2MrQo=;
 b=PLRVeI+PBIY3CI3GHJVUFdF3ecsk0EFk8VCDly2y3xvK4Sy/Sit8o8fUgzTo9bc2jW
 bXELZnoXUDjyufVvHf4ISAnHskj5guRbZZkL6Ifqxvjfe5gnB08j4EYxzqd/gW40yQmw
 fkeTx64MsxcMHxz1kfr0yUCWFTOzefWf5ztVlD3KLaKGpkqjvRiy5vVN6pC+SwWcBzlC
 W6BE8o/lgueg60ZsNa9KBEUg1cceDzEKqI6yTMVRYhp5BqO5SQSkOnMSpO6WnNfXXKQh
 Hk4Rdmftgpzab92fpjzWvIDnS9mYQ8WWchexDbemk/QX5N19eTYXdAJmeurb6WiD5Pqg
 e19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733525735; x=1734130535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4uiql7sFnLdjODsO1+IMSzCjQKghuwLZZfDPhC2MrQo=;
 b=a0OQEPGSIlt+hS/gGrw8jXx111qkb4H49TGNSn3IeqHPNmAkpCH+enV+rTYaLTwcsz
 p6ITMfhECUtw9tsbrAkO/zNrT3g/wXW+9YeqhwZg5wkw6Dt3h7GSOtFSkOiQx6SQob4X
 YGQnMP3CkIK7wzfuI434xFG6SwRh+aUuhXTrn1mCo7U8/OkgJ3a5NLK0f8c3kAq9ZFrq
 92L/nMnGDF0cCuboEMTiLTIaUxNSd8EbX/hFKVA8sn0JUSZ45S8yOtNJLtSwrVwQGc5W
 7sk0ZYLnCKBL4PkD8Z0EIXP4PsEKs9/G/1nMDWviwnCgbiFWxeevvOaCXh1tVeMdQB6b
 VtLQ==
X-Gm-Message-State: AOJu0Yyg2Qfu694V2JdZVzLjf0BPWgOLeouOIti7IhXI5RpLrXf3vhpv
 akDPoXx5TOstxvUBx1+5oywsgA92Uh0xnk/6dibk05jzlrEdrwjjaQpcHqJvlNy5/sUr+XkyI3K
 o
X-Gm-Gg: ASbGncteMCAgELOUGc3jDc2+JkmGwDPPNsX72egZev96z92UFNDWgt3JHZydS0VdqUO
 I+VB9s9Bt12yyUJuDiFCS0SnyNuf4VT09LNFHu0CzRIV/bfLtNRRhkhajBLKmRfGJ8N02J7SXT5
 5xQ1NuiNMsapjaEdOvwpgO1iBa6VcWPqLlJ8QegJLjVBCvFmhpMoJw04ugnDEn5gayFLgAI55r6
 cKCf/3heV8W/ntQcVPKktB2Yiq4iVm2YL0Yk9Hs8llUoZ3R98PNFPJieRY8MCUrakdQG/zQzVFt
 U8apqWvxZEE+v+KE5zUj5joSdCdHg9OY/fza4g6ZhTgYkUJ8
X-Google-Smtp-Source: AGHT+IFqlH9nlrvrDTokJDjxLTQ+cUar4trkId36Zgt/BGcCJ1jmLfwl4LF0y/dj5xETQGDqqEtScA==
X-Received: by 2002:a05:6902:70a:b0:e38:9d20:2583 with SMTP id
 3f1490d57ef6-e3a0b72d31bmr5347642276.32.1733525735023; 
 Fri, 06 Dec 2024 14:55:35 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467296d4d7dsm26080871cf.34.2024.12.06.14.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:55:34 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Stefan Roese <sr@denx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alexander Gendin <agendin@matrox.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Michal Simek <michal.simek@amd.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 03/10] test/dm: add sandbox test for sysinfo_get_data
Date: Fri,  6 Dec 2024 14:54:20 -0800
Message-Id: <20241206225438.13866-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241206225438.13866-1-raymond.mao@linaro.org>
References: <20241206225438.13866-1-raymond.mao@linaro.org>
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

Adding sysinfo_get_data into sandbox ut test dm_test_sysinfo.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v3
- Initial patch.

 drivers/sysinfo/sandbox.c | 19 +++++++++++++++++++
 drivers/sysinfo/sandbox.h |  1 +
 test/dm/sysinfo.c         |  6 ++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/sysinfo/sandbox.c b/drivers/sysinfo/sandbox.c
index d39720958f0..af54fe87596 100644
--- a/drivers/sysinfo/sandbox.c
+++ b/drivers/sysinfo/sandbox.c
@@ -13,6 +13,7 @@ struct sysinfo_sandbox_priv {
 	bool called_detect;
 	int test_i1;
 	int test_i2;
+	u32 test_data[2];
 };
 
 char vacation_spots[][64] = {"R'lyeh", "Dreamlands", "Plateau of Leng",
@@ -24,6 +25,8 @@ int sysinfo_sandbox_detect(struct udevice *dev)
 
 	priv->called_detect = true;
 	priv->test_i2 = 100;
+	priv->test_data[0] = 0xabcdabcd;
+	priv->test_data[1] = 0xdeadbeef;
 
 	return 0;
 }
@@ -79,6 +82,21 @@ int sysinfo_sandbox_get_str(struct udevice *dev, int id, size_t size, char *val)
 	return -ENOENT;
 }
 
+int sysinfo_sandbox_get_data(struct udevice *dev, int id, void **buf,
+			     size_t *size)
+{
+	struct sysinfo_sandbox_priv *priv = dev_get_priv(dev);
+
+	switch (id) {
+	case DATA_TEST:
+		*buf = priv->test_data;
+		*size = sizeof(priv->test_data);
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
 static const struct udevice_id sysinfo_sandbox_ids[] = {
 	{ .compatible = "sandbox,sysinfo-sandbox" },
 	{ /* sentinel */ }
@@ -89,6 +107,7 @@ static const struct sysinfo_ops sysinfo_sandbox_ops = {
 	.get_bool = sysinfo_sandbox_get_bool,
 	.get_int = sysinfo_sandbox_get_int,
 	.get_str = sysinfo_sandbox_get_str,
+	.get_data = sysinfo_sandbox_get_data,
 };
 
 int sysinfo_sandbox_probe(struct udevice *dev)
diff --git a/drivers/sysinfo/sandbox.h b/drivers/sysinfo/sandbox.h
index a7cbac0ce18..47b7f5ef9fe 100644
--- a/drivers/sysinfo/sandbox.h
+++ b/drivers/sysinfo/sandbox.h
@@ -9,4 +9,5 @@ enum {
 	INT_TEST1,
 	INT_TEST2,
 	STR_VACATIONSPOT,
+	DATA_TEST,
 };
diff --git a/test/dm/sysinfo.c b/test/dm/sysinfo.c
index 6c0d2d7e4df..14ebe6b42e7 100644
--- a/test/dm/sysinfo.c
+++ b/test/dm/sysinfo.c
@@ -19,6 +19,9 @@ static int dm_test_sysinfo(struct unit_test_state *uts)
 	bool called_detect = false;
 	char str[64];
 	int i;
+	void *data = NULL;
+	size_t data_size = 0;
+	u32 gdata[] = {0xabcdabcd, 0xdeadbeef};
 
 	ut_assertok(sysinfo_get(&sysinfo));
 	ut_assert(sysinfo);
@@ -57,6 +60,9 @@ static int dm_test_sysinfo(struct unit_test_state *uts)
 				    str));
 	ut_assertok(strcmp(str, "Yuggoth"));
 
+	ut_assertok(sysinfo_get_data(sysinfo, DATA_TEST, &data, &data_size));
+	ut_assertok(memcmp(gdata, data, data_size));
+
 	return 0;
 }
 DM_TEST(dm_test_sysinfo, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.25.1


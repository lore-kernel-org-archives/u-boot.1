Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD21CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 20:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 778728499C;
	Thu, 18 Jun 2026 22:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="D2dMKBBG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C22E88005D; Thu, 18 Jun 2026 17:48:10 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C97098063E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EB9B83FA72
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 15:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1781797687;
 bh=VKgmi0BR83ZXyhJpK+lLvVZmdCbb65MRCDSs2eiQ7Ng=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=D2dMKBBGHPv6ZiO1xWkJOvBw3g1vrovfEEJUk27pnaVIa0T4bEIL6nyoGZhjUKrFp
 61tXb09q9r7dAwXXJPpZw/O205U4E9hfdXIqNfHjGgJ/niR6BqWpunEZCkhIrtdzXb
 TNEpx1TethJ2t4ritFTmiKPyDm3oHdmon7ayS1ctkcSmu3h985uypwYtp/mgZBbma6
 MHL8BuKloYJ54xGjTpQmY39QRBfjV7vMoFUIGstk1PHJpEFeNWOEWPUStkkIOwXeTZ
 11FgFtoo4sYDAv6mGCJCMZyeHywr4Cj0M1hcAMf25E9X+zXFtbTLHzr5tqbo3r+rJj
 HzbYE9Qf3qzjGm0fbO0a7AF/qfsFk4Rwc2UJE+r/knLSOXr/VDtGCsI/IBi/VP/6Hl
 8D7FtJyTEs0/dUeKjq1vVBVkCMRuGBS/1+CBSf25DffiM923mtX9vZBrrTQUxXhB7c
 nbl5O4mqn+iWcu7F0E2P4fdpdSTiWbP0ZobmcJVYK/nov/FsalFbiQiTbcK4N9Kwn8
 GATSzlLOjmTQKkw/ib+QbpWAQmXQPGUcY4XvN2RHfW8ns4e9oVspHepybKsQzHNr7N
 VmfUH2L8gmxhxIv8Ap1/yiprFSOFsXacfS2FpeNSUi8PLxM3ms7AVRRaF6tGNk0Dm+
 KFTBYeTApfMN2jNlkv/RuHnI=
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8454912a507so730122b3a.2
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781797686; x=1782402486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VKgmi0BR83ZXyhJpK+lLvVZmdCbb65MRCDSs2eiQ7Ng=;
 b=FTmpOH1WuJulxtVvQNi+fd+gQZgbKbJd/JwFyMCKWdx9LNS89fwlJLuSWDRZ/4QpQu
 ku2sAnV3pmxKd8EmxEjfto26VSwLEotC6ETZSq6YbvPym2GzOt+FFlu21fda3ECmyhHy
 arAGciCFaz3r246r5tsswl3Z4ftHnpc/Fw9irEfD7crG+e95T4eTyLGR8b2KcDjOcXyY
 cBlI4VAQC/GrtZ5r/yD6Pd/iZHihrFIWcEI+jdryP4N94h7X+rkgVG8h1In0+GsmIcyJ
 x+WseihzZgQHjE4KrPyekjbPgBA2IcLzjO+saWzQRy9P11ecvU/4srYUDbL3FsZuPr/d
 Lqtw==
X-Gm-Message-State: AOJu0YzBjdgGSS0y6ph/1WYCTlIGcFyxC3eShLo31zGKRr/ZPNifNCvk
 vPKYvB7WvzXexPS8oi02RkdeRpX2tF2zCtcdnuTZ1vio3piXmeG+TMdemxXzYZtwlwqZJ/AW9Ax
 FMssrOGXPfYc2u6RnW0l5Q7XalyTHDA/CsHw9oCWXe4svYCngaZYlvXPHtTaXgygqHbHjVUPtdX
 aENNg=
X-Gm-Gg: AfdE7ckPvX39QsGVrc9355v7B5IxdxkGAG+5zHuBgidSMFxPPWgyT2AoBkRwP4/AuzM
 Z5Ag+UFYZ7LzBo7ojcGy9/VM+Ujc2Tk7XOIhdW0YrHNvof8qt4gInx++YylSGmenug5Z5Vq7rXy
 37o1j+Sd/1xonig+dPLNsj5EBq8SibnmfXOL2YeXjz+IdOXcBXr5nxmBQB4er7+NR3SypYBtQmk
 n0DJS3WCGxo1PLQunyJmyiGVYdBLQDqwKjLEBXzlUf/27ZNZGL3u/ef8UjW3cJwIJLYebKsuWPM
 P6de5B1lEf7otBRi/6CUQgNwMsEUtHulB/lB44YcmmdCguXcjgGdeSZq3hab8e/804FzgXZhfHX
 hgxWWiev/nEt5Vw4Lf918ki8fguUMiffKWXcwWc3JRrtA8+1i5npX3D8kGqa3ogJq1hVxLEkAOZ
 wFeGJt
X-Received: by 2002:a05:6a00:1d81:b0:842:5bbd:3d85 with SMTP id
 d2e1a72fcca58-8452447c9d9mr10642339b3a.19.1781797686569; 
 Thu, 18 Jun 2026 08:48:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:1d81:b0:842:5bbd:3d85 with SMTP id
 d2e1a72fcca58-8452447c9d9mr10642277b3a.19.1781797686242; 
 Thu, 18 Jun 2026 08:48:06 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b049120sm19860127b3a.55.2026.06.18.08.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 08:48:05 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/2] test: spl: check load_simple_fit() rejects an
 oversized data-size
Date: Thu, 18 Jun 2026 15:47:47 +0000
Message-ID: <20260618154750.180675-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618154750.180675-1-aristo.chen@canonical.com>
References: <20260618154750.180675-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 18 Jun 2026 22:42:13 +0200
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

Add a regression test that builds a FIT with external data, inflates
the data-size property far beyond the image and any plausible load
region, and confirms that spl_load_simple_fit() returns -EFBIG instead
of reading the declared size off the device. Without the bounds check
in load_simple_fit() this test overruns memory and crashes; with it the
load is rejected cleanly.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/image/spl_load.c | 49 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 3b6206955d3..c43c977f784 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -367,6 +367,55 @@ SPL_IMG_TEST(spl_test_image, IMX8, 0);
 SPL_IMG_TEST(spl_test_image, FIT_INTERNAL, 0);
 SPL_IMG_TEST(spl_test_image, FIT_EXTERNAL, 0);
 
+/*
+ * A FIT image's data-size property is not covered by the configuration
+ * signature, so it is untrusted input. load_simple_fit() must reject a
+ * data-size larger than the destination rather than overrun it, because the
+ * device read happens before the image hash is verified.
+ */
+static int spl_test_fit_external_oversize(struct unit_test_state *uts)
+{
+	size_t img_size, img_data, data_size = SPL_TEST_DATA_SIZE;
+	struct spl_image_info info_write = {
+		.name = "oversize",
+		.size = data_size,
+	}, info_read = { };
+	struct spl_load_info load;
+	void *img;
+	int node;
+
+	if (!image_supported(FIT_EXTERNAL))
+		return -EAGAIN;
+
+	img_size = create_image(NULL, FIT_EXTERNAL, &info_write, &img_data);
+	ut_assert(img_size);
+	img = calloc(img_size, 1);
+	ut_assertnonnull(img);
+
+	generate_data(img + img_data, data_size, "oversize");
+	ut_asserteq(img_size, create_image(img, FIT_EXTERNAL, &info_write,
+					   NULL));
+
+	/*
+	 * Inflate data-size far beyond the image buffer and any plausible
+	 * load region. Without a bounds check, load_simple_fit() reads this
+	 * many bytes off the "device" before the hash is checked.
+	 */
+	node = fdt_path_offset(img, FIT_IMAGES_PATH);
+	ut_assert(node >= 0);
+	node = fdt_first_subnode(img, node);
+	ut_assert(node >= 0);
+	ut_assertok(fdt_setprop_inplace_u32(img, node, FIT_DATA_SIZE_PROP,
+					    0x40000000));
+
+	spl_load_init(&load, spl_test_read, img, 1);
+	ut_asserteq(-EFBIG, spl_load_simple_fit(&info_read, &load, 0, img));
+
+	free(img);
+	return 0;
+}
+SPL_TEST(spl_test_fit_external_oversize, 0);
+
 /*
  * LZMA is too complex to generate on the fly, so let's use some data I put in
  * the oven^H^H^H^H compressed earlier
-- 
2.43.0


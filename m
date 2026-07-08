Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CA2C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1977084AD3;
	Wed,  8 Jul 2026 14:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="q/L5942n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA548843B6; Wed,  8 Jul 2026 12:35:36 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9068838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 12:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 84CC63F16B
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 10:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1783506934;
 bh=VKgmi0BR83ZXyhJpK+lLvVZmdCbb65MRCDSs2eiQ7Ng=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=q/L5942n9chdO5tQF4ClU9zEPbtabvbr/MCLtSjO/VfiyDWscz7jogKDnN2/zmo9V
 CJJzwDi5czlthyiUwTaxoxT2L5bYw7SRuPDqVAtscCBg1qA57OxQ2wjVUTGqWLEBnd
 IN3RmHYIvUiP0E4wY/av0srDFdcbcKdO2c0CtOSbxhl5FCl9sCrmBKlXdKPrpAwCtu
 C6n5yjfPvf81mIR3za7r+ntqKfmRrxc6P8vZRdMfNuqlKxFyPABoQeGTu7QD1q3sfp
 K7K82gluAsLXxwDxhYFXHhFPcdovsTUaKb3JVBKHzk1ZpYniFW/AeF/ZtI1eHm0IKp
 dy4nEc0tBrr1/iXsMGAq2RcCLpyRs83Uj97nBv7QgcJBrANS3FR9gPnVlnGQyhlb6Q
 eEBdMYw7Qa1a3d8a7qyGfXE+zFOkMBEc/EdBJsfATw3BvVnJhT949iA8k5KsTmb2dY
 kZALriLYRfsYrtvYVVL53iBx2ZT3d5V1TuGlU8/6yT/IL1GC4L5ZrX1ykgKgh4OEwd
 X8y/InCW9/SBqFypLAzhSpPJLGnPLD7UxByaYjWUzeB8r0eIOVlmXm9W0EfZzfECSg
 jrDET5k+XSyFNXH3KFBbRUDaj7Z3YqpON0bXMNN7dApap3v2HhCsh00aJEPRw+Xw5d
 oBAtmgv2PEAoV7SwUrFSbckc=
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-388b404eae6so962357a91.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 03:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783506933; x=1784111733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VKgmi0BR83ZXyhJpK+lLvVZmdCbb65MRCDSs2eiQ7Ng=;
 b=C9WqAfIOYcppuBjZb2B7STB1zGPmwQjsgDGOvLTeMBvyQCk1UARbLmaSLG1qkVF4KG
 385DeF48xUBKqCxZ/IkgLldCtvuFmxKwypfwm3SF8vt2d1aFgG41Hy4xZQxkF3DYsiW6
 kLdhFqYrLJUCd4AR+0HlvFmZh74Px4dVtEe1Cj8qPJksIZw/DGna/sDjDSn50V87gGA+
 f4fmuQRTg01wva9o3a3wn6yha1fCb4inHFc58JuyugkqIbBS8v7XSJS6VOT7084uJhFC
 619dFoxCNGXLqIVsxjZTjx+P3R9Ont4ioPCuEHAXGuYE6aXrpeIApYu4hH7d9ofJIixZ
 c4IQ==
X-Gm-Message-State: AOJu0Yw7aK+1iYieCHMi2V/TXzCkr9UvE42cbJE8vb/8lGMbtyq9zL4H
 qwXXd99x5noQaPqXOuo7VG8PLndBcau8PeDJsdvczu0FypiYxySUfLByxSnY1IwSJMrR+vQPcFk
 TKQcVL79buvvbbkqPKft/OgWBOsw294XLvvseNyo1kyGJy86Rd0nD1O+vfSx0GtPPX9dHGAtMU9
 CU7LI=
X-Gm-Gg: AfdE7clqX7+ff1Qh3powYkV2kDsVz9PkVyBPvDqy6gtaKPEeyGGVoGXL3xPsYVDO4Lf
 dWtMDbX4CW+EOrTbbL/sM5EWgsdkwdHbZyvG4SJ93JcmfGZa4nhdDb9w9IHW9Re8Fn6huDnqUVn
 zWXJvs81rDmd7bAwKM42Gj6Sbx1aiaNPjoP6Uwh9z7rt6Zp5JLjDRbYXAgud/eQ4tnsC+QKgpfL
 8lUiNW7R2gjfUO1tmzwf/Zz548++On7Gy3HQgZEgmFgGqfh6PP5eWJXdZz1QS8DxHsZNzzmQu54
 Vl7llYGlmNkRWdUMoGs+y9Appc2aiIotXWkGwxaISnPru64JcLyQDOqWRja8HTbpyZF6lq6ju2r
 iinl6cql/Gq7Rf2rw2FAx2xI4Nru6xBpskoFH4tSH7Lr1qD0Ebbk8Dt1mDuSFfA==
X-Received: by 2002:a17:90b:180c:b0:381:c7f2:f312 with SMTP id
 98e67ed59e1d1-3893fe5b65emr2120260a91.2.1783506932662; 
 Wed, 08 Jul 2026 03:35:32 -0700 (PDT)
X-Received: by 2002:a17:90b:180c:b0:381:c7f2:f312 with SMTP id
 98e67ed59e1d1-3893fe5b65emr2120232a91.2.1783506932263; 
 Wed, 08 Jul 2026 03:35:32 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-387d12fcd99sm2563896a91.2.2026.07.08.03.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 03:35:31 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] test: spl: check load_simple_fit() rejects an
 oversized data-size
Date: Wed,  8 Jul 2026 10:34:49 +0000
Message-ID: <20260708103452.49277-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708103452.49277-1-aristo.chen@canonical.com>
References: <20260618154750.180675-1-aristo.chen@canonical.com>
 <20260708103452.49277-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Jul 2026 14:40:34 +0200
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


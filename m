Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0688DCCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 15:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7042783DB3;
	Mon,  6 Oct 2025 17:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z3JbIeAE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FBEC83DCA; Mon,  6 Oct 2025 17:31:35 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A91083DA7
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 17:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e3af7889fso31488175e9.2
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759764692; x=1760369492; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m0Yh6QBMLmUELFpLv36yR4P5bTfS+DKtNLcEgCbujcE=;
 b=Z3JbIeAEnFMfV8oXT/5L5byqoOHW6FqttIp+sooccLMpZV8gioBNi74J/hqe+rlN3S
 04gp6o34gIhqJpQ62OXwRrTE2V3SqQvnjBekNMYGU7ebr3QNhFqj5uWPdsPB2BJ3A95I
 HZINtnojsDysWr9N4qylI3trBxr7FIJmXW136fl83KiAdJlJO4S0KhhPXEk2dOxmYqnp
 4ssdGDv7gO2ggOV9KfqbrULRM8qBgehRD2KNTsm7GSgR+DuoMjcuwm7yKZT6ppW7afb7
 G7sDrSttiJyEtKomVEZCLriKF7bkRVPtiIe18kcQ0twNB21j6+UmlKjGRH7EBLyoS6qS
 G+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759764692; x=1760369492;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m0Yh6QBMLmUELFpLv36yR4P5bTfS+DKtNLcEgCbujcE=;
 b=k3eCPlj4lZUIqbHneuF4oIpLQLklrjP3lsvc7fWfKmSgvD20o3dZ1JSE2QWRpoZrmP
 OPRIe/aXibZdSQsmgVHS5MxT53l4Zm92RkwnCJW+nNAS0hlDBrgJEo/ftZe6CWIZx87M
 elx8E7xg70GJheB0jKxMx6z4/TAMiSpIEHflCigS/sSMCq7ItaJn/Iy7LAoPKmtPbkp9
 bmo9IHjhL2EzpRN3liZfjW/1AQ6uU8t63nbuRawnRGMoypdRqb40pbqK9xJNpE6KqZ6y
 MWQedwqIO6yqs7QvizK/1I4lU183MSZwwksSR6VxbLUZcSoyhrf5zbAWDWoUCsy25zB+
 xjzg==
X-Gm-Message-State: AOJu0Yw2Jrf9ub89KuUcwMBPhSmLBJsFA7HJa+CD+XkX3/ORN641PW8z
 BjrpCJx7AWfqJbKYSrlp853Z2NjI26fl1/6a2Utqm1mRS80leFMPGPxy0+NSYmGmb3U=
X-Gm-Gg: ASbGncsBwpPyW7FYbcChrkH/u4fpfHj+N90xdhIhBJ7bmdwokyayBKz50zZitRJ5e2C
 zhBvg5BdiE2a9nAhVjoTKwyU2UtuzNE5usdprYGiBZaXLefVBbGotyZ5l0HokUl+PjIN2muxjBr
 YPEzn1hM2UWb45X5zY2LFR9NOHaIFzNvCXIA2YP8yoh/XDTHRCnJTiOULzGXgk/9HVRgtOyJCsI
 Va9lHdqKjQr8IXLrWdSQTevD7sAYdvsaNXgNM7F27FOWl5gIM/MXdR0sEzkl3Qx+mvas/kuc0O4
 STC76eJ54SgZWahEHmHhE0vE0lkSkQSvFM1OlV2NbqUTC24SQwwlSImQhV34H/C19z54tTVYrgu
 bjG3V7JO+eOxwEaZjrhBmsC4hFJMTHBM8MlL9tCMXZGJXbZpual5dMXOz+qQJokS73Z+Dd0awGq
 30xQ==
X-Google-Smtp-Source: AGHT+IEGzA9xxW8udad6YCajX+lfV8qLKrAUjzh63cxf5DMYs1/RjJ8F/QE16EK4wWV9CEv41d3REA==
X-Received: by 2002:a05:600c:698c:b0:46e:36f8:1eb7 with SMTP id
 5b1f17b1804b1-46e71124219mr88423525e9.10.1759764692004; 
 Mon, 06 Oct 2025 08:31:32 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:d8c:ebdc:373e:b4a0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e7234e58asm161112825e9.7.2025.10.06.08.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 08:31:31 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 06 Oct 2025 16:31:31 +0100
Subject: [PATCH RESEND] ufs: ti-j721e: Correct error detection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-ufs_ti-v1-1-f37bf96d3ade@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

In ti_j721e_ufs_probe there is a call to clk_get_rate but the code after
that attempts to detect an error from that call incorrectly uses
IS_ERR_VALUE.  Instead the test should just be for regular error codes.
The call returns an unsigned long so that needs to be cast to a signed type
first of all.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/ufs/ti-j721e-ufs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/ti-j721e-ufs.c b/drivers/ufs/ti-j721e-ufs.c
index c5c08610ffd0422c9cf9d8e85b0396e6102cb29a..d50918912b2168db4e00c3cac0a9c54872a76602 100644
--- a/drivers/ufs/ti-j721e-ufs.c
+++ b/drivers/ufs/ti-j721e-ufs.c
@@ -17,7 +17,7 @@
 static int ti_j721e_ufs_probe(struct udevice *dev)
 {
 	void __iomem *base;
-	unsigned int clock;
+	unsigned long clock;
 	struct clk clk;
 	u32 reg = 0;
 	int ret;
@@ -29,9 +29,9 @@ static int ti_j721e_ufs_probe(struct udevice *dev)
 	}
 
 	clock = clk_get_rate(&clk);
-	if (IS_ERR_VALUE(clock)) {
+	if ((long)clock < 0) {
 		dev_err(dev, "failed to get rate\n");
-		return ret;
+		return clock;
 	}
 
 	base = dev_remap_addr_index(dev, 0);

---
base-commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
change-id: 20250813-ufs_ti-dd699eb6524e

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>


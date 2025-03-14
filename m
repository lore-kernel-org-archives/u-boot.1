Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3129C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4163581E67;
	Fri, 14 Mar 2025 17:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f+SOU+cH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC14081E06; Fri, 14 Mar 2025 17:10:13 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6948481DF6
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:10:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso21746975e9.3
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741968611; x=1742573411; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RYaEkdklrHuyHTUKVW2PrUFP5rOcqczCKRkflSTVPCs=;
 b=f+SOU+cHSpSPQ7uNuhiDISoDpi3zkxr8EADWciS4l3mZzh7GkDar8BNrR0a8m8vHDX
 ufmKiAzSw2+qt1ZO3clqPaqs1fOltOLrTD3NsTzbDfOmxZp+BDaLFoMfT0a3kglu01M+
 7G1UNymJbu0ukAx3O0j/WIl9p0hIeKsbgtsrwQAWT6wfPPMxefW6ozzF/A1BpqunU50k
 ZSfueE5XaJLJaoR5mGu3MDLvGfRRtRwDr40YkqQHUNBDaxMoN6BKwwsl+X8adxHyuFFX
 p9aOG6+lnBBSDFfu3sCTDJToRDexxQnoBAQ5Q2cjrXua8BfVsU+u33Qh9229Mz5OBX1j
 7c6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741968611; x=1742573411;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RYaEkdklrHuyHTUKVW2PrUFP5rOcqczCKRkflSTVPCs=;
 b=dxoo8czFe384lWJpzss8OEh7peAx5NuYsB1IJV3wkzyg1dAt4EJwfIKK0Shyy+/l6e
 FjTHLAEd4AfFZ7cW6qrHdfRBGyIRBLevJU2H9SG7WBCgkqIUNYpiSPcYCq3yO14ma4Vk
 uqiOi88Na+Cth0IU9jVcHMDAdxq1chyD/xJ21vMTs2UWxJrXaSwOJW1eTKZWNmRTj5z1
 duTrqt1Aw8Qqi5p/6ka/OvWjm2swFg4nJEx4zYauBwy2on8WWvOhXr8k4YF9zxTJuZGq
 bKSB3KP7IqMphNj80dzLnBK9rhDUSFQZZJq3d9IHzXMZLuZUWllmR0kv28VFzmllicye
 GsqA==
X-Gm-Message-State: AOJu0YwKyVqUHcXOFaXoXDv3X4mzK2s+9WanhUJzZvQ83e58RPrFmYR3
 J5Wtzg+XUODGV5OWtuF3noXBfXvZm9xmWsrdfksUY+No/OrajCS9hwz7FYom9nk=
X-Gm-Gg: ASbGncvBftwgi8S31Dx0CKX2gZ6O5YhkzYvEPIXAQpBaDiYUFeCMHbnnGL6QHKP3nxK
 wtyz3ZeJDLe1Tvcl1GP2e5FjLAuzTiZUURDk61EzcxPT8zZNRtr/EFoV9SjDD1xTBgaQ6Q8cxdC
 VgTh1VldeJYBhh1IXNIPSQG73LGZBtzrJWle8a4ZCgaO2Jh4bUX6acWa5BteryMsUEOYlaCoYZ3
 HZZcfkClgWiXHi3gFQlcZ7AWIIPSPO1AxL0JW9fOr5X/FdlnxrM/OAMZwNFsKy5X7V0zGyhOKr2
 1KFOUkDlZAnfB9M4c1102qTOLzGEGbuoESq/Ph2dXN6lwM0cMY7n6a8vfxz5
X-Google-Smtp-Source: AGHT+IEMfrp8wsZOXrE/soYS9n59BR1E6anKs7wo9ZkvZagfRuGn/5bvWTahMZvjzQ5TphgMwyCe0g==
X-Received: by 2002:a05:600c:4708:b0:43c:f184:2e16 with SMTP id
 5b1f17b1804b1-43d1ec72502mr45946825e9.5.1741968610836; 
 Fri, 14 Mar 2025 09:10:10 -0700 (PDT)
Received: from toyger.powerhub ([2a0a:ef40:1d11:ab01:2b81:563b:c694:c380])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fdda29esm22035015e9.7.2025.03.14.09.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:10:09 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 14 Mar 2025 16:09:44 +0000
Subject: [PATCH 1/3] i2c: geni: fix error message wording in clk_disable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-geni-load-fw-v1-1-587f25f2812f@linaro.org>
References: <20250314-geni-load-fw-v1-0-587f25f2812f@linaro.org>
In-Reply-To: <20250314-geni-load-fw-v1-0-587f25f2812f@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ViSEXF6ulexxcTGCSNBJr7i9oebVqkC6IUyOhAzuwc8=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn1FTfLbgSt1XZUKwCuQV6BbcNYo70P0B5A7xcr
 LwpHUtlzVqJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ9RU3wAKCRAFgzErGV9k
 tld3D/9Fl0bUwCdw4ttQv0Lsa0TawinLCpRmsYeFJsS3d0V+mPOvFk+p7XfeVvrnZ3B2i6deXig
 yo2+AfQWeE9MSw0SiL5YGGZ3tzt8YeBwcJ69ONblYKBTIxGCW7m27a4jyXqlMULIgA9p2JCkW9j
 IbY2/xTUBwV0BeMDIR512vHxdAJNb89Kwj/ZGSA+MBNL5+dKwbhOSqcVDpIR5Po+1n7sE8ulc/z
 LXqLVVkb+63ePyKs+VRis2Qaron0XEkEZAZpL5A9vjPdpqY0ENOKeZ0JF2jp5eq+Hr4SFTna5JO
 /jJ6CxrjYd/LCTK43ttC6SaRxVdRxhuOGwUjNorKZepKzvYOz8DhTB4FaV/4Z4qYLjnNil5Pmah
 ZFGaGjcQ0N5WD4noEaCZZQ4155vlwugx/YtYLN88ZUmrKcm1jQVHpdnIfJXPaCtZ6nn8q5BZuSk
 YSpmBPoTToZfdnd1rIgqv6GxfvlNRGwvhNvKFMb3yM1i83n56CcA8QSBRbU/Xzj8qTbkgE08/Xw
 jHWuM1auObMlN65DLegoNfhhiq/jVhvcLlYs0BMxRXA2MJazYZScLIt1ltH5ZnDkdsT1uc1bZUd
 cJqlvDeLboBQBkXAvGiRY93MuexPwaHV97vLCk6TRLyEScuqtB7QuxMdif8ujN/Q9D5FBqAKPXX
 YZ4pjkr0RyCADOA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Correct the error messages so they accurately describe that we failed to
disable the clocks, not to enable them.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/i2c/geni_i2c.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
index eabf5c76c21c2bc12c80dbb9fb498a0080928248..4eb41ba852f7790ca646c8ba38f29fdb727fa804 100644
--- a/drivers/i2c/geni_i2c.c
+++ b/drivers/i2c/geni_i2c.c
@@ -330,17 +330,15 @@ static int geni_i2c_disable_clocks(struct udevice *dev, struct geni_i2c_priv *ge
 
 	if (geni->is_master_hub) {
 		ret = clk_disable(&geni->core);
 		if (ret) {
-			dev_err(dev, "clk_enable core failed %d\n", ret);
-			return ret;
+			dev_err(dev, "clk_disable core failed %d\n", ret);
 		}
 	}
 
 	ret = clk_disable(&geni->se);
 	if (ret) {
-		dev_err(dev, "clk_enable se failed %d\n", ret);
-		return ret;
+		dev_err(dev, "clk_disable se failed %d\n", ret);
 	}
 
 	return 0;
 }

-- 
2.48.1


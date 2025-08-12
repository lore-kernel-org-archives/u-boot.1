Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330F2CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 16:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD561835B6;
	Tue, 12 Aug 2025 18:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="opjCwQJo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC19B835B9; Tue, 12 Aug 2025 18:43:02 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B714383321
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 18:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-455b00339c8so37215055e9.3
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 09:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755016980; x=1755621780; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y9H5pWUeVCWeI7stVxGe0U7SvoC4MIk7Ufbe0TJgP1c=;
 b=opjCwQJoAvY+UG/15uPHnoksG4vhWkPoPy53Cio/ndMrfZNf01MuKmREyIh9OKqlCZ
 IwMaCUos/Cmd8DFkvh+671WzlFiU1LsSJCSE6524UULP4TjZVqdeYl9Wx6t0NYN1HJFS
 tGqb40qeL6EWNjHmv7AcPrIEERanoBblbk/8ilsqxQEk5weGL6UYazUE1XF92FrATm18
 S6Goos31R9oEc/3yuEXFq4aI1ltiRVE58qSzPP43FEcoRozINmwpAQqkqfE/8QtyGDhe
 /8CAZicdQ/1Fx9ejh4UVZrgwMryLyEE6zUqYRhbVoJG/Ghpig/RjXLtmkT6gjGWNU7qG
 /gSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755016980; x=1755621780;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y9H5pWUeVCWeI7stVxGe0U7SvoC4MIk7Ufbe0TJgP1c=;
 b=Jz1uWE/1PP7gbRHO0Ja6M6Y31bxSeTt1W4ykPVUQEH1jEEQLMNgeT9IBD56lFD7MTU
 YEd1wLVoE7ANZWlvLRa65c1yuusbHSo/sch3uPcYly5LN7CBb01QWDEpgYuympEJQjS4
 bH5gGiFRFe2Q6hmYGF1q7JPsfsVzE7xIuNEnAFw0fLXQ2o+niN8+PjMpThVPhcD3crRq
 o5GoB+/F/n9Lz5HTQSzjh4wfE3Hl4tDltZTQVwD2dTBiGauu+HD84cvugeBfd8HaxEn6
 7QYkHMVTHFgSE7Zo54ctWjIrR9mJHH41t4P2nsg8kWwe4RkFLJ0ZLzordCnUeoqMxSm/
 8IcQ==
X-Gm-Message-State: AOJu0Yw+XEVIF2bdo6R5krHnG954xpr/7FPn8P6dunyvgYjMQLd+0sRn
 hePOb97eJONq6vyCSG45gBWSLv1YGPx9nL3G1lHilehtl9UIGmdnxoxrCTGmGTiod7E=
X-Gm-Gg: ASbGncsy2MTtI2gX06SeQdCAnnUMQf7NSE31n1S0wzVd/N6QbNTIShlBlZlH/5VmYzs
 L5no+ocsMDbSOB546BDczJ8GvGsrH0Eu98zWLLh/c3mKrAdGc6kKR9nc6cfgei5nv7Q+0gZ4mgO
 gxjwpPlYE5NYN92o3kwHQZ/SoXa91qam56dr5W6K7/ptTxRCRKqHKN1N1AQKM64YcNAz5wrYqEz
 kKPHK5B8er3PVhclrIkb6OXFMrfTeZUBLTMv5mYuJMKg5K/+gYm9BGQip3Z3rr8OKxVwFcmnTmX
 kO/k7HaoPDh1NBImBXiyh+YYacczAaVuSVbt/9PLaSlWVy2nAUaq6cx5gNIciy1nLyDx5dQH63h
 kBX1OIml4psiQvtDlPiadgPMabwh9k8hc/NIvHakVlyqQ9gDWKD0=
X-Google-Smtp-Source: AGHT+IGRlu4lwSQdYRS4wpLY9BVO9SHk4VDqKx/6JkMQ+n4iXnTzqBkIg2RoCyJEHABz6p/e4SVBEw==
X-Received: by 2002:a05:600c:1d20:b0:459:da89:b06 with SMTP id
 5b1f17b1804b1-45a160d827bmr1135305e9.16.1755016980182; 
 Tue, 12 Aug 2025 09:43:00 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:97a2:1bc7:9f2e:6519])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e6867193sm308660685e9.6.2025.08.12.09.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 09:42:59 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 12 Aug 2025 17:42:59 +0100
Subject: [PATCH] spi: fspi: Logical or used instead of logical and
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-nxp_fspi-v1-1-4191caad372b@linaro.org>
X-B4-Tracking: v=1; b=H4sIABJvm2gC/x2NQQqDMBBFryKzNpCkjVqvUoqMOupspiEjJSDe3
 djl+7zPO0ApMSn01QGJfqz8lQKurmDaUFYyPBcGb32wnfNGchwWjWwCPiy6ZxtezQxFH1HJjAl
 l2u6DUN7vOSZaOP8L7895XsM8nMBxAAAA
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In erratum_err050568 the test for apllicability uses logical or to check
multiple chip IDs but this means the test will always evaluate to true
as at least 1 term will always be true. Logical and should have been
used so that the expression evaluates to true if all terms are true
which would mean that no chip ID of interest was in use.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/spi/nxp_fspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/nxp_fspi.c b/drivers/spi/nxp_fspi.c
index 6d97b8eefc9..853d666b019 100644
--- a/drivers/spi/nxp_fspi.c
+++ b/drivers/spi/nxp_fspi.c
@@ -846,9 +846,9 @@ static void erratum_err050568(struct nxp_fspi *f)
 
 	/* Check for LS1028A variants */
 	svr = SVR_SOC_VER(get_svr());
-	if (svr != SVR_LS1017A ||
-	    svr != SVR_LS1018A ||
-	    svr != SVR_LS1027A ||
+	if (svr != SVR_LS1017A &&
+	    svr != SVR_LS1018A &&
+	    svr != SVR_LS1027A &&
 	    svr != SVR_LS1028A) {
 		dev_dbg(f->dev, "Errata applicable only for LS1028A variants\n");
 		return;

---
base-commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
change-id: 20250812-nxp_fspi-5a30a147596d

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>


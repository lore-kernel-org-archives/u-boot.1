Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9976FFD3774
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 16:36:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73BCA8412C;
	Wed, 25 Feb 2026 17:21:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Fp2E0My0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CA0084132; Wed, 25 Feb 2026 17:21:04 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26C3D84120
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:19:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48375f1defeso48149815e9.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1772036339; x=1772641139;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r6tAXVQt7ZycmjS5oFVFmcoK4X7swFXBbYv+fE4pNxo=;
 b=Fp2E0My0Er1OYYEAjcykDYpqftiG2Hly1HmltBwvoqLT1DNfeYgCOoFc+wYP7YW+F9
 HkYalxxbyuRHu9xKMWZGG0G/e32CR3bUtoHacOQfhaFgR1p/ASGkF98OcjTnwpNLPV2m
 2OIAfXIwonnr8vwIi4d9H9YeNq512YyqQxHs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772036339; x=1772641139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r6tAXVQt7ZycmjS5oFVFmcoK4X7swFXBbYv+fE4pNxo=;
 b=P94BIUNM0JpfqDgF3zKd39ZYW2DTSF3EDAKHAy8RSmF4Z4cGLXe3VvOhDJ0bnQt2+u
 Jq9bExaMuQYI4ywITVgXwwhTN7cAolaBx32WNwEl3Hh/VUJdUVRSsOUPI8Jg3tXRGysM
 D/IaFrjgHSbDi6XhH9DOOQo8BoDoWqwsrGsh5B3lqC/VhoBJNmitDMpDI3+lnDTbKaO3
 xK+/yegit17G4vyvhT9Uws6RBLZlsaptBqjqyKhYgbY/avwkxqTX5hrACixuOFuB85Y4
 VufmShdQHCgO4giOjKRkF8Fib+YPXG2+yXaAV3d3WVW8Cw/iDXARyse543WChkL+B0V7
 fq1Q==
X-Gm-Message-State: AOJu0YxShmvyX0B2uqneptwJCqpV1iiq+57Eq0uSSL+4Y5hmLc61lZov
 6GUIiG8LM+D9KmQVNNSUOT/xfdN+t5l78bQMhUeTpXD6DAYxzjI0zXgtNksisvefEkk7Su2BdYn
 KMIwW
X-Gm-Gg: ATEYQzxunznJ6xiOj2CZIUTo6BMW5KNladoU943U+21jd0/e5XvlPIrg7EmlMPusPNr
 MevyVUFKuBbVBjwq0EgOJIiIp6SMPSXzc9X+2dDG1oOQULX4ykr+cpw661LhVEnpBEgbuTyD9/G
 2WZIVl0GZw9DOGJ9QLGZwWG7hvngXnDRoUKU9Md23WdjHdvfjvxO7vgFCJ+hL9lfS4yGInBIkMY
 bYPEoD4HQAePwg3cG5jfPJYPunF0GRm8QapsDQaGOP6Cj1x2fwN7OG9fu4GOfX6GqDkju6yqHb5
 EGivsiYHukb2+SkKrn+DzeZd6gSSWwo/0CiEphKeyrmpS8qeDVPoThpGGJNF0+2u6iX0yyxDlTq
 9JV9iTTtoVADSHXORVAE8dby4hNQTI7CL5xRHY+akSBXony2qjlihuELfOtVSKjajflNU/xyxdo
 vobDwXHEHRJRwLBRp4zV+2uhVXSFGLyn+QkW7zKiRxCPRnagWFwtMlGc95XWdvk/b+XEBWMWeie
 Bo5vyym/cRnc4cqd6TyNzvNICSguJ7JuYtrrtFZ0ehXmXYa
X-Received: by 2002:a05:600c:19c9:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-483a963d2d9mr247390685e9.30.1772036339263; 
 Wed, 25 Feb 2026 08:18:59 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.43.111])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f19f5sm186562265e9.1.2026.02.25.08.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:18:58 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <simon.glass@canonical.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/9] spi: sandbox_spi: support wordlen setup
Date: Wed, 25 Feb 2026 17:16:53 +0100
Message-ID: <20260225161851.2475274-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
References: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
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

The driver currently ignores the word length configuration. Implement
the set_wordlen operation to store and track the current word length.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v3:
- Add Reviewed-by tag of Simon Glass
- Store wordlen in struct spi_slave data instead of driver private
  data.

 drivers/spi/sandbox_spi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/sandbox_spi.c b/drivers/spi/sandbox_spi.c
index 4cc016138b11..7c237ac8d371 100644
--- a/drivers/spi/sandbox_spi.c
+++ b/drivers/spi/sandbox_spi.c
@@ -61,6 +61,15 @@ uint sandbox_spi_get_mode(struct udevice *dev)
 	return priv->mode;
 }
 
+static int sandbox_spi_set_wordlen(struct udevice *dev, unsigned int wordlen)
+{
+	struct spi_slave *slave = dev_get_parent_priv(dev);
+
+	slave->wordlen = wordlen;
+
+	return 0;
+}
+
 static int sandbox_spi_xfer(struct udevice *slave, unsigned int bitlen,
 			    const void *dout, void *din, unsigned long flags)
 {
@@ -158,6 +167,7 @@ static const struct dm_spi_ops sandbox_spi_ops = {
 	.set_mode	= sandbox_spi_set_mode,
 	.cs_info	= sandbox_cs_info,
 	.get_mmap	= sandbox_spi_get_mmap,
+	.set_wordlen	= sandbox_spi_set_wordlen,
 };
 
 static const struct udevice_id sandbox_spi_ids[] = {
-- 
2.43.0


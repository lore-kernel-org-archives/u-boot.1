Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61879CF58DD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AED228942D;
	Fri, 20 Sep 2024 10:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TUZop3Hc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A4EF89382; Fri, 20 Sep 2024 10:13:30 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D488389382
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c44e1cde53so2088194a12.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726820000; x=1727424800; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=foPS6tB3S6Bm4uKwaA2l/pXxZfKHgADzo5rV+ccL1nQ=;
 b=TUZop3Hc2kVOyU2xMKrQGOP5YwY2N7OKmOTXjT3mbISG/5nvsZB58sJ0JwqCEg99xX
 51q97sAm7clixuj+No44DLe0T/SZWsgmfgDMhRg+wMM4Ai8X159AuRHinKOBMcecAJjC
 Rf2wGcAAzI9FWFdXB5Wd0v5RBtp1vmOb1RWAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726820000; x=1727424800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=foPS6tB3S6Bm4uKwaA2l/pXxZfKHgADzo5rV+ccL1nQ=;
 b=MDCl1pPnRTqKCEWK092gaubiRdXdyFpbDX2gX8Jf3K7ucHoQbIa3B0sMREbZfHb8Vv
 5Du2QfqOJl8mRbAqB0/txTtNM64N38CCd7zChicJhjlVvjEiGxgHMbNsU87Mm+qAp/Y3
 1kDCg9qXS6T1RuAzT4tbfKLNxQk/rbyJHPhdY2+5Fkp2d+iFb/m/6FQnMO94AMjmQx5N
 UDAm/YaRhdBUtfK4H/SwxxAwW6nEhugF+lcJLfhXoLcCDDOTPMOI15zhJYCwxGMuy9Zt
 6JAfq7fJCe+Rekhyavb1XUjYZ/JQLAStxu9Izh+Z1aJg1jSRyYDdHUJSMv2BwM6Q6Lyr
 O4Zg==
X-Gm-Message-State: AOJu0YzCBod5LdBuKUHQDX99m+CpD7Ywrqy2D00ILgnkRNIJw0KxzHoU
 45zFvfjazftreF0936W/Oh1fKTDdBMqccdVo7AIt4ORm7kARNBDP28c+kdvU/Ns+EnxDgBIPyHc
 QDQii
X-Google-Smtp-Source: AGHT+IEqwogJEFRpcivNeXITMPHBcv6y0iCj0GtPMYaFjo7nGUsEGVlCvx0tmy07Hp0lS37W8ow0VA==
X-Received: by 2002:a05:6402:51c9:b0:5c4:1320:e5a3 with SMTP id
 4fb4d7f45d1cf-5c464a3f71emr1146298a12.16.1726819999906; 
 Fri, 20 Sep 2024 01:13:19 -0700 (PDT)
Received: from chromium.org ([83.68.141.146]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bc88cf7sm6804447a12.90.2024.09.20.01.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:13:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 01/18] image: Add a prototype for fit_image_get_phase()
Date: Fri, 20 Sep 2024 10:12:40 +0200
Message-ID: <20240920081309.140426-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920081309.140426-1-sjg@chromium.org>
References: <20240920081309.140426-1-sjg@chromium.org>
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

This function exists but is not exported. Add a prototype so it can be
used elsewhere.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/image.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/image.h b/include/image.h
index c52fced9b40..9da55fe23c2 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1171,6 +1171,18 @@ int fit_image_get_data_size_unciphered(const void *fit, int noffset,
 int fit_image_get_data_and_size(const void *fit, int noffset,
 				const void **data, size_t *size);
 
+/**
+ * fit_image_get_phase() - Get the phase from a FIT image
+ *
+ * @fit: FIT to read from
+ * @offset: offset node to read
+ * @phasep: Returns phase, if any
+ * Return: 0 if read OK and *phasep is value, -ENOENT if there was no phase
+ * property in the node, other -ve value on other error
+ */
+int fit_image_get_phase(const void *fit, int offset,
+			enum image_phase_t *phasep);
+
 /**
  * fit_get_data_node() - Get verified image data for an image
  * @fit: Pointer to the FIT format image header
-- 
2.43.0


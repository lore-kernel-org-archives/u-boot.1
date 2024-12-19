Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0D1E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 18:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B5F28022B;
	Thu, 19 Dec 2024 19:29:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nworAGHo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7A758033A; Thu, 19 Dec 2024 19:29:22 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 787CF8022B
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:29:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-844e6d1283aso76002039f.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734632958; x=1735237758; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IyZuMFoqZLhbMZy8ftr92p+WXS8xDpo1+GTJBnHgM8k=;
 b=nworAGHoEQyAitH6mjch6CgcV/D2TIDevr0lEmzUoW8ocMtgu1L1/yVsMzJd88ny38
 ynX5GIPLytpSYTZnQTQ7WUQRkJpOZKik+MY41R4q0bX3bdTI0DRRg0O6pKAFSb2aVyvb
 BdCB79ND3bGbKPtTIs0/Q8sa/kU7ES5mMHkhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632958; x=1735237758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IyZuMFoqZLhbMZy8ftr92p+WXS8xDpo1+GTJBnHgM8k=;
 b=ZCdQm2ih+mkCmlZRCj5cCqdnPf4QvOlx0McPGYohaTVIMRrNbRmpjzLVY5sQA3FiD6
 YJzazdL1quzHiCStKtG3yf7ODnT1cE57BYkQfe9Kyz7qEniOYCXg0pPmTqeozR9Q+qJJ
 BC9BixlTCnAODsDuKEuzAycBPPKe9Zi9oAHkHrfOYuuWZ4eU5EvxHqLhzXsngtbsrlkO
 30dQGhDdkgD0OKzX+4KnoBhgq4O+VssJlaFZklb1YoiPVgaQ9mJImdcCZAF2XqMEAhL2
 LzuYazejDUzJuTIOvfEW+TP/TCEWduKw630vBzKvVcAjzhbsKJMCXsIzvQUlb+GiOXFS
 0WKA==
X-Gm-Message-State: AOJu0YxLRH3goxG9NorPX6IBIebLUOrooZ35nwxfXBeFnIQJgtXNyKQ3
 xM10WpSkNC1QZbB9aVCtp5HMjW77/iyslJruCHD1xwbp97/652FfKnmOUkopZ85Xn+R2bciz2aM
 =
X-Gm-Gg: ASbGncsVzWBakBdUvLuyadN5ZVf0A8YS0ClGSsEYHRXEf7/zmljMqtur2WmQfdJToVO
 UxdGqTuamC1JFtECN568GORY6+1TgmNnGHOGrFIBQQzudty7XIOtM7P1x43QVd0TPkB00ZXegDb
 KGS4kx9yDg1IZhJ+WkgtM4OO6tHJ5uD9JPmrHlMx3lK6nlTkuSA8w1wdUayl0woUxzOaIcdKnMZ
 E+8OBaOl50dHXbIbgN5/kEKx/qwYH/zXy7X974HVk43LY2VU0vaD9IPjgwEr7LW2FbmeGCeeTQh
 PkJvkd3ok1PqucOajQ==
X-Google-Smtp-Source: AGHT+IEIhcyfS74Cgkf8u162lx3Zt5KFbs86GQGgy+aGTSt0eaz8Xy/MqxgXB3drSFaKIfd0TEj7Fg==
X-Received: by 2002:a05:6e02:1c44:b0:3a7:c563:d3ad with SMTP id
 e9e14a558f8ab-3c03093ec46mr30083555ab.11.1734632958629; 
 Thu, 19 Dec 2024 10:29:18 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68bf676c6sm393655173.50.2024.12.19.10.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:29:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 02/19] image: Add a prototype for fit_image_get_phase()
Date: Thu, 19 Dec 2024 11:28:50 -0700
Message-Id: <20241219182907.2609704-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219182907.2609704-1-sjg@chromium.org>
References: <20241219182907.2609704-1-sjg@chromium.org>
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
index 9be5acd8158..bb15ef69871 100644
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
2.34.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1566C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1DDA877C1;
	Sun, 12 Nov 2023 01:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="COr9uU5P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55A9B870E6; Sun, 12 Nov 2023 01:45:56 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD6A18709F
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:45:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7a98fdeaac7so139078739f.1
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699749946; x=1700354746; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Av7sBy3aAHZnwIt3aobUSd2ret/OUMuUX7v8Lc3WR0=;
 b=COr9uU5P0f9kBSY/shtFl4fPWx3T80vL+QuZy7SVEjfEenjO6acAAJaF1m8oqrrOnN
 Hr09qKIronaKLrSD5OkG8RJA9XsitMxA+6WsPEJiPW/RxYMIwZITb0AplNswAqaVMLYE
 uezB/lWdbr5+vP722GDQLGNnC1u//E2NDKCQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699749946; x=1700354746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Av7sBy3aAHZnwIt3aobUSd2ret/OUMuUX7v8Lc3WR0=;
 b=c7xX/TBLanizNqaLBDk6mZAOEUiT5UExqp14mgcmbbufYMhLjqFqWvtEQmUgg7SBzf
 LPlwF19qJv8u4Vmwrp//QbMoQDlu5BRCyR6DqsCa+kPWeusULu7M10eCnHUsP56hJF3o
 N7JDYh3PrZfCxVmWpmYedzM2ecBmQIqwbBiK/P7em2JhHxBLJCmd1C6Y40NyUocY2FMF
 jqiXHcm+3bIYRZPe1kxFKrRbv3jfV+FCAhzUidGydKr1KKLppC5fT2DAdoUiYtGe4eeY
 mECZL2ZGlq8NMt4dOnFYtZbPfwrsCHK7sjsn6jFho5tq+S9zWVKxkM4sf8ABvTkypF01
 z+SQ==
X-Gm-Message-State: AOJu0Yy2i1u2hIUlLM8Ld+TgZAB3HIP9RBTuKxn/6stAlfxG87Lrjcu0
 AIR++UYAvf3oFZ8ZOhVe7NgNEtKp5hFPZ+rfNGulAw==
X-Google-Smtp-Source: AGHT+IEfzgivPJVoA1tjW6fTJHq7FF/6PSMAmNcKm1tXy2q7/A+/wJD8YtM67koNoL+GTLLRdiaNqA==
X-Received: by 2002:a6b:d903:0:b0:7a6:9f67:6085 with SMTP id
 r3-20020a6bd903000000b007a69f676085mr4242266ioc.8.1699749946476; 
 Sat, 11 Nov 2023 16:45:46 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a5ec111000000b00785cfdd968bsm765277iol.5.2023.11.11.16.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:45:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 4/4] image: Correct load_bug typo
Date: Sat, 11 Nov 2023 17:45:35 -0700
Message-ID: <20231111174533.v2.4.I33852d11a04a125d8a4fd7938a8eb989454e7fd3@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112004539.80982-1-sjg@chromium.org>
References: <20231112004539.80982-1-sjg@chromium.org>
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

Correct a typo in the function comment for image_decomp().

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add a 'success' case to the cover letter

 include/image.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/image.h b/include/image.h
index 2e3cf839ee36..0fe67852c563 100644
--- a/include/image.h
+++ b/include/image.h
@@ -936,7 +936,7 @@ int image_decomp_type(const unsigned char *buf, ulong len);
  * @load:	Destination load address in U-Boot memory
  * @image_start Image start address (where we are decompressing from)
  * @type:	OS type (IH_OS_...)
- * @load_bug:	Place to decompress to
+ * @load_buf:	Place to decompress to
  * @image_buf:	Address to decompress from
  * @image_len:	Number of bytes in @image_buf to decompress
  * @unc_len:	Available space for decompression
-- 
2.42.0.869.gea05f2083d-goog


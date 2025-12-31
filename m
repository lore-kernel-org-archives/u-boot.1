Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98114EE645E
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 19:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF56284172;
	Wed, 31 Dec 2025 20:11:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Uj/To5wR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72FE284131; Wed, 31 Dec 2025 20:11:15 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BFCE84105
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 20:11:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E6FB93FCEA
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 19:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767208272;
 bh=xswHFqilHHbyuxCItkI5MhXh+w9ExGMFeb7zWdsQBAs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Uj/To5wRL2iwCbAeYkDX4CfV4r0S8nbXUZBfa86Sli/1ZaRKohufk8D6N4USjzwIC
 DVVGNgDSrtxCvNE/976/dFn8qqAkazhaHmKUhFz7JomAWwBB5FJcVIiSWw4d/4uVmW
 hzauEOqGRTvIFqIuIxvQtmnEreS7Fpt/7GnYgMqO5rnHCyo1WqYDJgWa8x7D6eKuKx
 mo1xkJTshtHlyD/RKlW8g1XF5WWDoqBoeiQyCo97AaMjK4MW5kg/ItSPuLN8IoAy9M
 komB5QSzMSbR+qVtzoTauvqkOlQAveZg2L+WVrJ0tkjUkl5sF3fmS6LU9fq7IqNP5o
 BNqqoOdOrNjBJKiPoopkNukvfoRLfqBR9gjaC1cq/KMk1jvklIkVve0P9GA3UzDOjs
 oewbFJV9U3FbXocLiTZKxQhYGP1bXTVl+CSIcUrLwzX67ECkPDHj1D67g2Rv0lN3zt
 5oMydHLQ7Jm+B8RHW3dKtYLP2KZRrZ/+Stq5i17LAde5d+YZWayBYwi/shrVfiwyiE
 de+6seTSMyHs+oS22BFFPpbfRFgQ/iMoTmkwgbK5ep+AL0/ynYgTCSxlldOl7AiZzm
 CVsekRTX0ppjMGCuJh78KSTbCOkke3jr2CUrhbtv82/Vf3f3Rf4KnTOjlox7GRYbJc
 wfbDtJmeYzRdYyh1dOs859dA=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47918084ac1so91738085e9.2
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 11:11:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767208272; x=1767813072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xswHFqilHHbyuxCItkI5MhXh+w9ExGMFeb7zWdsQBAs=;
 b=re3BtqQmPOL+fAnkjDBFdNGPohOpsT67n75nVCSlpOebi8DIpabVfdpcqL79aoivV4
 QuGYV7Y2Y9gUr4Znl1HrVA92/GZxajXsArLEzyAFxK42O6pdQviNq8wvLu2klRX6O6p5
 XBb+sqMDyyGqcLnslf/OZU14ifftz3YbCll9n6o4vRGnJkVkS28crn2zN6WbcHvyZ1Co
 QlVuzs9pdjldPLU7y0ElanbYyWRjwgna6dhuM6kdsj+Ak7vCYKaw7br3gNYWq6wS8zTT
 9W2apkmt9YRXWwCvF6JB/Pu9nXQ4N96QE+wXtZhuuxHPBjD5TtjFJqEjtMGR+5Xa/3uq
 kcDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXza3QnaFZCsYeKfFcklsQA9aouHyBpPOIc5FAsTw/sRWUjEQsLSbcU5AcU5v+TfnfpFk6lazY=@lists.denx.de
X-Gm-Message-State: AOJu0YxLzBySuiECGV9Nt7RmYnOb5NF/4zXbaZI7gnPCA0LClO3Y2vst
 2W8D5ilBYHFjAnTnH4mhltWIP7CyynX5p6x6qKQ+7CiJMJB92ch9kZmVtfXg2NkBbI5ILseRpMq
 mBIYxrxGT122x0bPJO8Gl60yA7zsA+vw2fzEsh1PT+0WssmmawcwYd3ro0MksCTXYigXPJ8A=
X-Gm-Gg: AY/fxX5jywhPzWZ5cn63zSJuBhlBTuqeoiyzJwH2Yo5PbQ6yMVzG/YZQGKGOTTlIHPn
 GEm2LbOWsemFvIKI7KcCM78bZYFXtrjqLP2FiydxEWDxUfal1f/QqjfSd9N8domAwV64b2J0kd0
 tSNR+ttoFf8lhahd98223DXT1RVziwfMsT9GIKkTKfqvzt3N2lNyZfI1PbfELnFBJWUOI0eNnOy
 pGxZOrqGSUZJKGXnx3E6oyuUKgkQYDpQ++8i+W5W/YaTapko+TzDY/49D/LvhnXHwFhICVKkCAr
 5sfuTlUbkG/f9A3aagtdLDETW9Kv/P0sjzJwrdieOAQR3qhH8cbKfLPrbzoAP5cHM1EiA2XACSI
 Dm9AbmtHjVQ0U2/WP/C6EM9BZ5T1DgZy0gduFnnPhVOwlelKES75XcUoA7D8RHBdIZb0zc74eh0
 17
X-Received: by 2002:a05:600c:4f52:b0:477:a978:3a7b with SMTP id
 5b1f17b1804b1-47d1958a5d5mr534015905e9.22.1767208272325; 
 Wed, 31 Dec 2025 11:11:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1R5qK17SXB70qWK/RjLn+Wqz6xEwIZBixrJuUFADcCOcp07myOEFw4sJ0YmHZRq8vKg1gag==
X-Received: by 2002:a05:600c:4f52:b0:477:a978:3a7b with SMTP id
 5b1f17b1804b1-47d1958a5d5mr534015595e9.22.1767208271940; 
 Wed, 31 Dec 2025 11:11:11 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be272eaf8sm701685995e9.5.2025.12.31.11.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 11:11:11 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/4] Makefile: repair CONFIG_CC_OPTIMIZE_FOR_DEBUG support
Date: Wed, 31 Dec 2025 20:10:51 +0100
Message-ID: <20251231191054.247270-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231191054.247270-1-heinrich.schuchardt@canonical.com>
References: <20251231191054.247270-1-heinrich.schuchardt@canonical.com>
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

Since commit 5f520875bdf0 ("kbuild: Bump the build system to 5.1")
CONFIG_CC_OPTIMIZE_FOR_DEBUG has no effect on the non-host code.

This patch reestablishes the prior logic to add

    -Og -Wno-maybe-uninitialized

to KBUILD_CFLAGS.

Fixes: 5f520875bdf0 ("kbuild: Bump the build system to 5.1")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 6b5c5ee019e..2a972af4906 100644
--- a/Makefile
+++ b/Makefile
@@ -869,6 +869,11 @@ endif
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 KBUILD_CFLAGS	+= -Os
+else ifdef CONFIG_CC_OPTIMIZE_FOR_DEBUG
+-KBUILD_CFLAGS  += -Og
+# Avoid false positives -Wmaybe-uninitialized
+# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=78394
+KBUILD_CFLAGS  += -Wno-maybe-uninitialized
 else
 KBUILD_CFLAGS   += -O2
 endif
-- 
2.51.0


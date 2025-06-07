Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DD1C5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 21:12:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D11A282A9E;
	Sat,  7 Jun 2025 23:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mo/NxK5y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15793811AC; Sat,  7 Jun 2025 23:12:09 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE81A82AE1
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 23:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a375888297so1955000f8f.1
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 14:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749330726; x=1749935526; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4J1fQ8n3dPO2CUqSrzTRSf1//NacAMI0QEDmdFHwgfE=;
 b=mo/NxK5yz0oXZ/jl1P9T8niuKU+4hjGso1YOrw1U/SGw90+rFS2d/fjNDF+ooSCNkp
 OQ7Xh1KY70tFZXcCo9pVgKD6asARbffhDCBzJSUedWCl1pcnMOmibQlA3LEl6z6iDSjB
 U+eWsqyudNkpIA+8/bIzEfKO0SKsUIm2KXkUVgho+zrYfbcRtTCzELcKTxLhq52JBtJU
 2uNEjocNTk+3NAE19GFB0AV+MS2wm/5THeI5nJ5oSW905tumDRMcwmhdPOhCZ2xDipvG
 fRPLud+QfmdIPkxpH34G0jnhbDqsH2J7OyBTX9rZ8t9p89QbMtUcTxWOuCa5BiQk6ciR
 NeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749330726; x=1749935526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4J1fQ8n3dPO2CUqSrzTRSf1//NacAMI0QEDmdFHwgfE=;
 b=euHjAFfj52hWp19RK+4Tgy8DPkvlymXPpSba2iLnGLIx6HVgwXJQwYb/HWoAgkoN5N
 oYPY+raLd9PKH3ZQEVkaaFBkH5mAk9ImLbXjincMNjgpEhWPhw4cLNf8LTm64MrpSzde
 50x1svskbqRLnYMvDM0khKQ5fD8/C1grgGIuWytsiCRkxjREK7erFYCcHXc4S2uWI9qF
 Ob0nUeDtX70pl1kSeyvGlsLv+jxmyj0xHB70S8RWIr24uLtcdlvqUZH06fqEiZdaDmnx
 yMqcN48zAtkcrTt5kX09nyJKsdnFmM9TUFz86dQTlc/Q6VQIV3ySdQXoh+xFc518qtE8
 q73Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs5cI/GgG02OSpn/IQ5hsQScxcNhbC7OeefNPGxQl7BYX/5IWdNgXJ+kpbE1hA2pRxooULyM8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5m8F6XzFF9Fq7EKoquxWbDuK+5hC+72gcmswSw4S1Ur82FUFW
 5+Rn63LXCcoUG/kJg2hFxpymBZp8s1wW6fbIY/xEzw9ZXuz9zagjFp2Q
X-Gm-Gg: ASbGncsixTPqY/1wetzAL1WKEPY3ZbjYDSLkH0F+PzG0WjxG59Nng8mTXpSJlb8kvKt
 Szop1vWud52jCa9Cvy39j+vOqVjLTPStMUMn42NIvhXZkMU8TSQDtOHMw8KUh0UT68mpKTCgIBN
 Z49gpazRzcZJOeUTXxAeYY8KcDoOh95soXcsG8IJ2k/5hDYqjXgO+yLtdxe6hKYyuFcjTtywb+R
 Mkmlg5Q4hL3e6CjHoolOsA+6ynjE7F6ILN9YtZTvXY3e4jnCLUzGhxPBzHnD8CqeWi8cY651HSM
 +cGnl1jFLfEXPnHrTYqpWO4PhRTal41RfM9QOwRYjSMiJM1HHRJillLvxifeVVcqOrKAUmla0dE
 MQeQIUujq/UVl9pw7Qz8LN6ELf3VHe70=
X-Google-Smtp-Source: AGHT+IFZPKzaMvTTVuJQ4glDswoV/JQKfgSZTBpDMjQ7umrh9ad3L5zlE4qelBG0wKX7CN3dKkBVbA==
X-Received: by 2002:a05:6000:310b:b0:3a3:598f:5a97 with SMTP id
 ffacd0b85a97d-3a526dcdd9cmr10105018f8f.9.1749330725995; 
 Sat, 07 Jun 2025 14:12:05 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4526e155ce7sm64368245e9.10.2025.06.07.14.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 14:12:05 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 2/5] iommu: qcom-smmu: add missing linux/bug.h header for
 WARN_ON
Date: Sat,  7 Jun 2025 23:11:18 +0200
Message-ID: <20250607211133.2005-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250607211133.2005-1-ansuelsmth@gmail.com>
References: <20250607211133.2005-1-ansuelsmth@gmail.com>
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

The WARN macro requires inclusion of linux/bug.h header. It does
currently work as bitfield.h includes it indirectly but this will
change when bitfield.h will be synced with new Linux version.

Explicitly include the header to fix future compilation error.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/iommu/qcom-hyp-smmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
index c1b95bc8b8c..2e51ce4f242 100644
--- a/drivers/iommu/qcom-hyp-smmu.c
+++ b/drivers/iommu/qcom-hyp-smmu.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <iommu.h>
 #include <linux/bitfield.h>
+#include <linux/bug.h>
 #include <linux/list.h>
 #include <linux/err.h>
 #include <lmb.h>
-- 
2.48.1


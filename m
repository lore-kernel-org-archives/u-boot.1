Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A576BC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6F1D8880E;
	Mon, 15 Jul 2024 12:08:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DHW3iEPM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2225E887FD; Mon, 15 Jul 2024 12:08:14 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC0E088753
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-59559ea9cfdso5121214a12.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038091; x=1721642891; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bcZVa+VDuJji/8aNFxPP1iBM+h15a7B0d/YaMGub7Uw=;
 b=DHW3iEPMWk3B3FigX3j65+fjOFULv6TjT21bvhUE9AQ4/bjIj1Xlqu+Hys8WUVRkrW
 CM6ieWI/uzfohF1umuGYJz3SjYXtWhAkpHZbISodGQ0IOg1Z5qvfCGbElbozn5fkUqXv
 TCiSS6IaQvxMb9Vc9AxqP6kRYYW0zlAe5da7Zsof4ZmdXHawNjc+/polCk/P9QsH7p7L
 /+oG49xUAFpyDfdmk86W3roGWz+9TpzYmFriyYrZ0Fw1HdWal/tVoVuFBazvE9+aoV4w
 4vkTOQEfu032V6HMwmMjOkfIZk87byOYanSGvPhA2xSS9hOLeoUk7P6tmNc/uqTMGSoJ
 zpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038091; x=1721642891;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bcZVa+VDuJji/8aNFxPP1iBM+h15a7B0d/YaMGub7Uw=;
 b=A1V1SqgzdnTSyOy+InhlG/ZjnQiCmNFACFJ1K2oX5lYSZycBqAIdEmiOVneU0ewrOd
 jmnp8XDRsuH5QH9rOQlxhJv2YGFE7c0ANKOX6E8lUz9H4jlQt/iRjZx7K1vj5cXmu38A
 yeNNVJGIKKouN7pgxw7ozOxY4oT6rwwcI49LyEQDBQegy259g7jq4G22FOg2F6E3hNkp
 Qn0ID3UHYJMiVdMEnHuSPbX44F4FN4xYI4t56vOcLvJqmVSXhuRfgBTI864pK8AB63yb
 khVNUyFRFDLbZV0xE7OtIwuJoK8wo+QzaGfqIeNomjFwBh/nsPLMrL1V8XrGFVHyrlxJ
 Iugg==
X-Gm-Message-State: AOJu0YzJzHJiKOzMph/anmkYv07qAHH035/QVpQZSwlC4p0QAkxPGaVD
 mUARf8bPGgNqF+gTwyM+Xbc9WUi4RSArnL4EQzG6EBzIkXBM5SwDC5qahTy7Hok=
X-Google-Smtp-Source: AGHT+IHi7d3PjDKW8DNv3Uw59Z8s8XngICHrbsYM1jXKy8TfDzQ3zrIp+TsvTk/KVfYgtM8uZQv2+A==
X-Received: by 2002:a17:907:9711:b0:a77:b0a4:7d88 with SMTP id
 a640c23a62f3a-a780b689270mr1826883166b.10.1721038091298; 
 Mon, 15 Jul 2024 03:08:11 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eb4sm198102266b.60.2024.07.15.03.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:10 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Jul 2024 12:08:01 +0200
Subject: [PATCH v6 02/24] linux/bitmap.h: add bitmap_empty helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-qcom-rpmh-v6-2-0c948a25d018@linaro.org>
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=986;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=PxfbD3T2xPQP1uXV5S6na22BOVQpSqa42vcVud4EfCI=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmlPUFr19Fc8y1LQnF9K196NjB0jt+ShmdGkyg8
 3HZeMtMcsCJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpT1BQAKCRAFgzErGV9k
 tjwBD/4wAiZ8umvoqwpJ+r1PSKZmt0UQm0PG3MJjoZRyCN/D+dh3lovxC0YAFMCySa+gxpHzcIM
 oc+Ea20B4V9J1dROfKYySKHXa8ZWIVbtN5RaO/5hfQrZXo6ZLPHkwoKkslBQq9mfS4O+v4705AH
 7GiNPxbGRTxGw6PxM3Ri7M+iw8zrIM4HnuPLM8rGNtXUzglY/oUqOS/WIXy+kfcE8i3rsxc7XYG
 rfUs3yEcq9TzKPDmJsNF+o189ZekSPT0S5s2cdODeQmF1fWJYirHZEc/GvPkP2Z19U1ER18Re7W
 O7avYYj8VmLGeSoIj4b1KWajUBfCDk4mhKtgFoG86XcMDzdrv3SuteGEa9YQgUn7o6lK1Gjt9fe
 hOu6Q5BZJnfGZCkMtRl87Y+vCJiKy69/VQYfiIPzl+D/VWtJDYiYqMKKubYpSAjg/bfsOo2L098
 wFzElQem23xwvITz/T1d7KS+U1FM4yW0bPzWT2irTv3lGJgXG3wbI0xFM2PMrUZBWGOVbCsHwc3
 7DojMb9cPRIxP1ycpO5FQ5ei3JzJCnQi8kTe+Q5lkCQ0plt4WP7huzYy4tX6B7kWzgJi25Wku8Q
 hpqlgoQwXAPyXn6N1JnT08HA7p8htSDde20M52GNVCV+JWtHRbCmoMBrR3SGAem0fUZ4ue55C7V
 VoQOQlPRWp4Ey9g==
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

Import this function from Linux as of 6.10-rc6

Reviewed-by: Tom Rini <trini@konsulko.com>
Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/linux/bitmap.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 0a8503af9f14..40ca2212cb40 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -195,8 +195,16 @@ static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 		memset(dst, 0xff, len);
 	}
 }
 
+static inline bool bitmap_empty(const unsigned long *src, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return !(*src & BITMAP_LAST_WORD_MASK(nbits));
+
+	return find_first_bit(src, nbits) == nbits;
+}
+
 static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
 			     const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))

-- 
2.45.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151C8C04FF8
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 15:04:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5499A87CF2;
	Mon, 15 Apr 2024 17:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d3E1HwBu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93D558814A; Mon, 15 Apr 2024 17:03:49 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 893FC87CF2
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 17:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d895e2c6efso42316531fa.0
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713193422; x=1713798222; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h/blv1jhNMGdp3y04vVVIazZY+yEsnljwxhnc5rTng0=;
 b=d3E1HwBu1ejDKeEsmh4Zz8TspG6aK4qtstpEnVotmPBok/iW1GsT/L0FACczssSEB4
 Mf8OxWiKnlrUIN4tCM7UcoopPTb68iiX8AuoSRIhCPcYUKhPkR5Zj6mWWFlghZmGo4VS
 ADeBIPaCv8tNIWZlBD7HxU2kQsnJX2/bLdrAYFQqNT9/bu4sqSiJpGO9ncHzbBRR55Ig
 C7cLtVidIxQxRpA/Lhx3UP5wA/g4FkSpdwitdq3zQjO48y6omb8gZzoIIxFdg29Dk99f
 7XRZE4LNgC9Bs14VHdrlcza+OsDnZI+uCRGmldC0OkZvXz4lSNgHHaPqMbLtofr+GhM9
 BB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713193422; x=1713798222;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h/blv1jhNMGdp3y04vVVIazZY+yEsnljwxhnc5rTng0=;
 b=O+YQxgnFbycYk6nL4aGFbP/giWunwWsgeAQx6UDZZN+N6Z//QrzPccFgyG49X3wfCC
 3zGnVubZomONqukLSCZ88mQfR4/G8JlFr3rPwaL42H/1D8MtcWTuMsQqYH1EC4eS0owk
 L5F++/lVVCngxTPorDLNzKGT45VuVYsF//a71cF1k5Ir4+VfOuKMNTX2TqtgDfu6aiHA
 q/SBE8GClY4X1tT0bpsW/TAtzvzRjm14szZctqo1q+4TqksgiX8JcR18smzkMFygaMd+
 erLB7Qk9Su4wyGuu4ZlT2oqPS8mMWeQjkFz5fJCaDdAqr3jHJ99noJ5iI/SOmhe48TZA
 kQLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL3cv38xJdwFRRw9uvdDsrD4zQQDnSmLM4UoNg9CUndAkAbrRu0qFYYom4w6ztx4ui4gt/dR8oXW3WzKUEkqVKUedSHw==
X-Gm-Message-State: AOJu0Yy1xq1me2+caEY6HUiBVZh421O4LKdgwpFxWTi9S6Eq9nDkdEuU
 bueE7cGjXqdVvlPyatzBmV+Wv6ocFfzU0YnMZi5xTff0hhOYyfLfOWkcEzDoXgI=
X-Google-Smtp-Source: AGHT+IEhXswvFWOzqxwzj/G99B+hSgfT+yzuXDLZKpfXHTC7Msc3z6VkRL5NaAtV1PU/sFrjgLXwLg==
X-Received: by 2002:a2e:3509:0:b0:2d6:c0eb:41cb with SMTP id
 z9-20020a2e3509000000b002d6c0eb41cbmr6690843ljz.3.1713193421910; 
 Mon, 15 Apr 2024 08:03:41 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a05600c358700b004182cd07133sm9040333wmq.3.2024.04.15.08.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 08:03:41 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Apr 2024 16:03:38 +0100
Subject: [PATCH v2 1/3] clk/qcom: apq8016: return valid rate when setting
 UART clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-b4-msm-serial-bitrate-v2-1-b7a048adc6a3@linaro.org>
References: <20240415-b4-msm-serial-bitrate-v2-0-b7a048adc6a3@linaro.org>
In-Reply-To: <20240415-b4-msm-serial-bitrate-v2-0-b7a048adc6a3@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Robert Marko <robert.marko@sartura.hr>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=920;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=z+mdt6z8O9e9zBFdjcbWdLQu5FVirlaHaG+3os0axxg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjRZx9PP9dzPvHjak6Gpu/CN/aZNE3+9K2oN6dz7/6lUa
 1HmxRsrOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEOpYzMuw6Gh1k/VHH7X3O
 04trdnwy6Wq4+HRu/0wXpz2Hg1umTHvD8N/r3H9hzQn/2txCP3x6abz46+MuzoTyvy861eq27GN
 6kKcIAA==
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

The clk_init_uart() helper always returns 0, but we're meant to return a
real clock rate. Given that we hardcode 115200 baud, just return the
clock rate that we set.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-apq8016.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index 5a5868169c89..6210fba87984 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -99,10 +99,10 @@ static ulong apq8016_clk_set_rate(struct clk *clk, ulong rate)
 	case GCC_SDCC2_APPS_CLK: /* SDC2 */
 		return clk_init_sdc(priv, 1, rate);
 		break;
 	case GCC_BLSP1_UART2_APPS_CLK: /* UART2 */
-		return apq8016_clk_init_uart(priv->base);
-		break;
+		apq8016_clk_init_uart(priv->base);
+		return 7372800;
 	default:
 		return 0;
 	}
 }

-- 
2.44.0


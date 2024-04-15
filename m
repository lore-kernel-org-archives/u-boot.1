Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADA0C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 12:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B93D588223;
	Mon, 15 Apr 2024 14:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eF14+iIH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA75D881FE; Mon, 15 Apr 2024 14:44:36 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 135D288223
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 14:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-344047ac7e4so2425482f8f.0
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 05:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713185073; x=1713789873; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=75JeNrH2fm9Dj7m4XrOpiemG5n9ITOmRPsU5m9vbyek=;
 b=eF14+iIHtywBWaDDb1YDbe35aRhTjJ1VxMCWq/CfmXjSJgQk+ee3CUzCnozn8k61Tj
 cio9ryLDbbDRPyH0CShPfftKc3M1Wy0KAV5PvQly5pQya9jsW/0PkOPnyw4zdAnJPdaz
 hxZXxJ3oYv5JMDGUfAVKVWjSMXcvZH+PVwC+7gPWKrHVvRjwr8lCvDkFa104SzJWh67b
 mrnEmRkq84yS7Xv1fnmpxwykZ11m2k7sBjWNmhvYNkdlxQk886TyWyIwKKMyPk7iAMpW
 8bWa5vRfsUt2bAS5285pY7bR5gEdOE1D3qEsdguXsN8cqO625OuSnOQDckmyVq3LwnL4
 ugBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713185073; x=1713789873;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=75JeNrH2fm9Dj7m4XrOpiemG5n9ITOmRPsU5m9vbyek=;
 b=vvdIssG2dQX9pxz6HnJzaEzmov92Hvoh9vouiOEbvRlEMN3vLJorn6T3b/vY28W5pe
 byNnicjmc1vSfY93TWMyRBSFhwckJs5cm8tXjeZGUwOQtuxEJjEsrP84nSW28augghyI
 wvdZEf/MsB3OlTICSGjs7RYw0hs4l7inLvEm7pDa5keTvwsP0Qi78V3gfZWVoVWP5SWf
 frXE08s5bwq/TKgG7+Q80vEerSz1kiLd87CaD7FP0Lqp+FD97BFDBfy0rR8ld2viCWgu
 T9vH7LXOZvM9D8R13it/+nnR/SYPZ1Fhl3ZpxJAzDKrYv1wvmcf7+j+Glvnv3IeF3qy8
 fJTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAyPvdDDm8KsGnn5YROUidQNRTsRrgLLNS8eRRXnkbw+v+9iLsAHWgDO0BEtS8CgcNg6hTs9L/HfgKFfPbRmlxSFnZMw==
X-Gm-Message-State: AOJu0YzUc3Qh4sNkgwCOoaZxlKs7CuAcBcRTdBjHbGbSZ071l+yrMOtQ
 Bb5Guo39ZuDqG1hQID9ePRem4NvsidsF2Yz+GKbRnqQlgAy86lgPD5KROVfXQUE=
X-Google-Smtp-Source: AGHT+IFLY0YnG708a2aN3zh93QthKcsUrLP92socEFJ1jCs1LT8EKizJa1QA3tmfH9JL73OlEOOdzA==
X-Received: by 2002:a5d:4248:0:b0:343:39a6:93bc with SMTP id
 s8-20020a5d4248000000b0034339a693bcmr7667782wrr.11.1713185073639; 
 Mon, 15 Apr 2024 05:44:33 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a5d488d000000b00347321735a6sm7931517wrq.66.2024.04.15.05.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 05:44:33 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Apr 2024 13:44:21 +0100
Subject: [PATCH 2/3] clk/qcom: ipq4019: return valid rate when setting UART
 clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-b4-msm-serial-bitrate-v1-2-5a89f84fd9e7@linaro.org>
References: <20240415-b4-msm-serial-bitrate-v1-0-5a89f84fd9e7@linaro.org>
In-Reply-To: <20240415-b4-msm-serial-bitrate-v1-0-5a89f84fd9e7@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Robert Marko <robert.marko@sartura.hr>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=979;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=jbE4uxM05hys6K6aPZcowyfpb9rgLC2loD8Pu1qX1Mc=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjRZRf3ST2ca1/PWLnhWfufwFE2d4u0ndYNPxZdfbeb/q
 a0RYnmqo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzEXpSRoZ2hPXbC2/gt67xP
 5f6acfnp9JJL/m/KRG699Ir59/jJs6kM/+OFm7VYlZjMCpZeU594L2Beg7ws574FRe3yNtyKS/v
 fNAAA
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

clk_set_rate() should return the clock rate that was set. The IPQ4019
clock driver doesn't set any rates yet but it should still return the
expected value so that drivers can work properly.

For a baud rate of 115200 with an expected bit clock divisor of 16, the
clock rate should be 1843200 so return that frequency.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-ipq4019.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clock-ipq4019.c b/drivers/clk/qcom/clock-ipq4019.c
index d693776d339d..72f235eab212 100644
--- a/drivers/clk/qcom/clock-ipq4019.c
+++ b/drivers/clk/qcom/clock-ipq4019.c
@@ -20,9 +20,9 @@ static ulong ipq4019_clk_set_rate(struct clk *clk, ulong rate)
 {
 	switch (clk->id) {
 	case GCC_BLSP1_UART1_APPS_CLK: /*UART1*/
 		/* This clock is already initialized by SBL1 */
-		return 0;
+		return 1843200;
 	default:
 		return -EINVAL;
 	}
 }

-- 
2.44.0


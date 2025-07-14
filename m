Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18776C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05FFA83093;
	Mon, 14 Jul 2025 15:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pmPCDH1E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62BCA83061; Mon, 14 Jul 2025 15:13:21 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 820308304A
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso3328340f8f.0
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 06:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752498799; x=1753103599; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7VzvDZ+10IVltyj53raqwBJ3cghBbjv9yDHlTuW3/6Q=;
 b=pmPCDH1ErXjxXODYJ+MZE0y/kNbXuaGn1u2ktjo9RimjUONabDpwBi8fNO+535e20L
 5rG3ZFZqRB+eYeS0Kxpq8gnMmWXvNNW/IyyA+zugJRKA9NJS7dms7V4a978fWRxNMyKD
 jLQnZ4NP7tRg/0wiPpCppqRV1cr708Goj+Jndvd/XF+BAT3asslVaCsuoTTLOmoR4qQP
 abFoJkwIMxwgacOqa3CjzOcoSct9bTBa2MXs5Iw4yovSFZ62612s8GPqPWYbpxky3a89
 N+q1uHyJncu7ENMD8ot68YohAvOIaG8TtAJ1td8UXdzb5IbEXRPwhnhkaPDBkbrcVrod
 ywPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752498799; x=1753103599;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7VzvDZ+10IVltyj53raqwBJ3cghBbjv9yDHlTuW3/6Q=;
 b=i8IXMdnwheU20+oxAm0oOpRZnCywtiDNt5tR/X73ClgkTBWAbNLQLHhswexc3JPUHn
 SP3Zs8NkPVcE2/ibsboEGXtExPL0oCyMTnykGGKM+1Zzeamt4r8nYekI4aQMrhnoo46K
 lzn8JC5oNwyGR7q8hvVsnzrBobSkk6k5qzdT4FjLCSwL7N3VYaewUVitibEd7sHfak2Z
 wBe6TKqOpGsLPqiIU529NNUfs1RDiRDD4zAzYLGCDg+WWCoHCBl7qSu8Dw9ojl6PHXjX
 iSMuvc/iX+nLrUJfmNVmxYUCP3vQoVKgzOa0TzVT3RRKsSWPbdrVMDrJexxlrQHAxzhV
 ThKA==
X-Gm-Message-State: AOJu0YzGT+eyut3gPQcKACNJQIJ1I5eV9NOth7pgOxCtHoixWTz9/PHo
 7Cjjsqb5B2EqX2W/j/OsG+e4i5pw/VKM6unbz09qR39zAClsEKOwup8zobFClYVo7NE=
X-Gm-Gg: ASbGncstXnFzvnkewWWKhcNamWhYgGK3MPp2SJqsFukyow0lqgV/zswnFkARf+YcUgy
 5xI2GxIDr6bku8UnV0La3jaPswDG4wU3DRVjRmAyGWwd2Wdd7gbL6OBYZFx1ruVbYvS73/N1Hv4
 5ScA+jqTQWRbBysBp0+//0CdXxX9w696sHc9xz+TAFssfd5bLngvxwsad/nRjpc2aY3LPmwasIb
 wbhXKt4zvcxz2DsnGtBEe1Vi47j9NQPZa2ZY9dCd2GbOZh/6ZNZml0ul2XLFvOnjxNugTszUpvG
 Qmdb4JITPE6rULQ5jhv79UrUgK24E8uREzCDbgUnGGPWpiJ7nK+o3zsUprG0S6kBk7urzLQO2aQ
 ngE5O9qhJQeJ6bCHXWiS0LbUAX0xFN2laWg03yxNe1gDSsxqK/2A3QHJ2lfIGioMJA0eB+Bb5zE
 xrGuzW
X-Google-Smtp-Source: AGHT+IHBcfbeIkmV638PT82W2xwLRcCFFaFvOofc2+xTnosSgWMEDx7f+m1Jv+5RtRR1zOgIFf45Qw==
X-Received: by 2002:a05:6000:290a:b0:3a4:f038:af74 with SMTP id
 ffacd0b85a97d-3b5f2e3ad53mr10949248f8f.51.1752498798891; 
 Mon, 14 Jul 2025 06:13:18 -0700 (PDT)
Received: from toyger.localdomain (p549d4699.dip0.t-ipconnect.de.
 [84.157.70.153]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc9298sm12361010f8f.44.2025.07.14.06.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 06:13:18 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 14 Jul 2025 15:13:13 +0200
Subject: [PATCH v5 2/8] i2c: geni: fix error message wording in clk_disable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-geni-load-fw-v5-2-5abbc0d29838@linaro.org>
References: <20250714-geni-load-fw-v5-0-5abbc0d29838@linaro.org>
In-Reply-To: <20250714-geni-load-fw-v5-0-5abbc0d29838@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=yl5eH8N9a3bWD1YMIpzhqdHUST/oYjNpQQ03AWxv7EE=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBodQJqJ673BtCjLOijwpERSxHKSTBlUi/88q82O
 K6Tqm7CXcmJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaHUCagAKCRAFgzErGV9k
 tguGD/wMd78tBkCAPJmzDYCHayskBwCFkQ4M/Vy+dK3bE4QAiho2exgwb7I9hkYAdyXBtGArFdm
 2aSRuVHFaw6UHPyMLIHHPV1aZMzOdesndwGKbItbUZXFHsu7UxmKI95jYkdYAIRRg7oEtISFT1B
 SHRNIsLFM1VK7vY8bQ/EULhMH3kFrJ2RhudaiLLAo4nkH2BR1zHT0mZERjf/QOPj9E6w6MA/Kef
 xuMpW/pCRe0KU56jFtB6Rklkd6Hj6PsSmFFbvhXFT8OzyWvFTnk+ZcFWZIuRzo0hU3HRFZzUtPz
 dXOP9/Wh8q2PSbAdz6aiGTg5TwX3ceYQb/4lIJvWsOdbYuNNXOq7Facc5zffeLSB8paSJL+fEAh
 rhbJQToO8Nym+MVKnJNwu3ctqC2j4NWne5A6DX6L2kKPuHq50HYreFcArhkeQmhf4KcB1ctow/L
 UV5LHyxmxpDZNAL3cUe/5GzlUODw5VKgheF8HgDXcfl06iwyqBlMZygH3PPC49lkkzKUNlh778h
 ExU0oygW/0luoZNlHLSs56+1x46GxqO/5niruaVOJF190vid6MAwmWJx9KIus74y97xXCv3HdjG
 +IOfGR1M3PA1z6MuiVZdxOmYGY4SohymvQn7FRHlNXeUk9EOOacPsRTaFaA4QizB2fpKHj5op0e
 N1hvQmuDzO3xczw==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Correct the error messages so they accurately describe that we failed to
disable the clocks, not to enable them.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/i2c/geni_i2c.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
index eabf5c76c21c2bc12c80dbb9fb498a0080928248..4eb41ba852f7790ca646c8ba38f29fdb727fa804 100644
--- a/drivers/i2c/geni_i2c.c
+++ b/drivers/i2c/geni_i2c.c
@@ -330,17 +330,15 @@ static int geni_i2c_disable_clocks(struct udevice *dev, struct geni_i2c_priv *ge
 
 	if (geni->is_master_hub) {
 		ret = clk_disable(&geni->core);
 		if (ret) {
-			dev_err(dev, "clk_enable core failed %d\n", ret);
-			return ret;
+			dev_err(dev, "clk_disable core failed %d\n", ret);
 		}
 	}
 
 	ret = clk_disable(&geni->se);
 	if (ret) {
-		dev_err(dev, "clk_enable se failed %d\n", ret);
-		return ret;
+		dev_err(dev, "clk_disable se failed %d\n", ret);
 	}
 
 	return 0;
 }

-- 
2.50.0


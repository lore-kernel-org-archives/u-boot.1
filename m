Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0D8C369A8
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 12:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C3DC83FDE;
	Fri, 11 Apr 2025 14:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UVjtUCeL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7040782B72; Fri, 11 Apr 2025 14:48:03 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE7F48400F
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 14:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso14746385e9.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 05:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744375680; x=1744980480; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+4Mzv1xKB9J/KHmbbrhduwbxjjdxt+NIIKcEUnNZcu4=;
 b=UVjtUCeLpg4ynYg2kZF9wTlR7WLOsQtRiYynKmf4Zd6G2DpwBaMZUkAwjIodFN7P73
 +0ac0YRidsIxoVY9eeWRvugwnlFLHYyWoUdy4159wgXsLcwXZ5h9ns48v8ugpeD9lHZt
 xFnR5WEINnoByXm4qZYzNh1iDn8muI0A8lHUi6/yvJyauP6NBWJv8ruQwgnsYSt79LFn
 ZbNUkOPSxRTPB457p4vbH1P/mSc60UIiYq5H6DSbpU0hTLVYGS15NJrNzQwod5mohpUk
 bHwKDO1LBq+08bnqslnk6d4m4gLeHBRM5eHSmZI4Uyrcysr6vDeIQ3EzOtAlKeZHPTAE
 gR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744375680; x=1744980480;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+4Mzv1xKB9J/KHmbbrhduwbxjjdxt+NIIKcEUnNZcu4=;
 b=C1DX6bMvuJkpvQ8kDUHKYk62fV9iVHY1cerqrtMrQV1JrKpQzBjAiAbkyY6u0dmZQ8
 7DPtkZxZNL+OskRnWl8dEhbBSAdoW2YnnUR2mIOWxzJeRbOx/DiuHkwaVoqxyqdWC0Yi
 sn73mMZ7cp1+HnwuIhIIelqQ4HqD9J1PBVVD29xDonlWGc/587Sbx3z3G/RBd9q2rH8m
 bP5QTerzgLasUCSDfqb2PrhTji77BX7D5D+DkeBMMI7Mb6dMCG+PeH9hYNYVSNREVXmE
 /7jlFK0LMUNM8e4cgsTQQ80QAWI0TvX3BUi5Y1LZXIvFJ7s/2AbZCSR109DVmyULotqY
 RUgQ==
X-Gm-Message-State: AOJu0Yyhd4ISfMga0qcuy4/+MAMAlWHbbsf+uDBJeXrBiSbAvFxdSJSQ
 4v4Wc+gXqaLuRqLVgjk8JtcLxp4ZNabov6dRAuUVuFyJmD8JXQjb/FGH9wbzNS8=
X-Gm-Gg: ASbGncsQs28r4VxWLL/CoOiq1myQjZjXLsdHGKhF9QgT8Kk3cRrzFY3eyLzn2ZEBStC
 4EEcLlP0jAukYfwZx/I8UzohvaGNDTKscvXt/+31QGtkE8qbl53kHIPBlGhucOyJsNcgnStIWcx
 S1HsJXciJUsFkiDFWm+xwHTRy5gVl6iiKvzlVzht8nFWynRabvhDVBFtmyvQmbW0bSFqY9YJIia
 QJSZuUZc/rTsox/ogItCQNmqyn95DLEPLx0y1pvF5bLg70bjchI7qpdGE6mRjV0fXI32Q7Mj5ea
 PD0RjqIg6xsjpTWo9/d5ys6PDmhcsh8kScBrNFX0UmM9mRCJ8phk95nJ3n9tU6hhlt5KNwseRFu
 YgDYflrEfp2bVW1Yt/Q==
X-Google-Smtp-Source: AGHT+IG/oRPugd6DGQ8w1tARGXjPdwQ6AF6VCFm/JfzvhcLBLE+/AwA7/+WnCi19wyFRqcQhhfZ4uA==
X-Received: by 2002:a05:600c:35cf:b0:43c:fd27:a216 with SMTP id
 5b1f17b1804b1-43f3a9ab0f2mr17268295e9.23.1744375680477; 
 Fri, 11 Apr 2025 05:48:00 -0700 (PDT)
Received: from toyger.tail248178.ts.net (35-60-142-46.pool.kielnet.net.
 [46.142.60.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f206264a1sm88299695e9.9.2025.04.11.05.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 05:47:59 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 11 Apr 2025 14:47:44 +0200
Subject: [PATCH v2 7/8] clk/qcom: qcm2290: show clock name in set_rate()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-livetree-fixup-v2-7-1236823377bb@linaro.org>
References: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
In-Reply-To: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=uOUNRhMRcPwqnuVm45bRX4aWzjuSI+N3wVTsv9rak1U=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn+Q90qWWbHD9GHDQH7Sr+AwUfAAckousrFnomY
 vzpNnXcA8yJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ/kPdAAKCRAFgzErGV9k
 tsWWD/4mJ1kB+1tTTzKpcihHALMmT7PTXccwvjiGdBHeadmodElXR0Jm0BgsH0NOssa/ANkbbya
 XodJh/NxFme6ETGkIT9zEOuqXl+AmmAZeeqfomBGgjMQR0Ie2aaHRUaZ7qvIk/jDN510SO7c2In
 pYkzNFKc1eytTj0I4hVp8pIQqoKXcBoyNI+FbkjqshmlDmP3OLgRKWIp4MC5Pk+VYy+CYZJr3/T
 nV62BgH6IZTHDYVJsq6kfR3nupQgeA1UfWmL1waY3hsPceKQtir0DE6rT/4iBA3G3DZzehIy3FK
 rUkRdR0jjdn+OHKxXN+rrRgMw2Xwcc4mIg0L90Fop5NWV3k3Gyol5VMCBKJBGL4E2QT8le54adf
 zwSH1u55C3eADndqxpe2XCEwhKdtzOdE5KJPSy9gBHjtJ5lR3kp/xkfvlm4QMtC43hr3YuUk967
 ObIE9ggYPhfMqh+HzMLQvRXBCH4G39oBoZXpktT8y5ZfNt/VsVsDeUnyEdRWgcVhfGzHmhs36Nb
 boqJ+wBIIMsL499Q0yzRdVKYRZRx5+h2OsUux6DrNYWINLaVbIRqu66YJwh67AFBtQaZi0yyl2R
 ZsgfoYsgHNoxT7WPQeT8mAuQ27tEhxwAivQI9p6A2F30rPBMhW8pysEGfm6M0k/K0S9M7J9RicN
 aoPdGjdllt4zf4Q==
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

The device name is always clk_qcom... Not very useful.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-qcm2290.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clock-qcm2290.c b/drivers/clk/qcom/clock-qcm2290.c
index 1326b770c3ebd723120de4b6657aafac726023d6..fad104fb91aec8917de66b63dd546926c8856011 100644
--- a/drivers/clk/qcom/clock-qcm2290.c
+++ b/drivers/clk/qcom/clock-qcm2290.c
@@ -87,9 +87,9 @@ static ulong qcm2290_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct freq_tbl *freq;
 
-	debug("%s: clk %s rate %lu\n", __func__, clk->dev->name, rate);
+	debug("%s: clk %s rate %lu\n", __func__, qcm2290_clks[clk->id].name, rate);
 
 	switch (clk->id) {
 	case GCC_QUPV3_WRAP0_S4_CLK: /*UART2*/
 		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);

-- 
2.49.0


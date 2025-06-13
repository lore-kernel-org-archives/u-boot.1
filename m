Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11409C71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 18:11:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE67582EA3;
	Fri, 13 Jun 2025 20:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UZIJX0vU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6816D82F83; Fri, 13 Jun 2025 20:10:26 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D2BA82F73
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 20:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4533bf4d817so1932745e9.2
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 11:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749838224; x=1750443024; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3UV57k4rVnijtDtvo0BY0z3lwOaNoI6EVcU6lW1NM8o=;
 b=UZIJX0vUsGHWyO21kLk0c2HkUg8RdtXDrItTKxWTHxNxIyDDIEthBOAeFrOUu2DqNB
 kgzDypCu/Q8C/3R35riyVX7r9lqHq2iXz/HYqNKqaTt/pwwFODb7RV7qFx6ugZgiabKP
 f3DMMrdGxZD1vS+NwJnxB4wHvTNozDe+SrNlEPVu/9OXm8GTnvruuk1jUQpNGdiHEai4
 HUamiexcM5basMkHoO2PHGacbwE9fLw916yvC692Wv9AnV6yJEmLoHPYRNvu3fvhJtGp
 pOc/WDuHCSRt+obpKkdVXEL/sP+rarnCymJQ/bUCv+lrcNyXZMYUyCWvEDO+Zyb+4DsW
 Jr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749838224; x=1750443024;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3UV57k4rVnijtDtvo0BY0z3lwOaNoI6EVcU6lW1NM8o=;
 b=cUPiojkJVDh7oWEIxgYvPUmgrcB/MO7t4YhyKM5pI85kcx0qzH/saUehLrWrQ2tJZq
 ZBz0QGpZqehy1bS9xMVIqdzA7e1KNfAbDcELMUyX2RygfIHY7pcgi1m/dsrcbeOvwQdG
 kB2PEa34UWOaEsQ/yWIrJlcCS8dw+HW5fOCgnVB+wMj+UxRDjTXL70OQph8UdFXVhNEw
 CWTObrsWB1RKct1gm/CSLafNeRG6Ctjgi3AsF8J5pwjQgaTvk1TEd/UCttUyUXvNLenK
 qczaGTmolQUH6KCuXZBa25x7b85UngtjtZhW8tVN3Qh1H+H/MOWbK9ydVwW+GXMOvNgK
 jo1A==
X-Gm-Message-State: AOJu0YyNi4cHkNsscfF5MN8ruuDoinsnm9HC+ajQOU7/xEU4Q8zBy+tZ
 +5d9RQx+dKcwfHE8+18if86FkR6uZCQ8F1HYKdseLEJTh+fmBX+dR5Ck1C8sCP1fKrBzlVo7Cj1
 JwuP4
X-Gm-Gg: ASbGnctQz3m1/iNW4PCSRQJ6CSwIrPUIp3/nI7J0fU+ZY121faNRhIx0fwtsHZPvC9U
 50EJ0DxtUfWX5bbZ9tZm4x3PDDKKuyIMdNbh4sGvk3BnClC+gG2q6qfmI2086f3XJbcwiQMDu+I
 fwyEiZQ7s+Q69z0u3xLEZ+PiFUiw4EhKuJIFO0DebJx6wgTo1qUNcpgdU57FDPi3G+IBlBAYETI
 h0Wl/cpokneaVrOqHlGpX/f9aSvdOuwLAH32T11ViAXqWcCLUo+Dli/yq4vKTM0fJfceG5TDuwd
 K5WLrgbDW0i3K+JHJb2K5aIx1mcIXJpwOWKE2vzXvmHEpHE2NNZ5SFLfjWU1+CmPlfF0
X-Google-Smtp-Source: AGHT+IGI8WAjsYO7pUzYz/ECjswivk8UE2ybghognzXOrsIXSDZrVGNDW7tTpWnFDaJbFcjo68TrZg==
X-Received: by 2002:a05:6000:2082:b0:3a5:39a8:199c with SMTP id
 ffacd0b85a97d-3a572e9a0d9mr857228f8f.53.1749838223798; 
 Fri, 13 Jun 2025 11:10:23 -0700 (PDT)
Received: from toyger.lan ([213.240.182.76]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e14fc98sm61511975e9.29.2025.06.13.11.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 11:10:23 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Fri, 13 Jun 2025 20:10:17 +0200
Subject: [PATCH v3 4/5] clk/qcom: sc7280: add uart7 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-geni-load-fw-v3-4-be778b3b101b@linaro.org>
References: <20250613-geni-load-fw-v3-0-be778b3b101b@linaro.org>
In-Reply-To: <20250613-geni-load-fw-v3-0-be778b3b101b@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=ilc+MkFAWqEHp3xVjnRqOgd0tHQQmGiRxLtjzyftWZk=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoTGmIv9bvFDPQywtZCPdFX3J3Uut+eRSv/Zs9p
 Vurwb161UqJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaExpiAAKCRAFgzErGV9k
 ttePD/416zpHO+3Y9aqaphA4fcMkdaB0g/oS4mFm6oQ8dOxd12UfCHupSYBQ22TIhm6B1SsOkBD
 g2BfPnDJBMPJtMBPau5DwWJLArX9zlmMRAdSS9ccFMq+aNFS14iq+udZEXFOFtMSnLGDbnYSKEL
 DMIH0W1XYhiN71RIRLXB3pvspOHSTWt/zmEmXMyFKuw/spAXANp9GBGaJZrlVaVHy1rwn1udSqr
 vxtm2NFj+E4C1NjZKSz+4tiuhZWAqegyVdnJuoXJthzTTgNwrTPu4ceIhhbVDtyLXIYo2S0mHoa
 9nC/tpZCRVJZKHho0PvvIA7hp/s647EocHJ+GjLabYhANWKCplWaHqrryebkZvXlP7FQyO/Bh7c
 Yc+LYQpVS3buf1rppTtApjZcR9zbfgZg6Tx5hmv7i1xZhFN91x5eTCTGaQbWQx4im1yiI3QKac+
 ZSa/9alxtH6RFufvYr7CX8pybauc8atqg7FkAPMzLgYKNzw9Y/+gIW50Bnx3xKU9MdyXwywZxLh
 PBG8cYsqDi9mRWhU1xN1Yf3ujPefSvwTPPxnVYeL+JQibH/Xyr5bJri1BWLhfmX85pEcrlZqEt7
 UoQghhlwZku6QHJyaoxxqpArfgsiOu7A1RXU+emGxKbfI7UMLgC6zwlan+63WERcN91dtMc+0ex
 phnppOyxF3smTFw==
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

Allow us to power up UART7 so we can load the QUP firmware, this is used
for bluetooth on RB3 Gen 2 and possibly other boards.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/qcom/clock-sc7280.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index bf3c6c4ae647a46f7f96b10c0e3ed76a2f2ebee1..55a233df39450e511aebf7892214967c284a603e 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -67,8 +67,13 @@ static ulong sc7280_set_rate(struct clk *clk, ulong rate)
 		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s2_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, 0x17600,
 				     freq->pre_div, freq->m, freq->n, freq->src, 16);
 		return freq->freq;
+	case GCC_QUPV3_WRAP0_S7_CLK: /* UART7 */
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x17860,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
 	case GCC_USB30_PRIM_MASTER_CLK:
 		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
@@ -128,8 +133,9 @@ static const struct gate_clk sc7280_clks[] = {
 	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x52008, BIT(10)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x52008, BIT(11)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK, 0x52008, BIT(13)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK, 0x52008, BIT(15)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S7_CLK, 0x52008, BIT(17)),
 	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x77010, BIT(0)),
 	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770cc, BIT(0)),
 	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x77018, BIT(0)),
 	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x7705c, BIT(0)),

-- 
2.49.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4468CD3B7F0
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 08:29:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4C26899FD;
	Mon, 25 Nov 2024 09:29:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sFE01+FT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36BC18961D; Mon, 25 Nov 2024 09:29:22 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58DE7899CD
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-431616c23b5so22674665e9.0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 00:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732523358; x=1733128158; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fmDoEvMcLQk1iUUInIvL51A4FyTRrjeuoBXe2MvYOtM=;
 b=sFE01+FTI6HgULx+LN682GZE7DeqUKe5rIh3RW45obsvnd3zKDGEVR0at6FLpFBRaR
 9Zfl1fLD/b2TD3QNNTtwc0nx/MrWRuGbn/XThRplE4L1mE1HNlUhTC6bVsvPwjxb9GKM
 SxsUT5Ij9qmVmdDi24eRFitL84B3ggRGtkxtYoezQkMcvlV2OLV+1sLhuM0iqfhYG0co
 E8FX7E/K7mbAiIHLlQAjSwT4JUJij57ikmhu+vpmq3ux/MKMdXvfLBlwAGI3iLjla9VH
 749LX5ldVmeXPI43ArArufbDKEAvhLtUwSwwTDwq48MzWRc2TgfluB3UnQbvX+GLq45U
 UK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732523358; x=1733128158;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fmDoEvMcLQk1iUUInIvL51A4FyTRrjeuoBXe2MvYOtM=;
 b=Mn0oJZSq+mdNjcFFZwFhxMk/4+oBBb9lChG03TWaJeeqNj7LQvisBpZd5GAznvzuXB
 QiH3Wbssdj+pWVSMmcdhPrATq8+s2y3h8vsP11MnmHsFhE6AkvMEa+jnI1wzaAbeA6sx
 xq8uvJV1euV6InMPL7Qx6yuGjys8Wr6IoXSwE1cUCRg5FOnlCBVQ/GztWgScg70zlkw6
 +jbt3XvXHYRj9zm3gyhSuQYiFkIoR+oXkl3fP29tAcXD6sQFD4Wf+50o84rEUSaMunR1
 MldJcbM1FCujT47muU4ZMTwvZPj0olkj/hoX/8TmMupC2epIUnqAXfvvP+qhf/YYASt+
 GAug==
X-Forwarded-Encrypted: i=1;
 AJvYcCX73S6zkr0xZxbzQsRcV6kGuDXICnddaLrlo+eQAnarJphv/S5kxjZDud8VsQVQERcUTJW/X8s=@lists.denx.de
X-Gm-Message-State: AOJu0YyMdAwu1knh61DTEBO+rZ2H/xQBTH99mcAOq2VKJ107SrFYQM4r
 Uq+Jx2rT1k9VFWaThlogDW1EhFzG39NWpgK1+Q0moUVIPRz1BMAq99nSGs/jIQs=
X-Gm-Gg: ASbGncuQ87pP0YFR6G8jTEeavqSfcv0Wu7qcauxwa8RLPnwE+OcMPAO64/4+IUp/sji
 1GX+eoit7YaPUdZPfelzXywQzEVxEXbb54q88+DVI8R8RixlqHRHSP6SAQPTAuM7qnFEPlSM8nq
 LAcPv901+8oMvYwVrORXOhvGdct4oE5Ux0mAsjt6l2TO1eKHu2QgKF2MgBJrGVPNlatppOo3zXf
 Ap4b8IfyD1ouk//gJlqC9jwHkOcsfWfCqwiGp/sS7k47Yueqm4VSr0yc+R9eETQlS/qyyA=
X-Google-Smtp-Source: AGHT+IFtDovVzwPCZxeLDbq7TosWL8DA0dIXAvtT0gLWaa7n0JbsaEotTOWGR/whylvoenSTeTi7LA==
X-Received: by 2002:a05:600c:3d08:b0:434:a09c:4f9c with SMTP id
 5b1f17b1804b1-434a09c5181mr10149005e9.16.1732523357905; 
 Mon, 25 Nov 2024 00:29:17 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde1107csm121423545e9.15.2024.11.25.00.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 00:29:17 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 25 Nov 2024 09:29:11 +0100
Subject: [PATCH 2/3] pinctrl: qcom: sm8650: add pcie[01]_clk_req_n function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-topic-pcie-pinctrl-v1-2-4df323d90397@linaro.org>
References: <20241125-topic-pcie-pinctrl-v1-0-4df323d90397@linaro.org>
In-Reply-To: <20241125-topic-pcie-pinctrl-v1-0-4df323d90397@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=802;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=uDgM4BGxfsDKqUl5LK8ouTs/8zDqT92/LO0vFV5XOog=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnRDVZbE26/1P4VK5vZG/n8uIcH88QxyCkKywppEOy
 pDFpz4GJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0Q1WQAKCRB33NvayMhJ0cfhEA
 CWNZR1Ef6uhJswF33K0fC4+PMSEq1pvnQaUlbWZvx/0juBUZWV2lYlCyRk6/cU+YkSP7EcO9NAlXB9
 cRKpdt0VY+n6poVTamsEQTmoC2ZTenXltEbRTVsF3kQ9CpC+BKCeqUrP5FFzPOjGMJHoyChwIcQlfj
 rSaNphoDx0iDTW4qi/m0zcFYUmEI2jOG6A3BiJNPRW1Io+BrjA5z+SlRVJbIXAC4JCkh0k//8CKqkE
 rTddC8Ya0i1Bzo2dCLdbf4Ywrk8ipFjsaSJhtw4CWQ3SpkXL38cglsYoyqxcU1SWqjzryxPyI95srK
 +oaGntQN/oXOln0vLNh6HbGe4pDIBgcb8MY5aE6mye8jxYGht6f2t5+BBgGIgE9gT8GA5DR0roipbU
 xY4tuUiDlzqbRrziD9IZHgo2CEB3QZPLh4/m0qtlFpNbiW0ZfSu/Ou9ttZgKsCRoqvYcdvA19GGe4d
 Wk6sXbsugcB5e4z+fWSe3RPf85uCrCGb+y11tFKTygebpJZJ1fe0CY9GzLuQDSUgBGrs7n6LbG1a54
 lkfy8gCdCVkw66ccmdrj/ji0UvXHI81lGMLqT68HOpE6w+5oFuC/V8aT47AqfBgcXtZ8YBoiiRWdR2
 qyOje4WsF64xq8jZlGZnKPjVvXAHPcPRXatvON4TlXRTuf5ZxZZofxec98uQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Add the missing PCIe clk_req functions for the SM8650 TLMM.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-sm8650.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-sm8650.c b/drivers/pinctrl/qcom/pinctrl-sm8650.c
index 58fc94e71ac152538a09b1bca9b0f58ef913967b..9146d6abd9a046460836ad8cda6ea196bc4ca91f 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8650.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8650.c
@@ -16,6 +16,8 @@ static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
 static const struct pinctrl_function msm_pinctrl_functions[] = {
 	{"qup2_se7", 1},
 	{"gpio", 0},
+	{"pcie0_clk_req_n", 1},
+	{"pcie1_clk_req_n", 1},
 };
 
 #define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)	\

-- 
2.34.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED09D49228
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 14:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 038B9893E7;
	Mon, 18 Nov 2024 15:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O+hgwKcs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2BB888D61; Mon, 18 Nov 2024 15:42:07 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F96E89469
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 15:42:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso17549015e9.1
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 06:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731940923; x=1732545723; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zpW1Tei9SlGisfripl6CJjo8+LyrBVsm9nuhkOmF5WA=;
 b=O+hgwKcsn84cXWLfboMGps8KuiIIQm6o6L4+4RTvPu5KCKnVhX5f6ZlNY1Ee4UICzE
 JILIFLVGsMptqAlh4kHaMZjTiGPLqjcblnqI+LWvf0BusrcN4QHSu5y0f8K6QVIhtHbD
 ohhwDoqes73CcoADn0MjoouDUy2SWuhjki1OADoeBhFZScY/lgvltMa77mPPIDtxY5WF
 NV+U2TGJfyOgbQLIEMvVXYE5Wnkspuz6AQHu6jTtbmygQEojaxDusxJFWZVG9qGEVxFo
 wBQeXKBSs/63Qjx2KwJrPvWBy4qo7dU2V/c1IZ/SeKsjT4jDwDPsWwYpJCEUMAD8RIvC
 DiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731940923; x=1732545723;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zpW1Tei9SlGisfripl6CJjo8+LyrBVsm9nuhkOmF5WA=;
 b=R74zlBuGH4OD1jrRPCO9goeauAO9qATs8SMT7Wf3EibNNvVTZ62C/Wp6ty7Pdi144Y
 uNggWfnCYm4O3YGBzqKut+jUoSEFxnTpPE3Cl3ymXUBwEo0ePSLLsMZR/ui2lL9PBIFS
 LYlJPZ8p+PDSk2MkN+C0Wy1EV3U9tlPztGznyDPqp5z1RgOeCelpl6R7wIUDMqsM0r36
 fep6S4Qt8tRaoAPDeARBngM+IaDKpaEq/cFdtW9WvFnkPkjvrRgXrFTBWb1jMu+F70Wz
 Ux218tix+AdIkP5+qgTI8VOINuZTVUM30/gQ0rDgtQ+GmKO9zqwLHv7YAC6gw2vIR60M
 PPoQ==
X-Gm-Message-State: AOJu0YxlB+H5fE/nr2fFDJ+DuKu+xXOsBcHdllDmiKT2tnlve8QIv3Qk
 Qh52HAV70FIaE4lwK2XyNtbz63e4FX3ELY+4hZW+2SEFHOpXl4XIvMj1oHGM7QM=
X-Google-Smtp-Source: AGHT+IGHD316iQOU3GR3O1Up/J0uBTjQ+LY8/wh2lAk8Wpep/UmTKV9/JnAKN1SdDJ/b7F2Y4xAVBw==
X-Received: by 2002:a5d:5985:0:b0:382:4f5:48 with SMTP id
 ffacd0b85a97d-38225ae946cmr9339476f8f.59.1731940923030; 
 Mon, 18 Nov 2024 06:42:03 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab788e1sm156906495e9.15.2024.11.18.06.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 06:42:02 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] clock: add support for X1E80100 Global Clock
 Controller
Date: Mon, 18 Nov 2024 15:41:59 +0100
Message-Id: <20241118-topic-x1e80100-clk-v1-0-8841e87ad81f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADdSO2cC/x3MMQqAMAxA0atIZgOJKFSvIg7aphoUlVZEKN7d4
 viG/xNECSoRuiJBkFujHnsGlwXYZdxnQXXZUFFVM7PB6zjV4sNiiInQbis6aibjyQtLCzk8g3h
 9/mk/vO8Hu4RYUGQAAAA=
X-Change-ID: 20241118-topic-x1e80100-clk-d05b8f0fe1e9
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=680;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=/hRXJqT1XnJiPT1utp1PODnVKDi1vN0eTfkSt9UjjXE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnO1I5UPG3pLP8t7xco7jcZVK6U0n1DQV91o7Cg9GE
 9nWdiluJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZztSOQAKCRB33NvayMhJ0eKzEA
 CkEuJ4l1s2GjkYRS7LLglaNTB66QmpjojiggU+P6jZ1arL2HCA4H2vNXMWz0mZGTQOg6qJlXkt2R/k
 3kwfYPLhi8DF7MkSxbRCW74c+4/ivvVv8IV8a/lbXGwGYDUCwDm3X4XV6dCZiKFMEcUoy7lo3N2HaO
 EBoC0y57gQGrJrAh7BY5xkU+eoSItzr1Nf38OMGd+UvPOlvvaK/jGxI9gOJ9C4sx9N4J0D/fQmXbYb
 CYWDcKh2wdkdOxeNPhIOX7zZbS2+rcVeTOkxP6SsI+fKLtB1LpThzReYskgPE4YJETO02xndhg3Zcg
 NogJHGGS+RRJxQZi9hUL0ehrgmBsspZI9tfo4UvHoWMpjMZPXeUiWipHUlVtSqhuTtfXjA5SAQVLaS
 NB7zP/oyK3iPMOq+esd5gwiDR6reUFa7TS66XLMNVM351cOSCCuWZZqidCmzfFo8uizPl0OMtjVjlU
 FB5o+aKUWWV5Iy2XQf40Qu8sYp1aEMp+eeeiF+/NgWWpkunDvJup+1mJCkLxVltUCT1JLe95PZTFYC
 5oHlz7kwnIAFKAYTA0gtzrx2PhiY3DrGps6VyiccqvkOOrKiwlPs8HrxX84cUCVspomkoy9NqCvpQK
 adPKRLF+BSTHqHxxBtBuq1JWJQle7+F45nthp2m2+z7Q6b2UNI50qGr0lvtQ==
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

Add support for GCC in X1E80100, and enable it in qcom_defconfig

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      clk: qcom: Add X1E80100 clock driver
      qcom_defconfig: enable X1E80100 clock driver

 configs/qcom_defconfig            |   1 +
 drivers/clk/qcom/Kconfig          |   8 +
 drivers/clk/qcom/Makefile         |   1 +
 drivers/clk/qcom/clock-x1e80100.c | 348 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 358 insertions(+)
---
base-commit: 56accc56b9aab87ef4809ccc588e1257969cd271
change-id: 20241118-topic-x1e80100-clk-d05b8f0fe1e9

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9425CD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 17:53:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 025E187F6E;
	Wed, 10 Apr 2024 19:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fIIipVSG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A7C38817B; Wed, 10 Apr 2024 19:53:35 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F6E688149
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-516db2214e6so6095409e87.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712771611; x=1713376411; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kCH2rooG8J1nVDAxO5+RH/VkObjZ5nbehNUVUJXwfWM=;
 b=fIIipVSG+Gbh1cYyvRdcZM8oW4tdTlSyDHppsjpa9DNxgSjM1BfKB3l+pRV5aNT0gZ
 pfkHbXZ8yus1P3EPisWDA6wLM9gfDa+TPynw5MCb0oG7MgAhVgYz3ceHEph5QWTu+ZTi
 M+ZEOIVjRhwFHlceccgEKe8Ijl0sQNj1qEGaGfjXzhVR3+t2JXWdinKdhLYmHO0OkFk0
 1ozSeeIv9Us9H/XhJlkjLlP5APSn/AX014q1DU6cGLnNu23Jv6WwVimP3teNb0nTsN7l
 nPKhaz5s0U64dS4SaN+pFrsn5s3TOOeE6qWNVcui41COfBFp+9+N8FC4+fsP3hwv0K8B
 D1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712771611; x=1713376411;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kCH2rooG8J1nVDAxO5+RH/VkObjZ5nbehNUVUJXwfWM=;
 b=XUwVuOrvghNumZ7bZDWC/LvKF/ugoKKE05+0I3oyhrorZP/aihcSD4XGSYRQ5sHyCI
 y9CrR94M+7nFfqg78t6ls4BardRBzUzyD+/D4OLDRbUhqjPH/PQpQmSqFrrfDsv8LZK+
 /Z7zVkDd62Al93/aMHHtokzSYGKUwB62m2dDasgDB3kqIOz8UZK47F8m4L1QASkxwEph
 9zOFAWL+usXA7qjuyOwmSJhYJDmDgy+7cqSGuvjHooq4NwCsYhmfJvuZN2iNzZ9DiU7a
 HTBWZVcAvwWRzh1ROyV+nY9iR2As3g+guzK4etlHmZg0ZE1NlT/V05O0NCCs810SsB5L
 tg5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz7UiAtWsE7uH+dJLDdzYzdAt8oaPCwKlOVamyLuAdXMrUM5XTALElPkT5v7AKUcCuD6TxIYH5CAK/r6Wi1V5ObIDlHw==
X-Gm-Message-State: AOJu0Ywl/YDec+HBU2RYhkyyyv1DjO7YfEbUXltMLO1Rj4VVY4udJABt
 zDsUSK4qlcxcxGqVBqW39pk07MB2y163RKRgEvoLY3Dxr5nZDgvW2KdnzhZ0vzc=
X-Google-Smtp-Source: AGHT+IH5AYj6x6ClcbHQQx36i1Me9zJTLpDS6Bh79PjWT5to0i4ehPH6c+Cwl8hKjDipAFkDVPs0Mw==
X-Received: by 2002:a19:f010:0:b0:513:cf73:d8d2 with SMTP id
 p16-20020a19f010000000b00513cf73d8d2mr1864772lfc.54.1712771610866; 
 Wed, 10 Apr 2024 10:53:30 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::4716])
 by smtp.gmail.com with ESMTPSA id
 w1-20020a056402128100b0056e2b351956sm6543599edv.22.2024.04.10.10.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 10:53:30 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 0/4] qcom: pinctrl drivers for qcm2290/sm6115/sm8250
Date: Wed, 10 Apr 2024 19:52:35 +0200
Message-Id: <20240410-b4-qcom-rbx-soc-v2-0-5120a9c7f6ce@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOPRFmYC/3XOQQ6CMBAF0KuQWTumQAPUlfcwLGg7QBOlMkWCI
 dzdCgtXLv8k//1ZIRA7CnBJVmCaXXB+iCE7JWD6ZugInY0ZMpFJIUWFWuJo/ANZLxi8QSmJlDK
 VLpWC2HoytW7ZxVt9ZKbxFeHpOP7cOPNPtdYWhcgpTymFL9O7MHl+73/O6e78Lc8pClRCWJ2Xu
 tK2vd7d0LA/e+6g3rbtA/IfLEv2AAAA
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=D8tkccXAohWs4e2jin+nrpoPb1ODZXfHkouGZDMNlQQ=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmFtIZ+fwW7fPEjUPnYeS/2oRFaNbYGtUyLhCeK
 9YdWlvQbHyJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhbSGQAKCRAFgzErGV9k
 tv6RD/91pY2DSQQmINweaM71tnn6zKxm0r6JKfT4qostqIktq4uzoIsAnRS2RL7zIemKWU3zCTs
 +jWl6Jfxffk3jb1ESBMAzBitywWn/HM7AmT8yuFLWLhPNEiQSU/Th08QRRcFF42o6/Yjj/s9Psv
 2iGeKDkTVa+4GVfeohuU3vBfWtx2TIrwgLo36V2bNMfet57gARyqC/CtSQS73NVpJ4fKZsWroZn
 RvJYxzk+wTLkyA+jswsS0d9Vdk0TZCdYKbVBQRuGO1icB7eoLeMO4wSZZ7fNEC2RqvD7pM6AbYJ
 UUPkMdFx2Pr26/FTP+yqmraNSuNxyIuUNGNbY0Y+zbjY6nSkLziE5u2iFlurgSFriGYiTUgv7oM
 SzagmEudw4pWjYhleipbGWGvaQfgFJDso/2dDSYIXEyqxOsDMzMZ/URd6Avr1FlDveh0OV8w4D9
 p8ny/zxNs1kN3/vLve+YKljBs1cv5mc/0mPjm4Q21kKVU5KO6hv8EqS6ZXQXPwtoQvV8hhHQb0o
 ovNV5wi0X7zu+AVkSaQivVBYihw4Ue7gf5J8/DKppqD++qIrh1hGiMQQwJrprJx8GVEtkb7f4Zk
 gEGY9dzaAUW01YOjGcaYxxzncKLaZhxDvfGHc8OhUd2r6SuOh3zoNWkJVV/qSKjqW7c4JJG+OSG
 dRh3Tpsbd4ROjDg==
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

Introduce pinctrl drivers for three new SoCs and enable them.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Changes in v2:
- Fix a few formatting issues
- Link to v1: https://lore.kernel.org/r/20240408-b4-qcom-rbx-soc-v1-0-900db37b8bdf@linaro.org

---
Caleb Connolly (4):
      pinctrl: qcom: add qcm2290 pinctrl driver
      pinctrl: qcom: add sm6115 pinctrl driver
      pinctrl: qcom: add sm8250 pinctrl driver
      qcom_defconfig: enable pinctrl for new qcm2290/sm6115/sm8250

 configs/qcom_defconfig                 |   3 +
 drivers/pinctrl/qcom/Kconfig           |  21 ++++
 drivers/pinctrl/qcom/Makefile          |   3 +
 drivers/pinctrl/qcom/pinctrl-qcm2290.c |  70 ++++++++++++
 drivers/pinctrl/qcom/pinctrl-sm6115.c  | 200 +++++++++++++++++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-sm8250.c  |  99 ++++++++++++++++
 6 files changed, 396 insertions(+)
---
change-id: 20240408-b4-qcom-rbx-soc-44ee99c8b799
base-commit: 4ba549b0a4e67c563785ab144edf47e108b34822

// Caleb (they/them)


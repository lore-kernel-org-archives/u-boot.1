Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC30CD128A
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 13:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92E63880A3;
	Mon,  8 Apr 2024 15:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bJHUJHSV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2815488077; Mon,  8 Apr 2024 15:07:17 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3195A875E9
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 15:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56c404da0ebso6699176a12.0
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 06:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712581634; x=1713186434; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YgcDVQqw9rocnuThrcWTJTNEwtrlUcBu0jkLjG5An3k=;
 b=bJHUJHSVk7EsRaUdgrpl2PY8N7AfbVy2XmHisY+7gCl2bvsLsnBDrCxT0Q2LgArxeR
 l1qJnD0dAtl/E5o2E5xbE8NPHhEsYP6beU9qZWjKZ0YeSWarivXxtrmYlOCo2GQr3ZTQ
 Ow6BPHCi6yMzj9Hle27zQ56DWPXfwJo8niH69eQmiqf0fsHwwFDU0BV8y5tR5il24F4o
 FITdDQWO874LTx6EVs+tlga4v8I9RyNVvIJMbJLKapol9eJwZRXuKvmo7U0/CTh9FnFB
 pZp0TRMazogqH3C43vmgI6m8+TamxUbqyhbyD3isIW9IXXJJpmCsgeTpRpowN/Wuj3WZ
 Khog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712581634; x=1713186434;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YgcDVQqw9rocnuThrcWTJTNEwtrlUcBu0jkLjG5An3k=;
 b=CfbTsKQKdBlfoMGGpuTtValiSfFwydnceuK8SOmNbdKw2hkiAnyg7v8UoEUr1wxm0p
 EzmHpkpIQqHfUP7l3NtfZsoour7Sbe7aBUlz6e5BI9WaKql6nsA/8k8G26bGWbMeZn2K
 I9a5suN+Ve2m40Ql7wPxRBhZzlneb9YW5k5iEVZK778oaEEwckMU8W+/m7MwJUEk4k6n
 KsH9ynGcQ0RFPbJCwd+IPAIt9N12eH11ivETXDScRDwh4wsMdPi8zJkFqjhL/y3QNCof
 7/RjivflQr/kaRKqpgs1e2Cv9OsDE1l0LBfE5Jj8iQKubFbljvBRifhc6/RH4Q773PW2
 t1sQ==
X-Gm-Message-State: AOJu0YxHypRQZr6P4ieV0Wna4NUs2CVYxpca23k84Xnsg4mFCpx0b1yG
 I5UYRQnIgxAjYnJwPkbr3QBCk/OdPbwqWsEuPvv/CbPVCTLhi4cdnXZ3QuXuL44=
X-Google-Smtp-Source: AGHT+IEU8bA+kQLhovFO1JlZKMST/3Fmw80SzbN6vl5nxzwNST3lGuyk+mlwKgLqANopNPLmYaugrQ==
X-Received: by 2002:a17:907:3601:b0:a51:de8a:fe99 with SMTP id
 bk1-20020a170907360100b00a51de8afe99mr1245634ejc.42.1712581634641; 
 Mon, 08 Apr 2024 06:07:14 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a170906338a00b00a51ce37a708sm1998981eja.94.2024.04.08.06.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 06:07:14 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/4] qcom: clock drivers for qcm2290/sm6115/sm8250
Date: Mon, 08 Apr 2024 15:06:48 +0200
Message-Id: <20240408-b4-qcom-rbx-soc-v1-0-2db1d3658660@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOjrE2YC/x3MQQqAIBBA0avErBtQE4muEi1Kp5pFWgohiHdPW
 r7F/wUSRaYEU1cg0suJg2+QfQf2XP1ByK4ZlFBaaDHipvGx4cK4ZUzBonPOGDHQIElCq+5IO+f
 /OC+1fux8HENhAAAA
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=L5BAtLfkmGO3OaQRSaTUWBdg+CVgBmAIgnfBUpwHzrU=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmE+wBBP/yEQkKtTWX4LowhJoO3vub1OMb40C2g
 i5VTrqtbRiJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhPsAQAKCRAFgzErGV9k
 tk4LD/9N/qnkrtjfsbnqwq+btEzNbPlz0sRDASiZEbeJchTno/ytE1N42AASvhQfRy3mw5WiBHp
 KOL25t/V3AwW/19ibTvRqS/6nUQCpTmTWaoWKly74n+GHisaE1JvVAtEBy+cJWXJB5UabpiNQ0N
 ytzmx6wLPge3YrR7usbEiGqUybXtiAh16qv7tkaXtQYV/O6hq8TcNq5VNc8qhXKTXOKwnkZ1vpa
 74n12+k9H3hsbpX8+1IYJABf9FjpDsiPqDGspB7c5qwHdwxxECWuEW6p9K93KA84iqarmuLrLpA
 XqyeK1KA6yyce/2IkAPjmq/5ddTAIO1iHk07MotKUgJ0hzofNuFHdGFyxZd5aDQ/Il+GOxRlKVU
 eUUzAR7A+xfoMPDP/dbs2p4/PczDxVhzFl5FbjvMMoW/FooBZC4RMf+LpS+Lsw1C7oTqVgcW44b
 wObs8kuaP56NzkWnv8uga1P/aTPxKu+Gj7/OAtAdB6sLmx7i22TmIVFuB2ojInbGznbL5VAr5RF
 HVL4amFjxR69hW952zvU2UGp59TNC/TC/pq8LghAXGiwtXVBuAhXNcObf+2ZqatxY4hCYdZDYql
 bg/8Z6kMOgg8mFNXYKhUo/nxqyoAOHtZWzwO3B/I4/d3Dw3xMLYjDUx7ceVRc2XBIqP1ijWuIMh
 /ZtsLK6EctukGKQ==
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

Introduce clock drivers for three new SoCs and enable them. This allows
for configuring UART and USB on all three as well as controlling
relevant resets and power domains.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Caleb Connolly (4):
      clk/qcom: add driver for qcm2290 GCC
      clk/qcom: add driver for sm6115 GCC
      clk/qcom: add driver for sm8250 GCC
      qcom_defconfig: enable clocks for qcm2290/sm6115/sm8250

 configs/qcom_defconfig           |   3 +
 drivers/clk/qcom/Kconfig         |  24 ++++
 drivers/clk/qcom/Makefile        |   3 +
 drivers/clk/qcom/clock-qcm2290.c | 192 ++++++++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h    |   4 +
 drivers/clk/qcom/clock-sm6115.c  | 199 +++++++++++++++++++++++++++
 drivers/clk/qcom/clock-sm8250.c  | 282 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 707 insertions(+)
---
change-id: 20240408-b4-qcom-rbx-soc-ddd6603e31e1
base-commit: 0e4dafaae9f627bd5294095ace157a506b38e7b3

Caleb Connolly <caleb.connolly@linaro.org>


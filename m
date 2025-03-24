Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B947C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 18:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91532808AF;
	Mon, 24 Mar 2025 19:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qQ0AS39v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACFD081026; Mon, 24 Mar 2025 19:17:50 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13347801CF
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:17:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so945449f8f.2
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 11:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742840266; x=1743445066; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yL72CGN3JzWuts0RW7eGrRAarooDEBH8BQJWlqFFM+A=;
 b=qQ0AS39v1SfyW+0NBqjA91lE+o452zx9eMHQH1jvJi0wiCo8zGMfwXB1gEhBsagxFm
 BTfzpft5DO0DhL/zXoehXrs0PezuIUPhksqc6RiLdT/9OJ17ZWXgDQ9rsOZ8t6wr/59C
 e0WVSF4v2F1+A0nTwocsJwJn4gvPvPe9sM06z711lZ8wy0VRXN+sc5v8imRPEakiKScx
 0JtvxRV2Iv3sBsRAzK0QTLaxpkCsjwpADBUs9wYNW/J8CiDn2pXWRPFefSo7jGv/FRRk
 n9b4G9SNfIlDncyyGD3xelY7EfPfpX/grjDtt1EyUV30ilt0dJDJHuQPth5Gx3FP1EqH
 vNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742840266; x=1743445066;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yL72CGN3JzWuts0RW7eGrRAarooDEBH8BQJWlqFFM+A=;
 b=gOA2wCudKdf4Qc0zjrPVKvJKD9LM5hXx06xVcWS8zxEoW3VYZ8T+hvjP+SsaKiwm+B
 ePoSqSe5GXO9kksIhqFnZ5nm84e/7vaj3lsPqMgc2CCQ1zGurHpt8Cpp5lLAoFaATQ6z
 1Sv/EZK4WRgsWkR/QKMN6b3YANdHZdjX5Q75CUFMUucNgxtEv+X0XHV5EKEVIEyHS1xf
 DTpFCQqCJQ+RcyrmF/YB4ufH8E/ZnWYR8M4kyKEUDsZaVX3/64eBPqHGrN0Ymgj5hIIQ
 FUZ07CJDaaHYFN7BJyOMqP1xmTiZKwt32f3db/hejquVBWbxEq5eYUIZScPqsVYujdJf
 Tqwg==
X-Gm-Message-State: AOJu0Yz3U3enfMxTcpamNFqCTanPtODKj+tvzmGwsBWNySCUQH90CLKR
 4Q9m/CehcEt6M2m8OJIuAmzalIhnPZ5KBXlgpmjT+Yy2ZevrTZ9z794OVmP7zuk=
X-Gm-Gg: ASbGncvx5j3xzrV42zhrWHGV4gf67DlSmhh0arZyTpXxXnxlZq+joX7ubseEM/aOfY2
 YFg3HLUURhPDsQ/BsdPb1DPKlBUt5UvFjXeWXkoB9VnYubgNPuzyrlE4IB6uysHgE//vDYJk5Cc
 ob6LkJBnX3qX50qcpL+a1zyVrREWYxhlMbInQBxvA8gF5v16VVbWcR2hUbkPGTQaIjBY5LttUPO
 +l3GuWiVySYwvKNfimBfHSB/AR7OkV8WGtawJdqboUS4fr3LrfQNK9cHb9DqwWqljpRwDmtWZNA
 KHgZpqK9mx+cp0yLvGvZMXt6F4rNf2hTcwtqS3j8IKapcetY8iDrlWAYzaHuigGFIiG8J/TqbPJ
 Z4LPmnSd/fmqq
X-Google-Smtp-Source: AGHT+IHXEjCjKZ0hx1om+3ChUJ6vbbzcTOPr1tgUU1aWJC1kvKu9NVE9Ryr13oFNqfhVuq01n7sncw==
X-Received: by 2002:a5d:588e:0:b0:38d:dfb8:3679 with SMTP id
 ffacd0b85a97d-3997f901202mr11066723f8f.17.1742840266433; 
 Mon, 24 Mar 2025 11:17:46 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e6450sm11690651f8f.70.2025.03.24.11.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 11:17:45 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/4] Qualcomm: fix sdm845 clocks and enable fastboot
Date: Mon, 24 Mar 2025 19:17:36 +0100
Message-Id: <20250324-sdm845-fixes-fastboot-v1-0-d177a10f336d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMCh4WcC/2XNS27DMAwE0KsYWpeG9fNvlXsUWcgSlQq1rFS0j
 QRB7l4lRlddzoDz+GCEOSCxsXqwjHugkJYS+EfF7JdZLgjBlcxEI3QjhQJysVcafLghgTe0Tim
 tgEL2WkvZS/SsbK8Z3xdl+nk+csafrfDrUbKIRObNj9WB8+EP32gCOyf7TbBz4OAcml4r3wq0J
 zLROnOvbYqvT/8cIbpmUAPntRo6UVABeQs1hXk3pzksJqc65ctrOxlCKE4M61g5O7VGY9dq7tn
 5+fwF903EVRsBAAA=
X-Change-ID: 20250324-sdm845-fixes-fastboot-e238553383ef
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=n9r3Eyw74M3VaVCh9CXpfsd+NtTRuwDosD6ZmQ+pFUY=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn4aHHzaKZYJEFWrAhW0PEeXICcb9DEj+MnEXsx
 WGSwu45jbaJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+GhxwAKCRAFgzErGV9k
 tpA4D/0ZDuM+Iuo32m+H17BA/SZDjh2ysb/4CuRAyJgD399nrYAwLK89J7GawCeAYr0Zi6hnRLt
 yF2EEkA3ZilbgSz2wZ+bn3ClpHK7Ii/2MWsM1/MHTZfPFlkj8zNPJkkxQtcFWfvqLBmbabdE5gK
 zG1c4PMjr7br+unUtG95BCAj1BD7+TvH0evgz3EYtgHnbs1hV16UwkFG/E+KT9oSNPKkE8y2hFa
 7OtSTHvrsgUKNGGdkyb4nI7kortYCR1uVYEvQxD9POjn6m9813EsbAeZQ/L6iooUk3t0MFve8rQ
 0moeeQ1wCEFeDVAhkF5Al4Onrhi9vAgxP6h0tr+uLcAsefAD/f09ouuGPjlc9DJH47QjezV6VJ5
 MX+ns5SnRzG5qzrndKUyzL/W1IydBoM7eq/2sfqaJ/Cbo1nksM3DtbzYPoIWMlk7UnetgoRwCIS
 gIX1p2t6E3e3ganuV4OPX1A9p772EOxmc78MKWXbJYg9NV/DKx0CuSiK1U1oyRjqUGwmzA89Uov
 +cyWwEiyZ+DYyuj9iF0kbJ76rQZs8caw03NJp9Buia9X8p6OzC6croyjno4kDy7rWpYIONNLHtp
 hhNPc0fUfkbgqBhk0ZJ/6Q1gTHpzGtgujNwZtJRFT0eBkjYf4k/e65syryK0l2/CG26tiTJT5C3
 yIIR9Q+ny2mXUkA==
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

Fix clock init failures for USB and UFS on SDM845 devices, stub the RPMh
clock controller, enable DM_USB_GADGET and fastboot support for all
Qualcomm platforms supported by qcom_defconfig.

Fastboot isn't super useful yet, but can be used for flashing MMC
(either internal or sdcard).

Depends on https://lore.kernel.org/u-boot/20250319-sdm845-usb-clocks-v1-1-ddea854f62ec@samcday.com
Depends on https://lore.kernel.org/u-boot/20250227094911.497219-2-rui.silva@linaro.org/

---
Caleb Connolly (4):
      clk/stub: add sdm845 rpmh clock
      clk/qcom: sdm845: add GCC_AGGRE_UFS_PHY_AXI_CLK
      mach-snapdragon: enable DM_USB_GADGET by default
      qcom_defconfig: enable fastboot

 arch/arm/Kconfig                  | 1 +
 configs/dragonboard410c_defconfig | 1 +
 configs/qcom_defconfig            | 5 +++++
 drivers/clk/clk-stub.c            | 1 +
 drivers/clk/qcom/clock-sdm845.c   | 1 +
 5 files changed, 9 insertions(+)
---
base-commit: dcb6a5e7651f4a6cebfad4389119407e2a852783

Caleb Connolly <caleb.connolly@linaro.org>


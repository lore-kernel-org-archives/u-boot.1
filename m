Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBF9ECE579
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 10:30:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F61688D84;
	Mon,  9 Sep 2024 12:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fTCsM0dq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F132188D97; Mon,  9 Sep 2024 12:30:37 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F11988D84
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 12:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c25554ec1eso5468608a12.1
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 03:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725877835; x=1726482635; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9WUVUui5kQ7yz63vIDdE2W1GzhpKYGd87s3MmwT/DCo=;
 b=fTCsM0dqRokS+ln5IHwGqR57y/UQy5Xna83Q/ruNqdNZ41GE2xvvl/2ZAyrxaWCyCu
 3bf9wO/JhafdBV/DBEVe8o1OzKhDT69+FZX4zr2mi0GLrnh2AMWhiAirZJvqc9Vk4lXm
 cHXJcCs2doHzdqXqUPvXW8NA7X848NkZi4ggDtB7vI8bFoS99TzwzszcyC1V6eMFvmCj
 Gf8K0S6d/6W8Cy38z2/y69iRykCShoDf41lRMI5eSO66Qb4x/Z3bCk7HECfpnV+2+PBJ
 rlW0ik+zSBBo8VlsoEysXBmpu9ZuHZfUy7CGiBeT0bNHEO80mWUfhU7iCksC6QOPb37s
 ABcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725877835; x=1726482635;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9WUVUui5kQ7yz63vIDdE2W1GzhpKYGd87s3MmwT/DCo=;
 b=s1tBKtZQHhukpnaK5RXtw3HisiyGk+EQM2HalcXxD7KLtZkeAaMGHGwC+uSkOu+Dx0
 8ZXhre1hEIGQZ3kymeATLNqvrx5oWQHedbXZm2kKNkbcy3JgKNjshz5DWFrUwnKedn4q
 sVLAxm6bns51RTjiF/QfUiWUL9hL83YSJzK67T+R0gUbY+0yFjXerzWi7OM+Wv/g0UMb
 F6L2zXOPCBBqiOYgvB6PD1zixsj4a3mBsJO3Oy+Z7dPJG6pLaGnCytycmAXaQzY3ZrZY
 z8zLLDEzN3fAIlc9EKSww4CYIFGeQZVd0COwDL1ZruXPlfQCSqyYZUMBJmTHvBtzt+CF
 gygw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp74Q6TtC3FLWTnQ4hTQf4AQnHmTlHatbaNZ0jXYLaFXETo6+ZijZmWZAfdZzOvU6AxYH7010=@lists.denx.de
X-Gm-Message-State: AOJu0YzLlH009xfhRu7x2G/FxVpzn6nHPAoC+l83hHJMSIZM+w73JDxH
 FbWLdKVz8RAFlqorXdIROf6+7s5tYYHgiCrFgeG/ptmJ3FS1lQHayQ7nvIuAWGM=
X-Google-Smtp-Source: AGHT+IFe8FkCmq5gJGKwgtlgrKWzQWflKv53Vd0OIvEoPKawdjxDzClcRuIfwfTRefG/AmMbzkYxuA==
X-Received: by 2002:a05:6402:1ed4:b0:5c2:e888:4cd3 with SMTP id
 4fb4d7f45d1cf-5c3e974ba73mr5991285a12.35.1725877834844; 
 Mon, 09 Sep 2024 03:30:34 -0700 (PDT)
Received: from lion.localdomain ([2a02:8109:aa0d:be00::8db])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd46733sm2822287a12.27.2024.09.09.03.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 03:30:33 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v3 0/2] clk: add a stub clock driver
Date: Mon, 09 Sep 2024 12:30:31 +0200
Message-Id: <20240909-b4-clk-stub-v3-0-ef09307534d5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEfO3mYC/13OTQ6CMBCG4auQrq3pL6WuvIdxAbTARELNFBsN4
 e4WXBhdvpN8T2Yh0SP4SE7FQtAniBCmHPJQkHaop95TcLmJYEIxLQxtFG3HG43zo6G2tJWxpi6
 170he3NF38Ny1yzX3AHEO+NrxxLfrx1Gcbc5uOITkMdLEKaOllbpxomXG8fMIU43hGLAnG5bEF
 /h/JIk8FpZxWWntpZI/43Vd31dpHJPoAAAA
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1972;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=L0Y3jnTzgpDcYz8/pE5xRV2g7d1K6/tou9U99sY0nRE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhrR75zySf7zxFVrms7HqquuPl/XREUtdzY9XTecU3PaD6
 9a9aYWPOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEHD4w/LMsSJ/4+/nKxY8f
 dFXzfTj8zOP6qy2/TbyPqW/ZzjFRcDEvw3+vHT/kGNvkm18G+qnVv/67u+VVp/029RNLPi1d3v3
 sxvJ9AA==
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

As U-Boot works to align itself with upstream devicetrees, there are
some common issues we start to run into, that of hardware blocks which
might be important for an OS like Linux, but which aren't useful in
U-Boot.

For example, the Resource Power Manager found on Qualcomm platforms
includes clock controllers and power domains which are only useful for
managing power consumption and enabling low power states.

As this is not at all relevant for U-Boot, we can safely ignore these
devices, but we don't have a good way to communicate that to U-Boot.

As an initial step, implement a "stub" clock driver which can be bound
to these devices so that drivers will work as expected. Add the
necessary compatibles for the rpmcc and rpmh-clk controllers on older
rpm (non-h) platforms and the sm8250/8550/8650 platforms.

To: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>
To: Sean Anderson <seanga2@gmail.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
Cc: u-boot-qcom@groups.io

Changes in v3:
- Add 8250/855/8650 rpmh clk stubs
- Link to v2: https://lore.kernel.org/r/20240527-b4-clk-stub-v2-0-29013855e343@linaro.org

Changes in v2:
- Take the other discussed approach of just implementing a stub driver.
- Link to v1: https://lore.kernel.org/r/20240410-b4-stub-drivers-v1-0-6935bd2c07d1@linaro.org

---
Caleb Connolly (2):
      clk: add stub clock driver
      qcom_defconfig: enable stub clock

 configs/qcom_defconfig |  1 +
 drivers/clk/Kconfig    |  7 ++++++
 drivers/clk/Makefile   |  1 +
 drivers/clk/clk-stub.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+)
---
base-commit: d0f74bd417daf6492975ce346843ba0767caf51c

// Caleb (they/them)


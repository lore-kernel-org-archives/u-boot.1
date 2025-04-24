Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB6AC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 09:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC94381F54;
	Thu, 24 Apr 2025 11:17:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="egdMrItJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2655981F0B; Thu, 24 Apr 2025 11:17:02 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C3DA809D4
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 11:16:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so6390335e9.3
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 02:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745486219; x=1746091019; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mZN5KEjT2NI4w6Mbv3KGkq81xV+xFSp615FYIMkkW8M=;
 b=egdMrItJISmxSc1xyq2D3sSeKE4JbKQDzf+b8cwR4wMVqOkmD8r0I2jSqL1J6IE0SI
 MD/bHkGRnQGoab5Awtktlgq8t0gqS+P/vI5UQdp8BKcNyliuI7Z6vug7f3pJw64ARycX
 JJJTaA+SFeegc56y86iwkJQzK/4DyFgFT6wFb2zkKq3ZDG0Sm3e/Azxd87j4erFAIQIA
 NZDjqL+6/2hqbuj1uSXP67MTTqAR1Q+zEfSwfHl9MaiTVQCd6ikEEH0RU2DNFmfiOJDt
 +0qVlJwXzg73S0xN3NrcFAAff7uwBvAGP2GlbObEPN8mltumHTE072YE8uc+QxZsgUtG
 fjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745486219; x=1746091019;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mZN5KEjT2NI4w6Mbv3KGkq81xV+xFSp615FYIMkkW8M=;
 b=YnZYKmB1lhIulTZC5warBgubx564RUDtZfPN6XIr4jvjlF55wjkx7ubHQD+buetzGF
 nX9h/UdDyvaVbTzw0/ok9Uufb4QRB3S/cSdOIXDFMR+5nuF55hE46q+4B468TA7DfDEL
 lHkbBRRY1lLYV1dOJan1Juulr/TKW+XFdLgN+m7HYkvUsbZQsFI4Ebd+hKVScmMR/Ccu
 rK/wxFsfKCgby85+Jrs7WKj9OtymVe8YHZMb8uhYisGpVQBxDM3V/vS6CGujeSp8SCNH
 MSbYH+MQq5z7Mo/udxyfvSpV6P7QJc5WCjn6QfjjQIpwKigUHRfB2EP6fQUFJ+lpllL5
 3zKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOFrkahy0fQakvroDv1pEkFCPDUGF5ZkpRAYOWest2ky+NBmZ6Iv63Rcm1MKWwYprLyDpkx2k=@lists.denx.de
X-Gm-Message-State: AOJu0YyIr/QQ2mmpjNXvM08NjfM0/fj1O/6fjtRF8PpDISZZBQWG8MFG
 ebpQltSjQ6Ns7OuaYl+4opJRWnTrTh9txZzHL4FsJ9sKE2yGNgtNDfofQB25mlA=
X-Gm-Gg: ASbGnctMq3wYvXbQfVXMZYbCwRTVSkQ2I9Azq+fCrYNdGkmZjVFPoRLHBix0ZKtFQR3
 kzp8F83cNBDaVhmk+lrXSbNZPC9rLkRHlJ0jLTbVm1kXtLgLHVasr+jdtk8sMAtiPB4iYBrWWFA
 5MAV1dQaDPjuljI3Yae2P59awU0ef496M0JApCKSdOnts3znLXnW9sDzYXlgajI9c79SBLlb5uf
 c+w8lD8a0BDsSswppxU5bJvTI54boQ9KWlC9RNkfU7jJLHwl4FaBj2gj/o5WupS4/aKDL8YRfE8
 HqjyvaEFaVIHNfLH/x2TBVGu4oLjySDiS+hm3kimaiRmo4PhmKU=
X-Google-Smtp-Source: AGHT+IHqqT9cbEUscKYwxVWtlrzennTRFbZjgqOW4zO//EHqwqIUlIi8IvMZ56ZoJr/6YYfDF1cbSw==
X-Received: by 2002:a05:600c:a403:b0:43c:fcb1:528a with SMTP id
 5b1f17b1804b1-4409c818aabmr13221125e9.6.1745486218806; 
 Thu, 24 Apr 2025 02:16:58 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:d677:e5de:3a6:836])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d1e19e1sm13000945e9.0.2025.04.24.02.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 02:16:58 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH v2 0/6] clk: qcom: apq8016: Clock fixes for U-Boot v2025.07
Date: Thu, 24 Apr 2025 11:16:40 +0200
Message-Id: <20250424-apq8016-clock-fixes2-v2-0-fcc371c9e45f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHgBCmgC/22NwQ6CMBBEf8Xs2TXtAo148j8Mh9IusJFQbA3RE
 P7dSjx6fDN5MyskjsIJLocVIi+SJEwZ6HgAN9ipZxSfGUhRpUpdo50fZ6UNujG4O3by4kRojHV
 ctWRsW0JW58h7k81bk3mQ9Azxvb8s+pv+Bon+Dy4aFbadq72vi8Jbcx1lsjGcQuyh2bbtAyx3R
 dC5AAAA
X-Change-ID: 20250419-apq8016-clock-fixes2-66ace5b26ab4
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
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

Fix some issues in the clock-apq8016 driver that I noticed while testing
U-Boot v2025.07-rc on the DragonBoard 410c. Make it possible to poll the
clock status with GATE_CLK() to avoid potential race conditions.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Changes in v2:
- Rename BRANCH_CLK() -> GATE_CLK_POLLED() and clarify with comment (Casey)
- Add R-b tags from Neil (I assumed the rename is minor enough to keep them)
- Link to v1: https://lore.kernel.org/r/20250422-apq8016-clock-fixes2-v1-0-bfc9dd933da6@linaro.org

---
Stephan Gerhold (6):
      clk: qcom: apq8016: Fix SDCC clock addresses
      clk: qcom: Move qcom_gate_clk_en() to C file
      clk: qcom: Use setbits_le32() for qcom_gate_clk_en()
      clk: qcom: Allow polling for clock status in qcom_gate_clk_en()
      clk: qcom: apq8016: Convert GATE_CLK() to GATE_CLK_POLLED()
      clk: qcom: apq8016: Fix SDCC clock warnings

 drivers/clk/qcom/clock-apq8016.c | 17 ++++++++---------
 drivers/clk/qcom/clock-qcom.c    | 27 +++++++++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h    | 26 ++++++++++----------------
 3 files changed, 45 insertions(+), 25 deletions(-)
---
base-commit: 233fda6af674736dbc6ff37a9ef003b9fa4b8074
change-id: 20250419-apq8016-clock-fixes2-66ace5b26ab4

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


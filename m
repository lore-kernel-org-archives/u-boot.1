Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BB6C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 10:54:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C4EE8197F;
	Tue, 22 Apr 2025 12:54:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ivb2x4Pd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E129B817C4; Tue, 22 Apr 2025 12:54:37 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD619810E8
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 12:54:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5f4d6d6aaabso7073831a12.2
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 03:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745319275; x=1745924075; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GGrCqhjVCf05dwarrqpIwcZt6lBzmeing42kBoiGvq0=;
 b=Ivb2x4PdQh8SFNqoZuGzm/1XEupJymQDp+5JCbSuNhfWVCo3J6vR3Kd6kPVSmWTmIw
 blQF/Wl4ajya8vCPCIZMs8584VEAsFWWAPruOqVT/eNFpFV9phzEPJDowWOllSQz72dD
 XLNHUntbmQHC7IgrD5wHTpeEAcgT+HHkYg9m/bnd5P8tIgr1z+slQl/l4CByQVRDKUuZ
 DV+soE+jt73jhxzm19rfvA5PVZ89+41/kouuiQmQVMrPWALUd6Mjqvi95r1XV3LwnAWS
 WDYfZg5l9niyRbySyB0tCKVvp7d5C/FzHRfVLP8S4PofhNxjITweu6Ruj0hSKAWRQlvs
 wQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745319275; x=1745924075;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GGrCqhjVCf05dwarrqpIwcZt6lBzmeing42kBoiGvq0=;
 b=bv08PeYFmn1PI3gD+idBCRSMRDRpBq3+0TsgjsctU8t+CmFVR9Wk6HKWMwPYghgWrA
 aaDY7rdvxqNDn7ZGRL8grytp9hLhxJQEWgjGJlmWSOmED9lvaq2Puwf+462FfUNpzmp9
 hewl1msQVWR+SCtG6tT47WBwj0YRYRvo+/r1NVC+vPNKECql8XFRgN4Aw7zl6oonwNOu
 TBeP/FDrgDqxX0jv0ruG3BoGYImmX/1hDi/hpg+dH3coyDH7sqbb4IIhZpYcEpUhpbEZ
 sBlE47F8Tfh1ZAsDlFy21UXy+/2CeI67p/mTCBbvdtpyJU0zfZGl+2YWigUlXX1Vpac7
 ShNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUixNcb53NTbeDsUCB/K4cFAyA52WYvBiV2mzUDsdnTCzM1mOLd4bn1jDC1JBAOoMAn/teWYc8=@lists.denx.de
X-Gm-Message-State: AOJu0Yxok3n1GqmcFn/7fjfokIEx4ZIdLQZLHbiIeqn+xaAsgJ8Xiber
 PILm2LmgVptXdnYkhzguY6GE/pgbBa+gXkdCI0iifAwIbAdpduYYbTH68vkz0KA=
X-Gm-Gg: ASbGncsXC66fggOQ8a5IeeOzjo1ukC+l7aJLTNPx+g8Y/wRzhX8KWonafZUiT7i4jc3
 u5FwAsYXKDJiRiL3I3LOXsPUtr6vVmk3OLDUJ7Ey+6JNcrrF8XZdXi0qEVIJhQim74BS03AR8AE
 QGZsO6hnrN9OhA3UqZGocy6IOGvBB5HcqbVKGN04Ra0Tg7iEJLeKRgwvGUZUSP/pTrO+/GzX9IK
 jav5FxkqEIsoemzxnbxUzGIIxwDKoUahf3ADgmy0OtU3XkTB/iQHadgTeUIVl/lg32DL8TZx1Lp
 EtcEqYPVu5aQS6zlvjgXFyfgC9MAKiKRPAWPvH/t5rv0urDWtIQyNg==
X-Google-Smtp-Source: AGHT+IFP+RnJxUaMjgpaETpCNNdHwQNP3dyUGekQWbWN1ZDdaTXEuFSgBmkd/7zzI6G07LJx3I5x1A==
X-Received: by 2002:a05:6402:210c:b0:5f6:23d2:e6f4 with SMTP id
 4fb4d7f45d1cf-5f6285d8503mr11715666a12.21.1745319275177; 
 Tue, 22 Apr 2025 03:54:35 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:d722:61ae:90dc:b4e7])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f62554a1desm5709635a12.8.2025.04.22.03.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 03:54:34 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH 0/6] clk: qcom: apq8016: Clock fixes for U-Boot v2025.07
Date: Tue, 22 Apr 2025 12:54:05 +0200
Message-Id: <20250422-apq8016-clock-fixes2-v1-0-bfc9dd933da6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE11B2gC/x3LQQqAIBBA0avErBtQSamuEi3MphoKLYUIpLsnL
 R+fnyFRZErQVxki3Zw4+AJZV+A261dCnotBCaVFIzu059UKadAdwe248ENJoTHWkZ6UsVMDZT0
 j/aWcw/i+HzW8vS1mAAAA
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
Stephan Gerhold (6):
      clk: qcom: apq8016: Fix SDCC clock addresses
      clk: qcom: Move qcom_gate_clk_en() to C file
      clk: qcom: Use setbits_le32() for qcom_gate_clk_en()
      clk: qcom: Allow polling for clock status in qcom_gate_clk_en()
      clk: qcom: apq8016: Convert GATE_CLK() to BRANCH_CLK()
      clk: qcom: apq8016: Fix SDCC clock warnings

 drivers/clk/qcom/clock-apq8016.c | 17 ++++++++---------
 drivers/clk/qcom/clock-qcom.c    | 27 +++++++++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h    | 22 ++++++----------------
 3 files changed, 41 insertions(+), 25 deletions(-)
---
base-commit: cde0050618968aae335dfbc930641656d51ff5d0
change-id: 20250419-apq8016-clock-fixes2-66ace5b26ab4

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


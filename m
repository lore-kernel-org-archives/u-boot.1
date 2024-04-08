Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E69C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 13:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9521E875E9;
	Mon,  8 Apr 2024 15:08:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="evEH7/f0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99E088808A; Mon,  8 Apr 2024 15:08:07 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBD1187A80
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 15:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so5208261a12.0
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 06:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712581685; x=1713186485; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0FdEm4jzw6DKlCymKfrSZ3QJMbLcY5A81Rr+/HCfLig=;
 b=evEH7/f0qCg0F1JUIXw6bfUgTHbfLJQX1znUVss9GHLyMIdTX4nsB2gJV63T9Irby6
 s/0GyVmoKVS2irrq2KElJYTZmg3wdg04RwFSMrN0AmkstFBTpcjKzzE1+t3QdqInxcGI
 nQxq8NVYXt9PF1v8JuDipMn3cuK+C53VYovc77PSe9aYRXWm4rnzQDRmhvcFy1tKp9kE
 9f7PwQLOvKenGI8QDYviAL/Amx25uDqlGMsTm5DKeUBmr026JBucBTe0gaLmS5sehZfw
 k/v9m7gVmMXLuP6zZ5sMDUCln21ZYMfg1x3NfEp2dkaLYXfKnUVj6TBc1M/sMSx7e1rn
 j8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712581685; x=1713186485;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0FdEm4jzw6DKlCymKfrSZ3QJMbLcY5A81Rr+/HCfLig=;
 b=uxy9npk1VqCOnMEvggzvaEOsd+sQhlwtLQyyn5WsLgS9HERcPUpZlou+UhNzysxcsi
 2NPEjhYEDya6ExyVcX4khrr7V3YHY2PJKOf1szIzKc0ueniPX/AgTGDzbGmE/C0494TH
 S+gYH3zrP+W5KpM3J/wsEJ676aO4xVzNZapmwJpBcwrYgmlYv9KTs5Ql3X3tD5KZKXG8
 C02v73llYBZiBTXHQfcGF+uy1dcqPho0HTsxrkKefRPFjdmmLqCnIEJgPBHsgQdf5lQo
 kxrL1SlFchEnh1rp5hERCLwWKa6Nx+hgeqErYjgtloaCO0UIiWQ8/dhUa8hTr9fFDYec
 dH6A==
X-Gm-Message-State: AOJu0Yy8uvugWC4DXl2EGWaHXBgUPPVO1gayF3KluN9CWJbb0Su/mftr
 6TFzPs896c4Lsxhp6GoxSo86bG5vA7aBTxSaRUsMlk582GbxjYrXYd9QFCdWqcA=
X-Google-Smtp-Source: AGHT+IEHdjLvCWhVD1mBWVZupQ6pC1hZ6dVhYLczJ+v8Lti0nt807aU0oQqcDCly1c2AjTRCHl7uew==
X-Received: by 2002:a17:906:f212:b0:a51:b326:ed41 with SMTP id
 gt18-20020a170906f21200b00a51b326ed41mr4075752ejb.52.1712581685320; 
 Mon, 08 Apr 2024 06:08:05 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a170906844b00b00a4e23486a5dsm4394815ejy.20.2024.04.08.06.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 06:08:04 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/4] qcom: pinctrl drivers for qcm2290/sm6115/sm8250
Date: Mon, 08 Apr 2024 15:07:38 +0200
Message-Id: <20240408-b4-qcom-rbx-soc-v1-0-900db37b8bdf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABrsE2YC/3XMMQ7CMAyF4atEnrGUtFZpehXUgSQGPNBQB1Clq
 ncnogMT4/+k961QWIULDGYF5bcUyVMNdzAQb+fpyiipNjS2IUu2x0A4x3xHDQuWHJGI2fvYh6P
 3UF8P5YssX/E07q08vyr83MefO5i/akqp62zLrWMH47Z9AJaDsZaoAAAA
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=912;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=dUY+gbhuBljNvkwtJXjQ5c3kyK68vt5CXDRuaNS0M40=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmE+wzLjnTTBZjr4zuR9Hny3WIK98EUGEKkk7pu
 8phbaLcI22JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhPsMwAKCRAFgzErGV9k
 tksnD/4o6O9KzGyc+Nli/l3lUwEy6zUCQzXI83jDfdFRUaEGbB77zHNB/GcJUIknzF71syotXxz
 h7zz7XTICGhksbxAxp8zi1wCjfbYxMKd1w9+tv6KUVfH1zHIYOs5krhRptS64Hil1UFxp35rOl8
 d2hiqxUSu1Ba25YVpzI/L5s+av1UdZ793Uy7yl6LMSx0T10BZTKkpNjTO4DMAUusWcS7uoqZ6NY
 3iW2gLoNJdLy9R/aa08sbWMPykqSzvxtBuobARbu2F4fBBXIkqAH5Kj1qWbRfYvEtG08auY6sN+
 2DttqB0GH5nDWTcQ9P79+SAbyyhhNQCXv9RdFILOEdOeCOJPpzOtooBCGNWJ07mzvl3SDbKRz2m
 WgdXpFWm60N01KuPDpbphB4GrszOBLtCg4FK3+w5cXHZTCEsLX7E16ZND8dFKhFs4VGTHuK+XQX
 UsqWutGdsQWmO5i1X6gg5TBZlCIiRHZo68xrx7gkSRyulEIQsDAo+si/n8bfa41SKxezJ475Gx5
 SSCXMhwUQXQmmaxVrBN94PY24jCWXdorGf3Obef+VsmMvg1EiAgUiRTd99y2dEf8GAYHgqydjNa
 TDCcZ1+K92qbGX+K2jA6IGfPkSaYbEBAWG6U1yCgngHQHjqYtyvXneQj52pjCJboge2Au4SCvFL
 I4rQoVJAjVMJSPg==
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
Caleb Connolly (4):
      pinctrl: qcom: add qcm2290 pinctrl driver
      pinctrl: qcom: add sm6115 pinctrl driver
      pinctrl: qcom: add sm8250 pinctrl driver
      qcom_defconfig: enable pinctrl for new qcm2290/sm6115/sm8250

 configs/qcom_defconfig                 |   3 +
 drivers/pinctrl/qcom/Kconfig           |  21 ++++
 drivers/pinctrl/qcom/Makefile          |   3 +
 drivers/pinctrl/qcom/pinctrl-qcm2290.c |  67 +++++++++++
 drivers/pinctrl/qcom/pinctrl-sm6115.c  | 197 +++++++++++++++++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-sm8250.c  |  96 ++++++++++++++++
 6 files changed, 387 insertions(+)
---
change-id: 20240408-b4-qcom-rbx-soc-44ee99c8b799
base-commit: 072eacb0c7a2d7a621b581d238422f0254c78cb2

Caleb Connolly <caleb.connolly@linaro.org>


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F01CCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 16:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8E4D8312A;
	Tue, 14 Oct 2025 18:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="poMy/a9x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12BE7834E5; Tue, 14 Oct 2025 18:03:54 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0583807B1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 18:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-421851bcb25so2570491f8f.2
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760457831; x=1761062631; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lqf/9ETwkExouuXV3BvnMhWpGLR2tL3yi+9oTXOLF4I=;
 b=poMy/a9xQEQyRik/N8I9In1rI5RXFtg4WXz/AJqvVPWALIBwdfYtwCzs+LYhLQZPhi
 +wk6csIhWOKsSGWGUZH2VaQhc6YHSlzwTSe3UONxOKmnkfwNhFFhDvold0qW5bzFGhvl
 hVej8zmOwerYQ4hFMxQZ9VOpFPwBr9LKDLdISvPxr+d+dfBGXhmzshMAi2Boj2k+yYLa
 /SduD5kLU/+L6WvGH9Hy57w8dsPXzh/f4gyGYQwv9Fj/vnUIdpO7PSb036px8IH9PYDA
 HUvGozeMb4hypA/0XRHb8mC6/y9HWngZOWD6lKBNRIQYX9w7ofuH5OEI8kYTjk/z5Trd
 MVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760457831; x=1761062631;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lqf/9ETwkExouuXV3BvnMhWpGLR2tL3yi+9oTXOLF4I=;
 b=l6eZaN/o4IG4aq3kbBizzeAFWJDEXn8ojOEP+BcvXj7ReCd1pV8kkfTlRfEbRo627k
 bWAha6y7IxmU9TbO94ESsJgG7N3fizOwOYyikrMOdQgrhH3mR2kqSiJt3WaA8GbG1LT9
 ZBHIf8WYZSVja1X/gB3rtKiJC1EG06aXGNgXQtZUPtBgbZhXk1DH6fzhEk6/6qJzy4NS
 7MCwPchHor9shxFEku9hXeG+9fMfAkPaEw/iRV+9GoCg1UapALXJhMdict6yf/+E//H4
 jDFT1T+Ux/JJUlKdiPq00flNFWVqjLgvLIED4dPAnImOLAMbEOmky16sKRaHPzGG8eeh
 uPvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJIlM5Oaq33MPVQRgXWyqi7TSJTfPvwVhnDOd5Bj+mqm8hRTY9g3UZZyJB3B/zQAH3IweM+Xo=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8AZBrFyjD1EVGqHJmjZS+9EOFxEBC/xdsli2W+h6R4M8XQA1G
 b42qNRjoHWdddEhFz+YQztdw+LN/5VsD5ovtlmBNlGr/GQMLVXuuIDVXj/sPM2Dzj0o=
X-Gm-Gg: ASbGncuJTXuHMWPLV4LpnVIbPOgbD8kXStBjUSsat9TSZuWNNAyazTBT92WIkeYrmqo
 Yn65+Nlmu1K9k1/uCV3RkO0fzpVxpevuOa5cfj7vDXxkYrXb3BL/MYBYH4OwBtXlfYYQlmP7fDo
 /gd04yzJ/lm2oiSbtFyvhH8KEQCy1gyYGCscbG1m5yjxs5YJaw1THcNI7mqs2/2WUOXkxQ6G8pB
 YisUW7lxYpqJkdg04HQtOyzc2d4181htDQejc/Mmz8fYpBmj7sx8fvwJXCX8J5JHweDf6PlrWWd
 DQJlilkPfb/B2nHLxOv7cqTimeou7N1AKSVVxFIiBkK3PedR3DW37kaXhhiEP9Lq5JpSeM+QBzw
 FWL9bn5GHhkVI8marT9Puz+jMX58zrKETzmZqNtoW200FQRaRaAe9OwrcMh47RBX0EDrWDJ66TD
 10cTzM5HB8
X-Google-Smtp-Source: AGHT+IF/5Wmmv1ua6T3LAiGhyoCba6UK6TERqk/0RKZpmKsCLikI8yx0DU/RfcGgRmOcFjJF+/X0jA==
X-Received: by 2002:a05:6000:40ca:b0:3f1:2671:6d9e with SMTP id
 ffacd0b85a97d-42666ac61a1mr14186370f8f.1.1760457831134; 
 Tue, 14 Oct 2025 09:03:51 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:216f:297d:c441:f2cf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57cce5sm24864380f8f.1.2025.10.14.09.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 09:03:50 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v4 0/2] fs: semihosting: Test correct variable and fix API
Date: Tue, 14 Oct 2025 17:03:49 +0100
Message-Id: <20251014-fs_semihosting-v4-0-6f2bc490175b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGV07mgC/33M0QrCIBTG8VcJrzOmzs111XtExKbH7UBp6JBi7
 N1zuypGca6+A7//RCIEhEiOu4kESBjRuzzK/Y7ooXU9UDR5E15wyYqCUxuvEe44+Dii66mSpmp
 q21ndGpLRI4DF5xo8X/IeMI4+vNZ+Ysv3Zyoxmo/xEqoOtJbsdEPXBn/woSdLK/H/nmevWa0El
 EwpozZefHqx8SJ7aSsDTVdbzuWXn+f5DdZQDsEtAQAA
X-Change-ID: 20251002-fs_semihosting-85d697fbfcad
To: Sean Anderson <sean.anderson@seco.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

Smatch reported an issue that the wrong variable was being tested after
a call to smh_flen(). Investigating this showed that the API was being
used incorrectly and attempted to return negative errors through an
unsigned return value. This in turn also limited the returns to being
less than 2GB. This series allows the use of file sizes up to 4GB - 2
and also corrects the error detection.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v4:
- Split out changes to smh_read into separate patch
- Link to v3: https://lore.kernel.org/r/20251003-fs_semihosting-v3-1-5f6de9b7f225@linaro.org

Changes in v3:
- V2 missed fixing up one use of smh_flen, fix it
- Link to v2: https://lore.kernel.org/r/20251002-fs_semihosting-v2-1-c1783e4188d8@linaro.org

Changes in v2:
- Fixup smh_flen and smh_read to allow for > 2^31 byte files
- Link to v1: https://lore.kernel.org/r/20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org

---
Andrew Goodbody (2):
      fs: semihosting: Fixup smh_read against overflow
      fs: semihosting: Fixup smh_flen against overflow

 common/spl/spl_semihosting.c        | 13 +++++++------
 drivers/serial/serial_semihosting.c |  6 ++++--
 fs/semihostingfs.c                  | 23 +++++++++++++----------
 include/semihosting.h               | 13 +++++++------
 lib/semihosting.c                   | 28 ++++++++++++++++++++++------
 5 files changed, 53 insertions(+), 30 deletions(-)
---
base-commit: ecdc3872a767fb045be3296d4317ae978a14b022
change-id: 20251002-fs_semihosting-85d697fbfcad

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>


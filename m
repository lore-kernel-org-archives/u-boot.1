Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC54CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 13:19:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1571083869;
	Fri, 17 Oct 2025 15:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1xwAyp0t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCCA783893; Fri, 17 Oct 2025 15:19:24 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E8B983804
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 15:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4711825a02bso7809835e9.2
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 06:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760707162; x=1761311962;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YDPAkJzKorzhbUpcgx26glYcltCHd+VB2sVfGsT+Tm4=;
 b=1xwAyp0tfPFdhW7YipyapupJ7ZtIZt51A5fGcfrHy4efu72brrxZGvxzlZ3dorxiPh
 bwrlbW3gDZSyhh7HgChJg3wVVy/i8yboDlM7KADVEEpekVSql9rs8YSCSAPC7RtUoEje
 N2JfB7qyPvTCSUCxv3g4mu4hUt0FhfAjamKmywzzH8SwcIKjdayGoaqKJR8tH5T9a1OA
 HdCwHXBw7trhn2MXkc9GGBGvkB2Ehb521RrZOSGir7TKaO6zPTayHijBhwd40IYuQTKj
 BX09AqnlNuSYC/jNlqnpAI6PYBdPId+GdLa7ol3yxS3fNS1qHiv2Q//B1Bd8KTdlYK79
 HJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707162; x=1761311962;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YDPAkJzKorzhbUpcgx26glYcltCHd+VB2sVfGsT+Tm4=;
 b=rRKrZyM1VIhcH5Pg8yXJgzm0ALaePJaYBVewY5UEBQw7KGnDVCHiW1e2uzFQcEtzE3
 a35zZuXk5X8qNuPar2eq68PXFV02DYn5GFz1OdcOgpSUhjUJADjAXvCmidhqvZ9q8abC
 H+rXZbAIZ7jnjwuD+M7bojHXh6KAt8/mTtwvZh4inDn1jHPeBUHiBULPXqML+Kl3Mm9Z
 4RB6CXQylXH6ZZgf0N3TbBgP4EaV1walCFRg6Hg9wCeTgLwHyKVcstWc1aUD4B23zZzd
 IZ0Us6lrVTZkRssKE3PTmJCJiPszVrW99ouokjNRqnGJyEBrwrSbG0KZf7d5/AYjCmmj
 jpSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDvquRLvLArNxZ/5UJlIFoPtzdBxpdEmGOsiN/EmlnUdlJOpF1tLxzK4U7qBdGh4zOSOJBthw=@lists.denx.de
X-Gm-Message-State: AOJu0YwcwJ++nTjqeLmK97+xzt+GdhWZv9RwZ+C4zbJhLG0JV4l9dksy
 WDyChDnKwi8Ob9w1YRefsepugNLZIQbvKa8VVp5k5pcRcw3oZgDiNICrEOwcJgOxiO8=
X-Gm-Gg: ASbGnct7AxPfKdU3KFxkQsnm5HAgumuMIWDOoNupQqx/nhiGmYWgpfD2EiUQ4iXP+PM
 v47WDX0vW+6ZzJ/vy0X7wV4PTMYCouEmQatXedpN5FhOcvjVZ0S/wnE+9T++WMwu0JA95xD/6YJ
 kq6MsXs8ikquFA0S0ul1kyDAIgjwGXPl+1GWC+ZtHveQktGmEJQ6TFnNWeYhEkYZss2PGFiCU31
 yGhhO0RvYguyVLeyvY9nP/t5U0tPwFU+fGklK3iyZn3+IdXqexX31PSTEKbbOP0XX1IGWbrv28/
 HZCKESEAYDBLmEFcY11o6DmQdKhILxYQcFvFOLYr9osCGXrNzWqNFLs1P/SiLPAkwhFVJrwUQav
 arJlO77shBDvO/lMjC5ErnqlRD7+YumCxMHvqSILlfBIT0OOlv55oT2EO31ia4fbdaijnexFchD
 ehEbxsqz6+Smfp/sBlLGaGN6v2
X-Google-Smtp-Source: AGHT+IFQ5T1UJTff2K3ai8FPQvwifFgLhD8aySE5s2f5rQTiW12oFlLQ056/NDH1eQ69YA7h27mjEA==
X-Received: by 2002:a05:600c:820b:b0:471:1717:40a with SMTP id
 5b1f17b1804b1-471178a8245mr27071605e9.18.1760707161830; 
 Fri, 17 Oct 2025 06:19:21 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:4f9d:9005:7d78:d1f4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710f2ab58bsm44395465e9.10.2025.10.17.06.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 06:19:21 -0700 (PDT)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Subject: [PATCH v2 0/5] android: add bootconfig support
Date: Fri, 17 Oct 2025 15:19:16 +0200
Message-Id: <20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFRC8mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIxNDQyML3aT8/JLk/Ly0zHRdI3OzVCMT86RUS0sjJaCGgqLUtMwKsGHRsbW
 1AKzHLA5cAAAA
X-Change-ID: 20241128-bootconfig-276e247be992
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>, 
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Maxime Fournier <mfournier@baylibre.com>
X-Mailer: b4 0.14.3
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

This patchset add support of android bootconfig partition[1] in u-boot.
With Android boot image v4, all androidboot.* arguments must be
passed via bootconfig instead of using the kernel commandline.

[1] https://source.android.com/docs/core/architecture/bootloader/implementing-bootconfig

Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
Changes in v2:
- Add test
- Add new command to be able to load and read bootconfig before booting
- Somes fixes to works with sandbox test
- Link to v1: https://lore.kernel.org/all/20241128-bootconfig-v1-0-0e63a5dae82c@baylibre.com/

---
Guillaume La Roque (TI.com) (4):
      boot: android: Add sandbox memory mapping support
      boot: android: Add bootconfig support
      cmd: abootimg: Add 'get ramdisk' command
      test: abootimg: Add test for bootconfig handling

Mattijs Korpershoek (TI.com) (1):
      boot: android: import addBootConfigParameters() from AOSP

 boot/image-android.c                        | 180 ++++++++++++++++++++++++----
 cmd/abootimg.c                              |  35 +++++-
 test/py/tests/test_android/test_abootimg.py | 108 +++++++++++++++--
 3 files changed, 292 insertions(+), 31 deletions(-)
---
base-commit: 2ba64e303b2706e5c42a6bf982326d632342ca66
change-id: 20241128-bootconfig-276e247be992

Best regards,
-- 
Guillaume La Roque (TI.com) <glaroque@baylibre.com>


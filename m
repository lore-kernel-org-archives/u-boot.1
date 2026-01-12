Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9B0C9EC6E
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 10:55:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 853A983B7E;
	Mon, 12 Jan 2026 11:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WYBwEvUp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4397F83DA6; Mon, 12 Jan 2026 11:55:44 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8C3983B5E
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 11:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47bdbc90dcaso44336635e9.1
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 02:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768215341; x=1768820141;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7tKv5rZvyQD1RWCkqMsE8y2lzLODzE5HSDDbZqiHx+I=;
 b=WYBwEvUpL9kGs/50nnOedmJPaT09enp5QDyazLnHGXpKyljdx4eOgPuYIeJyhoUx27
 /BzByOsyaMVPMAcaLeMAKuVjwmYbYfUQXpsxJlLo5vsXx6K2NjdEU6C+rHiHuNzLrxOG
 ySo5v7Rs6+4F8iYsx0m9HQEVKf2X3DUBgGeMF2uwQkwbc750Q9JbmLk5y/RAVZo7f6g8
 0t8RL51519NmeY6WRANEE50LMdst6ysVSB3LyuXKDVfjh8M9tYPgYq1y02bXNAltgdXo
 PQD6QIun8M7ufMLBH6DVnX8sUzoBNSdC3+5RiJoeSAvjNbcKXzCSrPZRQa43kKbaOlDF
 PDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768215341; x=1768820141;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7tKv5rZvyQD1RWCkqMsE8y2lzLODzE5HSDDbZqiHx+I=;
 b=HVkAGiU199h/xGeRESBCbyxxWCxZAycxPp3/vUNAPimaGxrEKrZ+Idc8UvMPjOXyob
 jYvVxQ+gg21q3rBgpXtNmnZH53+i87nXU+TSedmP2IGHCpnnk4CvmTiFqJOKUPNdaTSA
 MM1z553uTFitGpQ0qnrWfgI/kG4s+TzqJuP2ELsow7op8pRagcXuh51RL1GKYnbtF9Zb
 K5DJuHGmjKhUbEV8MbPn2cSRp/QAvHGyt2L17umdFN1o3Q9Cif9FtSt7XJLqhQ2317tw
 IcTkDMAlo+DS5qfdserHv1XlTD9MPP+7+OJPWFOJrNqDvywxIRzOV+RY/II8F7UqXW8h
 T+NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXbkdE71oaXRWNVzDn3yBdug7aoy13XZQWMCHVj4q/CxvbR8y9QyVEafGTfVAWC7WK6wzasMI=@lists.denx.de
X-Gm-Message-State: AOJu0YzP0VjZwE5bOLFi4iHNwCwIMK06H12gP/tAcBL/4Q0mWcB4lXcF
 9QxYxOqK6jF/x3ragBEVPsvyQ7yhN+CD6c9SRwmBRqo3SPNAXteXwPGXSVoyPeABnPE=
X-Gm-Gg: AY/fxX4LwzB7CYeYDpV3miikIjMR7GZUQM9BfS7mPonDSVbMmItHA+QTcES713On29S
 Oomv3ID/7ms0tCTPgTNDcFs4dog/tve8POkzjf9QO2/sAUxvC1Hc3krw5+e3H1X1hMk82RqSlp3
 FAU1ClK7QJ3+B43JZzbuJCtnKvfDbdNkdzyY3jdvs0RA7My8hEQUmNxHPnQFy05DtFr9oLdlj6g
 j99B44MTI8NH4WFeTzzkz4LThzKu3y+VmtNDuYPaGo4p3+NdCHhlbtdASmM1Vme3CmpnOzy7CR4
 3F8x9dTZyICtzsE9Pg0gs6ISNxhU17PuQm6za2wnm/jiziYUjx9CeqxZ9NuAw57p/xzNkQVpkIa
 Qe1rdNWJd6qp/8SieI20Na/+OCZSFrHUR7jQv4kQydFnfQwhgW6SkMmo/dkvRc/vof4D8fn77Qn
 fZtdh77T/HZ8l1mQ==
X-Google-Smtp-Source: AGHT+IFd2Sycqbm84+oiQeUD9pvda8pxE7JBsbilVZIdNmI5S8L40n3bQyaemoAy2VzBYokwDPhHcA==
X-Received: by 2002:a05:600c:3152:b0:47d:403c:e5a0 with SMTP id
 5b1f17b1804b1-47d84b184abmr202516405e9.12.1768215341239; 
 Mon, 12 Jan 2026 02:55:41 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:ad8e:46f0:bbfb:2e18])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df8besm36145393f8f.26.2026.01.12.02.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 02:55:40 -0800 (PST)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Subject: [PATCH v5 0/5] android: add bootconfig support
Date: Mon, 12 Jan 2026 11:55:36 +0100
Message-Id: <20260112-bootconfig-v5-0-79b242159ac7@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACjTZGkC/23PQQ6CMBCF4auYrq3pDMWCK+9hXDBlgCZKTSGNx
 HB3ixvEuHyTfH8yLzFwcDyI0+4lAkc3ON+nke93wnZV37J0ddoCFWoALCR5P1rfN66VaI6M2hC
 XJYoEHoEb9/zELte0OzeMPkyfdsTlumRyUGC+MxGlkoU1FhvkXBt9pmq6OQp8sP4ullLMVg2gN
 zpLusKCCshqqkr1R+tVI2xeiDrpnIhqUsRQ2x89z/MbxU9arSMBAAA=
X-Change-ID: 20241128-bootconfig-276e247be992
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>, 
 Sam Day <me@samcday.com>, Maxime Fournier <mfournier@baylibre.com>, 
 Eddie Kovsky <ekovsky@redhat.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Guillaume Ranquet <ranquet.guillaume@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jerome Forissier <jerome@forissier.org>
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
Changes in v5:
- Fix android boot test.
- update actual boot test image instead of recreate new one.
- Link to v4: https://lore.kernel.org/r/20251218-bootconfig-v4-0-5bbbdb0be1dc@baylibre.com

Changes in v4:
- Create some subfunction.
- Update some variable name.
- Link to v3: https://lore.kernel.org/r/20251114-bootconfig-v3-0-a28b813dba90@baylibre.com

Changes in v3:
- fix test check
- reate subfunction for bootconfig append
- Link to v2: https://lore.kernel.org/r/20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com

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

 boot/image-android.c                        | 272 ++++++++++++++++++++++++----
 cmd/abootimg.c                              |  55 ++++--
 test/py/tests/test_android/test_abootimg.py |  91 ++++++++--
 3 files changed, 349 insertions(+), 69 deletions(-)
---
base-commit: cbff44d3d29f73324b313c1ee6629ec6e904054e
change-id: 20241128-bootconfig-276e247be992

Best regards,
-- 
Guillaume La Roque (TI.com) <glaroque@baylibre.com>


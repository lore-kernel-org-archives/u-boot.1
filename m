Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DD8CCD19A
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 06:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E14383D3C;
	Tue, 18 Nov 2025 07:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bn2fivHP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9518F83D28; Tue, 18 Nov 2025 07:40:55 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82B7383B95
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 07:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7881b67da53so45440727b3.1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 22:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763448052; x=1764052852; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/U53VRI1F29l8cPpaVb07vIbtNvyrLYQDi5wruBRrCc=;
 b=bn2fivHPAlegRr0s5x8QG4da0CtEuzMAiO+eZ6aVI0XCC8tjHwbWpBmnS+SY6SDttx
 e/qUfnZvHygnX2G5SfJMS2q2ceomPf1f84UvF/ToRUpYri5Y0547N7XsrtVydKl/ClVU
 uENo4yNlNLBsI7HLKD240/tZ3UQI9VOPa9dMlQfBt2qoJQgu/mO9y9UfP2sqgQs7Ldu2
 H3IzB5ULTrG5rXQaJ4uJR30bQ2K0exIxs5iD3H7f71XW09BTC9S8S7Rqc39wZVpedmPb
 FCo1JnkHVlqE6pV6S+aPrnWRWG3u2mwifuNh1tUh0EMf4lEIw5caeySqi5fCt90b2+MC
 fYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763448052; x=1764052852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/U53VRI1F29l8cPpaVb07vIbtNvyrLYQDi5wruBRrCc=;
 b=t0jDb7q/dUlm7ASeKPyVvAOXQvRHUjbTVm6cnXdKljWQQhgbGRqjFxzsK0Rnm/7u00
 O6o6DiOoYZfvKo5p/OgJeHwWer7CkKyoqBmyQ0bIanwGQjJojYFsVj87urAaqmsIHL+K
 ta1sxd7XAGx3hGW7nxhvAE9h7uBbhMJkGQD+pc48TOk1rv0Qz15QGW8+J5PAlKMXgjZ2
 H2dFZ8BBO0fk22aFbX/khh4jLLDBYPthti+qMrFkOIwodznMAIZ9kQ/YyiyjQ/VBIGod
 054dxANROs1xWYLVoUDUiNZb2rM3EXU/s/HNpQfQe8lJoeL5nWxQ1EmkKjmwQRoKjmau
 0iKw==
X-Gm-Message-State: AOJu0YyG1tPQxPql0H4LLvcffTmhMf6MqD39Bm8waHVGKlhYV/8ZtPL/
 chQxGjNDuIAlc2ufouPaBLYHC+0hgFpTYur0GTVXaWD1fIlyKdYoPRMNdCJ2
X-Gm-Gg: ASbGncsZ/kzR/urSIfdpt7purgIHb5MPAJ6G2+rsYB9yHnv7/DmeZy/R3iulIzYSiNN
 h3wcatM0u+15CvYrqlRi9HuD4FCmnwBynnUpcCiEMOXR6d2On4Q8aCdAYTKkTybVf/CeFwJbl6l
 y6guAAfRMKDAc4H0Qzfvl04z2yTJHdUPAVXwDk7nlpDKM/u4BCzeVCzgWwTvkN64xq1bNihvv2i
 HjjX8z1LGy7xRZNv2ipT0uvc4kWOXj1mRPJqVkUmYP9cvLIs4PuEnweeHjb9pdWRBYMQBBoPzcT
 SLbxlKvzdzr89OmkUQ4u49xVNM4B+eKwqgIeNJKESi3U8eHgLtZIAFuWAhgHZMfINee0MyA/Hpu
 jLU7EmGnwnuNDkYZTFo0P1ED/u7D/BP1/1F2l9WSmepEOx/ytfXJGoR/gxmg857mp6yN2y5aExX
 QBirxSDbACHeXJlcW+qN95NG0BRg==
X-Google-Smtp-Source: AGHT+IEecF01Ht1cDTmrUsKQUvxPNDRT24hTyuca+7/r4HsN/Ka9oI5yZTLyZ2VRn6K0I9quigBt2g==
X-Received: by 2002:a05:690c:6f8f:b0:786:6b92:b200 with SMTP id
 00721157ae682-78929e50e5fmr143122597b3.30.1763448052033; 
 Mon, 17 Nov 2025 22:40:52 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78822128160sm49781967b3.32.2025.11.17.22.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 22:40:50 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <stefan.roese@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Yao Zi <ziyao@disroot.org>
Subject: [PATCH 12/12] MAINTAINERS: Update ADI entries for new boards
Date: Tue, 18 Nov 2025 01:39:45 -0500
Message-ID: <20251118064000.14613-13-malysagreg@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251118064000.14613-1-malysagreg@gmail.com>
References: <20251118064000.14613-1-malysagreg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This adds missing maintainers entries for the ADI SC5xx defconfigs and
for a device tree binding file that was previously missed.

Signed-off-by: Greg Malysa <malysagreg@gmail.com>

---

Changes in v2:
 - Possible files relating to ADI were identified using a shell
   command like so:
   $ find ./ | xargs grep -i --color=none "Analog Devices" 2>/dev/null | awk '{ print $1 }' | tr -d ":#" | sort | uniq > maybe_adi.txt
   This file was reviewed and entries unrelated to ADI that merely
   mentioned the company name were pruned, leaving 111 files.
   Then, maintainer information was retrieved with:
   $ cat maybe_adi.txt | xargs -L1 -t ./scripts/get_maintainer.pl --separator , -f
   and each line was reviewed to ensure it matched ARM SC5XX. This
   identified one extra file that was missed previously.

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 60772a494a3..a6be53de500 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -637,6 +637,7 @@ F:	arch/arm/dts/sc5*
 F:	arch/arm/include/asm/arch-adi/
 F:	arch/arm/mach-sc5xx/
 F:	board/adi/
+F:	configs/sc5*
 F:	doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
 F:	doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml
 F:	doc/device-tree-bindings/pinctrl/adi,adsp-pinctrl.yaml
@@ -656,6 +657,7 @@ F:	drivers/timer/adi_sc5xx_timer.c
 F:	drivers/usb/musb-new/sc5xx.c
 F:	drivers/watchdog/adi_wdt.c
 F:	include/configs/sc5*
+F:	include/dt-bindings/clock/adi-sc5xx-clock.h
 F:	include/dt-bindings/pinctrl/adi-adsp.h
 F:	include/env/adi/
 
-- 
2.49.1


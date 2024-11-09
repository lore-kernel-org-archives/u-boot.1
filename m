Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2A1D5E37A
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 18:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA05889235;
	Sat,  9 Nov 2024 19:01:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mLjQsc7u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75E9C88B9E; Sat,  9 Nov 2024 19:01:11 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8779D89048
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 19:01:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37d49ffaba6so2164987f8f.0
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 10:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731175269; x=1731780069; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=goVLxNLspJxwz2GPctR+ELXyVt1pm9Yrrf2UtSkRHzY=;
 b=mLjQsc7usbTDEJfiMk2emxIk80BtNMfG+rpGFQO/Cn2psevreXSQwwwB12IYsQlcqY
 InmlRuolI5SKQ7hgRvMlzf5IlPxfSR8U9/hTv5ICuNX60UHA2l/FMUthJ1A0pEY0ofCJ
 bs5/2hHg0fHUsj1NqWN5GF7iQfoiueDMpA/WYJtNNK0omjC0cFRwZbnthVKLFBnSPw9h
 c/u6eTYtzrxmnxuwDjBYQS/IeNf1TP2rAgoLNd0YfubkwtckavU6NEFbvT+09RtOHwuq
 0KkBlfQGIyR1qUIaH2RPCRjtFN4TmHA5SXSjTs7Lta0zBfXWjxspQ1kqRh0xTWYKlszm
 roPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731175269; x=1731780069;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=goVLxNLspJxwz2GPctR+ELXyVt1pm9Yrrf2UtSkRHzY=;
 b=gvMKReGtGL4CArRuAJUyxPUFlUAEo4P7CvuBuaDqS44T6YTiSj0AXoCpXBcuJpFd7C
 sB+WKwpFdW/QWsjes7jkJ3cL1ff/xCEXIyc6NC4/DhIgPGRACtbIHQ7vcifeLDmX5lF4
 cmlr28GjSD6IB6YmD8esA3avSFiFb091oXbULr8YOLQAwMWTpufBXS+wJAbNe71JvAJx
 JPwGPzi67wYSBMpTrSKRkx3txIu5fxEuRR4fsSXsXrRQxH2THYhUIiDMAC0tpmxxvVSp
 tWOX/ziYPlYx0y+yn81BP3K5x+LJ7MvQubQzUzmTzD615GTahpiemCG00zZS93U5NLhX
 0sfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIwLJoq7JJhKCfF6ZfcOoN1PxXw5WQABjwlGWU8PnLFXTreY3iEY/APxfDfT1nNo/jrIGtwMU=@lists.denx.de
X-Gm-Message-State: AOJu0YyZD9E6jxgWqRpTLSqBwcMx8GIwVhO+P/Jq1fyF1ELkRKKeJbj3
 C5VwfVdjE8DaWWHw8gi5WvyiXgB35MF/6iLylcF2UaXr48u0GHAT
X-Google-Smtp-Source: AGHT+IH/WeSAvSvDWyG5St4gzWRnxVkNQN77kgrKyf1qw47ZyAHgrUQyvT27aXG3R+qJLmtG8uHPTg==
X-Received: by 2002:a05:6000:1f8a:b0:381:bf27:e845 with SMTP id
 ffacd0b85a97d-381f18270cfmr6423951f8f.1.1731175268787; 
 Sat, 09 Nov 2024 10:01:08 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432aa73a2d8sm146095025e9.41.2024.11.09.10.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 10:01:08 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH 0/8] led: update LED boot/activity to new property
 implementation
Date: Sat,  9 Nov 2024 19:00:25 +0100
Message-ID: <20241109180038.10344-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
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

This series is split in 2 part.

While adapting the LED boot and activity code to the new property
accepted by Rob in dt-schema repository, a big BUG was discovered.

The reason wasn't clear at start and took me some days to figure it
out.

This was triggered by adding a new phandle in the test.dts to
introduce test for the new OPs.

This single addition caused the sandbox CI test to fail in the
dm_test_ofnode_phandle_ot test.

This doesn't make sense as reverting the change made the CI test
to correctly finish. Also moving the uboot node down
after the first phandle (in test.dts the gpio one) also made
the CI test to correctly finish.

A little bit of searching and debugging made me realize the
parse phandle OPs didn't support other.dts at all and they
were still referencing phandle index from test.dts.
(more info in the related commit)

In short the test was broken all along and was working by
pure luck. The first 4 patch address and fix the problem for good.

The other 4 patch expand and address the property change for
LED boot/activity.

Posting in a single series as changes are trivial and just
to speedup review process. (and also because the second
part depends on the first)

Christian Marangi (8):
  dm: core: implement oftree variant of parse_phandle OPs
  test: dm: fix broken dm_test_ofnode_phandle_ot
  dm: core: implement ofnode/tree_parse_phandle() helper
  test: dm: Expand dm_test_ofnode_phandle(_ot) with new
    ofnode/tree_parse_phandle
  dm: core: implement phandle ofnode_options helper
  test: dm: Add test for ofnode options phandle helper
  led: update LED boot/activity to new property implementation
  test: dm: Update test for LED activity and boot

 arch/sandbox/dts/other.dts |  33 ++++++++--
 arch/sandbox/dts/test.dts  |  16 +++--
 drivers/core/of_access.c   |  61 +++++++++++++-----
 drivers/core/ofnode.c      | 118 ++++++++++++++++++++++++++++++++++
 drivers/led/led-uclass.c   |  30 ++++++---
 include/dm/of_access.h     |  86 +++++++++++++++++++++++++
 include/dm/ofnode.h        | 107 +++++++++++++++++++++++++++++++
 test/dm/led.c              |  18 +++---
 test/dm/ofnode.c           | 125 ++++++++++++++++++++++++++++++++-----
 9 files changed, 539 insertions(+), 55 deletions(-)

-- 
2.45.2


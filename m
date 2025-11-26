Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29605D11184
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 22:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E247F83AC6;
	Wed, 26 Nov 2025 23:50:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CeAqTsvG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FF5983AA9; Wed, 26 Nov 2025 21:31:53 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F415839D9
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 21:31:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47790b080e4so400555e9.3
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 12:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764189110; x=1764793910;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SL4n5rOX7oEG734wz/rR8EP6d4WyQy1hPReiJu5d5XU=;
 b=CeAqTsvGX379n3PsMyzllxIIJIHhn68bL9DsDygZnR1wkd03t0MQZAjJhLzSiKH2gK
 RQYIW1im/9iASAcR81tujxKVbngs3jU5S4Flg9T+tm80jyoxLj5erIL6JSDdxxM1VzhF
 Gr1MrF4kFDPm9OibIaQjnGl4ZDkEcylR8WaDf0k3Rf3mTfQfES3er7tHy7UhPxYEXhuR
 TkmpXF+pfIpK4pL5U2iO4nZFYvyWFQ5+NhnCSEhEP86bjE1CLbU24WPijExLHqKd6Q/7
 aSh4F/iugIxEuIBLix/WlqxEMRtEev+UT5YWONCrrKgONGHMEWZCuo2RcZ8Gi1cFghyU
 BXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764189110; x=1764793910;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SL4n5rOX7oEG734wz/rR8EP6d4WyQy1hPReiJu5d5XU=;
 b=J0X0VQpBTodSdMk7nmQ3nUcuCecQcPbTGD4/rDS6LAXv0rI1kz8u3voIqQdRCgQih4
 b4WGqOKQIr9ftKnquazG1LmyGW8Gv+YmH268vcqf51odpW0QkBl8rgA7XGVY+1y5aYtc
 yZKuZdV8Cd+l7T6tCpKS4AgKyDLw6ejxu5XSGFs106BXEhnZaXuuAgNa6K5OZnRI94lm
 GDVNVUUz+0Wm8ObWi1eTpMrEVup8gCiytI6szXPQksodvCQCvDSTJvuGoccB8+l7kyNL
 d3GOWDZ5gMphjzwCeTpMSYNp1OBh9flY9o9dZXf8CnlZmbdKZKazJ45q9WnbrPw1ESBh
 35gw==
X-Gm-Message-State: AOJu0YwPZAVZcMkz8sBH5sQilLBxhq5FmIOeh3GEFvz9k8Etbij5wm8w
 nfrNNdSEjEckCWH2LH3wXtseVGj4pCuQwVQJzdLbAdVxRyObVvdhFmaxYH0xstehSjg=
X-Gm-Gg: ASbGncu7gI8aiAyZvnf+rhQaniPbmazxPEMZ+MtnuWfiVWBiyGu8qxrDxWlykIuNHTI
 H2Y4Nf7/A5n9YkqHK9WOKoKJUh2af/paASqGozVre2ugcTrTvzP2k5LC1QPJcwItRGsPJeehy2l
 GVNWOAC7YZfZjSOu+tcATdXYq8l5B2qdz86S8u1D+ww04LqWCdo1JbY8lNKNZrFuVweBXjmV5rw
 AvrqjdpHCUwGTiSnpGNGghfjdaSjZyxkrxLWJB/0CQnvZ0uHk5l5trUX/kmVd+xJzNbFob03lF4
 lECnWpXW3wETq97kqa4vqA/FouM8Ndwh7R05ZSO0ttBTSrBXDTxRmqQQgrX+4Dc6WJEsJEcz6nq
 IwuxWR5rCTNfetxgMAJ/fsSka+1K9+bkIk+I9OZP2HcsYh8ouCO+TpN8EaN6lrNSyKkn0vAds4e
 ChsbkQ8Yg=
X-Google-Smtp-Source: AGHT+IH4aHR/QQWXvtgWyH+EvE9cZBxcl4SR8zLF92FM4XqXHZMUIbCczyrku1S6scvj4vWWC36XZg==
X-Received: by 2002:a05:600c:4515:b0:471:13dd:baef with SMTP id
 5b1f17b1804b1-477c112566cmr172861995e9.26.1764189110416; 
 Wed, 26 Nov 2025 12:31:50 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4790adf5387sm57812515e9.12.2025.11.26.12.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 12:31:50 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH 0/4] dm: core: Support same compatible in host/gadget musb
 drivers
Date: Wed, 26 Nov 2025 21:31:06 +0100
Message-Id: <20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIpjJ2kC/x3MSwqAMAwA0atI1gZM/eJVxIXVVLOwLa2KIN7d4
 vIxMA9EDsIR+uyBwJdEcTaB8gzmbbIroyzJoApVE6kaD+dlxv2MGn1wWuyKV4oNFoRUVqUxpqO
 20ZAOPrCR+78P4/t+0vReom0AAAA=
X-Change-ID: 20251125-topic-musb-probing-v2026-01-1343fff8176b
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1527; i=msp@baylibre.com;
 h=from:subject:message-id; bh=0yD0u6+U3Aj/0vlJiKafbZARiQ4snEKTREdMQz9MGVY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkz15DmJ2rumRjxcNbNmfW/Wy3U5Rq86d5qW6ATKue7rV
 hN+cUe4o5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACZiJsfI0GI2/aqJwJl51wXO
 PXsibvX1rjXHM0bGVqYCrVOc52YaNTD84TjKrX89xV7im8JKjjuaxQoRM6b+bVE0/aW+ImnPtSx
 BPgA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 26 Nov 2025 23:50:13 +0100
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

Hi,

musb currently uses a wrapper driver that binds on the parent device of
the actual musb devices to manage the differentiation between gadget and
host modes. However in the upstream devicetree this parent devicetree
node can not be used to match the wrapper driver.

To be able to probe the musb devices in host/gadget mode directly, this
series introduces support for returning -ENODEV in bind functions
resulting in iterating the remaining drivers potentially binding to
other drivers that match the compatible.

It also changes the address parsing of musb-ctrl to be able to parse
relative addresses.

Best
Markus

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
Markus Schneider-Pargmann (TI.com) (4):
      dm: core: Support multiple drivers with same compatibles
      test: dm: Add compatible multimatch test
      usb: musb-new: Relative ctrl_mod address parsing
      usb: musb-new: Add compatibles for ti,musb-am33xx

 arch/sandbox/dts/test.dts      |  4 +++
 drivers/core/lists.c           | 62 ++++++++++++++++++++++--------------------
 drivers/usb/musb-new/ti-musb.c | 36 +++++++++++++++++++++++-
 test/dm/core.c                 | 15 ++++++++++
 test/dm/test-driver.c          | 25 +++++++++++++++++
 5 files changed, 111 insertions(+), 31 deletions(-)
---
base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
change-id: 20251125-topic-musb-probing-v2026-01-1343fff8176b

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>


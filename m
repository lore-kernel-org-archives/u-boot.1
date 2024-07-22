Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B135C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E00A8865D;
	Tue, 23 Jul 2024 15:35:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="BPHnGRIp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3F1D884B2; Mon, 22 Jul 2024 22:24:42 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EA6388276
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 22:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-426526d30aaso35537075e9.0
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 13:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721679877; x=1722284677;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mvYzIB9BhdW/03zcTCCBLarWmyQzKEi+D+MZhtkgXmI=;
 b=BPHnGRIpVxFbVME24YXCMZX1ShcShd6T5AlPF/7ld0TlQBZN/L1Nu3zoVC44rbqe3C
 2kMybvM39TUT+GG243tAhmbHw38w7SdKBKqRJy94dGkcIESr5WJ8YLPrNpVIraUjsuqY
 UrjBWjdNd5uGhK6ZMfa93AYdye8J08eot7s6ixBN3aZzAWjbWtV5MtN4H7GNGAqaCfP7
 IuHnrAWvCrNEmgRLP9r5B/3L7fWPXFLrgwx1UmzKRem+m7nmTFhmTKLqsoH3Q0JyIpQj
 X9BFrqQKibfU2JlSBGs3pJ+K6tu1NG6WXH4Z6OtpOnk6WUYk1KtsN7Km6yNjxSBxUorB
 M7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721679877; x=1722284677;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mvYzIB9BhdW/03zcTCCBLarWmyQzKEi+D+MZhtkgXmI=;
 b=xKePKMO0gYWCNNJ8+zG16J5r8g/oT1o3nfyVDhg09vG3W8Xwwylt7goYlAFT+xka9V
 56NPpGRgtaTu9ym9U49lGl6RS6/fmn9EdjVFi825t/yu9s/57okg3DPwJ/zOyVH/pRiY
 oBuM6Qj6w/CrcRRIGOhWat0pOGakKQEpz08QvDwwkzHFmCysaeF9HSbim9hTUvKjgjvI
 uiJ2Dtz7au4Epm8oFDB3k4XLFAz/4xwps4rBaWaBIhm1sdJDNFqpCpXG/ncQIYNOEAJy
 fwnV5soRTnGSgRE0yT0wF3y7vzlVqWpTgeN/bSzpjd6gNCZAo2qiok1Z+78/8H3nunA2
 cHPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWZBxHm9qwlX+BznNiTNOiEyBIUbnsRoFJbQaDSvMLzbTimgov4M1mkum0xkHCvMZp8mzthhiCTNTFNPBmb0qSmmTyWw==
X-Gm-Message-State: AOJu0YzkavBzKmPcUcpmWAW5Rw2taebYiLE6KaGCTRUMP/l06pqeFnJ2
 dM7ZXmz/5xUw2/ynKrIJehUVm6HEdc2I1Kjd4vxURXtEbkPsfeQyyWtn+xIix9Q=
X-Google-Smtp-Source: AGHT+IFHvfYNlYcZc1XYhH3od2xKpt3dP8KK9iOqBYkdw6c4s/E8s/YH5qdsZjKtKLD/ODofLLlZBg==
X-Received: by 2002:a05:600c:384d:b0:426:5d0d:a2c9 with SMTP id
 5b1f17b1804b1-427dc522895mr58632855e9.10.1721679876718; 
 Mon, 22 Jul 2024 13:24:36 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69071d0sm142982855e9.26.2024.07.22.13.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 13:24:36 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
X-Google-Original-From: Zixun LI <zli@ogga.fr>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>,
	u-boot@lists.denx.de
Subject: [PATCH v2 0/4] usb: gadget: atmel: Code refactor and DM_USB_GADGET
 support
Date: Mon, 22 Jul 2024 22:23:26 +0200
Message-ID: <20240722202426.190986-1-zli@ogga.fr>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Jul 2024 15:35:55 +0200
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

Changes in v2:
- Fix null pointer deference in driver unbinding
- Separate code refactor into 2 parts
- Remove dead code

Changes in v1:
- Based on [PATCH RFC] usb: gadget: atmel: Add DM_USB_GADGET support:
  https://lists.denx.de/pipermail/u-boot/2024-July/559503.html
- Addressed comments, moved the refactoring to a preparatory patch.

Zixun LI (4):
  usb: gadget: atmel: Code refactor part 1
  usb: gadget: atmel: Code refactor part 2
  usb: gadget: atmel: Add attach/detach support
  usb: gadget: atmel: Add DM_USB_GADGET support

 drivers/usb/gadget/atmel_usba_udc.c | 214 +++++++++++++++++++++++-----
 include/linux/usb/atmel_usba_udc.h  |   2 +
 2 files changed, 180 insertions(+), 36 deletions(-)

--
2.45.2


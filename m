Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91F8C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 09:23:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D11082F14;
	Tue, 15 Jul 2025 11:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="am4qMHeQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13D6183092; Tue, 15 Jul 2025 11:23:17 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C424882F00
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 11:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-455fddfa2c3so29569805e9.2
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 02:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752571394; x=1753176194; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XeROoRr244nmM7Scg+tK73qG/jMNPEX72MYwz2GB9+8=;
 b=am4qMHeQUELe/Q5U/8SM+u08pbUylj1sQUTO5uSLcvjfg+IM1mPO253kjUsWgBfYsw
 aHzk/gyZVRb4yRKktU68660xCUMmFM0xWZ6RdrgD1xpnTY9ne4RTH5Fjf/4r/7xEsOSW
 00uFBfnShLVCGuLJrthbOw651HgeGVv+kpFf2fXe+9HsuI1GxxYcwMwPNRcir8IqVa0Q
 NNjrgYdg/zpxTkBLeqbNQBzr1A7WIQGFtV+Qr/YOtR0jZSZhXN5kHw5+1514nu6BIFif
 OBt3dIemAbMb7EqnTyWBzDb1wfbpEXgPjK5oh+2uNFERonT9KUk/hECV+RXXbKJGlQbt
 QLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752571394; x=1753176194;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XeROoRr244nmM7Scg+tK73qG/jMNPEX72MYwz2GB9+8=;
 b=F9MZfqRP0MRqy1WWRo9ZjrX7vwHaAtJjBnkX2EF7oMefBCXfZCQnxZ6PJWlmVowllE
 zDu9zGaWrbWzOLKzAQ5BrOPfnWVhF1NwwOyTNepyCnMTfagivDATgJAo5cPVCSeWrehf
 RTudieue3q3hisI23iJ4X5SEwZRqAoMoel5qHcljYvXU92iNiWCkFg2iKwqWHQStGQe2
 ms+ap/5zBCvynWod5SkVKyuqm5L2yGynGnJQEMJC3POxEuE0H5u0QcWL2TybuglVjzuY
 /EOTmCMhdkoTSA3ZwjxB7Jh4PEWwwBGFCmAOe/QWqlTeaf04nXTN+efguBr8mKBM/+hI
 bj+Q==
X-Gm-Message-State: AOJu0YzRCpKMsxSOARCiSa8hOubxL71tgVn104UFzdowCS01aCPKnHB1
 fLpZu3AAlmJDdJ3SyG0H2NIV2ahw25+VYg5agn4wGHoOOkxaYt0cA71WsdsR7Gd3TdM=
X-Gm-Gg: ASbGncuel6TcK/K/cVJvAk2suMf57GZ+tfg6UOfHQcb8U0U/Xzo8GOszsQrocmMQPP6
 2/r24aY+7UvJa9RHApsVtCQjSMMVnTHA77hk8wRmm6gfDbmp6+gTZXQl2XKwy3H6dAgCIHHoeOK
 j7+12GFQVdtsuj89UnwyAjN6Flup5Tore+hDPaLoeNAs5Trl2d519fxlJ7IH+mxZAydxcgTobtx
 aEnIk2xB6RHHkQOA1ElKLte5yb5VIoY8E3HOUROZMmvY/SXt/dUTYXKT50qFi2Sc/ObHSCYkxl1
 YmXpV776Kmt+tdhEcVo6HcYhGJum+K1wyHj5RJMaXKn+n7IdV3/PyTbSuoynZkJ8NpGb/tzCvZs
 3BThmuoXjbGvGvJ3unVMU20DFDsHf1/ZGC40czc9Sx+Tcebzo2A==
X-Google-Smtp-Source: AGHT+IHD/10bIelo348C2zacQ/D3U51m73w9ix2+nAwQgOGqBFzT1zAnX9dPPgS44lhtLXXAZMP7jA==
X-Received: by 2002:a5d:6e44:0:b0:3a6:f2a7:d0bb with SMTP id
 ffacd0b85a97d-3b60a1456d7mr1152506f8f.12.1752571394091; 
 Tue, 15 Jul 2025 02:23:14 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:c1bc:9f9a:fc67:a1d1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d587sm14379588f8f.46.2025.07.15.02.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 02:23:13 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v2 0/2] block: Remove unreachable code
Date: Tue, 15 Jul 2025 10:23:12 +0100
Message-Id: <20250714-blk-uclass-v2-0-1bb1d2eee896@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAedmgC/22NzQ6CMBCEX4X07Jq2lp948j0Mh1IWaMTW7GKjI
 by7hbPHbybfzCoYySOLa7EKwuTZx5BBnwrhJhtGBN9nFlrqUtbKQDc/4O1mywwXUzXGSTVU0ok
 sdJYROrLBTbvytLwg7cWLcPCf4+XeZp48L5G+x2lSe/p3PylQ0GtldOPKoa70bfbBUjxHGkW7b
 dsPGFqNHr4AAAA=
To: Tom Rini <trini@konsulko.com>, Alexander Graf <agraf@csgraf.de>, 
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Smatch reported unreachable code in blk-uclass.c which led to noticing
that uclass_find_next_device always returned 0 which meant it had no
need of any return value.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v2:
- make uclass_find_next_device a void and update callers
- Link to v1: https://lore.kernel.org/r/20250714-blk-uclass-v1-1-d21428c5f762@linaro.org

---
Andrew Goodbody (2):
      block: Remove unreachable code
      uclass: Cleanup uclass_find_next_device

 board/emulation/qemu-ppce500/qemu-ppce500.c |  4 ++--
 boot/bootdev-uclass.c                       |  2 +-
 cmd/regulator.c                             |  4 ++--
 drivers/block/blk-uclass.c                  | 14 ++++----------
 drivers/core/uclass.c                       | 16 +++++-----------
 drivers/power/regulator/regulator-uclass.c  | 10 ++++++----
 drivers/remoteproc/rproc-uclass.c           |  6 ++++--
 include/dm/uclass-internal.h                |  4 +---
 test/dm/core.c                              | 28 ++++++++++++++--------------
 9 files changed, 39 insertions(+), 49 deletions(-)
---
base-commit: 074e05952705972072f52128cf2e3ec2d8f35de6
change-id: 20250714-blk-uclass-34684c01f60c

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>


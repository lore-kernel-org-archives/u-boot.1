Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79E6C2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 09:05:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26646887CA;
	Wed,  3 Jul 2024 11:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aOlKZppx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 142A0887FA; Wed,  3 Jul 2024 11:05:18 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06B63887C1
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 11:05:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a7541fad560so200474566b.0
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 02:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1719997515; x=1720602315;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mfPTeVB3NzRsQTJfcxwkIs7+YMouqHPrVYATIwK01OY=;
 b=aOlKZppxMlZbfwI6EWsKplRsWEFHGmCeE+ycMIP8NkRBKqWH+0NKMwKOlONkGUeSOu
 ZzZdu7tZN+hK//hnle/ynOoPCzTq0Hy/tKUrTtaOnBb4hPHhZ4KHuus35k+5L7Ei8cV1
 Q452F+9F/mrqwQo2HItTPACMI0sPyrGr1q9do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719997515; x=1720602315;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mfPTeVB3NzRsQTJfcxwkIs7+YMouqHPrVYATIwK01OY=;
 b=t63ABbPYG26TXc6lFk0n6umCeuk6EdRKlGTNnudU4+wHtKjDItsyvcYehQXd4kVfzY
 daZ9zXLDx90i4O9JztHnSbXdVWVW9W4CM+osGYp9n6X9BDj1jPO3DaxchWeR5L1UPZTE
 hH3TER0i2SAhco32AMf6NMFKnA+hCrjLP7wlEPwb+fom6X7akRB+gt8f00V+lXLXyUg/
 y1bKI/V0V69AQp57w+/Ayuvvpl8gZwdemU+Z9sbJssU1L7PO0XVNlnORfoRAQsfYo2ak
 yJPutA4nJKqAdmSsWqf49SxxuQwdol+75VCZlPGSgnxdYTPOF00IC2oKfvxLFwDOg+Zf
 zYng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUccmnFlCrEzTgqvrVNFa7+GcJVRXAyA6Kq5E2YPCou2cZNB8BumhRHeW4dgwfD/q6hCQqN2LN3cFasrxlwK2rkbETcZQ==
X-Gm-Message-State: AOJu0YzOmmeVHevboup4M6dg9d5lLnpihhgs1Gorm/qpSxIifSpu+Vvb
 qZr7o3jVkociBHKgHJ/yl0WZG4NYW2+Jdk1XtHIhNe51FU73eqsn1JO5LlFI1yw=
X-Google-Smtp-Source: AGHT+IEkw3KTn9T6JKo6zUZgB1NmoOcdkhKprAo6SSTNBn7gLrh1qXQWS0fg/qwGjj0+4gnjuafcqQ==
X-Received: by 2002:a17:907:5ca:b0:a75:3627:fccc with SMTP id
 a640c23a62f3a-a753627ff82mr459350466b.51.1719997515160; 
 Wed, 03 Jul 2024 02:05:15 -0700 (PDT)
Received: from panicking.amarulasolutions.com
 ([2001:b07:6474:ebbf:d622:a7f3:7832:9423])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf1bb6bsm491186866b.30.2024.07.03.02.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 02:05:14 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Lukasz Majewski <lukma@denx.de>,
	Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, linux-amarula@amarulasolutions.com,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 0/2] Support imx8m composite mux
Date: Wed,  3 Jul 2024 11:05:09 +0200
Message-ID: <20240703090512.92636-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

The mux ops for i.MX8M composite clk needs to be specialized.
In order to reduce the code duplication we need to make public some
interface and write a specific function in the mux ops. Those patches
implement the behavior

Michael Trimarchi (2):
  clk: clk-mux: Make public the clk_fetch_parent_index
  clk: imx: add mux ops for i.MX8M composite clk

 drivers/clk/clk-mux.c              |  5 ++--
 drivers/clk/imx/clk-composite-8m.c | 37 +++++++++++++++++++++++++++++-
 include/linux/clk-provider.h       |  1 +
 3 files changed, 39 insertions(+), 4 deletions(-)

-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84783C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 19:20:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2296381FEE;
	Mon, 31 Mar 2025 21:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="uSBoT21C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A224481F0B; Mon, 31 Mar 2025 21:16:39 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45E1C8171B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 21:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso34307725e9.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 12:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1743448597; x=1744053397;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6oadK+OcA5b2DyUZxGvL6GIIVvSbiTmnmlw/h9sKN8=;
 b=uSBoT21Cgb2rX2DZ7F3FLZGHbnqt3EEJiYuZKd7yltkxZmsgGCId+tULQGM/hN+Kp8
 MVpsQ9Oszhd7Q5GHB7RjOMhbZMIQTnClGejxHscRam521PGU8sIv4BnFEkTduvNk/dQv
 y744/y/FTR1KSCxqHOCwSDaFUDZqPS8AttiCe3Mqc37xHEE1bTb6vDXI/kAXWDgw+nsZ
 HNLOeLsOBpC9LuKkNDo89aZAA+49PTqdIDulGu2g2NoogGWL/Xd0SQsZxcVFDstgOaZv
 fUYsA191R1i0ho1LQg8Uo8c/elCrtdZykhzpn430KNtPD3auN15PFtqVQxPXb1fjhuP5
 MVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743448597; x=1744053397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A6oadK+OcA5b2DyUZxGvL6GIIVvSbiTmnmlw/h9sKN8=;
 b=HLOjBcHZsVYuU3v53Wl1UQpBvsOgxeKLmHGRZCssSsw1KGceTZ1szsJr9ScGcHCKfV
 Eu2koNL/pZBo8EXFSy9sxly205z/PEwqoTvzZtlI16kKta6jEPGoPlxsr6mO6pFWFOGP
 lJ7z2DGAB63T0NNZLuWKeChVgC38pYPluGxooNFbh1ZxllzcGGI3pPXbsqm0rMgSOjTX
 +q6CJfMNo1QMByVIzXrRfM+HFYJtuLpsmxi6JHk+J+JRhbICnYlnax4HcnCLYSo7oHXv
 kTA1iudYSX+20/T96Zt1b9u5Wh30qY3rMXB+kSxKVIWAvCebCUYmY5zZveMo4xkrtFJQ
 cOqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2yLeg4vB6jI4a9sGu3F1i73sqf7Dgi5o2ZJfMyACA7hvkKb7tm5tGpsWzFg7PAzXotflbtJM=@lists.denx.de
X-Gm-Message-State: AOJu0YzJgcACqFNynRl7KkXf7lXOo6KFzIPgEL5QqFcuvG25Qad7Gvk8
 26VI5U85U+GdQiwS7k6bFO5P2JI6euUg6Rrp7RKNJPNJms32H6b6mZBxPng5xc4=
X-Gm-Gg: ASbGncvZAPymaAdTmNDyg+wQvO8tv2NCUdashIUy1wWV+4jC9f3tWB4cMBvNn1/tjt0
 P7azOwKd/DjJSK72OmMOMSeCHczmg17zfrGBH2KrS0ndHWe2sl60jme8w+ZVmC3lg6Ec7yEnth+
 SlXJFtGuRixzE8YTcYiSsn9fRKVFPzCoZamYP+4rHza6JDcTkDUVOa0PdZb5LKMaLzS13yRG02n
 vHBTQqjc6g/wtLxgPbVuyLkzt3vQYTHW9JaIKq+7pvkkjz+i9XLN8nPZAWlBUzbRt3wunD+6MIH
 0sa/VY8N/hIGR/ARsZhw/MHgNGtIsQAKtfZpM7Kurv++obnFgyq21ieP
X-Google-Smtp-Source: AGHT+IE0I4CvjDgW1iM0QncpnK44L/MxHGHZjrJte4yqETBqVodkp9ZUnptn4+14UoeokrQ+b2yCVQ==
X-Received: by 2002:a05:600c:4589:b0:43d:b3:f95 with SMTP id
 5b1f17b1804b1-43db8526596mr74511705e9.28.1743448596613; 
 Mon, 31 Mar 2025 12:16:36 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d82dede98sm173144165e9.6.2025.03.31.12.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 12:16:35 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>,
	Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH 7/7] ARM: dts: at91: sam9x60-curiosity: Enable watchdog node
Date: Mon, 31 Mar 2025 21:15:16 +0200
Message-ID: <20250331191520.1805001-8-admin@hifiphile.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331191520.1805001-1-admin@hifiphile.com>
References: <20250331191520.1805001-1-admin@hifiphile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Mar 2025 21:19:48 +0200
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

Enable watchdog node on SAM9X60-Curiosity board.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/dts/at91-sam9x60_curiosity.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/at91-sam9x60_curiosity.dts b/arch/arm/dts/at91-sam9x60_curiosity.dts
index 99867d2bf8e..cdb782e28ff 100644
--- a/arch/arm/dts/at91-sam9x60_curiosity.dts
+++ b/arch/arm/dts/at91-sam9x60_curiosity.dts
@@ -248,6 +248,11 @@
 	};
 };
 
+&watchdog {
+	status = "okay";
+	timeout-sec = <16>;
+};
+
 &usb1 {
 	num-ports = <3>;
 	atmel,vbus-gpio = <0
-- 
2.49.0


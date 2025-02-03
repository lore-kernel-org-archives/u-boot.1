Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891E8C02195
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 15:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4D47801A0;
	Mon,  3 Feb 2025 16:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QUtsx5tp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D001A801C3; Mon,  3 Feb 2025 16:10:41 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE1A780079
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 16:10:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D3C3F3F29D
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 15:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738595438;
 bh=xvQTq8unif95dppQVeBJfaE/8d/wKfOuWo5GN+tSl9c=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=QUtsx5tpzP8CIBUp/XVLa0/VOhnnn8RUZwvAQ7shG/ztq98KX1RbmaVKJSdS9MsES
 yMxiHkYaR1j6jioFV2B4C2TUAWBDTsiJqvFhHOodqrPTSAX1FBd09hPJTxXaWiNCoq
 AUybFnTlYNkwQE7MyjRiE+faKYeI3N5skoJ+SWjJ/zVqBRdGyeKJcDXnom0Zrwafxb
 O6HXq0FX4DD1uR4t1kTsldJ6ZeqpLvlRu/U8QWbuypoN4MuU5N/RUw4BrUzTkpP+6L
 Q2VjQ0JxePymqh3WRTcLXfNadLIhX1kNUY14Io7Bxt7GfZOXgnEyzluhESumhg8HYi
 DPnAfvwDGbQlg==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43628594d34so23570565e9.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 07:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738595438; x=1739200238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xvQTq8unif95dppQVeBJfaE/8d/wKfOuWo5GN+tSl9c=;
 b=Hii3y18yqisK8V/xOPq21W+j9pgh+5AyXlcFgulrtH4lYlSK3iG9KmEelUNSbbNnjZ
 ZBflUWQZxFhQAdQQhTRj079A+8KteLTcj6ZpI/SPmAR1dCkNq9jaTnD3VIA8wLZzvUjd
 yjtVLrikNTQvkHk5vONjaJOnzgXdgGBY6+MxE/tndEnJc45fW64UZfttIRmN7sD46b2s
 SRJmYIjvagWugnYbfKM4893Ok49LjsJUF6Gt0Cu7EZ4olAiyCAMhdUdjhkzOCMmRAuk3
 ShgVIS3gQbvQJ+QKtOeeK2kgCuu7Q+1EUAN7YX/p7A30RXiloQpl17biPDKUziFhVu2U
 9asA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3g0UHj8IGjvEFzTDv2zVinJHH/w9Me3wMcIfh5KsvCHivd3Bxdb1Qhvi/3y6FqHRPHpulcFE=@lists.denx.de
X-Gm-Message-State: AOJu0YzFUppiquOsNsq+YiYvc6klRmR18X1ZNXWgzHYew0S29RevGt9r
 QGESe2nxlQoO+w+NVxrJhbSyeioQ8gl7qrMouxD60m1nFYHkrWCopTa4EELNTeylLMqHnIVJHYx
 0V/vWeU9HZd56hjKSthFC8SDTk16hZFaHt9xFkt69z86qApSjSNSMQ2UBsFHlPhttlpI=
X-Gm-Gg: ASbGncv2HcZh+HWHC850M/cbjAFd887o35ZF5HWgYFM7kIuLyZUG87uZkZh2J/xH0Cv
 Fa0WS0bKLrj3VzwHVnA2R84Mp/H1OXj1q3Du8ORMA6uuurMsRq37GpXhJbO2s9aAiisZQXNCC7o
 SZU6nZtBvKJfka2NPE827F13fnHiz6AvG7DGkYvIo03+z1NTIUzP3tYjYvh5CKxjFEVFOr6FpBj
 Em+jlBw/MNzMCgfWPqCHv0RH+Rf26u43EiXff+QNFFN/AntvdGgIjGHmy6osuZCJ/Hte6yt2Ji5
 70nqasVqYDn4Ykch07R4G0FpljAXVujLeXvH2rY=
X-Received: by 2002:a05:6000:1563:b0:385:ee40:2d75 with SMTP id
 ffacd0b85a97d-38c51960d9amr17449144f8f.20.1738595438485; 
 Mon, 03 Feb 2025 07:10:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkeIlegMaQhtp+Ja4N+hZ/Zr/7WWpoRqn5l4exhdEokJpgz64ixzkXQiK3ZAwimoArzYInTQ==
X-Received: by 2002:a05:6000:1563:b0:385:ee40:2d75 with SMTP id
 ffacd0b85a97d-38c51960d9amr17449112f8f.20.1738595438126; 
 Mon, 03 Feb 2025 07:10:38 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:4aa6:8ee1:4638:a26c:daf2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c102f7dsm13235419f8f.30.2025.02.03.07.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 07:10:37 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Massimiliano Minella <massimiliano.minella@se.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 0/4] cmd/setexpr: support concatenation of direct strings
Date: Mon,  3 Feb 2025 16:10:25 +0100
Message-ID: <20250203151029.60265-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

The setexpr.s command allows to concatenate two strings.

According to the description in doc/usage/cmd/setexpr.rst the parameters
value1 and value2 can be either direct values or pointers to a
memory location holding the values.

Unfortunately `setexpr.s <value1> + <value2>` fails if any of the values
is a direct value. $? is set to false.

* Add support for direct values in setexpr.s.
* Correct the unit test for "setexpr.s fred 0".
* Add a new unit test for "setexpr.s fred '1' + '3'" giving '13'.
* Remove invalid memory leak tests

v3:
	remove invalid memory leak tests
	move an assignment
v2:
	Update the commit message to indicate that a bug is corrected.

Heinrich Schuchardt (4):
  test: clean up setexpr_test_str()
  test: remove available memory check in setexpr_test_str()
  test: remove available memory check in setexpr_test_str_oper()
  cmd/setexpr: support concatenation of direct strings

 cmd/setexpr.c      | 54 ++++++++++++++++++++++++++++++++--------------
 test/cmd/setexpr.c | 46 ++++++---------------------------------
 2 files changed, 45 insertions(+), 55 deletions(-)

-- 
2.47.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C93C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 08:08:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B949887FD;
	Mon, 29 Jul 2024 10:08:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hjq7qIsB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C26A887C0; Mon, 29 Jul 2024 10:08:06 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2B2382BA7
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 10:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5a2a90243c9so4143328a12.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 01:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722240479; x=1722845279; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oHGbGSlCPxUn+ZqN5G7b/1110cnb669ZP9PtOzndk3A=;
 b=hjq7qIsBu89dXf6lV9C+s1gwV6sAPTeL1ckBk6/f1Wj2+BlsLoK7rH2Sz2I5XEg0JI
 JWsijj7YGBZsjjxLB1dLN9LqbA4ROPBvnHMfu+OR2o9qiQmIqr8ezOc0mXpCdTrZT3Yd
 gOCpINayjDvMX9zLvwjlb5dfTMlpzqFeN+/fVqN2HnBw6C3ZmKpwDgoItRiikuNZDtur
 BqgB0Vs+EX5Gld8w1hk4BEHF/zUd/lDwVCaL+D/PytKJ8Y/sf/AO28NHL/BcdQErKToz
 R6WPogF9km/dIiNafkf3TOFwQv96xFzycTmEhWhVM2NxZmXQe77fsgQevbgXBpFslZ0M
 kCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722240479; x=1722845279;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oHGbGSlCPxUn+ZqN5G7b/1110cnb669ZP9PtOzndk3A=;
 b=QOi1QEOuFdJqH03Cgs2qnSQ2NMHi9SIQZ6yRA9BcLAa05EY6wJTKLYqZxAQJyf5c1G
 8FGi1H5hZKOIeK+xxpAmk8Fb56vS5HoUtgINkbz8gbvv4+ci7PgJofmGkuvqjH01nsvF
 SNvyOHW8IFsSZA9oeW9tTdSODdpT8V0jvzP6rDRRlqSCVh7A+1pxaGfzqsF3w45lQ5FP
 ZY6D3zLSOvZDYDUdX1EVTUwX7s2ly3criDuYfXV32XpPp/D1wgek1i3o77As1PBMzxQ6
 wDs5WcpaRXnrlFdx0P6I4QCgEToLKKAHNvPTe226WsOOb8jB8mPgAIOHY+P2zyx9lXOM
 U9hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFff6e0mlse2EPxX2yJ8yj6cb3RLwXiKu+i4RiRII+Dug9CegRvVsHzQrS+itJ8awpdUZhkPC1h9sN5NSzj4HLTnkaFA==
X-Gm-Message-State: AOJu0YxW/8AxCXgAdXE2nzf8ozVCI9Qr2ApGYYdwd3HrePBK9eqVUj8t
 tGRNy0l39IJiU1VnRoPfQrwCO9jfsdxvttO/5leXmKd4AdlYr1u8IRmLcw==
X-Google-Smtp-Source: AGHT+IHs9KgAcOa/+4tdLzWcVj5u0ONMW3rbCctkdL6TLbFc9+DUAUi+r78D/O91WFvdo0PaUJ2YXQ==
X-Received: by 2002:a05:6402:13d3:b0:5af:758a:6934 with SMTP id
 4fb4d7f45d1cf-5b01d37bd25mr6190904a12.0.1722240478838; 
 Mon, 29 Jul 2024 01:07:58 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac63590cedsm5352868a12.29.2024.07.29.01.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 01:07:58 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Walle <michael@walle.cc>,
 Miquel Raynal <miquel.raynal@bootlin.com>, devicetree@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 u-boot@lists.denx.de, linux-kernel@vger.kernel.org,
 John Thomson <git@johnthomson.fastmail.com.au>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 1/3] nvmem: u-boot-env: error if NVMEM device is too small
Date: Mon, 29 Jul 2024 10:07:31 +0200
Message-Id: <20240729080733.16839-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: John Thomson <git@johnthomson.fastmail.com.au>

Verify data size before trying to parse it to avoid reading out of
buffer. This could happen in case of problems at MTD level or invalid DT
bindings.

Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
Fixes: d5542923f200 ("nvmem: add driver handling U-Boot environment variables")
[rmilecki: simplify commit description & rebase]
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: New patch in the series

 drivers/nvmem/u-boot-env.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 936e39b20b38..593f0bf4a395 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -176,6 +176,13 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		data_offset = offsetof(struct u_boot_env_image_broadcom, data);
 		break;
 	}
+
+	if (dev_size < data_offset) {
+		dev_err(dev, "Device too small for u-boot-env\n");
+		err = -EIO;
+		goto err_kfree;
+	}
+
 	crc32_addr = (__le32 *)(buf + crc32_offset);
 	crc32 = le32_to_cpu(*crc32_addr);
 	crc32_data_len = dev_size - crc32_data_offset;
-- 
2.35.3


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CD2CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 10:52:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EDA687D9C;
	Thu,  4 Apr 2024 12:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d1JgQEnC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33EDB8842C; Thu,  4 Apr 2024 12:52:55 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFF328701E
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 12:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d85d0c61c7so670321fa.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 03:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712227971; x=1712832771; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ddq7jQfB1YUezwrz6VYCZqdEtCNBMbBK8g8ZeXqZvjE=;
 b=d1JgQEnCYTpgIfbBkOgIHR/iBjnXLoRo+l3JUxgTNzz3V7K/O7Jh36j+NyVdQZbwqq
 hIrSpNKiCpUJbPJY1gWZ6Bz8upZ3FWQAQz7RpN5h2Xowys0HIIIEObY+7ZYI4B9SJGvE
 tUL/B2r92h3RhU6aqTL60OjfwGYiPvs+tun6caAjl8/9BX5+H55onMRzpatMXvxbN3/e
 U7BxxOxAEDLepsEug0JFWdS1ab11ZNpmLRDzEHklK2ig030RSdTEkyLjntIcEb/Rjc1v
 s2hTqAnitQJIXYAo9IcaSZA4/o1RwDG4hj2a6zaTDFrrfqx6Pukcs1yHYnnGRbi0gtlT
 xJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712227971; x=1712832771;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ddq7jQfB1YUezwrz6VYCZqdEtCNBMbBK8g8ZeXqZvjE=;
 b=VMdk5MjQrIvsjPFpO3GxsGi1zKfTp7T88hbw3CHS+4iZiCAYK5k7E6OJphoW9o4IDK
 8S3QeSr926Mnxva6p8hiMdFTzs8KliSJbzFno8Rf9DpVkjD84/G0MwO9EI+p+ClkvavU
 U8kKj6KpT9PgECTaeN48h84G13is50MuXWQP79ghnjl3wLUBkA23VA1MS/pgCUSRivD3
 KyBkaIeA1PiXXNUbu/sXksTS5ZbDi+dhmVg9QoJtUDi0x13UZ3YhyNB1dCdwJa4yN7pT
 ZU4fx0d+6ZyCAhEd22+RgUdOhK9q9QhVJEBkEL7puVVGcmJGVfu++D2SmTUJYREcjLPK
 CoWA==
X-Gm-Message-State: AOJu0YxzJOXz30pQJQYNt0KshQK3JQo1zoHGFjJaeFZEV/lYfE/cWRei
 7lUjU7aS7s0vksexzVI8tAdRF4x7fHfsIAHL36l206/18fM7Otx8+dgGysN57TMBAA==
X-Google-Smtp-Source: AGHT+IG3o/2K4JaH1OpCvLCnhU+/bI25ekfsrOuVVnhguxFwyVjXbo/h2BylRVp+Eml5DtNtvmWB5A==
X-Received: by 2002:a2e:86d1:0:b0:2d2:246e:b373 with SMTP id
 n17-20020a2e86d1000000b002d2246eb373mr1427897ljj.5.1712227971047; 
 Thu, 04 Apr 2024 03:52:51 -0700 (PDT)
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 a10-20020a2eb54a000000b002d82ba2d106sm638761ljn.68.2024.04.04.03.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 03:52:50 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de, jens.wiklander@linaro.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1] MAINTAINERS: add entries for tee-related orphaned files
Date: Thu,  4 Apr 2024 12:52:48 +0200
Message-Id: <20240404105248.3241506-1-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Add orphaned TEE/OP-TEE-related files to TEE subsystem entry in
MAINTAINERS. This includes:
- optee_rpmb cmd and test for it
- Misc. OP-TEE tests
- OP-TEE SCMI agent implementation
- Documentation, including device tree bindings

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0462ade4ac6..0f7325d6045 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1642,9 +1642,18 @@ M:	Jens Wiklander <jens.wiklander@linaro.org>
 M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
 T:	git https://source.denx.de/u-boot/custodians/u-boot-tpm.git
 S:	Maintained
+F:	cmd/optee*
+F:	doc/README.tee
+F:	doc/device-tree-bindings/firmware/linaro,optee-tz.txt
+F:	drivers/firmware/scmi/optee_agent.c
 F:	drivers/tee/
+F:	include/sandboxtee.h
 F:	include/tee.h
 F:	include/tee/
+F:	include/test/optee.h
+F:	test/dm/tee.c
+F:	test/optee/
+F:	test/py/tests/test_optee_rpmb.py
 
 TEE-lib
 M:	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
-- 
2.34.1


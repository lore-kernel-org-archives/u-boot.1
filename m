Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C72C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 00:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3B6F8033D;
	Fri, 17 Jan 2025 01:10:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GQHMKyEy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F9BA8069D; Fri, 17 Jan 2025 01:10:10 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80CC180312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 01:10:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B349B3F5B2
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 00:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737072606;
 bh=8jRbycU3CXZEiKk678yZlbF5UogP9d18IvbAHAED7Jo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=GQHMKyEy4wiGJzvlh+8gHVPNCM1s08aDV5MJik8/UeRL6wMh2uDTR23niUaw+czKx
 6sYDSOApCyKKariZwqRgHcQCfc7Uj3Qa8a5anIyTZtI1H77YzaBZGgzULctGeYPYJt
 VWVqfFdHtmit/GzlLI6ZO8uhZ7Api8I2bcTCSBdDQz2XpMU1Zjky3MZBA+bYMxv7o+
 ztsIQhphzi8ck3c3Aeq11chG2WEsdH7dw9DqgY0+djSATsju4zCbuQQFDMhPvOcfFc
 pzhs1djecT4O+n/Y1mh6d7RuQicXUR+XisbFxmGLo9uT8dBMm/8KbAUcY5qVKIB9g7
 5Be7riqXJGb7Q==
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aafc90962ffso172543766b.0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 16:10:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737072606; x=1737677406;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8jRbycU3CXZEiKk678yZlbF5UogP9d18IvbAHAED7Jo=;
 b=vU5j1VS3N+7Clm+PWciucVGApu+zFajGZaNINkqiQwDeaw74C5ynXY/lQ6NHRWvhC8
 t5oDKSdsWCx6RbcT56PrE/qP6u4rq7vRQ30jPDyKijD8/Fjc9jGxMX4MzijL647XkkfR
 VYeHorB1DsevDvxOHb6vKwKAgGYu/2mszg7TTAP8hCKn2VcDxhLs7JzXsvou7bJ1pZhe
 051fNrT9YApzc6m0bafdC38BVsDbH4ccYdFsOSiTcKhVMYA6Y99ck1OiipTUZLPMBZyQ
 LYQD4IWiTxzNlHLtaFmVNBImG9mpg3t+Xji2rsBoTI75tppIHmdPmLcVLmTZxNj6vZdQ
 bEjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMtS3gRv1u8vxmLkwXVzJFrbXMnzcWo5HafV+5BR9GhZOTr8In2SeFFie+wPPOI7+ETso8kFo=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4K0X+2Fto71XRsotBV5o79np564tBN4C6r7m/Xu9FSS9SXhcI
 P7iupRZRNiYD23V0YQE1uG2OSWkja/IegwmKiZc24Ek4KEqAIksZdWPhgbfjzUtBqiKZv70KfSt
 iOmx77sak8snOAvytBynw/c30eyEbPj2GDt20fgRNOwy/eM9Sw7TYyw8J/K/Ma8SArC0=
X-Gm-Gg: ASbGncttNUu2Q2glU8IkHDC1gPrK/+v/odwy6/9xHcD1qv6/6CfJrdHctUWma7gLA4n
 +DxiYJ3T+6i3jVBgD6zd0zb1uAhj+uXWivAdcxiK8gcHSNi6o6qKDq8sYPV/Q29QvEYnyqbJdlU
 9nr5u2SEFDprJEJ55yPsxIkWK/YIYNEUGPf1g8m5ZTXE+LoikFIkI7zuxuFD1LMf8DeG8I+0PWt
 R0iAT15TSdCEld7A9U+3iR7XGg2d+6b3L8KZQlTjenmrTypH0iwy62md85BXVrRDDz5lo7qBRPQ
 EDAroApInOMrfg==
X-Received: by 2002:a17:907:7dab:b0:aa6:a87e:f2df with SMTP id
 a640c23a62f3a-ab38b2b7842mr58519966b.25.1737072606156; 
 Thu, 16 Jan 2025 16:10:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErA1zF/VSBT85HysXWD+SP1hx/7NEXht44BXwkNym/HDQ6frz8mNbOj6jWDLNFZVraoXbYuQ==
X-Received: by 2002:a17:907:7dab:b0:aa6:a87e:f2df with SMTP id
 a640c23a62f3a-ab38b2b7842mr58518566b.25.1737072605842; 
 Thu, 16 Jan 2025 16:10:05 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:18b7:2225:e8f4:a4b5:e79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384d27117sm71986466b.75.2025.01.16.16.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 16:10:04 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/3] log: enable filtering on functions
Date: Fri, 17 Jan 2025 01:09:50 +0100
Message-ID: <20250117000954.531785-1-heinrich.schuchardt@canonical.com>
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

Up to now we could only use log level, category, and file for filtering.

In the UEFI sub-system event handling functions which are called at a
very high frequency are in the same files as other functions of interest.
Filtering on file level is too coarse for generating useful debug output.

Allow filtering on a list of functions and add unit tests.

(Resending as mail did not reach the U-Boot list.)

Heinrich Schuchardt (3):
  log: make log_has_file() static
  log: enable filtering on functions
  test/log: test function filters

 cmd/log.c             | 42 ++++++++++++-----------
 common/log.c          | 33 ++++++++++++++----
 include/log.h         | 17 ++--------
 test/log/log_filter.c |  1 -
 test/log/log_test.c   | 78 +++++++++++++++++++++++++++++++++----------
 5 files changed, 112 insertions(+), 59 deletions(-)

-- 
2.47.1


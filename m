Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AEEC83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 16:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDD09830EA;
	Tue, 29 Jul 2025 18:08:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B5xVxiKI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30AD7830F6; Tue, 29 Jul 2025 18:08:29 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42A9F82BA1
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3b78d337dd9so947515f8f.3
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753805307; x=1754410107; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O1cnVQXuFquuLL5bpTvy6+/d6gfzbcSnL8NYj+WP9nM=;
 b=B5xVxiKI/DrAHLCgBlTtM42gwwqeURDrPjE1Erb77sqY5jyauQ9F/BYSzkgAjNdRQM
 vaehg2NWWiSaNSjJFw40xm8CLSlgTHcJ3cUu0QNuNwl+6oIqBzKPILVoESYsLItZ5R+T
 rmXUsY13HAujRQKfeAhdnGceqCmBpLpnXqs1pzAP0dwqQimHvMorZLDBSOm9TbPSKmu7
 oFNdlZQlm61AI+AX2yOwBtAr5prNFmJnthUdO7peEvpz2u0jz0SVFCNjdlq1P/W0N9BX
 1PG383r7v6CWzkwQLcvXU1LPt5jN0E/g6YR9xKj30EQZbIQ+banM1o6DPmhEUGzpWKmA
 SyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753805307; x=1754410107;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O1cnVQXuFquuLL5bpTvy6+/d6gfzbcSnL8NYj+WP9nM=;
 b=U/gTL8xahEz7TYAoxYA0zKBr246oSPJExraJTWyIZ8fnzSFZeQ4LYqb8Ldv3mMo5aC
 zMhvfrCpfzQWLzoYtmwmcuF9pXNmLBxko4ix+XFCpIe8r+UyYupaWJxN5BtYn4CxCy+O
 htqZZ9pO7GIoZzyTG+SUxmyPV9IygkjqJ7jLVmmJPEfDsyJ/VC3NZwLQxu8whXnj41kY
 4IC3ioAMzClYvi8usU2BhcxeLEtEzdtlYVFt9VpCVuOlq468zAY8SJ+C56hOuMNnJGrN
 QMVRorYMkhMCvS5R3o3nOQKDgG6DLDkcTrRMg3Bd6APPqlLVE2wZOeNvABNtuypmPlZB
 BUmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjypT6LZl8jz+gD9zo41pVAPxWGMt4BESKf8j7+MKYSFOa1hFwk05+Dzcx6gwfqBfz7JQuOKU=@lists.denx.de
X-Gm-Message-State: AOJu0YxenMC/O2qtMqqZu4lnfSiy4bLemuTciOj+9iNDTbPyizAwldvK
 XZb475Mjq24ElvVL4XldjToTyO9ci+AszLu7O94pouk6Vo7IBTgGY2tOCVLb2ndW5+Y=
X-Gm-Gg: ASbGnct+p2nr0CjM+OzTvYc7Vrxh8xqjuX34KjPElAHFff0V7cQYDbNdh3w4/nMLT+d
 ZMbGKD828M9Q4WbESzQvsKrBt+GlZy3xmT2tRr4mwew1tDGnHKjP5VBE0UK4SoV4G8AVRQ0LE6b
 Vrx4fzRvZGT6HdJoytWBINOe+krR/DUmWIVb7GBwOarI0rULF2eo35fj+r+YZD9yfsDaAQILyMp
 a9cEeJ89jVS+tvQVRDEN3SVlnEVCihfLs/yC35BeUVzt7+ghxqtr2JhxUFiOnrU5xE92UJqZ3JN
 lZP9SLz2RUkVJeVwXSBLSDDQCym6wDQsRxGllZBTfH7Yqtae20VwxeRfx73SMKV8AL4o09LBa2A
 50KIn+vu3LBllltf4nLLgP/8a9lmpqPdCHSt0bxR7otNf/x3OsE1LajUgsCKafbrSjaK1zOqbTE
 HTS3KhThwl7Q==
X-Google-Smtp-Source: AGHT+IHzdG4Dc8OndQKAwOoCJfbUmfWHWSihqf6klK6nwy6d/09zGmGcxuZQC8OsHO8myZFQ0Oe3Tg==
X-Received: by 2002:a05:600c:1f92:b0:456:1b93:76b with SMTP id
 5b1f17b1804b1-45892b952d8mr3851275e9.4.1753805306590; 
 Tue, 29 Jul 2025 09:08:26 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b781d2fc1csm10512075f8f.5.2025.07.29.09.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 09:08:25 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 18:07:31 +0200
Subject: [PATCH v5 10/10] qcom_defconfig: enable framepointer for
 backtraces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v5-10-0009c4620a46@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v5-0-0009c4620a46@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v5-0-0009c4620a46@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=896;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=qbtQg8HJtEug/f6yeDjkin1KAD+HjGh206UQEHqDWKw=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiPHC21iOfvJOM2iB4mgqBmDg8CkvK+v/mg+wc
 yxi1UKawiOJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjxwgAKCRAFgzErGV9k
 tl5/EACHVd9QQLv9lL6hXW6nXPnmeX5iNSPqsVv5nhyCiJKnZfGOLbD80C4WHdr8fwyhPAlD2H8
 z1DB1TRgDWlU//zkExN264wjVa5so7UodJI9BflVH9lPxD1ZEiD3Vh1/ySpW5ehOeqJo6uTqkzs
 YoPqrThcPSIkjr6kVYhQIl4J4Ha9S/mjWoudla0BZEbgSnZjue3YXwXVYiFQ+ogehEpw39rf5YE
 nxRkCP2PBeC/PSBMibzINfPn04Okp2tduJ1sJJCfjbJzWslcdYxPmQ/bV2uTeTXAvouvhwgoRPh
 vrvIwsCGISilRw4rdmE3mB7CVBhT0RoQNHRIZfr0D5Jiyx1RGDDHnVk3w8CFnN4rxRxGQ4rpl8v
 Zhbh7F97E1VvkzJ0JTCdPrcTDQio6ujkgg7AaZLurkqYmANzLRWtHjbHEVxZ9QvIyGHWxr4zL16
 mKHKLYos38h4l00ZCpo7ojihcrBiI20dQ86mS2JHQ5mFrCKlxWR/0RYUgBHfGnZ47FR/DhbUcga
 AaLTjiYEfUxOOihi1ctpvcVMTxxfyp5R37uf9PYBWAnw2YSJL0RUrYsrkZVzfq6VE1cX7G77HNU
 rXrno83wC627dlhGX1SkzCRKx4Oi/iqXz7A7+ctoX07OAWZkfRo0t2bWRlW7Y2Dw3JSzOy6IO2n
 k9yxNqqe5s5Qc0g==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Enable CONFIG_FRAMEPOINTER so that we can print backtraces when an
exception occurs (or manually with unwind_stack()).

This helps a lot with tracking down what caused the exception.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 86d7de89e7746e33f4385ca78c839b43319cd861..9036c39d637eb059e340b1b62675746a21cbb1a6 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -5,8 +5,9 @@ CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
 CONFIG_ARCH_SNAPDRAGON=y
 CONFIG_NR_DRAM_BANKS=24
 CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
 CONFIG_SYS_LOAD_ADDR=0xA0000000
+CONFIG_FRAMEPOINTER=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_BUTTON_CMD=y

-- 
2.50.0


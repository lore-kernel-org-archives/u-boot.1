Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4000FD41D44
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:39:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D185893A5;
	Tue, 12 Nov 2024 03:39:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="coO7Ic70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 695CD893A1; Tue, 12 Nov 2024 03:39:06 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32393893A5
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 03:39:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7eab7622b61so3495160a12.1
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 18:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731379140; x=1731983940; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dfgkUf5q2+uzcMQb76Hirvf0Fv6h6PUf5JdtsS7RHWc=;
 b=coO7Ic709G72V8In8Wd+IUKMxx1anAhojpXg6k2AMasVMkZVTnAKq3ySC9VqBxvY/F
 +vPlhFBfOwbG9xh3IHNzP0Q5hQ739Zj7WHBcPqPVRSm0Md8trUKmykCP4aYpYeUf+4de
 T12/H1NNJcltZeIec1KRzfjFgWMKfSKviqHFw5qas/8DgJyUZhQL4YpZm0P4X1P/J6Xf
 dcrfnFiVZySLW9bWIHK+mdpUWTwsjkbdEM6FaR45i2Ba7Yc3KfdAdl4sdGOmynIntJ4w
 NJfr/rsxpww4oTPTXhNiqeJoP9Ym2IYTqoZkVah7o9CexYyj1Xfe170UCf2qkWP7Y614
 dtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731379140; x=1731983940;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dfgkUf5q2+uzcMQb76Hirvf0Fv6h6PUf5JdtsS7RHWc=;
 b=u29bJ+oresh1XoWL8S8WA55jKh3WhNdXF1a7QUHWN8ASEK2ugvNyKK0noiYavnPHJR
 zAkkI5XBTF0irqZ9XPfThgQZPOKe2P7FjcRcPMEu61eN64DA9hOZGuPgvBGBtSRy4DuI
 wQ3tPBsjMp7ftUilaob0gZh77yfFCldX7JWd+unBS7mx/evNZIn3skmLAIxCYLQKNQol
 w+AYgPfKkbePkU36Av98FMFzM0/+Tv0iyRkD0yUBiEngBHdkJ8bK8ocK34peo+Aw9Taw
 8wLTgDjk+x2l69roiYAd+QspPparTd0+wKjVztnxS1g0T99Z7g70JuaNffB6GuEpAbmH
 LaHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/Lwt4/LHQlzHMdG9ebcwCEPqQfF9mhvdbcXXxAwLh5Gz6QWARar6At80D96AvJH9phbmdpBg=@lists.denx.de
X-Gm-Message-State: AOJu0YzlE0lIkJhlBh0n8r4eJTXgvQea/Ffk1kVoE1FyO6jNVNea4IkV
 kNqsd2I0bZ/L3yjSA5kWQRMdnWWpwy+aclRtsbRietQXHapNE6fjf466tw==
X-Google-Smtp-Source: AGHT+IEJVSxhMkQvgAOI8X2XpkBGaDuebIfz08K6zZd4vFD2kwOxfnAPEGn+sD5RQjfJ/ljzKgMYGg==
X-Received: by 2002:a17:902:d2c8:b0:211:6b21:2370 with SMTP id
 d9443c01a7336-21183ced53dmr205779665ad.29.1731379140451; 
 Mon, 11 Nov 2024 18:39:00 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:be16:bfad:7211:61df])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177e45ef0sm82748305ad.153.2024.11.11.18.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 18:38:59 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: hs@denx.de,
	u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH] tools: imx8image: Add missing break for CMD_DCD_SKIP
Date: Mon, 11 Nov 2024 23:38:54 -0300
Message-Id: <20241112023854.2289656-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

The CMD_DCD_SKIP case misses a break statement.

Add it.

Fixes: 254c00803b63 ("tools: imx8image: add possibility to skip dcd")
Addresses-Coverity-ID: 514648: Control flow issues (MISSING_BREAK)
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 tools/imx8image.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/imx8image.c b/tools/imx8image.c
index 96ece28bd6..7a060811c7 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -93,6 +93,7 @@ static void parse_cfg_cmd(image_t *param_stack, int32_t cmd, char *token,
 	case CMD_DCD_SKIP:
 		if (!strncmp("true", token, 4))
 			dcd_skip = true;
+		break;
 	case CMD_FUSE_VERSION:
 		fuse_version = (uint8_t)(strtoll(token, NULL, 0) & 0xFF);
 		break;
-- 
2.34.1


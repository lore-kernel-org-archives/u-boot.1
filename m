Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EF5C02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 02:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B0908081A;
	Wed,  5 Feb 2025 03:09:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i4T5Eq9E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86568806C9; Wed,  5 Feb 2025 03:01:26 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 618C8800B3
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 03:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhang971090220@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2166360285dso106408225ad.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 18:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738720881; x=1739325681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ugEWFJWlZXVHAWuZTjNDjB8B7HNJOzyhXRun/vKUyl4=;
 b=i4T5Eq9E7e50m57qL/zSRhipCIbs5Jix3DsZVCcNC8vgQlFQGQI42SJMVqxJP1mGGd
 JVFLYLAjMsXOcp2Z8fFsAzEzrWWMIHU93u55OKwh/gnXyfzEN9goh/1OMFelgrGGJC1O
 nU956I59bHcdrxhHJ3hAQZhBh4J9VKcuIWDfaJvUink7es5dxCmw2W3h0mlc/VPErMF+
 5K7iGIrG8Z2DDS2xyKhSO+QAcZpk3tBOK+MAyM//3PdKKD/F9RY71monqo/r2hY5zB5j
 yU4TA7sdqUytecc7b/NTYoMqgurR8r1jN1ga+anvFJzwfNhvJ/5xH0rAnT3hKgr3IWli
 VQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720881; x=1739325681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ugEWFJWlZXVHAWuZTjNDjB8B7HNJOzyhXRun/vKUyl4=;
 b=jJWEKtXgl6+b1bL1NDuV9QtyPcH77mkTOlkNtD2UzW/LyN6s9vwd0Qdo5gCak9UwB8
 yMf4b6QjR2rDIpT+rHPIT8s5z/ytZPADlQBFraeOTCG1bliitL175TQI9i9Q8lbLCiaI
 h4EXenVoGNw4G/xq5goIpebgf0GeaQMZ50ASNdGc3FYeUbdktIR/E1ZZi4DRKWE0BSpB
 Z7qnRixATsjgfCx45W/btkgqTnjox1LNAnJmxzHWqoa/VcQool74ZfX8vQJftqdp3keS
 Y4TlIohNuKhKJ1xZxfKf3Ae7Fwam6aAv0NsVGjnizjl2LvhpyjzTdgZAoX+fp028BIQd
 Vlaw==
X-Gm-Message-State: AOJu0Yw85ZegWn8nxqmEKOp9Zr5N+NNXd86pywYs0LNTLfUKBJF7Ksab
 WKWhv1AcFvKZyFrYAOU5KJEU2jubAGKAXLz7H1tSzqh/CdNQy0GfRCViiXaM
X-Gm-Gg: ASbGncvxrLOjAkFSwWrB5HMmYgYAeXl2V9NJedVcWBpbVqYR4vmdbtPQJqMCJJplD+s
 Yw3TPfionEp5v9ZiwJg4TnVvzrh2RvpYg/q53Fpa4Zr3Ah6aXXd2TJttJWvtvxfN+l1MhW61tEa
 ephOA+fMMHHbSNjcxz72UvfeGMiJk7zsX3rZ+hc9saYb8SOh6DYY9igBIcjf9xRgh1K+YzZGY8Z
 iYXmcFPjU1KPBmfvaG/xHsRyuRVpjc4HxoUR33CElTdVIufnIZsT5CX063u8hhIcnx52dQyrvmi
 ahzqeUceQacONss6nrw+3zOagUBCqpLVSks1gzOyilslQTO1QaMTSeZZ44aDE78=
X-Google-Smtp-Source: AGHT+IFGQS88VKQYlIDJJTZStN1icjzoCVY2THNtG/mtmMf5zhQG2hkWIIODF/q2lYGhFn29giFw+g==
X-Received: by 2002:a05:6a20:ce4c:b0:1ea:e81c:60fa with SMTP id
 adf61e73a8af0-1ede8845d3bmr1754849637.20.1738720880785; 
 Tue, 04 Feb 2025 18:01:20 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe6a1a89csm11155802b3a.158.2025.02.04.18.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 18:01:20 -0800 (PST)
From: Michael Chang <zhang971090220@gmail.com>
To: trini@konsulko.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 zhang971090220@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] net: designware: support phy io micro voltage setting.
Date: Wed,  5 Feb 2025 10:01:06 +0800
Message-Id: <20250205020106.40785-1-zhang971090220@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Feb 2025 03:09:25 +0100
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

Support phy io micro voltage setting for NPCM8XX rgmii
interface.

Signed-off-by: Michael Chang <zhang971090220@gmail.com>
---
 drivers/net/designware.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 94d8f1b4c0..0a1fff3872 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -741,6 +741,18 @@ int designware_eth_probe(struct udevice *dev)
 			puts("Error enabling phy supply\n");
 			return ret;
 		}
+#if IS_ENABLED(CONFIG_ARCH_NPCM8XX)
+		int phy_uv;
+
+		phy_uv = dev_read_u32_default(dev, "phy-supply-microvolt", 0);
+		if (phy_uv) {
+			ret = regulator_set_value(phy_supply, phy_uv);
+			if (ret) {
+				puts("Error setting phy voltage\n");
+				return ret;
+			}
+		}
+#endif
 	}
 #endif
 
-- 
2.34.1


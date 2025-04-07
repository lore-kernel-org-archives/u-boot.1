Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F36EC369A1
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 20:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0C0B83121;
	Mon,  7 Apr 2025 22:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QbaYTpEx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 626E4830E5; Mon,  7 Apr 2025 22:02:46 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64627830B6
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 22:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so3892517f8f.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 13:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744056163; x=1744660963; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pA3fr9ZK1HDD76B3sltaSieNwG9WriYbyzvZMSD9JIk=;
 b=QbaYTpExdVR2Itaf1gNw8bMG9ref/YStcfGS1FRzsIRkbDYrr4+M4tOEjHelgrwLL8
 xwVqrx0wPgw+cAITp13lVqulWFjxMi1EVDiJoVre7TO8y2VX9sKyWI0efNlgRfgt6qD6
 96tXFgwfrEE3aeq5KkVGqMIL1Szoc9b9AbhJ+ktB1vS/FEeQkR0xdh5zsOl8s+tMbP02
 BUD9EUxD4jFBO9hAYPSyNwXAVArHeuoDC42mZGJmnksfABjmQoRErfG2ipz3VLjDD73W
 HpmGBHCS+wgLBrf4uvZJQQtbvo8rT+nb4XR2yd7QiaPmjHR1pHv7tZ0izpYxnspgLaYe
 g4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744056163; x=1744660963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pA3fr9ZK1HDD76B3sltaSieNwG9WriYbyzvZMSD9JIk=;
 b=N1SexS4Fnk0agPYrtieUvsQ+a3YBj2o/iHzaCY68GoFx+fQT1f9mdJoLBSrHAzOlLC
 vUx0qddDStHTpLYKWLzcbBZZmvPXYEW9wAYV64awsf0Kkt7i4W8Cc/9fUwO540lbNX9I
 e5dHodQVzKvlK7xjbPPobW4Zet02wmC9SWna7LDk9UUlBUmgOndVaSosnmW4pS1l79bz
 X8etLsu81EwXMtDJb9X3JDOtAUUMRvp3ma64xN6YntfOTvTUM1MlbNa4hGSkSAeJ/vfd
 TDRuIEYF67q5Nf02rpkxRVZNoYtUXx/HFQWAtTreBu/EX38CK9HSs9yWyihIw9DHiYj7
 OhwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx2u6ksYUJg+sYviyo8Sz/f0wsRg8d5tgq6DW+7l88hFXepINmqdj5zeqliU3kpEErqerKjxk=@lists.denx.de
X-Gm-Message-State: AOJu0YwS4eGBbLbfDjaIz88azHEtMj5bJ5yhfBImgWsrsJCgiRuMCHsl
 GJgAonP0uMmKRMbOefpCsFZScfz/KuS2FYhnAhBJn9YtV6AqZW4+
X-Gm-Gg: ASbGncvaoL+icufh6xwwgRWNVWLOvFgaotAZvnotWmfVix+Z6x3zO8wFusKDFsmEAF4
 4pUVPUYiIL/s+fPAkWzC/Z6qHBfayQiP9jmbHkbZ8wvjZIBmKVNm2F2mpeE2X4HOuucNbUcqMCT
 LpLNaHzPvn1SXOr1qOOoO+Rp+ZxhqYZXXk6Iz2V2aw+NFErk+yu7byDAcPx7TWoIQ34rinhCJaH
 HWRl5ekPYi2Sw2U2Q5jKwDQ3CC2sl9eRFr7M794VLxuf5RDNjp/Vmy67VYKtW4YF91+9rwy1ve9
 AR4Jp8XiVQx5D637GV7aYIDXNsyaXEPEJtiEbxDarA9coiMHkfDK2qkxZI+c0wf2KRWj1Gkkwrh
 ti8AtxMhpdeBBZA==
X-Google-Smtp-Source: AGHT+IH4QyOjHAh9bnKvCD4Tb0oBGEpnsHG2rNey+DOkJ2VErlB+tU6B/VlLnt9oQR5ZiEwKHscgLA==
X-Received: by 2002:a05:6000:420f:b0:39c:2692:425a with SMTP id
 ffacd0b85a97d-39d0873fcd8mr9778558f8f.6.1744056162775; 
 Mon, 07 Apr 2025 13:02:42 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-39c301b9d55sm12723354f8f.42.2025.04.07.13.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 13:02:42 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 08/14] regmap: Add regmap_set/clear_bits shorthands
Date: Mon,  7 Apr 2025 22:01:52 +0200
Message-ID: <20250407200208.25594-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407200208.25594-1-ansuelsmth@gmail.com>
References: <20250407200208.25594-1-ansuelsmth@gmail.com>
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

Port Linux kernel regmap_set/clear_bits shorthands to set and clear bits
in a regmap. These are handy if only specific bits needs to be applied
or cleared and makes it easier to port regmap based driver from kernel
upstream.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/regmap.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/regmap.h b/include/regmap.h
index 22b043408ac..8c6f7c1c9b1 100644
--- a/include/regmap.h
+++ b/include/regmap.h
@@ -361,6 +361,34 @@ int regmap_raw_read_range(struct regmap *map, uint range_num, uint offset,
  */
 int regmap_update_bits(struct regmap *map, uint offset, uint mask, uint val);
 
+/**
+ * regmap_set_bits() - Set bits to a regmap
+ *
+ * @map:	Regmap to write bits to
+ * @offset:	Offset in the regmap to write to
+ * @bits:	Bits to set to the regmap at the specified offset
+ *
+ * Return: 0 if OK, -ve on error
+ */
+static inline int regmap_set_bits(struct regmap *map, uint offset, uint bits)
+{
+	return regmap_update_bits(map, offset, bits, bits);
+}
+
+/**
+ * regmap_clear_bits() - Clear bits to a regmap
+ *
+ * @map:	Regmap to write bits to
+ * @offset:	Offset in the regmap to write to
+ * @bits:	Bits to clear to the regmap at the specified offset
+ *
+ * Return: 0 if OK, -ve on error
+ */
+static inline int regmap_clear_bits(struct regmap *map, uint offset, uint bits)
+{
+	return regmap_update_bits(map, offset, bits, 0);
+}
+
 /**
  * regmap_init_mem() - Set up a new register map that uses memory access
  *
-- 
2.48.1


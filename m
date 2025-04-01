Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D433C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 22:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C263582072;
	Wed,  2 Apr 2025 00:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i+sQiQ/j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B64B8171B; Wed,  2 Apr 2025 00:52:48 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70C0381FFC
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 00:52:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso42476645e9.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 15:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743547966; x=1744152766; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pA3fr9ZK1HDD76B3sltaSieNwG9WriYbyzvZMSD9JIk=;
 b=i+sQiQ/jANb3BuCd4bbNNyKbPeiGw8Pa/mn0bw4txxX3HMZLIvp3YQhKPhx/JAOuRj
 CRpqQ1K0N7NjD1zacQW8hlxFDofQ86gJp5NzJHdKxMPfmyexs4Ba7OgZ3u+/3Z6guSeO
 QKYjdNTVng4JqJHjx21rMMXmcDs/sLq89P3w7xFlHOCo4fu+2ydRiOtRR8J6L8RsBQvZ
 YgyyJBLlyPxRFgPtg/rjspCRdV9i8Rooc08SxNlkktcXBKefEfI6tUzw4njtlhHwVZh/
 GVix0/rorQwmLarPfKOfTLYnbACHUvmxWyE9G8Fwe8GHneEPLUE7qGXNUf4cENqbZh/i
 p21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743547966; x=1744152766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pA3fr9ZK1HDD76B3sltaSieNwG9WriYbyzvZMSD9JIk=;
 b=UDt1mO9FElkoNo3BYpM0lpJJSXLf1VeO0EN0G+9KETJ+F2dpKT5KayRVARBNf2//Gj
 yz2vOAzY9Z8k7rQRxgo2d240s4eKVPZJEuHM59Pj4UNpmv4sBxuAFlXAsMfRAfn+YWI4
 F+QeS96gXVC0okiHyufkCuroqVMLNRjuKvE9oTh2Rc0jz01FdaRZUZ3GhU9ee01Avslk
 RK3riQg8Vj8ZdC1iLuVleuxfmbN86clPKdJqj48f8naXxmTWsSM9hl27YkvFKqarQTPl
 Zjz5Dt+J0RqEwj2Yu1sJDE7Yo9mJOps8mJ4HLv95eXR8ons9l9XamDgSUMXaDtHVM1FR
 s76A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyBwPAXm3oQIM1BiJm0INw4jlB5TPqQkFyFW6NUha3POlYZzttFz0Jj5h+tsyLQp1BSQ7ThjM=@lists.denx.de
X-Gm-Message-State: AOJu0Yzzq4dlVd85RghcLwWm1IUV/ebJDV1iu2GF1JCYM9eHUrUITlJ0
 tnh6lKEneERNOE5c0ZBARfNtYZIdV83J/qGRl57NDlW5dvjpMQ/e
X-Gm-Gg: ASbGncvKC+CzKm7bxaeauD5pnY9Qo6r5nIZgmCyxCAlax+s+JHAcf1Tqi1DEp58KR+p
 QL47mYD02xvnveU3BQc8fY09gyXhK6+pIkUVkS361E9jd34Sl8eL4G7U/hD6O7GkaFEc7U6nKLj
 xdbDNOcflRvCQgP+w4k/0t3aYq0n8LAxjcpqgVcEjyLA5oOwVqTHdL2lBOqlVZ0jr8mJorehD3e
 HkqJ/+XPR+6jl3wUeP1zgiydDsfk+MW56xF5bUeN1EQPDQoDieo3fWJEbC6GBUc9v0eBzbaoruH
 N3sBHcQkWQnWMtf8E3PQ5DE1uEvCFR0nA4oH8awTGqvWlEAiHQrcKXDRY2PZUwcghcfsSS43s0m
 Kk/418Z8RR40T8Q==
X-Google-Smtp-Source: AGHT+IGT9GhowKX9msuUnx1g0KRKqdnFOgUytYjhJb3zqelEtmCkDFDIpF8bzG5GofCoxDdjaiv77w==
X-Received: by 2002:a05:600c:8119:b0:43c:f513:958a with SMTP id
 5b1f17b1804b1-43e7a5426dbmr118845565e9.13.1743547965871; 
 Tue, 01 Apr 2025 15:52:45 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43eb60cd77bsm2478625e9.19.2025.04.01.15.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 15:52:45 -0700 (PDT)
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
Subject: [PATCH 08/14] regmap: Add regmap_set/clear_bits shorthands
Date: Wed,  2 Apr 2025 00:51:40 +0200
Message-ID: <20250401225156.25790-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401225156.25790-1-ansuelsmth@gmail.com>
References: <20250401225156.25790-1-ansuelsmth@gmail.com>
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


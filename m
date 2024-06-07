Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8FBC27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 20:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F35F2881AF;
	Fri,  7 Jun 2024 22:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TG22Kvp7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BD74884A9; Fri,  7 Jun 2024 22:42:58 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE5EC87F6F
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 22:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a691bbb7031so340667666b.1
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 13:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717792975; x=1718397775; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5n3DsFuSxZnMozu+1+unhCOLL9tu7ODNypKPBuiv6IE=;
 b=TG22Kvp7TG4vc5TEQhrOiVpy4SsMNB48PM7xTnTZgQ7nbM3NLPlMG10g4bua0ys3cg
 nS1bPENOiv/0SCNmhdCQr9dZ1TgsMZ+X1voxWTJL5uXw5ahqo0yS2KOE3sqjNoC6isYa
 q9AyIb3qY8iuOHkXHY6mVhAh5Oj5h7zEaYiC27jXUprPp9FlXlqwYLJjWNIog61g4ixT
 lbMElQ0I5aS0rdE/wFeYrE5Lqw8/Db/0vGsoNDkznCGyBi/P8sUx+jinBHT9KU6HVNt+
 BY9GfW5UnXltlskdNwjUhy1QOCrcNJRdBm+beStB864MiLc1SjyaqABawmf+/pn4BVJr
 SLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717792975; x=1718397775;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5n3DsFuSxZnMozu+1+unhCOLL9tu7ODNypKPBuiv6IE=;
 b=dfc7aHIaN1oDJlS66AW4iSFUqQySJQijAiGQhYCSJtlXYpnq7yjRoj3pSegEEsEoda
 eNFHTiI971/Bn17rzxE5OjCNaqLNCYn+iUtiQmHe0me7YRXwWwA35UF1zYjbWV6ONsLD
 OsCDor9M6DKKrNUwCK9Esa8v3F7WKboOEFUhoGGc9hp9i5PTf17yHbkqCyzWr59FHYiR
 Flp23Rjokl6NnwGmeS6NqbyJs18kgl6EXaCwhXTY8t0VUMcxosPs+5h+MYJOZhe5XCuD
 Lqp5FAxtbULMHfzIw1u7Wi46ovQOESOFXOwowcmz8YdXw7PVaKq/QxzATXKxOcuL1XFh
 239w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIhQKK8GY3E5jO+GEyO0MkzHJG1Pk03U2xbu1TfrcgGbKVnPLzXtOY2iVUzfKyVxgjOFfxfNvp5wiTCIIpIwzdumdoyA==
X-Gm-Message-State: AOJu0Yzi7r7lro7HAEIn6xgVuDbex2y/3Om2jSnsQUDD+mNyo4qLhnI+
 WXpBnuiC72CKeqOxL4y+7eQgUwPGI2vAWmgie19QxruFWhR8MAQUUlTweiT4XcNNKeQBRk0BaPQ
 5EBs=
X-Google-Smtp-Source: AGHT+IGAzMSJQM8kFsPNZqnCTJKopZLsijcHq3INsctT0ZOWvQXTNNG7vjf2C+gxn2aZc3byvW41Yg==
X-Received: by 2002:a17:906:f902:b0:a67:83a6:e with SMTP id
 a640c23a62f3a-a6cdb9d5712mr324582766b.75.1717792975149; 
 Fri, 07 Jun 2024 13:42:55 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c80588851sm300766966b.29.2024.06.07.13.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 13:42:54 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 0/3] arm64: add a software pagetable walker
Date: Fri, 07 Jun 2024 22:42:48 +0200
Message-Id: <20240607-caleb-upstreaming-v2-0-bae407f51f22@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMhwY2YC/32NQQ6CMBBFr0JmbU0pDVBX3MOwaGGESbAlUyQa0
 rtbOYDL95L//gERmTDCrTiAcadIwWdQlwKG2foJBY2ZQUmlZS0bMdgFnXitcWO0T/KTaFWjtVV
 NW7sK8m5lfND7bN77zDPFLfDnvNjLn/1X20shhTHS6NE6V42mW8hbDtfAE/QppS+bhpdFswAAA
 A==
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2045;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=kGbvULJ2Xsb0LVLo+lPuGXyg191mD9+D1+3SsSh8gQ4=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmY3DNsRaEJcOSw+6q4YnLod8lbS+IomxgmjUMf
 cwHeZYyZEmJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZmNwzQAKCRAFgzErGV9k
 ttkSD/4gpaGAOZEdZ0sX1nyAXVpyWZulnxQ7DnJHlQ8DaFd8qXtG1dgBHUgB1qL1u8EnDntgDCB
 yDOGfwGYzLlX4igF38hbIXO1HUe/iOYESuxy3bMv1yBpjZSMbVhsT+xUbzRNbedsNJfbz8JEueV
 J1KbORP1Xsli8nMk9oH4aE/9O/572bIBoWNIh+YkUr4TvLCCXrKmLztcipJK2hSu3boZ8G/4+GZ
 uhtZXkCICzfNsyG4mCM5BWVk5WzrhEcwLKvL3VgJoU+5LhDK6ObWlIBAN4qtOW1KqTZMhaSFlpo
 bCxJR3el97mM8zHP/9ZhZOFd4Rtax9Gay/gQr8xjFzLc76eYeQieHVEiJQsPOFuG4xfe0jFX4z3
 hZ2jGruxQXyIUzAOqU1QZGtokHKqIO5Wcq3KNt5U+qKqU4pu+2JvmDk89jBWgOQhAXYf7+FSLMM
 nRj8ZuW040+1MkeGcnD2MYMcgCEk4XgLqY/6R9zcTntd4A2oM+DelNq8lVZ9uHJHHoRlZSecJJs
 MxbRHF50Ei/CndZt+5RelZhtsJscSGn6d7PToUtDuBLg7V/0PE+knJS4K/cUJkjjMX9zdUnY4Ib
 ht4nLRYMiZXMCqP+6Qe5BCgMQ3LvuYYfhDI1aC7o6ZlXaLMZSBsWmIolCuq58LYDjyoU6U6cOZ4
 7wh6Pc4fyKfOU9Q==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

MMU issues are some of the most frustrating to debug. To make this
slightly less unbearable, introduce a software pagetable walker for
ARMv8. This can be called to dump a pagetable with the default
formatter, or a custom callback can be provided to implement more
complicated parsing.

This can also be useful to dump the pagetable used by a previous
bootloader stage (by reading out the ttbr register).

Here is an example of the output when walking U-Boot's own memory map
on a Qualcomm RB3 board:

Walking pagetable at 000000017df90000, va_bits: 36. Using 3 levels
[0x17df91000]                   |  Table |               |
  [0x17df92000]                 |  Table |               |
    [0x000001000 - 0x000200000] |  Pages | Device-nGnRnE | Non-shareable
  [0x000200000 - 0x040000000]   |  Block | Device-nGnRnE | Non-shareable
[0x040000000 - 0x080000000]     |  Block | Device-nGnRnE | Non-shareable
[0x080000000 - 0x140000000]     |  Block | Normal        | Inner-shareable
[0x17df93000]                   |  Table |               |
  [0x140000000 - 0x17de00000]   |  Block | Normal        | Inner-shareable
  [0x17df94000]                 |  Table |               |
    [0x17de00000 - 0x17dfa0000] |  Pages | Normal        | Inner-shareable

---
Changes in v2:
- Document the MMU debugging features in doc/arch/arm64.rst
- Mention that functions are stripped out when unused.
- Link to v1: https://lore.kernel.org/r/20240607-caleb-upstreaming-v1-0-99094dabb3d9@linaro.org

---
Caleb Connolly (3):
      arm64: mmu.h: fix PTE_TABLE_AP
      arm64: add software pagetable walker
      doc: arch: arm64: describe pagetable debugging

 arch/arm/cpu/armv8/cache_v8.c    | 202 +++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/armv8/mmu.h |  57 ++++++++++-
 doc/arch/arm64.rst               |  37 +++++++
 3 files changed, 295 insertions(+), 1 deletion(-)
---
change-id: 20240607-caleb-upstreaming-82744a2786b3
base-commit: 22ca7e13dc02be83c29450ae4444add8e150ebdd

// Caleb (they/them)


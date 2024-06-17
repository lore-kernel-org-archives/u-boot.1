Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BE7C27C6E
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 08:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB21A88279;
	Mon, 17 Jun 2024 10:03:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HueV0gzO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 735FA88271; Mon, 17 Jun 2024 10:03:56 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BE37878ED
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 10:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a6f7720e6e8so111203066b.3
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 01:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718611433; x=1719216233; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Oi5eUSQP0Qj5KSuTEIJPyU5vafCoZDwsQRGgxVpp0uo=;
 b=HueV0gzO17xhJLX5C0nyO4EwWBUwT1pU/a0NJlmgNutXtvpDd4kvpchO2TU8gSNeTb
 T3Jqi7jJ4uoPvFr1VLaMfnNQTIWanS+zzKeyqY5qhffOwLXoh1o1L4Q1lY0IZuNZYEWN
 9FYwfM1bV47InvRIW+eH6WHsdavS435X0Ft0ztLX/jPX3Vk9pZ9Nj8dtlQMSU+CCMwji
 ulMwjXk5WbGzF/lgT3drOWCfgsN/CGWN4nb00xBXK72y8sOzJaaF105tk2NCuh+sENvO
 sXa8r+1Y4u0JnbYV8jNX2psKxtwMb7dJwiOHlF2V1kR16FC2lEgH9pii+9wAQBb6nNpQ
 mWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718611433; x=1719216233;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oi5eUSQP0Qj5KSuTEIJPyU5vafCoZDwsQRGgxVpp0uo=;
 b=sOJf7lmw3D/O1uXAIUql8GDZl8LKp299uAEOgh4o/l2usP4HO4oLRvZ7dqCQYntYws
 skSxc6qKq5ZbzF9tGvuqYiFOU45Kp0JU84BJVwe8jmwmI+anSAgR+KAouN0x1cKPiIiU
 kml2hkjLQ1iRMliH3B3C1aHsCKrQuHWXhg1YCYYCinFSttMTdHy9mMaxT0KQSSHTMbih
 y+g9TwQUgI3/S0mo8p/QAuf1c+bGcjSn9jMiolxT/EgF/wG2EMs9hDYdCKtU/Vlbh/eQ
 gWmhsVyfMdWy3C7NxZ0c+FkQX0yRgpZlQx//C24M1reYcisFaLlWH3VYbd4Q12CjkeZd
 +5Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXYuiokdw1IlMJx4iLU7BX4xsBwuVg2GGoU8FNmz/uQLLhspq8bB0/vGx0BAPk7L+NpFvp7EbECSjpTxjvKk8e0Hhg6w==
X-Gm-Message-State: AOJu0YyFjtW/qa2C4oKCIkb6WobYsTVvKh2P82lkFtatOkJTjtz27TFC
 H3tYS7qtjkwFgT/+SqgW1rHlhhFGRluIpJi2IQIMi5zZzGXXB3Bb/UEDKJFiPKY=
X-Google-Smtp-Source: AGHT+IGBO1oxGhpDFfje1M23/dWDnRSPQpAk1hOOjx+PJiYxy8c5IvzVs9pZ5AYGQy9F/IX+MXB3Gw==
X-Received: by 2002:a17:906:af8c:b0:a6f:1b59:e877 with SMTP id
 a640c23a62f3a-a6f60de6086mr710587566b.75.1718611433324; 
 Mon, 17 Jun 2024 01:03:53 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::52af])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ecdd79sm493224966b.132.2024.06.17.01.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 01:03:52 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v3 0/3] arm64: add a software pagetable walker
Date: Mon, 17 Jun 2024 10:03:46 +0200
Message-Id: <20240617-caleb-upstreaming-v3-0-1ba35dc9179d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOPtb2YC/4XNQQ6CMBCF4auYrq0pQ6XUlfcwLloYYBJsSYuNh
 nB3Czs3uvxfMt8sLGIgjOxyWFjARJG8y1EeD6wZjOuRU5ubgQApKqF4Y0a0/DnFOaB5kOt5DUp
 KA6qubMny3RSwo9du3u65B4qzD+/9RSq29ZeWCi641kLL1lhbtvo6kjPBn3zo2cYl+EtAJqxBK
 VR3LjqAL2Jd1w9hNUGv9gAAAA==
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2260;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=yg0TyCP24vTF7JZWw35zF7QK20h3z6Bg8gNTM7afZ0c=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmb+3nO8ZxYSkpnrU1s/HgVIJEFQRWJRwii+UJX
 +LdIBh7INSJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZm/t5wAKCRAFgzErGV9k
 tncLD/sFdVnAAsz8AkaywG679d1rqYXI0quPCkdXEbeGcl9BwaLB+jDbplx+9q0sSYv20jsRnV+
 dvlY/niKDjfYFtaQRScd8Fi1JpdKbljNpIhARwFoNSn0Nn/1bgmNLWK4I+IEGss5/J64OKtXbff
 lOCmaTTt0CudOvabe6csH1WpeNGq/+Zd4zmVikIu90CwV1vennmOZnX5B86AY7g9iYQAsjgg2wW
 fpLRWDC7L5FsQn7zl5VF0ATYW00okqH0DRr6ttb56CjqARMXbkOj/iHoqMyWpk9uQchwwaCwYZT
 U2DhIggMWM73DJW8MCcsRc0kh/lsZ2mdYOrMxytOvG68gYCSgUJ+u/vTEV2oWQ2FcVF41fOzCtL
 FmagfcWQQqv6QpacoitypoEafNmLuU4Ur6gaPXFxz9Hw3bdA6jS35Hbf/qC1oXEgY9zua3f4Q9d
 UtZJzl54NvZQuV3YgIDYK6HNGYAxPm/gxIz1oGk+Ns5Kyd5lCItUnivX5G9M+fsJ5gG9Mt8iXWH
 KxNIsXWiCPjmnC4iv9+3l7LvtZc+UsCcT9ctc7Az8nW+4VlCITaWOm9AL33z7NAJE4MHPQD8ax9
 9LW0WM7orURRA8E4vxWoJUQa5K+hjrnPoMX2qveutJnlyCXRXRG3s0Z80EY3bib4p2tCyjH4Y2I
 KV5qNYX8iIiEQdw==
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
Changes in v3:
- Add doc comments to __pagetable_walk()
- Include doc comments in documentation with kernel-doc::
- Link to v2: https://lore.kernel.org/r/20240607-caleb-upstreaming-v2-0-bae407f51f22@linaro.org

Changes in v2:
- Document the MMU debugging features in doc/arch/arm64.rst
- Mention that functions are stripped out when unused.
- Link to v1: https://lore.kernel.org/r/20240607-caleb-upstreaming-v1-0-99094dabb3d9@linaro.org

---
Caleb Connolly (3):
      arm64: mmu.h: fix PTE_TABLE_AP
      arm64: add software pagetable walker
      doc: arch: arm64: describe pagetable debugging

 arch/arm/cpu/armv8/cache_v8.c    | 245 +++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/armv8/mmu.h |  58 ++++++++-
 doc/arch/arm64.rst               |  49 ++++++++
 3 files changed, 351 insertions(+), 1 deletion(-)
---
change-id: 20240607-caleb-upstreaming-82744a2786b3
base-commit: 5cff71259b26b73ed0e9e9acd12d16a4d8ede04b

// Caleb (they/them)


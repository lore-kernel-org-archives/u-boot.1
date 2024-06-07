Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42C3C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 16:51:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F5EF88415;
	Fri,  7 Jun 2024 18:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rKEQJhd3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02F0688431; Fri,  7 Jun 2024 18:51:36 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE19787F6F
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 18:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a68bf84d747so230957666b.3
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 09:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717779093; x=1718383893; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2aRjr6VFhAbtDXp2bvf6Y2U8tH9bqXgZOYHrJK6zB+I=;
 b=rKEQJhd3q1GC0/FHgUIPhiAIqiA8SzbkL8c1wvzrQ0Ywu3wu2x+PdfQzYOKkPnqovx
 LM1NhZt7LKMf+XRnGaz1kgT7aEM4zTJtmajCPEvqtbOj33TAJG4ttSD4VYI1CXHJpzIu
 DLmZx6nshgpFH3bvd909x13W5mngFCtSd82j140uz4VsS4J6pra6KfhiHv4dhe6iAE0E
 /nPZHs2CXoRCNA1jwHc/Vv6qo/PIONfCOR2SdXk5Wz99ci76EIyEqrXWYPfW6SDxmiIa
 QqZAFNH89xzjrjaPYCCU+N3hnyvYQ+B5v0+lrtk6mzzuMww8P9Q/YkUz0EJ+KHyGxW8/
 x7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717779093; x=1718383893;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2aRjr6VFhAbtDXp2bvf6Y2U8tH9bqXgZOYHrJK6zB+I=;
 b=FX6WSJz7FNiaJB/wE7TnQw9fO96ePJI8UA8UCbGt5x4WAFWtA2y/4nYSys8mtN0vxk
 37G76zX8rw3gnBuIVziRJtbmvzonc5f5YpM1mzcWwl1j5gRQif/AtosruZS6kdj8IHJX
 +CkJPwO4w0WDjxAQe/6TcLjvzED6ybx1Kh9bjyN+ct/uwO6JAHtzoi/TPQiZsYKws5C6
 sJ0VTdjvyFvBqAEWIn7GKQQ3+WXrZLXZVagfvRePXRWazSazLE37wq1/tb7yWPcWpuVu
 V3xqu2Vy0GW87Vwc/1as5Pwt/3KyUXxOVq7oYwY2et4KHf2023qgbX6K3cXlX+VWEer4
 CB3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3/kuyVtFXLDn61CaA8XO3mtRn94Ng8qUNUwFvvbGKq85P13IUuBI9V24nA8lTWZjK4/gvNqk+MjD84d3Q4TJ+ZCgS7Q==
X-Gm-Message-State: AOJu0Yxz+YER1MAO7e1cYWcXZYnbSCAQkw/63GwbQE+UfojmnBgsiPRT
 6X98v46LzpjWMFVzqt0Jyn1ZxzeNgxjbXXfs9EUA7yjfvQvExXReQc32LsnwTQs=
X-Google-Smtp-Source: AGHT+IFKi4UFxIXwh5RalcOxS+Qc/XgUJdrBzm7AoTjzfbSbfEFtwOs1Bb8EMnjEzsLeL0ateuk+WA==
X-Received: by 2002:a17:906:a015:b0:a69:67e3:57e6 with SMTP id
 a640c23a62f3a-a6cdad235c8mr199450466b.49.1717779093301; 
 Fri, 07 Jun 2024 09:51:33 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c80581c05sm266720466b.7.2024.06.07.09.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 09:51:32 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/2] arm64: add a software pagetable walker
Date: Fri, 07 Jun 2024 18:51:18 +0200
Message-Id: <20240607-caleb-upstreaming-v1-0-99094dabb3d9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIY6Y2YC/x3MQQqAIBBA0avErBPMRKOrRAu1qQbKRCuC8O5Jy
 7f4/4WEkTBBX70Q8aZEhy9o6grcavyCjKZiEFxIrrhmzmxo2RXSGdHs5BfWCS2lEbpTtoXShYg
 zPf9zGHP+AFbjJFdjAAAA
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1705;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=mbugjza/3AXFMrnsqXThdsfeoDL6g450s5i6UZXmkj0=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmYzqUu4ivmxv41AHMQj62wRIVgRVL3gr6OfS8K
 KD2vBhmMwOJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZmM6lAAKCRAFgzErGV9k
 tqUWD/9WxB0BVMAGb9qDqOeGEXPxFAB2y5vzmePtqf9r0ASafq1JoKvoovjx4+Hxncpf2QuGLEN
 dKoLyku043D4DmiFP9R4A0HVFVriJ2y239+Ps5DIDtsw3UrApCNRBp0wPG9FtHDkEI3YMZhY+My
 PY4ZK6hwOnuU6rMYPthV4khP5/eNjOv4clvHJOpKiKFwHGhduDeDfDUtsVjfhWRfwvNXOIZpr45
 AIK17FH6zMbMkwPtCodKhhUqDRf19HHZwG1ZZPMhpCB1C/uPcdBNLZ3kQeseoSzhvqPfFAXpp6q
 IFX5LMnl+S3qMfjfbasxdzFbib8GcjcExQN3vE34F0geB3W3mDXjxnzuih+VjZ3AGZ/KZodcRre
 xRG6V6BV3K7LP6ExmAMN+OhcVrUWAwnL5fseM6FvuST4Zzkm8DHqrj+ol095eau+pWOlzaJV0Nc
 5576PhyjlHEojSt/c3+Y0bv3VeWRo9qKh6oueRDcSeHv5JVj3z/iYSLS6kF7wJZFAZPcjBvl/yv
 qB+x7e61NIeZgPTZPYm7jTeno6CwEefrI2YAWA+0HhW4N842tSbihrWlyDJtgtEj1t4ImJkIuvS
 WH30zwbjdwXEUNB6Cr6laUZeqwftW37tOvAHFbgZAmcJ8NxAFXB9sC6w/sjkV+qF8PGV7wRccto
 /4EbUyD/pn/qisA==
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
Caleb Connolly (2):
      arm64: mmu.h: fix PTE_TABLE_AP
      arm64: add software pagetable walker

 arch/arm/cpu/armv8/cache_v8.c    | 202 +++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/armv8/mmu.h |  57 ++++++++++-
 2 files changed, 258 insertions(+), 1 deletion(-)
---
change-id: 20240607-caleb-upstreaming-82744a2786b3
base-commit: 22ca7e13dc02be83c29450ae4444add8e150ebdd

// Caleb (they/them)


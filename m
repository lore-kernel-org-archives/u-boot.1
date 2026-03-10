Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1C2FD4F05
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 16:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2187F84179;
	Tue, 10 Mar 2026 17:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mBf8gLCa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22F3F84154; Tue, 10 Mar 2026 17:26:30 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1ACD84171
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 17:26:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-67bb5e4d06eso777835eaf.1
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 09:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773159987; x=1773764787; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=f6tXvmUS2jEdx0ZWVMkNnSL6FLfjnxLSrq9KZ7WUOow=;
 b=mBf8gLCaMq/i/iyaogVeWm6/wb8wOUFJ0FfplncwNQONVQAMdoVFeOOoLSNJ8cEy5l
 G3Ibk1Ph91DRN5wFyE5792/OaYjAYBLnIL9L9f8u7+yRYIkifhemX9ieeHbWdtKr4vZ3
 b13hfx0xilr7JAmbhkSqa3bZKjFoTnqUVWXZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159987; x=1773764787;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f6tXvmUS2jEdx0ZWVMkNnSL6FLfjnxLSrq9KZ7WUOow=;
 b=aAQ6GWWYferHTEN56kfL5xrbYx+DN4/iv1IjRPm9Ls8AqpLyNhFw7w/w5/FqqBdZtY
 Yicska8jxaGPdYyx6EDIucpJ6Fge8UnDspszRnxZMXypDXiUjnWQd6AfJAJvoP/mZHmz
 txJ0dyv4sg9Sb7pZVYLwYDZApp04Q1K4CYJVLTbXLL97Ox0NPbbcGpVbaoN1/JhmJvBd
 h7zTnJ7XMVBd4YbhFpPZEWBCybk3OQZ3AvtK7G5gsmTIz0PSMwCe989CBmllUONjmJ6h
 AkWKRJCh7F0NMblrAkoRLTFZ3v/pd6prRFOUoby/gbrwOkMJXKTdv4AHDtDbrl9oMRYh
 RK+w==
X-Gm-Message-State: AOJu0Yy3AcNQ1Quv0NQLv4oyAT5Oi1GAlhfT8sd3NRDZC6v/Wcr+ApTd
 U8GCu991EtYoG3v4lcgXn3BBNXvPu2M8hptHy4zvjAxnqYna8RtMpVQ+9S+ZwzfXSkJY1LfvvA3
 1mnMfBwM=
X-Gm-Gg: ATEYQzw5ApaVvdgHct0bN6RiHM8SuwJFcHp1wCSK978M74K8LRU0/T8y48WqP51W6mH
 wUmxUble/d5nUnqILqAAl4vQSnHc1rIK4Rdfp0JrppzOWgWhcH8W87dELErywOHBoj57lmpBKx3
 TPQhcEt5WYRtWgJ6HljrtsTbVdlYmSHWaCHuYOCH+lMYOF1AarYXoNVw9OG83uOcGnqXqJ9zSdf
 TjurPlSuDtsAHCV5B9X+gTt9/NZpVFwxRF9I6EzhGlhAWOjupjFpuFxAAw4CgT6R5MOKvJZ0nbo
 xMQdj06icaZvnvf2rX81XAEPYAprqd83lPND+9dryr3mTliD8rIBK/EHHWF4UdTOr1mCIkXsGF2
 T9aILeVjWzHwIuHOmLM59aofp/Ih9LBR0I5JK+ZVxR++BmrCucHk5a2gE7h+xRol4S07P8iEvQR
 lof9SbUdzHnKz5jpr+sPIjNFs5efwtTvvNj1AtNQoyEOWOuUMBuaYZYaWrgvaKWIgWTccd0lFQI
 r0slgFCypzIBYk0qQ9DXEKT+OGGlsmLQdMuiXtnVJ8FnZX/jz3f+iTjGzQ=
X-Received: by 2002:a05:6820:828:b0:67a:1bc9:92dd with SMTP id
 006d021491bc7-67b9bd76ce3mr9633449eaf.75.1773159986701; 
 Tue, 10 Mar 2026 09:26:26 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67ba42709e9sm7008252eaf.0.2026.03.10.09.26.26
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:26:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] sandbox: Only select DM_GPIO if GPIO
Date: Tue, 10 Mar 2026 10:26:25 -0600
Message-ID: <20260310162625.1163957-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The DM_GPIO option is not available if GPIO is not enabled, so make this
select only happen if GPIO is enabled. This avoids a Kconfig dependency
problem.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4af0da2485fb..53697c31db6b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -196,7 +196,7 @@ config SANDBOX
 	select DM
 	select DM_EVENT
 	select DM_FUZZING_ENGINE
-	select DM_GPIO
+	select DM_GPIO if GPIO
 	select DM_I2C
 	select DM_KEYBOARD
 	select DM_SERIAL
-- 
2.43.0


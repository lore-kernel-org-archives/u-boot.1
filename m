Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7358C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 16:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CFA582BA1;
	Tue, 29 Jul 2025 18:07:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lh86aQra";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 175EE83197; Tue, 29 Jul 2025 18:07:39 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E0B482EB8
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:07:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3b7920354f9so675288f8f.2
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753805256; x=1754410056; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eG215o2L6dTF5UVmOvDhoEeJt/2JGwDj8B519N713YU=;
 b=lh86aQraN72bO8owo7mEJbXGS5HrmVzwE1ZptIA/ckUyUTTHyi+hja5y5FL6XvtW0z
 PraPPn5YbxyKKG7fTxbyLgupNjlpUkUkcsV+dhNqbDjPsfL6QPvnizM2sMRjAkvDKLSu
 prSL/4pyNyZV1XCkuAuFiXp5+r0MtvGT6f9e031mIlD1a6SPyJpJoQzq2su5Omioir36
 CPepS6A7M9MSwjVwXzZ9A28NUQ5vEpYQILkKJkLuraSgvyBJ/MZNVT8CNzQb7dc/6JuD
 p5fgUWdQwlgMO4/NYh2xsqovin+ng8mWs5uhAXSTIkr0PwbbYeQk5gl/YxQs4BuzQT8Z
 sFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753805256; x=1754410056;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eG215o2L6dTF5UVmOvDhoEeJt/2JGwDj8B519N713YU=;
 b=Tlu7wPIKQT12i2NSVBgsGWRR4FPu1PWJ4Lt5Ks9rrpyL7bhvEMeTsFH06KjBaw/qmJ
 oLtqn9sdXp2WxXPLHMGMSsqbcYG3oi+1P9kc5cKgPOGtHsZgCgBFTp9XTSOaw/3Kh6n+
 kb3NMJY7nILWCGIB7dJSNnLlW+jFLb0hjm2OT8+XSY4u0UHywztFJZIYbcu4r2/8XB2z
 aKuxMq3uhsVYcG5EGkFSqlcKPNZtpsiS0deWayP7AXYJHL31ye7NW+YDENc1xpF4LtOM
 231vskVNXiiBFC/8jz3SKb/rzy3uuPOQh17PNlY+UEPMqopLSH0BXu0N87Vq0LfvCMP2
 7W3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOqQ6u+ZzFjY5rDVr6/WA+YOHuCv06rLQIlYQbCAJa+szTuOV9ClALF8xcJKi6qAnJcePq7jo=@lists.denx.de
X-Gm-Message-State: AOJu0YyDF5FOoNrrEhBIj0xwDa/cluKgb3JaPA4V0oqMYhaKU9atKdem
 Mu0srLam1Hryv73mpn5bxivjiWq1QD91CewDIO/q6Hz5MZDtigu5EtsNKJOj2mLcRTs=
X-Gm-Gg: ASbGnctbUFOd/QQTK3lTGBdUzfnVpQRLtI3n324GHZphfjcxXKQg+S+HhliG0zzwjHT
 ZDY1rNgp6MZzVhFamPg/MmJRaYfOfqOxZ9wVsP4zbDk6GI4m0uMDaNt0Z6u/hK3j1iyyAJjSr4l
 Uu4R33vqCajwToAVpx70oBd6H+PtVa/W90yV2nZR8imOsmCPJmFznPOfPfLPjU3Yz7rXu0VO2F/
 lazP5NTG/WetlrDwJor8ZcJCqxR7jGRMiBUuP9ZvZTK4cz1gjR/w277TbmiZ+9iY9LvIbLMpsRs
 gebaNxLOwotRRPxqTd0dHQ8tLdBfJyBXLvXG0Jc44EFx7jvr2IqXmJt7u4Zax2mjudmjp2tSBgA
 8+KBGmgplqjaQm+Nz37yt7AVqmnPFctZpMqHMXaib5tbZF6Kg4LO4R0P1biy9fTPnMyTryznqwW
 VcELzZ908J7A==
X-Google-Smtp-Source: AGHT+IExDffx4u7h4yHk1AU5chDXXvSZ6MmjY7f/wkIWhl/pIYSYEtlvRLtnB/kQX7Ag1oLlm+ouOw==
X-Received: by 2002:a05:6000:200e:b0:3a5:243c:6042 with SMTP id
 ffacd0b85a97d-3b794fe4e34mr182517f8f.2.1753805256347; 
 Tue, 29 Jul 2025 09:07:36 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b781d2fc1csm10512075f8f.5.2025.07.29.09.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 09:07:35 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 18:07:22 +0200
Subject: [PATCH v5 01/10] cmd/exception: missing include string.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v5-1-0009c4620a46@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v5-0-0009c4620a46@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v5-0-0009c4620a46@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=ht0PVAG/UPdWKeozeEuxksuwC/pt0UiZIujECKi0GJI=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiPHBLIpIbhthzqGqdbiqLR8V+Wy4HkOekivdv
 22MJLeCteSJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjxwQAKCRAFgzErGV9k
 tk93D/0aVBwQfqXlOVeDkCLX8f0UHHLEUitYrE3dAmyq7EdW6z0iCdqfF77p0yNo2uD8jQW2fvH
 GjXOKOKjWfoP2V0tKJXyL7cWQdVUjqxYMfIN07bZ0K9rO384mTvHzNR2Euq4LMvfJQ4PcChx83R
 Scsi6lKzPaQqLsAiFsShT97X4BHjP64ztmY9U5S1oNyQQPtTgVwL6ila9oEQyynvkkKi4G6a6N/
 8+8kUOxvYYZdZFeU7e8liI2ptYyc6xd4by0jUj1MEvhC/1BkuC8A6nxA/sVT38MoHUMx5yO57O1
 DGqH0geTAlw7+aLrRVy5lEQm6P4VAg+xkoiQHI/yh1tcCtkZ6nbHku4K3Cks6ZroFKG7WqbsRBH
 YgYWgLh5rY4dVgRtWsJBuuJGZ/BhkufKrysy0AiaE21I+XXgypHW5qzJu5DySPfkPUBiNsqfEP2
 U+Ajg8gtboNi5ciHQaY+YcS47ErhnT4HRxIs3yeRZV/LvtcQmhIHVAR/6bdFGGm+T9GV0mZuCwh
 ZqOuADzIZHyeF7YDmJ1qATLxMZxefJzVeHanrEpK20yjsM1xPtsi2fYtud62hLidCdJaED3OmBF
 5wrQGqEZTZ3fKmmZlZFf2j9Yyuh5fUWgA45ednj3FsW25+Ako1KT1DKKFucYDDGev8iwId3XIx5
 +Ap/TbZ06zjkdFw==
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

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

When building qemu_arm64_defconfig with CMD_EXCEPTION a build error occurs:

    In file included from cmd/arm/exception64.c:87:
    include/exception.h: In function ‘exception_complete’:
    include/exception.h:41:23: error: implicit declaration of
    function ‘strlen’ [-Wimplicit-function-declaration]
       41 |                 len = strlen(argv[1]);
          |                       ^~~~~~

Add the missing include.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 include/exception.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exception.h b/include/exception.h
index a7f21e73d7530972eefb3255d799ed45de30c82f..0d4dff49954ba1445a16c151ab480d9859a7bea8 100644
--- a/include/exception.h
+++ b/include/exception.h
@@ -5,8 +5,9 @@
  * Copyright (c) 2018, Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
 #include <command.h>
+#include <string.h>
 
 static int do_exception(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
 {

-- 
2.50.0


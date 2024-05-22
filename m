Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6379CC25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D14F6884FC;
	Thu, 23 May 2024 01:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DU8f4djZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 069F5884E7; Thu, 23 May 2024 01:31:42 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D428E884EC
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6f0fd87da53so4004018a34.2
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420697; x=1717025497; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UK+La7C1WTAR2Q1AWdJrZ4bxawvdTt4on1J5ulr8SBE=;
 b=DU8f4djZ1tTo3WNs7S8kTj+0l7oR2jvjnGzXxQjwDSYrloQOqjWUPp6JQ+W5LylSpB
 nno7VsMHFecMyBTEMBi51XRpo1m8+M0B+Gkos/1+QvyuyfjwmJR0MVKg/x3D4Bs7ibgh
 mjzQNnNgzxzzlYDXN/sQD+a3ZMi1jJVjrop5JYfw59EceOCwTtamcFx8A5VCswYRBmz0
 CfZlEIvj5SKB3WJWUtGP08B0DGgTYDehIZYzjWrgY+B09YEf+X4kshIMM8qh2yT4iS2K
 ma7EG7e/U2fCB1Ov6ffluGvu7KY1RH8SGaCbxBWJMe1b34cLUkpYPfkOlNnqpvwFJ6p5
 e79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420697; x=1717025497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UK+La7C1WTAR2Q1AWdJrZ4bxawvdTt4on1J5ulr8SBE=;
 b=p+U9AzsSdOUhRJbRPAttM6cKUyZrYV0mR0YtwZh4UEMBwMdsBWbu/XbJ1pHsZMyBfj
 WwjvLb1xXtA/GDT66k7v7mtKms3NMS4j5dg/Vb4eNfWGRvTtqUT/OXzZ5GFKzZtuvMKO
 h1BzfLFdhlv1xprPcisHPZ4DuwzoGCz3CweS9E03B5pRUB8HPGwOAV78jOv2WZ0B0UxR
 t0lZvIjgfsFJI42RJJaCKG5DeP9EwF6xSD/RorvOeolOUhqf9HNtEvPZZclvUQIgJT/e
 JCKsiTeI5fRqF5GNYU7BGrJkoIcKI8YiW4Kz5613oUpzAF/QngAAYV+9v55z6B5eo7Tt
 ooqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr7oUWUhul/ABFMxyvEw/d/jP5Q0jVDmt9pVb/zkgDqqo+CmdfdWLjJIBohptd20AzxlafS0R8caHjTuodXlElV6OxYA==
X-Gm-Message-State: AOJu0YzG9rWVVt5ftLbXKJ+6vv5L0hFhR2LFNkKO2XvLgZuIWhsOlgA8
 21hnnIxjX/sLu0Nh2UifCrWIL6h1oenQ5TXOMpVNH+rflazuz9nVJjU0LPSVI+M=
X-Google-Smtp-Source: AGHT+IGC/lLRwLZrg+hXrFTaEnWaOnLXvH6/4uqb+8bRpJP/9ZQ1BqwG/uwhoauqCsx1eONu98JQpg==
X-Received: by 2002:a9d:7309:0:b0:6f0:6f1b:a55f with SMTP id
 46e09a7af769-6f665191e67mr3548182a34.6.1716420697638; 
 Wed, 22 May 2024 16:31:37 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f0e49e317bsm5038343a34.57.2024.05.22.16.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:37 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH 02/42] mmc: dw_mmc: Remove unused version field from struct
 dwmci_host
Date: Wed, 22 May 2024 18:30:55 -0500
Message-Id: <20240522233135.26835-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522233135.26835-1-semen.protsenko@linaro.org>
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
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

Nobody seems to use it, so just remove it.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 include/dwmmc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dwmmc.h b/include/dwmmc.h
index 136a95b8cdb6..39024fb38aaa 100644
--- a/include/dwmmc.h
+++ b/include/dwmmc.h
@@ -163,7 +163,6 @@ struct dwmci_host {
 	void *ioaddr;
 	unsigned int quirks;
 	unsigned int caps;
-	unsigned int version;
 	unsigned int clock;
 	unsigned int bus_hz;
 	unsigned int div;
-- 
2.39.2


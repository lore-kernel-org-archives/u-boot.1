Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE76C38147
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 08:49:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A613E8797F;
	Sat, 16 Dec 2023 09:49:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vp+9JqT8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA21987B8C; Sat, 16 Dec 2023 09:49:06 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C0A4876F7
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 09:49:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-552231d9c1dso1935868a12.0
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 00:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702716544; x=1703321344; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jY3q45KUIp44it7BTupf25SkTW1eIU2wrwfWOiGQX1A=;
 b=Vp+9JqT8drxLOnTzI1zRc9lV0O4soiNAP9GXuwZ7i3PY4b5gfHjeej9NpNWJWC08tO
 fMDf9kCIm+SMlXvDCbO/xjQVpdivHelHLLleeceibC3LrCfziYLa6q3ANHKdCIdw68GM
 0iT/Qqv1eGXKC1UiJwTtN6ANUB7G/7yDrMuzcWpjgu+GZvXdX6feAN5NNQ1dquu7MXCH
 pWC5IHqKdXDpTLWUQjUl7xojkKHoTU0De1MPQvGsLLAc22t1xbL3OO0A6tQA6hF5aw4T
 Q9NxkeUuodUyre+r/yvLd15FnfgW8yMkMmOxhWI3X/nrY6UrJ2kEJ4P+iBwe6CZYIoxq
 1CQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702716544; x=1703321344;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jY3q45KUIp44it7BTupf25SkTW1eIU2wrwfWOiGQX1A=;
 b=IqPLnPYT7KsRZOd28Jkoi1kh8hfWd9OhknsAxKjzr5E63bpZK7D33IX60QbuaRLl9F
 ie7gJBysXY4Ajgshz+9j4BO09kOHw58SsC+IjpFLaJT9zXRlum/I27RFLkDsr8z7CjWN
 vvLajpeLX9ydfiWBjAm3R7sFMF7olqsRwd2swnaR7/Rv8lzhxQj9T+60/6npGFJCMYok
 MqH5eAd7Hw39H+PXtQig5H5MkgbJZSDbp1P9UPalhxOipYBxp+I7QX86DgUBEN8zepr0
 h6h5U62tx89Pv30KnxvKH6vR6FNoZWhlyAfnu7g+98mcq3/hkqT+tE30xEpt6I5PAbGh
 kAow==
X-Gm-Message-State: AOJu0YxcWOTP0IXZFWJl80Tty4LDEDOrRhKvf5yrEMs0vmiiMPnb1scf
 +xvhJnpwBETFSnY5ImVpRAE=
X-Google-Smtp-Source: AGHT+IF6Z0kfoVnTZVDgR32OdBqkLUo6NBV3HoJsjI5e30ki6w7zFclWv/7iGrOzCoTlYNxdl7C66A==
X-Received: by 2002:a50:8dc5:0:b0:552:351e:fd0f with SMTP id
 s5-20020a508dc5000000b00552351efd0fmr2988925edh.73.1702716544095; 
 Sat, 16 Dec 2023 00:49:04 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 f22-20020a056402195600b00552687b7b1fsm2525197edz.39.2023.12.16.00.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 00:49:03 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/1] Fix clk-gpio driver
Date: Sat, 16 Dec 2023 10:48:37 +0200
Message-Id: <20231216084838.19403-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Existing gpio-gate-clock driver acts like a simple GPIO switch without any
effect on gated clock. Add actual clock actions into enable/disable ops and
implement get_rate op by passing gated clock if it is enabled.

Testing current driver implementation shows that it is not fully capable
and lacks gated clock manipulations.

---
Changes from v1
- added comments for priv struct members
- return gatet clock rate unconditionally
- switch log_err > log_debug on of_to_plat
---

Svyatoslav Ryhel (1):
  clk: clk-gpio: add actual gated clock

 drivers/clk/clk-gpio.c | 44 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

-- 
2.40.1


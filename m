Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220C5C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABFBA81671;
	Wed, 12 Mar 2025 19:15:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iJR3wP6B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C347481782; Wed, 12 Mar 2025 19:15:36 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB3C08141D
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:15:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-abbb12bea54so31345266b.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741803334; x=1742408134; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m+aLMxOxU57xV3q2C0DUGCLtwzOnE4qBqKRBXOjgw4I=;
 b=iJR3wP6BQwfumFV/T9pKQzk8oNlPPatavzTohQNMnL0uQo2CokEUM78++quyCWTXb/
 fbSmxrRQwu5D9lMAqarQ0VaOwuTlMdrQpTPeXKJjZ3wXbPAe9IuPVjMp0j8A7G0tmLZD
 2dq9Ju29io43Sw2h83C8rm0Os9XAiM+wNnQpUcxSnub2IxELwRNuQbXGVOkg2KEprC9z
 29AuMM/P0VOME1xR2W/zXnlpoO6nEGiF2K5aB8A71CVEhzXcVJWOzt7LWg+/9hEW6BWg
 2nxgObVLPULV5Fp+1WJBZh78mfUSyTDiTnfckZIuE5dTDbMXqNu7izlVq72otue0p9iH
 Rzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741803334; x=1742408134;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m+aLMxOxU57xV3q2C0DUGCLtwzOnE4qBqKRBXOjgw4I=;
 b=Zig9XkoB+fhvD6H8lK2BpTztHqkt7v5V6H2OBhCzkfFr9hK6RT3C6/UFjcd6mJqCq3
 L3LGr5EXN9g2a2XVFZgpCke8QPu+hblZlHBBG9jT2WOF+MdKPDBjEuhu/NBy9P9Tioa9
 8to3JYXyo3BQ31qJkQYl2+dO6OrZsFqMhugjCHA6q3oG/U8Sr20Jsslt4+nMV5OkoCDE
 oq0TLeSUpCCvBJAKIMKIK0sJk1Q7+nmvrMmwjiwbz/bI9wqIjiyTaMdRO3f6/IQd5+Na
 AeET/2CrN8z2onBDOfE8t2IJalnxqFvVmcfMTsvOFXkM2HthM/ik78dGvVczTq9l9Xwd
 fhtA==
X-Gm-Message-State: AOJu0YzyMUGrQPgXcxY0nSX88iy7ifU8dycHi5QIxlCQ3JzLpADFd36D
 yQgh1fVPv1oq+/HGltu4b+heCIyMX/9uclYeICua8As0iP0iQydD
X-Gm-Gg: ASbGncv77QhuGkkewVb0j7dgKNC+NtG/ydaBEb9dIr6jpHxVL/XvHaIgmn5xm/5NOzR
 ePJC1+SVJakzs/XxVJ1dXzzSDLOwOyYAvyCLtLaQLKd0hZqMWJI7Ezcwgq0wRn64IJgfIVVoLSS
 Oqyx0GoFrewbtq9IoWqElpXKJR9nxiMlg2LwJvG2+uKqELUAqbJl+bk01+CtnTCHc8cU9sSUN5f
 wCcuuqvGkgPjAiKw1vVV73YEbCvsylPvYJfaghPLVU9F768I2mcSYIG4RRFi/koXmi3O31DRuH0
 mHxORQMP/rjp8rV+v3gCj2PMoL3hAwCEZdqa
X-Google-Smtp-Source: AGHT+IHVMil9OlUcoac5uLgYPrFn2fp/2fY1rT55F6OVAH0J/xqLuDdqpcNjAC78LApKe0JhyNaAhQ==
X-Received: by 2002:a17:907:60d2:b0:ac2:a2f9:4728 with SMTP id
 a640c23a62f3a-ac2a2fa14a9mr1723707866b.56.1741803334164; 
 Wed, 12 Mar 2025 11:15:34 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac28c11561dsm641906666b.145.2025.03.12.11.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:15:33 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 00/11] video: panel: various panel fixes
Date: Wed, 12 Mar 2025 20:15:12 +0200
Message-ID: <20250312181523.121313-1-clamor95@gmail.com>
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

Fix missing LPM flags on all panels below, adjust endeavoru panel to comply
DC changes, add power supplies and fix reset gpio behavior for renesas based
panels.

Svyatoslav Ryhel (11):
  video: endeavoru-panel: move backlight request after probe
  video: endeavoru-panel: add missing LPM flag
  video: lg-ld070wx3: add missing LPM flag
  video: renesas-r61307: add missing mode flags
  video: renesas-r61307: adjust compatible
  video: renesas-r61307: fix reset gpio direction
  video: renesas-r69328: add missing mode flags
  video: renesas-r69328: fix reset gpio direction
  video: renesas-r69328: add power supplies
  video: samsung-ltl106hl02: add missing LPM flag
  video: sharp-lq101r1sx01: add missing LPM flag

 drivers/video/endeavoru-panel.c    | 21 ++++++++++-------
 drivers/video/lg-ld070wx3.c        |  2 +-
 drivers/video/renesas-r61307.c     | 13 ++++++-----
 drivers/video/renesas-r69328.c     | 36 +++++++++++++++++++++---------
 drivers/video/samsung-ltl106hl02.c |  2 +-
 drivers/video/sharp-lq101r1sx01.c  |  1 +
 6 files changed, 49 insertions(+), 26 deletions(-)

-- 
2.43.0


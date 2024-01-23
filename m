Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C18C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:40:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F6E887D67;
	Tue, 23 Jan 2024 18:40:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a4EcaGps";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E000787DBA; Tue, 23 Jan 2024 18:40:30 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F84B87D4B
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50e766937ddso5422117e87.3
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706031627; x=1706636427; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EB805FhMjvmJ6hQfBAVr2Z8Z0GY7s8U0IFMDKSkLPBQ=;
 b=a4EcaGpsWvhNoW09au+nWc9O009kf5gR9RJDnMr/zdSG5VCnSAR3GgOqUqE5CfPt+v
 8KwkN/MxL29RXsfDUo3ArVOTEb+ivTcX3+0sACHFJeFiQ+3dOuMTJR5EqnK0+c4gDH0t
 583lin5m7GAokj+zf3Kv7dI8VTpJSJ51IM1NojHh0Yw1zbZ3Sc21uhGoZZMCI9NTfKVa
 kU0OPRc+95xMuVeFgv2igDN49NUMfAxnXteiNuW23wO3LIqF/VbbL6X5L7Tvg53Zsj64
 Js2FqcLiItJztvXO4WI0VxB34QbVEgXA5wEwBRf3fERGubHbOEw3i5Xwv783xgucUXXr
 wcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706031627; x=1706636427;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EB805FhMjvmJ6hQfBAVr2Z8Z0GY7s8U0IFMDKSkLPBQ=;
 b=LfFXP6uhXdYfL4O1vYqNPMqFHZthqdh2I5ArCohUZL03JKXioYkoDMEXVUSHoqWNEn
 lTnHlDhdxvRrOjgkmGYQw9MZxwNScxiMu/pdkpcTflQWFArV5R9TzkRkK5Rd8NGgip+r
 QGDKYI6ysE473stkFWDaQtKXwHc7paDU5wa4GjRajGsxnkFKPe2x5iAcJ9oiU3xPTQQR
 Nhntn6yq83TUA0SeBtRjAPcZmWIAxfyUoLzleA+xmoHIDqk5ahBtsAToNdZsxMt6u+Xi
 gdN6Efis2Bf4gIkgJ0Ym0fdZwi1iZ2LqWNMuT9MzpBZc8akc91VpyOZr2FV6BuSzd6mp
 lWRg==
X-Gm-Message-State: AOJu0YyCWjZ7wnQcfoUWRyCWCaqFgT/jmReOHuz1o52vgvI5lvfI1WjA
 km9twt6QXji7HOWgwNJKoepU4IMAx9DlY4ZzWMS+CwOObADfTeeJSMoM+RDpqnGx6w==
X-Google-Smtp-Source: AGHT+IEjvWz+9gKyR/OQDGTtxsCEcNdeFOBi3DDImOrx46dz0apBRjPo9s7cZZH5OaBxHgRIs8U8zg==
X-Received: by 2002:ac2:4c53:0:b0:50e:7718:d4b8 with SMTP id
 o19-20020ac24c53000000b0050e7718d4b8mr3350274lfk.96.1706031626616; 
 Tue, 23 Jan 2024 09:40:26 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 q25-20020a056402041900b0055c104274e7sm3526286edv.78.2024.01.23.09.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:40:26 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Anton Bambura <jenneron@protonmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/5] Tegra panel improvements
Date: Tue, 23 Jan 2024 19:40:04 +0200
Message-Id: <20240123174009.247414-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The current patch set improves the logic of existing panels and
bridge used by Tegra 3 devices and brings support for additional
DSI panels used by Tegra 4 devices.

New and existing drivers are fully reusable, contain no device
specific parts, and are written according to existing datasheets.

Anton Bambura (1):
  video: panel: add Samsung LTL106HL02 MIPI DSI panel driver

Svyatoslav Ryhel (4):
  video: panel: add LG LG070WX3 MIPI DSI panel driver
  video: endeavoru-panel: shift the init sequence by one step earlier
  video: bridge: ssd2825: shift the init sequence by one step earlier
  video: renesas: shift the init sequence by one step earlier

 drivers/video/Kconfig              |  17 +++
 drivers/video/Makefile             |   2 +
 drivers/video/bridge/ssd2825.c     |  82 +++++++------
 drivers/video/endeavoru-panel.c    | 128 ++++++++++----------
 drivers/video/lg-ld070wx3.c        | 186 +++++++++++++++++++++++++++++
 drivers/video/renesas-r61307.c     |  93 ++++++++-------
 drivers/video/renesas-r69328.c     |  81 +++++++------
 drivers/video/samsung-ltl106hl02.c | 157 ++++++++++++++++++++++++
 8 files changed, 571 insertions(+), 175 deletions(-)
 create mode 100644 drivers/video/lg-ld070wx3.c
 create mode 100644 drivers/video/samsung-ltl106hl02.c

-- 
2.40.1


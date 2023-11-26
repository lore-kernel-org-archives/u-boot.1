Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A0DC4167B
	for <u-boot@archiver.kernel.org>; Sun, 26 Nov 2023 22:09:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA0FB87496;
	Sun, 26 Nov 2023 23:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="qbQwSCxo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60EC8874BB; Sun, 26 Nov 2023 23:09:50 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B30587495
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 23:09:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40b397793aaso13665055e9.0
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 14:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701036586; x=1701641386;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eX93EeT4Y17h2exsUqzCs+S7f3imXQntwq0tb7Q72rg=;
 b=qbQwSCxoLDbFRQcRGnT6K+bTBLy99lZj5DF1kdDcviLX/9JSLuWTj5RsATfCKXW7hy
 czx16fhiboZxSxYzafnB2XYRj2upRWL5Wb1cPnMoMa2yyzhrRr7btPP4LfMAI0AuBNHy
 2DH2NENC9J7/qtDDAHziJgCA9VjlOuL1vggyNR+v5uKiSS27EXvaaR1jkJH2ikwMgMyG
 1p7yAkG10PaFT9XegQwEcH1XEWdPt9ur5am3Rl0UzJNQNWt1i/fDtYOxQ+Ur+9I7FeVW
 5k94Tq/nSYMYJOWMm7cPALoiHGaOGiKp7m4OFVgGiQYySjuusB7UP9tGXZIQm1lxGK9K
 ggMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701036586; x=1701641386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eX93EeT4Y17h2exsUqzCs+S7f3imXQntwq0tb7Q72rg=;
 b=l/6N90jOcp0O/vsAEPM9YQqrGEMsO+qiajDPgkm9LGMNVs3lgmFwN2vrMIdSelMphq
 bYyipiTq7fa1D+zf8BkT9hS7CMeqCxs7S7VX7J/1YzpyrZursgq3NKCIy8+OfktDzWho
 2+JIsprueYC8ILRbTC9UhKpRloUaHf5OPq5V+MCdO5tJyJ4VNJicvADit93eGCkIsRV4
 vOJ6p8VHmHjoWcecfKc1p1xJeUGUe1J22bAQer/2apx3te9Py4Dc2GdunPR34VzoG065
 axQajzPcMf+o1fNFV077IxouyNEJi6z5YRyzEwpltHBk3coGistA4sWWuH3333zXJyRm
 bC2w==
X-Gm-Message-State: AOJu0YwVo1jk1z4nrwTHkXtBQWYVB4gbLhLYqctdDmvaVy/yYtKDqoJm
 RK5vYhZmI61pWWl91HwZhjHjBoLeouFRCUZxslSZMhao
X-Google-Smtp-Source: AGHT+IH81/CeyzugOhtDQXRSNZ5/+6/pjwMC5FzmFWmsYskFW4QyeyTSPkNSqo5KEciOEbuzOppt8w==
X-Received: by 2002:a05:600c:299:b0:400:5962:6aa9 with SMTP id
 25-20020a05600c029900b0040059626aa9mr11485197wmk.11.1701036585497; 
 Sun, 26 Nov 2023 14:09:45 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 p16-20020a05600c1d9000b0040b3e3eaad0sm6471126wms.41.2023.11.26.14.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Nov 2023 14:09:45 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Shantur Rathore <i@shantur.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 0/3] With this patch series we implement SPI Flash storage
 for EFI
Date: Sun, 26 Nov 2023 22:08:33 +0000
Message-Id: <20231126220836.374956-1-i@shantur.com>
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

variables.

Changes in v3:
- Fixed compiler warnings.

Changes in v2:
- Refactored efi_var_file to move common parts out as requested
- Changed ifdefs to use CONFIG_IS_DEFINED
- Fixed typos

Shantur Rathore (3):
  efi_var_file: refactor to move buffer functions
  efi_vars: Implement SPI Flash store
  defconfig: rockpro64: Enable SF EFI var store

 configs/rockpro64-rk3399_defconfig |   2 +
 include/efi_variable.h             |  26 +++++++
 lib/efi_loader/Kconfig             |  25 ++++++
 lib/efi_loader/Makefile            |   3 +-
 lib/efi_loader/efi_var_common.c    | 109 ++++++++++++++++++++++++++
 lib/efi_loader/efi_var_file.c      | 121 -----------------------------
 lib/efi_loader/efi_var_sf.c        |  91 ++++++++++++++++++++++
 lib/efi_loader/efi_variable.c      |  17 +++-
 8 files changed, 270 insertions(+), 124 deletions(-)
 create mode 100644 lib/efi_loader/efi_var_sf.c

-- 
2.40.1


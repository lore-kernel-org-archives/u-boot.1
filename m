Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3793CF5386
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 161D888DEF;
	Wed, 23 Oct 2024 15:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YHtdqd+w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39B6C88F82; Wed, 23 Oct 2024 10:52:43 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A7CA885B3
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 10:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liujianfeng1994@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7c3d415f85eso769439a12.0
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 01:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729673554; x=1730278354; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jBIJBNOZz+PQ9LIsmX4bUTQQgawChPUtaLPN0gzNMT8=;
 b=YHtdqd+wPNWaE1iuhcZQGP2clslrUhJbKpYZtGoSi4h3wNwcNHPmw1XLUyq5xR7UxW
 fUHOELf8PniV0OuSgWitbnb0QSIjn+YJRlsbo2EQufnfiNlDQ7/e05nKw22H7Y4yjReA
 VTB/rzW3QKGmMyQRlP31MIKTBJd4etS4D9gRpm2+YS5PPjKlQIvpW0wyNwSfNS3M858E
 Qw+dpFtvsnLHApxBrjJSlGCxnRxHJc6MQtJuD23xJhwLbF48Ac66+WWwvZ1ELKmOpWVh
 ZIdw5Q48GHURjBmWWNh9J2QFysv+226YzIQuh7VF61rFdkeiDW2h3q+0oogfOAjHvUUn
 eb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729673554; x=1730278354;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jBIJBNOZz+PQ9LIsmX4bUTQQgawChPUtaLPN0gzNMT8=;
 b=qZCFBl7Hhmaba8ki0WO9iwtI7f3JWCQXH/Px/DLYbx9tTajx+ZHlotpWNTufyjhxXy
 NUt9bJCNDo2rhSFP783TCOZtwRenuSY/u8ZK4LXIu1opb50vJkuPNHWXwjIAcf2t48eY
 N373049DXkeV6s47iZV/zR/sRsUxGdm4q7f2GznF6Hf3OYkUt0r2TcyZ6hioK8b1VNFB
 lQTuG+1uFo/jFUt/AJIOZ1sBuiOYRhmW2AtPqkWDAijQHlLGcomFGg7RvpCvtveNnCIe
 4tiiDb1NF9PN/ERYbmW7Ro+BvNeqR6MKaBic4H6C3lb3pUx1Qd/sFblUWwVS8pHl3Dde
 8nQw==
X-Gm-Message-State: AOJu0YwfLIFCs8CYX1ImkbonFSx0Jou4U+vXUSMeKHS7/oHXBJlTqOrR
 d+kCAzkPqUBP1BdhfaSilH+ba8TSbRtH9820tSwnycx4f+G5RYET5iCHSw9m
X-Google-Smtp-Source: AGHT+IEkGL+swSfr+Aal20lxvPxK9V+jqmbZJ8Z0juJWmEk8nZhanNf03qjFLFA8n9uVUW0KI1oCjQ==
X-Received: by 2002:a05:6a00:3e0b:b0:71e:7bcc:a0de with SMTP id
 d2e1a72fcca58-72030b1f0ddmr1275131b3a.3.1729673554275; 
 Wed, 23 Oct 2024 01:52:34 -0700 (PDT)
Received: from rock-5b.. ([221.220.134.146]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d7595sm5892689b3a.110.2024.10.23.01.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 01:52:33 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: u-boot@lists.denx.de
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Ricardo Pardini <ricardo@pardini.net>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] configs: orangepi-3b-rk3566_defconfig: Enable
 CONFIG_MULTI_DTB_FIT
Date: Wed, 23 Oct 2024 16:52:20 +0800
Message-ID: <20241023085225.403545-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Oct 2024 15:15:20 +0200
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

Orange Pi 3B uses board_fit_config_name_match in rk_board_late_init to
decide which kernel dtb to load. To make it work with system using grub,
we have to enable CONFIG_MULTI_DTB_FIT.

Tested with opensuse using grub2, without CONFIG_MULTI_DTB_FIT grub will
load rk3566-orangepi-3b.dtb in u-boot, which has no gmac ethernet
enabled.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

 configs/orangepi-3b-rk3566_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/orangepi-3b-rk3566_defconfig b/configs/orangepi-3b-rk3566_defconfig
index 2181c9caf58..e87849a9946 100644
--- a/configs/orangepi-3b-rk3566_defconfig
+++ b/configs/orangepi-3b-rk3566_defconfig
@@ -48,6 +48,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 # CONFIG_OF_UPSTREAM is not set
 CONFIG_OF_LIST="rk3566-orangepi-3b rk3566-orangepi-3b-v1.1 rk3566-orangepi-3b-v2.1"
+CONFIG_MULTI_DTB_FIT=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
-- 
2.43.0


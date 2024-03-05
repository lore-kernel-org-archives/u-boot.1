Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520A6C48BF6
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 02:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A04287E92;
	Tue,  5 Mar 2024 03:11:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SHicp1ey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E424F87FD7; Tue,  5 Mar 2024 03:11:34 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7E9D87FA4
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 03:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=twoerner@gmail.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-42ef1822b07so7383461cf.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 18:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709604689; x=1710209489; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RM2D/3L8qP7BC/kGElcnVyRrX3UdRyDY62OTgF8Zc8g=;
 b=SHicp1eyclrLN50BbJekD1SOEAnqQkaTzdqFQNgKy3+XnsMIbi0F/ZMZ/6av+mrM+d
 WMSUQeAdXRjoz5NxSgTUo7fAFYJs1k330k8hnnvZYV+soxw3Z6BUEKELo4Lu5fFoDZ4y
 MzwtspDnBOlMbZNqN81Ii19IiFLc7hIO0wr1P5CWSmRHKS8qqb9MR3MfEFGOhuWB7ZaI
 VZ40tw0bsee61GcO3AqwuKUy9deBhe2Drh3OAzg6Boye1W1yftT/Xp4WnB0wxCO+gzHD
 eMdsSC1LTBWP7caxHeWCOalnVLvQ3dXBG8JgprB2XtOB6eH7ajEPqvNm/h73C2Qez9iS
 B0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709604689; x=1710209489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RM2D/3L8qP7BC/kGElcnVyRrX3UdRyDY62OTgF8Zc8g=;
 b=geJ4Xi/C6gj90gFng9+LWibRRME8VS/6Q6KyN9d0O+D+HlYglX4fro4h+Kz0bP9Pg3
 BedFZry+IuXQFkaeXCxhwiDDNcAS82CO6JW7vN/2WSe/dzzyufepuEDhdc9lQG4QrXlp
 /uKwR1OatupnXc7WbEJdM6WrPeiOR+WTa8f8hZz2rsqOPuyzZU5s9C8rfa9rExcHXwRv
 +rhLvCT1aEv5H7SxKngpnbv6OIx87gv8gSD63GhzZknXs/eOkrtjt8xR+pVe1o3FvLUW
 rh+u9jkyVEr1lGn2VDtH5bRAwwK5uooay4Rp9m79OFA2pL8qlvStRfV4eaxTXnGTTYxo
 haAw==
X-Gm-Message-State: AOJu0YzOv9G04qYH5ctj346eL3Bb0MnJRvwtAxhhYMcQ172k5GmvSvG8
 ox4JT+kw0NoQ1PnxhklyRjjOUzXJLJ4oPKwd9w0XXGqsLtk2rYgkMfj4gZHOdNQ=
X-Google-Smtp-Source: AGHT+IHLdXY8qtBLkyaMj/6yKMwaMqr5fZxXAY/LZJGjrchrjHV3zALD4bQhk0SL0CJ6V8szqA8NDQ==
X-Received: by 2002:a05:622a:2d3:b0:42e:e0df:aec3 with SMTP id
 a19-20020a05622a02d300b0042ee0dfaec3mr647397qtx.31.1709604689687; 
 Mon, 04 Mar 2024 18:11:29 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca.
 [209.91.167.254]) by smtp.gmail.com with ESMTPSA id
 i19-20020ac860d3000000b0042ef122e15asm1558534qtm.12.2024.03.04.18.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 18:11:28 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Akash Gajjar <gajjar04akash@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Simon Glass <sjg@chromium.org>,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH] configs: rockchip: rock3a: enable environment
Date: Mon,  4 Mar 2024 21:10:44 -0500
Message-ID: <20240305021051.22405-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.43.0.76.g1a87c842ece3
In-Reply-To: <20240305021051.22405-1-twoerner@gmail.com>
References: <20240305021051.22405-1-twoerner@gmail.com>
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

Following the pattern of other Rockchip devices, enable the U-Boot
environment to be stored in MMC. This patch specifically assumes the
environment will be stored on the SDcard.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 configs/rock-3a-rk3568_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/rock-3a-rk3568_defconfig b/configs/rock-3a-rk3568_defconfig
index 28d157dbd7a7..44158a4d34f1 100644
--- a/configs/rock-3a-rk3568_defconfig
+++ b/configs/rock-3a-rk3568_defconfig
@@ -58,6 +58,8 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
-- 
2.43.0.76.g1a87c842ece3


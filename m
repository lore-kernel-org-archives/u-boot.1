Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5953DC3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D5078899C;
	Sun, 11 Aug 2024 16:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y9/Rcddu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7194888916; Sun, 11 Aug 2024 16:51:23 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74021888E0
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-81fb80d3887so139541439f.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387879; x=1723992679; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=75ApKbY0HV6OpkDrxFfww/adga1JYEL2PyMkFDH+c5I=;
 b=Y9/RcddugD6/Nx90hd/33r1Vhu3n8e/g/5YtN4Z9zdVBSsHkUAdkO3zI6zx7TGR/Mu
 GXe7cXjUaynhHsGQaqDRrf7+atknyaPQKbMsB8dFzWcYZNjxanBmiMSkicKjrVQbOd6l
 7lKI/sCALE+2p05oOO9+nbn/So4OvAsXYJtxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387879; x=1723992679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=75ApKbY0HV6OpkDrxFfww/adga1JYEL2PyMkFDH+c5I=;
 b=cYmAoa9DPmum/cI8uq++4Qk+Ty6sulNTGFtHK7wArChUkBQHJ8IlupB3IF2Zuxbscc
 ofoSUdDYByTE4qQ8Y9/lrFxGSgJQ855yfUNC4nl+jpSFcQMnGdWYQ6l3E545bcHzrs1m
 ULe9t6po0/UptmQj7o+63RdiyjELH+Da5i6lUeHFWTq3A19T1U20AhhTjNX+lkjahm24
 fIwpGd0yHkrcGWJdlVNDRIrblhqWhn2ZHccnCy+IOonxJeMPLTN+wOONCa9NQZzihfRy
 iZM7b2D94vrHwaLFmbtNM2wEAIPWYE/HgajcLtg1Obqql9YZkYa0S4DILgMGM5kJOVOr
 Vr6g==
X-Gm-Message-State: AOJu0Yxt/+2qHK7KCyg1CroquSeEtbGfM4WledlychtvODVE7Kryr17d
 jsPRXZIZY64w2LBaY9vUn11ud6nvBYzB56mNaw33bpI9Pzh9FV6EroXVo+EPjW4LuTOeQni9XmA
 =
X-Google-Smtp-Source: AGHT+IHO1kR+3miCcOrHG07Da/CtlfPen57rSSHIveVzqsdVD6EaHtW7x2TJV0Cqu8jNhxvhV7rZ+g==
X-Received: by 2002:a05:6602:2c82:b0:81f:938b:f0cd with SMTP id
 ca18e2360f4ac-8225ee392afmr1268840539f.13.1723387879051; 
 Sun, 11 Aug 2024 07:51:19 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca769fbe17sm1076047173.101.2024.08.11.07.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:51:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 07/18] MPC837XERDB: ethernut5: work_92105: Drop CMD_DATE
Date: Sun, 11 Aug 2024 08:50:36 -0600
Message-Id: <20240811145047.4189460-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145047.4189460-1-sjg@chromium.org>
References: <20240811145047.4189460-1-sjg@chromium.org>
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

These use pre-driver model code and it is several years since the
migration deadline. Disable the 'date' command so that this old code can
be removed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/MPC837XERDB_defconfig | 1 -
 configs/ethernut5_defconfig   | 1 -
 configs/work_92105_defconfig  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/configs/MPC837XERDB_defconfig b/configs/MPC837XERDB_defconfig
index 9eac43a0fcb..dd30e8d30da 100644
--- a/configs/MPC837XERDB_defconfig
+++ b/configs/MPC837XERDB_defconfig
@@ -139,7 +139,6 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
-CONFIG_CMD_DATE=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
diff --git a/configs/ethernut5_defconfig b/configs/ethernut5_defconfig
index cc2f567c8a8..004f1866162 100644
--- a/configs/ethernut5_defconfig
+++ b/configs/ethernut5_defconfig
@@ -46,7 +46,6 @@ CONFIG_CMD_SNTP=y
 CONFIG_CMD_DNS=y
 CONFIG_CMD_BSP=y
 CONFIG_CMD_CACHE=y
-CONFIG_CMD_DATE=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_JFFS2=y
diff --git a/configs/work_92105_defconfig b/configs/work_92105_defconfig
index 4b73e1551ce..e7da0de5df1 100644
--- a/configs/work_92105_defconfig
+++ b/configs/work_92105_defconfig
@@ -47,7 +47,6 @@ CONFIG_CMD_NAND=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
-CONFIG_CMD_DATE=y
 CONFIG_DOS_PARTITION=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
-- 
2.34.1


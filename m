Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CC8C83F25
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 08:10:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F284C8339C;
	Wed, 23 Jul 2025 10:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OR1tdj1/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 718CE833D0; Wed, 23 Jul 2025 10:10:24 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D2F98329B
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 10:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=prabhakar.csengg@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4563bc166a5so3886345e9.1
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 01:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753258221; x=1753863021; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WVJdIbu7WAHaQTGqV63Wgu+7tUc71pwK1r9SWgLag1U=;
 b=OR1tdj1/9R+X5TcxyBuzSjv649lGU2Eg80lZ49x1ZLgtAZQyEAWEb4rrDA+YXyyabw
 3IpfMckzh0uRtFGgznRsn/4Wv3eaWe6KMyd13BVPkS7KaSuQoJ8vjlnhprnP0lffhtDW
 mcjjVwFUsUKu+BuO+GQI5YrE7c/b7+YrH4fkdYWoBOintZAaGPVbQ6uG5J/NJeBZHD+T
 JiFumoK9aUcqRPeRiVfk8nVtkFY0/hr6kESzJtkEPPcSmpbuno1r5BeVVyUrnCqR04HX
 QSk/aBN8g8AX+eUCACXtN72YEQf4w4KfyMDq0maxIet69CtYpdOZdfTAPatsn6Ph0a9y
 wgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753258221; x=1753863021;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WVJdIbu7WAHaQTGqV63Wgu+7tUc71pwK1r9SWgLag1U=;
 b=CTQED/eWqORLpIiXE++B4gdZNKHGMAd4Dj5yYIZyRjsqVoyKw1MZ1YF6qpEjlypl8P
 XZYUHTb7Q39+AL/5oqv9EbtoF/g83aASMrxDfA9H0sBEofyG6WXT3Vi63RH4ftj0f7Dl
 +cZwW65CKIOe0J+atAMstGp+JG3HQ8HzbdkyuP1uegtHqe7OLaL1hJ0Ui6d9kxXKvSbM
 unC7oLkk1lc4S8NsxqRFbRKGAzQyDkszuniqAMWjrzacryEtYj/D/jjGCjmvtlpzH698
 a284DuShxa9GC9tDki9drY4PfihhHQO3zTxxQ5iQUkUvqOkCIYP9TN1xIhg/zgdpD+2a
 Fs1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyV0w9fNc+s3mjQTVjORgGoUF1ii1y8GJ9InYPfEVBDkYyUi6R0dZw6DSnhNPyKu5IuX4qizQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5ISglDRIMOfQ35Titor+fKs4VyJVJqE5duvPDOSQJLIgCJGyv
 /z/9lx/GugdbcsN3otgSjU+a/WJlTxvNRnt2tuVN6x6BPq6ziRox4qPm3RwAYQ==
X-Gm-Gg: ASbGncv5Piq4b0HKnIMa+VNdmKGdFNaZX3v/ETFrEqLFGfWh955Qsjtvdfyep74nQCh
 vHRGrbwneQcfbl5Xl7MLarUNihGhW39V0hTPlO8XBJfGxjGPGDd80zHvdCrXTr8h1oB3i53cngI
 wOZzw1h3xKD5XLqjzfMrF9RdCw3He1acNi4AKJXi74URi9F7sStQX7FdDgW6manD808iKUVp9sx
 h4cu8ho7TrY76UQX8wcTL96rOMwYjwMUcVbbiU7ArqhXmyyxpxdyPqd6VBwCot/Gf6WQo8Gt0YB
 sxwvC6y/7BL7azYKtFAuEnG1HtpI9TsC1iHRA87/H3Xw0js6ggQewgy3wnXkurb+np88RfO961B
 viJlC+x7YAHIleyMZ+HmAYWB1vefc/qotuJMZS0gInQvUjFaKIUKP3Y8K+xkR/7GSGD8wYoObDW
 pGaZpAU3s=
X-Google-Smtp-Source: AGHT+IHoEu0uet1IKhUh6TXqWUlwjn0y6Yiqq2bjTRlC5eB7+x3YwPlKHikkCFWQ7XFKVh1zRPr2Xg==
X-Received: by 2002:a05:600c:a293:b0:456:1122:8342 with SMTP id
 5b1f17b1804b1-4586271252bmr33803905e9.5.1753258220301; 
 Wed, 23 Jul 2025 01:10:20 -0700 (PDT)
Received: from iku.example.org (97e54365.skybroadband.com. [151.229.67.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45869199461sm15064375e9.8.2025.07.23.01.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 01:10:19 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Adam Ford <aford173@gmail.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 "Cogent Embedded, Inc." <source@cogentembedded.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Chris Paterson <chris.paterson2@renesas.com>,
 Prabhakar <prabhakar.csengg@gmail.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3] configs: Remove redundant CONFIG_TEXT_BASE assignments for
 Renesas defconfigs
Date: Wed, 23 Jul 2025 09:10:15 +0100
Message-ID: <20250723081015.278248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.50.1
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The Renesas board defconfigs explicitly set CONFIG_TEXT_BASE=0x50000000,
however U-Boot's POSITION_INDEPENDENT=y build default already places text
at 0x0. These hardcoded overrides are therefore unnecessary and will be
pruned automatically in upcoming resyncs.

Remove the CONFIG_TEXT_BASE lines from the following defconfigs:
  - hihope_rzg2_defconfig
  - r8a77970_eagle_defconfig
  - r8a77970_v3msk_defconfig
  - r8a77990_ebisu_defconfig
  - r8a77995_draak_defconfig
  - r8a779a0_falcon_defconfig
  - renesas_rzg2l_smarc_defconfig
  - rz2_beacon_defconfig
  - silinux_ek874_defconfig

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
v2->v3:
- Also included the r8a779a0_falcon_defconfig which was missed in the previous
  patch.

v1->v2:
- Instead of setting CONFIG_TEXT_BASE=0x0, removed the line entirely
  as it is redundant and will be pruned in future resyncs.
- Updated commit message to clarify the reason for removal.
- Included renesas_rzg2l_smarc_defconfig
---
 configs/hihope_rzg2_defconfig         | 1 -
 configs/r8a77970_eagle_defconfig      | 1 -
 configs/r8a77970_v3msk_defconfig      | 1 -
 configs/r8a77990_ebisu_defconfig      | 1 -
 configs/r8a77995_draak_defconfig      | 1 -
 configs/r8a779a0_falcon_defconfig     | 1 -
 configs/renesas_rzg2l_smarc_defconfig | 1 -
 configs/rzg2_beacon_defconfig         | 1 -
 configs/silinux_ek874_defconfig       | 1 -
 9 files changed, 9 deletions(-)

diff --git a/configs/hihope_rzg2_defconfig b/configs/hihope_rzg2_defconfig
index f5bb28cb0c7..19fb14887c6 100644
--- a/configs/hihope_rzg2_defconfig
+++ b/configs/hihope_rzg2_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN3=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_TEXT_BASE=0x50000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a774a1-hihope-rzg2m-ex"
diff --git a/configs/r8a77970_eagle_defconfig b/configs/r8a77970_eagle_defconfig
index 4ab362f0d43..3734836fa61 100644
--- a/configs/r8a77970_eagle_defconfig
+++ b/configs/r8a77970_eagle_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN3=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x700000
diff --git a/configs/r8a77970_v3msk_defconfig b/configs/r8a77970_v3msk_defconfig
index 5ef81682caa..d3df0fd0baf 100644
--- a/configs/r8a77970_v3msk_defconfig
+++ b/configs/r8a77970_v3msk_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN3=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x700000
diff --git a/configs/r8a77990_ebisu_defconfig b/configs/r8a77990_ebisu_defconfig
index 414bfdebab1..7405f207612 100644
--- a/configs/r8a77990_ebisu_defconfig
+++ b/configs/r8a77990_ebisu_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN3=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
diff --git a/configs/r8a77995_draak_defconfig b/configs/r8a77995_draak_defconfig
index 12d92067de5..2d487722677 100644
--- a/configs/r8a77995_draak_defconfig
+++ b/configs/r8a77995_draak_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN3=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
diff --git a/configs/r8a779a0_falcon_defconfig b/configs/r8a779a0_falcon_defconfig
index f4f5c57451f..1b99ba1f02b 100644
--- a/configs/r8a779a0_falcon_defconfig
+++ b/configs/r8a779a0_falcon_defconfig
@@ -4,7 +4,6 @@ CONFIG_ARM=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN4=y
 CONFIG_COUNTER_FREQUENCY=16666666
-CONFIG_TEXT_BASE=0x50000000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0xC00000
 CONFIG_ENV_SECT_SIZE=0x40000
diff --git a/configs/renesas_rzg2l_smarc_defconfig b/configs/renesas_rzg2l_smarc_defconfig
index e7c0a7e1eae..4730c76248b 100644
--- a/configs/renesas_rzg2l_smarc_defconfig
+++ b/configs/renesas_rzg2l_smarc_defconfig
@@ -3,7 +3,6 @@ CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_SYS_INIT_SP_BSS_OFFSET=1048576
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_RENESAS=y
-CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_SYS_MALLOC_F_LEN=0x80000
 CONFIG_ENV_SIZE=0x20000
diff --git a/configs/rzg2_beacon_defconfig b/configs/rzg2_beacon_defconfig
index 0b91337b17b..d3f7061f04d 100644
--- a/configs/rzg2_beacon_defconfig
+++ b/configs/rzg2_beacon_defconfig
@@ -3,7 +3,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN3=y
-CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFE000
diff --git a/configs/silinux_ek874_defconfig b/configs/silinux_ek874_defconfig
index acdd1ad5205..af462d2086f 100644
--- a/configs/silinux_ek874_defconfig
+++ b/configs/silinux_ek874_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN3=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x3F0000
-- 
2.50.1


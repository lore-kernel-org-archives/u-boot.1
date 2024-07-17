Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31739C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57C4C886DB;
	Wed, 17 Jul 2024 16:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GQftKGQk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CD56886E7; Wed, 17 Jul 2024 16:54:59 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89A2988137
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DF159400B4
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 14:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1721228094;
 bh=eokLYgEhrjy+DhM5vVhVvkAa+bH+gqssvU8V2j4Ffno=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=GQftKGQkwyqhE/A+kgrA3yaKmWWF2oKqcNzWN9dUP71KL3fxbAAyCqOzHvw1wwVzO
 wtPCn1Ba0Ri5uNcMptsrtop3llpV3xkUSXLgInN+5J8FLK7rwgpVAb2pTk4AbV9zk8
 GGYXowDv1Fy9rO4kS50sjCRcmUSxAow5Kjdxlk3UhHgabztiBEMW/8ue3E1YPOSPXK
 yKJiH1GA7uMaKK3Ez87nwIVJukl/KSzX2KSWC3r0N/Af8QXjeVujIZLvG1XSVBRYJF
 hu7UntUb5UxlkwdIvGUcmKYBUU964GZyNphgfY6K4nYtKwlPwTiw0/axzUMe2LxMuP
 EX/wXmpZBhD3Q==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-368255d4bd8so1388248f8f.3
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 07:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721228094; x=1721832894;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eokLYgEhrjy+DhM5vVhVvkAa+bH+gqssvU8V2j4Ffno=;
 b=paqYJ92hV/FUZJloE7+UnAp9tlV0KwOisbUhkPAcBh+Ee68p4dBDWc1KIk6L4cCQD9
 dZHQ+lmRccVyIC0/EJuGyNNkG9mi+JjoVIj/prRiT+FRD2yxITBmTG+/oRcqZoB/IYIM
 PowHDotqkCrQjGPA28O4qCCgTjV5Dg6YzcJQZGiqWOJUOPQ5NyRcenTp9qXIlAvi63sh
 8T9v/dFIaSTObqRoqZ41Vb8GYaNmzANs9ckBjIeEqn4vHz0WMQ5c1aoFgCx508FesdYY
 QjpyfkAdwiG41SpEMd+vbgg15h03Onh0SGdl0ity72ACrVQiHR4GxLlY8ehEfQ1RYFm8
 0pjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW37c1s5ezAvopxnQvV/dvdtlaLDZ7KDuiYsmpfa7i/8fBRf6weaG9TfeIg17ska1Idyxt4wWucW0qQTSpZlQvyjC4aOA==
X-Gm-Message-State: AOJu0Yyc3ZRmcUXdQxmSOombeclgB8DMfGU1CdyHRnhmMWyYFfxLwDy0
 nCOaL7DE41Ddu7d9o2JPlZiKK5LXqZZGOfB7hqCBy6nwC7E48rMV28RtDJWOgxR2a29miFH1HBo
 zVm5/9wCKdJhXuk8mJRe/+HO0qnzLYOIAIy0fQYesI/3jYhxn89QK0J2DkklD4wvgZ7o=
X-Received: by 2002:a5d:5f83:0:b0:367:93b3:4377 with SMTP id
 ffacd0b85a97d-368315fbd9fmr1669487f8f.19.1721228094103; 
 Wed, 17 Jul 2024 07:54:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7C459kBaHeqW9dSO8OS4Yz8rWjPO49IAf+Z+/HAb8DzMWHDRakCJZwd068L7lYHjLyH+m5A==
X-Received: by 2002:a5d:5f83:0:b0:367:93b3:4377 with SMTP id
 ffacd0b85a97d-368315fbd9fmr1669466f8f.19.1721228093745; 
 Wed, 17 Jul 2024 07:54:53 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-093-080.um16.pools.vodafone-ip.de. [62.143.93.80])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3cd1sm11987200f8f.22.2024.07.17.07.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 07:54:53 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Anand Moon <linux.amoon@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] cmd: move CMD_DHCP6 options beneath CMD_DHCP6
Date: Wed, 17 Jul 2024 16:54:46 +0200
Message-ID: <20240717145446.192222-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

All Kconfig options that depend on CONFIG_CMD_DHCP6 should immediately
follow it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/Kconfig | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 0cf0d8ad8ab..323e473cd64 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1810,6 +1810,23 @@ config CMD_DHCP6
 	  Will perform 4-message exchange with DHCPv6 server, requesting
 	  the minimum required options to TFTP boot. Complies with RFC 8415.
 
+if CMD_DHCP6
+
+config DHCP6_PXE_CLIENTARCH
+	hex
+	default 0x16 if ARM64
+	default 0x15 if ARM
+	default 0xFF
+
+config DHCP6_PXE_DHCP_OPTION
+	bool "Request & store 'pxe_configfile' from DHCP6 server"
+
+config DHCP6_ENTERPRISE_ID
+	int "Enterprise ID to send in DHCPv6 Vendor Class Option"
+	default 0
+
+endif
+
 config BOOTP_MAY_FAIL
 	bool "Allow for the BOOTP/DHCP server to not be found"
 	depends on CMD_BOOTP
@@ -1927,23 +1944,6 @@ config BOOTP_VCI_STRING
 	default "U-Boot.arm" if ARM
 	default "U-Boot"
 
-if CMD_DHCP6
-
-config DHCP6_PXE_CLIENTARCH
-	hex
-	default 0x16 if ARM64
-	default 0x15 if ARM
-	default 0xFF
-
-config DHCP6_PXE_DHCP_OPTION
-	bool "Request & store 'pxe_configfile' from DHCP6 server"
-
-config DHCP6_ENTERPRISE_ID
-	int "Enterprise ID to send in DHCPv6 Vendor Class Option"
-	default 0
-
-endif
-
 config CMD_TFTPBOOT
 	bool "tftpboot"
 	default y
-- 
2.45.2


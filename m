Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A770606A32A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Jkg0cDz1;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=aE5m4jVE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 659D940660;
	Wed, 21 Oct 2026 17:04:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oHr30W0QBCPA; Wed, 21 Oct 2026 17:04:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 77442405ED
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792602240;
	b=cqhdB0Neqtkq23YNhfL6fSbiopqcAz9e66gxvNEW9CfIeRrjidY/xHdwh8bhsoppU08f
	 5VmR94+YDNF2k9GPvhvTBnr+WGJ3a1ehf1wePvJFzwqDBWxo3cILYsBSpbQCpE4NO7r6w
	 WGlyIvuIyAypxpXxiBvqbmcUMOHD0iOGPgYYs4/eptvULDW7oxGor3bicTtjBRb9jd1j6
	 O4b/qxOuM/BEulOY9kuSMOdhNIYAMJN4KhhsZUPOXJTfg/HoIBKJdl7Qe5zLYcOyhHijn
	 Wy4Sq4q0CDmdrO6O5asPB8Ns43mRnRWBn+YQn8tqG0YmgYr0vU2Q2cWJhNmVX8BiiIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792602240;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CQxhqrj0cntWE/PrO1cQXa7sYnqBYti83JM1Mc+tJmw=;
	b=TILxbTWcrsszvU3nfCVbXkmiDjS9IFcWNW2OhxTQIMs67VD8irKBgvj9/v5qb+T6ofaX
	 PnvvdYdgTMhM5KGuCdZhM3U+KsWWLKtiUU3PwpCsL+OjLRPUe6eyoQEN3zSbmoSeWSK0X
	 PD0OkpThH4zfVWEoFvxR4XtY1YfqEG09MLN/S5f+Ipu0rUcnjQT7VgiYIQKS8/4TCfzqy
	 uNStwkBuzukAqgkvhnxXmtFWCX1cbzj14oy41dcZkfY2SI50mDg0MXNlJXpvui3Pz8TNG
	 MXk8m0+0mha2mRCDGCcfN9R95ou5mn9ImAb5i1jDg5EtkvvFC9duvFOx+F5MsQ/8qhw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792602240;
	bh=CQxhqrj0cntWE/PrO1cQXa7sYnqBYti83JM1Mc+tJmw=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Jkg0cDz1ynXEqVsk2tutvoeNpoYUMQd0AYCjtSLy7V1ToDnsh8E5b8v+YMQuIgS9t
	 4mkEsRo//nP5X3FAYdpntfu8goPITL24VsymTaxKtMcvfB6OlFbOvgE8xfksQr9PBT
	 u7OLGON116K6FOD/Tjaz2zhfRtrJeVl8CDvDGLZYcf64rW4KQfE2jfeJeTHOj47q76
	 NbxnRSmiIxoZmK1DReKeTGtkYrbYYZ/KkqJ+p9GTxKOQIucqUq+u9nci5RuPT4wzLH
	 d+TVt+iIcYSO9n92rmTPpkxbE6aQIxeVJ59uLb5+qAUUorMpnaFnieU6MgflvgoqmJ
	 m9TG587omi2sQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77442405ED;
	Wed, 21 Oct 2026 17:04:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2997B930
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:03:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0F31F605E7
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:03:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9GiSggLFOYp0 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 17:03:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1FABA605C7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792602238;
 b=lrkD9odUxlgu108sXq5l6DXtb7LboLR5d8nMkn2Grqsh8WiqNIcDVXTjczBU9n+ONIBX
 M7PrKCoZCIg3mALFZS9KKFm3TA3AV23bQ7IjnVLauM/1SABEdk3eIZpTDc37nCpHGbZWO
 C7dNzttlir+bk2s5EALSzrFl0G6agwheiighWyVI/dAkDNJ20S3s4u7ITGtcZqeCYdHs+
 yTEorKNrnfMQSteVfmwkiEh3dLew1WNFFtqu30Joon+Es7kI6w71c5oOzqNYUEQovHZKY
 nZGU74OK45UXab+FUaaxK6CmwVoffWzP4MdTO1GQEpO6er62PiNyccz8SsmLi61AORw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792602238;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=CQxhqrj0cntWE/PrO1cQXa7sYnqBYti83JM1Mc+tJmw=;
 b=SX2DVUOlMdiRKdW7mwIvvCcSULvjDqhG5Moaq9P/EfbG2k55NXPcDb9f0uw2QbOhmEKN
 XUHMzdET1iRTpCEAajiTsJ3I6YN3hIZ2AdnyywFDsxL9qwtW5IJoMBL7neVkXBaxvnWN0
 ieYNSzKodFPNtsOgZKPKF4zPuUieRZV/SsipMxwOfqha1jSY9rl/1GqvWTXM3BcvrQvEQ
 ibyTfSpH6OBnhcILqWQv1izSGGs4U1VFH+istX4schReszpxOa8zZr9mcNmqHPlbfHDUG
 BsSYry3bPpCKQtM8GZYPkrz6Orq+2kyTaCBMax3YVOdbxjU9u5Qge5yOVRYBAUytx5Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=aE5m4jVE; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=aE5m4jVE
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1FABA605C7
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:03:57 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-843ea301d60so673122a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792602236; x=1793207036;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CQxhqrj0cntWE/PrO1cQXa7sYnqBYti83JM1Mc+tJmw=;
 b=aE5m4jVEyz0qIFJ7OfD4CNIn8B+roXBdQ95cByEeuZ5aYBd1feH58wZB8+N56PVb/6
 2tj0ZPove++nc1MN7GdLFalgWgjbC1232d32zQQThssKW7Q7szI5iBYaozkX+dTaoGUT
 Pkrl7Em6xch280hlendQ+Lh+mRX/9AGqVCo1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792602236; x=1793207036;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CQxhqrj0cntWE/PrO1cQXa7sYnqBYti83JM1Mc+tJmw=;
 b=lxEjDJ/rvqpRuMKyh/xNwAExUp6jff+6FVgu8xyBYvbqvgOaBGYRsnwtrVt6Ztf2/R
 J6lvdfsOxpnVYKtkheqv9qOUOXxZZLE7kCrD0kXkG0TTCWzQWscn8zILYVbpOshf2xNO
 sveoXZgzmH5Ps8mTS85tYDMWA0T5HGOt/HPGpq8EVNX+g8kc0eXh6gLrtXF5DW5hq1un
 xL3KTf7Dn04YPSGM/jFjsvvX5Mtz2j/fnWaZQGBXa/bquI2BJbiXzDJh1luR2i2i3gj7
 uJOvuCpvjZVyTefUFL6obs8uvdkE5k6TlNG2ZRj+EIQLKncWOh4z3RWl4fM56dooP/nD
 tE1A==
X-Gm-Message-State: AFq9FYKZ8blaSUDIDR1DAO2Q/wJxzHcRDPQG8ARgVXiMuvv1VPSNOetu
 N20i39gF/bUtXCkvfwYYjWyJVB4hiTCWpI6qMZl3OWBxm+3n2Mt6u/z4xuE2+eCd4mgezhx+7dj
 XQq6RKKhQ65u8
X-Gm-Gg: AYBFou3PJzWsi+4f6NJFsWIOSMJa5gg+9mfx4x1IWxdkeY9NmTbc5TPpKlLOe11+Xud
 HigEw3u6ofAeVPe5jPJSeFk4WQBHzima76fG8AfI1/VqmQI/dVx2vGOxfdYy+CAt8bSHQyktLtB
 BWas8GYjc4TK/BPOEOPIRuWuIU98KCKQAG34PJCDdvpdSvul3WjCrEh+oT6WPUZ9JXpL87121mB
 YTXtE7rYMKGGs5R4bI1jUkYsGnax88OZmD4YNlXo92t7nqFz0yz1fRm4ojo7aQmATjrnIuYqteG
 nK6r6INgY+bywvyuw2bxzHQ6FBAPe+xy9QLh3jddeal9Kb65iC6yMXqqu5AUgnPGHx9fbX9iCRc
 Eob65XrUUxqT3WefqbJJx889ST2kOpz69dLU1eRQX8ewfaQ5ZI3UQ5D1WoDhSfzNZ5eKLXfyJej
 sZ32+L9+AzvjgTOEbSgjc+CYmuJqjEM4UhgfdDfpysecWMYqyZv9LgtB8+CUR3SatYOBW3o5YTy
 kluSm7xBVq3YWwSg1s8LBQjQ8MM6qaekQXx42r2Pp/vWmI1bowN+j6kWBntR+LrLyKGpMZdEKN8
 Nlyg4sWVK3pWhJZ2qJC565Znglk4cHIpKOczGUS3FQr2bS5OGENTc2sdM7/JUlKHJe7POGf9F8I
 xMNeFkuQRUeGZ+VK02kcsRB0q5T36vRkH66evIsZqjnjaOA==
X-Received: by 2002:a05:6830:917:b0:81b:9d18:75a with SMTP id
 46e09a7af769-84d08d01f5amr1940047a34.21.1792602236505; 
 Wed, 21 Oct 2026 10:03:56 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbd2d453bsm2737969a34.17.2026.10.21.10.03.55
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 10:03:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH] arm: ti: k3: Add select TOOLS_MKEFICAPSULE to some platforms
Date: Wed, 21 Oct 2026 11:03:54 -0600
Message-ID: <20261021170354.3260916-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Starting with commit 2f736e8e3f4b ("tools: build mkeficapsule for
CONFIG_EFI_HAVE_CAPSULE_SUPPORT=y") we no longer build mkeficapsule so
often. The TI K3 platforms, on their Cortex-R cores, need to have
mkeficapsule built as they generate capsule updates, but these updates
are managed by the Cortex-A builds. Add select TOOLS_MKEFICAPSULE so
they build again when the host doesn't already have the mkeficapsule
tool installed.

Fixes: 2f736e8e3f4b ("tools: build mkeficapsule for CONFIG_EFI_HAVE_CAPSULE_SUPPORT=y")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-k3/am62ax/Kconfig     | 1 +
 arch/arm/mach-k3/am62px/Kconfig     | 1 +
 arch/arm/mach-k3/am62x/Kconfig      | 2 ++
 arch/arm/mach-k3/am64x/Kconfig      | 2 ++
 arch/arm/mach-k3/j721e/Kconfig      | 1 +
 arch/arm/mach-k3/j784s4/Kconfig     | 1 +
 board/beagle/beagleboneai64/Kconfig | 1 +
 board/beagle/beagleplay/Kconfig     | 1 +
 board/beagle/pocketbeagle2/Kconfig  | 1 +
 9 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-k3/am62ax/Kconfig b/arch/arm/mach-k3/am62ax/Kconfig
index 6a3969343ec1..0c1c7ca2802c 100644
--- a/arch/arm/mach-k3/am62ax/Kconfig
+++ b/arch/arm/mach-k3/am62ax/Kconfig
@@ -48,6 +48,7 @@ config TARGET_PHYCORE_AM62AX_R5
 	select SPL_RAM
 	select K3_DDRSS
 	select BINMAN
+	select TOOLS_MKEFICAPSULE
 	imply SYS_K3_SPL_ATF
 
 config TARGET_AM62D2_A53_EVM
diff --git a/arch/arm/mach-k3/am62px/Kconfig b/arch/arm/mach-k3/am62px/Kconfig
index 0f1fcfab5fc3..628e02b78552 100644
--- a/arch/arm/mach-k3/am62px/Kconfig
+++ b/arch/arm/mach-k3/am62px/Kconfig
@@ -24,6 +24,7 @@ config TARGET_AM62P5_R5_EVM
 	select SPL_RAM
 	select K3_DDRSS
 	select BINMAN
+	select TOOLS_MKEFICAPSULE
 	imply SYS_K3_SPL_ATF
 
 endchoice
diff --git a/arch/arm/mach-k3/am62x/Kconfig b/arch/arm/mach-k3/am62x/Kconfig
index 87470248aa15..0ce30db83bb7 100644
--- a/arch/arm/mach-k3/am62x/Kconfig
+++ b/arch/arm/mach-k3/am62x/Kconfig
@@ -26,6 +26,7 @@ config TARGET_AM625_R5_EVM
 	select SPL_RAM
 	select K3_DDRSS
 	select BINMAN
+	select TOOLS_MKEFICAPSULE
 	imply SYS_K3_SPL_ATF
 	imply TI_I2C_BOARD_DETECT
 
@@ -45,6 +46,7 @@ config TARGET_PHYCORE_AM62X_R5
 	select SPL_RAM
 	select K3_DDRSS
 	select BINMAN
+	select TOOLS_MKEFICAPSULE
 	select PHYTEC_K3_DDR_PATCH
 	imply SYS_K3_SPL_ATF
 
diff --git a/arch/arm/mach-k3/am64x/Kconfig b/arch/arm/mach-k3/am64x/Kconfig
index e8b7d54d7ac3..fe3f1b7c6ba8 100644
--- a/arch/arm/mach-k3/am64x/Kconfig
+++ b/arch/arm/mach-k3/am64x/Kconfig
@@ -26,6 +26,7 @@ config TARGET_AM642_R5_EVM
 	select SPL_RAM
 	select K3_DDRSS
 	select BINMAN
+	select TOOLS_MKEFICAPSULE
 	imply SYS_K3_SPL_ATF
 	imply TI_I2C_BOARD_DETECT
 
@@ -46,6 +47,7 @@ config TARGET_PHYCORE_AM64X_R5
 	select SPL_RAM
 	select K3_DDRSS
 	select BINMAN
+	select TOOLS_MKEFICAPSULE
 	imply SYS_K3_SPL_ATF
 
 endchoice
diff --git a/arch/arm/mach-k3/j721e/Kconfig b/arch/arm/mach-k3/j721e/Kconfig
index 4d01f2c8af2e..f8c97ccf45bb 100644
--- a/arch/arm/mach-k3/j721e/Kconfig
+++ b/arch/arm/mach-k3/j721e/Kconfig
@@ -26,6 +26,7 @@ config TARGET_J721E_R5_EVM
 	select SPL_RAM
 	select K3_DDRSS
 	select BINMAN
+	select TOOLS_MKEFICAPSULE
 	imply SYS_K3_SPL_ATF
 	imply TI_I2C_BOARD_DETECT
 
diff --git a/arch/arm/mach-k3/j784s4/Kconfig b/arch/arm/mach-k3/j784s4/Kconfig
index f5447b0b836f..7a7430f67a10 100644
--- a/arch/arm/mach-k3/j784s4/Kconfig
+++ b/arch/arm/mach-k3/j784s4/Kconfig
@@ -43,6 +43,7 @@ config TARGET_J784S4_R5_EVM
 	select SPL_RAM
 	select K3_DDRSS
 	select BINMAN
+	select TOOLS_MKEFICAPSULE
 	imply SYS_K3_SPL_ATF
 
 config TARGET_J742S2_A72_EVM
diff --git a/board/beagle/beagleboneai64/Kconfig b/board/beagle/beagleboneai64/Kconfig
index 7d7077e9f28e..735dfb5f1f39 100644
--- a/board/beagle/beagleboneai64/Kconfig
+++ b/board/beagle/beagleboneai64/Kconfig
@@ -24,6 +24,7 @@ config TARGET_J721E_R5_BEAGLEBONEAI64
 	select SPL_RAM
 	select K3_DDRSS
 	select BINMAN
+	select TOOLS_MKEFICAPSULE
 	imply SYS_K3_SPL_ATF
 
 endchoice
diff --git a/board/beagle/beagleplay/Kconfig b/board/beagle/beagleplay/Kconfig
index fcc6a5aa4960..d545d2297abc 100644
--- a/board/beagle/beagleplay/Kconfig
+++ b/board/beagle/beagleplay/Kconfig
@@ -23,6 +23,7 @@ config TARGET_AM625_R5_BEAGLEPLAY
 	select SPL_RAM
 	select K3_DDRSS
 	select BINMAN
+	select TOOLS_MKEFICAPSULE
 	imply SYS_K3_SPL_ATF
 
 endchoice
diff --git a/board/beagle/pocketbeagle2/Kconfig b/board/beagle/pocketbeagle2/Kconfig
index e957b8e8377e..b696f69c8230 100644
--- a/board/beagle/pocketbeagle2/Kconfig
+++ b/board/beagle/pocketbeagle2/Kconfig
@@ -22,6 +22,7 @@ config TARGET_AM62X_R5_POCKETBEAGLE2
 	select SPL_RAM
 	select K3_DDRSS
 	select BINMAN
+	select TOOLS_MKEFICAPSULE
 	imply SYS_K3_SPL_ATF
 
 endchoice
-- 
2.43.0


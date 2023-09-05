Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0EEC83F33
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 01:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B6C586541;
	Tue,  5 Sep 2023 03:12:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DvzuaUPN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3784086541; Tue,  5 Sep 2023 03:12:47 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8931C8652B
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 03:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-59234aaca15so19539287b3.3
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 18:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693876362; x=1694481162; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JSjeX9ezypdYl2xZEwu+tJOiM8swCLJihR386Q4AZLU=;
 b=DvzuaUPNvWJ412J0DKkNbyC41+zveMG6nAeWGtD12z6u30elAunzjvuezkboOACL18
 Z0DboA/wrcN6pYDEN3bAbYzTXC+bbShaeEw3zTst/o+LX0ICDTkjDBy7BwlS3oVqlw/O
 5lYJ+jZEz+U1FtRtpbdqOIn0R78uPG4I1h3P8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693876362; x=1694481162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JSjeX9ezypdYl2xZEwu+tJOiM8swCLJihR386Q4AZLU=;
 b=FlFsOdemiitdcMQz4UaA+QmgQq9gxEHKPAwmyx4t18EaBVaHxjYYNCsapOXVa+E/5y
 /OPZJ+r9TV5Y86a3I7pg2/SAcmNv/pp2UmtjFK2Adjn2NOfQgAtR8D8sa3YBjc6pTbVe
 OzG5WdfF4lI94MSupHDKoBPBos0YiNFWn4bFhzPkEOvdN942HyZX7CTG0Jvi7WqF//RA
 tN+fZuyJw370y/RarAqnQlU4Jz+FjpdRO+B0lCDarOTulQEtp0h5RDxbmau9ngIsnHnT
 ScEZhS5fHtwm53HTbl/ZOIH6bc2okSoDSBZFmRcYFwj6zurVQPyFhyR7dI81cnf7lC0/
 nhGQ==
X-Gm-Message-State: AOJu0Yyn/EYdmnvWB9jKOM3L1I8XChlN7jcnRqjzTZzcKpxY/skixjVK
 fP2AJpy7yMbk6Jj4+8kRuiezTG3pG3/51UGGHR3+vw==
X-Google-Smtp-Source: AGHT+IHelVJto7BzwEWsMewLHyOpUkmUPxWUif8VyCws7GBn+AFzk/sp3T9rOjyBWsjHiJ7F2kh8Zg==
X-Received: by 2002:a81:94c7:0:b0:589:ad30:5f5 with SMTP id
 l190-20020a8194c7000000b00589ad3005f5mr9502234ywg.52.1693876362085; 
 Mon, 04 Sep 2023 18:12:42 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-51ef-a95e-1d1c-c7f8.res6.spectrum.com.
 [2603:6081:7b00:6400:51ef:a95e:1d1c:c7f8])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a0df101000000b0057a67df3308sm2868829ywf.101.2023.09.04.18.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 18:12:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH 1/2] =?UTF-8?q?MAINTAINERS:=20Drop=20Pali=20Roh=C3=A1r?=
Date: Mon,  4 Sep 2023 21:12:27 -0400
Message-Id: <20230905011228.4006020-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905011228.4006020-1-trini@konsulko.com>
References: <20230905011228.4006020-1-trini@konsulko.com>
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

Remove Pali from his listed maintainer entries due to his publicly
visible actions on the mailing list.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 MAINTAINERS                           | 1 -
 board/CZ.NIC/turris_mox/MAINTAINERS   | 1 -
 board/CZ.NIC/turris_omnia/MAINTAINERS | 1 -
 board/nokia/rx51/MAINTAINERS          | 3 +--
 4 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 536df4a8962e..aecda1f36972 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -366,7 +366,6 @@ F:	drivers/watchdog/orion_wdt.c
 F:	include/configs/mv-common.h
 
 ARM MARVELL PCIE CONTROLLER DRIVERS
-M:	Pali Rohár <pali@kernel.org>
 M:	Stefan Roese <sr@denx.de>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-marvell.git
diff --git a/board/CZ.NIC/turris_mox/MAINTAINERS b/board/CZ.NIC/turris_mox/MAINTAINERS
index b29ce92ccd77..5f0551e2e1dc 100644
--- a/board/CZ.NIC/turris_mox/MAINTAINERS
+++ b/board/CZ.NIC/turris_mox/MAINTAINERS
@@ -1,6 +1,5 @@
 TURRIS MOX BOARD
 M:	Marek Behún <kabel@kernel.org>
-M:	Pali Rohár <pali@kernel.org>
 S:	Maintained
 F:	arch/arm/dts/armada-3720-turris-mox*.dts*
 F:	board/CZ.NIC/turris_mox/
diff --git a/board/CZ.NIC/turris_omnia/MAINTAINERS b/board/CZ.NIC/turris_omnia/MAINTAINERS
index 8bff97cc2737..effce8a753b4 100644
--- a/board/CZ.NIC/turris_omnia/MAINTAINERS
+++ b/board/CZ.NIC/turris_omnia/MAINTAINERS
@@ -1,6 +1,5 @@
 TURRIS OMNIA BOARD
 M:	Marek Behún <kabel@kernel.org>
-M:	Pali Rohár <pali@kernel.org>
 S:	Maintained
 F:	arch/arm/dts/armada-385-turris-omnia*.dts*
 F:	board/CZ.NIC/turris_atsha_otp.*
diff --git a/board/nokia/rx51/MAINTAINERS b/board/nokia/rx51/MAINTAINERS
index 25f8b3c5a9ad..d2718ebd417c 100644
--- a/board/nokia/rx51/MAINTAINERS
+++ b/board/nokia/rx51/MAINTAINERS
@@ -1,6 +1,5 @@
 RX51 BOARD
-M:	Pali Rohár <pali@kernel.org>
-S:	Maintained
+S:	Orphaned
 F:	board/nokia/rx51/
 F:	include/configs/nokia_rx51.h
 F:	configs/nokia_rx51_defconfig
-- 
2.34.1


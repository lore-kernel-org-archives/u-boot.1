Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE090CCF2C1
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 13:24:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B938F611B8;
	Fri, 16 Oct 2026 13:24:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BKpr9uh-ApQS; Fri, 16 Oct 2026 13:24:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 19844611AB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792157054;
	b=AihO2InW5ixD65yprN80cqkkS5TuQFmTUfRQxe9c6VAMnEbV4pRSo9H/+dQ9LFd4v1dd
	 iIBmef1g75EgW2GM4xZCPj9S/nQ9LyxZm/cNlmdgNHUytnFpIBk/FNtIeT2udfAq9jkb9
	 5viqkl/Q40FPVa1s3H9i+LG/UsJnJJvu+1h+ZxHKxpFgkKGvHUZIT2wd9Z58cGzu0N2yb
	 ANMg9Y3RI73LoIF0IufWg3cgx4BLNdzA3C3N13RF4oowa7UTJJjFpXbVCUl2ykokMnYOb
	 VbvrMcaRQkiW/WXFJpO2h7ZszARiEKJ7hcRR+pZh31k14EdSP96hNhTiyV5wTKz8Qpw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792157054;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:X-B4-Tracking:X-Change-ID:To:CC:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9JWhEaF+I01k0vYtzWvd9+P2wN2Dtv/JAnWQ5viVlvI=;
	b=c1SqGexD1BWl53fsN3aBddYUC8WtNlblDfZlQAXuxwaRG1YnVPr8hu6OaX73TyMhx08D
	 Uzrn2K6QbbzB8LLaQZ0NDapvpohbNwImtXMaED3pbpAkKFGvDNp+2RGJUvOIzqYMQaDln
	 3QkGhPygo3A7EMSqXD3l86H0N85lqjRw6RNKqLMJPyhqIl/0mXtWSaCjXpCwo6Py2q7TZ
	 bLziCoUsQMVNPfoWe0tMo6Ry3m4ZTdDwg3p6ws4TebHdOTEkBKxVKIkUp6MW5oSjYVkbp
	 WeDpjN9OgtZk/6baD9/r3rPFMD4UmGkh+JKUVLO//CD+cpH/Mx6u10v4XSMnmmVnUfg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792157054;
	bh=9JWhEaF+I01k0vYtzWvd9+P2wN2Dtv/JAnWQ5viVlvI=;
	h=From:Date:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hKTCXXl5UaYQ8qIozfXfuAu+ZjZ+ZMswQ1mOx+0a4U/Ju0ru4CdjiBL+0AG1KRcuR
	 ZoF5GX2eN1Bo9DGIxONDXbjBFOOf1qHWs4EHOquGcurjI5Qc5rD/B9tKphPotZgYyb
	 sYgAcuGEQVT4EMZaA5S+QxrksRKuxhqlx6J1O5Tiu8xTgZpvnYeP/bixo2nM0UXnvF
	 b1boOIQnyFpSsW75CoGxvB0OZ7oM66mBjcu6Lslu8hr+w7P98sxHbBUlkX1k525UYW
	 PQQdX/YbcFh2g3Fm4BoaxQIsf2m3IuUSWfS+p4DIXMhdTKUAfKOxl4NN9wTdS2ykKs
	 mGAqCcbIoFjrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19844611AB;
	Fri, 16 Oct 2026 13:24:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F0DDF362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E2E364046E
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:15:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F1Mmbv5s-3wW for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 09:15:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5B5FB40100
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792142150;
 b=IbV7RRBwUWKGaZgXuv0DuM82MlK4pXav5b1QXEGpw9Xp6m48rvCglHF1EHHQa3qz7aWt
 qtSsRWthVoavR6ppUzZxwDG4QWBq+ZTH2p8yNg7qht8qzTeqiwHZYZnm+6uH8BkYhZu3a
 zzWNL4cyu+Ic2rY6akMAAaYnjwXcvBGiqj9Wg7c2+kwbRCLQJptD015CLEtAyLjfhy9mw
 F6r9njs579Aw+ei+9/NLE9lUYr7rr2cWofZDLMli5vwDnSbqINf20N/Rc3DtPiIgGXU3c
 8FHv+LUyG7AiH3g1GCEKsiEDRFFqpvLkZ8XlY053olshXYOol7fw1YrFvbYZvvjhJFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792142150;
 h=X-Greylist:Received-SPF:Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
 bh=9JWhEaF+I01k0vYtzWvd9+P2wN2Dtv/JAnWQ5viVlvI=;
 b=e0u4EHEeI2ZvlOFIJJb3pBGmu6ej9mf1Qt3wshjpC1uIOtju6j0wmtRRXVGArREQj/jF
 uIftbUPJIrYgPXbpmKstJkx4XT24vUK7djgCxESkykJf18TqwSAelk7T0/pGBNEwi7kzD
 QfZiSpO/QMmPIRXiamqzIooWVVrI/aLY0Rgqch5I5WYwk6XCiydyqmGCx2f/GABkO8TI7
 gySWv4XiZ0bUr3ILhfIwn8Tg8UqmPVUBB2OrcoaKkWnGu9ZS0ARZmW0s/cm8/bW2H7rcm
 Trd13U5FmdFPbpr2IbNAu39iPYFXqUc4vqYzITv7ciDyHcp/yMm4FKl3Qh+Qg5o3X6Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=aspeedtech.com;
 arc=none smtp.remote-ip=211.20.114.72
X-Greylist: delayed 304 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 16 Oct 2026 09:15:50 UTC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=211.20.114.72;
 helo=twmbx01.aspeedtech.com; envelope-from=cooper_huang@aspeedtech.com;
 receiver=<UNKNOWN> 
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5B5FB40100
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:15:49 +0000 (UTC)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 16 Oct
 2026 17:10:43 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 16 Oct 2026 17:10:43 +0800
From: Cooper Huang <cooper_huang@aspeedtech.com>
Date: Fri, 16 Oct 2026 17:10:25 +0800
Subject: [PATCH] configs: evb_ast2700: set default SPI FIT address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261016-ast2700-fdtspiaddr-v1-1-2b376be8a6ef@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAADq0WoC/x3MwQrCMAyA4VcZORtIC3bqq4iHtM1cDtaRjCGMv
 bvV43f4/x1cTMXhNuxgsqnru3WE0wBl5vYU1NoNkWIKFBKyr3EkwqmuvijXaliohHAZr/GcE/R
 wMZn085/eH92ZXTAbtzL/Vi/WBsfxBXNDZOJ7AAAA
X-Change-ID: 20261016-ast2700-fdtspiaddr-c0c1187925b6
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, <u-boot@lists.u-boot-project.org>
CC: Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Tom Rini
 <trini@konsulko.com>, Cooper Huang <cooper_huang@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:23:56 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The AST2700 EVB bootspi command reads the FIT image from ${fdtspiaddr},
but the default environment does not define fdtspiaddr. Set it to the
SPI-mapped FIT image address used by the OpenBMC image layout: flash
offset 0x420000, right after the environment, in the FMC AHB window at
0x100000000.

Fixes: b62b55ba4b2d ("arm: aspeed: add ASPEED AST2700 SoC family support")
Signed-off-by: Cooper Huang <cooper_huang@aspeedtech.com>
---
 include/configs/evb_ast2700.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/configs/evb_ast2700.h b/include/configs/evb_ast2700.h
index 6b73eddc1af..bf5cda94fe4 100644
--- a/include/configs/evb_ast2700.h
+++ b/include/configs/evb_ast2700.h
@@ -21,6 +21,7 @@
 		"bootm ${loadaddr}; "					\
 		"echo Error loading kernel FIT image\0"			\
 	"loadaddr=" STR(CONFIG_SYS_LOAD_ADDR) "\0"			\
+	"fdtspiaddr=0x100420000\0"					\
 	"bootside=a\0"							\
 	"rootfs=rofs-a\0"						\
 	"setmmcargs=setenv bootargs ${bootargs} "			\

---
base-commit: 65a7532545336e4b73e049a69436e255da7df961
change-id: 20261016-ast2700-fdtspiaddr-c0c1187925b6

Best regards,
-- 
Cooper Huang <cooper_huang@aspeedtech.com>


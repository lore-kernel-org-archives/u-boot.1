Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A3AC3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 14:19:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05B6888967;
	Wed, 14 Aug 2024 16:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0093888981; Tue, 13 Aug 2024 17:53:18 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DAB2588842
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 17:53:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hugues.kambampiana@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22C9512FC;
 Tue, 13 Aug 2024 08:53:41 -0700 (PDT)
Received: from e129527.arm.com (unknown [10.57.16.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BDA33F6A8;
 Tue, 13 Aug 2024 08:53:14 -0700 (PDT)
From: Hugues KAMBA MPIANA <hugues.kambampiana@arm.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, abdellatif.elkhlifi@arm.com, hugues.kambampiana@arm.com
Subject: [PATCH] maintainers: Update list of maintainers for Corstone-1000
Date: Tue, 13 Aug 2024 16:53:05 +0100
Message-Id: <20240813155305.446779-1-hugues.kambampiana@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Aug 2024 16:19:31 +0200
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

From: Hugues Kamba Mpiana <hugues.kambampiana@arm.com>

- Add new maintainer: Hugues KAMBA MPIANA
- Remove maintainer: Xueliang ZHONG
- Update contact information for current maintainer.

Signed-off-by: Hugues KAMBA MPIANA <hugues.kambampiana@arm.com>
---
 board/armltd/corstone1000/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/armltd/corstone1000/MAINTAINERS b/board/armltd/corstone1000/MAINTAINERS
index 1cc9aaa29a8..ede4b007540 100644
--- a/board/armltd/corstone1000/MAINTAINERS
+++ b/board/armltd/corstone1000/MAINTAINERS
@@ -1,6 +1,6 @@
 CORSTONE1000 BOARD
 M:	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
-M:	Xueliang Zhong <xueliang.zhong@arm.com>
+M:	Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
 S:	Maintained
 F:	board/armltd/corstone1000/
 F:	include/configs/corstone1000.h

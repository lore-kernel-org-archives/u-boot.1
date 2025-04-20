Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E6EC369C2
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 11:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 678028205A;
	Sun, 20 Apr 2025 13:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="C9H4b6xs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DD628205B; Sun, 20 Apr 2025 13:58:15 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41ABE82054
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 13:58:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=kettenis@openbsd.org
X-KPN-MessageId: fd170a37-1dde-11f0-beb8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id fd170a37-1dde-11f0-beb8-005056992ed3;
 Sun, 20 Apr 2025 14:00:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kpnmail.nl; s=kpnmail01;
 h=mime-version:message-id:date:subject:to:from;
 bh=g1nxkIz+IKXNkAxavbL1g3Eke2buKyzLxgydNzVCBJU=;
 b=C9H4b6xsfLwxJNsxnDa0WnUXfGnG6N39KjHTNFmWguPmSPb22vyea+2LMEP0i0qz6FAB76kQWnrxu
 JdS6T2/giVFNIxmNzd1SEGwP3OCCsS5uAzs2+bNo/0KZ0aSueaOXIsdIMqZxx5bYm0HZVF4az6t0G+
 Bm7BvtPRrCWf8GJ8=
X-KPN-MID: 33|XHq2qnMKLrvnftZ0pBW4FLDFycy2+lEWpyq3xzExmNFe4isRCajGOi59qE+DM4F
 3yeoAeQN4UWz6tcJ6bU2nzZYnLqe2XOka5fI/TozhOOo=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|+0LVNW/O3BYW0JF+oH6+wtIkjtClkLxYRoIBCxPZ6Vvx0oV7sz23a+1I4bgNazE
 QuW8ITsT7bfj8uNsKYLIsDQ==
X-Originating-IP: 80.61.163.207
Received: from bizet.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id bb1ee4f9-1dde-11f0-97e2-00505699d6e5;
 Sun, 20 Apr 2025 13:58:11 +0200 (CEST)
From: Mark Kettenis <kettenis@openbsd.org>
To: u-boot@lists.denx.de
Cc: kettenis@openbsd.org,
	trini@konsulko.com,
	marcan@marcan.st
Subject: [PATCH 0/6] Apple RTKit improvements
Date: Sun, 20 Apr 2025 13:58:02 +0200
Message-ID: <20250420115808.94272-1-kettenis@openbsd.org>
X-Mailer: git-send-email 2.49.0
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

This is a collection of improvements for the Apple RTKit code
that we have been carrying downstream for some time now.

Hector Martin (6):
  arm: apple: rtkit: Add support for AP power & syslogs
  arm: apple: rtkit: Add default buffer handlers
  arm: apple: rtkit: Add a generic RTKit helper driver
  arm: apple: rtkit: Add OSLog buffer support
  arm: apple: rtkit: Add endpoint field to buffers
  arm: apple: rtkit: Support allocating OSLog out of SRAM in helper

 arch/arm/include/asm/arch-apple/rtkit.h |   5 +
 arch/arm/mach-apple/Makefile            |   1 +
 arch/arm/mach-apple/rtkit.c             | 234 ++++++++++++++++++------
 arch/arm/mach-apple/rtkit_helper.c      | 145 +++++++++++++++
 4 files changed, 333 insertions(+), 52 deletions(-)
 create mode 100644 arch/arm/mach-apple/rtkit_helper.c

-- 
2.49.0


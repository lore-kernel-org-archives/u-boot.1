Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9ABEE7719F
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 12:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C502805DA;
	Mon, 13 Jan 2025 13:25:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736771126;
	bh=irXWp4SfXxGB5BlhcR8DBgHOvLySiYitrzMQ/X3kbTI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SzFfC6tWs5rGSjeD11oTFKaFLVyoiV/rTPQgwWyb4KtMab1Sp0fzBDnaNe7XVnl7K
	 3U714yjIAJSBCk+ekRHSk1ZyxcV9M8s1HnEt2ujsxmy83UkAyKbApmWQ5Gt8z4FOPF
	 TZLMZPa438MUGJpipxZ2c5xU80I+WqKMfBIbA2pnBuwFvB4EiOBkFd0vpeULkf5Jx1
	 5jtHWfQW+xPwSqZT/qyUTfxYtY50v4V+jyBzNQBmhq7QDwtwavcimC37FD7FDDa8mf
	 cRWBWrJtnl/GlsgrQ6u3hCJIiG9fNQnuoXO5Ay2MUZCDem083V2FiEmSIh/TFPU1xy
	 l7VZ5Za8G84xw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A56D805E7; Mon, 13 Jan 2025 13:25:24 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0719801CF
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 13:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="cmYc2WiN"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 44B5010408F8C; Mon, 13 Jan 2025 13:25:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736771120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=irXWp4SfXxGB5BlhcR8DBgHOvLySiYitrzMQ/X3kbTI=;
 b=cmYc2WiNDN66zPCgLLfCjOJC1xN+Q7GC2lNjBAlN8PymCdnqb3P3HC7gXpwVwqmu0nj+BZ
 8YAK7s4id2q0kTe09pq/2JDrOEW2/WtvqlXGDslDRHmaVBb8YtUQpNWh4XHaRM9MFPBJiq
 P6CFkrMZGRDx7rDX/MRPvE4ri47ASaIMawy2WBOZKRQkwgYCDJcVu0PNyNIaQYzXuEr7Vm
 ZvHFn6BbG+O+7P1eUm72fpknkrYelQaCigl4tzwfyl+oiJfR9xnCSJDkTzPeyZSyjFgc/C
 VFFO3ynY3NHOZa9CfcZx9R7TYAsA+AufDBb4zYnFgAOVtRhySCmNRW1Quv7fWg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>
Subject: [PULL] u-boot-usb/master
Date: Mon, 13 Jan 2025 13:24:50 +0100
Message-ID: <20250113122503.5890-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The following changes since commit e13e0a921f444cc12127c8a497dcc476f1268939:

  Merge tag 'efi-next-20250105' of https://source.denx.de/u-boot/custodians/u-boot-efi (2025-01-08 18:05:51 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 801b5fafd35db53f229bde5e2eb7d290e5d172e7:

  usb: ehci-mx6: Add i.MX95 support (2025-01-13 04:39:05 +0100)

----------------------------------------------------------------
Marek Vasut (3):
      usb: ehci-mx5: Use regulator_set_enable_if_allowed
      usb: ehci-mx6: Use regulator_set_enable_if_allowed
      usb: ehci-mx6: Add i.MX95 support

 drivers/usb/host/Kconfig    | 10 +++++-----
 drivers/usb/host/ehci-mx5.c |  6 +++---
 drivers/usb/host/ehci-mx6.c |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

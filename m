Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8C8CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9B8A86A0A;
	Sun, 17 Sep 2023 16:09:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="J+QkJZ/4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XiKvQfUv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E518486A0A; Sun, 17 Sep 2023 16:09:53 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C37C869A4
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RpVDb6gyZz9sWS
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RXQufOQVmB5UiEDXI8hA5p0S1M3PJOLhdB2igqxCOGk=;
 b=J+QkJZ/4zzO6HpVIfFS50n5tJ0vvf0q1ztfi3gjo3jRjVXFcToHe8ayRji7UFFhZHd3tyt
 ov4zQwfFmo5XGDRtQY/oCUvc4DM7WpNGNYk+HFVElbTdCmYOj1O9XVtfJnEiKiJ1SKDFHh
 QebYMZmltKeEgewJ1QUUtqqPBZAX1YnYAdPd0rDrtiFcaNzYYgDPEw4nRdTDn5+1her5/r
 CKE0mqkHLd1fyOtouIaTL0JEHI8xeB2fn3VWEnO/UHuRAL2GIGCa4sygllhM+qIxHt8w8Z
 NaV6GwjIraxXab1j3V+vOPWrS3FWDNVGyNkVM18HXgUiOYXFpJGgp+taGA5rbg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RXQufOQVmB5UiEDXI8hA5p0S1M3PJOLhdB2igqxCOGk=;
 b=XiKvQfUvsJgTMgiy/KPEJKmlpIIMZrulV1vO/fB+tKFggT8orbP0yjXtlzFCw9DRonq7WY
 zUpEuPDwBE0lAlYqa+g4O0w9jMIdhBs1hK/Pe2wsbcvOyJMHsmbfDPi6FyIzM1p9ZNLrWl
 uKMYvDlQoJ6wdZcZL4uwYzmhPfX+viOMV04GH9mBbgQdC8rEJJe4rmeEqcE3XXRhFoU/K9
 34BwhIEx3Rjf0+I0OXFLBtZRjTAtZC9cVOJiSGTkmGZuOi7xgka7Bytbs+h8AazPeO8eFR
 IgdeSt/i5myiZLznzRLVss8+YCDK4PjcH6rvZQ95QU+AdcbfYdF+M1ZnMM3nFw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH] linux/compat.h: Define empty __initconst and __initdata
Date: Sun, 17 Sep 2023 16:09:39 +0200
Message-Id: <20230917140939.379762-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: uqtuxzxgmb4ftw34sjwyq8bpfjysexnt
X-MBO-RS-ID: 09fb181e3661b095e0e
X-Rspamd-Queue-Id: 4RpVDb6gyZz9sWS
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

Introduce two new empty macros used in various static tables in Linux.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 include/linux/compat.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 921e698f407..f8e3570d1ad 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -271,6 +271,8 @@ typedef int	wait_queue_head_t;
 #define __devinit
 #define __devinitdata
 #define __devinitconst
+#define __initconst
+#define __initdata
 
 #define kthread_create(...)	__builtin_return_address(0)
 #define kthread_stop(...)	do { } while (0)
-- 
2.40.1


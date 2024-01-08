Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F41DC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 21:11:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE55C87A36;
	Mon,  8 Jan 2024 22:11:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="GsYkbzAr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ScvI++5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B26A87A4B; Mon,  8 Jan 2024 22:11:07 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31E9D877AF
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 22:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tdmg@linutronix.de
From: Tobias Deiminger <tdmg@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1704748264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DiJkZUCfF+BZl4T8QUcDu6DfGWsH/Z4MBZTFdyAUiL8=;
 b=GsYkbzArRZs19RkXQgOmcPyBy8N/sE/vRWp7IbLzaAnplSvNRHhxBWBpKRtzEyNYWszrzI
 bQxnZaoStDbhctQ/bkhEr1oa3IeHhOpTCDFP9AkvsSue1MtImoEVvf4cX+ZcM+dlOhN952
 a3wlS+6OE6zuPkHykyLuvyssrTCbN+z5VkpZj4rNeYtS6oyi0z+aN9eOSBAZwFD82miCZ7
 OX5hoaUnsQdOMFPKE9VjfIfoXaUl95mTtV2hSoAf2QevCE1dMNXwq0AFgljKm/C9Df8N0R
 YtkGKkeInr+PUsZObo8f98n3GtnondKs6p5cs51bICCw/rrCksGbrZGM5k4PzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1704748264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DiJkZUCfF+BZl4T8QUcDu6DfGWsH/Z4MBZTFdyAUiL8=;
 b=ScvI++5D7JBjAnXq+NdrRNQLDxFhcjrWo+Keal8ikYUAshRZnZ8tZP8i7lFrFKd+Eivpw3
 FyyvNKtGxF0PLWCw==
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Harald Seiler <hws@denx.de>,
 tdmg@linutronix.de (Tobias Deiminger)
Subject: [PATCH 0/1] Skip cleanup test if not built out of tree
Date: Mon,  8 Jan 2024 22:10:59 +0100
Message-Id: <20240108211100.112730-1-tdmg@linutronix.de>
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

This patch avoids false positives in cases where tests are invoked with
test.py --build-dir=./ . 

See tbot issue 107 [1] for motivation and prior discussion.

Previously it resulted in:    
E   AssertionError: leftovers: net/mdio-uclass.c, net/bootp.c, [...]

Now it results in:
SKIPPED [2] test/py/tests/test_cleanup_build.py:23: Leftover detection
requires out of tree build.

[1] https://github.com/Rahix/tbot/issues/107#issuecomment-1880192186

Tobias Deiminger (1):
  test: Skip cleanup test if not built out of tree

 test/py/tests/test_cleanup_build.py | 5 +++++
 1 file changed, 5 insertions(+)


base-commit: 93d91e9485d902a1836a22e72d1a545b587adf36
-- 
2.30.2


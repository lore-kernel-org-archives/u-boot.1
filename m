Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31BCEA7941
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 18:40:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 334928341A;
	Wed,  4 Feb 2026 19:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="fXuXLI+x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9287D83A64; Wed,  4 Feb 2026 19:40:55 +0100 (CET)
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CDF883015
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 19:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=linux@fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
 by mxout3.routing.net (Postfix) with ESMTP id 144A0604A7;
 Wed,  4 Feb 2026 18:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=routing; t=1770230453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jt0XuvuCZkFd8W5eE3TFQki2z1RPcn11MhPX9C3HcYs=;
 b=fXuXLI+xw4y/uHlplnnmqEjxiGJM+N7cqO7g9DvcL0x3T8wdMUUlyp79WW6ROhFa+Q1JSM
 HtTr0p9q1UxNYoswFaqhoNC14tLkl2ohrVpR8/3y8reQZY07VglJ9Lr/jnQ2XbTs5vAB/0
 zi4ZbWHhUaqAg7pATm16cFm0nCJzXXA=
Received: from frank-u24.. (fttx-pool-80.245.74.171.bambit.de [80.245.74.171])
 by mxbulk.masterlogin.de (Postfix) with ESMTPSA id E9AD31226B6;
 Wed,  4 Feb 2026 18:40:52 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Tom Rini <trini@konsulko.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 0/3] Add command for getting ramsize in scripts
Date: Wed,  4 Feb 2026 19:40:41 +0100
Message-ID: <20260204184045.111808-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
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

From: Frank Wunderlich <frank-w@public-files.de>

Add command for getting ramsize in scripts

v7:
- add guard for test to not fail for x86_64 qemu board
- extend doc and config help text
v6:
- add missing return for error in env_set_long
v5:
- move msize to meminfo and drop first param (always display as MiB)
- rename msize to memsize
- add doc and test so it becomes a series

Frank Wunderlich (3):
  cmd: mem: add command for getting ram size for use in scripts
  test: cmd: add test for memsize
  doc: cmd: add usage doc for memsize

 cmd/Kconfig               |  8 ++++++++
 cmd/meminfo.c             | 25 +++++++++++++++++++++++
 doc/usage/cmd/memsize.rst | 43 +++++++++++++++++++++++++++++++++++++++
 test/cmd/meminfo.c        | 20 ++++++++++++++++++
 4 files changed, 96 insertions(+)
 create mode 100644 doc/usage/cmd/memsize.rst

-- 
2.43.0


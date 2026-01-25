Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEC6E63CA5
	for <u-boot@archiver.kernel.org>; Sun, 25 Jan 2026 13:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21C9283C4B;
	Sun, 25 Jan 2026 14:13:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="ZuIYvxDs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB84D83C67; Sun, 25 Jan 2026 14:13:01 +0100 (CET)
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9AA783A36
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 14:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=linux@fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
 by mxout2.routing.net (Postfix) with ESMTP id 2EA5F5FD8C;
 Sun, 25 Jan 2026 13:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=routing; t=1769346779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Gl4A5LNlz7HG1snybatKYfEkdgU6WpWORjeZrnZAWvc=;
 b=ZuIYvxDstu2AenwMdXTXMav12jybADsIx8SflvcUNiUELBE0nBXz6Md7bO5I1VMRzzsPM9
 dOuIXKXqpCT8EkdQIxNnCs3F2aErvKjhYcC9J3iOL71BPsPFiT+mAZU41CYIwxiQPhdazf
 7mIY6vVx6QxjTOSv7+CnaX9Fx0mPeSc=
Received: from frank-u24.. (fttx-pool-194.15.85.69.bambit.de [194.15.85.69])
 by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 0A3471226CC;
 Sun, 25 Jan 2026 13:12:59 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Tom Rini <trini@konsulko.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de,
 Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v6 0/3] Add command for getting ramsize in scripts
Date: Sun, 25 Jan 2026 14:12:50 +0100
Message-ID: <20260125131254.23210-1-linux@fw-web.de>
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

 cmd/Kconfig               |  7 +++++++
 cmd/meminfo.c             | 25 +++++++++++++++++++++++
 doc/usage/cmd/memsize.rst | 43 +++++++++++++++++++++++++++++++++++++++
 test/cmd/meminfo.c        | 17 ++++++++++++++++
 4 files changed, 92 insertions(+)
 create mode 100644 doc/usage/cmd/memsize.rst

-- 
2.43.0


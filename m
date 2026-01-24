Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C033D715EE
	for <u-boot@archiver.kernel.org>; Sat, 24 Jan 2026 17:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C91B83C04;
	Sat, 24 Jan 2026 18:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="e4O+SmjP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D834E83BE1; Sat, 24 Jan 2026 18:23:54 +0100 (CET)
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9CAF83BF1
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 18:23:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=linux@fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
 by mxout2.routing.net (Postfix) with ESMTP id 3E49D5FC7C;
 Sat, 24 Jan 2026 17:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=routing; t=1769275431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wBMHf9RGXgLHTCksNMR5FIOzrJtszZThTbIfxr4Inag=;
 b=e4O+SmjPrnCSfzFHurmMCVVVx1IvPu4YxwbP2++/wNngDRNInDt80mqK4TbMF5xJB5pacV
 svmY7C2reJdqT1u3eCVwknVHDA98xyvyvcShYAq15aIZCcI46PRE/JGTmMSVX+pkLFQJNt
 qqMz6OFSptnxb5WmNdxdX0esDHRsysU=
Received: from frank-u24.. (fttx-pool-80.245.78.113.bambit.de [80.245.78.113])
 by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 1BCB01226B6;
 Sat, 24 Jan 2026 17:23:51 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Tom Rini <trini@konsulko.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de,
 Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v5 0/3] Add command for getting ramsize in scripts
Date: Sat, 24 Jan 2026 18:23:39 +0100
Message-ID: <20260124172344.926755-1-linux@fw-web.de>
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


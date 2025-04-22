Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F75C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 06:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52838810E8;
	Tue, 22 Apr 2025 08:46:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D29DF810EB; Tue, 22 Apr 2025 08:46:20 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE90081026
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 08:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan. (unknown
 [IPv6:2605:59c0:20f3:a400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id F2184B4C05D9;
 Tue, 22 Apr 2025 08:46:16 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Tom Rini <trini@konsulko.com>, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Cc: E Shattow <e@freeshell.de>,
	u-boot@lists.denx.de
Subject: [PATCH v1 0/2] jh7110: starfive: visionfive2 drop setting of $fdtfile
Date: Mon, 21 Apr 2025 23:45:24 -0700
Message-ID: <20250422064541.635210-1-e@freeshell.de>
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

Drop convenience hack that sets default value of $fdtfile on visionfive2
target(s). This is not needed since the JH7110 OF_UPSTREAM migration and is
anyways a duplication of code from SPL that adds friction to maintenance or
adding new variant visionfive2 targets.

If it is still desirable to have default $fdtfile values based on
OF_UPSTREAM dtb filenames then this should be provided further up the code
path in an API and not by duplicating all board detection logic again from
SPL into the main payload.

Users who need to specify $fdtfile may still do so the normal way as
described in U-Boot documentation.

E Shattow (2):
  doc: board: starfive: Drop setting of $fdtfile
  board: starfive: visionfive2: Drop setting of $fdtfile

 .../visionfive2/starfive_visionfive2.c        | 61 -------------------
 doc/board/starfive/milk-v_mars.rst            | 18 ------
 doc/board/starfive/pine64_star64.rst          | 16 -----
 doc/board/starfive/visionfive2.rst            | 18 ------
 4 files changed, 113 deletions(-)


base-commit: cde0050618968aae335dfbc930641656d51ff5d0
-- 
2.49.0


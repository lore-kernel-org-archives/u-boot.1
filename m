Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B805C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 23:35:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47FBF87988;
	Thu, 28 Dec 2023 00:34:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=prolan.hu header.i=@prolan.hu header.b="A/a6wnpw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 215028758C; Thu, 28 Dec 2023 00:34:22 +0100 (CET)
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 058C387740
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 00:34:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Csokas.Bence@prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain
 [127.0.0.1])
 by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 72FA3A12E8;
 Thu, 28 Dec 2023 00:34:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :from:from:message-id:mime-version:reply-to:subject:subject:to
 :to; s=mail; bh=z31nXc62wAFFRgsRuNcivBdfkmWbB3w3DwNsKkbjvEQ=; b=
 A/a6wnpwb/+IuSAnOVqrUL//tqBABlt5wrcFlz/n/EvwW8+ig2hdQYKI+NMK0bU0
 5IxgnX2BEKcdCS9plyMy8UJsEJcAESDaLa6ncpcBLnY0BLIy18nx+jvAwt+v0kQa
 CFYp1cXaF7s5X/xLipfFylSER9Q5Yv3T778nYJOnzw6aFNbI/uDX19zuPTB82Rpw
 Qp6GEDZF6xXkeqNE8oaRzPYiqgAfBtSBTiZBSX6+Po8q+824BL1QzRJA7tLMkUZl
 XalG6wLUwX6z0UmZT5S7usOYMhJqi7Bf9eJLDoP+J3JfBSpwJQyZw1Jd5dTjvUmj
 WYLZLsul+PHrKkbhk+rbSTf/cZ1NG4WkCgy96hDYxhLWF9GllFQD7kEbOl7xxaMG
 gv4CLsM17qNwdQbvZAqDhzNZfyc4ZhjVGrE6Tr0stfMGF2q09NGGBfZqeKWiySqL
 Z5Scr8kGf0wZkvLXEjjC6G+/elolJxGiyqybPMC4oXrsz3wGC8fUby1s1EcCyu0J
 +NSszPsx8zNqPW4EZfbnSYxQWTmM9t5cN/Q7+HP3XuN/fWbh/YhGHIneTSnV0aPP
 mHfFZOaMpWjo+vPfPO5sgHtCYBX6WZR0pv+rY1eyX9/FT4VFlTtXUaC6eJTzrbj3
 xneXCjdboNiOLR3VXmqogTVD9HZwooH3L0GW/WdtHSs=
From: Bence Cs <csokas.bence@prolan.hu>
To: <u-boot@lists.denx.de>
CC: Dragan Simic <dsimic@manjaro.org>, Simon Glass <sjg@chromium.org>, "Daniel
 Golle" <daniel@makrotopia.org>, Sean Anderson <seanga2@gmail.com>, "Mark
 Kettenis" <mark.kettenis@xs4all.nl>, Bence Cs <csokas.bence@prolan.hu>
Subject: [RFC PATCH 0/2] Passing U-Boot logs to the OS
Date: Thu, 28 Dec 2023 00:30:10 +0100
Message-ID: <20231227233011.358276-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK; S=0; OP=CALC; TIME=1703720055; VERSION=7966; MC=1862357694;
 ID=305937; TRN=0; CRV=0; IPC=; SP=0; SIPS=0; PI=3; F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29916D385C6C7D6A
X-Mailman-Approved-At: Thu, 28 Dec 2023 00:34:44 +0100
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

The problem of sending boot logs to the booted OS has not been solved,
but it is high time we do it. This proposed patch aims to give a crude
solution, utilizing CONFIG_CONSOLE_RECORD to capture the logs and
saving them to RAM, along with a struct residing at
CONFIG_CONSOLE_RECORD_SAVE_BASE. There may be more sophisticated
methods than this, which may be implemented if time permits.

Please note that this patch is not the final solution, but we do
intend to finish it by the end of the MW. Also I am WFH for the
holidays, so if someone could smoke-test, I'd appreciate it.

The patch series was based on the current tip of `next` branch:
Commit: 4b151562bb bootmeth: pass size to efi_binary_run()

Previous discussion thread can be found here:
Link: https://lists.denx.de/pipermail/u-boot/2023-December/541138.html

Bence Cs (2):
  Add U_BOOT_VERSION_CODE macro for packing the version number into a
    single int
  common: console: Add support of passing the saved console log to the
    OS

 boot/bootm.c      | 27 +++++++++++++++++++++++++--
 common/Kconfig    | 13 +++++++++++++
 common/console.c  | 13 +++++++++++++
 include/console.h | 19 +++++++++++++++++++
 include/version.h |  3 +++
 5 files changed, 73 insertions(+), 2 deletions(-)

-- 
2.25.1



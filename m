Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C386D29C40
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 16:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D87DA83015;
	Mon, 19 Jan 2026 17:07:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="fGVsVBa4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B2B180B98; Mon, 19 Jan 2026 17:07:58 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 249A78003E
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 17:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id ACB021A296E;
 Mon, 19 Jan 2026 16:07:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7174460731;
 Mon, 19 Jan 2026 16:07:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B5DDA10B6B181; Mon, 19 Jan 2026 17:07:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1768838874; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=D05yOduquZ12/Qz8z5Lmhi6wDIM1eifOikiJa81m4B8=;
 b=fGVsVBa4OMqDn0qHrNN+Q6fOgSgvWFbOUu0M1gxp4IF0UDTk1PkQqajbyPlgISRswj0QQw
 O/JaKfQuVROjAzDGeEx6Y1UftSkKp2BqxQxH4Ti5USKsq94XzMYQgWoJQfjVFdAUcqlo88
 51mEmY2zdoxklqoKGADKv/bJZldjtt/f8C2ryfbRusC1Z0NIaiZz+FPvLWUQdL/xW57cTj
 eClG/DMfe89fT09WfUVvfCvkKioMPhg54KY3D0yn3vyhxKdXW32CMk1af3IezegJ+B1fua
 TUtARBjrUH4m7OVgIRtn28XhpV14nYV0d+PFRz651LQ2Nhfr2VBUfoYnYZ/C/A==
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, thomas.petazzoni@bootlin.com,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 0/2] fwu: Mark failed bank as invalid during rollback
Date: Mon, 19 Jan 2026 17:07:40 +0100
Message-ID: <20260119160746.1330877-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
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

This series improves the FWU (Firmware Update) subsystem's handling of
boot failures by properly marking failed banks as invalid during rollback.

Patch 1 refactors fwu_state_machine_updates() to use an enum instead of
a boolean, adding support for FWU_BANK_INVALID state.

Patch 2 detects rollback at boot time (when boot_idx != active_idx) and
marks the failed bank as invalid to prevent future boot attempts.

Changes in v2:
- Refactors fwu_state_machine_updates() to use enum as parameter instead
  of adding a new fwu_invalid_bank() helper.

Kory Maincent (2):
  fwu: Pass bank state enum to fwu_state_machine_updates()
  fwu: Mark failed bank as invalid during rollback

 include/fwu.h                | 22 ++++++++--------
 lib/efi_loader/efi_capsule.c |  5 ++--
 lib/fwu_updates/fwu.c        |  6 +++++
 lib/fwu_updates/fwu_v1.c     | 16 ++++++------
 lib/fwu_updates/fwu_v2.c     | 50 +++++++++++++++---------------------
 5 files changed, 50 insertions(+), 49 deletions(-)

-- 
2.43.0


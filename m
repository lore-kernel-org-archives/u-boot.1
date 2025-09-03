Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA0DCA1005
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 02:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4D6883403;
	Wed,  3 Sep 2025 04:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="RIl6xo3w";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vh/zEPUa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A7C083420; Wed,  3 Sep 2025 04:01:07 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D53F833D0
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 04:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cGm6n06lgz9tFr;
 Wed,  3 Sep 2025 04:01:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756864865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=AH+X8wcIxBM6mm71RpZdG4wMEoMRYocgLXgzGpsUpWE=;
 b=RIl6xo3wZanvdadYchE8qeHjbxyVuqI3FuIYdu3dAgUVhTxJFjhXiNPJZBI52h2zRp7XIK
 JlSA/QCVSQMDR8BiMARjtLpbi28FAU2aU9Bve0iZ3Z239oDJDIUsEFxbosxsFic7wOXPuz
 iiWOvf/BWNB4UV7lA9OYy5lTeblxeRKkp4NAtSSY35Kc11QtKkgKNGkBmco0tPo9TUcC8O
 AlthVkqnKVydvJ7AmZG5sfPK0AKNSMVkziPG0SFBrBizerrCRqHB2NvuxHm3qo0RI3g+CY
 gjPPNUwywHDatyOb3kO/b7kE/bMrLRXrL1Gu48C9GrGm0nrAzF3vp9pNyk47XQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756864862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=AH+X8wcIxBM6mm71RpZdG4wMEoMRYocgLXgzGpsUpWE=;
 b=vh/zEPUac+S/X7FEG+/hNoX+o44Te/EBqkAUIGeMa7P6X+2V+j9cD8FPEp2aGiTzrVFXLY
 5FHqhzgZg1PfSpIyClxhOmycu7i/Z/4ol2wtiuCRMGRCi3LiZEdOoj84WQqrG2UdqmRfvW
 Iq/kONNRnP8AdAMsVfP2fvOe/VPkpwOSbfcc5VGmvU8fmcGVGEIElOP7xYngpXb4D/MOz2
 rGz+mIH0Ipnd3kZ1MDLUIgE+JGbfshFqqX2uGL+fdtAJi7Wy+z5W83tZ9ZoF1jFE8b/UXt
 S0Z6gfe5EL2L069pmTsnEqTdCIdOMfP3YuBOoWgiEpuARd+cgNqev3UZX3qIaA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PULL] u-boot-sh/master
Date: Wed,  3 Sep 2025 04:00:26 +0200
Message-ID: <20250903020045.878082-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 64b21d7f5c6f552e85c
X-MBO-RS-META: jubufxr1pxdjgstjpjriyioiiwk1qpth
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

The following changes since commit d367be2b13a388fdb0dc2720f66c30ddcec8a4fd:

  Merge tag 'u-boot-rockchip-20250831' of https://source.denx.de/u-boot/custodians/u-boot-rockchip (2025-09-01 09:50:01 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 8705ee4b6d3665f096017aaef5c1496ba7c74cc3:

  pinctrl: rzg2l: Variable may not have been assigned to (2025-09-03 02:45:08 +0200)

----------------------------------------------------------------
Andrew Goodbody (1):
      pinctrl: rzg2l: Variable may not have been assigned to

 drivers/pinctrl/renesas/rzg2l-pfc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

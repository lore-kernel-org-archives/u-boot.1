Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB28C54E60
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 09:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2853B87DBE;
	Sat, 16 Mar 2024 10:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Wab17S8I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CD8087DBE; Sat, 16 Mar 2024 10:37:03 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03F15879F3
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 10:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 5B0B63FB61; 
 Sat, 16 Mar 2024 09:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1710581819;
 bh=j0M7A/wbKNoWx70eh2+GiDXEwLcLLQSI6BVWlMyQQhM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Wab17S8Ig02tUfWYWa57ZdTehCJYkv6aeVxMdI1XyFkpgYhd15/oxS5pVXoLXl370
 +q+8f6xMHg4rlhITsyGWxxACJla/RgNzJZ3UI8vA51HNzYH5EZgnoOwEpw70ru5ap3
 9YP4CJnE044VIAQG+MFedM4LIX5pS6j8tQOePy0nsg8kRDXdAbphpur11nFb+rYR6e
 ILhfwzbMlDohd2MXLFiFWkc9cfvyDvDChM+b2lAn5KtokT19JfT3XfRw4V0olbBsNe
 n49t14oAPqE0WE4H36BcAD/9snLwmRG9MvJOUmKe1v8Y20oo6ToBCkc3iqFLLoi/XO
 zBl3ahPIKv+TA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/3] cmd: bootefi: fix error handling
Date: Sat, 16 Mar 2024 10:36:41 +0100
Message-ID: <20240316093644.54869-1-heinrich.schuchardt@canonical.com>
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

efi_run_image() tries to remove protocol interfaces from a NULL handle and
returns EFI_INVALID_PARAMETER.

If an EFI binary returns an error code EFI_INVALID_PARAMETER, we show the
usage help for the bootefi command which makes no sense.

If bootefi selftest is executed and a problem with the device-tree
installation occurs, efi_install_fdt() writes sensible error messages.
It makes not sense to show  the usage help for the bootefi command in
this case.

Heinrich Schuchardt (3):
  efi_loader: correct handling of EFI binary return code
  cmd: bootefi: Don't show usage help if EFI binary fails.
  cmd: bootefi: error handling bootefi selftest

 cmd/bootefi.c                | 12 +++---------
 lib/efi_loader/efi_bootbin.c | 16 +++++++++++-----
 2 files changed, 14 insertions(+), 14 deletions(-)

-- 
2.43.0


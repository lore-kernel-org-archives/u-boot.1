Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2DCCD5BB1
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 12:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE58E84865;
	Sun, 24 May 2026 14:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="JimJkg5I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB2C284693; Sun, 24 May 2026 14:38:25 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E5F283AA9
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 14:38:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josh2@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 4F05E275E5;
 Sun, 24 May 2026 14:38:23 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CBdLG0rXmkWJ; Sun, 24 May 2026 14:38:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1779626302; bh=9iprNF8XU8tgaZFBbKcDmDbj5tUfQLKW/HZdW1CYvGU=;
 h=From:To:Cc:Subject:Date;
 b=JimJkg5IOJD9JtJDigqp6Nm6svWw4dcmaIBPC45jJ2snrRcK8WkMcBwVIUtfExWq1
 1Of1pZeg7KS+bb4uKlkTUGuQE6Gt4g5vOtPMt6QqyJsp7hlP1B0M70D6VMGm6Spgy1
 r947y7/zM9xeZW3RBxPo+5ISlAbiwl6DFOS3OOwduvjsueNT87VdyDlMOEwSbodjib
 6/Rqd6ULG7uS0ZADmrDq9EwL8YCvRHkb/xlKIsrn4hLfe/GGbJ3JKcJFn1CK8uGplq
 Eeo6msZs9g/Uo8yeugOlvIr1Opw4CgnWUVuM88BB56+WBOTMs5bfgmbzF4cBHp2EJr
 vpqeAL23U+C8g==
From: Josh Law <josh2@disroot.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Josh Law <josh2@disroot.org>
Subject: [PATCH 0/1] armv8: reduce core errata dispatch work
Date: Sun, 24 May 2026 12:38:21 +0000
Message-ID: <20260524123822.7244-1-josh2@disroot.org>
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

Hey folks,

apply_core_errata() runs during early ARMv8 CPU entry, before
lowlevel_init(). Today it still checks the Cortex-A53 and Cortex-A57
paths even when the build has no matching core erratum enabled.

This patch leaves that dispatch code out unless one of the supported
errata is enabled. For the A57 errata case, it reads MIDR_EL1 once and
reuses the extracted CPU part number.

The erratum register writes stay behind the same CPU checks as before.
For qemu_arm64_defconfig, where none of these errata are enabled,
apply_core_errata() goes from 15 dispatch instructions to a single ret.
For ls2080aqds_qspi_defconfig, which keeps the A57 path, the dispatch
side goes from 33 instructions to 26. A KVM microbench of the same
dispatch sequences showed 1.30x for the no errata case and 1.09x for
the A57 miss case.

Josh Law (1):
  armv8: reduce core errata dispatch work

 arch/arm/cpu/armv8/start.S | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

-- 
2.47.3

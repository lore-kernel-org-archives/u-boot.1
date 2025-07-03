Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78BCC83030
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 06:43:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F3FA8206E;
	Thu,  3 Jul 2025 08:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D373181FEE; Thu,  3 Jul 2025 08:43:24 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D1E5180194
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 08:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C8D7152B;
 Wed,  2 Jul 2025 23:43:07 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.164.21.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D7A33F58B;
 Wed,  2 Jul 2025 23:43:19 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v5 0/2] eficonfig: add support for URI based boot option
Date: Thu,  3 Jul 2025 12:13:06 +0530
Message-Id: <20250703064308.1019305-1-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
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


Add support for adding URI based boot option through the eficonfig
command. Also add a basic test case for checking validity of the URI's
being passed to the wget function.

Changes since V4:
* Clear out the URI string in eficonfig_process_clear_file_selection()
  when user selects the 'Clear' menu - patch 1.
* Display the URI string as part of editing the boot option by putting
  a check in prepare_file_selection_entry() - patch 1.
* Clear out the URI string in eficonfig_process_select_file() if a
  file is being selected from one of the disk volumes - patch 1.



Sughosh Ganu (2):
  cmd: eficonfig: add support for URI device path based boot options
  test: wget: add a test case for validating URI

 cmd/eficonfig.c      | 146 ++++++++++++++++++++++++++++++++++++++++---
 include/efi_config.h |   2 +
 test/cmd/wget.c      |  20 ++++++
 3 files changed, 160 insertions(+), 8 deletions(-)

-- 
2.34.1



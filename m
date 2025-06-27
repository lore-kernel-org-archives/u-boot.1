Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959C5C77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 11:25:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED7C082F5D;
	Fri, 27 Jun 2025 13:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0998482F8F; Fri, 27 Jun 2025 13:25:40 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5226B82EA5
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 13:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21A1D1A00;
 Fri, 27 Jun 2025 04:25:05 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.164.21.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 847503F66E;
 Fri, 27 Jun 2025 04:25:20 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v3 0/2] eficonfig: add support for URI based boot option
Date: Fri, 27 Jun 2025 16:55:07 +0530
Message-Id: <20250627112509.264221-1-sughosh.ganu@linaro.org>
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

Changes since V2:
* Added comments for eficonfig_create_uri_device_path() - patch 1
* Added comments for fill_dp_uri() - patch 1
* Remove some superfluous newlines added - patch 1


Sughosh Ganu (2):
  cmd: eficonfig: add support for URI device path based boot options
  test: wget: add a test case for validating URI

 cmd/eficonfig.c      | 131 ++++++++++++++++++++++++++++++++++++++++---
 include/efi_config.h |   4 ++
 test/cmd/wget.c      |  20 +++++++
 3 files changed, 147 insertions(+), 8 deletions(-)

-- 
2.34.1



Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAC6F3D31C
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 16:14:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 833788382A;
	Thu,  5 Mar 2026 17:14:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F292B839A8; Thu,  5 Mar 2026 17:13:58 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id ECB5881E18
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 17:13:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B83EF339;
 Thu,  5 Mar 2026 08:13:49 -0800 (PST)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.129.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 43BB93F694;
 Thu,  5 Mar 2026 08:13:55 -0800 (PST)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/4] Add an efidebug ecpt command
Date: Thu,  5 Mar 2026 17:13:45 +0100
Message-ID: <20260305161349.2317130-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi,

This patch series adds an "efidebug ecpt" command to list the conformance
profiles and a python unit test.

This should help verification when we will add more conformance profiles.

Best regards,
Vincent.

Vincent Stehlé (4):
  lib: uuid: add EBBR 2.1 conformance profile GUID
  efi_loader: export efi_ecpt_guid
  cmd: efidebug: add ecpt command
  test/py: add ECPT tests

 cmd/efidebug.c                   | 49 ++++++++++++++++++++++++++++++++
 include/efi_loader.h             |  4 +++
 lib/efi_loader/efi_conformance.c |  2 +-
 lib/uuid.c                       |  4 +++
 test/py/tests/test_efi_ecpt.py   | 42 +++++++++++++++++++++++++++
 5 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 test/py/tests/test_efi_ecpt.py

-- 
2.51.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD2DCCF2DF
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 11:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EC3183015;
	Mon, 19 Jan 2026 12:12:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="pqvzlGBZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B7D68313B; Mon, 19 Jan 2026 12:12:05 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49546800AE
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 12:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1768821114; x=1769425914; i=xypron.glpk@gmx.de;
 bh=kaVXE9fP/OCkNhJHE9PT8tVeLVziHaraobnr4M5BKnU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=pqvzlGBZcd6oU5dnQmjdUaW9JYeTecZA2CDckUJFJtRN3cBDeLkPHfN3dGX3CkP+
 lhKtDtLCYuil6rTpEJoYbELzAraQ1spsHFriNMNKpnsCKbnfHSoqnmzRHvN5EiDm1
 /yg4/VKMB7IWoPt4Xou6W7BRjmZDf674zczWJCQK54P/VYYIxY2SDl8Hemt6IMNEI
 1D0yauD5GbxxkZkhVpa55IT+aNs2CjXBK4e257YJn6rU6JbmFsmpzrDZMLuCpIYql
 0guiuc8+OXZmaRQTdoQqt329jtdz7SncSHLybfCsusYYQorMYFKlWM2Ub3MUJ4rXV
 /MqVIdC4JXmVfaGQlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mz9Z5-1w3hpx0t3z-00sIeF; Mon, 19
 Jan 2026 12:11:54 +0100
Message-ID: <1696a0c3-f3c1-443b-8ca5-06298589e664@gmx.de>
Date: Mon, 19 Jan 2026 12:11:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, E Shattow <e@freeshell.de>,
 =?UTF-8?Q?Neusch=C3=A4fer?= <j.ne@posteo.net>,
 Manjae Cho <manjae.cho@samsung.com>, Paresh Bhagat <p-bhagat@ti.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2026-04-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GMxvYqy6pOVwt7GWXWhWtsW76W8Dfno9pPieKP8iADc6pnwMqRE
 JIUsZR9/9WF3k/bIRBWJ7wlaQBwJlrqP0mQ8ryw0OrHr5imaITns7cWk/iBNjosktftmd4j
 z0+iNs87sOn+RkXEG/PwLEir5Ho4XGiY+XvZBtwuOEzNUFk/SNLCBKyhYvY4uXflp6p2KaO
 jHyfrwAkIj6GY+QBBnPPg==
UI-OutboundReport: notjunk:1;M01:P0:uJEazwgI8LY=;imxc5AtHB+fEbxM4v0uxo8TersU
 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
 +NI6aRiiX+GqAGqiy5kk39oFBvSaDysgkieL46
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


Dear Tom,

The following changes since commit 6b2d05748cf3cd6ba417a96c00602b0122e10af=
6:

   Merge tag 'u-boot-imx-master-20260117' of=20
https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2026-01-17 22:29:24=
=20
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2026-04-rc1

for you to fetch changes up to 9788e9cd4381ea4011a576d6e3eaf351bec7606b:

   doc: board: starfive: update jh7110 common description (2026-01-19=20
10:31:22 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/29039

=2D---------------------------------------------------------------
Pull request efi-2026-04-rc1

Documentation:

* Update StarFive JH7110 common description
* Add TI AM62D documentation
* update the development process description:
   - Rework the custodian feedback section
   - Explain when/how Custodians may edit patches
* Update urllib3 version for building
* Update links to doc/develop/falcon.rst
* Describe QEMU networking
* kdoc: handle the obsolescensce of docutils.ErrorString()
* Fix typo "addtional" -> "additional" in pflash section.

UEFI:

* Fix boot failure from FIT with compressed EFI binary

Others:

* cmd/meminfo: Correct displaying addresses above 4 GiB
* test:
   - Consider configuration in meminfo test
   - Consider initf_malloc is only traced with EARLY_TRACE
   - Clean up test_trace.py code

=2D---------------------------------------------------------------
E Shattow (1):
       doc: board: starfive: update jh7110 common description

Heinrich Schuchardt (5):
       cmd/meminfo: display of addresses above 4 GiB
       test: cmd: consider configuration in meminfo test
       test: initf_malloc is only traced with EARLY_TRACE
       test: clean up test_trace.py code
       doc: describe QEMU networking

J. Neusch=C3=A4fer (2):
       Update links to doc/develop/falcon.rst
       docs: kdoc: handle the obsolescensce of docutils.ErrorString()

Manjae Cho (1):
       Fix typo "addtional" -> "additional" in pflash section.

Masahisa Kojima (1):
       bootm: fix boot failure from compressed image for IH_OS_EFI

Paresh Bhagat (1):
       doc: board: ti: Add AM62D documentation

Tom Rini (4):
       doc: Update urllib3 version for building
       doc: develop: process: Move the existing block about patch=20
application
       doc: develop: process: Rework the custodian feedback section
       doc: develop: process: Explain when/how Custodians may edit patches

  boot/bootm_os.c                               |   4 +-
  cmd/Kconfig                                   |   4 +-
  cmd/meminfo.c                                 |   8 +-
  common/spl/Kconfig                            |   2 +-
  doc/board/emulation/index.rst                 |   1 +
  doc/board/emulation/network.rst               | 152 ++++++
  doc/board/emulation/qemu-riscv.rst            |   2 +-
  doc/board/starfive/deepcomputing_fml13v01.rst |  32 --
  doc/board/starfive/jh7110_common.rst          | 635=20
++++++++++++++++++++++----
  doc/board/starfive/milk-v_mars.rst            |  73 ---
  doc/board/starfive/pine64_star64.rst          |  77 +---
  doc/board/starfive/visionfive2.rst            | 449 ------------------
  doc/board/ti/am335x_evm.rst                   |   2 +-
  doc/board/ti/am62dx_evm.rst                   | 256 +++++++++++
  doc/board/ti/k3.rst                           |   1 +
  doc/develop/falcon.rst                        |   1 +
  doc/develop/process.rst                       |  49 +-
  doc/sphinx/kernel_abi.py                      |   4 +-
  doc/sphinx/kernel_feat.py                     |   4 +-
  doc/sphinx/kernel_include.py                  |   6 +-
  doc/sphinx/maintainers_include.py             |   4 +-
  doc/sphinx/requirements.txt                   |   2 +-
  test/cmd/meminfo.c                            |  20 +-
  test/py/tests/test_trace.py                   |  38 +-
  24 files changed, 1049 insertions(+), 777 deletions(-)
  create mode 100644 doc/board/emulation/network.rst
  create mode 100644 doc/board/ti/am62dx_evm.rst


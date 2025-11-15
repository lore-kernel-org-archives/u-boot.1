Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8556CEB2CC
	for <u-boot@archiver.kernel.org>; Sat, 15 Nov 2025 12:22:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30B24841CD;
	Sat, 15 Nov 2025 13:22:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cxdga6K+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C91B7842FC; Sat, 15 Nov 2025 13:22:08 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F19183C54
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 13:22:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1763209324; x=1763814124; i=xypron.glpk@gmx.de;
 bh=/mL013HHPotRhFHQi5FsiR3IhA8DI7/6+c8upEtRRQE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=cxdga6K+0ITrIt3cwHFQJu0cqjlvVdfONUjhl8tUFT3QqYBjZOzBeZM+ip0is4It
 0TqK7xYlXRYQXnT54xWou+NzIXHHcNozMRkaCQK8SVpCiNTz3nu7Gxi05Tu4cAqzt
 cEMPvLdC6xg1aR7T9TQNOEYTdVGXqpV33+qBDT+flSaeZaPVYqbsx5RvSRG/yFoV0
 +TtAQKEKuIwzMgTK32nA8bwHKXOzOFT+IXoGuAz7Q6lRuT8Rmg7NFhPtWxxoUi6NS
 zZF+xSvW6C2h7a/+s/+H/xZ1ge0Q1NjSRsTrZzTeSwWGYy3koa6gqQTbLc9jdGuyz
 iW3yXAaRXoVdi9TbpQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIMbO-1vPhKi1vkq-007BMH; Sat, 15
 Nov 2025 13:22:04 +0100
Message-ID: <26b74dd7-6fa0-4327-9b75-0c750dab5774@gmx.de>
Date: Sat, 15 Nov 2025 13:21:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2026-01-rc3 for branch master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o4bs9akFJh2EiVp9el8RFFOOCRSvugngkMd5DU2TN148K7eWx1c
 kJqiF6qO6ZkADu9dCpYfmBeS3BAFkDBPIJzfrYFt2iHwZAfEIBUbUIdNMsFNHXkTsV59F7I
 1UQ4gu1sEkqQTquRuN7yXTljURmvzmUH6VUSS9mDkVGJ+vSImVgU3KZD4OJLjTu6pGSUTXE
 Fbd71xU/JIenM+TCiiacg==
UI-OutboundReport: notjunk:1;M01:P0:+LcRyyKpRW4=;l3O3FysftcQkw6j6zBYTmx876xo
 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
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

The following changes since commit 6c2f2d9aa63d1642dffae7d7ac88f7ae879e13d=
1:

   Merge branch 'master' of git://source.denx.de/u-boot-usb (2025-11-13=20
08:01:57 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2026-01-rc3

for you to fetch changes up to 8cc144227e13b50cd6d97c36ebb45f31f4d8c9cd:

   efi_loader: Assure fitImage from capsule is used from 8-byte aligned=20
address (2025-11-15 11:50:42 +0100)

=2D---------------------------------------------------------------
Pull request efi-2026-01-rc3

Documentation:

* Correct the linux/arm64 platform string for Docker builds
* Complete pytest dependencies list with missing packages

UEFI:

* Use Sphinx style comments in efi_selftest_console.c
* Don't include asm/global_data.h in lib/efi_client/efi_app.c twice
* efi_client: correct memset() return value
* Assure fitImage from capsule is used from 8-byte aligned address
* Fix warning when building efi_selftest_snp with clang

Gitlab CI reported no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/28355

=2D---------------------------------------------------------------
Bin Meng (1):
       docker: Correct the linux/arm64 platform string

Heinrich Schuchardt (4):
       efi_selftest: use Sphinx style comments in efi_console.c
       efi_loader: typo 'eventfor' in efi_ipconfig.c
       efi_client: don't include asm/global_data.h twice
       efi_client: correct memset() return value

Kory Maincent (TI.com) (1):
       doc: pytest: Complete dependencies list with missing packages

Marek Vasut (1):
       efi_loader: Assure fitImage from capsule is used from 8-byte=20
aligned address

Tom Rini (1):
       efi_selftest: efi_selftest_snp: Fix warning when building with clan=
g

  doc/build/docker.rst                    |  2 +-
  doc/develop/pytest/usage.rst            | 21 ++++++++++------
  lib/efi_client/efi_app.c                |  1 -
  lib/efi_client/efi_stub.c               |  2 +-
  lib/efi_loader/efi_firmware.c           | 16 +++++++++++-
  lib/efi_loader/efi_ipconfig.c           |  4 +--
  lib/efi_selftest/efi_selftest_console.c | 44=20
++++++++++++++++-----------------
  lib/efi_selftest/efi_selftest_snp.c     |  2 +-
  tools/docker/Dockerfile                 |  2 +-
  9 files changed, 56 insertions(+), 38 deletions(-)

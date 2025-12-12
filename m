Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F6FD4921F
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 12:44:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B665830E4;
	Fri, 12 Dec 2025 13:44:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="aimjwKrJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6FA283106; Fri, 12 Dec 2025 13:44:16 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52E8F8307F
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 13:44:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1765543449; x=1766148249; i=xypron.glpk@gmx.de;
 bh=Lan/JYt0aowZUzs+FDI/SOjJDygL4YcRjlYsDM7dWSI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=aimjwKrJWVwj+4R30/hkKJiAkbEieYUHu0gVWryRVrglReHDC0MZ8eGW8nZvsJiQ
 CBoZjL2VjqbMCo6BeZjPNVWJwvPPQWfQH1cJPBWYU8zoFfFwimtotBHhmZvabHMVf
 DF4MlikA5ej3HIXw3ogJZIdFYEHo2ePMJeanqFoCVhrrgTNj3SRwhoXKNPmxlfkPJ
 0XOLtSWWvvynEIv2CmoB9M4KDCEc1R4YYm3NEJan9kAN8PciUOa3vAIAR7evdmdSa
 5u6xTFxbr97xPUR4J8gMuZG+CyBpBrZDSVV5G6bx42KfeYaPDGvfil0aEcILvngWV
 joI9Td9PpTWbAaXG7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.125] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2O6e-1vRH551QuU-009RpZ; Fri, 12
 Dec 2025 13:44:09 +0100
Message-ID: <b0ba6f42-d157-449e-9857-84d9bb39bf80@gmx.de>
Date: Fri, 12 Dec 2025 13:44:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2026-01-rc5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1JGjAnPm84aIsn/leVOucYaPnAMv29lupB2kjfq4F+xTMSr7EfQ
 SuoXD6iPbgUuhJPMCFXzqSwZDTj9Jvr9RRhmLdjcxof8DqumsP8CzDnDOlFyEOodZ7KCrls
 Q8T8jT9/iDxnhcXxH7+8dBMoDROH9lfS7vkRBTin/sXx7/65ADjpndfoRogMhdMIZD0+ZCv
 A7rdjZeWAx9Y6z2FQxGLg==
UI-OutboundReport: notjunk:1;M01:P0:oaWloY2xygI=;qDvXX+/wHXVdZAzONpMajaOwUyU
 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
 mMOEBf5KeqpyZ9wwWwtw7FEOyKsDIWUwMnl/Gn
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

The following changes since commit ff80e95fed188ec3d4001129445e414c9c811be=
b:

   tools: use setuptools 78.1.1 (2025-12-10 09:28:43 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2026-01-rc5

for you to fetch changes up to ec1c966285758489ee45cfc2af703d0ede1a376e:

   doc: board: ti: k3: Fix a couple small typos (2025-12-12 12:52:31 +0100=
)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/28738

=2D---------------------------------------------------------------
Pull request efi-2026-01-rc5

Documentation:

* Fix typos in the TI K3 board documentation.
* Describe the TI J742S2.

UEFI:

* Add EFI_PARTITION_INFO_PROTOCOL_GUID translation in the UUID library.

=2D---------------------------------------------------------------
Andrew Davis (1):
       doc: board: ti: k3: Fix a couple small typos

Heinrich Schuchardt (1):
       lib: uuid: add EFI_PARTITION_INFO_PROTOCOL_GUID translation

Udit Kumar (1):
       doc: board: ti: Add J742S2 support

  doc/board/ti/j784s4_evm.rst | 23 +++++++++++++++++++++--
  doc/board/ti/k3.rst         |  6 +++---
  lib/uuid.c                  |  4 ++++
  3 files changed, 28 insertions(+), 5 deletions(-)

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE8FC61CE7
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 13:12:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34D3480E9A;
	Sat,  7 Jun 2025 15:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Gf5zj5qv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C41681F0D; Sat,  7 Jun 2025 15:12:37 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BE5D807B1
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 15:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1749301954; x=1749906754; i=xypron.glpk@gmx.de;
 bh=V/b74g3PWFrAi4ZB9i27clkhX8c03PenJBeIxR7rYWM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Gf5zj5qvO4SXK1FwdiHPzBvBiL2IDYaglErrLb1OP+YVeI9D/L8Ncj8XRbx48Ub5
 Z6bQ756JLenhD1vXqKmS3WA3cQJTrmPc1IPocEC6rZ620wqGPdfbByaVDNhGWiJTD
 AgYQAejuLzTGbsLd3GqxhIMOmPflKsatkgQFSRPcTdpPF7cAyhVGbYfNN+Ajm6vOT
 aSomv2bxnD8yGglqE1uKnhyI2nWUNRjGIxM/NQ9e58INYBpO7rYcxSvB2WB78rJMp
 8BBtp1LlSBzZRY6VwZ/yG8v4Skc+Zcmfpiq22rIKiNjPHjhnW1ykiKmjVqRJrvbyk
 x25GaV1i5FVdGIXpwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.175.200]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5fIQ-1uV0tU13wA-000scr; Sat, 07
 Jun 2025 15:12:34 +0200
Message-ID: <468c1753-395d-4b35-b948-5163888fe02f@gmx.de>
Date: Sat, 7 Jun 2025 15:12:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 BehradElmi <behradelmi1@gmail.com>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [MASTER]Pull request doc-2025-07-rc4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:06CWrEgp6dCK251xaP0ymc9Yu9YHlQqEWBS0rlkjW3oXw6dUNs+
 YFBNN4W2CyS8/K65DE/6DrF5G6tgrzcvoyBLm5HkDYRppiBeUubSeJAxMcVyi5VVtSSjw4H
 o6QuRP8bIsVjMcreejx5uePg8vc1oejJJEibPi/J16rFdSYjhI+HbSgO/5h4EGTbi8G/cKO
 16h1mqkwbvW5neOq6G8AA==
UI-OutboundReport: notjunk:1;M01:P0:6YcLHFATyII=;phxEdMIPpCMluexH+POG8OKRfY8
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

The following changes since commit b3f69c14187d413610abbc2b82d1a3752cb342c=
1:

   Merge tag 'xilinx-for-v2025.07-rc4' of=20
https://source.denx.de/u-boot/custodians/u-boot-microblaze (2025-06-05=20
08:40:42 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/doc-2025-07-rc4

for you to fetch changes up to 2018486f6c1ae7dae56b46f2bbfcffffaf9441b7:

   doc: build: fix typo in gcc.rst (2025-06-07 14:52:18 +0200)

=2D---------------------------------------------------------------
Pull request doc-2025-07-rc4

Documentation:

* fix typo in gcc.rst
* correct EFI_TCG2_PROTOCOL_MEASURE_DTB description
* Add missing reference to firmware for BB-AI64
* Tidy up the bootefi-command docs

=2D---------------------------------------------------------------
BehradElmi (1):
       doc: build: fix typo in gcc.rst

Heinrich Schuchardt (1):
       efi_loader: correct EFI_TCG2_PROTOCOL_MEASURE_DTB description

Peter Robinson (1):
       doc: board: ti: Add missing firmware for BB-AI64

Simon Glass (1):
       doc: efi_loader: Tidy up the bootefi-command docs

  doc/board/beagle/j721e_beagleboneai64.rst |  1 +
  doc/build/gcc.rst                         |  2 +-
  doc/usage/cmd/bootefi.rst                 | 20 ++++++++++----------
  lib/efi_loader/Kconfig                    |  7 +++----
  4 files changed, 15 insertions(+), 15 deletions(-)

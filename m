Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746AFC87FD2
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 15:18:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5E1E846E5;
	Fri,  8 Aug 2025 17:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ZtKKLRhZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 815428476F; Fri,  8 Aug 2025 17:18:44 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52BD1846D5
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 17:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1754666313; x=1755271113; i=xypron.glpk@gmx.de;
 bh=XjXmBIqnoTro51HXo3tkSbolG7kO9M/8iiSk/wF0HBc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ZtKKLRhZow062DmFRHFjlpASyQ7OS/uyfiJe0WYyeLvL9X7iWht6sRdAbOWfrzyc
 +fXKmMJZd1RUClecbgOrg1l3u6EMsnqx6GaAGvcYFAYPqG17L1/nGNIth656Y1Fmc
 KK80JOhpNySvuT1Q9+QbSm8efogeKDtq0uNsCf4EEpRZiWsnphjLaDRSLYjnlmNNI
 eeXi9WNRhdEoVau3nKMKolYs3TSOSj2GG6x5pUidk9PLvho4+kSGzDHZAZ7RjLXQl
 TuziG8L1zmmynqA6fOq73M0TRaEG9ZMnezN+z6Gy59OsneIcYSCpFOyJdOSIDrOLY
 uFf5bl5yJtjAI2iBWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8QWG-1ufz1E44jw-00BCLL; Fri, 08
 Aug 2025 17:18:33 +0200
Message-ID: <c3a1fb84-9a70-4b04-8db7-e01200e80dcd@gmx.de>
Date: Fri, 8 Aug 2025 17:18:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2025-10-rc2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r9kC5frdHei+YmSZcIho6On0zCK/cBbd3ArM25dxf4r5UDY/5vx
 Oj7OTVF9PjG7cjeFHj768d2osw82c56IjMFo3rsjPtGQG6WAMKz9XbrWiEEf3ps3182dG8C
 qQcf70JjwE/51kC/aaEX0XSzkZbyOOmLf+JRpt7Nro9vdrCp2Eo3J8FvWmyN84bnCKfrgQZ
 gzPXP6YQMWxIRCVruQZfg==
UI-OutboundReport: notjunk:1;M01:P0:V/MsfEPePpA=;Dcj7qo6erm3xTajcxbyktj3QmJQ
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

The following changes since commit 123cd77122a13288e1552b5d9b7c22a6f19e2e0=
2:

   pylibfdt: setup.py: Drop license_files (2025-08-07 11:16:12 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2025-10-rc2

for you to fetch changes up to 598df59f758df6c635970ed549beb2cb1674e0d9:

   doc: spl: fix typo 'TPL' to 'VPL' (2025-08-08 08:52:12 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/27307

=2D---------------------------------------------------------------
Pull request efi-2025-10-rc2

Documentation:

* Describe running U-Boot as a pflash image on RISC-V QEMU
* Correct the description of the bootph-verify device-tree property

UEFI:

* In mkeficapsule fix a resource leak in read_bin_file()
* Support loading a Linux initial RAM disk with the bootefi command.

=2D---------------------------------------------------------------
Heinrich Schuchardt (2):
       tools: mkeficapsule: resource leak in read_bin_file()
       doc: qemu-riscv: describe running as flash image

Leo Yu-Chi Liang (1):
       doc: spl: fix typo 'TPL' to 'VPL'

Simon Glass (1):
       efi_loader: Support loading a ramdisk with bootefi

  cmd/bootefi.c                      | 33 +++++++++++++++++++++++++-------=
-
  doc/board/emulation/qemu-riscv.rst | 26 ++++++++++++++++++++++++++
  doc/develop/spl.rst                |  2 +-
  doc/usage/cmd/bootefi.rst          | 37=20
++++++++++++++++++++++++++++++-------
  tools/mkeficapsule.c               |  1 +
  5 files changed, 83 insertions(+), 16 deletions(-)

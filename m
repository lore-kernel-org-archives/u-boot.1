Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBC1C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 16:16:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68F9D8081A;
	Thu,  1 May 2025 18:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="G08/6np8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7BCD8081A; Thu,  1 May 2025 18:16:33 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 061A38070C
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 18:16:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746116189; x=1746720989; i=xypron.glpk@gmx.de;
 bh=N9NjBv/CepU5fRblVSFMF8Yx/+QHOdaytBv9MmgM4dM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=G08/6np8rDj0AIlYeXMKgCzxdQQES3jd5aYXNUBpvm8LJO/+ciQBJJsnW6nyDGwl
 Jx5avr3WXYZ1F7/NmqMcKQDWqqCq8U4mB6jJEK4fbSaEVbhHVQ+Dg2fnMbu0vXDg4
 1muqKxBb/Bndk57ljjOFSUG97RQMmd/XaICWHchtn82ByFndKtI/ElonWMZv4v2RE
 KNGXP8VFzbq+IEJs+6U/gJcC8MJ/t5Vwcbr+7PVV45OiCRDRMNVREjj3nUgIiQOZf
 WhEn2UNyNSnkfMJOTp72fiFO8pUqoTdLK/WMFCazDpZMGRGR++IgdSzWNcnI0A+mm
 oSxUmNnY0gnIay/pcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMXQ5-1uSSfy0Rip-00L6qg; Thu, 01
 May 2025 18:16:29 +0200
Message-ID: <62949207-e59c-482b-b629-94a0e61c454d@gmx.de>
Date: Thu, 1 May 2025 18:16:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>,
 Adriano Cordova <adriano.cordova@canonical.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2025-07-rc2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8ezXPLUfd77sKTLSoXwwZaq/TfVFhwL5ZfmkwSbxivOP3VI0yMH
 tLRSGQjH3QxyKz1106v1Yx3fL6BmlHVHMol7O6/Bn1MACSMPfSq3QRldVqEnmZpo/S/I02z
 AgUG4CcU6U/JmBI274DelbLbE++FQfEI9E7FObRMonhPGJ1nlcQoRTxRtXnW+t5+7d3jtnH
 mYfMDTN4zBwTwIvZzDGfQ==
UI-OutboundReport: notjunk:1;M01:P0:ZY7W0oA0BkU=;GIqefdiw2xn4pgsV6CTTk7tj1iM
 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
 g==
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

This pull request fixes the "installing EFI_LOAD_FILE2_PROTOCOL failed"=20
issue.

=2D--

@Anshul,

I had to rebase your series because one line which you tried to change=20
from ..code-block:: to ..prompt:: did not exist. Please, check after the=
=20
merge.

=2D--

The following changes since commit aa96cda0a58f4d181b81a897b0b9fea3d972947=
8:

   clk: fix crash on clk_set_rate clean rate cache (2025-04-30 07:50:18=20
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2025-07-rc2

for you to fetch changes up to c0546426724099d94a497ea11ad79862daf37767:

   boot: let BOOTSTAGE_RECORD_COUNT default to 50 (2025-05-01 09:24:56=20
+0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/26025

=2D---------------------------------------------------------------
Pull request efi-2025-07-rc2

Documentation:

* ti: update bash code-block directives to prompt
* ti: k3: add language for code-block directive
* correct uthread inline documentation

UEFI:

* correctly handle EFI FIT images without initrd
* pass kernel load address not entry point for EFI FIT images

Other:

* boot:let BOOTSTAGE_RECORD_COUNT default to 50

=2D---------------------------------------------------------------
Adriano Cordova (2):
       efi_loader: bootbin: do not load an initrd if none is provided
       efi_loader: fix typo initd_sz to initrd_sz

Anshul Dalal (2):
       doc: ti: update bash code-block directives to prompt
       doc: ti: k3: add language for code-block directive

Heinrich Schuchardt (2):
       bootm: pass kernel load address not entry point for IH_OS_EFI
       boot: let BOOTSTAGE_RECORD_COUNT default to 50

Jerome Forissier (1):
       uthread: doc: fix inline documentation

  boot/Kconfig                 |  2 +-
  boot/bootm_os.c              |  4 ++--
  doc/board/ti/am62ax_sk.rst   | 20 ++++++++++----------
  doc/board/ti/am62px_sk.rst   | 18 +++++++++---------
  doc/board/ti/j722s_evm.rst   | 12 ++++++------
  doc/board/ti/j784s4_evm.rst  | 16 ++++++++--------
  doc/board/ti/k3.rst          | 10 +++++-----
  include/efi_loader.h         |  2 ++
  include/uthread.h            |  9 +++++++--
  lib/efi_loader/efi_bootbin.c |  9 ++-------
  lib/efi_loader/efi_helper.c  | 29 +++++++++++++++++++++++++++++
  11 files changed, 81 insertions(+), 50 deletions(-)

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4F5EEB564
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 06:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B75A8641B;
	Sat,  9 Sep 2023 08:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PlbmUbES";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3FEB8642A; Sat,  9 Sep 2023 08:48:34 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4D9385DFA
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 08:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694242107; x=1694846907; i=xypron.glpk@gmx.de;
 bh=ckPsngL+po0FbjpDxMTk/2VbmouAJLlB9nglMCPuCuM=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=PlbmUbESed1HlIXgO6t7NFa6J1FAFcAc4KGRQ5RXCi3zcKNY+MBUJxo7tfbaABHVyM7/E3Y
 BfyU0HQyQtzGqR/Mw+ng+vl0DJ7fg+IPhvKWAJfypypTWjQHIDINIwLZ62j7RtqBzfdOjOep6
 nv/mIdugQGi4wb4Y+hpeIQhjK9xC1r/I0+UvvFfABf9p0Ke7ba5CiJqE5NOmZEPDrMThIwUaa
 GvPgbYIBOuS7M+RBZJfj8/w4iZ5X+W1TN1kHihfzgFWqph2t8LA8y09KAbHEHszWtVJC8ttMc
 HYYQ7Fg5LnLYQmdYgLZfQXB7jyTgz33CsbLi+U7dS8GDoH8WaxFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMofW-1qMESF2tlM-00Ihpg; Sat, 09
 Sep 2023 08:48:27 +0200
Message-ID: <a29e29a3-10f0-4ff2-9e27-3bb771ab2b8c@gmx.de>
Date: Sat, 9 Sep 2023 08:49:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request doc-2023-10-rc5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O2X7HPplLqd3I+NlZH7KUTg6dxdIx+j+aY3+XL2suIwMz03QDd+
 01sPPY8fxRGS+ZS55K2iRSHo8m9CMGtB7e/qeJ0muzYuIwycZYsnNXdhsas59YXBjzOz7ia
 xZd1Z3BoaLSdJ/H14PmYGYbqRETJ/KdT714HwT/cavRbUeSQD+keeTCC6RNrKKooZP67Lse
 aUT4LinTnWZVZEpqsHTRg==
UI-OutboundReport: notjunk:1;M01:P0:kzq3ag06cjM=;aOrqw4Q7eM/JXMQnMA6uUN8Ykv6
 3XRAjsloI3WghnyORHf08aS8J5cHPwNCUvy32qM1nbfT/qutN1P5uj1zMmVWN4MWRQW0k6hwr
 4M86RiegawhJOytaPBRX1yqTwss52R2D+M+DPQe8h1qa5tFutbHToYy3IWiOGl9bJUy7aZNXE
 FlQaP3yfTSzu5nCpYXAD6h2NhVMGPZIw9bVrofY93EORfMXKlGZWw1TZhCmYcFlznXTtO3JBY
 saGNph9qp2aPj6G7y3uhMLith3u9oee38kDGYK/mXtED6kO4qopwi0HRj16gQK3sMWMr2Y9Gm
 wodAhs4Q1oZ6B9Lpi4+KkF+sHz90EWe1Edu3ZxwjOL33nttOoVuBQPQNweVuyVImgGT6TpsFF
 Vc/YagWRLjoAEOWdVp9JfwsjsXU3D3JfykGA4KNPFFOYSGVrPqJN0NFjRShq4Nbl6uPwYoors
 +2V7nBmNEs0q7hzCexfb54s+IMflZ0ubTRjZhm63UEYIBeI0s7HcbLXn6VrNQf7s8nm2XdmnA
 5vMga7AkBB+URLdSFNdG18xq5B+2rE2ZXQPb9XnS6t15+O7uJNR/2nQqDlV+fch6I/+Y6Gmcy
 5aqfu5H9Y7VrHV5SKT2WKMv+7QPdtY7eJjF1gPgMt8WljjMCJvTmkN4v8Jurkv4pk3yTFnAJS
 OSxEfC4FWG+kV600uJ7ND0MC9MK4SSG8DCk0JT/fBzIGp3wBfNifyviidY+KFlBzcRY5xPjBT
 utyY0zun9kQ26DzaxGoWHJ2N3rlNM46RO3j0eocE89HXQ3sfCW6SVy9h6O6KgNUMsMBKzu+i6
 O08jT5g8UYyTYAV90/ufMglFAuEeMmTWlLAYJdj495pk8slhOMIOesmKXSKfo41r5UbP49pjD
 iMQbLBLzAHfkvPDE2898gA1nl6jo/1McIw3BtCdWa6ZRTAOv8cP8qTLHJuBJiqg/lTksX+TUO
 pz4Ffeug2Q6Qc+81WLbnPMsb5To=
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

The following changes since commit c0c08be5468cb26db597932bc69c4eda1129841=
d:

   Merge branch 'master' of
https://gitlab.denx.de/u-boot/custodians/u-boot-usb (2023-09-05 14:44:10
-0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/doc-2023-10-rc5

for you to fetch changes up to 7314ba2bf8452df68d07f251aa59440de58067b0:

   doc: board: ti: Move documentation from README to .rst (2023-09-09
06:12:47 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/17697

=2D---------------------------------------------------------------
Pull request doc-2023-10-rc5

Documentation:

* move more TI board documentation to HTML
* update TPM usage instructions for qemu-arm
* update the EFI app documentation

Other:

* tpm: Fix autostart for TPM1.2 devices
* spl: fix undefined return value in spl_blk_load_image

=2D---------------------------------------------------------------
Heinrich Schuchardt (2):
       spl: undefined return value in spl_blk_load_image
       timer: document the unit of the timer rate

Ilias Apalodimas (2):
       tpm: Fix autostart for TPM1.2 devices
       doc: qemu: switch swtpm instruction to 'tpm autostart'

Joao Marcos Costa (1):
       doc: Update path to source_file_format.rst

Neha Malcom Francis (1):
       doc: board: ti: Move documentation from README to .rst

Simon Glass (1):
       doc: efi: Update for the 64-bit app

  board/ti/dra7xx/README             |  26 ---
  board/ti/ks2_evm/README            | 194 ----------------
  cmd/tpm-v1.c                       |   2 +-
  common/spl/spl_blk_fs.c            |   2 +-
  doc/README.ti-secure               | 226 -------------------
  doc/SPI/README.ti_qspi_am43x_test  |  76 -------
  doc/SPI/README.ti_qspi_dra_test    |  47 ----
  doc/SPI/README.ti_qspi_flash       |  47 ----
  doc/board/emulation/qemu-arm.rst   |   2 +-
  doc/board/ti/am335x_evm.rst        | 437
++++++++++++++++++++++++++++---------
  doc/board/ti/am43xx_evm.rst        | 188 ++++++++++++++++
  doc/board/ti/dra7xx_evm.rst        | 139 ++++++++++++
  doc/board/ti/index.rst             |   3 +
  doc/board/ti/ks2_evm.rst           | 306 ++++++++++++++++++++++++++
  doc/develop/uefi/u-boot_on_efi.rst |  26 +--
  doc/usage/fit/howto.rst            |   4 +-
  include/timer.h                    |   6 +-
  17 files changed, 984 insertions(+), 747 deletions(-)
  delete mode 100644 board/ti/dra7xx/README
  delete mode 100644 board/ti/ks2_evm/README
  delete mode 100644 doc/README.ti-secure
  delete mode 100644 doc/SPI/README.ti_qspi_am43x_test
  delete mode 100644 doc/SPI/README.ti_qspi_dra_test
  delete mode 100644 doc/SPI/README.ti_qspi_flash
  create mode 100644 doc/board/ti/am43xx_evm.rst
  create mode 100644 doc/board/ti/dra7xx_evm.rst
  create mode 100644 doc/board/ti/ks2_evm.rst

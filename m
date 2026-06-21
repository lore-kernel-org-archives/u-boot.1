Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844CACD98F2
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 09:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 780298499C;
	Sun, 21 Jun 2026 11:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="AP7W0Elv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D52D7849BA; Sun, 21 Jun 2026 11:59:55 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F7E3848DC
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 11:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782035979; x=1782640779; i=xypron.glpk@gmx.de;
 bh=LmBzB8muSxA+l2d3bZRsiVKnRIzl6OtODWGEC6Po1X4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=AP7W0ElvNPkygFuL5IWAF8eSoX4ipZ39ZAA13g7sJeuTcTdBG003P2qKz5wyUjK4
 d0FqCJEI0Lv9buQwVhkyKM/PLihf08h9fZESP7vLe4xsnosC0Jf5rE4u7e5v8oIsr
 N2SajcFsxn6chRSHtkdYeIgIDOHJoNQzOUXBDGGEWmHtvB+8XFPjnjk43dezMrFcX
 zWFebBjTFuU3Vgm49mSj+Zm6uUr6fD4S4vaQ/ZLWpeNci1AKFBAP9PfqDdTx4fX9D
 oKJqnKDIjC7QIwapV71Oz2eJwTuCbeYogk9uUOA5ls2hkrRRwb0lv5CZMPrBbYJCh
 Yw+DmX1qzPvkb5gXQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNswE-1wqhRz2vV2-00NGOf; Sun, 21
 Jun 2026 11:59:39 +0200
Message-ID: <aaa976b5-693b-48db-bd26-6be981757413@gmx.de>
Date: Sun, 21 Jun 2026 11:59:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Denis Mukhin <dmukhin@ford.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2026-07-rc6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X7siHmLX8pAwdxjbHJjsCNnN0xOtAdPXqIF4hT2qHooSxpMa4cc
 W6gAolF8d54BJhUoLzc/cxYTbQsyxR4C0TiYnlz4KEXUhf9GMvnCV27d/p/iEWPG60J3tsj
 qF6rUCMfNFmg4kizvlkIDFluCSXKD1oR7zWQ5w+Eszlvvf8xiomzg7JovcK2mdNoHoo232L
 OA61DO2/eRU6orMGp4g7g==
UI-OutboundReport: notjunk:1;M01:P0:mEyNQBdc+h8=;m23cfMV1LhQ8XohHgPI25PhyDdI
 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
 szZlTNFdGAbMQqK9MT6SU9ZQ8KYQLpttkasM=
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

The following changes since commit 922cf29dd8045f7348ce0f20145f46e8235faf2=
1:

   Merge branch 'master' of git://source.denx.de/u-boot-usb (2026-06-18=20
11:41:22 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2026-07-rc6

for you to fetch changes up to ad90d1ec8b43aa3d7ec5790db5c5740472e47c96:

   doc: android: fastboot: Document halt behaviour (2026-06-21 10:56:37=20
+0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/30505

=2D---------------------------------------------------------------
Pull request efi-2026-07-rc6

Documentation:

* bootdev: fix typos
* board: renesas: Document Renesas RZ/N1D and RZ/N1S as arm
* board: renesas: Document Renesas Geist board support
* board: renesas: Document Renesas Gray Hawk board support
* board: renesas: Document Renesas Ironhide board support
* android: fastboot: Document halt behaviour

UEFI:

* fix memory leak in efi_var_collect()
* set revision field in block IO protocol
* fix guid comparison in efi_selftest_loaded_image.c
* fix use-after-free in efi_selftest_memory.c

=2D---------------------------------------------------------------
Denis Mukhin (1):
       bootdev: fix typos

Ilias Apalodimas (1):
       efi_loader: fix memory leak in efi_var_collect

Marek Vasut (4):
       doc: board: renesas: Document Renesas RZ/N1D and RZ/N1S as arm
       doc: board: renesas: Document Renesas Geist board support
       doc: board: renesas: Document Renesas Gray Hawk board support
       doc: board: renesas: Document Renesas Ironhide board support

Mattijs Korpershoek (1):
       doc: android: fastboot: Document halt behaviour

Vincent Stehl=C3=A9 (3):
       efi_selftest: fix guid comparison
       lib/efi_loader: fix block io revision
       efi_selftest: fix use-after-free

  doc/android/fastboot.rst                     |  5 +++++
  doc/board/renesas/renesas.rst                | 28=20
++++++++++++++++++++++++++--
  include/bootdev.h                            |  8 ++++----
  lib/efi_loader/efi_disk.c                    |  1 +
  lib/efi_loader/efi_var_common.c              |  4 +++-
  lib/efi_selftest/efi_selftest_loaded_image.c |  4 ++--
  lib/efi_selftest/efi_selftest_memory.c       | 17 +++++++++--------
  7 files changed, 50 insertions(+), 17 deletions(-)


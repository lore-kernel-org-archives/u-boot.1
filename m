Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16313C27C53
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 10:22:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77FB98804F;
	Sun, 16 Jun 2024 12:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VMgyq7C8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB4D2880E5; Sun, 16 Jun 2024 12:22:42 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BA8487FC2
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 12:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718533357; x=1719138157; i=xypron.glpk@gmx.de;
 bh=6zZXreGeJzn22MYXdMr6UfIE8+m5tNzdDwqvBugz1H0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=VMgyq7C8sTHP62eSIPHLj1xo+R/Oyn2/Z+EzJ50zMGwTMylD6P47+XDt5+ZaE4IX
 eBy0uzs3CfBCZAAlh0hj12ulHfwJwi5ylEmgh3tuyMUItCzpbALXJJuEmwJWSeJBG
 HD3oVbdKtOhVAA8CrBBcVfxx9ICQSy1KdPJQt0gYSM6CO24j7FUCMOqf78I6U/Cpx
 XCHHCLRamLEJVYYVexyp71GQNewQGP1qR/hrB4h/ICaZMDAnoU2BzuThlLvRRbkQX
 DjG3xTytG7KU3A+uezfeCC4jgr6A8nEeq1czROjx89QCV+OpQ3YXz+UsJj5RvekfL
 oLat+XqlQGHn7/sh7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.41.25]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mt757-1sYO2O0g4f-0161AH; Sun, 16
 Jun 2024 12:22:37 +0200
Message-ID: <b7a5261b-f94f-4d72-a046-09b0e181ce4d@gmx.de>
Date: Sun, 16 Jun 2024 12:22:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Dahl <ada@thorsis.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Schultz <d.schultz@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2024-07-rc5-2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wmhqZRBKh8jbHwhUhfSJCZFG//LKa5XAE147nK6GAsteeDv/3o0
 +ilpXN0oFZICBubbCb+JPsQl9NM2k1t0VMkzSoBlp2IuEYCgr75MWa/LPl7apjfRDedHIku
 Wj7l5VXO1Zor8R8O2lAg1+8w1kpjU48h1sgPrA2D1G3ALvXMkejdYvvSat8dYK0bZxSAWrM
 j39Thoan5gxdcvs0ZkcXw==
UI-OutboundReport: notjunk:1;M01:P0:d8Opl5ht+dU=;4zsxpqDAYbWkG9C815HMAHqupZw
 Eo3O5R5ZlPQh1PQklxsW6lNvlI3loX845CnmgElhQL3OX774/wr0KdVl0790LNzaQHdz2muYf
 6lVeC7lDI/Igb7Zz0aaz1oqhCICDgE1IL1dMvBt3rUIFf1XXeWPRhUQpW5Fwy9fNQKj0uPeE7
 k92cl+ByPXfbUTrTKKG3uzo8ubo3wisgjFDatvAAOMxs6636cQpl1VIZV7c3cS7X9kRFCcZk0
 7CDji5S14V1pc1RPDqB40EdzzqUX4Qwy7UOiHNHp0KWPBV74D4QY8bfJ8VJULm2etF9a48TrA
 RoCcl6Ys+zHZO6lBAq49llx0W1ek05Vf7DoiRelmIJC2EBxX67t5xqxHSwhto7g6b20w/EQg5
 vUha3MeceIpbHWfZc5WC1qMvz5EfAL0kngLA+LVJmp1ILjwRX3YcoIVrT3NbMRqc6GpdQ58gr
 bpD3gF23q9BNE6hBkYW4AI/cDNUFuVSyDSjiw+BLJJNSwemTiKgmxHQSPcQEDPF4fxM21kFyh
 Ml15xzgabdbvmsh2Jx7Itz/nFaeNnbXYmSC7H0PkuwWqYPnAcIKRFg/Xa9aUWeHtDutQXGB4B
 EOeWhnz1Rcu2uGF8BBIP3y6Iwol6wfCSCSznCtJ7oHweZT6NTc9SJHxQ+I3/NoIjm2PB38cKL
 BCv2T/rTxYVn36VNu8vikvjZFcHlAWuo10GubddxFYTn2AOJlwxN5XQWSCsnizgF1bSzZysx9
 j8qsdxNsxkD1FzIFqX0Ig4E9OAyrxRY9V/CZQx00H50rYvADU7fCvUsY2kNJEalp/nGWnygbD
 isPtXPeBst9puBOfz1nRln9eD5nwn4mORvSizn91hr92c=
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

The following changes since commit 2248c96ea1cf0b65377040d9f87ce7d8cf534c6=
3:

   Merge tag 'u-boot-stm32-20240614' of
https://source.denx.de/u-boot/custodians/u-boot-stm (2024-06-14 08:13:54
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2024-07-rc5-2

for you to fetch changes up to d1499a8b3fa30e4d835a139e958fc7bec96af412:

   doc: Fix link reference to general verified boot docs (2024-06-16
10:37:10 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/21141

=2D---------------------------------------------------------------
Pull request efi-2024-07-rc5-2

Documentation:

* Correct links and board names in PHYTEC board descriptions.
* Describe UEFI measured boot.
* Fix typos in include/bootmeth.h.
* Fix link reference to general verified boot docs.

UEFI:

* Measure device-tree into PCR1 instead of PCR0

=2D---------------------------------------------------------------
Alexander Dahl (1):
       doc: Fix link reference to general verified boot docs

Daniel Schultz (3):
       doc: board: phytec: phycore-am62x: Fix Link to Documentation
       doc: board: phytec: phycore-am64x: Fix Link to Documentation
       doc: board: phytec: phycore-am64: Fix phyBOARD Name

Ilias Apalodimas (2):
       tpm: measure DTB in PCR1 instead of PCR0
       doc: describe UEFI measured boot

Mattijs Korpershoek (1):
       bootstd: Fix a handful of doc typos in bootmeth

  boot/bootm.c                       |  2 +-
  doc/board/phytec/phycore-am62x.rst |  2 +-
  doc/board/phytec/phycore-am64x.rst |  4 ++--
  doc/usage/fit/signature.rst        |  2 +-
  doc/usage/measured_boot.rst        | 35
+++++++++++++++++++++++++++++++----
  include/bootmeth.h                 | 12 ++++++------
  lib/efi_loader/efi_tcg2.c          |  2 +-
  7 files changed, 43 insertions(+), 16 deletions(-)

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B44EE49AB
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 07:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72ACE86432;
	Wed, 23 Aug 2023 09:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="E78Uqr9+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1584864AB; Wed, 23 Aug 2023 09:04:24 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82BFC833DB
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 09:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692774245; x=1693379045; i=xypron.glpk@gmx.de;
 bh=+Vka7fdS+KHusLg40264pPBWPi01GcVTFHqkExS3URw=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=E78Uqr9+8/Nrr8EQ8NPURyD64dmZIb5Y7jSpICjaXCxoPKWoVln5zn7QJmiPBVXQLRSXHeY
 dx4LLtn5vU9kqdeZ0tcmnCMODbZZKZtWWJmc6ecADrGyLDCFzZt0b2EtAsozDpE0DyaG4pLkq
 ynVYqImsc2C94M4Z7fX/KRTa+9u2ywdp5mcbOncAfPI6Q4vkHoutNXwIR76OrV59dryiVt7bc
 OTSJEGbUQilfdYmTwIOH9RBSKxPAIg6g4vLXeq8ltBdGg58v+GGs5cZjsnCL58WhcjMixHLo8
 PIeiGZqWtYKdc3ho7+H6O8BAq5ru2yK54T7fgE2NqrD9yYvYDj3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRTNF-1qKDIW2eRx-00NOgL; Wed, 23
 Aug 2023 09:04:05 +0200
Message-ID: <fbe36d84-9e06-3f2f-9a5c-b1a6f4d32df4@gmx.de>
Date: Wed, 23 Aug 2023 09:04:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jonathan Humphreys <j-humphreys@ti.com>, Nishanth Menon <nm@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request for doc-2023-10-rc4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:34/LaD7r95Cc3gTEH9MEbI8Zz75b4ZS5hSA49vRr5R1RizEu55C
 KvYiyECbjra4aurrUTIJn6e52MMGNKlLHe+cbHU016hDTgoxWlg7lg02/1xACxy8wJQDTa8
 TavelljzFUG8wpfT0NcrrR4z+hefcdkDw962R1LBvNGjtHFm4w5h4o9rMKR21Ym9TaDIuWA
 +aAE42yH2WZ2+DM2Iy+8w==
UI-OutboundReport: notjunk:1;M01:P0:g0eg2oDYA7U=;oEbF/KxzfjfBVjvNv5YpygWG42/
 zamMvrRZsk/AYVQk8OoNH8WG2+J5KD+MspjJnDBk9G27DoX64WNKXaTCmsmcb31JUBthc/TOI
 qpndleGWBOQdDLtpm/MX6q3+8VG/+LV0EvAGIGj+AWnGyDtW+v6DJoLqWDvmk51vRaeM4HZbl
 PT2i9AiFQ2brPulmZyAgi/hk54ipQwEKyfgGpYzJD5L5qckm/XqEESRU3QwEhoKs+tYrULueN
 al/lcamDBxuHdBSnV4SfQfld2RopFL4K+lyXmQOKvzs06iHe+qbsVCUcBf6DPazRd2EcaU+lx
 4GbNDd8XgOBksgMkwoExDtn8k6cnvuoTinm++Rf6lBG2Xi/3IQZVSea5izIYLcQDJQ1S30TVe
 ktmPka7B+T2Dsgkfur15Idf264TVnuwgfoeNn6OAI5Og9qD0ndK6MVZlT6VBuWEZpO7qFxqFf
 4FnD9KDKoPhknBIQPwVG3Lxu2bJkELN8OGb1HvcWlPHNynOy3DLIKv04/0bnVDUkj0YB/YM/N
 EEsIGE6vWeY2NMnxcKlwQBtxbWC+P0wtrkdVdPxvY6TR/QyaXYPFRsLsROd1D5wnOMvio3V4E
 GjqIWkmpoPgf9IMVDuYmXR/GuS1b6ejo6p6soyunMynb/QelTIZFy1C8zR3wPLG/1kcJIXI/H
 9dihAt/S60FixzrJoRRqe0H9FtMcLLSnpuF5DjUVDo0chMMuvQdu0zaSlRvTNRd9xuEa+cVYQ
 fTZ8688GSSq7u6K+wiDCg2chAlch1lqetLkdgkVCuj0126WCazP19vG0NkVxoIcTmjvuP1pb1
 ZEizjziDkKWRRe2+jKfgGFQDI3PgWg7nEwWjZ12H8OUJU05DNxoR7oIX3csPsTb9aAKoIa4VF
 0SAR6voo/nGcXMPiSDtTjAUugk8kONvhcXajo5VU2egIdcJlqhEcXGkdfkcEvUFjYWOlQqwuk
 Jj/Glg==
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

The following changes since commit 976fb2ffa3875a7bed9866bf5cf939a81c423ef=
8:

   Prepare v2023.10-rc3 (2023-08-21 16:19:59 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/doc-2023-10-rc4

for you to fetch changes up to 4e73b0153cce064e10dee4722cb2b6833361c227:

   doc: Highlight the most relevant u-boot talks (2023-08-23 08:03:00 +020=
0)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/17486

=2D---------------------------------------------------------------
Pull request for doc-2023-10-rc4

Documentation:

* Fix documentation for TI boards
* Describe running on VirtualBox
* List build dependencies for building documenation
* Add references to U-Boot talks

Other:

* Fix error handling in the setexpr command (printf_str)

=2D---------------------------------------------------------------
Heinrich Schuchardt (4):
       cmd: setexpr: fix printf_str()
       doc: board: ti: k3: image alt texts
       doc: board: ti: am62x: provide image alt texts
       doc: board: ti: am65x: provide image alt text

Jonathan Humphreys (1):
       doc: board: ti: k3: Fix up OpenOCD references and debug info

Nishanth Menon (8):
       doc: board: ti: k3: Fixup alt text for openocd sequence
       doc: board: ti: j7200: provide image alt text
       doc: board: ti: j721e: provide image alt text
       doc: board: ti: am62x: Fix build step numbering
       doc: board: ti: am65x: Fix build step numbering
       doc: board: ti: j7200: Fix build step numbering
       doc: board: ti: j721e: Fix build step numbering
       doc: board: ti: k3: Elaborate on various firmware

Paul Barker (2):
       doc: Explicitly list build dependencies for docs
       doc: Highlight the most relevant u-boot talks

Thomas Mittelstaedt (1):
       Documentation extended with specific information for VirtualBox

  cmd/printf.c                       |  6 +--
  doc/board/ti/am62x_sk.rst          |  7 +++-
  doc/board/ti/am65x_evm.rst         | 18 +++++---
  doc/board/ti/j7200_evm.rst         | 23 ++++++-----
  doc/board/ti/j721e_evm.rst         | 21 ++++++----
  doc/board/ti/k3.rst                | 31 ++++++++++++--
  doc/build/documentation.rst        | 11 +++++
  doc/develop/uefi/u-boot_on_efi.rst | 84
++++++++++++++++++++++++++++++++++++++
  doc/learn/talks.rst                | 15 +++++--
  9 files changed, 180 insertions(+), 36 deletions(-)

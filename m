Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AF0C54E66
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 00:19:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D83DF87E1B;
	Thu, 14 Mar 2024 01:19:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XVyjm06X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 614C087E1C; Thu, 14 Mar 2024 01:19:55 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5712587E0C
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 01:19:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1710375582; x=1710980382; i=xypron.glpk@gmx.de;
 bh=7RKwHnPcSp3M47ykbBh8H8EAdGYhyGxi4MD6fSWrXso=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=XVyjm06XNKXAGOybKYXP7bU6NhFKNZe0hn9CdXQnlex3TVm8jlDeSFnututQYH8y
 ljH7d1CVwxW5TRAaejlX8lHjkcCO6na+O2vSHXr/KKaKmOdbL0+N2hq4/m6nLtnjt
 RlFlfs+RX0k+HoiWJ+lmuUSFjHYwoLcewh5mG/CvbYoqOte1WOQBWfQiu+iNgx4RM
 UQLsOtqM2g2XKyGs7OfxIT5R3c7AZ80j2QUoQyoBypn6zpLLnn1MuaruzZa/7aYj6
 UwXLpvz2Cxn7WhFREN5DDDKlukJnoeZClvdNoYY9aBWiaB68x6d9pownQawUFMoOS
 I7ZBZ5HfSTO+fBPX+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhQ6-1qzSMk0DlU-00niq6; Thu, 14
 Mar 2024 01:19:42 +0100
Message-ID: <792febd8-7372-436e-8720-3efeb8d66b75@gmx.de>
Date: Thu, 14 Mar 2024 01:19:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexander Dahl <ada@thorsis.com>, Mark Kettenis <kettenis@openbsd.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2024-04-rc5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YbF2+iu1aN4o2FagGDv/rAKduVDaglY8alo/6JC5PlZT3HSxUON
 /K1ojuOmnY97v9pjEw1I1vR4PZDgnp+m5bFEiw+cPltiQJ5zFOYaVUxxfVa/lhN1WqWzB5O
 5ShXaawQ8KZnXHpN6414i4KR2urviWsVztrHqYJnENSsdNWVbRvOjVWrkXXXAeOWn19Ngs2
 RIFzjNIfRusqDw7nwYf2Q==
UI-OutboundReport: notjunk:1;M01:P0:j+r6XZ28lnA=;3Cc5KgXNLg8tt5cRw/X046MYhB5
 2ctY47ZKNN+QNrTASeGYoquKhnUdDFuZbPoZupqFWbDqeioosZGHpplbbuxn7R7pcBCmOUx8W
 uBHIRfv7FgrLTRcz+g9EgZY45rXDTvHzQl4yN1jbPkKKnMRTNQa1RkGlVcgU1Ci8dCJt87eGa
 H3ahOXUMCmU8/MCMKtaTzY92S5H72ILA7OZ1PHKq+CprzL471kcncHlGpbonCGMtkImFN/owj
 M9JbAc/shlzHJg424vtJ8mq01R/BgM8vbfSyA6TNXGwB9PzIWAUWDSCd5Ctu6/H6A2L+aq0rm
 BHkNt4qJ3/Cj/mWqDCikmeZgkN2aHTDLzj5Eh5ffhzBw05W23WxlL9QhNMpVZMAUX3vyL5FKg
 ir1hu9+kXCYXbTqMsEOW/m5+bjjy7zIEBSZeblrG9KypJw26MU4mHJR/NXXLPfp6siAvqQDH8
 wJzC6fHQdYbK5toj9cOuHg7OhN6fdQtquSeXduUbP5Qts2mcW/giqvKH8b7g4a2hY/4vfe0vb
 r+/0cVwsiS6kHTxlHVmmqY+h9j1yWwvttD/VFzkGqaOc+GQClWozddDtDkLGqQvJC5rtkUKQo
 6Ru4U0QFPYaRaX7pduqca1aWzD/+/H/DqRmnl+5pYgXc/S2AFf9yJWID3CGFYdAgbC6p08rPn
 XlfE1gxcqvBmcMw49ts2AyHKV4ytwKKmx6cnbLdhdX43OA/m8i1pR0Fzopj0+Kzcr10I+0rj/
 IXLA2x49QQ6wdhAIw6uB/afEj0+sMm7OgHx4eqPqhpp3Eb+noE4Pzcm5j2suLyu53ZPJpQY0G
 WGsGsYHcG9tFQ4G8a/UuYMdnAm4hNKfrEa7EBM05uuToQ=
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

The following changes since commit f3c979dd0053c082d2df170446923e7ce5edbc2=
d:

   Prepare v2024.04-rc4 (2024-03-11 13:11:46 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2024-04-rc5

for you to fetch changes up to c8a2567475508156f4f43ea2caf3532790d47f8e:

   doc: fix incorrect path Documentation (2024-03-13 08:16:16 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19917

=2D---------------------------------------------------------------
Pull request efi-2024-04-rc5

Documentation:

* fix Python string escapes
* develop: commands: Fix function prototype
* fix incorrect path Documentation
* fix mistyped "env flags" command
* board: phytec: phycore-am62x: Update artifact names

UEFI:

* Invoke ft_board_setup() before efi_carve_out_dt_rsv()

=2D---------------------------------------------------------------
Alexander Dahl (1):
       doc: develop: commands: Fix function prototype

Benjamin Gray (1):
       doc/sphinx: fix Python string escapes

Heinrich Schuchardt (1):
       doc: fix incorrect path Documentation

Mark Kettenis (1):
       efi_loader: Don't carve out memory reservations too early

Thomas Wei=C3=9Fschuh (1):
       doc: fix mistyped "env flags" command

Wadim Egorov (1):
       doc: board: phytec: phycore-am62x: Update artifact names

  doc/board/phytec/phycore-am62x.rst |  6 +++---
  doc/develop/commands.rst           |  2 +-
  doc/sphinx/cdomain.py              |  2 +-
  doc/sphinx/kernel_abi.py           |  2 +-
  doc/sphinx/kerneldoc.py            |  2 +-
  doc/sphinx/maintainers_include.py  | 14 +++++++-------
  doc/usage/cmd/env.rst              |  2 +-
  lib/efi_loader/efi_helper.c        | 11 +++++++----
  8 files changed, 22 insertions(+), 19 deletions(-)

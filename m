Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660D9CF9C5B
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 09:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B5F2882EF;
	Sat, 21 Sep 2024 11:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="twtrswiy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A50A888413; Sat, 21 Sep 2024 11:35:28 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 505B288279
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 11:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726911325; x=1727516125; i=xypron.glpk@gmx.de;
 bh=ikqijNkdkk+KyPLeSyAVy1ZL8IWt5hRD5MnMS2fky2Y=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=twtrswiyihdy1MyWFH528+N9TvOil0QV2ImMINAxUBfbzjVx9ySkOZUXUq9dkhE3
 HuCEzxLp5BNItGDwZE/ItqoBRyH07CurvRfHrls7xv0z0qYBG4sPyqKlTLwQ/LuBM
 yjC2juW9+ddgYU238b0fU8XCLRwmgseAZ8OdKL7j2OJOCbgKbisbporqSstht/FHn
 cm0e5ugV0swmPoqbukmlDlePW8Dj9YislwwPq1kF+LbVqfK2K8Hnh+lIo9vchC8DM
 Q9sdPmnY0T8h38xmTELy4uCtdxz64w3ozb0NPfc7/NvVqIvrZdQUlwKCjRLQSTMLj
 N2lxy9niZsHCqbOWFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.104.110]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8XTv-1rwy9k0zWz-00uZFM; Sat, 21
 Sep 2024 11:35:25 +0200
Message-ID: <00131229-9bdd-45ba-b4a5-c674e1340eab@gmx.de>
Date: Sat, 21 Sep 2024 11:35:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Thomas Perrot <thomas.perrot@bootlin.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [MASTER] Pull request doc-2024-10-rc6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NOP4fFHwyo4s21fXqvECWF+KQA3aAgVvoZspvPR6Nz6WH9Hy6bj
 RpmhszwyBh7d8xRYs66++0YhtCgQikTs1AWomN8v+eq5L1UftdwH8MAScvR/ztEmUcV3P3s
 8JkRAeGUCVExHbNVtFEZSEujJv1itJhF593veFAXQ1DbxxrexxdBohXLpB2tWY1eCClvB2h
 hbNon0ZMIx/spxLQcJ+kg==
UI-OutboundReport: notjunk:1;M01:P0:YBWQeD5R41k=;+QlowzpTay1Kwr25gjtFIczhF8y
 C3S1tHko9Suw1ZMPIfU2MeEREwL7u+fwNbZIHWYMJBGrXloBXQtbk00w2basgcylqUrhU3cH1
 2Fgft5i7F7Rnxe35THRpnKfnN13Yf0bBENo9ejm2Z+Eef7/uolm5K7yYekkrIg5ojRJ36jQOM
 tL7fzEN0dslm5sisC3o331zS6F++cXF0BCwFbWVUZ0lut0LW5CViGwYnHCQsPd1C8V2drt1Cy
 J447tSz7nU4i4ei6sThQadEJm9W/hbBUTzLlT+gijjn4iLhZ2tMa9bbIwaYbTx26re35sWc06
 Ueh7KObMgT1cXoRCkdwgLov+k7msCgmkaCMjrRlQR/qttfAmhpgC59JJ36hx9f+4iM+rK4N4P
 UV+BiRm/giGM5YMkPhZ7V2cD3HHy7NihjDYngs1+nDfrnzJ4Z3ACIFvUYF93qu9MAFvgPyxjW
 y8bu7fy83LQIwfITmHXPujkHROMmvZRUGCG7vqxRjD5QUVGCQ4mf8jieAxayw937G0FJ1oX2T
 GLSAJ9MkcnlBUcpfAuEV36zAQ68PqtKs+lYf12+9dKvASCoXPmnITMyZtZaHAss94bz8m+O3Y
 viHKbjGFBxqjB+bIy175BeW4dgJSPr821KB//IPVdhnsmXUBjJ6DjeiUvVDLqv2vG2Ws6Nnix
 dRYumUDdLdSe0D0z7Hm+/OcBuNDUnhILBfe+cJLMVyeodV89pDJHdoZTH3VTq1tPYRVPfpDCt
 zrreya/nmfplyHgaBdg89z0Fm/RcMbmYhMnLeDtpa7SJktAMC7P2ucS+XlHZjDG6IJDuFUt42
 jxkONv/3nOeDqE4V0rTlHSlg==
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

The following changes since commit 91a7927aa6679d1a3ea30ed9dfe17002d11bcac=
4:

   dts: beagleboneai64: Add boothph in chipid node (2024-09-20 18:08:34
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/doc-2024-10-rc6

for you to fetch changes up to 7803a66399381570dae5cea030b01b26cd5ca676:

   doc: usage: cmd: ums: fix dependencies (2024-09-21 11:22:42 +0200)

Gitlab CI showed not issues building the documentation:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/22388
https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/904189/raw

=2D---------------------------------------------------------------
Pull request doc-2024-10-rc6

Documentation:

* Correct function descriptions that are not Sphinx conformant.
* Correct incorrect dependency CONFIG_USB_USB_GADGET in the ums command
   description.

=2D---------------------------------------------------------------
Heinrich Schuchardt (7):
       efi_loader: fix some function descriptions
       cmd/efidebug: fix some function descriptions
       doc: include/getopt.h: remove comments confusing Sphinx
       efi_loader: correct efi_set_variable_int() description
       sandbox: fix OS function descriptions
       boot: correct struct expo_action description
       events: correct event_uninit() description

Thomas Perrot (1):
       doc: usage: cmd: ums: fix dependencies

  cmd/efidebug.c                         |  4 ++--
  doc/usage/cmd/ums.rst                  |  2 +-
  include/efi_variable.h                 |  2 +-
  include/event.h                        |  2 +-
  include/expo.h                         |  2 +-
  include/getopt.h                       |  3 ---
  include/os.h                           | 16 ++++++++--------
  lib/efi_loader/efi_console.c           |  2 +-
  lib/efi_loader/efi_file.c              |  2 +-
  lib/efi_loader/efi_rng.c               |  2 +-
  lib/efi_loader/efi_unicode_collation.c |  2 +-
  11 files changed, 18 insertions(+), 21 deletions(-)


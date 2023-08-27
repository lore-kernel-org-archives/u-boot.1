Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12340C83F11
	for <u-boot@archiver.kernel.org>; Sun, 27 Aug 2023 07:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ECF984B20;
	Sun, 27 Aug 2023 09:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Q9LFnDfK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B459684702; Sun, 27 Aug 2023 09:54:36 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC8B380726
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 09:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693122870; x=1693727670; i=xypron.glpk@gmx.de;
 bh=cuq0fb2xyqq/ab5Z6mlcioP5AebhoUq9JzwGHHsZL9w=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=Q9LFnDfKVdI6oSYe8FsVFXxNJENTm++TpXHIVLNJDZfsMxYrUIXJAH0htsS8RxI13qwuVgb
 FEpqSVqbzcdmQ90rbzHCvYeS/O82/f48FY2ExAQ0zRwVJAeegr/N/zFRYj56eF24OC1x6QZ0G
 eyY9/Ps5aJajGB57WMWm3WvSOk8TeHhxXJh+7DKaWa7Ia2qjjE3iElTWmkt5ZAHFuoe+HKrjR
 0NwG/ZKorkd4lM9jy1okBYWh3K6K4edTBk8eVKujd3kk3JIj1A96NdyDh4dXEUduaYYFblsZZ
 aba+ytWQoCS602tTx6/C2C6MNpFvVjoWuvVpvGYOydXd2mncPYFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17UW-1pY4mi1Zl4-012XtX; Sun, 27
 Aug 2023 09:54:30 +0200
Message-ID: <808615a4-ae31-d15d-4d90-b58c5bf86c3c@gmx.de>
Date: Sun, 27 Aug 2023 09:55:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nishanth Menon <nm@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2023-10-rc4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BeUO92ca90rWq9R+MaqJeJqFa0cVvwkxeUOyHVLbXPHzMUDcxXb
 TUR9+9Ga/1v1rDmYRNppKKpW3jXgbkHJzA4M+tN3PMimvsY7PJWDBsgircf1VQyTI+7foTw
 W9pN1zfTfOKRgMbBb4NUu4VcLx66Enw4oLpy2LMUOmU+bKV3X9ppzRNqwkZtFZ2/PkiOEQj
 iV6ThjStquEuZiNVHkMeg==
UI-OutboundReport: notjunk:1;M01:P0:BHvtqGfNOL4=;ahVLyOKwLxO1PTYZ2/F6YVFmRVw
 NFsmzu68lU68TxHjfnR5is/rjAIBDpcajbHAhzCn+PLB57+wbS+aVV7433qrhJeGQHKOtu8JB
 VUrhfKHQJXotLguoZpENU+LphyFkWhFCm1IX6JM2sevFBDHt5st6drFwiGUZwpne4WwCdsDNQ
 v/pv+bY+XSoRoL3ckYQYaljNOBbFD1accGJJ7WjFTaBEN5+2ZlTimVWBeuQh2NC3wnavfRY6t
 Yvvr/VPc2WWy4IkBNhQ8sezYPkFO8u1bnpjK2JVIaZE56q3/6PfXGzXXgSGrp2BpJQ60OCiAN
 rMMXovjQeLOrnxrzQeZ3wIqfVbQLozKLeEPDAGj9EAdcmiX47FMxvZgbcihfB6Le9gpymET3X
 fdVOTCkpocBVxGcQSHtPA4PFF0L8R5akrB36V9CO5AhaG0mArfGGhV+jAx0EtsGRx/yTovinT
 Xv6uDaVs2nanptAkMIFvohKKFquMGMxFp/6z6hIJIvBDgobCUkDGBJs81vcw2RqjorwvsXmxy
 afORXf3Vn0pESPGk+Yzbw4JPAd6HGDF+AIiNRjxpYuB5So4EHMhQBsvwBeJJO8lbjPRx95MPR
 mI0SJO75X80B5spr0MWuRWHG/64ltM9bu78ItEB1AUBpoh+3X6cOSMs/JtpP3gEQwTBvHw8wD
 t5GZ2YkFPHU0AFidD68hq4Lep/njrzZPk9wBKy1fS2/SsBQuEDk1rlGpABpGqoAE8nop0gHHq
 Rnqac0IYS7pfeBEg4Nir2kUcma6MMBaAJQdGQsIjftZUGJCtG+2D6rKIP8CHtDbyQrvtGlEce
 TZRrPTI1daa1K5555CTKR4uOzuOsViUZ6umPESTEADD7UazKcTwVSP7XbCfKCPEvsTYbZ/p5+
 4HTGQMRtPFTRoa/uaOZcG6sYc7ClfUI73m9m9Tk9C74RZZT1hSjZ6/XmfO8QS745imLY76K9C
 Q801NIrhDybPnPEmgRPpdvLXYos=
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

The following changes since commit e508b930021168c788f14977fc101ccc1151b3c=
8:

   Merge https://source.denx.de/u-boot/custodians/u-boot-usb (2023-08-25
10:52:39 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2023-10-rc4

for you to fetch changes up to cc889bd0754e50a3cd50e8ed3094388480fbec86:

   efi_loader: delete handle from events when a protocol is uninstalled
(2023-08-27 08:21:08 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/17537

=2D---------------------------------------------------------------
Pull request efi-2023-10-rc4

Documentation:

* describe TPL/VPL/SPL boot
* Add support for sphinx-prompt and convert TI K3 to use it
* board: sdm845: Explicitly add boot.img flashing command

EFI:

* remove handle from events when deleting it

Others:

* fix gpt sub-commands setenv and enumerate
* add a parameter check in hash_calculate()

=2D---------------------------------------------------------------
Heinrich Schuchardt (5):
       lib: parameter check in hash_calculate
       cmd: fix gpt setenv
       cmd: fix gpt enumerate
       cmd: let gpt_partition_entry be hexadecimal
       doc: describe TPL/VPL/SPL boot

Ilias Apalodimas (1):
       efi_loader: delete handle from events when a protocol is uninstalle=
d

Nishanth Menon (2):
       doc: sphinx: Add sphinx-prompt
       doc: board: ti: k3: Convert to sphinx-prompt

Sumit Garg (1):
       doc: board: sdm845: Explicitly add boot.img flashing command

  cmd/gpt.c                     |  22 +--
  doc/board/qualcomm/sdm845.rst |  11 +-
  doc/board/ti/k3.rst           | 112 +++++++--------
  doc/conf.py                   |   2 +-
  doc/sphinx/requirements.txt   |   1 +
  doc/usage/index.rst           |   1 +
  doc/usage/spl_boot.rst        | 321
++++++++++++++++++++++++++++++++++++++++++
  lib/efi_loader/efi_boottime.c |  89 ++++++++----
  lib/hash-checksum.c           |   6 +-
  9 files changed, 469 insertions(+), 96 deletions(-)
  create mode 100644 doc/usage/spl_boot.rst

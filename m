Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B930FC47422
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 11:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 766E4875B9;
	Sun, 21 Jan 2024 12:46:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="AkhgVCx+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4BBB876B1; Sun, 21 Jan 2024 12:46:08 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32114874BA
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 12:46:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705837563; x=1706442363; i=xypron.glpk@gmx.de;
 bh=P6cMj36lnf4xl25l3NpjdRsb8ht1Tz9FG6SJDXqQz4U=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=AkhgVCx+7Xa/j+uEYGmI4tyvr2M61Nv1ZX3dZ8E/Oku7ac4aM74epo/uTbtXQfTA
 EAKybR6cjYA8H5dYQe4xl6GemTKT3CrfO3Ci+VFDkOsSoNUXstBJP/W8RF9OUFv2m
 3idRPo9F/PF3p1OhpisC10H1xHxPoKuSdisWA9L/FSyLSN5ekqL7tpfZDVLTQFrm7
 RiN5xoGpq0V7ywwkE9GDWXBnafKLIZaVKJCQ71Tk0yF97oMeV7DkASt58wdIUOI3u
 sz5LK6qzHDLZpJI2hh4og6z0yBkpvUWw8WV2M/ba0ZeIC9F67WzNcZoYIdYDY7ZCl
 SYs9t3Sp7JkVK0MM4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33ET-1qxnXC20CL-013P7X; Sun, 21
 Jan 2024 12:46:03 +0100
Message-ID: <37dc396d-7580-4373-b8e7-561a8f7fdca2@gmx.de>
Date: Sun, 21 Jan 2024 12:46:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Wei Ming Chen <jj251510319013@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2024-04-rc1-3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IUUEmgqb92pjYTBoBi4b3hP15D8Ra58oq3zjM6CHTuVVFkOIqco
 ltHXSJtOVV2MMTMkjgpebrpYZKMLGcr3/csCm0/PjdaAjFjq+TFXWfbcqJ+GDYgQw36E688
 Mc97XGW+AsNNORLIclkRi0jxYcyhcvjD/vJ4IWPCQ1cLTDP6iOAv3LtbfIbLEtb0TzSUJLr
 zU9R9wOtM7DO5eUdeRahg==
UI-OutboundReport: notjunk:1;M01:P0:owEKdFSuuZY=;MZhnBXdM7wQizbTKB1XY0uGTaOu
 iq1Cowsubzvgx6l/JvtucsrjtakksILJCdpn/SlMGRVoFMqCbaVGmiHrxfGKI1ErTmDsc6z0K
 7xUsukqUiWz9+NNm3nnCELclpGmoKx9RK8lh+nnr+wVqCyByb1vLsCF4tNKHKftPCGqd8z/Jr
 zR7gkWJWlJCZGPJH8qVeOIFKlUhZl/HVPtX9tmsyoCLcqKfmUgfhzb2SrTr7Hne+h6gqHxyn7
 bqpGPK0o1T6AVD8zgS1uiIdO2cIn9lF0FYUGiNDniSg8tuM/Ik+NEZ+a+14GhqylywWYADQ9f
 mrtcLVd1x5rI3VQ5RWe8biVOx+Y9uXzm38XK4tVFhg/5YknJtLRLW/lozC4CcHDhMGecw6sMM
 8IgODEzfCRSptDz65pi517ZWXvxRzU2MsNEyvwDVCOLVAMCabwfM3Clt+MdoZf6q8Yv7iSYsL
 6i23Yep5W9SwkTYX24tkTblUHM1KeWBniog404yAb4lMwJdxhqU3vhvqIAcxRg3zZetRtlWba
 wnXPbdcVJi3rpAf7HSV/D6RJY5vnwRUOrSGN1eYZJu8GdfcpCBAu2NLXwVEsn2WLTmJHhRj57
 h2B+ZHQ/c8Ipva3b/skLlyYh3ok+z8imw9lpk6TLa1W38vCVRClLjv5qjoQ5r5eMJxmtbD/D+
 soGvrVICbF89a5kgMe1449aqYhYCG6ZNkdvBthOA+4C1gkjePiSdewb91e4z7fDKyIRACGnnp
 Uj47QiznqjviBXRtssj1fB42c3i5LWc7v3tstE6Cl9tg+Tv+jBrE9oWT/ELcymClFXVmKBPgg
 2Hf4ASOKel5hLxXz53M4AzYDrhePnX9sj2WwokO8RL0nhd+YwNQmo4P/xxWVQmeLSbdgAn9zG
 JAptYcf0w7VPZZuffDnPhQFGVkSS+Uy/ta5RGPgZF9osFqqdGEVWc1uB2E/45/zfEmWGs/Pto
 QLvwiA==
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

The following changes since commit 3c04fcf3137d5f694d52b8f355373e4baabe5f7=
8:

   Merge patch series "k3-j721e: beagleboneai: Fix USB" (2024-01-20
11:39:13 -0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2024-04-rc1-3

for you to fetch changes up to 2c98f7435cc5edb2a0b96e9f398c0b7f084e83cd:

   efi_loader: return immediately in UCLASS_EFI_LOADER removal
(2024-01-21 11:24:24 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19394

=2D---------------------------------------------------------------
Pull request efi-2024-04-rc1-3

Documentation:

* correct documentation of part_get_bootable()
* remove duplicate word "has" in UEFI documentation

UEFI:

* rename check_disk_has_default_file function
* auto-generate boot option for each blkio device
* auto-generate removable media boot option first
* avoid pointer access after calling efi_delete_handle
* create common function to free struct efi_disk_obj
* return immediately in UCLASS_EFI_LOADER removal

=2D---------------------------------------------------------------
Heinrich Schuchardt (1):
       part: correct documentation of part_get_bootable()

Masahisa Kojima (6):
       efi_loader: rename check_disk_has_default_file function
       efi_loader: auto-generate boot option for each blkio device
       efi_loader: auto-generate removable media boot option first
       efi_loader: avoid pointer access after calling efi_delete_handle
       efi_loader: create common function to free struct efi_disk_obj
       efi_loader: return immediately in UCLASS_EFI_LOADER removal

Wei Ming Chen (1):
       doc: uefi: remove duplicate word "has"

  doc/develop/uefi/uefi.rst    |   2 +-
  include/part.h               |   4 +-
  lib/efi_loader/efi_bootmgr.c | 141
++++++++++++++++++++++++++++++++-----------
  lib/efi_loader/efi_disk.c    |  52 +++++++++++-----
  4 files changed, 147 insertions(+), 52 deletions(-)

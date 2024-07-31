Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76B9C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 08:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FE5C88970;
	Wed, 31 Jul 2024 10:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="bBG1SJr7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F23258897A; Wed, 31 Jul 2024 10:42:36 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB109871C9
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1722415353; x=1723020153; i=xypron.glpk@gmx.de;
 bh=8GuVbUdyOMiV9lk3euq5vGrEQ752wARon3NvPopN3Wg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=bBG1SJr7DB0eweGlN8zlYfVSnI6ODMQGS1StkxZ1i6p/iCQdaAneBFav8c3Kb5i3
 Z8dpBaNcjM5s7rcPoWcjNHp1hrXEaUrkwekd30QLKkSgvrjyZveLqnCKDOtQfodyZ
 4WoSaEmtYZwDbnN1w3SxzNTI+dO9kroLKGOOmyjp3eL1kXTtKdDhRSNShQX8OoDLT
 p4q2WPH0Ul4P8QgKCJZnTYa/Me1RB0EjO8pvYlHmCjLBGQzP7FCFGi1+4JmE0nf/r
 rjjAQXZA9jOfz4LyrkF9evdX+VH8I8OCqBaqn2pOjMYp7NJqotHHEroYYA84D+Z9E
 C2pq9d0BimjorURAew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.93.80]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M59GA-1saBNU3IaS-007WUC; Wed, 31
 Jul 2024 10:42:32 +0200
Message-ID: <bfbc4bba-ec7c-40af-a149-097b9bcaaf60@gmx.de>
Date: Wed, 31 Jul 2024 10:42:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2024-10-rc2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NOs8DwtWhHEhCoAlKK0cTlMBvk03VaMTxqtF1YA7bYNzGBHibym
 gVy0/7K06VLXlnftSP0Ah5fUpHM0xY9tEY0y2pEIVm/lHAkBD7XA4QdVWUwGMT2uS8/Ps2O
 phYe/q3AroABbGkO5IDFbu1UTompXH8fnd9buG3r/fmtq6+TpKvCZ1R2I2Cro+xawJ9EpNO
 3vEawv09YvLKEPKq8pKpw==
UI-OutboundReport: notjunk:1;M01:P0:7xBJnZytDRk=;maJAzL+zV8isfzA61j80QebKLHV
 UO0sGde8O70CAPE01OOy6s5lhoHpOihlzotV+t1DlEmt2yRlHmjWCdGm8WPyaNoH/LsLi8UtU
 rVrXffv4dip1M/CNv6vO4HmeKKxxWmTVruQOuKTE7MXG9yAVHPSCWrT8VrnHfez5wsYeyCoHX
 sAG66RKOZTBSQVVHQ9WUL4oWRPda2vFXq2saT6h+gAyxfjf58AJ/CjPxsp8hij0vvnPRR8Dh5
 0j5zQezndc/VSuWnv0dJk2GzJ3zWsCEVvgoqeTHDqIqjtfHF3nRvB9vs7fAapXXWApGFkt/p7
 IJzE3H3NkhnmCXiFmb12uTmPPy8qUjYZXWPIkcONtgGcwAh5y5Dn9Emq+I19YASoCa3CApRbg
 da55hufVPQ6gaHvC/7PO1fXQphLAuIK286HCu8JpXButUP/pE5Ip3K/iw+4A/qO17BhRaTONI
 8SuEqQsx9D1pwcj63s8QJQJ7uCR9Qg0YvDWNy40cagyq5JLLjEAh3PpqqEK5c0G7nvbBoMEmw
 HTExkVLhBCqTuMWeb6N2fS9XQci4TZUNnG8R979aEJ/qnpd8fAtUiXwyYpkv64bq6YSbA0WPv
 QmsgGUzVrq0YXNHpXkmb+gegDPJpjuUuIerGdRMBOu6p9MdXTGbTIkMAHWqtOrCpPsoM5Q6r5
 b+jKKPM8tlqk/yorcPc1bOqrlaLbTYBZTgsDMHRgmY4WpeK26mFaEiKXJdu6+pes7kpAu94ku
 s7RRRbZoDlpWT+sA5xmHjBl6vph4hnmJkRDXL9492mJrMJDiGoiQWHmCyWgtjp8Kdh5W6txBY
 EqWtFp3r7EDvs4LvQLVtJ7Tg==
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

The following changes since commit 8877bc51a8a4d921ba2f163208b8b1a57ba47c1=
8:

   Merge patch series "led: implement software blinking" (2024-07-30
14:31:24 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2024-10-rc2

for you to fetch changes up to 939afc80b6b5de23d70789f3cb3a391dd31319b1:

   dm: use list_count_nodes() for counting list nodes (2024-07-31
09:54:53 +0200)

=2D---------------------------------------------------------------
Pull request efi-2024-10-rc2

Documentation:

* Add a description for bootmeth_android

UEFI:

* Provide and use function list_count_nodes()
* Require EFI boot manager for EBBR compliance
* Correct check in efi_load_option_dp_join()
* Adjust config options for capsule updates

SMBIOS:

* Add extended Extended BIOS ROM Size

=2D---------------------------------------------------------------
Caleb Connolly (1):
       efi_loader: add /dtbs search path

Heinrich Schuchardt (3):
       efi_loader: require EFI boot manager for EBBR compliance
       smbios: add extended Extended BIOS ROM Size
       efi_loader: correct check in efi_load_option_dp_join()

Ilias Apalodimas (1):
       efi_loader: adjust config options for capsule updates

Mattijs Korpershoek (1):
       doc: Add a description for bootmeth_android

Sughosh Ganu (5):
       linux: list: add a function to count list nodes
       efi_memory: use list_count_nodes() to count list entries
       efi_memory: avoid possible null pointer dereference
       efi_memory: get the efi_mem_list node directly
       dm: use list_count_nodes() for counting list nodes

  MAINTAINERS                      |  1 +
  doc/develop/bootstd/android.rst  | 39
+++++++++++++++++++++++++++++++++++++++
  doc/develop/bootstd/index.rst    |  1 +
  doc/develop/bootstd/overview.rst |  2 +-
  drivers/core/util.c              | 14 ++------------
  include/dm/util.h                |  8 --------
  include/linux/list.h             | 15 +++++++++++++++
  include/smbios.h                 |  1 +
  lib/efi_loader/Kconfig           |  2 ++
  lib/efi_loader/efi_fdt.c         |  3 +++
  lib/efi_loader/efi_helper.c      |  2 +-
  lib/efi_loader/efi_memory.c      | 33 ++++++++++++---------------------
  lib/smbios.c                     |  9 ++++++++-
  test/dm/bus.c                    |  5 +++--
  test/dm/core.c                   |  9 +++++----
  test/dm/test-fdt.c               |  5 +++--
  16 files changed, 97 insertions(+), 52 deletions(-)
  create mode 100644 doc/develop/bootstd/android.rst

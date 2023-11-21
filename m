Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9D3C5AD4C
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 02:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCD42871CD;
	Tue, 21 Nov 2023 03:34:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CL3QdOkR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92A7287128; Tue, 21 Nov 2023 03:34:38 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B1F2874E8
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:34:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700534075; x=1701138875; i=xypron.glpk@gmx.de;
 bh=f/zH42yOnm1ADn4LGubBTf0GtXFj9lMHLAFxRHES7g0=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=CL3QdOkROCA6CwRIlReHu/mLR2NBPHgab+hRzny4NWyzLycjbRhgtzjwkwLDh4P6
 eJ4pDC6/KTDaciMhEsUtdAddxEnwtX33biuJrxb6M/1qgbTR1i8emri2AupJXSiL9
 UEoHf9yQWUazPzht9Fd3CTfpigjxVdPrgj37on12j4ZCLsknlmLmaeIaLtEb9ZF7f
 TpAP9WEm0YJqIzVRFnlFXh0V3tDxb6BCWG/7/pSsQImY8fJh9bcNlcJ6N+dhK2ke9
 MGjHGVQWHQMQ+nBy61NfIJ7c/8cV9/ogsmoPe7z7iT7+l3iFTcoW99zJzTeJWcBce
 x1CiODtZcD30SlhqbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLQxN-1qoYgr46U7-00IS0y; Tue, 21
 Nov 2023 03:34:35 +0100
Message-ID: <d35c315b-4106-42ea-b017-01c16d32b9e5@gmx.de>
Date: Tue, 21 Nov 2023 03:34:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2024-01-rc4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MQRTdO+3P9KBQ6+liImc8WA77RGTMp/WQYXLU68dmSWM9KuRj6d
 YIs6fReLUt9mMZHYVNZJdo5ZTP1dW1NVpaSoX3zN65AgnclzV6fUgYyew+3wPX/FrA9zUhb
 oCpRLTBwphnqPDrp7YoIAfvuNN8cdZfN1m4nwSphkpdXnH0di2Pn6YaHSxyg8nPgDgvmKCN
 wQacOuuYmuQpRJLq/F6ow==
UI-OutboundReport: notjunk:1;M01:P0:HwqIoM5FiKo=;XNAD9gv2qYNQIwlQ9DI1eVwklD8
 p7G1y2WIj3kR2d+QTGwD6mnfdnDy9lx5cY88+JFMnRAm/YPeOIUr0F2m8YzKY0uBkKSnS0bWw
 L9TZHT4Jbfb4mFRNHrw0vPHN4QrXq25+xQjmPTAW7VhOz9rMiOuQBdCBBsSM00Bs63vQ73GOn
 o7vuYEFlR0wLeVt9th9U74b9i1XGTRY3Do7IeI5NJd/2MUqDesbUTNpXFSF8FZ1O1yaLXApNt
 nKSDojxIa8SAg7GcFByY5bqNQM21W9o9yVcHNFXt5bp7RVLxE56zAs5k0VJX4y0SLXYm1vhVN
 FYWNqdCGekvIv1NOho84Vt8c+rIXdywYrgCGWWYUdTdzi6L/IXM/UwofQJLG5yNTYaa5ATExv
 Jh/KgX3+ktGDaeiC+E1lb4JCLbub5AHPX+3FuwFM+C0+wZl1K+WZbqjFGlCymOhJmCuLMHtmZ
 CuoIzjpgXNuFfEtBo77Pqe/eHq2vQ9Ti2YHTEXovWoS0FqZd4CeEqgLlhEilZtPQsuwJN41h9
 ZTIGdOwSBoT8LysIbcrEAiENTALvkRGckdA4ug4qzN+/i+OT4HMyLuTOp4tbTGU3Gh6fOYQir
 NsSwiMYcGfobD6rt24cb9X/gqkYJTYMMeXMuUJJvVHzFthOZk5h66Og0yZmJJo86gn2XZVelv
 dkkP+w7qC3174+mXx4IBch89vp2xRN+VyUr4mKi9U21iMZiWKRzBhioTR1fWOnl21HV/ny+GV
 irhW4FNTPnAjcBGkcq3VW/qicw4wHtpwuWo5uvUJuM+jpiafM8hd1C4VSn41TXbZqYfEgXjRL
 rkVxOofoqwLndQameZbnt+I193q7niRIrLw4e0SHf+fQNZxTT3ZiM1ow33p7GvSHipSt5Sae9
 1Saj0ja9qyCp3N8Zb6LC1meTrejkLuFofLOEc/I2I6uvcPlp06tfZXHJjiI4jirifd1w9x5HE
 Utx5ThaGnWDOyqThcYoJQtNlFWY=
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

The following changes since commit 24ca49b33af98d54d6cd2e845f071f6565345ff=
d:

   Prepare v2024.01-rc3 (2023-11-20 08:43:46 -0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2024-01-rc4

for you to fetch changes up to 64658007f3c61e32bf241f3048a23b1728774d57:

   cmd: eficonfig: create shortened boot options (2023-11-20 19:06:22 +010=
0)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/18655

=2D---------------------------------------------------------------
Pull request efi-2024-01-rc4

Documentation

* Add HiSilicon board documentation to HTML docs
* Fix building with Sphinx 6.0

UEFI

* Increase default variable store size to 128K
* Check return value of efi_append_scrtm version
* Create shortened boot options in eficonfig command

Other

* Avoid incorrect error message in mkimage

=2D---------------------------------------------------------------
Heinrich Schuchardt (5):
       mkimage: do not write incorrect error message
       doc: add HiSilicon board documentation to HTML docs
       doc: typo fdtaddr_addr_r
       efi_loader: improve efi_var_from_file() description
       cmd: eficonfig: create shortened boot options

Ilias Apalodimas (2):
       efi_loader: Increase default variable store size to 128K
       efi_loader: Correctly account the SCRTM event creation

Jonathan Corbet (1):
       docs: Fix the docs build with Sphinx 6.0

  board/hisilicon/hikey/MAINTAINERS    |   1 +
  board/hisilicon/hikey/README         | 227 --------------------------
  board/hisilicon/hikey960/MAINTAINERS |   1 +
  board/hisilicon/hikey960/README      | 247 ----------------------------
  board/hisilicon/poplar/MAINTAINERS   |   1 +
  board/hisilicon/poplar/README        | 288
=2D--------------------------------
  cmd/eficonfig.c                      |   5 +-
  doc/board/hisilicon/hikey.rst        | 261 +++++++++++++++++++++++++++++=
+
  doc/board/hisilicon/hikey960.rst     | 284
++++++++++++++++++++++++++++++++
  doc/board/hisilicon/index.rst        |  11 ++
  doc/board/hisilicon/poplar.rst       | 302
+++++++++++++++++++++++++++++++++++
  doc/board/index.rst                  |   1 +
  doc/develop/bootstd.rst              |   2 +-
  doc/sphinx/load_config.py            |   6 +-
  lib/efi_loader/Kconfig               |  14 +-
  lib/efi_loader/efi_tcg2.c            |   5 +-
  lib/efi_loader/efi_var_file.c        |   7 +-
  tools/renesas_spkgimage.c            |   3 +-
  18 files changed, 890 insertions(+), 776 deletions(-)
  delete mode 100644 board/hisilicon/hikey/README
  delete mode 100644 board/hisilicon/hikey960/README
  delete mode 100644 board/hisilicon/poplar/README
  create mode 100644 doc/board/hisilicon/hikey.rst
  create mode 100644 doc/board/hisilicon/hikey960.rst
  create mode 100644 doc/board/hisilicon/index.rst
  create mode 100644 doc/board/hisilicon/poplar.rst

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5A2CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 14:51:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8687686D62;
	Fri, 13 Oct 2023 16:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="aZ/cgfep";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AF7886E39; Fri, 13 Oct 2023 16:51:49 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C00E86B95
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 16:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697208700; x=1697813500; i=xypron.glpk@gmx.de;
 bh=xzJYGl/k+hjysbF41kW0ifSA1JpRhuRfhRf6oSvnlJQ=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=aZ/cgfepOjPk6wbh7heK+UQW+HZTDFLWfoSWwc6dmJDdltalOebxV2AizIvOkUFPdvyrEGQxHVF
 miOxLNmjDILZjJC8vvA2IJF2cA5c66CO3sWb0uT0kwiDhiEmdcNcUq0w/fbJ7y4kvta2UTdbqKeBY
 9fEJqLilEmmOqMSBATC7lJTO8UoePMMxfxTbSPYe8GmBIVU8oiiwlOhKcba9MZAvxuBRwecOJipC9
 3hXSd8y2wI/IgqDigVjHx4ahHv6bbCh4SY94mWktNf9Zb8SHXztctusi4kC3xCj3R5XL11DjCzDlw
 IGCcPYV+dzfid3YCm0YjC4sQYs+i1lm7sLAA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N79u8-1rcgzI2vD2-017ULu; Fri, 13
 Oct 2023 16:51:40 +0200
Message-ID: <090248a1-7ff1-41b9-91d6-270f53031b10@gmx.de>
Date: Fri, 13 Oct 2023 16:51:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Paul Barker <paul.barker@sancloud.com>, Simon Glass <sjg@chromium.org>,
 Weizhao Ouyang <o451686892@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2024-01-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/z5oEqvjsJz0/UotmH9c/UdCHho/KurHrSRpUOvVar9RjtSlivs
 SRFYLf6YcY3JknCtmhAclyH3gm42zBBXzP2Zj/tvn5R21VbUQWliHAegtfWayI/huqdptSa
 e3Xo0XVdWOyH9yyaUHeqPCYmBh1SuFd1KXdCni5qSEhSlN67w1JPnqDB9E6YVipTaGG3G+J
 Jzk6Km/XIJtAriyKD2D1w==
UI-OutboundReport: notjunk:1;M01:P0:u2DbcDH4jiM=;YA3XV9yKFGGhC7w8tJyZcVZTo+I
 wOEmtcuJ7NXaref4S1BRGOcPIrVl/0OtuV2LPKuXl9qT6d037HybaTBtRFWbC8POfQr57YPmR
 cb2wCfxHTRV6hMSG3Pniy+giGuwuMjHAzKKVkxT2OpBR2M1TCC9BClhJ5c9f95NiFV7tGxViT
 tf/Z4RRYam5nxg39nfcYStIwA9T/DT7IodGlcP4xuKO/z2gwC4X1F1v6RSpThKGBC2+FALjYy
 kHkNM+1qqtrJdGO7mh+kr3DXFrB7+iVSJiH9funJBSAKutJ0531VVyLlQpBYe81IipZu6JwmO
 ojk4fEj4xsjOjEgyA93mAy/JfakiqLXTumXxOJqRcye31iM6+tgZmlrlSFAoUX9Wl/1lgNEOU
 A/Fim2TXqwwQxhhSqTDa//bGk8ZXnM/X+K1N8riNpM0iq4j+cqYwMZvIcfgKoJ3tRiV/upkxf
 M2mfWSX2tSj+lp07Y8ycL+bgYvVwSqitqRKbrOMM4tWpR07ve0jNO2kn8kzIIhdfOv1+/n1BX
 0mnwhShh/hdsSwfYGCewefC9JC2i3f3+Hgrq4KYXLI75LQu1gFFNtFXOgqAFDCJUOEshgRHEE
 ijv5agJQxIoBFbtRaUYsQVnlcFJWrkY2BEhT7yfanTENbHcbjMjgwTI5VuR2oBAQ2TlfhSI1U
 b7zGFJQina77fyVLZjRT6Xlq3//qzLHt+97GXnu2P/fm+C36IzPvYQfFLtaTyUPfSo386maYF
 kxephw93qVees6KB8M3tfbTH67E3HYpsE52yHeVEngYsG3BqNt8aiy4Gs87I6yDgzmPTOMi88
 uUvbcC4bKlzFTMdtQ0SAOxacHN1GUBpGpVF6AE4yTTBUWnvI1Yh7V3NSuOiXy6dc4+c3c0BXw
 5V9EbFWSDALo91b5+gEA4tbyCRwGSpzXUuBTMBno6c2/l7oVePHkfDv0sjYtiXlVuqQ0abjjc
 U1LSZ8LGSmSDhfv7mfDxvcEJA1U=
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

The following changes since commit 997bef3c6d22d12c7fd092fb831bf94d114c9f6=
f:

   Merge branch '2023-10-11-port-gen_compile_commands_py' (2023-10-11
13:25:01 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2024-01-rc1

for you to fetch changes up to c1ab04626d6b05c6e82dfe4d97d3f62f7310d612:

   efi_loader: use well-known guid for auto-created boot option
(2023-10-12 08:32:27 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/18093

=2D---------------------------------------------------------------
Pull request efi-2024-01-rc1

Documentation:

* Bump urllib3 version
* Migrate Renesas board docs to rst
* Link an introduction video

UEFI

* Use same GUID as EDK II for auto-created boot options
* Clean up BitBlt test

=2D---------------------------------------------------------------
Heinrich Schuchardt (1):
       efi_selftest: BitBlt test

Masahisa Kojima (1):
       efi_loader: use well-known guid for auto-created boot option

Paul Barker (1):
       doc: Migrate Renesas board docs to rst

Simon Glass (1):
       doc: Add a short intro video

Tom Rini (1):
       sphinx: Bump urllib3 version

Weizhao Ouyang (1):
       cyclic: doc: Update documentation for CONFIG_CYCLIC_MAX_CPU_TIME_US

  doc/README.rmobile                     |  99 -------------
  doc/board/renesas/renesas.rst          | 255
+++++++++++++++++++++++++++++----
  doc/develop/cyclic.rst                 |  10 +-
  doc/learn/talks.rst                    |   3 +
  doc/sphinx/requirements.txt            |   2 +-
  include/efi_loader.h                   |   4 +-
  lib/efi_selftest/efi_selftest_bitblt.c |  83 ++++++++---
  7 files changed, 298 insertions(+), 158 deletions(-)
  delete mode 100644 doc/README.rmobile

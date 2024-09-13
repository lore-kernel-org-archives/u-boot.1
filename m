Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A945BFA3755
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 13:39:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E18CC88BBE;
	Fri, 13 Sep 2024 15:39:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tkHpHvLl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 795CC88D5B; Fri, 13 Sep 2024 15:39:16 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B0D388B27
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 15:39:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726234753; x=1726839553; i=xypron.glpk@gmx.de;
 bh=AtYPGifwLmQGgbBZWBOTe4M07uAe7ilmpHp35anFKoA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=tkHpHvLlvM0NcE7Cy8FAKGl3RKJam3Uj04lPjqxf0JC1fhMgwmgGaM49R8IVBVK5
 UhJeo8rzx1RpesztnN46zRWf4R8XvUydQss56cp/s5WScyoGAdfLkYkwoHPgF7lBQ
 7uc8J+Sh0ZD+xViEJ/p8iUcUugTkJqmgJiw6OxOdFQKqVr7OdxAXLYxHT2tyj37QM
 qIJ0Eup69tEf8kmLW1CwaOJVVyLhfgVpH6z+pz6HypeKV6NPY+PfupJVCiO08/ROu
 9/WP+Ow+qyXHCsbguikCmWOQZgoM8nX7Qf9ONkAUKMWIC3GfTwSlHEnhVkb7uuBbc
 y94hIbkOzZ11IiFZRg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MI5QF-1skUMQ0XZv-007Jaw; Fri, 13
 Sep 2024 15:39:13 +0200
Message-ID: <5f056170-6966-4925-b165-ab5f46959188@gmx.de>
Date: Fri, 13 Sep 2024 15:39:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [MASTER] Pull request doc-2024-10-rc4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2JqLZBtp57Cjn85+HEzQmgHvVVaEDJCPGqSaREBJnA3nVKdRUwB
 IjfXHCt5/Yo5nvE52DoFgJsjMi30w6oq1Aul1mO+ifi38WPyQf2m2q1XeDbeET53kbrWQFr
 0WHJ9e5aDhM78C+HdaXiTbIR3JFSQTlkcOmHY27df/r+i5AJD2EYUylehI5mZiabRtqaUkX
 iybuDZPiys5mZY37BXTIw==
UI-OutboundReport: notjunk:1;M01:P0:Zx6dp5jggSU=;E1a5Es1SbSlPoE2ekce905Fz/Zl
 sPkubdY1F1qcNLgS04b7GuR6BYB86dpdrR6CUJ0rIU8efULKTQMCh6q/wjRCGPKPPzeR8SZti
 giO/QkyDGSxtJjT+hRPNv/BmRbppT5e632glnSQSKaHwyavbSxsvOHyBJHbWS0coMupva3mY+
 lkP1klIgxktZlSAnpckbgTH+VAcF/wUYbYd9RpuvJxIbzEKAAU+DqnNHLC9TELaoM9ts+uhPY
 ZwHtBhNJ3j9c3TaOETwM4LWL13C0mPNw2x2CA0oSqcfs29BTMWXCgPrNN86aKRV3GI/0qCH/O
 NU2eB6qMJSELv+Sykp1FzB2qXFotOHPGeXB2LkgrPBv6YK3vLe66p/KZMtkUb936gxeW9+ryP
 q9QSRse/G6yvzBxVfVFtv7KBhMsaUex8HsMUYHFjpgCmVbhVO4B6ZZbr90Tq4GNE4gdYL7Le6
 CDT1cYQuBzvR7mnVPSVPrTTrwgeDg2ZbhgnDwOgcW9dlB885Yx+AjW6vIiJre00YY/86jU9wy
 QQKQ6SSOx9ZnJANhKfiq9J7fUU7oLe/lR2pD/Z4G/XFolaOTbJG0/lcekwp04cGPVlmtCHUDx
 4SgYSwxl7Rak94yP1qZZ+PIOTkufgs5uVsfmkFugRuwMRtR7SklkRexpCFPwC9xvjDhbrthPH
 Lahu3YfNcTlXSitywpdkz/fLVPMEzwoEPxWlT0CD25OTD2IR2h9f/12vLfhY3b88Scl22sUz7
 WjYC4OeBZXSAT+I1+pFqLzALIhCenLWyiBwLMgnSC+n3hPD2FEt3suFnMx1E2gmx1yLp2biZO
 tJRFRS7MlR7jIoM8rzOMGVaQ==
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

Hello Tom,

The following changes since commit 5f044932413694475422d4b16607dfcf9aff878=
1:

   scripts/Makefile.lib: do not include CONFIG_DEVICE_TREE_INCLUDES in
dtsi_include_list (2024-09-10 11:31:54 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/doc-2024-10-rc4

for you to fetch changes up to ff994a3c2ed0e8d233bcc6f0176ef21ea9c75009:

   binman: Update links for sending patches (2024-09-12 18:14:50 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/22327

=2D---------------------------------------------------------------
Pull request doc-2024-10-rc4

* doc/develop/sending_patches.rst: Clarify when to use which branch
* doc/arch/m68k.rst: Update toolchain comment
* doc/arch/mips.rst: Update toolchain list
* doc: Update rST to not reference the old wiki
* doc/mkeficapsule.1: Update homepage link
* bootcount: Update to point to current documentation
* binman: Update links for sending patches

=2D---------------------------------------------------------------
Tom Rini (7):
       doc/develop/sending_patches.rst: Clarify when to use which branch
       doc/arch/m68k.rst: Update toolchain comment
       doc/arch/mips.rst: Update toolchain list
       doc: Update rST to not reference the old wiki
       doc/mkeficapsule.1: Update homepage link
       bootcount: Update to point to current documentation
       binman: Update links for sending patches

  doc/arch/m68k.rst                             |  6 +++---
  doc/arch/mips.rst                             |  3 +--
  doc/develop/process.rst                       |  5 ++---
  doc/develop/sending_patches.rst               | 14 ++++++++------
  doc/develop/version.rst                       |  2 +-
  doc/device-tree-bindings/bootcount-syscon.txt |  2 +-
  doc/mkeficapsule.1                            |  2 +-
  drivers/bootcount/Kconfig                     |  2 +-
  tools/binman/entries.rst                      |  2 +-
  tools/binman/etype/atf_fip.py                 |  2 +-
  10 files changed, 20 insertions(+), 20 deletions(-)


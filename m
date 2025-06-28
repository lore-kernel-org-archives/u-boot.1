Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47DDC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 13:12:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2D8181D5D;
	Sat, 28 Jun 2025 15:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="t8uzg/Uf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2996182977; Sat, 28 Jun 2025 15:11:59 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF6F1806D8
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 15:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751116316; x=1751721116; i=xypron.glpk@gmx.de;
 bh=iNtB/PyqTRNsmCJKd3r0mjjCoqnCOADvctvVE+pefDc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=t8uzg/Uf4Ft02I0ZMCjEBuw+DeGw5/Du15lDq/FDmn/7yYuHwpvDjHjmyIznr6Hc
 vk7T3zyEccdLNVOvfCNy/5bwcuc9pSIDvaIlyhH7sweCZ917TKAHF0QyvgUjJFiWO
 kcgE8bdLQrwnORurs0GA7X08TGVjkeVRtdC1obN1sixPHDtBqIxCLn+SZnJ0qelY5
 m6pI300JtlM8YFlO6CaGwOuDvVs/rXkEcqzok2k4n02oLnZIKeqGNQjA7LjUdZrvW
 3bv3GnA8ZY1TeqAT0kzYsrggaJ/FWvgKmRZVp7/aDTnfDrd1OtO2dm0nqipFD7h+U
 fi3UAzfYKmUvoMj7Jg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.104] ([46.114.106.132]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sDq-1uQZOY0uDC-00F2u4; Sat, 28
 Jun 2025 15:11:56 +0200
Message-ID: <bccb18d8-d46e-4aaf-b69f-87ddd3701f88@gmx.de>
Date: Sat, 28 Jun 2025 15:11:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Fiona Klute <fiona.klute@gmx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2025-07-rc6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uJRAE66SARzimNRYXnPrHgwRf8fA38aUBpGuYCXj7gKLAoC9/fa
 eKmSSmWr6FMPza8rSc2WKwwfqFNmOk73UHnmNYPsczmkfGo9rWM2JZN/IklT3fYr9L7M2xd
 Xb0SPwK7vV0+hayK17dsom45Q2XeyAdm6qm4ZIK4ESToS3Xn7ccDRPjmlz2XglWIG76IQ1b
 c0t5ftffoevRYfKVwm9VQ==
UI-OutboundReport: notjunk:1;M01:P0:tAlUdZAbZpc=;qlGvqjlyQSuC3XqVZQLPR5fdpll
 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
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

The following changes since commit 359e3012921f2fc2d43f3c4e320a752173f82b8=
2:

   mailmap: Update email for Duje Mihanovi=C4=87 (2025-06-26 14:22:39 -060=
0)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2025-07-rc6

for you to fetch changes up to e80baf06af50a4c8c6f41e9b67f9931f964ced87:

   efi_loader: initialize 'total' variable (2025-06-28 13:03:19 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/26871

=2D---------------------------------------------------------------
Pull request efi-2025-07-rc6

Documentation:

* Describe usage of U-Boot environment variables in extlinux.conf

UEFI:

* Add missing variable initialization in
   efi_bootmgr_update_media_device_boot_option

=2D---------------------------------------------------------------
Fiona Klute (1):
       doc: mention that extlinux.conf can use environment in "append"

Ilias Apalodimas (1):
       efi_loader: initialize 'total' variable

  doc/README.pxe               | 3 ++-
  doc/develop/distro.rst       | 7 +++++++
  lib/efi_loader/efi_bootmgr.c | 2 +-
  3 files changed, 10 insertions(+), 2 deletions(-)

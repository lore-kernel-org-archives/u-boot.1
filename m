Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C30C5516D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 14:22:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4FC08133E;
	Fri, 31 Jul 2026 14:22:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fr0b3ojVFInh; Fri, 31 Jul 2026 14:22:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F4CE81334
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785507746;
	bh=9FVAtVAWZ221YI+tHePZHK6B2YgnnZMuKItk8kmjakU=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kmCT5OTgXXnWQDz97313aCuQBkbz4AInSFzs77YKtX7vEwumlZ/scpZVEE8hX86Ub
	 Rmv6FvzQea/2tMdipfvbE7E4q5AyVJ3RaxaodK9fLUgtxadQ0+YLCA6Yf0zlERc8jm
	 c/VPrRdkAnkneyP+Ivj0O55uEE6nnI9qflI8mracm48VTP5fmV3j3VIcabdw0X5Z8i
	 ptIUs6wKwzkSIzk6326jIyhUyoCLUh+hmcKiroSma86pfz85DmAFqkc14uAwJ1JW9s
	 DwAmsOKB0W7KQl+Y98gGM9k4sm/0EoZtxOZwVmlgTioUFSQPRm8dwIWJ5IRFTS0UsE
	 kX17YmENgaDtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F4CE81334;
	Fri, 31 Jul 2026 14:22:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EC00237F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:22:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D2792400A4
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:22:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xziEf4tIIyem for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 14:22:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 42D0A4004C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 42D0A4004C
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 42D0A4004C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:22:21 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6AD884A0F; Fri, 31 Jul 2026 16:22:18 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B29E849BC
 for <u-boot@lists.denx.de>; Fri, 31 Jul 2026 16:22:16 +0200 (CEST)
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPGRp-1wZeiW1t2D-00O1v3; Fri, 31
 Jul 2026 16:22:05 +0200
Message-ID: <cd57797a-bc4f-4909-972a-228570fb841d@gmx.de>
Date: Fri, 31 Jul 2026 16:22:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Aristo Chen <aristo.chen@canonical.com>, Scott Moser <smoser@brickies.net>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2026-10-rc2-2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o90Ih8uZNWNLjsVPlsFcQ8wKeI03l1Jz/N+j+pLRvd3/1B/F1vv
 gtsU4SIAEMjyEoKjlwq+WU+t9CJGkLjNiM2zAeYKcu8GaXhBQUh3+L0EvrSVegkFnnYR6vG
 x8hfQue1lJTcSd3+0ulYRYlsj3/1d6PJp2QbJkMsWrrbxRboSmBr7QFyDxnICTO12B9J1v8
 o+gVrKMWf/3rd76rWqeOQ==
UI-OutboundReport: notjunk:1;M01:P0:TNFpofAc5os=;ltwjGzytptIk6rCx4XKlpgPvsTa
 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
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmx.de; 
 s=s31663417; t=1785507725; x=1786112525; i=xypron.glpk@gmx.de;
 bh=9FVAtVAWZ221YI+tHePZHK6B2YgnnZMuKItk8kmjakU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=UgKc6dTCvlSwQ9Gxpq5A7XZ16+hMueVnoy1BnP7xJYTQRAIeQjoA2TqAQdvYdXNO
 3v1EKp1kSiKPF0N2FyKBFH0zcZp22J84jD0c1an43m4G/9T8KaiEknM680ebv83qE
 yoXH6PgZrPW0+PaPymuoloAl7J18wkqR5/jnltQuARvzfI57KO6OdeVt8rB5/pfTh
 2L3FlD9NSrt9aO9blcrPn6Sv85y3PkTeMmpZ2vRRPs7w2250pM4aDtqjTEH1PETTv
 798+UuX+n8qFb7Np6irFzpi4C4K/O/JfI97kWQL7+fIi0TrD5Pck2aZpOJOw+JVjj
 OVWACCY83dq05AQx5w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=gmx.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=UgKc6dTC
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=xypron.glpk@gmx.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UgKc6dTC"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Dear Tom,

The following changes since commit 100e12ea78c73071b9710f08b32fd4590019266=
f:

   Merge tag 'mmc-for-2026.10-rc2' of=20
https://git.u-boot-project.org/u-boot/custodians/u-boot-mmc (2026-07-30=20
08:50:13 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/u-boot-efi.git=20
tags/efi-2026-10-rc2-2

for you to fetch changes up to d78ba22ab2df094a659a7ffa85e0787037f7e3a7:

   efi_loader: fix use of uninitialized guid in variable enumeration=20
loops (2026-07-31 11:06:37 +0200)

Gitlab CI showed no issues:
https://git.u-boot-project.org/u-boot/custodians/u-boot-efi/-/pipelines/83=
9

=2D---------------------------------------------------------------
Pull request efi-2026-10-rc2-2

Documentation:

* README: Slightly rephrase env set and env print paragraph
* cmd: gpt: Reinstate gpt setenv
* CONTRIBUTE: replace "as" with "like"

UEFI:

* Unify the memory map output of 'efi mem' and 'efidebug memmap'
* Print ISA-specific and unknown memory attributes
* Rix memory leak in efi_sigstore_parse_siglist
* Fix use of uninitialized guid in variable enumeration loops

=2D---------------------------------------------------------------
Aristo Chen (2):
       efi: Unify the memory map output of 'efi mem' and 'efidebug memmap'
       efi: Print ISA-specific and unknown memory attributes

Heinrich Schuchardt (1):
       efi_loader: fix memory leak in efi_sigstore_parse_siglist

Marek Vasut (2):
       README: Slightly rephrase env set and env print paragraph
       doc: cmd: gpt: Reinstate gpt setenv

Quentin Schulz (1):
       doc: CONTRIBUTE: replace "as" with "like"

Scott Moser (1):
       efi_loader: fix use of uninitialized guid in variable enumeration=
=20
loops

  README                         |   4 +-
  cmd/efi.c                      | 221 +----------------------------
  cmd/efi_common.c               | 137 ++++++++++++++++++
  cmd/eficonfig.c                |   4 +-
  cmd/efidebug.c                 |  96 +------------
  doc/CONTRIBUTE.rst             |   2 +-
  doc/usage/cmd/efi.rst          | 309=20
++++++++++++++++++++---------------------
  doc/usage/cmd/gpt.rst          |  16 +--
  include/efi.h                  |  23 +++
  lib/efi_loader/efi_bootmgr.c   |   2 +-
  lib/efi_loader/efi_signature.c |  10 +-
  11 files changed, 334 insertions(+), 490 deletions(-)

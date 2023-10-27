Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEB3C25B48
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 19:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4410F876BD;
	Fri, 27 Oct 2023 21:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="WwoS8FK3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67F2287637; Fri, 27 Oct 2023 21:20:49 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BE9F876BF
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 21:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698434444; x=1699039244; i=xypron.glpk@gmx.de;
 bh=cHN49x+U8Y39rJd/Kc/3MqgV652RSlA6AQwKUU00/1A=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=WwoS8FK3Kl5WureoOXyu45kL9px4PpRfUFRUR3MZlneQzwYHF+/m9YHTkhp4s2wc
 UogD70LcVLUw9zU9HmClN4sAiCsICjk6fYZaEFUaxqcP95GyIXSQtT9J8nRyVyJZh
 Y8PpL4az9CkVRTxP2aAu/43wp7COW8l+86PfKJxbtjmigiBkTvEo/Hu+mc69L5l9f
 YYZOMufCe9X6YFnZrTRTx4wtbytyKYebXKOWG4f0hRYkba4d5rX5HetX7wFiB6hbQ
 sj0lUyDmLfUe428kSyc/xM27M5bhT248hIIEwwAyMGGlDn2iYoij2njXER1YbuZKP
 yBTUEr2fKNbPJOeIjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZCfD-1r1Fdd1pmD-00VCTO; Fri, 27
 Oct 2023 21:20:44 +0200
Message-ID: <a400d609-3328-41c1-abad-7c395be64228@gmx.de>
Date: Fri, 27 Oct 2023 21:20:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dylan Corrales <deathcamel58@gmail.com>, =?UTF-8?Q?Milan_P=2E_Stani=C4=87?=
 <mps@arvanta.net>, Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2024-01-rc2-2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cCyqvZKSpdh3UvL6ibUQ0OZ2wpi/xpsdvzDtVCUmn9tKnS0kq9+
 DxRCzDPab6gXNjHol7A8ekqMk8Hmq8RTXy1BNeKiQ4okc1IoPTpyiDyCFZwapKXDRohDAyk
 YuO3f0I5lcLy0o67FFcetg9ipWcm4SjWa87Z9f7w1fTjJCgupqP1IYpcIwjKyhBSg+FOR+x
 kyU6NJsvCdgMsh8WfNRWA==
UI-OutboundReport: notjunk:1;M01:P0:7FvrjDqGVxg=;T+Fp+FZ5+Oxo/RPW9Vu0zsYFhZM
 BJipHdAZFrrdtKRJTie38pYkMsOrbyz7lBwU3XY4DBBR2e236jJfKHtC9zSoNOgmBSn123XkE
 4BnmhrOkEnCh1xWpyIuyAhjA5DBzH3RvfrpMs808u6LZlHge2kN/oWu6MeWoIJh35JBMHkP5V
 G8MdL770TSb7zKQQao5qoud729zQm1D+Z6o4zAW8FIyU8GHKRvvhllAfWyoQTEtIO83E/68hT
 kwlzcBTZU7ckfYfaPUvfwsDfv88BjbgVGyY0DPhMI61BzUYm02IkUIOofCiTzotxlF3Ux8mir
 Js4uoDjc7RDyPrbPbLAOhW/NM2LZ9hGcpWR6Amt8EhPQTL11f9bL0kYqqsHhpTDb/BuprYen7
 ibQ0zuBBfiAVz0xeLBMIsd1gy9LQjvtnyIUf5vtniEPJNjTFQBXyyV7h9vhXYNaKWwlp48gLc
 B2/Nf71HdFIjfyfndEgNC3KVoAJwnK3eojqo/5G3inv7e/sMXoTvE1gTwQRrs+Z7KV8GQL1O3
 cUqhG0Efl/5ygEmtBvw7f9UydIdtTInirERy/IkXi2mK+4Vanf60DqG5hJlFCmv7qqq/dO8t+
 8wQNW3nqofH2hZoOmzjeQhI7YEnaJrw/bpOdyusobVtHLLaoKvBYfcrfWb2b07QtBr8JrWRwm
 Sq34/ofZ0+evAXRsLWw7tKn/Fxk6Jf3pGYAHu/5VwyAyNqSDh5p3S/cdr0yVjgLJoH07rG+rW
 6nM0oApTd5jBKu0kVvkZDRPzL9cY+JRe0tsZ159f56mRRWiTU18BfidkGde+2i95EV241vI3B
 XNWzidNj6x+fMWd+tkPOBxgJ+5DRS9EFFn5oYdzKoDUUYi7G4ADTGWE7gv5q8plLHoRFDvzHt
 ZvNYhDxUHdUYrsXkhfDTGjuCi9L1+8Cy5ks9YLMVTSVF4TVv1XwIHwtKSda16C8IFpamUhEEr
 tFKaew==
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

This pull request replaces pull request efi-2024-01-rc2. The two patches
with which you saw issues are removed.

The following changes since commit fb428b61819444b9337075f49c72f326f5d1208=
5:

   Merge branch '2023-10-24-assorted-general-fixes-and-updates'
(2023-10-24 19:12:21 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2024-01-rc2-2

for you to fetch changes up to e89827998fa47408f3d0be0384c7c19cfe8e2b3f:

   efi_loader: fix EFI_ENTRY point on get_active_pcr_banks (2023-10-26
00:36:07 +0200)

Gitlab CI showed not issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/18303

=2D---------------------------------------------------------------
Pull request efi-2024-01-rc2-2

Documentation:

* Bump urllib3 version
* Replace references to dm_dump_all() with dm_dump_tree()
* Update description of build dependencies for Alpine Linux
* Fix typo in gpt example
* Fix ordering of shell commands

UEFI:

* Move misplace EFI_ENTRY macro

=2D---------------------------------------------------------------
Dylan Corrales (1):
       doc: Replace dm_dump_all() with dm_dump_tree()

Ilias Apalodimas (1):
       efi_loader: fix EFI_ENTRY point on get_active_pcr_banks

Milan P. Stani=C4=87 (1):
       doc: build: update description of build dependencies for Alpine Lin=
ux

Tom Fitzhenry (2):
       doc: gpt: fix example of echoing variable
       doc: usage: fix ordering of shell commands

Tom Rini (1):
       sphinx: Bump urllib3 version

  doc/build/gcc.rst                      | 10 ++++++++--
  doc/develop/driver-model/debugging.rst |  2 +-
  doc/sphinx/requirements.txt            |  2 +-
  doc/usage/cmd/gpt.rst                  |  5 +++--
  doc/usage/index.rst                    |  8 ++++----
  lib/efi_loader/efi_tcg2.c              |  3 ++-
  6 files changed, 19 insertions(+), 11 deletions(-)

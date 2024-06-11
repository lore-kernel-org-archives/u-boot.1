Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31A7C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 11:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFC54878ED;
	Tue, 11 Jun 2024 13:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cjSNafgq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17226882B6; Tue, 11 Jun 2024 13:52:19 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFCCF83334
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:52:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718106734; x=1718711534; i=xypron.glpk@gmx.de;
 bh=2Sr4UWCb7kZXgbxNy0IzJywe+e28S4NReEC1sK/yUqo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=cjSNafgqBe2fVsmK5Sx77RUEMoCU1yVfFIYov+Aki38hukgH7A6+q/UCpsUH+PRp
 tTTIOdAwIYYkP/rhor96tU4beEarB8ABCPCUxwlaWXdnn59fxbKVwzYJX+wWNKkCp
 kaBa/8yTBIQXVEHN8Ut5G+cDFuNFfkS/K9B93TD6ZuWWBhAGlL8WulrmRYHqSWq1v
 iQhEX5KhX5srOAZQVwL6vEb56G/AyuEhHUpooLMEketHIYjnZreHNQOavN/af9v1+
 gwXmS6xh4EOAu1VT58fqG9K6qdkwWVT8vJtV8wph7pCi+kyH9ZMwk1z5Oq7fw+zEk
 y4AmyPQX2dkSIxg4RA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([109.42.176.212]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkHQh-1sfZLj1gGf-00mFXc; Tue, 11
 Jun 2024 13:52:14 +0200
Message-ID: <1e8d881a-6b93-453c-8639-34ca61aa82cd@gmx.de>
Date: Tue, 11 Jun 2024 13:52:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [NEXT] Pull request efi-next-20240611
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pqv+pfe3LqvX+WzTPR20z5aiTPrkpfgh0uWEEHHKGf/lqvF9fyj
 4iZSuRTEWjTH8jkHLTjQBgP9yOcXoowojlJ2+3O++IiFNCvyEn9tMggsXmoWeiZ2CMu5fOE
 x9o4Oz2yjwaEh/RNWN9sNYqSoO0JgnX2ePIX4N42cEdMqiOZj8InRyOL/ejfRsGuvV1XxMs
 xO81HKoUmBhOYj9ovqHjQ==
UI-OutboundReport: notjunk:1;M01:P0:dKcxRcmFNrE=;6mGVWCh8ojj8+9sGIOYqL1u627Z
 7hh1nN9PvSy/uK3XiwpB/Yi9IAFkEYBBNxu54S76sk7o5HscQieKVPDNA27BRT4HN0unkxGFl
 NqeOo7IQqBoBjm3xSdm3qEo8nDW88cCAK84clj2leBQgW9KdCgfSSpYQygIUXw9jhbQqKz1Bi
 1hikG0bd2CkwfGdQh6OfdkgcoWZIwal7nDTqt5SBH2ImPQJi0vwZdpqXpEEjB12d+PlojZxm4
 zL9qYV3M/Enzto/DvA9drqllmo96N9xyepp/NXkIAemrJ1osEtsRT9qD6wOCxoUacZscE3NYs
 SAMMGu1xF0vGDLJVfjOLe0E6da3pDmC9MNWYbCuODUp4ZoIn2CEHQsh7AiCL+ZyKmIWf7Y9N9
 nIqB5pVbREMEcDQ5yxrPhkJp4hlR3IPR+J5jJUZL/9iEEP30Zm+76Y02+EVOG1oD7vhopAVr0
 ud36TLDc8OWblVLhFZqVctZqZ6JqBR7l8fFgeMjIt08u8s0sBpElKKZlVhsQXW14h1MSSwBJQ
 evxXoL7JpF8WK/tlDGF4rIWrno4YK4P6TIS6/evNbdDgOCVWsfthmmjoBVjGWuL7zxddG+9XR
 C+hHxY8MGiMxhThQjd2nnlylDjBkO0LFlKmR0seqEArw2CGP75oPtJtX6FZOGrLAhTvCSljOC
 AbykRrE3nWuSCKqITanI2zMgTe2fF0ZEUEcKMNtrGBwEA++0I6F4LithNr7WcfLgsZX1njpT9
 t+WO76ryVz15bMRckgcx9b/CHuXxz0y0NH4/X4v013wjzc44MTYWU8AG/4OycpLhDMRDHn/l7
 qgfFLHonv5K1TVL+Q0wxhzRM+/Gabp7SgFm4rGKti6FT0=
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

This pull request is for the next branch.

The following changes since commit 4f836fb324ba500ecabdba4146c3ca9e1600cdf=
5:

   memory: ti-gpmc: use printf to dump settings/timings (2024-06-07
14:07:23 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-next-20240611

for you to fetch changes up to 535321c2ea76de44896330040d2e43aa4645d026:

   efi_loader: rename struct efi_initrd_dp to efi_lo_dp_prefix
(2024-06-10 11:43:37 +0200)

Gitlab CI reported no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/21059

=2D---------------------------------------------------------------
Pull request efi-next-20240611

UEFI:

* Allow specifying a device-tree in an EFI load option
   using the efidebug or eficonfig command.
* Let the EFI boot manager fall back to an OS provided device-tree
   if no device-tree is specified.

=2D---------------------------------------------------------------
Heinrich Schuchardt (9):
       efi_loader: allow concatenation with contained end node
       cmd: eficonfig: add support for setting fdt
       cmd: efidebug: add support for setting fdt
       efi_loader: load device-tree specified in boot option
       efi_loader: move distro_efi_get_fdt_name()
       efi_loader: return binary from efi_dp_from_lo()
       efi_loader: export efi_load_image_from_path
       efi_loader: load distro dtb in bootmgr
       efi_loader: rename struct efi_initrd_dp to efi_lo_dp_prefix

  boot/bootmeth_efi.c                        |  60 +-------------
  cmd/eficonfig.c                            |  83 ++++++++++++++-----
  cmd/efidebug.c                             | 129
++++++++++++++++++++---------
  include/efi_load_initrd.h                  |  12 ++-
  include/efi_loader.h                       |  24 +++++-
  lib/efi_loader/Makefile                    |   1 +
  lib/efi_loader/efi_bootbin.c               |   2 +-
  lib/efi_loader/efi_bootmgr.c               |  81 +++++++++++++++++-
  lib/efi_loader/efi_boottime.c              |   3 +-
  lib/efi_loader/efi_device_path.c           |  40 +++++----
  lib/efi_loader/efi_device_path_utilities.c |   2 +-
  lib/efi_loader/efi_fdt.c                   | 117
++++++++++++++++++++++++++
  lib/efi_loader/efi_helper.c                |  44 ++++++++++
  lib/efi_loader/efi_load_initrd.c           |   2 +-
  lib/efi_loader/initrddump.c                |   2 +-
  15 files changed, 463 insertions(+), 139 deletions(-)
  create mode 100644 lib/efi_loader/efi_fdt.c

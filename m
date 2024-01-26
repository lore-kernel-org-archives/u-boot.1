Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E46C47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 15:10:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB84387C11;
	Fri, 26 Jan 2024 16:10:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="agaWys1L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DC4887C20; Fri, 26 Jan 2024 16:10:07 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6B3C87B84
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 16:10:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5ff7dd8d7ceso4701627b3.0
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 07:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1706281803; x=1706886603;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejx68ud344PUd+6/Wpf17b9WLZHwQAzL46n+ShBTKyE=;
 b=agaWys1LiQLDQVgvoDYoo96Chj+5Z/fM78ZP45V86XfFfNnIT4jQpTkobpYPXhVm5Y
 gaV/hm4I+0kXrOh3xiub+YFlgwDDDol1k/tmhIbTLkYFE/+omoMSATQNqLNiyx0EhYkJ
 ffyjgEhat1tnkTW8GRQD9gBibqpKjRO7ptsMumkpVk/FRXq18sk1Hw8Y5/XSvx45JFQP
 irjP0+8+PdtC6bHT5Ybt3zFS1dgyJxOxMBQcK+Ya1ul0WNDXT0XhInPO0lAEssXSUpaa
 aqZ2LYAGjwzcOHAsKgvxprbdg67BxpeIxZ7xpZQ/Ag78icxyFNkUNFFjBrLHN1gGCIvB
 CpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706281803; x=1706886603;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ejx68ud344PUd+6/Wpf17b9WLZHwQAzL46n+ShBTKyE=;
 b=au/ENBZbSZUY0Wxm/Y4lFEPbp2pOwIXjPabbD3bZvCqRJdnf3CWFg+v/D62/BVSnXF
 a4E975sqFmox8q108sArA/87AZdE7PbJbRERFlGsDFeMwUtAnIUg/dUmXkdEkwREqpku
 /xB7g7GmjAIofeK2n3XIzwgV4HxG9FGx2pTD4hXbiOe8DRlCadn3R5WaLmyPH8yDeS3F
 X6giDF2jORIi7vGFV4RPcoL3j6a2Tej8YJ+OuP3L46Sj8B/TprwxpLSrKP0H2hzvNYlh
 psywd0fTD2YQOztYO1PG+LHKegQVUpcp94pA3qkNAfZeSChf00GnTAulrvlTICRsGGX2
 rQKw==
X-Gm-Message-State: AOJu0YwkmuJyI74fiF7a5SVJJfGNNe/A62+E4GQpPhEKrzd7Pw999o1d
 yvoBLkGUgcB3UOUK+BnBQ0V4xAydoEkixvEUcUtuIKrKP0D+Udwn78vvBY4fi68hdkz+xXMVfwx
 9HAMWxegzlllWb0TekXkVVzTsg114mLR8eYvy
X-Google-Smtp-Source: AGHT+IE3iyUbNjEqItfXkHrMLTX1zWycXl01QGL22EdPY+TLKAPTjkZI6w6X2C4/FQDedkEJFdmitlFKMmxt2rYoRrk=
X-Received: by 2002:a81:8d45:0:b0:5ff:934a:a11e with SMTP id
 w5-20020a818d45000000b005ff934aa11emr1461896ywj.66.1706281803254; Fri, 26 Jan
 2024 07:10:03 -0800 (PST)
MIME-Version: 1.0
References: <20240122115439.653871-1-sughosh.ganu@linaro.org>
In-Reply-To: <20240122115439.653871-1-sughosh.ganu@linaro.org>
From: Michal Simek <monstr@monstr.eu>
Date: Fri, 26 Jan 2024 16:09:51 +0100
Message-ID: <CAHTX3d+W83koHneGX+aH=EgyqxbTX9Bwu-Or8nfSjtd=8_GpKg@mail.gmail.com>
Subject: Re: [PATCH 00/18] FWU: Migrate FWU metadata to version 2
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@st.com>, 
 Etienne Carriere <etienne.carriere@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Sughosh,

po 22. 1. 2024 v 12:55 odes=C3=ADlatel Sughosh Ganu <sughosh.ganu@linaro.or=
g> napsal:
>
>
> The following patches migrate the FWU metadata access code to version
> 2 of the structure. This is based on the structure definition as
> defined in the latest rev of the FWU Multi Bank Update specification
> [1].
>
> Since the version 1 of the structure has currently been adopted on a
> couple of platforms, it was decided to have a clean migration of the
> metadata to version 2 only, instead of supporting both the versions of
> the structure. Also, based on consultations with the main author of
> the specification, it is expected that any further changes in the
> structure would be minor tweaks, and not be significant. Hence a
> migration to version 2.
>
> Similar migration is also being done in TF-A, including migrating the
> ST platform port to support version 2 of the metadata structure [2].
>
> The patches have been tested on STM32MP1 DK2 board and the Synquacer
> board from Socionext. This covers testing both the GPT and the MTD
> partitioned storage devices for the metadata access.
>
> [1] - https://developer.arm.com/documentation/den0118/latest/
> [2] - https://review.trustedfirmware.org/q/topic:%22topics/fwu_metadata_v=
2_migration%22
>
> Sughosh Ganu (18):
>   configs: fwu: Remove FWU configs for metadata V2 migration
>   fwu: metadata: Migrate to version 2 of the structure
>   drivers: fwu: Add the size parameter to the metadata access API's
>   fwu: Add some API's for metadata version 2 access
>   lib: fwu: Make changes to support version 2 of FWU metadata
>   drivers: fwu: mtd: Allocate buffer for image info dynamically
>   drivers: fwu: Allocate memory for metadata copies
>   fwu: Add a function to put a bank in Trial State
>   capsule: Accept a bank on a successful update
>   fwu: mtd: Modify the DFU API's to align with metadata version 2
>   efi_firmware: fwu: Do not read FWU metadata on sandbox
>   efi_firmware: fwu: Get the number of FWU banks at runtime
>   cmd: fwu: Align the command with metadata version 2
>   test: fwu: Align the FWU metadata access test with version 2
>   fwu: Remove the config symbols for number of banks and images
>   tools: mkfwumdata: Migrate to metadata version 2
>   configs: fwu: Re-enable FWU configs
>   doc: fwu: Make changes for supporting FWU Metadata version 2
>
>  arch/sandbox/Kconfig                     |   6 -
>  board/armltd/corstone1000/corstone1000.c |   2 +-
>  cmd/fwu_mdata.c                          |  43 +++-
>  configs/synquacer_developerbox_defconfig |   1 -
>  doc/board/socionext/developerbox.rst     |   9 +-
>  doc/develop/uefi/fwu_updates.rst         |  12 +-
>  doc/usage/cmd/fwu_mdata.rst              |  12 +-
>  drivers/fwu-mdata/fwu-mdata-uclass.c     |  10 +-
>  drivers/fwu-mdata/gpt_blk.c              |  27 +-
>  drivers/fwu-mdata/raw_mtd.c              |  85 ++++---
>  include/fwu.h                            |  94 ++++++-
>  include/fwu_mdata.h                      |  56 +++--
>  lib/efi_loader/efi_capsule.c             |  12 +-
>  lib/efi_loader/efi_firmware.c            |  20 +-
>  lib/fwu_updates/Kconfig                  |  11 -
>  lib/fwu_updates/fwu.c                    | 308 ++++++++++++++++++-----
>  lib/fwu_updates/fwu_mtd.c                |  76 ++++--
>  test/dm/fwu_mdata.c                      |  56 +++--
>  test/dm/fwu_mdata_disk_image.h           | 124 ++++-----
>  tools/mkfwumdata.c                       |  43 +++-
>  20 files changed, 705 insertions(+), 302 deletions(-)


Thanks for this work. I have tested it on kv260 and I see an issue
with 2 image per location configuration.
When I build mdata v2 with:
./tools/mkfwumdata -a 0 -i 2 -b 2
588aced7-2cce-ed11-81cd-d324e93ac223,e86660de-5602-ad4f-8238-e406e274c4cf,4=
8054af6-ce2c-11ed-8f66-7bc4531cfe6b,4b819c3e-ce2c-11ed-bec8-23de4c6d2cf2
588aced7-2cce-ed11-81cd-d324e93ac223,d4cf9ecf-8b93-c541-8551-1f883ab7dc18,f=
b04da52-0e9d-11ee-a57f-637805837c3f,07609246-0e9e-11ee-a23a-a38980b779a1
mdata.bin

fwu command is showing up configuration for the second image

Image Type Guid: DE6066E8-0256-4FAD-8238-E406E274C4CF
Location Guid: D7CE8A58-CE2C-11ED-81CD-D324E93AC223
Image Guid:  F64A0548-2CCE-ED11-8F66-7BC4531CFE6B
Image Acceptance: yes
Image Guid:  3E9C814B-2CCE-ED11-BEC8-23DE4C6D2CF2
Image Acceptance: yes

Image Type Guid: F64A0548-2CCE-ED11-8F66-7BC4531CFE6B
Location Guid: 00000001-0000-0000-4B81-9C3ECE2C11ED
Image Guid:  DE23C8BE-6D4C-F22C-0100-000000000000
Image Acceptance: no
Image Guid:  881F5185-B73A-18DC-588A-CED72CCEED11
Image Acceptance: no

but it should be (from mdata v1)
Image Type Guid: DE6066E8-0256-4FAD-8238-E406E274C4CF
Location Guid: D7CE8A58-CE2C-11ED-81CD-D324E93AC223
Image Guid:  F64A0548-2CCE-ED11-8F66-7BC4531CFE6B
Image Acceptance: yes
Image Guid:  3E9C814B-2CCE-ED11-BEC8-23DE4C6D2CF2
Image Acceptance: yes

Image Type Guid: CF9ECFD4-938B-41C5-8551-1F883AB7DC18
Location Guid: D7CE8A58-CE2C-11ED-81CD-D324E93AC223
Image Guid:  52DA04FB-9D0E-EE11-A57F-637805837C3F
Image Acceptance: yes
Image Guid:  46926007-9E0E-EE11-A23A-A38980B779A1
Image Acceptance: yes

And I think the issue is not with mdata v2 generation but it is with
decoding inside u-boot.
Which ends up in a situation that dfu_alt_info for 2 images is not
generated properly.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

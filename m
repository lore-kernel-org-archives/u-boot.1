Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35FEC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 15:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E074F875A0;
	Sun, 31 Dec 2023 16:57:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Dpz99qeh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53D2A877DA; Sun, 31 Dec 2023 16:57:02 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0162A870FF
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 16:56:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704038202; x=1704643002; i=xypron.glpk@gmx.de;
 bh=enUIX3+9bxab3kPZAzHUY13BGuI8ToZNosluoiClsBQ=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=Dpz99qeh1jLofJduYTKh+4tKRFii1muwuc3wmTvkF4PeUs+9EFgbFPN9RtBTBJtE
 g2KkrHUN00ritZNUoW7CVAFyM5MDoyU9b2298u/F6bz+iMh9x+jBLcAe7T22H/nDv
 uwblkLrbryKpT4BiyPUVP4ZIiyUe6lJlMftmSp1bDcmcv6ta3V19rCTjP7ELF0DQ4
 HfkmlaXAZKOeznfGfLNfKf6HZy2xxrV8cOp7yf71BaV5hQZO12Tkmp7w58cd455Wt
 rhoS7H4oKR6DgCxux4LupR+Y+rP99+UW2N3LJXq5mVGe/TcWA5Z125g2fsKdXyftk
 gLSkIgtVQlAOfGhxhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1HZi-1rMi000Wpm-002l93; Sun, 31
 Dec 2023 16:56:42 +0100
Date: Sun, 31 Dec 2023 16:56:39 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Igor Prusov <ivprusov@salutedevices.com>, Nikhil M Jain <n-jain1@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: Re: [PATCH v5 00/12] smbios: Deal with tables beyond 4GB
User-Agent: K-9 Mail for Android
In-Reply-To: <20231231152555.464874-1-sjg@chromium.org>
References: <20231231152555.464874-1-sjg@chromium.org>
Message-ID: <4683F3D9-7D61-4D26-B1F2-3DB07D009AE1@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1dWrCdHa+yBxobScdtEzv2DXLH9lwN1XoLU3drzCM+9ZGzf1C6w
 HEDdzReuDgk9ymbpEzmMzXBLR+g9GWBTJFh35LaqXxW2yUnZuf0wDj0kLEgdn0QvXlcadje
 uY6mi0g4g/hZOecbx6vuXbVIamYZQHGxzkD0bWYD/yJVDn9q5/1XENewigqu4EP690Exrnv
 R3NzWDzOirOnvcu9+VQ+g==
UI-OutboundReport: notjunk:1;M01:P0:4/E1YMYR0tQ=;B+XdnZL/J/FaKIJ7V+RVgv4QRBq
 Oaz+myRLt7s++cp0UW0YIvwld+oxH+BeAMpTxHwZAXYLmK38UETSHe8FDxusHQRzoV3iO8vZV
 xInQHvCFi6zFrMEZySFoh2jIJJ/5SwKsYEbrLEE7kQ4l1zhy09BSVih3ES4VdKb98OTd1Xbx3
 LSjqWu5T92Zz+Rh93pSGdVm5qLrVpc02RkpOPtC06DHT8l6WzcVhzfZP/pIHFXUSWr3Vi9TFe
 Ziqa9YA3SXG1JVxhjDLjN6JU13EnBBpfBBpaO9UTxpfk+O9FUzZCss7tkHoCcAWQ6w0ezX374
 ltJhHiROckE9QiSTmB947racJNia2YbZ5mbMy9joM1tLQQwjvRnaSdN/TKfO0K07kC3LQWd1v
 pt4WLfDkyI/wTdQOg8Ix70DfeiaXF7kv/fMo7xql/+I/SxjhVsoH5WYcTUZqlfhN74OL9CFi+
 y6/pMZl0QGARbAEW9XzWdOZ11fJ5FMS+VCdISemkE24PleyPlJX5Mx55SkkzfrvNMAO2AeT17
 mo8CMNeyLnthE5aMBA7rsaOcHgKtspYiJCbpNk+bxp4uGltFuiD8drroSNyiCsdSMZV902GT/
 KIGeZTJDyBFFdjEKSUbvL97bC42pgnQfA+N5aGfaXLXxJZjbwbdfZxyrP1Y3ggP3aLkWGaMJu
 x4eWSAzvh04wsJHKeE40xbKL5ByZTRbyAoclucEDuubU7z+HMgz+bHtkdtDL+8lqiVet9hhew
 pmI8j5E3PSEjYMtN2Uy25xBA15Y6Spqp6qIjdZ7aeDYGQ9aF3+loFDKtcVSciuNhr8o72m9M2
 2MIyqTIkw5cLSdNAqqyASsHJBsEIahxaKdhy53/tNMiQlJjiYvSCdhKYjA/dhPvYa+SGqhpgf
 Yj/8jZo64qZXCCD+j6FWQuR36cAeU7BSNNCiaQorVL8+VbO9ufZBdAi0DVmlVY7NfPZx7TL3H
 1GQwoQ==
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



Am 31=2E Dezember 2023 16:25:43 MEZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>When the malloc() region extends beyond 4GB on ARM we may end up with
>an SMBIOS table in that region=2E
>
>Add support for writing an SMBIOS3 table, which supports a 64-bit
>address=2E
>
>Note that this problem does not happen on x86 since it requires the
>tables to be placed just below 1MB in memory, unless
>CONFIG_BLOBLIST_TABLES is enabled=2E

The ACPI specification only requires that a low memory RSDP exists on non-=
UEFI x86 systems=2E

Nothing stops us from copying the RSDP only to low memory when not booting=
 via EFI=2E Maybe that way we could have more common code=2E But this is be=
yond the scope of this series=2E

Best regards

Heinrich


>
>v5 drops support for SMBIOS2 tables as well=2E It also adds some changes
>to memory mapping which should allow an EFI app (launched from sandbox)
>to read the ACPI tables correctly=2E
>
>Changes in v5:
>- Update comment to mention x86 alignment
>- Add new patch to drop support for SMBIOS2 tables
>- Add new patch to drop support for SMBIOS2 tables with EFI
>- Add new patch to rename test dm_test_setup_ctx_and_base_tables()
>- Add new patch to write pointers to tables instead of addresses
>- Add new patch to correct smbios-table installation
>
>Changes in v4:
>- Bring in this patch from Heinrich's series
>- Check the start of the table rather than the end
>
>Changes in v2:
>- Check the end of the table rather than the start=2E
>- Add a new patch to correct gd_smbios_start()
>- Add a note about why unmap_system() is called
>
>Heinrich Schuchardt (1):
>  smbios: SMBIOS 3=2E0 (64-bit) Entry Point structure
>
>Simon Glass (11):
>  smbios: Refactor 32-bit code into an else statement
>  smbios: Move the rest of the SMBIOS2 code
>  smbios: Use SMBIOS 3=2E0 to support an address above 4GB
>  smbios: Correct gd_smbios_start()
>  efi: Use the correct GUID for the SMBIOS table
>  smbios: Require the caller to align the SMBIOS table
>  smbios: Drop support for SMBIOS2 tables
>  efi: smbios: Drop support for SMBIOS2 tables
>  acpi: Rename test dm_test_setup_ctx_and_base_tables()
>  acpi: Write pointers to tables instead of addresses
>  efi: Correct smbios-table installation
>
> arch/sandbox/include/asm/io=2Eh     | 16 +++++++++
> arch/x86/lib/acpi_table=2Ec         |  6 ++--
> cmd/acpi=2Ec                        | 12 +++----
> include/asm-generic/global_data=2Eh |  2 +-
> include/efi_api=2Eh                 |  4 +++
> include/mapmem=2Eh                  | 18 ++++++++++
> include/smbios=2Eh                  | 41 ++++++++++++++++++++---
> lib/acpi/acpi=2Ec                   | 12 +++----
> lib/acpi/acpi_table=2Ec             |  4 +--
> lib/acpi/base=2Ec                   |  4 +--
> lib/efi_loader/efi_smbios=2Ec       | 28 +++++++++-------
> lib/smbios=2Ec                      | 55 ++++++++++---------------------
> test/dm/acpi=2Ec                    | 14 ++++----
> 13 files changed, 134 insertions(+), 82 deletions(-)
>

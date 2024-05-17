Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94E8C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 17:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D65F187F52;
	Fri, 17 May 2024 19:13:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mMVIUZoY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A47B87F64; Fri, 17 May 2024 19:13:06 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA45A87EF4
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 19:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715965978; x=1716570778; i=xypron.glpk@gmx.de;
 bh=xu1SUPwsJraLJLDYNjtCZcBLBwZkaDdlCzXnJI/wPkA=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=mMVIUZoYMv52obojfTvLExOckf0xLHiHqgIzOySxNLA54Y7dLPJ3uS1QxuCUlrcy
 IM4qjTgq0OzC8vFcvoH/Y0uD03zkrPYL42zhGDFEB1Mzv0i7PQCLN21kvupcs+2hw
 BOA8QdVke/+y0g+nG5cYolR3HBDtuFwxKMcR7ug/cT1s3PRSSta0+6G3Zy5WpUcY6
 3/r9ibTf8R6mmxRxmq8HucexTO0ufsKeInsU8y5lRp5C/44TmDbLrGVjT97nOAIia
 gZzFu+U06UbyKj+x0vUjOzGxv05zeHSXFgbSrRsrzvSBjq3+5BJdFtY/pEh/uenOY
 gsE3neDgI75iKslPGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([176.4.195.183]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXXuB-1s3zkb2Fkl-00Z23m; Fri, 17
 May 2024 19:12:58 +0200
Date: Fri, 17 May 2024 19:12:55 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
CC: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 0/7] MIPS: Enable EFI support
User-Agent: K-9 Mail for Android
In-Reply-To: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
Message-ID: <F673BC88-7C9C-4633-91E6-1994732C5955@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yvehqnBcJ5sd559iXYYtwIFw8X5kA6rsoleI3rqDokWvjaD7t8A
 +LW0RIuAvFfeu70drgGGL8Mtv+CUWvWpSd25Yn4JDBACHczIqqDAEMaJ9PZX2gK6wE8dQoX
 SmDN63ZNJTMpKkwgcEJI5sn+Kuh9QUYOVZOA7NfqmJk6VQOsllsj7BiRXZ6QWlX6ph+Sn4Q
 rIrJJaLLfdByOFTtM/GoQ==
UI-OutboundReport: notjunk:1;M01:P0:KSrO/EjhY84=;hBzlOrL+7A8op5Px3et/mOq5oTG
 rYh4WT7eShXjivimxCAlR5JSrUNDQ1PnfeSFoCovJNk4QBUH3dgjR3S31cX+6PGsxiaf8cyTv
 LlU4QHHdk6AKuXMCaEIXL+wGWL1rOQGjWcosv9/QOpi+8BF6WqEsLhNGfsXLCBu0o3lZkHane
 hECCbKJeV8kiOzTuZJ6ZuH9HY3FFXhEr6ji/i8dlJEjIRqc4RX80A/v6HH+3PBmnW3KA+rDaw
 FTm1xx5OMjzEFQxfjqMQFkwPJvqpAtMoTRilTvW15zrBkJ0lOv69hQ0wH/C6OZcW2cLDKhRrH
 FiAc+hp+rJ9vqWXRkfpthxVl4NuL16ZfwRLk3J0JQRg3x7AV9EwnTmf4ncKmIVMMRZYoFaueI
 wPIYX7mIrZMpCS093iCLtDSxDV3LmC+dtZaHIZYPWkOyvWtYICr0YkYodbbpsNc4YMCZzDUoH
 c8Nfw4pxJu3jvTRMQ6c39+1DKQ9wPu9gD9Pvjv2179i2xHyhhm4+P3PN2g8cjBNuQz9BeWXLL
 e5g7/xbc/fJNFNM9pUZDvTQD6wkt3SGlJE5+6Mle6Srb1lIpQfcv7tvCZpChamS7BET5lNqRI
 Zeyo+mpn2mSlAYs1mDiXNujI9Y7PWZpjm2Xo6vJHA1lSn+NtJ9JYcyxg21BqfDvrgQBOn3l5X
 V3aNvns2yMJPq5GFkMK0zjJwggU484RwgLFR19SzHUg+/1CQaDvD8XNZP2boLbRlUoHeJbb1t
 iMITtmZJ+S1+wXprBG7UwffE+ZkFpumE7Q8sgQWdKvGKe3EsbnikVffw04f0eoabTtHc1J++M
 JQaiP16W5REEhmjR4jk290t7lpfPndGKR/19NzGVNLZHY=
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



Am 17=2E Mai 2024 18:32:51 MESZ schrieb Jiaxun Yang <jiaxun=2Eyang@flygoat=
=2Ecom>:
>Hi all,
>
>This series enabled EFI support to MIPS platform=2E
>
>Although MIPS is not defined by UEFI specification, there are
>quite a few firmware implementations available, including
>MIPS-EFI[1] for Loongson-2F, Lemote's proprietary EDK2 implementation
>on Loongson-3[2], Kunlun firmware for Loongson-3[3], efiffy[4]
>for MIPS Creator CI20 and another mystery EDK implementation shipped
>with some Creator CI20 board=2E =20
>
>Available applications including gnu-efi, Loongson's GRUB fork[5],
>Ventoy[6]=2E
>
>My implementation in U-Boot is aiming to follow conventions made
>by other implementations for architecture stuff and remain
>compliance with spec for general aspects=2E
>
>bootefi hello and selftest passed on both 32 and 64 bit system,
>gnu-efi, grub and ventoy are tested on mips64el with my pending
>platform works=2E mips32el efi executable from efiffy is tested
>as well=2E
>
>Please review=2E
>Thanks

Implementing the Loongarch architecture defined in <https://uefi=2Eorg/spe=
cs/UEFI/2=2E10/02_Overview=2Ehtml#loongarch-platforms> would make sense to =
me=2E

Supporting an architecture that does not have published UEFI standards is =
less convincing=2E=20

Is any of the mentioned boards being produced anymore?

Best regards

Heinrich

>
>[1]: https://github=2Ecom/kontais/EFI-MIPS
>[2]: https://github=2Ecom/loongson-community/firmware-nonfree
>[3]: http://www=2Ekunluntech=2Ecom=2Ecn/klbiosxl
>[4]: https://sourceforge=2Enet/projects/efify/
>[5]: https://github=2Ecom/loongson-community/grub
>[6]: https://www=2Eventoy=2Enet/en/index=2Ehtml
>
>Signed-off-by: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>---
>Jiaxun Yang (7):
>      MIPS: Implement setjmp
>      efi: Allow runtime relocate to be disabled
>      Makefile=2Elib: Preserve =2Erodata section for EFI file
>      Makefile=2Elib: Enforce EFI CFLAGS/AFLAGS
>      MIPS: Add smbios_start to arch_global_data
>      MIPS: Define MIPS EFI related bits everywhere
>      MIPS: Implement EFI supporting stuff
>
> Makefile                                          |   3 +
> arch/mips/config=2Emk                               |   9 +
> arch/mips/include/asm/global_data=2Eh               |   3 +
> arch/mips/include/asm/setjmp=2Eh                    |  36 ++++
> arch/mips/lib/Makefile                            |  15 ++
> arch/mips/lib/crt0_mips_efi=2ES                     | 239 ++++++++++++++=
++++++++
> arch/mips/lib/elf_mips_efi=2Elds                    | 113 ++++++++++
> arch/mips/lib/reloc_mips_efi=2Ec                    |  99 +++++++++
> arch/mips/lib/setjmp32=2ES                          |  51 +++++
> arch/mips/lib/setjmp64=2ES                          |  56 +++++
> include/asm-generic/pe=2Eh                          |   5 +
> include/config_distro_bootcmd=2Eh                   |   6 +
> include/efi_default_filename=2Eh                    |   8 +
> include/efi_loader=2Eh                              |  26 ++-
> include/elf=2Eh                                     |   8 +
> lib/efi_loader/Kconfig                            |  12 +-
> lib/efi_loader/efi_image_loader=2Ec                 |  18 ++
> lib/efi_loader/efi_memory=2Ec                       |  14 +-
> lib/efi_loader/efi_runtime=2Ec                      |  11 +-
> lib/efi_loader/efi_var_mem=2Ec                      |   6 +-
> lib/efi_selftest/Makefile                         |   2 +-
> lib/efi_selftest/efi_selftest_miniapp_exception=2Ec |   2 +
> scripts/Makefile=2Elib                              |  10 +-
> 23 files changed, 734 insertions(+), 18 deletions(-)
>---
>base-commit: ad7dce5abd49ef3b5c93da5303e15449c8c162b4
>change-id: 20240517-mips-efi-c9a1ad819c2d
>
>Best regards,

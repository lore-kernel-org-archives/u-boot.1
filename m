Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0BDC27C5F
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 18:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D3968844B;
	Fri,  7 Jun 2024 20:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tA5VhoDG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 811BB88464; Fri,  7 Jun 2024 20:11:53 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1827C8839C
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 20:11:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1717783906; x=1718388706; i=xypron.glpk@gmx.de;
 bh=QLV30QDBbssc9zRw7NyQmwAJNRFbPvGHr2EioYeOFMc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tA5VhoDG0O3GWEnt1zjzlljwhctsJxalp5L25MJmhH2/mn+tC08cDXYwVMQJSVp7
 2/KNxJf84sMxSqX/oW3dYpGgiv1oGlS7FidSkwWHglXqAo42+rINRltdEdZWoIrYM
 D3q8KM6ef9G4kSF0KjM1teiBVXoYzq4vyYfvYNt8ofYnutwCMaZDXt849OWtTr1ed
 z/CXIYWOuToWXSShZrlKY36I300BBLpy6qGtyQtCFQMzLy/gzN9g7VzDfVsLy0sdU
 MWWKP6/RI6frcCHXK9uHeuP2PgR8xDdYfSjnBOYFSZnFNpzfPJrv9GQJmgzrWnl6w
 aMUAWP9Gkk0Gx8S80A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([109.42.178.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95e9-1sTEjV2m9P-00ubiR; Fri, 07
 Jun 2024 20:11:46 +0200
Message-ID: <786590fb-2f5f-4855-bcad-3ce3f1cf25ff@gmx.de>
Date: Fri, 7 Jun 2024 20:11:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: Add UEFI supplement document
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20240529-efi-spec-v1-1-0668e4d19683@flygoat.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240529-efi-spec-v1-1-0668e4d19683@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lZ8AEFEE7opQnLLjbJM7nCXsPEuL7cbRmjH0SHTpnBemSL4CO0b
 gV2DaThMSVLgTrNGdBAjPbCG4r5e5Aj7wNdVPbfY3VMNCgi5B5J/W1KRmi8DrwWbjOWrwQq
 hNOmLD6XqaefSaHB1rEztDKuJF6kCBJmWt24G1fUpXKj+UHyqxD8zYD+/unBOaZEDsThq2H
 +HAmZNZSkAZ6Yf4qcHVfA==
UI-OutboundReport: notjunk:1;M01:P0:P0DDJRn3eyM=;n7Q6o3KhYxPOhzKWSHHKm/NzdnK
 s6sJZsx9xBxPAD0WFAJyzACH9xnWxgmLbLlguEGv5bPg1wSrYltEZKoAjpQkLm70acSO/Vui6
 lRvFAXMAojOc2OqLgXAA7DPeidzXXywWHOzNILw/yGfqXCib6cf/aFFjRivFUXvqH2OS86jVB
 d2EnS/kS0avr1nL4mtdAYURC21twBijKZ4Ub6uckyJKWM+BojZ9GtSScODRVWlxrNdC434wqS
 Xb+tzcDRBa7Ns0mkDPVtBl5QplAUbtgr3sCcv7CTXpx+XdXkuqYYHQYwjsztnx8IkhfbvMPhf
 7y7tgwWxnx5xhUOixIQ+oT6zc2kC4d7Rx9QjgxLxHL8RBYH3seU2itPTatcQJgOmibja6kSO1
 p8Nnyty5ywrZZPShhhlzQ4wrHkNnb2ueoRaaqnJgV9SsKrSMMx9CljQgHtIs+MXKwmQnHWMq8
 MZGYu0M4h9CEvky2vw0F2MdsyIVXfWOdtaa2DWv78Z0vKnlOt3ad+NFg2sWXlGtPjwPMkapZM
 eHCPLA0lRc5moXoRZrok6xZtcGryUu/fVkIYXvtIK4mULQUFDJargrIeinwwSlefK7fxe+31x
 QizkOSAicsrKgTWdYLCHulFZVZeCt+gWbIH3/slUrOS3ezcw/YXVLRgVYyGdrh/ZP+QoHTneV
 OYDIrbaXHoC8HH26UQjBQLcII/MkW7FM7+NavuHFsGtW8wm/AisL3lcNxGZrUp6JVPza6YuJb
 UQyYFPdqwkgU8qlrxNYR3BzhjvW66EzvSJps7L9IPXMa/LQ4vXh69/djbk5zmFE1w2k46ic6s
 FTMTJVHyubKrRQ7L7LBZbaGKi9chuF3OsaSrwmBZyiZCg=
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

On 29.05.24 15:36, Jiaxun Yang wrote:
> Add UEFI supplement document to define some behaviours
> on architectures not covered by the original specification.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Hi all,
>
> This document is in response to discussion at [1]. It is produced
> based on my attempt to port U-Boot UEFI to MIPS and Xtensa. I also
> plan to try m68k.
>
> Please review
>
> Thanks
> [1]: https://lore.kernel.org/u-boot/CAC_iWjLbY6+FaUYQw2Zv5y5byCnXRHxfzvr=
Ff1dMyJX+ANP9VQ@mail.gmail.com/
> ---
>   doc/develop/uefi/index.rst           |  1 +
>   doc/develop/uefi/uefi_supplement.rst | 73 ++++++++++++++++++++++++++++=
++++++++
>   2 files changed, 74 insertions(+)
>
> diff --git a/doc/develop/uefi/index.rst b/doc/develop/uefi/index.rst
> index e26b1fbe05c5..a274fff88754 100644
> --- a/doc/develop/uefi/index.rst
> +++ b/doc/develop/uefi/index.rst
> @@ -11,6 +11,7 @@ can be run an UEFI payload.
>      :maxdepth: 2
>
>      uefi.rst
> +   uefi_supplement.rst
>      u-boot_on_efi.rst
>      iscsi.rst
>      fwu_updates.rst
> diff --git a/doc/develop/uefi/uefi_supplement.rst b/doc/develop/uefi/uef=
i_supplement.rst
> new file mode 100644
> index 000000000000..cb20cd290912
> --- /dev/null
> +++ b/doc/develop/uefi/uefi_supplement.rst
> @@ -0,0 +1,73 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. Copyright (c) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
> +
> +U-Boot Supplement to UEFI Specifications
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Motivation
> +----------
> +
> +The UEFI specifications are designed to be platform-independent, enabli=
ng the
> +implementation of UEFI-like API support across various architectures. H=
owever,
> +some platform-dependent aspects and constraints remain. This document p=
rovides
> +a supplement to the UEFI specifications for U-Boot, clarifying these pl=
atform
> +dependent details for architectures not covered by the original specifi=
cations.

This does not explain why we should bother about any non-UEFI
architecture. It does not list relevant architectures and does not
provide any evidence that this more than an academic endeavor.

All git repositories you mentioned in you MIPS series have not seen any
update in the last four years.

If any company were sincerely interested in using UEFI on such
architectures, wouldn't they contribute to the specification like has
been done for LoongArch and RISC-V?

It does not make sense to define UEFI for non-UEFI architectures in
U-Boot. Isn't there any existing documentation for UEFI on MIPS?

> +
> +Architectural Conventions
> +-------------------------
> +
> +The UEFI specifications cover IA32, X64, ARM, AARCH64, RISC-V, LoongArc=
h, and

There is only one UEFI specification.

%s/specifications cover/specification covers/

> +Itanium architectures. This document extends the UEFI specifications to=
 include
> +all architectures supported by U-Boot.
> +
> +The following conventions are used for these architectures:
> +
> +- For architectures with multiple ABIs, we adhere to the calling conven=
tions
> +  used by the Linux kernel for the same architecture.
> +
> +- Optional CPU registers (floating-point, SIMD) are excluded from calli=
ng
> +  conventions. However, the UEFI payload should be able to utilize them=
 if
> +  available.
> +
> +- Control is handed over to the UEFI payload at the privilege level use=
d
> +  by the Linux kernel for the same architecture.

This does not provide enough detail. The Linux kernel can run at
different privilege levels on the same architecture, e.g. in S-mode or
M-mode on RISC-V.

> +
> +- Identity mapping (i.e., VA =3D=3D PA mapping) is preferred for UEFI. =
However,
> +  this may not be possible for some architectures. In such cases, if th=
e
> +  processor supports a default linear translation, it should be used.
> +
> +- Endianness: UEFI specifications enforce little-endian architectures.
> +  However, U-Boot supports both little-endian and big-endian architectu=
res.
> +  For big-endian architectures, UEFI data structures should be stored i=
n
> +  native endianness, with exceptions explicitly specified.

Why do you bother about big-endian systems? MIPS supports low-endian.
Linux distros like Debian have dropped big-endian MIPS support.

If found https://www.ventoy.net/en/doc_mips64el.html (MIPS64EL UEFI) but
nothing describing big-endian usage of UEFI.

> +
> +UEFI Images
> +-----------
> +
> +The UEFI specifications define the PE/COFF image format for UEFI applic=
ations.
> +U-Boot extends this format as follows:

The UEFI specification does not define the PE/COFF image format. It
prescribes its usage.

> +
> +- **PE32+ Machine Type**: UEFI specifications define machine types for =
supported
> +  architectures. For machines not covered by UEFI specifications, we us=
e the
> +  machine type defined by the Microsoft PE/COFF specification if possib=
le.
> +  Otherwise, we use the ``IMAGE_FILE_MACHINE_UNKNOWN`` (0) machine type=
.
> +  U-Boot should always accept ``IMAGE_FILE_MACHINE_UNKNOWN`` as a valid
> +  machine type.

We should not accept IMAGE_FILE_MACHINE_UNKNOWN on an architecture that
has a machine type defined in the PE-COFF specification.

Which MIPS machine type are you missing?

> +
> +- **Header Endianness**: PE/COFF header data fields are always stored a=
s
> +  little-endian, regardless of the target architecture's endianness.
> +
> +- **DOS Stub**: To accommodate various boot image formats, we relax the=
 requirement
> +  for a DOS stub in the UEFI image. U-Boot should accept UEFI images wi=
thout a DOS
> +  stub and MZ signature. However, U-Boot still expects the PE/COFF head=
er at the
> +  file offset specified at offset 0x3C.

Why would anybody create such an invalid file and expect it to be
interpreted as EFI?

Shouldn't you fix the software creating such invalid files?

This topic is related to the question of which specification has been
used to create UEFI implementations like
https://github.com/kontais/EFI-MIPS.

> +
> +I/O Device Access
> +-----------------
> +
> +UEFI specifications define the EFI_DEVICE_IO_PROTOCOL and EFI_PCI_IO_PR=
OTOCOL
> +for accessing I/O devices. U-Boot extends these specifications as follo=
ws:

These protocols are not used in U-Boot, yet.

Best regards

Heinrich

> +
> +- All I/O access is performed using the CPU's native endianness.
> +  For big-endian architectures, U-Boot should convert data to/from litt=
le-endian
> +  before/after accessing I/O devices.
>
> ---
> base-commit: 46ff00bea5dd2dd247d5e2fdadbf5dcf8653cd9a
> change-id: 20240529-efi-spec-0ea657985272
>
> Best regards,


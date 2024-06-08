Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37FBC25B76
	for <u-boot@archiver.kernel.org>; Sat,  8 Jun 2024 10:00:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D050D871C7;
	Sat,  8 Jun 2024 12:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="CALB1ggY";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="IeCYkqqf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AE2787947; Sat,  8 Jun 2024 12:00:53 +0200 (CEST)
Received: from wfhigh1-smtp.messagingengine.com
 (wfhigh1-smtp.messagingengine.com [64.147.123.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 298F5831A2
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 12:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.west.internal (Postfix) with ESMTP id 7E93D18000B9;
 Sat,  8 Jun 2024 06:00:45 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Sat, 08 Jun 2024 06:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1717840845;
 x=1717927245; bh=hLVVTBqnQDD3tBNO7Afl9Ybc79TrKheyFxDWrM4bNvs=; b=
 CALB1ggYPE7WWs2IbcVi2N+5PrSLogo0NNl8W0u1WR+787jtUooy/bfUTJMcnbmo
 HvM6gS97e6AP+L7jl8NMSos02YwpER+9+shwhCsC1sLu32+v72997y39HvkgIoy4
 NDLW33W7oHpD58uginZ9nNrDjUYLXFSL689BWH4fBzG942DVAdY6ItjQbT1KI0xv
 1coDnUfildS3EI3mTcXJ2ZwJVcqmR7/9jjSSJlS/P6ihZu6UGp0b/nScH3KeSspw
 +Vyd8IW8+JA7wSSqEtZhjrNMjs0ifrgoApkismnKSwgz1h3HDvUQ/vjaL7TGVMeY
 foS2kzYR5htzJvxUYK4Dug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717840845; x=
 1717927245; bh=hLVVTBqnQDD3tBNO7Afl9Ybc79TrKheyFxDWrM4bNvs=; b=I
 eCYkqqfeyRuU6UkY7np2RrsdqOnj1YUOna4ms7deD1kzL2e4taPao6bpeiB4Hv3O
 LiyuUErkkxenjFwl4t+nb1rW31wnELLcfa9ODNV1mq0GocsGBUZ0umhmET7/wKpn
 BE0NxYUIq5eaSdPLBgvbAyvkbM3ijpzpym1Abq5VoPEatktLt2EBgj1HKDlU4vX5
 pqtPZZLNDBrEQajbn9eyFrKpGZSDIokVa5JvwHcvfpsm6PUkYyETWoASalv9fUQd
 w3v8Hox8Fz3k9+79Hy11YQClyPsBuTz/rdx+4E6xYOE26E5iXYbY/XjnLUpmqK/X
 NNOz6wVTY4ImJzmlxeHjg==
X-ME-Sender: <xms:zCtkZgU6w44FiiEv8Of14ayGd-dwF3GS-LmDXdifWSz0adH6yb_qmg>
 <xme:zCtkZklO0klOaZbgB7W92mOr2pOydvQ5936sDZScGKWX0uaPQhG4k2yzbP7GG5MFy
 0JLnkrS-P4DeSw9Bn4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtvddgudefiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
 lfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtg
 homheqnecuggftrfgrthhtvghrnhepiefgfedtleetiedvtdfhjeeufeffgfdugffgheel
 tefhleeuvdejvefgieevheeunecuffhomhgrihhnpehvvghnthhohidrnhgvthdpghhith
 hhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecu
 rfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrd
 gtohhm
X-ME-Proxy: <xmx:zCtkZkZDjdEA5s19Y69kbHd8LFMgE1lcpkT6pKTcua37bKCdSOdcmQ>
 <xmx:zCtkZvX0ASE3F_of5WDBNe6ROX1FdcjNFcV17DGcDc7_R2qcjG2K8Q>
 <xmx:zCtkZqkuCVTMy158CM0_xEnUaBZuNJUx7KFRpURnunbzKCmJxcQ_HA>
 <xmx:zCtkZkdQhxowZ0lTGa_2swJFTgi5l5TRcEHFwZ2XMUC4xULpDrjdEQ>
 <xmx:zStkZsjXOA9vOWxP1jobCTd9AgrIiXaONdtVqcDKjJGn_681DP1AyPr6>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id C8C0836A0074; Sat,  8 Jun 2024 06:00:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
MIME-Version: 1.0
Message-Id: <bab8fae1-9a5d-461d-ad78-7d85192cc7c1@app.fastmail.com>
In-Reply-To: <786590fb-2f5f-4855-bcad-3ce3f1cf25ff@gmx.de>
References: <20240529-efi-spec-v1-1-0668e4d19683@flygoat.com>
 <786590fb-2f5f-4855-bcad-3ce3f1cf25ff@gmx.de>
Date: Sat, 08 Jun 2024 11:00:25 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>
Cc: "Tom Rini" <trini@konsulko.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] doc: Add UEFI supplement document
Content-Type: text/plain;charset=utf-8
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



=E5=9C=A82024=E5=B9=B46=E6=9C=887=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=E5=
=8D=887:11=EF=BC=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A
[...]
>
> This does not explain why we should bother about any non-UEFI
> architecture. It does not list relevant architectures and does not
> provide any evidence that this more than an academic endeavor.

Hi Heinrich,

As per discussion made at [1] it can be next generation of U-Boot's
API facing to bare-metal software.

I admit it's more or less an academic endeavour to me, but isn't
U-Boot a great place for such thing? Do we have to be bound by
commercial interest?

>
> All git repositories you mentioned in you MIPS series have not seen any
> update in the last four years.

Everything is working well, so nobody is willing to touch them.

>
> If any company were sincerely interested in using UEFI on such
> architectures, wouldn't they contribute to the specification like has
> been done for LoongArch and RISC-V?

Some architectures are dead in commercial point of view (m68k, xtensa)
etc, so I think nobody is going to represent them in commercial world.
Loongson tried to push UEFI spec for MIPS to UEFI forum a couple of years
ago but was trapped by a good deal of commercial stuff. Now they
lost interest on it.

>
> It does not make sense to define UEFI for non-UEFI architectures in
> U-Boot. Isn't there any existing documentation for UEFI on MIPS?

Yes, from Loongson, in Chinese.
But I'd like to make a cross-arch document to help with other ports.

>
>> +
>> +Architectural Conventions
>> +-------------------------
>> +
>> +The UEFI specifications cover IA32, X64, ARM, AARCH64, RISC-V, Loong=
Arch, and
>
> There is only one UEFI specification.
>
> %s/specifications cover/specification covers/
>
>> +Itanium architectures. This document extends the UEFI specifications=
 to include
>> +all architectures supported by U-Boot.
>> +
>> +The following conventions are used for these architectures:
>> +
>> +- For architectures with multiple ABIs, we adhere to the calling con=
ventions
>> +  used by the Linux kernel for the same architecture.
>> +
>> +- Optional CPU registers (floating-point, SIMD) are excluded from ca=
lling
>> +  conventions. However, the UEFI payload should be able to utilize t=
hem if
>> +  available.
>> +
>> +- Control is handed over to the UEFI payload at the privilege level =
used
>> +  by the Linux kernel for the same architecture.
>
> This does not provide enough detail. The Linux kernel can run at
> different privilege levels on the same architecture, e.g. in S-mode or
> M-mode on RISC-V.

I think it's only the case of RISC-V and AArch64 to have multiple privil=
ege
levels. MIPS, m68k, xtensa, power, nios2 all have only one level for ker=
nel.
But I'm happy to add some architecture specific wording here.

>
>> +
>> +- Identity mapping (i.e., VA =3D=3D PA mapping) is preferred for UEF=
I. However,
>> +  this may not be possible for some architectures. In such cases, if=
 the
>> +  processor supports a default linear translation, it should be used.
>> +
>> +- Endianness: UEFI specifications enforce little-endian architecture=
s.
>> +  However, U-Boot supports both little-endian and big-endian archite=
ctures.
>> +  For big-endian architectures, UEFI data structures should be store=
d in
>> +  native endianness, with exceptions explicitly specified.
>
> Why do you bother about big-endian systems? MIPS supports low-endian.
> Linux distros like Debian have dropped big-endian MIPS support.
>
> If found https://www.ventoy.net/en/doc_mips64el.html (MIPS64EL UEFI) b=
ut
> nothing describing big-endian usage of UEFI.

Yes there is no such usage so far, but Big Endian is still widely used
in network devices (cavium octeon, even aarch64_be from ZXIC etc) and I =
don't want
to left it over.

>
>> +
>> +UEFI Images
>> +-----------
>> +
>> +The UEFI specifications define the PE/COFF image format for UEFI app=
lications.
>> +U-Boot extends this format as follows:
>
> The UEFI specification does not define the PE/COFF image format. It
> prescribes its usage.
>
>> +
>> +- **PE32+ Machine Type**: UEFI specifications define machine types f=
or supported
>> +  architectures. For machines not covered by UEFI specifications, we=
 use the
>> +  machine type defined by the Microsoft PE/COFF specification if pos=
sible.
>> +  Otherwise, we use the ``IMAGE_FILE_MACHINE_UNKNOWN`` (0) machine t=
ype.
>> +  U-Boot should always accept ``IMAGE_FILE_MACHINE_UNKNOWN`` as a va=
lid
>> +  machine type.
>
> We should not accept IMAGE_FILE_MACHINE_UNKNOWN on an architecture that
> has a machine type defined in the PE-COFF specification.
>
> Which MIPS machine type are you missing?

Not for MIPS, but we don't have onr for m68k and xtensa.

>
>> +
>> +- **Header Endianness**: PE/COFF header data fields are always store=
d as
>> +  little-endian, regardless of the target architecture's endianness.
>> +
>> +- **DOS Stub**: To accommodate various boot image formats, we relax =
the requirement
>> +  for a DOS stub in the UEFI image. U-Boot should accept UEFI images=
 without a DOS
>> +  stub and MZ signature. However, U-Boot still expects the PE/COFF h=
eader at the
>> +  file offset specified at offset 0x3C.
>
> Why would anybody create such an invalid file and expect it to be
> interpreted as EFI?

There is no such usage so far, but I noticed that for m68k "MZ" is not a=
 valid
stub opcode, it might be a problem for EFISTUB kernel. Thus I came up wi=
th this
idea.

But it can be worked out if we define another booting header format for =
m68k.

What's your opinion?

>
> Shouldn't you fix the software creating such invalid files?
>
> This topic is related to the question of which specification has been
> used to create UEFI implementations like
> https://github.com/kontais/EFI-MIPS.
>
>> +
>> +I/O Device Access
>> +-----------------
>> +
>> +UEFI specifications define the EFI_DEVICE_IO_PROTOCOL and EFI_PCI_IO=
_PROTOCOL
>> +for accessing I/O devices. U-Boot extends these specifications as fo=
llows:
>
> These protocols are not used in U-Boot, yet.

Yes, I had a glance on the specification and noticed that issue, so I
write it here in case we are going to support them in future.

>
> Best regards
>
> Heinrich
>
>> +
>> +- All I/O access is performed using the CPU's native endianness.
>> +  For big-endian architectures, U-Boot should convert data to/from l=
ittle-endian
>> +  before/after accessing I/O devices.
>>
>> ---
>> base-commit: 46ff00bea5dd2dd247d5e2fdadbf5dcf8653cd9a
>> change-id: 20240529-efi-spec-0ea657985272
>>
>> Best regards,

[1]: https://lore.kernel.org/u-boot/CAC_iWjLbY6+FaUYQw2Zv5y5byCnXRHxfzvr=
Ff1dMyJX+ANP9VQ@mail.gmail.com/
Thanks
--=20
- Jiaxun

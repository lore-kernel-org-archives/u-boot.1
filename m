Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FA4C021B3
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 09:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1904680079;
	Mon, 24 Feb 2025 10:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="YMHHaLuc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A69BD805C4; Mon, 24 Feb 2025 10:36:54 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A536380017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 10:36:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740389811; x=1740994611; i=xypron.glpk@gmx.de;
 bh=IzsSk9O4Zeu+MjHL6EJoUtD+xq8ykYafJIISoNdtNUk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YMHHaLucpDgfTej7EjdhKHvCJRzJsA9P9WAXeNvYEPoNxo/+PWxTkCmsYWhtVjPY
 yCzAU/cXBEuBa/nZNQxSjI7qeO7Hy8Umnsz9k9ekggEBEuaLwSTsDeBIo9ghfIvJk
 ADZdcRmz80j9bQNOM200wUICxr+r0H9zZzJPKrR2Zfy/B+dSheh1QYHtCWICpq0wk
 rPOFlP2ajJp0FwwDToM7rPpy0etY58VBaaFlIBRpOsV0/IPphcgcrM5++WnsegnpN
 E6vjsqtTb3F6nh1QdckVBdW+Xsqsp0d5vxHqe76CSXjS+bTA8sPUAXOyH11afDqyz
 0UZ0mESFFZ30Q2ZjUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYNNy-1trSyX0SbC-00IMLH; Mon, 24
 Feb 2025 10:36:51 +0100
Message-ID: <87f3793f-19ab-4282-8099-144440b21ad0@gmx.de>
Date: Mon, 24 Feb 2025 10:36:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/17] efi_loader: Remove ENTRY(_start) from linker script
To: Sam Edwards <cfsworks@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-16-CFSworks@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250224055524.1334929-16-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A4SmW4xb6B3uKINQWsTJ6rj1mpzFp6gPsY49ar5SRhWaYoHAVOP
 Z3eEngzH0uX1S7p6vplgHNr56bae177GEhaJhttK7R4HDDXPn9pVmk9bf996ej9EN++BQUH
 3yThrOpidMasJocID8st9MyzvrXwwHz7gz9sIYx6YlDy+zBMSS79B7MZeMXj1mPEhSHDSxR
 2icEgcGX5Bg6s2jUkIgtw==
UI-OutboundReport: notjunk:1;M01:P0:90x87FsNGpc=;a+rmy+TmFFqomwiNIXMczKAMu5C
 3j7JatrM+n66oQoTNc8WVe4wdZ8yOAJMat8jWomqEmbcF53XODZXSgrmG9HQ9ms1r66f16dWF
 C4zKKh2LjWow99gywSlUgIlhNh9cFvKjLxsgx/MuwwLA+JMih68PspAQRKGteilE8VUEE8NJA
 eeYK+S1RU1MudiVEaeEYjraD1C7pNo4QhfkGCyeD4BCvcqYFUcysyqgJvbG8EKDjwsv12mcr3
 zl01RLQ91hz9xKfpJuKLkmkPZP4Qc6GnI3ZmFIsfMARfkHK1V8y3MpxCdnncSiJ3ZqEy/qCd6
 1PYNiGMEpmZYiMuseFz5XcTWcyJNfB+kevKHVgCcnMtcn4e8C9pUFwRrYgGIxijrJYAOrO2Qy
 gd/Rq4Q0wRN5raMlwjza7HurFtOE5QgwhAtxvTnnKXPAaiAGl6WWUemAY7+hVTBF0HpRcKxXh
 Th4zfJ1mEiEUvy0o9QJmoNitVs5+nCqkHwn7iazGMq5RjtBFn9WoMp1mTbWnjCWBu+evEawrn
 r+WhK/l6rSl98OeY7skKYFAEGnWCLw6BzyLT1oAR+MSNQTejUCEF/vsQO9eqp7URXZafOEclb
 SFP0OgeS4W8wGdygwhu2vq2woTKDIeM+1WkeBJKkOvSJEwARYSNEwG7ishkpJHHJiiFado6CF
 T9S++1p1GQAIvZns8bR1OegeCTgRcqbkzJWJ96urDG9oMbrvob7qvSrVQtCJnwJ+CGCIR4/pv
 00v6y3zTJmo0kK0VmcNattE+B+Bf8prSqiiEGoMlByRd/+vKKwd6x1ZiDltvdaJX2cy5pU5ir
 CwstD15+Qkazmy4BPRVPf3b8A868MeXzO6dZ83hAGfuyp3KOLX2y3SmKvpSm0l355fLBwfulB
 cVH6lgrk7i6wM25pU5YGzGWC4bkWw4a+hsY33quy72mhWftg+9P/prNzwL1W8GAf9vWu25KDa
 iW0LA2s+AtHLe9YYoi/wpc5192YcyAfHpHLVe7FvsbpVqksiVtC19Fhzpg78mgnxXcSgCWlgY
 KaOg6rvjKqDmTyfkY/RlmOd89XTDj6h++79ijcTHgEozEOg/2EVRKjK9ueceUNMaWhv4mi/0P
 NglWbW4rYHwAdr/ecmssufk273dzvH0KvYJa++Yp1HP1qAP3j+ztsTtCSoTDMXhcn8kLtdaab
 zr7XC2A9eJbN/N8KJWW80R/LJ7sM0UknDlgUtT+qXiFPZh/KKuWfnRZHoLuej823og76AN/DP
 rCdP+8n9i9rbJmkpk+EmKDryEC2xyDV3l9bR/0srqv/rcuBAU8zjIew3WEYKflc3Wd18VJK+t
 slem6f2tkd3DxUWgl9EfvV6qcLebcrJVdm8ygyVw53T+IJl/nj4rXeDka+KMGC/VH8gpc0Z05
 p9JlIceAG0cGN9C0TtWig4qhB/wr94IpXQ5XXKD860qw/wIfVwdhnpI2dr
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

On 2/24/25 06:55, Sam Edwards wrote:
> The EFI apps are built using ELF only as an intermediate "linker output"
> format, with the final PE header crafted within the ELF to take effect
> after the objcopy conversion to raw binary. As such, we really don't
> care what the ELF header indicates as the entry point.
>
> Because nothing that uses this linker script even defines a _start
> symbol, this directive has no effect. On GNU ld, it is silently ignored.
> On certain linkers (e.g. LLVM lld), a warning is logged. But in any
> case, no entry point is set.

I can understand the first part of your reasoning. But the statement
about _start is wrong. _start is defined on all EFI architectures, e.g.

arch/arm/lib/crt0_aarch64_efi.S:147:
_start

arch/riscv/lib/crt0_riscv_efi.S:182:
_start:

Why does lld complain? Is it because we lack

	.globl _start

on ARM and RISC-V?

Best regards

Heinrich

>
> Therefore, remove it to silence warnings and avoid confusion.
>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>   lib/efi_loader/elf_efi.ldsi | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/lib/efi_loader/elf_efi.ldsi b/lib/efi_loader/elf_efi.ldsi
> index 190a88fb69e..dc4d1a3660e 100644
> --- a/lib/efi_loader/elf_efi.ldsi
> +++ b/lib/efi_loader/elf_efi.ldsi
> @@ -10,7 +10,6 @@ PHDRS
>   	data PT_LOAD FLAGS(3); /* SHF_WRITE | SHF_ALLOC */
>   }
>
> -ENTRY(_start)
>   SECTIONS
>   {
>   	.text 0x0 : {


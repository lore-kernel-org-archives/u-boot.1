Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EFB606A320
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EUjjVAOt;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=rDmulnRP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9D7080D96;
	Sun, 22 Nov 2026 14:49:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8vmJ4zWAiUeM; Sun, 22 Nov 2026 14:49:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 56A1880D1A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795358942;
	b=s0zWaQnV0FQTvvkE9vLCQ4hSYk5+l6uaScXVgLgOiWuPUGorS2gV+D8MCsk7am1DaYPd
	 hLwuhbOSUwFF1iIDkFiIyjHOrXpFDuH2soXZHK0ZuDCW37zw82bzGwIEytaQf/gUGBoBQ
	 lBPBfxqRxLX9yoViEFglJjRGJAix+gpJBb3izfqpGQL8DOefShjrGI7//2XM9xwRx03XE
	 lemQEdprgITg9qKXsgp1H0eeRAz1nzPtY3r/5b0eQyFLBLxHzXQXWk2L6MToJaZJYXIhI
	 RgJt5vk8ep1Vl6L7cuy6vW4uPIzLlwteykhP1pwgqD0e17bx/1O93anUCftef+9Pe1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795358942;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM2-Signature:Message-Instance:DKIM-Signature:X-UI-Sender-Class:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8W3c9BKqyW7quJHNPMfDXWIlVh4I5JctBnX9qZ+/ThI=;
	b=Ju5patgUSTCqTwphL/34GadKV5SWkm4FFsav9iqhuiT1IoMP+S4XpMShGpyqGGFxogbb
	 puRyzs9iv1zU8JX9YfV/dPx0DhinrLMRPzQcxQrds2lxCkRIQRKrROROzzzfLMNOT3aH/
	 e/SjN60hBkHCWQgSJtp302M8YTQW4gwjAzN8atUqHoJmyAYUMZl/RaT/6AeNbL7xrULln
	 /KPHNtwkFFMTUfcdHT21925EXGqcHXOQNEwH2Xd7NKVMEfl1iFtvxfYcSWjmxe+5YPkNl
	 NQ40pi3p52NkO/DSf5LSvXeJbNAnmpSmPXtcbRT0nCfUaBxCpQPDpUORrEL6q6iLYgw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmx.de;
	dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=rDmulnRP;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795358942;
	bh=8W3c9BKqyW7quJHNPMfDXWIlVh4I5JctBnX9qZ+/ThI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EUjjVAOtnc/hjSXOcxGqrnmC798L8GRoWyqTGslE9cEy/Oig5oSayXTj6R+EpFscY
	 HMs9viWzESR1R5p0pW6fUW1dlKcyxbtY18WnF5QHtTdnAG5dtUaLz8lghtq/0NYWiu
	 2cl/nY9Anm7XidNiBD48oKbk/lzBL+N60fheaabFml5V1juclGxMRokznedf3Dczuv
	 ZsX9UDhW7BbT5EkTmHGnxatos3VTMEouETgV55XvWg3HGBAC9xbOHtZ4NM+/Sgh1Q5
	 LmyDtnCVLoKYFvsagQv5SIU9+7rop0OMsdkw+4OZF3UgTwrPWEWacWz/3/98nX/nT6
	 LM/zzm4zWK3Rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56A1880D1A;
	Sun, 22 Nov 2026 14:49:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B4BA3371
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 14:49:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A08C80D1A
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 14:49:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EImzJLenUlDs for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 14:48:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B353980D10
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.15.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.18;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=rDmulnRP
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B353980D10
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 14:48:57 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795358935; mf=PHh5cHJvbi5nbHBrQGdteC5kZT4=;
 rt=PHUtYm9vdEBsaXN0cy51LWJvb3QtcHJvamVjdC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:mLGqQDB9f1oyaSQkYf3a8cHYoAqD
 yboF0gjZ2yPQqhzz4CCVZhS1U0VRtYDlJDfVn/vRKyk8aGvlzPFKNQyQm4IsR7VjbfLQMurMJcw
 oxRAd/fEfFKv+Pz7zFBsKHAap3LcxjDOBzrP1WejDQRimsrpybBUZVgLcjQu+xW9xgbs6xVcRKU
 ls9siXtbuHOa0U+nGay8SqXbkLrDJYA6TXpNvV3OBr7aZK7uQCAsMyQf3Bp3et43aGatXKIeu43
 j7IOSiU/HZDdMLzrlMhoOCuqd+E2StKAul1uWlfNxYQYnMdLUr/a0t5380dHW4htR+2wq7XepNx
 SNcvuMGq49HyOg==;
Message-Instance: m=1; h=sha256: 8OQISym0EmOelqYS9qvnaDPvo0IYPfVzlJuLtkyy/Oc=:
 K7M/+cA8WPzn+l0AxUNIdWk93S7EMrpQR+Q4bORHwfY=, sha512:
 znzNmGf77+Xba+XsiqAILMLUgI27kF+GgKVuac1wWtFA+kNgOVFGCOkvSLUqEsU4ylW7tPAnqFDzMsrFDwG/SA==:
 QU5ClOn3Cs2zIm6KwKCTIElMNtuBiA4Pk3XGiot//DEaFB6Z6CmoqGVzmshH2UW3rNulDVZQy8XbMEyI36/MgQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795358932; x=1795963732; i=xypron.glpk@gmx.de;
 bh=8W3c9BKqyW7quJHNPMfDXWIlVh4I5JctBnX9qZ+/ThI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rDmulnRPhXRXzR0M7P0IWtcQiYQjcN42Eup/L5dtFj1qE1YSbTWZR3fVHj3v/ham
 Ul53Ve/qt6jJXZhlbvcxA98laGwV4mmW1jZsHAcyFfWQB6oanaTa67PVoMiaBqVMd
 LytL37EwmnI/LVC6MjlBLO5RbnH0EOULCy3ssoI4TYrm/DZuJhaQpzzSvW6AaNDP2
 6OPymOETkA4RG4jPcOBPKIi53FQ43X94d5sLdgklB3yiVXRY868/pOR2aEKFT1uUz
 QHg+Z5E9bbmtc/oP3cR7Z0sDzQPdK4UG3/WGR1OM+nGNYBn1s86N7N9PwhbeNfDc/
 j+VPqNCtXMP8lqjyFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQv8n-1xrVbf015T-00Kktf; Sun, 22
 Nov 2026 15:48:52 +0100
Message-ID: <f7d1db26-161f-4748-92bd-d81a341a7a99@gmx.de>
Date: Sun, 22 Nov 2026 15:48:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: prevent PE header and section RVA overflows
To: George Kola <georgekola@google.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Alexander Graf <agraf@csgraf.de>,
 u-boot@lists.u-boot-project.org, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>
References: <CAOTQ16Jz3KphYO54zYA6YG-b7s8AbrKXLHmZ86WuRv4DhqRvSA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAOTQ16Jz3KphYO54zYA6YG-b7s8AbrKXLHmZ86WuRv4DhqRvSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VctRodx4oH7TLkTgvQebJ0rXs31z6ylKnyqSXbVsOyBbS/XH2xJ
 qjOAh6p+EA7cBsN2vIuz+LI0aExOzwibTwZ9lNegXlfbW7AcE6cBCEAigkfrkm6TnbHyh5p
 NLjqZ7SZlFJbqpo6cROfTgi+Q0+UNEQ81F/piQa9icx21/7G2NLb7E9E+Ykc2UqGyaedlAG
 JjVhkhBcYNPHz8sOxqqEQ==
UI-OutboundReport: notjunk:1;M01:P0:C+qYZtafeSg=;RJaLddQ5s502ztVkv7XmsVcKObT
 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
 bqgR9Eqdoz5nz4BbuaUe/gKAXAW8cM=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/15/26 18:12, George Kola wrote:
> In efi_load_pe(), sec->VirtualAddress + section_size(sec) is evaluated
> in 32-bit unsigned arithmetic before promotion to unsigned long,
> allowing a crafted PE-COFF section to wrap virt_size and write out of
> bounds. In addition, e_lfanew, SizeOfOptionalHeader, section alignment,
> AddressOfEntryPoint, and DataDirectory bounds are not validated before
> dereferencing headers or copying raw section data.
>=20
> Validate e_lfanew bounds and alignment in efi_check_pe(), and verify
> SizeOfOptionalHeader, section table alignment, and section count
> against efi_size before pointer arithmetic in efi_load_pe(). Compute
> section end offsets in 64-bit arithmetic, reject 32-bit RVA or unsigned
> long overflows, validate raw section offsets, skip zero-length raw
> section memcpy() calls, and verify optional header DataDirectory and
> entry point bounds before copying validated headers_size.
>=20
> Fixes: cb149c66342c ("efi_loader: Add PE image loader")
> Signed-off-by: George Kola <georgekola@google.com>
> ---
>   lib/efi_loader/efi_image_loader.c | 123 +++++++++++++++++++++++++-----
>   1 file changed, 103 insertions(+), 20 deletions(-)
>=20
> diff --git a/lib/efi_loader/efi_image_loader.c
> b/lib/efi_loader/efi_image_loader.c
> index f9a2d2df40..11798c6c71 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -849,7 +849,10 @@ efi_status_t efi_check_pe(void *buffer, size_t
> size, void **nt_header)
>   	 * least one section header follows we only need to check for the len=
gth
>   	 * of the 64bit header which is longer than the 32bit header.
>   	 */
> -	if (size < dos->e_lfanew + sizeof(IMAGE_NT_HEADERS32))
> +	if (size < sizeof(IMAGE_NT_HEADERS32) ||
> +	    dos->e_lfanew < sizeof(*dos) ||
> +	    !IS_ALIGNED(dos->e_lfanew, sizeof(u32)) ||
> +	    dos->e_lfanew > size - sizeof(IMAGE_NT_HEADERS32))

Hello George,

Thanks a lot for your patch which addresses valid concerns.

Please, use `git send-email` for your next version. Your current mail=20
contains superfluous line feeds which makes it invalid as patch.

In the generic case buffer is an unaligned pointer.

The UEFI spec does not require images passed to LoadImage() to be=20
aligned. U-Boot's load commands don't provide any alignment guarantees=20
either.

EDK II circumvents the problem of buffer alignment by either using=20
CopyMem() or ReadUnaligned32() in case of certificate checks.

For your check to work in the current U-Boot code you would need to=20
first check the alignment of buffer. This check should come before even=20
checking the COFF magic.

The alignment tolerance depends on the architecture. x86 may just work=20
fine with misalignment while ARM might crash.

Please, clearly mention in the commit messages that the alignment checks=
=20
are not required by the PE-COFF or UEFI specification but are U-Boot's=20
choice based on the C ABI of the host.

It might make sense to add alignment requirements for LoadImage() in the=
=20
UEFI or in the EBBR specification.

>   		return EFI_INVALID_PARAMETER;
>   	nt =3D (IMAGE_NT_HEADERS32 *)((u8 *)buffer + dos->e_lfanew);
>=20
> @@ -897,7 +900,7 @@ efi_status_t efi_load_pe(struct
> efi_loaded_image_obj *handle,
>   			 struct efi_loaded_image *loaded_image_info)
>   {
>   	IMAGE_NT_HEADERS32 *nt;
> -	IMAGE_DOS_HEADER *dos;
> +	IMAGE_DOS_HEADER *dos =3D efi;
>   	IMAGE_SECTION_HEADER *sections;
>   	int num_sections;
>   	void *efi_reloc;
> @@ -906,6 +909,9 @@ efi_status_t efi_load_pe(struct
> efi_loaded_image_obj *handle,
>   	unsigned long rel_size;
>   	int rel_idx =3D IMAGE_DIRECTORY_ENTRY_BASERELOC;
>   	uint64_t image_base;
> +	size_t opt_size;
> +	size_t headers_size;
> +	size_t sec_offset;
>   	unsigned long virt_size =3D 0;
>   	int supported =3D 0;
>   	efi_status_t ret;
> @@ -929,14 +935,20 @@ efi_status_t efi_load_pe(struct
> efi_loaded_image_obj *handle,
>   	}
>=20
>   	num_sections =3D nt->FileHeader.NumberOfSections;
> -	sections =3D (void *)&nt->OptionalHeader +
> -			    nt->FileHeader.SizeOfOptionalHeader;
> -
> -	if (efi_size < ((void *)sections + sizeof(sections[0]) * num_sections
> -			- efi)) {
> +	opt_size =3D nt->FileHeader.SizeOfOptionalHeader;
> +	sec_offset =3D (size_t)((u8 *)&nt->OptionalHeader - (u8 *)efi);
> +	if (opt_size > efi_size - sec_offset) {
> +		log_err("Optional header exceeds image size\n");
> +		return EFI_LOAD_ERROR;
> +	}
> +	sec_offset +=3D opt_size;
> +	if (!IS_ALIGNED(sec_offset, sizeof(u32)) ||
> +	    (size_t)num_sections > (efi_size - sec_offset) / sizeof(sections[0=
])) {
>   		log_err("Invalid number of sections: %d\n", num_sections);

This message is misleading for an alignment problem.


According to an AI review the following issues are not addressed:

1. Authentication and measurement run before the new checks.

    efi_image_authenticate() is called before the section loop. With
    secure boot enabled it goes through efi_image_parse(), which
    still trusts SizeOfHeaders, PointerToRawData and SizeOfRawData
    ('efi + opt->SizeOfHeaders', 'efi + PointerToRawData + size')
    and uses SizeOfOptionalHeader unchecked to find the sections.
    tcg2_hash_pe_image() also calls efi_image_parse(), and
    tcg2_measure_pe_image() computes 'efi + dos->e_lfanew' without
    a check. I found this by reading the code; I did not run it with
    secure boot enabled. The validation should happen before
    authentication and measurement, or efi_image_parse() needs the
    same bounds.

2. SizeOfHeaders and SizeOfImage are never checked.

    [PE]: SizeOfHeaders is "the combined size of an MS-DOS stub, PE
    header, and section headers rounded up to a multiple of
    FileAlignment"; SizeOfImage "must be a multiple of
    SectionAlignment"; section VAs "must be assigned by the linker so
    that they are in ascending order and adjacent". [EDK2] rejects
    sections whose data starts below SizeOfHeaders
    (BasePeCoff.c:501-502) and SizeOfHeaders >=3D SizeOfImage (:239).
    After this patch overlapping sections cannot write out of bounds,
    so I do not request these checks. But a SectionAlignment that is
    not a power of two is reported as "Out of memory", because
    efi_alloc_aligned_pages() returns NULL.

3. The commit message says "section alignment" is validated. What is
    validated is the position of the section table, not
    SectionAlignment or FileAlignment.

   [PE]   Microsoft "PE Format",
          https://learn.microsoft.com/en-us/windows/win32/debug/pe-format
   [EDK2] MdePkg/Library/BasePeCoffLib/BasePeCoff.c

Best regards

Heinrich

>   		return EFI_LOAD_ERROR;
>   	}
> +	sections =3D (void *)((u8 *)efi + sec_offset);
> +	headers_size =3D sec_offset + (size_t)num_sections * sizeof(sections[0=
]);
>=20
>   	/* Authenticate an image */
>   	if (efi_image_authenticate(efi, efi_size)) {
> @@ -946,18 +958,39 @@ efi_status_t efi_load_pe(struct
> efi_loaded_image_obj *handle,
>   		log_err("Image not authenticated\n");
>   	}
>=20
> +	virt_size =3D headers_size;
> +
>   	/* Calculate upper virtual address boundary */
>   	for (i =3D num_sections - 1; i >=3D 0; i--) {
>   		IMAGE_SECTION_HEADER *sec =3D &sections[i];
> +		u32 copy_size =3D min(section_size(sec), sec->SizeOfRawData);
> +		u64 sec_end =3D (u64)sec->VirtualAddress + section_size(sec);
>=20
> +		if (sec_end > U32_MAX || sec_end > ULONG_MAX) {
> +			log_err("Section %d virtual address overflow\n", i);
> +			return EFI_LOAD_ERROR;
> +		}
> +		if (copy_size &&
> +		    ((u64)sec->PointerToRawData + copy_size > efi_size)) {
> +			log_err("Section %d exceeds image size\n", i);
> +			return EFI_LOAD_ERROR;
> +		}
>   		virt_size =3D max_t(unsigned long, virt_size,
> -				  sec->VirtualAddress + section_size(sec));
> +				  (unsigned long)sec_end);
>   	}
>=20
>   	/* Read 32/64bit specific header bits */
>   	if (nt->OptionalHeader.Magic =3D=3D IMAGE_NT_OPTIONAL_HDR64_MAGIC) {
>   		IMAGE_NT_HEADERS64 *nt64 =3D (void *)nt;
>   		IMAGE_OPTIONAL_HEADER64 *opt =3D &nt64->OptionalHeader;
> +
> +		if (!IS_ALIGNED(dos->e_lfanew, sizeof(u64)) ||
> +		    opt_size < offsetof(IMAGE_OPTIONAL_HEADER64, DataDirectory) ||
> +		    opt->AddressOfEntryPoint >=3D virt_size) {
> +			log_err("Invalid 64-bit optional header\n");
> +			ret =3D EFI_LOAD_ERROR;
> +			goto err;
> +		}
>   		image_base =3D opt->ImageBase;
>   		efi_set_code_and_data_type(loaded_image_info, opt->Subsystem);
>   		handle->image_type =3D opt->Subsystem;
> @@ -970,10 +1003,40 @@ efi_status_t efi_load_pe(struct
> efi_loaded_image_obj *handle,
>   			goto err;
>   		}
>   		handle->entry =3D efi_reloc + opt->AddressOfEntryPoint;
> -		rel_size =3D opt->DataDirectory[rel_idx].Size;
> -		rel =3D efi_reloc + opt->DataDirectory[rel_idx].VirtualAddress;
> +		if (opt->NumberOfRvaAndSizes > (u32)rel_idx) {
> +			if (opt_size < offsetof(IMAGE_OPTIONAL_HEADER64,
> +						DataDirectory[rel_idx + 1])) {
> +				efi_free_pages((uintptr_t)efi_reloc,
> +					       (virt_size + EFI_PAGE_MASK) >>
> +					       EFI_PAGE_SHIFT);
> +				ret =3D EFI_LOAD_ERROR;
> +				goto err;
> +			}
> +			rel_size =3D opt->DataDirectory[rel_idx].Size;
> +			if (rel_size &&
> +			    ((u64)opt->DataDirectory[rel_idx].VirtualAddress +
> +			     rel_size > virt_size)) {
> +				efi_free_pages((uintptr_t)efi_reloc,
> +					       (virt_size + EFI_PAGE_MASK) >>
> +					       EFI_PAGE_SHIFT);
> +				ret =3D EFI_LOAD_ERROR;
> +				goto err;
> +			}
> +			rel =3D efi_reloc +
> +			      opt->DataDirectory[rel_idx].VirtualAddress;
> +		} else {
> +			rel_size =3D 0;
> +			rel =3D NULL;
> +		}
>   	} else if (nt->OptionalHeader.Magic =3D=3D IMAGE_NT_OPTIONAL_HDR32_MA=
GIC) {
>   		IMAGE_OPTIONAL_HEADER32 *opt =3D &nt->OptionalHeader;
> +
> +		if (opt_size < offsetof(IMAGE_OPTIONAL_HEADER32, DataDirectory) ||
> +		    opt->AddressOfEntryPoint >=3D virt_size) {
> +			log_err("Invalid 32-bit optional header\n");
> +			ret =3D EFI_LOAD_ERROR;
> +			goto err;
> +		}
>   		image_base =3D opt->ImageBase;
>   		efi_set_code_and_data_type(loaded_image_info, opt->Subsystem);
>   		handle->image_type =3D opt->Subsystem;
> @@ -986,8 +1049,31 @@ efi_status_t efi_load_pe(struct
> efi_loaded_image_obj *handle,
>   			goto err;
>   		}
>   		handle->entry =3D efi_reloc + opt->AddressOfEntryPoint;
> -		rel_size =3D opt->DataDirectory[rel_idx].Size;
> -		rel =3D efi_reloc + opt->DataDirectory[rel_idx].VirtualAddress;
> +		if (opt->NumberOfRvaAndSizes > (u32)rel_idx) {
> +			if (opt_size < offsetof(IMAGE_OPTIONAL_HEADER32,
> +						DataDirectory[rel_idx + 1])) {
> +				efi_free_pages((uintptr_t)efi_reloc,
> +					       (virt_size + EFI_PAGE_MASK) >>
> +					       EFI_PAGE_SHIFT);
> +				ret =3D EFI_LOAD_ERROR;
> +				goto err;
> +			}
> +			rel_size =3D opt->DataDirectory[rel_idx].Size;
> +			if (rel_size &&
> +			    ((u64)opt->DataDirectory[rel_idx].VirtualAddress +
> +			     rel_size > virt_size)) {
> +				efi_free_pages((uintptr_t)efi_reloc,
> +					       (virt_size + EFI_PAGE_MASK) >>
> +					       EFI_PAGE_SHIFT);
> +				ret =3D EFI_LOAD_ERROR;
> +				goto err;
> +			}
> +			rel =3D efi_reloc +
> +			      opt->DataDirectory[rel_idx].VirtualAddress;
> +		} else {
> +			rel_size =3D 0;
> +			rel =3D NULL;
> +		}
>   	} else {
>   		log_err("Invalid optional header magic %x\n",
>   			nt->OptionalHeader.Magic);
> @@ -1010,11 +1096,7 @@ efi_status_t efi_load_pe(struct
> efi_loaded_image_obj *handle,
>   #endif
>=20
>   	/* Copy PE headers */
> -	memcpy(efi_reloc, efi,
> -	       sizeof(*dos)
> -		 + sizeof(*nt)
> -		 + nt->FileHeader.SizeOfOptionalHeader
> -		 + num_sections * sizeof(IMAGE_SECTION_HEADER));
> +	memcpy(efi_reloc, efi, headers_size);
>=20
>   	/* Load sections into RAM */
>   	for (i =3D num_sections - 1; i >=3D 0; i--) {
> @@ -1026,9 +1108,10 @@ efi_status_t efi_load_pe(struct
> efi_loaded_image_obj *handle,
>   			memset(efi_reloc + sec->VirtualAddress, 0,
>   			       sec->Misc.VirtualSize);
>   		}
> -		memcpy(efi_reloc + sec->VirtualAddress,
> -		       efi + sec->PointerToRawData,
> -		       copy_size);
> +		if (copy_size)
> +			memcpy(efi_reloc + sec->VirtualAddress,
> +			       efi + sec->PointerToRawData,
> +			       copy_size);
>   	}
>=20
>   	/* Run through relocations */


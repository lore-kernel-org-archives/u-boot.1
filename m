Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DDFE7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 08:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92DFE891B1;
	Thu,  5 Dec 2024 09:34:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="r7/Egkuk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC582891E1; Thu,  5 Dec 2024 09:34:50 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2ED38916E
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 09:34:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733387683; x=1733992483; i=xypron.glpk@gmx.de;
 bh=NSrS+Z/P6eeQhDgUJ8nWF0ESHbsGNEj+83boJEZLWKw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=r7/EgkukpceBRfH3p97+R0R9CW1rxpodf+hfeK1Fupm6dQt8qzDDn37BERQwrAJt
 PBfhTAnCU2keTuGwBhB2Ge1TNTdpe41KRuTiUwiX5M+DP3lmvwoVnNAEgKd6rJET8
 /8imSD5YgAAL6gU9HynU9+qmI/ZE8Ll3EdP/UWl2fApNxYQvB+buhIqEshKctHkya
 YisKklSjhoxBg4o+uuvDYxy/Mo3m17MYQlWftZR1wneNOEmX4i7CHG0dJouWiYPx9
 gGQh8qWeYeOvTPr9cR7610chsDPHHYWBWXUYTn6bYhHT82PJKf+3YD37gaQQErDCo
 2smWQ434X3bROaw8tw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNt0C-1szH9n1aBc-00PgQA; Thu, 05
 Dec 2024 09:34:43 +0100
Message-ID: <899c2551-a0ae-4183-aad0-7adebcd5f84d@gmx.de>
Date: Thu, 5 Dec 2024 09:34:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: fix pe reloc pointer overrun
To: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <SA1PR18MB56923B0952E67CC949A90A02992A2@SA1PR18MB5692.namprd18.prod.outlook.com>
 <4492be69-8655-4391-8a44-3b4cb682c3ec@gmx.de>
 <SA1PR18MB56923C88AAAC2CEEC6AA869099302@SA1PR18MB5692.namprd18.prod.outlook.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <SA1PR18MB56923C88AAAC2CEEC6AA869099302@SA1PR18MB5692.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UOpzfzQUxNRUqRK7sxIFJqHC75VoHfp1Y+g5HSkzAZT60qugiS1
 aUkLDhk31c6HDcGlu8s+thFiCfJakaTlRrjVxvHPRNdX1zffkwdLIsmhG65t6iNF7sFLTEB
 nKjI5ITyKHWC1g14wuEnjfxuyrDTg4RgoOZhetX7FpwLJgbuTIUUkCgedbfoPNTXx4CDyL+
 HLe+NEtuY8gSY0j08+T2w==
UI-OutboundReport: notjunk:1;M01:P0:CYf1JmSgnYE=;ugUIYy+Q0QHNuSAL4I9fHd9NyrH
 6eFUkAUurD9E5Bf6H3pqfnL3DleJivVzlJsOUAzBRwJm10Uo1C3FzQZZO+O6n8v88mRWokM/Q
 HsPhz1oTmDhD0N6UlESLmcaFT8M4ifQwdRb4xc5iWQbCanTTm7a9Kk+ybhSNs2vB6h5Aw4M8l
 3s02FAyi1W1SGzP8PvueJkwLLccUbS6+djUbn8yO47KGS4gIU5IGu2RmQ1eqvpqN4qmVcjvyy
 lyxg79JVr1TJIiDp1XFpHa51JHrtYjTx4vIOaO/SMnIvg30FSpdtyeBv2CQqhkpYOCwgXlbnu
 cvw+dvKMgu7m+UW4vMSiK9qpjehzr4Eb4ZRqz/m/Ra9bdV+60/nSva33/YKaGwsel8R+1cu4B
 7JjECS9yWHM+J+CXIjCDnZutsIKk96wRVeBh4+/aYgyor685MDg4aBI8vhWylk9nn1ch9T/Lk
 qr6HCVWNix8h02iM1/kvJZ0zo63B9bzU9L8qFPK/HF4/BN0ja5OxC6xaRC5IUCODHp5Vn/3bq
 RRWZIUr8Qko0BDVqiYn4BHoCTTd3f+jS9Oubi8cwteJ0h59lEzml7P960QaDDWIRZ+YZT0BAg
 1essGduQ1YWcjn2bTatHZM+2NxxT+o55iVPrr5AzCoPWiRJznGfa1EUouElKqOjpqXgrVMuv2
 mos8pEDguh8B7QUOcNYRFBbf5In5VdKH7se+OIVqctfn2hNApO1YHwDAcIHuXLfoJe9y7IvKE
 CBoinWkW8zWY0GBDelhCOBbD1VXMrETPk8wt0YXbJSPR/SaHeyKo8FydTOSlx1OTK5ylEfmt9
 88HVVnIACrB4tNdqodXAb5v+rMvXthijlkxwpmd7vPjc0h/Ei/a1fOrNDldwn5iDaDun7sr/D
 53VfZ4O9Mck4Acobj2KnvEBXJyUndS+b/M8C6KSRm2ymzdpL2APz+Th2Ibx320dWPF9YJCIOu
 CebpQ9I6GjU4xf/fsv7e+2yrg8ZdiY+4sPonuQAmYNrCaPcm9w/cSNkQsh5t8vpM6RZhLuLDM
 tRYyfw9TUzz+ev+qfN8AJRRv4tF/F+Rh7TqJRnu/gACwdlbHCj3V3Mk3Qv8uAXkR9mv/I/RtW
 MCTN1OFHEQNcTcLLfsv90gtQtdaYQZ
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

On 05.12.24 09:13, Aleksandar Gerasimovski wrote:
> Thanks for the replay,
>
>> Sections have to be at least 512 bytes aligned. The file alignment
>> cannot be smaller the 512 bytes either.
>
>> Hence for a valid EFI binary the value of "rel" when entering
>> efi_loader_relocate() will always be at least 512 aligned.
>
> That's not what I see in the case that I try to explain, because
> the sec->Misc.VirtualSize virtual size is 16 bytes for this section .
>
>> The situation above cannot occur if you follow the specification and
>> zero fill the raw data up to SizeOfRawData which is a multiple of 512.
>
> Correct, I see in the efi_load_pe code that section will be zeroed
> If sec->Misc.VirtualSize is bigger then sec->SizeOfRawData, but
> this is not a case for our image it's oposite.
> I can also confirm that in the real image the section is zeroed up to
> sec->SizeOfRawData, but the problem is that only the sec->Misc.VirtualSi=
ze
> (that is 16 bytes for my image) is copied to the "efi_reloc" location.
>
> I'm far from really understanding the PE format, actually this is first
> time to deal with this and efi boot on Linux, however our EFI image is
> generated with a "standard" tools like  bg_gen_unified_kernel by our
> yocto based distro generator, so in any case I see a nasty bug.
> Even if the image is wrong it should be rejected earlier and not overflo=
wing
> even overwriting the u-boot code. It's a vulnerability.
>
>> Please, provide an example image for download to give the full picture.
>
> I must think how to do that, where I could upload?
>
>> With "rel + 1 < end" you are not preserving the change but reverting it=
.
>
> Well, this is the tricky part, in my understanding not because rel is mo=
ving
> by 2 bytes down in the loop.
>
> I'm trying to describe the problem again, let's say in my image the prob=
lematic section
> is generated with sec->Misc.VirtualSize =3D 16 and sec->SizeOfRawData =
=3D 512, what will be
> provided to the efi_loader_relocate in this case is rel_size of 16 and o=
nly 16 bytes will
> be copied to efi_reloc location (see the " Load sections into RAM" logic=
 in efi_load_pe),
> so the content of the RAM after efi_reloc + 16 stays unknown:
> bce26000: 3000 0000 000c 0000 0000 0000 0000 0000 -> reloc section
> bce26010: 7c00 9340 67e0 f900 1c00 0ea1 a400 0f20 -> random content
>
> So efi_loader_relocate gets rel_size of 16 bytes for reloc section of 12=
 bytes,
> and this will overflow.

If VirtualSize =3D 16, then the reloc section has 16 bytes and not 12.

A section size of less than 512 is invalid anyway.

Something is wrong with the tooling that you use to create the EFI binary.

>
> When I'm writing this, I'm thinking isn't then rel_size problem as well,
> that is 16 bytes in this case?
>
> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Sent: Mittwoch, 4. Dezember 2024 11:11
> To: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>
> Cc: u-boot@lists.denx.de; Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Subject: Re: [PATCH] efi_loader: fix pe reloc pointer overrun
>
>
> On 29.11.24 22:09, Aleksandar Gerasimovski wrote:
>> The fix provided by 997fc12ec91 is actually introducing
>> a buffer overrun, and the overrun is effective if the
>> memory after the reloc section is not zeroed.
>> Probably that's why this bug is not always noticeable.
>>
>> The problem is that 8-bytes 'rel' pointer can be 4-bytes aligned
>> according to the PE Format, so the actual relocate function can
>> take values after the reloc section.
>
> Sections have to be at least 512 bytes aligned. The file alignment
> cannot be smaller the 512 bytes either.
>
> Hence for a valid EFI binary the value of "rel" when entering
> efi_loader_relocate() will always be at least 512 aligned.
>
>>
>> One example is the following dump from the reloc section:
>>     bce26000: 3000 0000 000c 0000 0000 0000 0000 0000
>>     bce26010: 7c00 9340 67e0 f900 1c00 0ea1 a400 0f20
>
> Please, provide an example image for download to give the full picture.
>
>>
>> This section has two relocations at offset bce26008 and bce2600a,

Starting at bce26008 you have eight zero bytes with this structure:

typedef struct _IMAGE_BASE_RELOCATION
{
         uint32_t VirtualAddress;
         uint32_t SizeOfBlock;
         /* WORD TypeOffset[1]; */
} IMAGE_BASE_RELOCATION,*PIMAGE_BASE_RELOCATION;

The loop stops if rel->SizeOfBlock =3D=3D 0.

"two relocations at offset bce26008 and bce2600a" cannot be true.

Best regards

Heinrich

>> however the given size (rel_size) for this relocation is 16-bytes
>
> The value of "rel_size" used to calculate "end" is not the size of a
> relocation but the size of the relocation table.
>
> The PE-COFF specification describes:
>
> "SizeOfRawData
>
> The size of the section (for object files) or the size of the
> initialized data on disk (for image files). For executable images, this
> must be a multiple of FileAlignment from the optional header. If this is
> less than VirtualSize, the remainder of the section is zero-filled."
>
> The situation above cannot occur if you follow the specification and
> zero fill the raw data up to SizeOfRawData which is a multiple of 512.
>
>> and this is coming form the efi image Misc.VirtualSize, so in this
>> case the 'reloc' pointer ends at affset bce2600c and is taken as
>> valid and this is where the overflow is.
>>
>> In our system we see this problem when we are starting the
>> Boot Guard efi image.
>>
>> This patch is fixing the overrun while preserving the fix done
>> by 997fc12ec91.
>
> Before 997fc12ec91 we had "rel < end - 1".
>
> With "rel + 1 < end" you are not preserving the change but reverting it.
>
> Best regards
>
> Heinrich
>
>>
>> Signed-off-by: Aleksandar Gerasimovski <mailto:aleksandar.gerasimovski@=
belden.com>
>> ---
>>    lib/efi_loader/efi_image_loader.c | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_ima=
ge_loader.c
>> index 0ddf69a091..04075d83cb 100644
>> --- a/lib/efi_loader/efi_image_loader.c
>> +++ b/lib/efi_loader/efi_image_loader.c
>> @@ -121,7 +121,7 @@ static efi_status_t efi_loader_relocate(const IMAGE=
_BASE_RELOCATION *rel,
>>                   return EFI_SUCCESS;
>>
>>           end =3D (const IMAGE_BASE_RELOCATION *)((const char *)rel + r=
el_size);
>> -       while (rel < end && rel->SizeOfBlock) {
>> +       while (rel + 1 < end && rel->SizeOfBlock) {
>>                   const uint16_t *relocs =3D (const uint16_t *)(rel + 1=
);
>>                   i =3D (rel->SizeOfBlock - sizeof(*rel)) / sizeof(uint=
16_t);
>>                   while (i--) {
>> --
>> 2.34.1
>>
>> **********************************************************************
>> DISCLAIMER:
>> Privileged and/or Confidential information may be contained in this mes=
sage. If you are not the addressee of this message, you may not copy, use =
or deliver this message to anyone. In such event, you should destroy the m=
essage and kindly notify the sender by reply e-mail. It is understood that=
 opinions or conclusions that do not relate to the official business of th=
e company are neither given nor endorsed by the company. Thank You.
>
>
> **********************************************************************
> DISCLAIMER:
> Privileged and/or Confidential information may be contained in this mess=
age. If you are not the addressee of this message, you may not copy, use o=
r deliver this message to anyone. In such event, you should destroy the me=
ssage and kindly notify the sender by reply e-mail. It is understood that =
opinions or conclusions that do not relate to the official business of the=
 company are neither given nor endorsed by the company. Thank You.


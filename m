Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B174DC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 16:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34BD88785F;
	Sun, 31 Dec 2023 17:14:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cvXNXyCf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2545E878A4; Sun, 31 Dec 2023 17:14:30 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2728A8785E
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 17:14:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704039266; x=1704644066; i=xypron.glpk@gmx.de;
 bh=Vcs104bSfOSc39zBUb90ig0/6pE91XYi78UdOWaM3Sc=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
 In-Reply-To;
 b=cvXNXyCfHjDKbVOCZuUNH9kyahFxMiw36nCr59MlFa6320tbYmQtaDISVAd4BX+a
 xXnEdATXz6/Z4TzUEYuUTdVMPQiL/+i1G1cMY489PxF21pJUx4lAQcXlvDvCn0nDC
 wyRn1QBng9kksvpSf9eOy89QSmiJrvU/O4Ainwm3dxL8Q201dldtBIgfFtpxNNPUY
 iOWZmPLfBPVFm7J7AiQVVTSgWZ7g9TfMyposWwhITVsfZQHpcsTINFLbpBUptTyhK
 OLzJ9J2m3vHx9KvkMBGRnvzCGGvt2yQZ3GLACp7mHGNmM2hLSQEhkD0tcdVzmlWko
 hulXBs7GGXFoeKrFzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8XPn-1r6RoB1xbN-014QyI; Sun, 31
 Dec 2023 17:14:26 +0100
Message-ID: <2d61b84d-9e1c-450b-8ccc-b8c166d4cda6@gmx.de>
Date: Sun, 31 Dec 2023 17:14:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] smbios: Use SMBIOS 3.0 to support an address
 above 4GB
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231231152555.464874-1-sjg@chromium.org>
 <20231231152555.464874-5-sjg@chromium.org>
 <b11c19c1-7ca6-468c-9355-7b9461a628df@gmx.de>
In-Reply-To: <b11c19c1-7ca6-468c-9355-7b9461a628df@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kkjW+heQPvAvDC9NGTTpFZ5rMj1CcXu8o0olvDOkScFoyveYBcU
 dfCb4cbKuURmD5B/33U0IcH49W4IyTh6Qg2+6HCWMMrw79rTGajybRXZcP4hoISzo+gSD+S
 LRhuJP1gxVTIwKrWnolCTD6Yf5uAloyrtNz1cXZV9HMQDOi+ebnhQytcIv8vnBDRuufNVOm
 OXsuEKIOIqr4zspiAWkxg==
UI-OutboundReport: notjunk:1;M01:P0:og00Awhvry0=;9LCbZuxiqY8ijNLzLF7jz5QuFgc
 qIsLblL2nzFwy2WzLzGGz0THY8L48z9PobyozxET1iaWiMmNJSH5Wr3hu3cAkJ1kZ687ZY2lN
 j9Vf9Ab2IWZIUZgNzgw6PgXQkZPEInU1MIZ6DSLmQD9j3iwj019BEm//h4sSo9RA1gUb7743A
 W8EVQ8LDkYX3p+YFOb6W8MO+nrXy5Zh4e+AYJrKSOrH3RJA5uPL7hz1Eu7I2Mt3PHzRpIYimo
 gUtdGiiRWc70s3NpNKyZo2RzLMiSCZESi6E3e6IJSCnY90P7ycNw3ku7wkj0dcqIokx2Ym+pI
 4EZB8p9AiN5CBLD0rDiP4BwZn7RD/F52OQlqFN75PirJq5GbXGVFuevT6GAMcKacb9noOz8H7
 3JNkPZvMxbyQbIMHeXyA7aJGDizSKG7JzpI8BlhPWsI5EIChFyTYQ2vtP4EArQTnpPSvQ/PjJ
 q8KPclsJcX/Smqki+lLQstqTCsHjlxQPsJ7AjwOhm7wt2OcUndzrdToXMpiX02fn9oI77rU8D
 h24Y2l3+tsvPh03WLxDAWed8oIfLfqENBblkvQkACPrbXYjVqsKv745xAyXtGaC3ZMrjfNGMs
 TLkq0yddLe5XhUqO3BEk7LKduv63LREIBHtB0uVj4+LHNsMmMbQgZFjItojJ5alqdILcwg9So
 D9PA+Wdz90pReWh6u3Nobhyq6FSnUbOUO2oJ97KwGWqpobUDSxRMobAI36HGXK/D3udXfaDlo
 WzbfFuxm9XDPrPPY23hkCcpUfNwjq5v7Ja+OfUjtFvDO1ifQZzStJ2OtSUU8l+ooJTo8GF4MT
 ef/XZB4+V9y5TzXOLCyV3h4kRl9dUJDkiSrhmtgToZdYqKDJMwxIUlH5ZbbNSkEJTSiyyYDbX
 9aiC68gxx4f1bazft3xLv6aWeXbeNO74YvI6MNdmyY2I9mKvvEZLBSZde+GtRbW4J1DlZUT16
 A3hRlKjBM44npgam9tmAxYY4TkA=
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

On 12/31/23 17:11, Heinrich Schuchardt wrote:
> On 12/31/23 16:25, Simon Glass wrote:
>> When the SMBIOS table is written to an address above 4GB a 32-bit table
>> address is not large enough.
>>
>> Use an SMBIOS3 table in that case.
>>
>> Note that we cannot use efi_allocate_pages() since this function has
>> nothing to do with EFI. There is no equivalent function to allocate
>> memory below 4GB in U-Boot. One solution would be to create a separate
>> malloc() pool, or just always put the malloc() pool below 4GB.
>>
>> - Use log_debug() for warning
>> - Rebase on Heinrich's smbios.h patch
>> - Set the checksum for SMBIOS3
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> ---
>>
>> (no changes since v4)
>>
>> Changes in v4:
>> - Check the start of the table rather than the end
>>
>> Changes in v2:
>> - Check the end of the table rather than the start.
>>
>> =C2=A0 include/smbios.h |=C2=A0 6 +++++-
>> =C2=A0 lib/smbios.c=C2=A0=C2=A0=C2=A0=C2=A0 | 30 ++++++++++++++++++++++=
+++-----
>> =C2=A0 2 files changed, 30 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/smbios.h b/include/smbios.h
>> index e601283d293..77be58887a2 100644
>> --- a/include/smbios.h
>> +++ b/include/smbios.h
>> @@ -12,7 +12,7 @@
>>
>> =C2=A0 /* SMBIOS spec version implemented */
>> =C2=A0 #define SMBIOS_MAJOR_VER=C2=A0=C2=A0=C2=A0 3
>> -#define SMBIOS_MINOR_VER=C2=A0=C2=A0=C2=A0 0
>> +#define SMBIOS_MINOR_VER=C2=A0=C2=A0=C2=A0 7
>>
>> =C2=A0 enum {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SMBIOS_STR_MAX=C2=A0=C2=A0=C2=A0 =3D 64,=
=C2=A0=C2=A0=C2=A0 /* Maximum length allowed for a
>> string */
>> @@ -80,6 +80,10 @@ struct __packed smbios3_entry {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 struct_table_address;
>> =C2=A0 };
>>
>> +/* These two structures should use the same amount of 16-byte-aligned
>> space */
>> +static_assert(ALIGN(16, sizeof(struct smbios_entry)) =3D=3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ALIGN(16, sizeo=
f(struct smbios3_entry)));
>> +
>> =C2=A0 /* BIOS characteristics */
>> =C2=A0 #define BIOS_CHARACTERISTICS_PCI_SUPPORTED=C2=A0=C2=A0=C2=A0 (1 =
<< 7)
>> =C2=A0 #define BIOS_CHARACTERISTICS_UPGRADEABLE=C2=A0=C2=A0=C2=A0 (1 <<=
 11)
>> diff --git a/lib/smbios.c b/lib/smbios.c
>> index eea72670bd9..7f79d969c92 100644
>> --- a/lib/smbios.c
>> +++ b/lib/smbios.c
>> @@ -567,7 +567,11 @@ ulong write_smbios_table(ulong addr)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D ALIGN(addr, 16);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_addr =3D addr;
>>
>> -=C2=A0=C2=A0=C2=A0 addr +=3D sizeof(struct smbios_entry);
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * So far we don't know which struct will be u=
sed, but they both end
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * up using the same amount of 16-bit-aligned =
space
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 addr +=3D max(sizeof(struct smbios_entry), sizeof(s=
truct
>> smbios3_entry));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D ALIGN(addr, 16);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tables =3D addr;
>>
>> @@ -590,16 +594,32 @@ ulong write_smbios_table(ulong addr)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We must use a pointer here so th=
ings work correctly on
>> sandbox. The
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * user of this table is not aware =
of the mapping of addresses to
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * sandbox's DRAM buffer.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Check the address of the end of the tables.=
 If it is above 4GB
>> then
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * it is sensible to use SMBIOS3 even if the s=
tart of the table
>> is below
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * 4GB (this case is very unlikely to happen i=
n practice)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 table_addr =3D (ulong)map_sysmem(tables,=
 0);
>> -=C2=A0=C2=A0=C2=A0 if (sizeof(table_addr) > sizeof(u32) && table_addr =
>
>> (ulong)UINT_MAX) {
>> +=C2=A0=C2=A0=C2=A0 if (sizeof(table_addr) > sizeof(u32) && addr >=3D (=
ulong)UINT_MAX) {
>
>
> All SMBIOS specifications since version 3.0.0, published 2015, allow
> using a SMBIOS3 anchor in all cases. SMBIOS_MAJOR_VER =3D=3D 3.
>
> Our target is to keep the code size small. Why do you increase the code
> size here?

You drop SMBIOS2 in patch 8.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>
> Best regards
>
> Heinrich
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct smbios3_entry *se;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We need =
to put this >32-bit pointer into the table but the
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * field is=
 only 32 bits wide.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("WARNING: SMBIOS tab=
le_address overflow %llx\n",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (unsigned long long)table_addr);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_debug("WARNING: Using S=
MBIOS3.0 due to table-address
>> overflow %lx\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 table_addr);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 se =3D map_sysmem(start_add=
r, sizeof(struct smbios_entry));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(se, '\0', sizeof(str=
uct smbios_entry));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(se->anchor, "_SM3_",=
 5);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 se->length =3D sizeof(struc=
t smbios3_entry);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 se->major_ver =3D SMBIOS_MA=
JOR_VER;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 se->minor_ver =3D SMBIOS_MI=
NOR_VER;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 se->doc_rev =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 se->entry_point_rev =3D 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 se->max_struct_size =3D len=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 se->struct_table_address =
=3D table_addr;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 se->checksum =3D table_comp=
ute_checksum(se,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size=
of(struct smbios3_entry));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct smbios_en=
try *se;
>>
>


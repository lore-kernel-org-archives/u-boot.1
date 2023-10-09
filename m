Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5060E95A8F
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 02:43:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B557286C58;
	Mon,  9 Oct 2023 04:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="pwirKCWM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3465F86C58; Mon,  9 Oct 2023 04:43:36 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DE028638B
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 04:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696819413; x=1697424213; i=xypron.glpk@gmx.de;
 bh=jgTnENo/rKarXtXnTslTyi74q+HaEgJcoCyGJx9DpUk=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
 b=pwirKCWMWJXKZ8PSNqu+pIBiUGL2mpRlrxl40kKxLvr4LwEO5Bxl4EHriZEXYmfa/7Z+gPGaFtb
 LaG1hI7hbkUCgVFopkpj3TR90ABdblUfNLvnyWSNdVtAuhVWpjAwCssoF79TteBfn1e95D13QcEn0
 j/ylNACp+UuCrQI4OawVzz1allngKgMj+iooKDHoZbhT+dovC1ciKGaTXaUF+0x7NzNrAEgh/4HpE
 72LTsi/sNV/AWBnvfQMEERLFEbQPERjkYhDOlk6hx3idC7z/oGiZalPKD+uop/BcS6D33G0EiUhGA
 MvY5ffuf574oK0SBq0bpCKPkUeVaWQQ0P3OA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof57-1rMW1k04i1-00p2hA; Mon, 09
 Oct 2023 04:43:33 +0200
Message-ID: <4295df86-0a0b-420f-b8d2-ed5c930ea9ee@gmx.de>
Date: Mon, 9 Oct 2023 04:43:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] smbios: Use SMBIOS 3.0 to support an address above 4GB
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
References: <20231008213646.622002-1-sjg@chromium.org>
 <20231008213646.622002-4-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20231008213646.622002-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:juQICBD/LW/ABrKrvNx7bNcOi9/r4Y3TWwh3nv1ljfpgq9/7dZw
 vCYsbda3BYLfpQ6IKwH90HmruzuPc7S6HbpHNpvXWvU4TygadtDg0q4PCVNzmdiG8pJ1Rsh
 jNEUZeiqeBksqoBi+oeg5PUkepydnMPMvddmPcNNjB4rsvLxUC4G6Ygs0TRaSKR4vW6eLGe
 Tk3r7hPHDRMnSrCn37nmQ==
UI-OutboundReport: notjunk:1;M01:P0:FZF7wAFh5Rs=;WOca9Fqby9iHuk2J4FIHCAbCakL
 P9AOVWLoAVcWQsVtnkPkmOdXpgI6nr8JkTNrDZKB3qJ4AO+XtLhUrwoJUmpuBOCxLjj3tDEqF
 nKflO7tjTtoL0knsF3nUnBa+/VZxv2+uPRu5ltA5P21bcOwpmOmtymAobcNqE2/mTw2qner6O
 +q856RMk2ssH/EQWG6LIfIBhtc3BlSaQM2Ea6syRl5rbiMauCylj5VwS5K2pGTl4yh6fJXyvA
 YDBvQ9QzXOGhZydHEQ6Z+jKPHOX6ZMLsH4tRSp8/LICmQpwGCil2SXu9s7AppKz0qbSbOf4wf
 HA0ORCiI3Kx2wZ5H3DVX2h/NBR/3xxEcuDe5WXFD8fE3XN9UhfzZDOQU9iGM7N+dkFs0yc3L/
 AXfZBOkNNp3rn0q5kGjBoego/AJu1xpSPSkfnGtBJc7iKH1rYXze6jcSOfH3Vd2R2ZZKMOXzI
 LUHHD/YWKUZkDcjgejtNBTVhnz7WfJybUCDopfhClrzsXOWugoiSCdm5L3IeJke3Xrtibsjbj
 IKjrI7OjhHZHdstnZIHftfYwQDuGgQR6LhPY6IQY7ymtN3IDsTyk1bh8iVR4UGtSFbiTSWDZU
 LFWLJNQmYxlKoCAxuLt1HiZ9hzyrMsCQ/koq/dAkN+Lh/GKFndeuMQR9gw1qVoBrLdd7H4/7y
 RLeNCUrLJwpy2COfBfzgAp3tM36MJsVv7Hgx1lpL7bv0014wULVmYxonpe9KZuLPtT5qig+st
 5waIKUb417Cp0QkUl6Ks/D9iofpNANSnJY8t7H9la5jpSJctVxAK96oQzpRZXygKdqNZJqSHj
 yxnxY7EHSX0u0UhBKqBqOr9lvm17GggjELP5aj7P3HaXSD5ZqxG7VISzeVDZ8l1dVaVFCGJMD
 a6WRTqs4vScfZMYHZdXbubuEHRHeHQoJEK3tTTgeRIMmRShc5cUPqIRCfmiocJA/P9sqgIuwy
 Bdxyf86BV7XR3svJkf3gxCV9tdQ=
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

On 10/8/23 23:36, Simon Glass wrote:
> When the SMBIOS table is written to an address above 4GB a 32-bit table
> address is not large enough.
>
> Use an SMBIOS3 table in that case.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   include/smbios.h | 22 +++++++++++++++++++++-
>   lib/smbios.c     | 22 ++++++++++++++++++----
>   2 files changed, 39 insertions(+), 5 deletions(-)
>
> diff --git a/include/smbios.h b/include/smbios.h
> index c9df2706f5a6..ddabb558299e 100644
> --- a/include/smbios.h
> +++ b/include/smbios.h
> @@ -12,7 +12,8 @@
>
>   /* SMBIOS spec version implemented */
>   #define SMBIOS_MAJOR_VER	3
> -#define SMBIOS_MINOR_VER	0
> +#define SMBIOS_MINOR_VER	7
> +
>
>   enum {
>   	SMBIOS_STR_MAX	=3D 64,	/* Maximum length allowed for a string */
> @@ -54,6 +55,25 @@ struct __packed smbios_entry {
>   	u8 bcd_rev;
>   };
>
> +struct __packed smbios3_entry {
> +	u8 anchor[5];
> +	u8 checksum;
> +	u8 length;
> +	u8 major_ver;
> +
> +	u8 minor_ver;
> +	u8 docrev;
> +	u8 entry_point_rev;
> +	u8 reserved;
> +	u32 max_struct_size;
> +
> +	u64 struct_table_address;
> +};
> +
> +/* These two structures should use the same amount of 16-byte-aligned s=
pace */
> +static_assert(ALIGN(16, sizeof(struct smbios_entry)) =3D=3D
> +	      ALIGN(16, sizeof(struct smbios3_entry)));
> +
>   /* BIOS characteristics */
>   #define BIOS_CHARACTERISTICS_PCI_SUPPORTED	(1 << 7)
>   #define BIOS_CHARACTERISTICS_UPGRADEABLE	(1 << 11)
> diff --git a/lib/smbios.c b/lib/smbios.c
> index c7a557bc9b7b..82e259f31791 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -487,7 +487,11 @@ ulong write_smbios_table(ulong addr)
>   	addr =3D ALIGN(addr, 16);
>   	start_addr =3D addr;
>
> -	addr +=3D sizeof(struct smbios_entry);
> +	/*
> +	 * So far we don't know which struct will be used, but they both end
> +	 * up using the same amount of 16-bit-aligned space
> +	 */
> +	addr +=3D max(sizeof(struct smbios_entry), sizeof(struct smbios3_entry=
));
>   	addr =3D ALIGN(addr, 16);
>   	tables =3D addr;
>
> @@ -513,13 +517,23 @@ ulong write_smbios_table(ulong addr)
>   	 */
>   	table_addr =3D (ulong)map_sysmem(tables, 0);
>   	if (sizeof(table_addr) > sizeof(u32) && table_addr > (ulong)UINT_MAX)=
 {

You have to check the end address of the table not the start address here.

The SMBIOS specification says that you should always supply a 32bit
SMBIOS entry point. Of course this is not possible on boards that don't
have low memory.

In install_smbios_table() this can be achieved by calling
efi_allocate_pages() with EFI_MAX_ALLOCATE_TYPE and a maximum address of
4 GiB - 1. Only if this fails use high memory.

Best regards

Heinrich

> +		struct smbios3_entry *se;
>   		/*
>   		 * We need to put this >32-bit pointer into the table but the
>   		 * field is only 32 bits wide.
>   		 */
> -		printf("WARNING: SMBIOS table_address overflow %llx\n",
> -		       (unsigned long long)table_addr);
> -		addr =3D 0;
> +		printf("WARNING: Using SMBIOS3.0 due to table-address overflow %lx\n"=
,
> +		       table_addr);
> +		se =3D map_sysmem(start_addr, sizeof(struct smbios_entry));
> +		memset(se, '\0', sizeof(struct smbios_entry));
> +		memcpy(se->anchor, "_SM3_", 5);
> +		se->length =3D sizeof(struct smbios3_entry);
> +		se->major_ver =3D SMBIOS_MAJOR_VER;
> +		se->minor_ver =3D SMBIOS_MINOR_VER;
> +		se->docrev =3D 0;
> +		se->entry_point_rev =3D 1;
> +		se->max_struct_size =3D len;
> +		se->struct_table_address =3D table_addr;
>   	} else {
>   		struct smbios_entry *se;
>


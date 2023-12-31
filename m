Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43678C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 16:16:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBA3F8785F;
	Sun, 31 Dec 2023 17:16:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="G59xasLm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 412A6878F2; Sun, 31 Dec 2023 17:15:59 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8358C8785E
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 17:15:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704039355; x=1704644155; i=xypron.glpk@gmx.de;
 bh=Z4zwCN/+yIcl/yoGoYc7+sQTpQ+WBzWvHkiQeGv7CdA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=G59xasLmX2z/DmqATlwt6/yZ9sH/aOTBhoqNyADkbzfK/0fT0aLas3A+W682IwL/
 ADDnih8pfqG6aH20tzApqNEsiIr55jcy1s+ta0HsWIX2aeQ4ikOZDIRPz1ykRlFRh
 Mt0WwN7VycmV6+Z64fQvKyOrNpWQczeayXJNXieZ0e4tsMicQ4Tvg9uGO3RbxLYCI
 h8ohq9ZggidXMIPg5yvRnIllmxiXV6fOd4aRw27VZD/tIgRnOASqqd+C4GPDAsr19
 9TlM+LPQwBQpfI02/1vJkXWqufCUy5LJGEIY/yFhWQ6YWvutXnOuEG6EkfW2ZASXw
 JMnaoitA4ZbhUr6DFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Jn-1qfwh00rNh-00e8e2; Sun, 31
 Dec 2023 17:15:55 +0100
Message-ID: <21868385-41e3-462b-a30d-c836f29ebb98@gmx.de>
Date: Sun, 31 Dec 2023 17:15:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] smbios: Drop support for SMBIOS2 tables
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231231152555.464874-1-sjg@chromium.org>
 <20231231152555.464874-9-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231231152555.464874-9-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oUpiU4AzRlnwb6IoW8YtvERr5rv4VuVZm6LOgHrtTsy3OPI8SOC
 2tYTF5b8xB72ZlDOiVumS0CdYKaAP+kPZslhoClIYu8tkCf6PTUk3h/7hh4yLkBB+4AvdPd
 UAaEdj5/VGp2zZ9hmrei+nxvem8SgJtVnPC9qqnncRDF9vwmGbHypWt/DLxTT4UBOKNCbGv
 ynswi4gWujPUeS7ja1jIQ==
UI-OutboundReport: notjunk:1;M01:P0:UGZrR+qwGvo=;r562fe+3Ou427J5cx3dnzfZEfX5
 ixaY87PmoXKiyRGK4UJXkkGDA+825G+kxiTpK66Ex2FmECjQXUoDLCVIBkq/ofNszL2a2uF4l
 JDXkvzHZa/dXEBG98BOlj47ybvxqxmrD0bwUw5c45mcDGbGI3cQtT1SgxBGe++dGp42GlPh38
 R/ivpFUNcGA3CVPjEoTMWXWsnW6wGBofE2Ig1cIx5zWnxcXsjVKLV5b/Gb/+1i0TJ8rxh8Hnb
 uDAtucLyidNRBmgYxpJAf5hIyrUuszmRNA8FPNbJ/0wS7DQYfZYhkL3Un/MZ7JvXHuQ8MdQcs
 vtcCxoPRjeJZy50rUaPPsluYvIlr08BW1iE8F5fnXUMU+wG6HyBXd7hCMKOAweIGZUHkKGSRm
 VQwJ9PP2XFBpG2p06boRwsscuqpAjfyfnUPKv6CoBAoAZKvHXctN0AVn/JXqtfaPoGbuekQLA
 ZQDXxnk96OPTiWd5wOerg3cK6nvaRlAFFYZPL7dMOugaQJ6qH4lFDBo8ZCDoKzRy6LJuYWiGz
 VVSNvq67P+TWZqlz9FNlhgUl8o74CjSEmYTKpxHbYVHwlDxnzS+2cgN7erM+XH+740alxhbnD
 H/1BT+S6HVIYmgaeiaWGhKgvPnO+TJbVq4BSZ9X2az6KGE9rexdmR9n52qZeohM0UQIclpZNY
 8bgV2P1Xu6RqQzCZsc2bLbN7hWJ3tW6YKSW4D04+tXaEiH/OrfJbrmxzsLsBO9NhUbrg2fscu
 iYnUwaxieUsPWKuLl85u+FMzdplXirA55kIqOaBL+6pQW8HHGGIuxcCYvntrX+fYpYG+mebGh
 lvFUwrvDAALglp1ulmGbG7/jjSQfvGcLx6DNBIp0V9Sno1PUj40BBhju+fd7TtEQsvU/CCSPO
 kmnKrLyVifx11WDpnUxYAsBcTsISQN7TkqpJSxu/ImJ3rdzpjND/t0hsPSerhSJR/mkFvGVn4
 dCJd2/Vmo++aSBrCdQs7cU1JDzU=
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

On 12/31/23 16:25, Simon Glass wrote:
> These tables are a pain since there is no way to handle memory above
> 4GB. Use SMBIOS3 always.
>
> This should hopefully not create problems on x86 devices, since SMBIOS3
> was released seven years ago (2015).
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
> Changes in v5:
> - Add new patch to drop support for SMBIOS2 tables
>
>   lib/smbios.c | 76 ++++++++++++----------------------------------------
>   1 file changed, 17 insertions(+), 59 deletions(-)
>
> diff --git a/lib/smbios.c b/lib/smbios.c
> index cfd451e4088..d9d52bd58d7 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -545,13 +545,12 @@ ulong write_smbios_table(ulong addr)
>   {
>   	ofnode parent_node =3D ofnode_null();
>   	ulong table_addr, start_addr;
> +	struct smbios3_entry *se;
>   	struct smbios_ctx ctx;
>   	ulong tables;
>   	int len =3D 0;
>   	int max_struct_size =3D 0;
>   	int handle =3D 0;
> -	char *istart;
> -	int isize;
>   	int i;
>
>   	ctx.node =3D ofnode_null();
> @@ -565,12 +564,8 @@ ulong write_smbios_table(ulong addr)
>
>   	start_addr =3D addr;
>
> -	/*
> -	 * So far we don't know which struct will be used, but they both end
> -	 * up using the same amount of 16-bit-aligned space
> -	 */
> -	addr +=3D max(sizeof(struct smbios_entry), sizeof(struct smbios3_entry=
));
> -	addr =3D ALIGN(addr, 16);
> +	/* move past the (so-far-unwritten) header to start writing structs */
> +	addr =3D ALIGN(addr + sizeof(struct smbios3_entry), 16);
>   	tables =3D addr;
>
>   	/* populate minimum required tables */
> @@ -592,59 +587,22 @@ ulong write_smbios_table(ulong addr)
>   	 * We must use a pointer here so things work correctly on sandbox. Th=
e
>   	 * user of this table is not aware of the mapping of addresses to
>   	 * sandbox's DRAM buffer.
> -	 *
> -	 * Check the address of the end of the tables. If it is above 4GB then
> -	 * it is sensible to use SMBIOS3 even if the start of the table is bel=
ow
> -	 * 4GB (this case is very unlikely to happen in practice)
>   	 */
>   	table_addr =3D (ulong)map_sysmem(tables, 0);
> -	if (sizeof(table_addr) > sizeof(u32) && addr >=3D (ulong)UINT_MAX) {
> -		struct smbios3_entry *se;
> -		/*
> -		 * We need to put this >32-bit pointer into the table but the
> -		 * field is only 32 bits wide.
> -		 */
> -		log_debug("WARNING: Using SMBIOS3.0 due to table-address overflow %lx=
\n",
> -			  table_addr);
> -		se =3D map_sysmem(start_addr, sizeof(struct smbios_entry));
> -		memset(se, '\0', sizeof(struct smbios_entry));
> -		memcpy(se->anchor, "_SM3_", 5);
> -		se->length =3D sizeof(struct smbios3_entry);
> -		se->major_ver =3D SMBIOS_MAJOR_VER;
> -		se->minor_ver =3D SMBIOS_MINOR_VER;
> -		se->doc_rev =3D 0;
> -		se->entry_point_rev =3D 1;
> -		se->max_struct_size =3D len;
> -		se->struct_table_address =3D table_addr;
> -		se->checksum =3D table_compute_checksum(se,
> -						sizeof(struct smbios3_entry));
> -	} else {
> -		struct smbios_entry *se;
> -
> -		se =3D map_sysmem(start_addr, sizeof(struct smbios_entry));
> -		memset(se, '\0', sizeof(struct smbios_entry));
> -		memcpy(se->anchor, "_SM_", 4);
> -		se->length =3D sizeof(struct smbios_entry);
> -		se->major_ver =3D SMBIOS_MAJOR_VER;
> -		se->minor_ver =3D SMBIOS_MINOR_VER;
> -		se->max_struct_size =3D max_struct_size;
> -		memcpy(se->intermediate_anchor, "_DMI_", 5);
> -		se->struct_table_length =3D len;
> -
> -		se->struct_table_address =3D table_addr;
> -
> -		se->struct_count =3D handle;
> -
> -		/* calculate checksums */
> -		istart =3D (char *)se + SMBIOS_INTERMEDIATE_OFFSET;
> -		isize =3D sizeof(struct smbios_entry) -
> -			SMBIOS_INTERMEDIATE_OFFSET;
> -		se->intermediate_checksum =3D table_compute_checksum(istart,
> -								   isize);
> -		se->checksum =3D table_compute_checksum(se,
> -					      sizeof(struct smbios_entry));
> -		unmap_sysmem(se);
> -	}
> +
> +	/* now go back and write the SMBIOS3 header */
> +	se =3D map_sysmem(start_addr, sizeof(struct smbios_entry));
> +	memset(se, '\0', sizeof(struct smbios_entry));
> +	memcpy(se->anchor, "_SM3_", 5);
> +	se->length =3D sizeof(struct smbios3_entry);
> +	se->major_ver =3D SMBIOS_MAJOR_VER;
> +	se->minor_ver =3D SMBIOS_MINOR_VER;
> +	se->doc_rev =3D 0;
> +	se->entry_point_rev =3D 1;
> +	se->max_struct_size =3D len;
> +	se->struct_table_address =3D table_addr;
> +	se->checksum =3D table_compute_checksum(se, sizeof(struct smbios3_entr=
y));
> +	unmap_sysmem(se);
>
>   	return addr;
>   }


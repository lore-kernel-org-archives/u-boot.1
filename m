Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D399C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 20:41:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97EFC87996;
	Thu, 25 Jan 2024 21:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Sw/yxNvI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83B6886FB2; Thu, 25 Jan 2024 21:41:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BFF187B98
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 21:41:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706215271; x=1706820071; i=xypron.glpk@gmx.de;
 bh=3Tq3kvLpZVAI+GImuuHz8Ug0+kOggoCBxCpQkHxN0aY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=Sw/yxNvIhI+fCJTrJ/GRHqY7FiRV3lvnvthJmLXfBcdhQVD7PuYk3SeqUC6Mwokv
 yzOcptX5IsF01s/IC0zyRQkxsotoLGv8FPvT1JgQvOqGECdcjBG/cNtH9lhMl+88U
 pzmFn2M79IqyGtoZ+KFq176vSLLBostVQPI+E7J6lvTYFruN7LByO8qfwhzBKCqYR
 +PKGURvDbairTm7Iar4QcI0h+33A6O7uCE8Fu89LLN5fS1RwBta1QBWf8k3ZNeb6X
 i3/jqZbG8pxBsN29FA1ldK/2VJoCtCBBL5Er/ujiVJlXitmkvfg0Jf3i591yGXbGE
 GO1o+gpBOAQ0/crQIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMofW-1rljJT1amS-00Inc2; Thu, 25
 Jan 2024 21:41:11 +0100
Message-ID: <ebd16ea3-d8af-47f2-83d5-0141e15c4790@gmx.de>
Date: Thu, 25 Jan 2024 21:40:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smbios: use struct_table_length to get SMBIOS 2.1 total
 table length
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20240125011128.1176557-1-masahisa.kojima@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240125011128.1176557-1-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8zVcgtGZPJySOiyVqJ2aJHPIs3MNgAgrqWZjEGepVerocroI5Pz
 sLNLy8xuLhwG6xGPjpXciXOW92v/vClEahv/nmLDkKLe1z+z+IAZ5QFSeM2Yaik3ykTOc6Y
 TaIQUajDMH7ATt0EWdea4ms1FSJ1RFuDWF3L1Z9pC8icofyIVOHG2ZsXJKRvRwKPEhQMaG8
 73PPWy3ACO1++JcGWOi/w==
UI-OutboundReport: notjunk:1;M01:P0:Kjwbdb6jp7E=;DjjHAPCd7bNnpr96CqEzdPFTObu
 NLsZxiXdPIO+upLqz2s626F02UYnl6uOMncKJmoDg5yeo7uyqrfpjP0iZbWmgOSPXlHagEdJR
 odTcpqIAhhOdGiQJ5xbGU62T93w6YYKk6pPzHAFln4G5EdX6cmMkjSunopRYtOudkRhD1t5px
 iSddcOH9S5uyuyQoB4RfoJs1hj9JVZMGn5xeWTePCsWmP1emzucqyeS2IdfWUvOhTdzMbF7Me
 ifDIhqArboNqAImSc8JBEEiGu4V+6Xt7+no8iSWqgZSm1ci8F4+8OkSU5JZKXPP3pMLOH4MzE
 thWMt5bjRYzAKiyO3kFZ6bKiAZD69Qc6fkaJLPt7pYnywe5v3a47pN4FV+4TivYCYscJGr0bf
 jB8hfkgeAknxLi7MFHyfxwGgvTy1ulNkKTK4Fp7jXBdypqx9OIcVlnqBD7/hIkb4c78S6ZHa2
 tjNifphrt8Tp+hgTXp1qUE08HRI1TXd9Bomr7nIDsDQjN7KFwRlBTIP7UtfkOq21mbStNsJ3s
 UWi9nMvdOQqOLxOTZ9TI5ghO8h4sR9F6SUKLoH1QVKpYw9LqMyY3+CylbhI5GMeLpDJWQC8lf
 Dd8jnDN96Qpag4Tk9kKbe2GFMw3IsOvfeJaB3qskqZtjewHTWz4h+zquXh+Akz8f5juHc/t3K
 t5vi52mD2rZILp3goBUsnzkjDb5yxqCKDJx9z5j4fF5c/4cVd4QstcshM/uiz1YfK+YTvenWW
 74QxoPgq9jTgpJ8XTvzbMBgXhagT67AvVGXvCl6ZYch2dBoPFOHrc50M06qDtEUyyEpNpVLfD
 Nahc/v2l/gAtoo77xOEb0CpRWT3w8xirqdxmCyx2iscITvVonc5YeHONdkNbqPTRIYQc6cJyg
 88BBgrw6Ug8/NNPCYZZALTxdPCH/XT3vqc/Pe+M/p63EsJnTLNK0rsFoJsDHggaI/bPH+xbwE
 M8JdyE8lmvEbYnVHrfyozCJY4Jw=
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

On 1/25/24 02:11, Masahisa Kojima wrote:
> The current code convert the SMBIOS 2.1 entry point structure to
> SMBIOS 3.0 entry point structure. The max_struct_size member in
> SMBIOS 2.1 entry point structure indicates
> "Size of the largest SMBIOS structure, in bytes".
> We need to use struct_table_length instead.
>
> Fixes: 1c5aab803c0b ("smbios: copy QEMU tables")
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>   drivers/misc/qfw_smbios.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/qfw_smbios.c b/drivers/misc/qfw_smbios.c
> index 9019345783..a898cb4eea 100644
> --- a/drivers/misc/qfw_smbios.c
> +++ b/drivers/misc/qfw_smbios.c
> @@ -90,7 +90,7 @@ static int qfw_parse_smbios_anchor(struct udevice *dev=
,
>   		entry->length =3D sizeof(struct smbios3_entry);
>   		entry->major_ver =3D entry2->major_ver;
>   		entry->minor_ver =3D entry2->minor_ver;
> -		entry->max_struct_size =3D entry2->max_struct_size;
> +		entry->max_struct_size =3D entry2->struct_table_length;

Thank you for catching this.

These are the definitions:

SMBIOS 2.1 (offset 0x08): Maximum Structure Size:
Size of the largest SMBIOS structure, in bytes, and encompasses the
structure=E2=80=99s formatted area and text strings

SMBIOS 2.1 (offset 0x16): Structure Table Length:
Total length of SMBIOS Structure Table, pointed to by the Structure
Table Address, in bytes

SMBIOS 3 (offset 0x0c) - Structure table maximum size
Maximum size of SMBIOS Structure Table, pointed to by the Structure
Table Address, in bytes. The actual size is guaranteed to be less or
equal to the maximum size.

SmbiosCreateTable() in EDK has this logic:

       EntryPointStructure->TableLength =3D
(UINT16)(EntryPointStructure->TableLength + RecordSize);
       if (RecordSize > EntryPointStructure->MaxStructureSize) {
         EntryPointStructure->MaxStructureSize =3D (UINT16)RecordSize;
       }

qemu-system-x86 gives me these values:

entry2->max_struct_size: 81
entry2->struct_table_length: 321

I think we should rename the field in the SMBIOS3 header (e.g. to
table_max_size) to avoid future confusion.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>   	} else {
>   		ret =3D -ENOENT;
>   		goto out;


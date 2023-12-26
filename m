Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D74C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 15:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F408887835;
	Tue, 26 Dec 2023 16:30:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="uNYpX5L0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1C9F87855; Tue, 26 Dec 2023 16:30:40 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0212F807E4
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 16:30:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703604638; x=1704209438; i=xypron.glpk@gmx.de;
 bh=n03r6RogWp7aXW3RyI1A3wtK9QlHszcLKCoYKORHpjg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=uNYpX5L0OgMoR/krcU+IFOTOko2DyYiDYD93/RL3KZlCKy73BhcHPTQxDqypV0lg
 3K1ZN5UlhG9239lxZqKu55wua5qNwjFF4KuBn/DGi5uYHUOfSOBgy820fVUVDR+yA
 EJkO9X55kubb3PUhXr3jlwaMjxS9fBvYYcH8QPSXGUaOV+tG4gjSTij5FY269tu0b
 XejVECEAPq/pvnWAx0lBYcHgPYtuBuHOZD4sjM0i391Ub0+HWqr4koYEFNEdqVvyO
 +kbge7BhYzh19AlJsiy347TJl/5KNRuI3fJKt8L/ogUPofVmM75rGVH+iwWsLNnZo
 N0+6nY7cfiBqvXU0Zg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.152] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDysg-1rS2tP07Km-00A0jd; Tue, 26
 Dec 2023 13:41:11 +0100
Message-ID: <ceeb1fd4-a469-4bde-b6e2-a49447b2020b@gmx.de>
Date: Tue, 26 Dec 2023 13:41:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] smbios: Require the caller to align the SMBIOS
 table
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231015024511.3995580-1-sjg@chromium.org>
 <20231015024511.3995580-7-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231015024511.3995580-7-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i8vkvuypSD3jNpyhasK48nqyOVt2VysBPGdKhiCQbQJYbitUsyu
 EkIHIeR6wx2jLYScMtCxo1pzRmXMEbiRbJYE7flEPaQDAb5rAtENUVdrDb3lJuVojpkr9Dj
 B+TyjTskkQxV+a/lf1mYM2afROnkaB1eGMH6iwI2TFxVWylWn11lXtAFFizmymY7D6ZFy+d
 M2w8Rq6kQxR/b13SkG1WA==
UI-OutboundReport: notjunk:1;M01:P0:R6+yy/ESvYM=;54Dayvx7mflAYqB7DusXj/AY/bt
 F0ztLWUxVsx5LlKN3Do4LaOj+XTsfelq340EF2JM5BcGE8TcfjKww6OOp/BQEwhM9KmSzU2li
 0cQ8tDssj8ZSMCLJ1S13+0k9FDpWNXF7Ysgqo962RLNUDpNjLLv7OtSHnUj5pTFD2gydITv1M
 H8NcPdGemQMkanhNzjqTACwxRhGgIrdzxFX8w8XtzSu0A3Hb7qwvCxbShMmNUzLeDUBXZiECb
 xFsKrU2+mMdcxTT4B1+EhCHxlvC9WUP3YWW+broDlBLtn+2Dy4VcBSYd2Z8Fcqe2CNxVvystt
 2BcBZNi6bhfxfmVDz4JCA7nhvB6NzD0uInPTfqJS28tjW8033GugOcD17CeOr25EnJ0FONIwQ
 4WXz8x/4/KfUuu62om1hPKiyOEARo/+GsCo2OmPI7sIjSrqSS3/7LT3Dufa9iyKsSkwEQDD1E
 sEQIBBaRiDTCP45yXq3bUdafeks7jHRjnTD6u1rf0TXl1sGUoE4acXenUptZ1dJHG+JTzwZvb
 gEYYP2D/+iUbCmASaUc9sAStoxOy9VjdEoCgXFN+9XweFAFFCZ2ZfCSVIy0bdfu17gAQIbsfb
 jZkjpt18Y+JdOoH5ZJ+UqT6tLWXmBV+pAxME4c6btf6uS+o1PM3RdmZdINd8q4VzPgnoZCTpX
 B4Z3rYrZTQR71ZQtnk+E7GQ4ykDxZ5XMRscf5zif1wwgiO/cB0L2a7TNb6hfd407px/ONQSOc
 Yns3c8nXYMBQY+1t9BCRsd+lEmyHtVXBPx6mIFxLiDF2o9fvdSz7eZwFYM+OajZe3ca8I+VHp
 oIU1zPwEXDJvxzDsfvsMe5BpVFAzNmWizN7FnhLBF3M+oRQpybQ62azeUDZnRUb9KHnawppJf
 ncr82UDCbYRrQH6a6l8F4axtzsWJJXb+eufuOH37VEWYWkgFLtvXX7x3olZvLWSDbWoTQo6EW
 hDWxMUqcdrNnHDwc+V3tdfq8k4o=
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

On 10/15/23 04:45, Simon Glass wrote:
> All callers handle this alignment, so drop the unnecessary code. This
> simplifies things a little.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
> (no changes since v1)
>
>   include/smbios.h | 5 +----
>   lib/smbios.c     | 2 --
>   2 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/include/smbios.h b/include/smbios.h
> index ddabb558299e..31d997287588 100644
> --- a/include/smbios.h
> +++ b/include/smbios.h
> @@ -248,12 +248,9 @@ static inline void fill_smbios_header(void *table, =
int type,
>    *
>    * This writes SMBIOS table at a given address.
>    *
> - * @addr:	start address to write SMBIOS table. If this is not
> - *		16-byte-aligned then it will be aligned before the table is
> - *		written.
> + * @addr:	start address to write SMBIOS table (must be 16-byte-aligned)
>    * Return:	end address of SMBIOS table (and start address for next ent=
ry)
>    *		or NULL in case of an error
> - *
>    */
>   ulong write_smbios_table(ulong addr);
>
> diff --git a/lib/smbios.c b/lib/smbios.c
> index 92e98388084f..5c9f108496d6 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -483,8 +483,6 @@ ulong write_smbios_table(ulong addr)
>   		ctx.dev =3D NULL;
>   	}
>
> -	/* 16 byte align the table address */
> -	addr =3D ALIGN(addr, 16);
>   	start_addr =3D addr;
>
>   	/*


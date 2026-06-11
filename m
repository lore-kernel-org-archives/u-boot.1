Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C9FCD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 07:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEA9780433;
	Thu, 11 Jun 2026 09:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="bEvvqy6S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6918F839A8; Thu, 11 Jun 2026 09:20:25 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6943480086
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 09:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781162422; x=1781767222; i=xypron.glpk@gmx.de;
 bh=krUnXksQF94NB/Wr27PU1wp0plCzH81lW25ozF9bVAs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=bEvvqy6SmCehp3EVSXKW5dKqGS6p6Uy4/H/wXUfp7AIxS7oWSd0jEK09iG5oD8Le
 BdrxEX1/G2VtNQrJPzd4VkgTPOsZHB8wibywoz4hJ0uQ2HSqibxMjd2H8ccKyJCFs
 v6fzgeMYrPqGTTLCBXXR02Ei09f4Hhtv1FdQxQWPyChEmn/iVvwhYa2v6TYqdJTr5
 q5+q5Nz86+2qXuwg+8t77D0st1gy3dtt/4CDkNNn53utd0UwnHRDCzYxHIR4tFkob
 2FN9837g2UN+BAXHUlMCmytPMlj+BrdqTXslHQSE+gB8A2oUKfAUCZZ9PfqcizfL/
 9thy8RfiElENIWjH2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYeMj-1wkPkj1PL1-00YoXp; Thu, 11
 Jun 2026 09:20:22 +0200
Message-ID: <1c0a92ec-3fb8-4759-b315-5f009a117644@gmx.de>
Date: Thu, 11 Jun 2026 09:20:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_selftest: fix use-after-free
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260611065950.522179-1-vincent.stehle@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260611065950.522179-1-vincent.stehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uihRC/2qJYrGLnrN55N5TDqbJAGEG1A8NZuiv0CLNrBMUq6VGE/
 m9CPNsLnfIKblhWrT+qlxRccnHe7fU1s3Jg39nPVMzDjtujjzrwqqzIIU0P4NwjKA8Dq08f
 wHHBsWd9QoBDl3AoJqapI6KsGWF5UI/2ktrzsI6PQrpGMZs60cZJAgNpBdK7cL1tM9GhDIJ
 p4zeDikogzhT7tght16DA==
UI-OutboundReport: notjunk:1;M01:P0:F+P6jK6RNEY=;3B8yc8FD0vHaNZf00oQt556LaQF
 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
 BcodlQ==
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

On 6/11/26 08:59, Vincent Stehl=C3=A9 wrote:
> When the `memory' efi selftest verifies the Devicetree memory reservatio=
n,
> it accesses the memory_map buffer after it has been freed with free_pool=
().
> Move the verification earlier to fix this.
>=20
> Fixes: 34c96659ed57 ("efi_selftest: check fdt is marked as runtime data"=
)
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>

Thank you for the fix.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/efi_selftest/efi_selftest_memory.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/lib/efi_selftest/efi_selftest_memory.c b/lib/efi_selftest/e=
fi_selftest_memory.c
> index 7320964c129..450470ceedd 100644
> --- a/lib/efi_selftest/efi_selftest_memory.c
> +++ b/lib/efi_selftest/efi_selftest_memory.c
> @@ -155,6 +155,15 @@ static int execute(void)
>   			       EFI_RUNTIME_SERVICES_DATA) !=3D EFI_ST_SUCCESS)
>   		return EFI_ST_FAILURE;
>  =20
> +	/* Check memory reservation for the device tree */
> +	if (fdt_addr &&
> +	    find_in_memory_map(map_size, memory_map, desc_size, fdt_addr,
> +			       EFI_ACPI_RECLAIM_MEMORY) !=3D EFI_ST_SUCCESS) {
> +		efi_st_error
> +			("Device tree not marked as ACPI reclaim memory\n");
> +		return EFI_ST_FAILURE;
> +	}
> +
>   	/* Free memory */
>   	ret =3D boottime->free_pages(p1, EFI_ST_NUM_PAGES);
>   	if (ret !=3D EFI_SUCCESS) {
> @@ -172,14 +181,6 @@ static int execute(void)
>   		return EFI_ST_FAILURE;
>   	}
>  =20
> -	/* Check memory reservation for the device tree */
> -	if (fdt_addr &&
> -	    find_in_memory_map(map_size, memory_map, desc_size, fdt_addr,
> -			       EFI_ACPI_RECLAIM_MEMORY) !=3D EFI_ST_SUCCESS) {
> -		efi_st_error
> -			("Device tree not marked as ACPI reclaim memory\n");
> -		return EFI_ST_FAILURE;
> -	}
>   	return EFI_ST_SUCCESS;
>   }
>  =20


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DD9C44514
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 19:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67D9F84AFF;
	Thu, 16 Jul 2026 21:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="WWgmgA2s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3891184B86; Thu, 16 Jul 2026 21:53:35 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3623384A0A
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 21:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784231611; x=1784836411; i=xypron.glpk@gmx.de;
 bh=2ReS6q9DwJ+EcPnn3Vcnfn2a0yjqmMdcESIuMHmK5PE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=WWgmgA2sQY5YJw9KIunkiyk6rQLXosrHM5KyOYJsTgjbcoWT9F4lsFfSsSTtWIiu
 zCCDLr2SN9bNH9DVevMhUlFP3hUylEWVt0upmtbK/FoikZ44pudIvFKFmU7JSHe/6
 MxcAK9HQvMG1P3yWsGuHlhN2gJFzszYCl8jzY4v266HV2WaLs/gTORfzFX8ikf2Jf
 5rRMWbZ9TE54HUWShY0WI1/5yjP1/5oXsaP9UaTzg5C8kHnBEG0gXy29uOamvuQxx
 TCP0DTRS0I0buOweAOOR/YegfRH3ekpycX1yPOOxmGJleSm+EmIjNWl9PzOiJh1XS
 euOje94bYPFgCkaKow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD2Y-1xFv0j0jK6-00he9m; Thu, 16
 Jul 2026 21:53:31 +0200
Message-ID: <d5718d9c-f9fa-4045-9d79-364c28a6b383@gmx.de>
Date: Thu, 16 Jul 2026 21:53:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] cmd: nvedit_efi: use efi_auth_var_get_guid() for
 the default GUID
To: Aristo Chen <aristo.chen@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260714094902.438079-1-aristo.chen@canonical.com>
 <20260714094902.438079-2-aristo.chen@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260714094902.438079-2-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F2Q7rJgzDe/aZx9L4Ye+Gf+owcyP8Og5XYL+eRHZSfgQYWUdRpX
 QA+/i2IKiwlKWaayUq9zvvKRJQOjHcty3FizdQH1YfooBP5+M61vnf8WRydoWEZveftb2HK
 4BKpgeLABNmlsTGbI7b3GF//+7n3pLYlu/edks/H995eXUZNv3Py11Sx6vKp1K+2mzbdkxu
 kpskrAb5kUhPgtYJtJpPQ==
UI-OutboundReport: notjunk:1;M01:P0:SUZztMBCPPM=;283H+g36Z7ORlO6zvRGdCwtetWX
 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
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

On 7/14/26 11:48, Aristo Chen wrote:
> do_env_set_efi() hand rolls the mapping from well known variable names
> to their default vendor GUID and has already drifted from the canonical
> name_type[] table in efi_var_common.c: it does not know "dbr", so
> "env set -e dbr" operates on the variable under EFI_GLOBAL_VARIABLE_GUID
> instead of the image security database GUID, silently creating a
> variable that nothing will ever consume.
>=20
> Convert the variable name to UTF-16 before selecting the GUID and let
> efi_auth_var_get_guid() do the lookup. That function knows all
> authenticated variables including "dbr" and falls back to
> EFI_GLOBAL_VARIABLE_GUID for any other name, so behaviour is unchanged
> for "db", "dbx", "dbt" and non-authenticated variables. Future
> additions to the table now apply to the shell command automatically.
>=20
> Since the conversion now happens before the value parsing loop, free
> the UTF-16 name at the common exit label so the error path there does
> not leak it.
>=20
> Also drop the unmap_sysmem() call right after efi_set_variable_int():
> the common exit path already unmaps the value for the -i case and frees
> it otherwise, so the value was unmapped twice. On sandbox the second
> call triggers a spurious "Address not mapped" warning for addresses
> that get a tagged mapping.
>=20
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   cmd/nvedit_efi.c | 22 ++++++++--------------
>   1 file changed, 8 insertions(+), 14 deletions(-)
>=20
> diff --git a/cmd/nvedit_efi.c b/cmd/nvedit_efi.c
> index 3a36f94775b..f38802e4f4d 100644
> --- a/cmd/nvedit_efi.c
> +++ b/cmd/nvedit_efi.c
> @@ -448,13 +448,14 @@ int do_env_set_efi(struct cmd_tbl *cmdtp, int flag=
, int argc,
>   		return CMD_RET_USAGE;
>  =20
>   	var_name =3D argv[0];
> -	if (default_guid) {
> -		if (!strcmp(var_name, "db") || !strcmp(var_name, "dbx") ||
> -		    !strcmp(var_name, "dbt"))
> -			guid =3D efi_guid_image_security_database;
> -		else
> -			guid =3D efi_global_variable_guid;
> +	var_name16 =3D efi_convert_string(var_name);
> +	if (!var_name16) {
> +		printf("## Out of memory\n");
> +		ret =3D CMD_RET_FAILURE;
> +		goto out;
>   	}
> +	if (default_guid)
> +		guid =3D *efi_auth_var_get_guid(var_name16);
>  =20
>   	if (verbose) {
>   		printf("GUID: %pUl (%pUs)\n", &guid, &guid);
> @@ -479,16 +480,8 @@ int do_env_set_efi(struct cmd_tbl *cmdtp, int flag,=
 int argc,
>   			       16, 1, value, size, true);
>   	}
>  =20
> -	var_name16 =3D efi_convert_string(var_name);
> -	if (!var_name16) {
> -		printf("## Out of memory\n");
> -		ret =3D CMD_RET_FAILURE;
> -		goto out;
> -	}
>   	ret =3D efi_set_variable_int(var_name16, &guid, attributes, size, val=
ue,
>   				   true);
> -	free(var_name16);
> -	unmap_sysmem(value);
>   	if (ret =3D=3D EFI_SUCCESS) {
>   		ret =3D CMD_RET_SUCCESS;
>   	} else {
> @@ -518,6 +511,7 @@ int do_env_set_efi(struct cmd_tbl *cmdtp, int flag, =
int argc,
>   		ret =3D CMD_RET_FAILURE;
>   	}
>   out:
> +	free(var_name16);
>   	if (value_on_memory)
>   		unmap_sysmem(value);
>   	else


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAD9C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 09:25:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F188F40F6D;
	Fri, 31 Jul 2026 09:25:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WhHzsoWmAHeI; Fri, 31 Jul 2026 09:25:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3F1140F70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785489910;
	bh=sXDh6spvgwGj7szi2Pgf4UPCFJFlpNKZ/GfwIhXUyDg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nJthnDxLUfXVJI57aaCnTcn9pPTDOjSrzTjQrkUF/1+Yh4PugL/ua3lGUUYn0vQpy
	 w9D/Jyf/SMOr18rhM+JaEshjGSAo24FWvwL5kM40cilhkhdUoSTZcshf4c/UiEa7SY
	 klMhcgZMcqIODgyfj4jkxSZQ73462AvJLvmkLsbVep3HE2f+EZ2WXCKO7A2MH1r+/b
	 P6aEqdqaqYyL+U3tHsz4SsOkmlKOULHuH5BmRzmEnV02wXDSvGIRW0JpLi4nzLrmDA
	 h/2yq5vOecsMcb6z2PRj7F2inqb5tzf/nDUy6arBKngrK0uFW/k0JdiCJm0wEgwYT3
	 NbmWEGYwWmlBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3F1140F70;
	Fri, 31 Jul 2026 09:25:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B0C3F2CE
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:25:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 973F560811
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:25:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5R4xsftuDeAu for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 09:25:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.18;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2A8416071E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2A8416071E
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A8416071E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:25:05 +0000 (UTC)
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5vW-1wcTvh2phg-00XAI7; Fri, 31
 Jul 2026 11:25:01 +0200
Message-ID: <b92c733b-a12d-4361-a767-2c7c17befcd1@gmx.de>
Date: Fri, 31 Jul 2026 11:24:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] efi_loader: fix use of uninitialized guid in variable
 enumeration loops
To: Scott Moser <smoser@brickies.net>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 u-boot@lists.u-boot-project.org
References: <20260728164948.821237-1-smoser@brickies.net>
 <20260728193328.865976-1-smoser@brickies.net>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260728193328.865976-1-smoser@brickies.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KfWCn+4NAfVfFgpL/gjKz/F7AR9ImMX17H6BV6k1i2y8bnl4DHS
 u8HQ9pwEaidoJ7rC+Axt3xPPCHczUMEL9znUc0oCnM98W7HnCQVnnvCfNZZtCa8sZXuSBuG
 IByN37Omjf6lVAy6aV/eu/0XvbttLNVeFMo32PH58zl+TwKtEVLXTWwB7QdSR1/htMjecVF
 r6MErC2INxqIR9L8Fl9UA==
UI-OutboundReport: notjunk:1;M01:P0:Jws8B1S1nJE=;sxAptUHAQ34pHXfF8fDQAZjcEDK
 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
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmx.de; 
 s=s31663417; t=1785489901; x=1786094701; i=xypron.glpk@gmx.de;
 bh=sXDh6spvgwGj7szi2Pgf4UPCFJFlpNKZ/GfwIhXUyDg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=QSEXubabnXfeXdvZGY3NcCNTXcNNq9vVwNjilxa7uRBgaoDfk2RkIEYC4yI1LaFO
 3k4jxdrwzKcCaWahHDU8lH46L9QizySsd5QXvCwuUHq8b6B/Kxvczvt5e/flLT9DK
 Nf/PBAkK1lx//I9qHn7NHgiITYowHrCBR+w+H5BtW+M2PMhpHx2ddK/DMxxuwqjU2
 1317WZ393ZXQ80G7jklwAM8K4WsbdhRluom/Zn9Ni5M9S/O1mrnbDbp9mvmOnW9UL
 7TfAWV+ZA5/EVJXPAvpg7UWshqw01UUCyVcRpVikovJ2DdoqmeVS1630alN5kRzlW
 qaOu8AeLac4WrvC3OA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=QSEXubab
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/28/26 21:33, Scott Moser wrote:
> efi_bootmgr_delete_invalid_boot_option(), eficonfig_show_boot_selection(=
),
> and eficonfig_create_change_boot_order_entry() each enumerate all EFI
> variables by repeatedly calling efi_next_variable_name() in a loop,
> passing the same efi_guid_t as both input and output. GetNextVariableNam=
e()
> needs the vendor GUID returned by the previous call, together with the
> variable name it returned, to know where to resume.
>=20
> In each of these loops the efi_guid_t was declared inside the loop body,
> so a new instance comes into scope on every iteration. Relying on it to
> still hold the previous iteration's value depends on the compiler reusin=
g
> the same stack slot across iterations, which is undefined behavior. With
> a compiler that zero-initializes locals by default (e.g. clang, or gcc
> configured with -ftrivial-auto-var-init=3Dzero), the GUID is cleared on
> every iteration, so the lookup of the variable name returned by the
> previous call fails and efi_init_obj_list() aborts:
>=20
>    Cannot initialize UEFI sub-system
>    ** Booting bootflow ... with efi
>    Boot failed (err=3D-22)
>=20
> Move the efi_guid_t declarations out of the loops so the value written
> by the previous efi_next_variable_name() call is preserved across
> iterations.
>=20
> Fixes: 140a8959d48f ("eficonfig: use efi_get_next_variable_name_int()")
> Signed-off-by: Scott Moser <smoser@brickies.net>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

None of the loops handles EFI_BUFFER_TOO_SMALL. Just create a variable=20
called fedcba9876543210fedcba9876543210fedcba9876543210fedcba9876543210=20
to break the code.

We should move all calls of GetNextVariable() to a new function in=20
lib/efi_loader/efi_var_common.c with proper handling of the variable=20
name buffer.

But let's merge the current patch first.

Best regards

Heinrich

> ---
> Changes for v2:
> - Drop the "=3D {}" initializer on the hoisted guid: per the UEFI spec,
>    VendorGuid is ignored when VariableName is an empty string, which is
>    the state var_name16 is in on the first call, so the initial value is
>    never read and zero-initializing it only costs code size.
>=20
>   cmd/eficonfig.c              | 4 ++--
>   lib/efi_loader/efi_bootmgr.c | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> index 4d060e3007c..d8e7ed6666a 100644
> --- a/cmd/eficonfig.c
> +++ b/cmd/eficonfig.c
> @@ -1844,6 +1844,7 @@ static efi_status_t eficonfig_show_boot_selection(=
unsigned int *selected)
>   	struct efimenu *efi_menu;
>   	struct list_head *pos, *n;
>   	struct eficonfig_entry *entry;
> +	efi_guid_t guid;
>  =20
>   	efi_menu =3D calloc(1, sizeof(struct efimenu));
>   	if (!efi_menu)
> @@ -1872,7 +1873,6 @@ static efi_status_t eficonfig_show_boot_selection(=
unsigned int *selected)
>   	var_name16[0] =3D 0;
>   	for (;;) {
>   		int index;
> -		efi_guid_t guid;
>  =20
>   		ret =3D efi_next_variable_name(&buf_size, &var_name16, &guid);
>   		if (ret =3D=3D EFI_NOT_FOUND)
> @@ -2245,6 +2245,7 @@ static efi_status_t eficonfig_create_change_boot_o=
rder_entry(struct efimenu *efi
>   	u16 *var_name16 =3D NULL;
>   	efi_uintn_t size, buf_size;
>   	struct eficonfig_save_boot_order_data *save_data;
> +	efi_guid_t guid;
>  =20
>   	/* list the load option in the order of BootOrder variable */
>   	for (i =3D 0; i < num; i++) {
> @@ -2265,7 +2266,6 @@ static efi_status_t eficonfig_create_change_boot_o=
rder_entry(struct efimenu *efi
>   	var_name16[0] =3D 0;
>   	for (;;) {
>   		int index;
> -		efi_guid_t guid;
>  =20
>   		if (efi_menu->count >=3D EFICONFIG_ENTRY_NUM_MAX - 2)
>   			break;
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 8c9a9b5eb56..8938b214ceb 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -934,6 +934,7 @@ static efi_status_t efi_bootmgr_delete_invalid_boot_=
option(struct eficonfig_medi
>   	efi_status_t ret =3D EFI_SUCCESS;
>   	u16 *delete_index_list =3D NULL, *p;
>   	efi_uintn_t buf_size;
> +	efi_guid_t guid;
>  =20
>   	buf_size =3D 128;
>   	var_name16 =3D malloc(buf_size);
> @@ -943,7 +944,6 @@ static efi_status_t efi_bootmgr_delete_invalid_boot_=
option(struct eficonfig_medi
>   	var_name16[0] =3D 0;
>   	for (;;) {
>   		int index;
> -		efi_guid_t guid;
>   		efi_uintn_t tmp;
>  =20
>   		ret =3D efi_next_variable_name(&buf_size, &var_name16, &guid);


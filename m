Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3810CC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 17:16:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2D488137E;
	Tue, 28 Jul 2026 17:16:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I8wTTaAWwrF3; Tue, 28 Jul 2026 17:16:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E9268135D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785258989;
	bh=oGzj3FvqVg3FMqf1zic0l9gu9YnxTrjfkbH5x45+2gI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eUMczqFqiYVXVPGaZpL6lD/kYQYkaIK7oPhVQTtrQGtJDrfVonm/MThpxeyLAnhzw
	 PUzJgmDWsdFQ10QSFCvt3b9GkKJfyG4S4dHahBGwmdl6CqjdOaxYhB+GUMTUpZqsAS
	 uC2Itzt8eA026Vrfer0fEBd2Go5Pv8Vkpo4JBQWzsDD4LWxB8j/cC8nswLyWhu+FAu
	 Mmk/TYz/IJC3G/cdzmyB4Npfo1TBjBypiN8PZ6rqcBEzJMRiRfKCvpaNWQ3k3IIcVg
	 NEblCSr19Ev14+v/dFsXKN0whaY6UGyQkJd/DmC0WP2vIfKDnuea16zbY1EFzn/VVT
	 I/CEuiCZAyRvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E9268135D;
	Tue, 28 Jul 2026 17:16:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B60DD45B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:16:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A7A368135D
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:16:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 11VkHGAeTGcZ for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 17:16:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.19;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7130B81294
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7130B81294
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7130B81294
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:16:25 +0000 (UTC)
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MaJ7v-1wU3b12vAr-00NpEh; Tue, 28
 Jul 2026 19:16:22 +0200
Date: Tue, 28 Jul 2026 19:16:18 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Scott Moser <smoser@brickies.net>, u-boot@lists.u-boot-project.org
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_efi=5Floader=3A_fix_use_of_uninit?=
 =?US-ASCII?Q?ialized_guid_in_variable_enumeration_loops?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260728164948.821237-1-smoser@brickies.net>
References: <20260728164948.821237-1-smoser@brickies.net>
Message-ID: <2C2AAF70-0D15-42B0-90F7-43E4E8C5B185@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LWXdyi2IMxqVF0oN+/icyUM3IRD3ElWENSP9VXXrr/uSu/L8jwn
 +rWbCpCqfz6PF1EbIrWMXePerNfiIIFkLRA+78gvZtB2nGC/L3V1EFWPzWPt21oicWo7rp+
 YXXD837UzOoiXtcV6w+5q28LYADnpxABqvlmGGGbglWMLoFMFTczPoJ8XoUMGL2XZOyFkLH
 3OufyivxcDIjelvRPXF8w==
UI-OutboundReport: notjunk:1;M01:P0:o6HqhvYR2eg=;7zbtdtI9/s4m/88DTxAHDIgtRpw
 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
 jZw
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmx.de; 
 s=s31663417; t=1785258982; x=1785863782; i=xypron.glpk@gmx.de;
 bh=oGzj3FvqVg3FMqf1zic0l9gu9YnxTrjfkbH5x45+2gI=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=NymTi0jiSMkDKT0PdcHO/UothEq1qxW7+oqdHN8tdM5SQozUdNdrVshucWN+JM9o
 2FwJkViB3h9jpqFtf58bT0nX8xHZq7VN0j/5uZjN5VfKlrYimg48X7696PFdDC834
 Hax9/Cwd+3CbMJii3OBgTQ5L/Nck2WpH5w4dRhahwixY3tR8KEdgf1cZE2N2vs5Ok
 LenWcGiSGXrCykN5h6ZPYUCINwOnljvTAKPdrm9a9X04eEWEh9ll6M0Drn3lJw3Ql
 elW6Smoc23Cxcr4zSYF+0Sac23/mbF0WFsu8S33V1gzcZnSiwJTN3aDqF1VaPntLH
 3b+1aw2Mh6hexZXd1Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=NymTi0ji
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

Am 28=2E Juli 2026 18:49:48 MESZ schrieb Scott Moser <smoser@brickies=2Enet=
>:
>efi_bootmgr_delete_invalid_boot_option(), eficonfig_show_boot_selection()=
,
>and eficonfig_create_change_boot_order_entry() each enumerate all EFI
>variables by repeatedly calling efi_next_variable_name() in a loop,
>passing the same efi_guid_t as both input and output=2E GetNextVariableNa=
me()
>needs the vendor GUID returned by the previous call, together with the
>variable name it returned, to know where to resume=2E
>
>In each of these loops the efi_guid_t was declared inside the loop body,
>so a new instance comes into scope on every iteration=2E Relying on it to
>still hold the previous iteration's value depends on the compiler reusing
>the same stack slot across iterations, which is undefined behavior=2E Wit=
h
>a compiler that zero-initializes locals by default (e=2Eg=2E clang, or gc=
c
>configured with -ftrivial-auto-var-init=3Dzero), the GUID is cleared on
>every iteration, so the lookup of the variable name returned by the
>previous call fails and efi_init_obj_list() aborts:
>
>  Cannot initialize UEFI sub-system
>  ** Booting bootflow =2E=2E=2E with efi
>  Boot failed (err=3D-22)
>
>Move the efi_guid_t declarations out of the loops so the value written
>by the previous efi_next_variable_name() call is preserved across
>iterations=2E
>
>Fixes: 140a8959d48f ("eficonfig: use efi_get_next_variable_name_int()")
>Signed-off-by: Scott Moser <smoser@brickies=2Enet>
>---
> cmd/eficonfig=2Ec              | 4 ++--
> lib/efi_loader/efi_bootmgr=2Ec | 2 +-
> 2 files changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/cmd/eficonfig=2Ec b/cmd/eficonfig=2Ec
>index 4d060e3007c=2E=2Ecd66f05fb7a 100644
>--- a/cmd/eficonfig=2Ec
>+++ b/cmd/eficonfig=2Ec
>@@ -1844,6 +1844,7 @@ static efi_status_t eficonfig_show_boot_selection(u=
nsigned int *selected)
> 	struct efimenu *efi_menu;
> 	struct list_head *pos, *n;
> 	struct eficonfig_entry *entry;
>+	efi_guid_t guid =3D {};
>=20
> 	efi_menu =3D calloc(1, sizeof(struct efimenu));
> 	if (!efi_menu)
>@@ -1872,7 +1873,6 @@ static efi_status_t eficonfig_show_boot_selection(u=
nsigned int *selected)
> 	var_name16[0] =3D 0;
> 	for (;;) {
> 		int index;
>-		efi_guid_t guid;
>=20
> 		ret =3D efi_next_variable_name(&buf_size, &var_name16, &guid);
> 		if (ret =3D=3D EFI_NOT_FOUND)
>@@ -2245,6 +2245,7 @@ static efi_status_t eficonfig_create_change_boot_or=
der_entry(struct efimenu *efi
> 	u16 *var_name16 =3D NULL;
> 	efi_uintn_t size, buf_size;
> 	struct eficonfig_save_boot_order_data *save_data;
>+	efi_guid_t guid =3D {};

Thank you for addressing this issue=2E

According to the UEFI specification:

"When VariableName is a pointer to a Null character, VendorGuid is ignored=
=2E"

Initialization of the GUID is not needed and should be avoided to reduce t=
he code size=2E

>=20
> 	/* list the load option in the order of BootOrder variable */
> 	for (i =3D 0; i < num; i++) {
>@@ -2265,7 +2266,6 @@ static efi_status_t eficonfig_create_change_boot_or=
der_entry(struct efimenu *efi
> 	var_name16[0] =3D 0;
> 	for (;;) {
> 		int index;
>-		efi_guid_t guid;
>=20
> 		if (efi_menu->count >=3D EFICONFIG_ENTRY_NUM_MAX - 2)
> 			break;
>diff --git a/lib/efi_loader/efi_bootmgr=2Ec b/lib/efi_loader/efi_bootmgr=
=2Ec
>index 8c9a9b5eb56=2E=2E3ee47000d23 100644
>--- a/lib/efi_loader/efi_bootmgr=2Ec
>+++ b/lib/efi_loader/efi_bootmgr=2Ec
>@@ -934,6 +934,7 @@ static efi_status_t efi_bootmgr_delete_invalid_boot_o=
ption(struct eficonfig_medi
> 	efi_status_t ret =3D EFI_SUCCESS;
> 	u16 *delete_index_list =3D NULL, *p;
> 	efi_uintn_t buf_size;
>+	efi_guid_t guid =3D {};

ditto

Best regards

Heinrich


>=20
> 	buf_size =3D 128;
> 	var_name16 =3D malloc(buf_size);
>@@ -943,7 +944,6 @@ static efi_status_t efi_bootmgr_delete_invalid_boot_o=
ption(struct eficonfig_medi
> 	var_name16[0] =3D 0;
> 	for (;;) {
> 		int index;
>-		efi_guid_t guid;
> 		efi_uintn_t tmp;
>=20
> 		ret =3D efi_next_variable_name(&buf_size, &var_name16, &guid);


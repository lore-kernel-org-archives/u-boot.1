Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A8E606A320
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H72lMRaW;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=aZH3Q6xJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EADA66063A;
	Sun, 22 Nov 2026 09:57:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HmO9K1XWauQI; Sun, 22 Nov 2026 09:57:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 03C2D60626
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795341468;
	b=Fu58Zoxe3WyLXzp9iPEmj4T7mNa7jpEahIGQAYJSdcK3c1BxeAYJZ7u0Aynpe3dCeO6h
	 4CV0zNa6K3dP31ZyjCLyFpWEIosiX/dag5FnVhCyH3lNe5qb82GvhS6TQPuG6LK4w3NBB
	 V4Tpe8nSDj+P+qWlQDwyIY2FqzwkP+PfpHefHCPndZHwfdO0orWbnstDOv93BqtFUgIx1
	 CdXpJ8t0TcTtDR65mTWDPZm+IcBAQqH1wzNxtgwPz/VsGY9aYgmzw1aT6ZmOhQHfRmLGN
	 tQ/YAbsZCGWJOV68XRXXguwyZAaqJtVpwYgCrShRmLz5Z09P9EnB87deg+DBzsgY38g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795341468;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM2-Signature:Message-Instance:DKIM-Signature:X-UI-Sender-Class:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bpCgk744Sjd435+/S3sICDvi+iOW8v1NAHQjDIeYexs=;
	b=l7cgQhWoVFa26cpmMayS3O4mR9oKg8MMzXkg1Peyw6DAGH0h2dSaZuNlHEpnd0N9iilu
	 fqv2eiqY1ljujSwLeL26newIG7BroBT6yQEe/6paQGD88OSzynmSbUkxcJI+52qgqENJV
	 vEqFn1U4OdHgi6nKIHliGEtWK1IbNDUIglzxYEvuHeg1ymed9u/Ra90tr7FsCT+Hswahx
	 AHIyqvUCYSdQHogNxS/COubkOGTeVWURZ6MVTUimeQZrLcIKtVBbNg8qGxbVAGjoL/8f3
	 9GzkTz9UZFpEUI6YsKK7J/WEUQoHofOiKbGJUYvaL522jIszzFKz7m0kb136iQPvuHQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795341468;
	bh=bpCgk744Sjd435+/S3sICDvi+iOW8v1NAHQjDIeYexs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H72lMRaW5NU95bfcpdZKQ+CFugvCBpzcbIFukIW5kUCLr97bHjkoA2FEATiGmVXxB
	 8xcZbEehtfEmz912dHnnJ4GDYIZE6Se6LiyrLR+oazpzyXV7v/FL4pB2aH9GnC/wUh
	 sqt5FyYi9f68LA8Wv7r7MP1alYcBt3v/CV0ZPeAFRjQzng0SZVza0RhOrIOqE1V4GQ
	 nQTRv/P3FcgEfuX1JMdDOvdZM7GMoPWvPFT1ShyRkxj4LcwGZ8L1WnbhhVXCyuYi2U
	 Ll/4Bjhti6q9I1REr913YzOQ9xVeTiKqGXW1B8HuiWFWxqyUvzOj3m3Hsfj0hDz4ii
	 Uh2b+9kdwcBBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03C2D60626;
	Sun, 22 Nov 2026 09:57:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B71F310
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 09:57:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4D083401AE
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 09:57:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Baj9sfSV8wy7 for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 09:57:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BC40640176
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.227.15.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.18;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=aZH3Q6xJ
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BC40640176
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 09:57:43 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795341461; mf=PHh5cHJvbi5nbHBrQGdteC5kZT4=;
 rt=PHUtYm9vdEBsaXN0cy51LWJvb3QtcHJvamVjdC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:NxqSiFGLOgxSPP6FcXNKd4ED8ljn
 gaTzMZAkdL2/Jqn+qtxRKkaAjBqcYB4unnOA6cJadpWn3odPArdSk9Rk6F9gU49FBxbMMmCsg8h
 1a2b/JtC4xbsEd89ah+k7/+quU5qxCPCDl+qWCaBiK/6XZwpo6PNVJzB33vyErjHWcU/6qjuGxG
 5IqpVB0/azjORTees/J2E9CLfN7JYba+zjLYF2jD4zbeCxROzZYkvSkHo49P0oq/jITsBaLDRtD
 c3pNrg0dfJeDOsZdnwTiiKKkA58I3GcoXxrDGBsmxG7+4VolUKTmzEOklEQfGrht6nTZcrhnFQK
 KyGt3nnh7fugIw==;
Message-Instance: m=1; h=sha256: c1SewCW+/ALxo+YuZzNOfyMbPAzHuGAr5qYDkwl5mFk=:
 k0flL9glnxOi11BHTGiNd1qJ7mXmviuwfq9KjH2orUg=, sha512:
 sRuZidfiJauHQ1CxUe2rlswbfFzI+NURnYCM6wzvdttXDdB5I1eCgq1kNAopvbc6ZyGpgKirFdPuXvFfA/fD/Q==:
 NXbYX9V1znLkOcgDAilLTZAGMOW9iQMxUwKUhNlB/ZxhJdACkQnhEHltagq5QhhP2L24okXPrMgoa93TPJHnQw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795341457; x=1795946257; i=xypron.glpk@gmx.de;
 bh=bpCgk744Sjd435+/S3sICDvi+iOW8v1NAHQjDIeYexs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=aZH3Q6xJzXep3+2jCRnW4XfGgDlAlY4M1TGHPFJpTB5byKohBAc8cGmenFLVegTg
 MEUjUJrOvSiUlw9jnS3WSr1SZUDR0yhPSzwuNp0NRvCagVJrU6A45lPmoXnUfZMq4
 nfeDXGDKyHrSPQ6EJTKKqv0g0Rgq9tDiqoRWncRRAIiWxEaNqQx3ZvxdWNnWwqtM6
 axatLqfnLE6MMFHnXKZ7tCBMufayrQ+DvE2X2LpZvDXOnhtOmDXzLEfjkOD7ADYCl
 m9yzUUNe5uVbOL6rv1rBU4ccYcr0Hs8o+mOYT+2Cf6uyEMs6I+4O10gneFDGQ1ZXQ
 weBkL/047iBTVwl4KA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Ra-1yb8S83Oi8-010bhT; Sun, 22
 Nov 2026 10:57:36 +0100
Message-ID: <4349d335-d5e1-495f-9510-903ea97f3464@gmx.de>
Date: Sun, 22 Nov 2026 10:57:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bootmenu: fix leak of entries for missing or inactive
 boot options
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261103180110.1025372-1-oss.patchbox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20261103180110.1025372-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MBpof5UeVVaqGXU4h7/F+tSMjnsINvYms4HxHvv4v3W1rafjGEH
 YrWdyDv+hemCU7cuEIqZ2cYrjyn0znUCc33KE7R6tBwZl++7fIQpksm3W+OzR1bc5+D+VYm
 OQbL0GurtMGg5AHa+C0uT/ifF2E3WfYiR3bWEtaqu/707L5GVsWdsQTbS0kBGzyIcAaBF3P
 WJefBKBqKy5Ylm4DQ/b1w==
UI-OutboundReport: notjunk:1;M01:P0:A9LEPsOt2h4=;ui+kSysGOWNju3jCvhhVFSE9s3x
 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
 n08n/pYqfZEFTFQv4Q==
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 19:00, Yuho Choi wrote:
> prepare_uefi_bootorder_entry() allocates a menu entry for each index in
> BootOrder before it reads the Boot#### variable. The entry is only
> linked into the menu if the variable exists and the boot option has
> LOAD_OPTION_ACTIVE set, and bootmenu_destroy() only frees linked
> entries. When the variable is missing or the option is inactive, the
> entry is neither linked nor freed.
>=20
> With CONFIG_CMD_BOOTEFI_BOOTMGR=3Dy and CONFIG_CMD_EFICONFIG=3Dy, each t=
ime
> the menu is created with UEFI entries ('bootmenu -e' or
> CONFIG_AUTOBOOT_MENU_SHOW), one entry is therefore leaked for every
> such BootOrder index.
>=20
> Allocate the entry only for an active boot option. If this allocation
> fails, free load_option and bootorder before returning, as the error
> path for the title buffer already does; bootorder used to be leaked
> there.
>=20
> Fixes: c606c0059f7f ("bootmenu: add UEFI boot entry into bootmenu")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
> Tested on sandbox_defconfig (LTO disabled for gdb) with Boot0001 active,
> Boot0002 missing and Boot0003 inactive in BootOrder, running
> 'bootmenu -e' with bootmenu_delay=3D1 several times and reading
> dlmallinfo().uordblks before each run. Without this patch each run used
> 128 bytes more heap than a control run with only Boot0001 in BootOrder,
> which matches the two 48-byte entries; with it there is no difference.
> The menu still lists only Boot0001.
>=20
>   cmd/bootmenu.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/cmd/bootmenu.c b/cmd/bootmenu.c
> index b55f5579409..39fc16f8c27 100644
> --- a/cmd/bootmenu.c
> +++ b/cmd/bootmenu.c
> @@ -304,10 +304,6 @@ static int prepare_uefi_bootorder_entry(struct boot=
menu_data *menu,
>  =20
>   	num =3D size / sizeof(u16);
>   	for (j =3D 0; j < num; j++) {
> -		entry =3D malloc(sizeof(struct bootmenu_entry));
> -		if (!entry)
> -			return -ENOMEM;
> -
>   		efi_create_indexed_name(varname, sizeof(varname),
>   					"Boot", bootorder[j]);
>   		load_option =3D efi_get_var(varname, &efi_global_variable_guid, &siz=
e);
> @@ -318,13 +314,18 @@ static int prepare_uefi_bootorder_entry(struct boo=
tmenu_data *menu,
>   		if (ret !=3D EFI_SUCCESS) {
>   			log_warning("Invalid load option for %ls\n", varname);
>   			free(load_option);
> -			free(entry);
>   			continue;
>   		}
>  =20
>   		if (lo.attributes & LOAD_OPTION_ACTIVE) {
>   			char *buf;
>  =20
> +			entry =3D malloc(sizeof(struct bootmenu_entry));

Thank you for the fix.

The scope of variable `entry` could have been tightened to this `if` block=
.

Limiting `entry` to the `if` block would make its lifetime and intended=20
use explicit, reducing accidental misuse and improving readability.

I will merge the patch at is.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> +			if (!entry) {
> +				free(load_option);
> +				free(bootorder);
> +				return -ENOMEM;
> +			}
>   			buf =3D calloc(1, utf16_utf8_strlen(lo.label) + 1);
>   			if (!buf) {
>   				free(load_option);


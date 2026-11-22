Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860A8606A332
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WOer9Oyu;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=n5/sQtaS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D20680E1A;
	Sun, 22 Nov 2026 11:55:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hNAyoNuUTGej; Sun, 22 Nov 2026 11:55:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5F87480DFF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795348517;
	b=Rs20f6O3RTjB5Sy54GG73ODAwswNbcUOhRCfgP4QfELovdhJqIJiw3ypwusQK8oClxz7
	 3PqHHoKyiBRZhoTaU4sC8l8pw7JMcIJmcWTxWWLE5ksLc6+BPsbenAILwtcAnD6AYpFEg
	 ab0qbSqicTXPpW51R96+jhhtavivbNTvS9eOl1D6X1Z3B8utGFrmgn7BPE6TyobxEBuMw
	 0fezAt3B30e9LakPYQdXZiAKsMg9LCOwBY5T0pl0968OKdNY8CP4xxKA4KPufb8Z3lin5
	 jVmo3Xx5RNmuYXnwVzGlFj5amHIjNNOm03n3azj0KiayVPtRYW3slgFnemTa1EULXdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795348517;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM2-Signature:Message-Instance:DKIM-Signature:X-UI-Sender-Class:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FjGiheBJij3MxGZlBDPnLt9XcJAHbtOmTYpg5nK0VF4=;
	b=DljFHSEPTmWAQtai+Gjb4/xK2DW5TC+hoWhplUs5q1irg13Fu+hi9tljQtW2Cy9e2WC2
	 hPN5UrxtoCYgI0cNlRRQigYKJMHXiMka1DQ2oGqNju3RteHr8tfwqAMdN6hapi4fSlXIo
	 qPRIdEbC1p1MAhcsrh/BvSBEhp1jDux/86/GS+aTimBc6JxBVbTuqWAZyCi3bznQe+xna
	 0/2swrB1LzJN3C5Z5YWwKnx9/v9jWd///Y5WDTcy/cTzqmZuQy7+NHgp6neTtOxnk/a6m
	 Pb/meudojqc93m+MV//4fSxP/l9LzDThR1Pn9k4Vuu7VRcMfl3ksy9DjTRUk40ASPWQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmx.de;
	dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b="n5/sQtaS";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795348517;
	bh=FjGiheBJij3MxGZlBDPnLt9XcJAHbtOmTYpg5nK0VF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WOer9OyuXeHLiGKf2TJLaDzxD7iUDtRqmV6fBrZiIIdsMe6VMMGpM095h7MHaZoDD
	 NXYt8zkJ/Kk2iec8gjna3WBLQGppZ+Zxu+G+QcxVby1//W0wy5DxmKdXceol3lcbNq
	 T09d0d8UpTagrsHeQV8DjOCWYxUxZj1NsDznOVutzKPUbetW0oxfAnC/UtBqrYsXw0
	 VD9lrR5wieLqOKvyF+CiS5LXltIbTtu98LKStf75kYFqYiIMOsrJmz5tMYV0gHaY5x
	 JnAALXeyy49nLlZ6euuZVsCPR6aVbJS0ho42XXJDgRAXDUYQpFCfQLD0DxliYHmhdF
	 4TGCTFW0D8rKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F87480DFF;
	Sun, 22 Nov 2026 11:55:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 81D57499
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 11:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6826280DFF
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 11:55:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9QTf3DqdTZ1r for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 11:55:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F22C680DF7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.15.19
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.19;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=n5/sQtaS
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F22C680DF7
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 11:55:14 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795348512; mf=PHh5cHJvbi5nbHBrQGdteC5kZT4=;
 rt=PHUtYm9vdEBsaXN0cy51LWJvb3QtcHJvamVjdC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:eApzn6cq6okA6YuhRMPLmFr3DM4A
 GhK7o/m+ofWEAWplfme1yEamccooymMewlNweZn53QXqWIYpEtwmXEkP5EurJ57EHk8u5T5ey+i
 C+ho/VP02Hb4GjwTTenzlFmVKsZiJNrvQ56RjvLGiIXZ0sMHt0wWGCs4c2YKSdE95Tr2WzzVvb1
 KpzlvryxdiuyYNypeU5BKbR3LLJTpP5+W9pNHBzMP+7d2rWdR2+XM6iiqVZp85rPyQx/F9UjgTp
 Shi/CJnSLG8vrh5cQewqNqFMjkl8YeOVkF25i9PKWutYaN7FRP+TLgMaowl+4houJjiFje3UPtY
 ksJ1b+WDOjL5gA==;
Message-Instance: m=1; h=sha256: 6mDywnz7R/QxiPNmVx3DZRjDBWf8b+xsWgnMvEtbAJU=:
 XkRKErWB/OlTq0vHIlh9LKeNg8fj+EFG1DCv1uKH2E4=, sha512:
 sxmEv0Ah9Wq4lWtSrn22NDSPdDIfzmueZU399a3g894+54JDagdDUIMAYIiY86qg3zMqex7O7S/7pdoM9w+Daw==:
 SKV1TssyNAit50ZpJ8Any5v64qno9CaeIa8AHjOs5IAQSn++U3wjXdDs/1NwywXnr1y91Q3w+kEfNaZH6xcCVQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795348511; x=1795953311; i=xypron.glpk@gmx.de;
 bh=FjGiheBJij3MxGZlBDPnLt9XcJAHbtOmTYpg5nK0VF4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=n5/sQtaSxAUX45SjTCoSKUIc2EBRK3ROGlMZSOkSy2CeKA24P4FjU++pbMyHTj1a
 ofPJ2hNUR+40HeECpWJxt79Q0MCfMWfTRxsClWK9dhAjodjz2PQCAi5uPmcjxIoKr
 grVV/IbmFKIgqEJ1gL9PyfZdn7LirlQpD8i/N2kq2LUkBL7lGLRDr3dtebTG3NvGa
 FQ1cusDmXwyEI326VzJAvC05o6p26n947ORiR+Iy6jnlFmCgYEIwjzHs7XQbjX+V7
 q+/znVcSLotOjG+HGPwBiKbukIvcwwzZfVOIoBZKNyicmnzUd3ASFtEYOFGBGkK5H
 GwlroGkMbV2GbdmcEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpDJd-1yKOoa0fTL-00iylv; Sun, 22
 Nov 2026 12:55:11 +0100
Message-ID: <6e9c726c-ef44-44ec-91c1-267273ca8f4c@gmx.de>
Date: Sun, 22 Nov 2026 12:55:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] efi_loader: prevent set_variable() to record
 append_write
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261113-append-v1-0-4cb63d522562@arm.com>
 <20261113-append-v1-1-4cb63d522562@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20261113-append-v1-1-4cb63d522562@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ye5JnVM3VxzseofUpZPqV3wRyW2iKILnc7F2C8uLZaVYNAYcXPX
 39/CjukxpHdBMlS3o83g2oU4gelWtJTM8pF6kFNgq0oFl1K2XYY4fwt3NEkaVD2tm2TFkeR
 9Aniie2whXNG2cLiVpkYpvBLICSnHPoWEp4GliXfNgh4n2jiNjE23B4EBa1w/QrxsxR1Zxj
 5YCIJEFnEI1KkZmdSFzNg==
UI-OutboundReport: notjunk:1;M01:P0:BnPi+MZJaUI=;rIGw62YFInRL+7SVQFzNAEW4Tb0
 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
 Q==
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 16:07, Vincent Stehl=C3=A9 wrote:
> If SetVariable() records the Attributes bitmask with the
> EFI_VARIABLE_APPEND_WRITE attribute set, this attribute can be returned
> later on by GetVariable(), while this is forbidden by the UEFI
> specification. [1]
>=20
> While the non-TEE SetVariable() already makes sure not to record the
> attribute when appending to an existing variable, it forgets to do so wh=
en
> appending to a non-existing variable; fix it.
>=20
> Link: https://uefi.org/specs/UEFI/2.11/08_Services_Runtime_Services.html=
#getvariable [1]
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>   lib/efi_loader/efi_variable.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable=
.c
> index 9923936c1b5..8bf2c91f3f9 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -384,7 +384,8 @@ efi_status_t efi_set_variable_int(const u16 *variabl=
e_name,
>   				      var->length, old_data, data_size, data,
>   				      time, &changed);
>   	} else {
> -		ret =3D efi_var_mem_ins(variable_name, vendor, attributes,
> +		ret =3D efi_var_mem_ins(variable_name, vendor,
> +				      attributes & ~EFI_VARIABLE_APPEND_WRITE,

Hello Vincent,

Thank you for detecting this bug.

If the variable does not exists yet (var =3D=3D NULL) and data is provided=
=20
(data_size > 0), you still end up passing around=20
EFI_VARIABLE_APPEND_WRITE in unsolicited ways.

Should we remove the flag from `attributes` directly after setting=20
variable `append`?

Best regards

Heinrich

>   				      data_size, data, 0, NULL, time,
>   				      &changed);
>   	}
>=20


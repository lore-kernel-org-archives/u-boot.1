Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543C1606A334
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FnDFYZsO;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lDZcFpVg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB36160761;
	Mon, 23 Nov 2026 13:56:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D_XXX4nEcH82; Mon, 23 Nov 2026 13:56:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1A9CF6072F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795442195;
	b=siCwxmXuX8jKGAkxMH6lYoHRp3ssdiZCt8TRZhgHmciFLkHr9FB1Q7oQluWEAOHQOdie
	 aIXLcUmqdibEIYMERfhz5ocXJs+WjsKm791OmnWGhaiEc70vuTMOTMJ4vG89Pe//HAqQG
	 jQn2nn9wojdKYvuHkvtL5ztf9GCfNQ+7ZKessoVnNVTywSZL0KATLIbtFN2I9Niz4sk9F
	 cO2nqek7LhQyKwmzD5yRMXTTi3SLyYdW+A0SO+1y0EdXt70YwXpRzWFcq91DGVMOIlNnh
	 G4yluaINE/6bsLN60iV3WsyU4zv3scpt3BagyEb1GWcNJIw+iWWvqrTOjfeRb3/C4jw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795442195;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mPbFP3AJdXkYba0fVZy+nbHvFhzugMFm7vwzQNBROP4=;
	b=TvxrVSaawvPOc9BPtmWwZ7itV4kPbcyHTPrSesDcn2rZJu9mMRpc4OgnKIpKDbLvWRWk
	 DHYVzTKwgJSc9Z9tFMWy1dYbKsW4dfDTBtDGqb37Bl02VGaKCXgyy+L6v6BiPlImJYAYw
	 sNjm5LeXUyeiuzmMQUF2P5CW9aLX+IqRRbtdwaN88YqMxgFv23WSIeoDqwhH317otym80
	 J3oC1U4cQYMUja6O5U/5U/wvr9/HLacbn9IVe2fz5IdRdk3dT4VyvGGp9FMwYsELOaMo5
	 VAfdmXkhePUmG1qY/GGij6MHZg4dqbJFaIXRRGwKclVJaf8qZprWrNdtJ8oUVWKn2NA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795442195;
	bh=mPbFP3AJdXkYba0fVZy+nbHvFhzugMFm7vwzQNBROP4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FnDFYZsOSUKCdrhc52oR/LwOuo7a4X+oUwPWG7Dkam93bUsrjcZSXvFbhxy4FmmNa
	 uxP5tlGE8NiYcPkOwnbLYTJRqdCmg+FmwRqa6eywLo3oYpYnyaYbgXR1y38tz1/8R3
	 6Q8HjBzVRWYewiCzWaxkDSS4ZknSJuOm9Q9wWlfofMuEQ4pJvx2plgREWsE8+lq4Vu
	 no6iwrqjaHT8kcxdvMgvdvfqH3kFFWH8GXxRfxu+fS9Jd+yk0FW4G8uPtSijaZhq42
	 EpKLdRjgMa0m7gHPc+y4+KzDWEIDg00k6+bhfLLX0Wd6kdSXMFbsEmyDEVjnfsSGEC
	 D1WvCdpIJvpmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A9CF6072F;
	Mon, 23 Nov 2026 13:56:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E08C260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3456E80E0C
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:56:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ohrCfXWGu_T for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 13:56:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C463D80E0A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lDZcFpVg
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C463D80E0A
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:56:32 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC590841F2; Mon, 23 Nov 2026 14:56:30 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9054B83108
 for <u-boot@lists.denx.de>; Mon, 23 Nov 2026 14:56:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 51007621E3;
 Mon, 23 Nov 2026 13:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA491F0156C;
 Mon, 23 Nov 2026 13:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795442181;
 bh=mPbFP3AJdXkYba0fVZy+nbHvFhzugMFm7vwzQNBROP4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=lDZcFpVgK42UkC6OimhGdfpxDySXDVASXprI9H9aXZkC1j8lTQSy8FC9eXV7PEi/M
 B2hk4wfEuEoHKLpAmn9zapUFRKcE3vs6vErCwt0gbc54R+AlhVGSe2H/LBJmDEAOrn
 yq4gEl8ZodnAogPSSEVyatN7gFPF6WAPQBorRmytsUzyd6aPoFhf8TKHMdEFO1Ooc+
 pFQ3M+CcJRdtUEfFUvKDhRHRRudGzoI01moCA0Fi4UDOtiORIIbj4Nors6ra0+Fdap
 cgcCwiWnnJq8n8a+5cqL6MobIp/KpVQ6da0w2m5+8SAeJ4qxBmTO4HgEmJQNt2lJ6C
 1NNA/ZlI/1gsw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Guillaume La Roque <glaroque@baylibre.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jonas =?utf-8?Q?Schw?=
 =?utf-8?Q?=C3=B6bel?=
 <jonasschwoebel@yahoo.de>, Ion Agorria <ion@agorria.com>, Peter Geis
 <pgwipeout@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/9] fastboot: Add
 board_fastboot_flash/erase/get_part_info hooks
In-Reply-To: <53169c72-64e0-4ffe-ad62-a5d7f988bc68@baylibre.com>
References: <20260930075527.92697-1-clamor95@gmail.com>
 <20260930075527.92697-2-clamor95@gmail.com>
 <xhkdbfqy567t3.fsf@mkorpers-koolstof.csb>
 <xhkdbcxt65btd.fsf@mkorpers-koolstof.csb>
 <CAPVz0n3HUqT+TqyRrkyc83r-sDXMcMEXpqPPYxhinvp1rs8pDQ@mail.gmail.com>
 <xhkdbse0ypi3o.fsf@mkorpers-koolstof.csb>
 <CAPVz0n3NSBJo+n7=Km5+GmyuQ7QQ=FhKydXP=dqBnJC7w4K=4w@mail.gmail.com>
 <CAPVz0n0e1r42peR3nv9ma-nFmhsiXB+cZCa6EdN35MA_U8K-SA@mail.gmail.com>
 <53169c72-64e0-4ffe-ad62-a5d7f988bc68@baylibre.com>
Date: Mon, 23 Nov 2026 14:56:19 +0100
Message-ID: <xhkdbse0rslbw.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Svyatoslav,

On Mon, Nov 23, 2026 at 14:37, Guillaume La Roque <glaroque@baylibre.com> w=
rote:

> Hi,
>
> Le 18/11/2026 =C3=A0 11:45, Svyatoslav Ryhel a =C3=A9crit=C2=A0:
>> =D1=81=D1=80, 18 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 1=
2:44 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>>>>> You are mixing up. This patch does not add any vendor commands. It
>>>>> allows using native commands with vendor quirks seamlessly.
>>>> I know it's not exactly the same thing. I'm just worried these extra
>>>> hooks will make stuff less maintainable in the long run.
>>>>
>>>>> For example. Tegra devices require bootloader and bct to be encrypted
>>>>> and bct to be updated every time bootloader is flashed.
>>>>>
>>>>> $ fastboot stage bootloader.img
>>>>> $ fastboot oem board:write_bootloader
>>>>>
>>>>> Used has to stage bootloader, then write is with some custom vendor
>>>>> bootloader flashing command which we have to make, document etc etc.
>>>>>
>>>>> This series allows intercept native fastboot commands of flashing some
>>>>> partitions and apply vendor specific adjustments directly. So I can
>>>>> flash bootloader, boot and system with native command `fastboot flash`
>>>>> but bootloader flashing will be performed with encryption and does not
>>>>> require from user any additional movements.
>>>> I understand, that it might be easier from a user experience point of
>>>> view (just fastboot flash <whatever partition>)
>>>>
>>>> But adding extra vendor hooks also means having a specification of wha=
t vendors
>>>> should do in these hooks: adding docstrings, adding documentation in t=
he
>>>> fastboot.rst page and such.
>>>>
>>>> I'm not NACKING this series, I just wish to discuss in more detail why
>>>> 'oem board' is a wrong idea.
>>>>
>>>> For example, do you have a closed-source userspace that forces you to
>>>> use 'fastboot flash' on tegra devices?
>>>>
>>> On production tegra20 and tegra30 devices bootloader must be encrypted
>>> with aes engine before flashing, and bct must be decrypted, updated
>>> and re-encrypted before flashing. We decided to use hardware boot
>>> partitions to store bct and bootloader, so we do not have traditional
>>> boot partition. Hence we are using fastboot flash to intercept
>> boot > bootloader (typo)
>>
>>> "bootloader" or "ebt" and "bct" commands to flash partition and use
>>> our own implementations for them (for emmc and spi). All other
>>> partitions can be flashed by default and need no special handling.

Ok, let's go ahead with this. It is indeed a more elegant solution on
the user side (just using fastboot flash <partition> and let U-Boot
handle complex cases (like bootloader/ebt/bct).

>
>  =C2=A0 I'm rather ok with the patch and with intercepting the native fla=
sh
>  =C2=A0 command through hooks, it's already done this way elsewhere in fa=
stboot
>  =C2=A0 (fb_nand.c, fb_spi_flash.c).

Please also look at how it's done in fb_nand and fb_spi_flash to see if
we can have similar return codes (if that makes sense)

>
>  =C2=A0 Some small comments for v2:
>
>  =C2=A0 - board_fastboot_flash() returns 0 when not handled and
>  =C2=A0 =C2=A0 board_fastboot_get_part_info() returns 1, it would be nice=
 to have
>  =C2=A0 =C2=A0 the same value for both .
>
>  =C2=A0 - When you rebase: flash() now starts with flashing_refuse_if_loc=
ked(),
>  =C2=A0 =C2=A0 please call the board hook after it, otherwise a locked de=
vice can
>  =C2=A0 =C2=A0 still be flashed.
>
>  =C2=A0 - A small update of the fastboot doc would be nice too.

Please address Guillaume's feedback (as well as mine I posted
previously) for v2.

Thanks for your patience

Regards
Mattijs

>
>
> Regards
> Guillaume

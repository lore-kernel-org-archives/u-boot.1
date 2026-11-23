Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9963606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U+V16BOH;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ktmFL1Fx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FF2760760;
	Mon, 23 Nov 2026 14:03:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yi-amq2qbHAZ; Mon, 23 Nov 2026 14:03:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 88943606B1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795442625;
	b=hxIygp5+JYJf9aUG0s55ToHd9MiHzAC+WaDfUjmiMlArLJjXtKSsEjvNmPVVUHdgJk2X
	 bNjF2hYc7CjYd0QL4aAO10sTSOW3Tdgz8+I/OnVk3SbzVv5EQePXvKa1v6Fgow6hYtJB6
	 6cjdptI8WHqHBckK43sTbj7oDJwiSihPDITW97BbtGBqFhCPZ8ZXNzhxe2uAPvQEBErpF
	 QmGkLLdx94U31Z2oeZUcpXMB1j87AQLNl9RWbblGFzWzYMcV/gE92agbsF3CJqqAlzCeV
	 LfVwvhSOZW5nUVZuJVRwlgP3hvhaIQUUn3UfUrmrBPYTqzOi5xU528obYeKqPy/8lDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795442625;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=er5Sntlh+vY5OmaRZ43PaY8O40dvb31OloZbrAB56ic=;
	b=rQibEB+ZbhAKCtYLus0cOKAM06Gcxw1eOd66Bli+1/kz7YLyna3s2EQ+sFQCbGTCCkuF
	 8CRQCTEnFFgxJRQLvhU6wuZoyL0NO+b4su+xIBG64xyx8Z3wP4noidtvS63k7njd+8b6B
	 yuyucNUM2WLQElprPdUvJ/8HDZeODXTFeFcAyw8D4fGftOjEMhqMB97DAdfpAu3BNy+KK
	 3JYO+gJh03xB3VWMD/DYSn2D+qyVeo1hfyGbOyXM+9u1RIK2pksykI1csJfUbKtjSIcjo
	 Us1NvOYic9gsdDafUCVpx63F2CUmQo72tDB7ohPdcwkv0qy/qIaV6oTkYalA/KefLJg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795442625;
	bh=er5Sntlh+vY5OmaRZ43PaY8O40dvb31OloZbrAB56ic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U+V16BOHKvNTeqVooYVWi/t6kWZWnPxhzVBKENNhQJ4IQ2uVmx4IRdynbxQEFrG51
	 XlluXnEyfxkSrUKCfH3sfvyRkdabPoBd3/snRAfydHLTzG/W3k43N3ZDM/g36cVZGz
	 Gbls6TGv0P6RMaj68bzcP/GI1w2HB9qiEbWBDfobDMBbJQ7gfyHceF2Jy2nWoXOKib
	 JLFzGcrryACNcGHkfV7jzy7cnaMG02U1eD+fbDAdoKB2cjciLuDGsYhI9lkBNkfpWQ
	 IzCFe3XOdTgxsA3mUZoI5W2bvNKxd594d3sAzH2QvKvonDW4PV3B/IWUTSOMqPbQyT
	 WXP8xYEQdpn8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88943606B1;
	Mon, 23 Nov 2026 14:03:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3146A371
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:03:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 171DE40665
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:03:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iQ-t1fmMg7GI for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 14:03:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B8C3F405AC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=clamor95@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=ktmFL1Fx
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B8C3F405AC
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:03:42 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFB11841F2; Mon, 23 Nov 2026 15:03:40 +0100 (CET)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com
 [IPv6:2607:f8b0:4864:20::132f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A85F783108
 for <u-boot@lists.denx.de>; Mon, 23 Nov 2026 15:03:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-382f4710a17so5664215eec.0
 for <u-boot@lists.denx.de>; Mon, 23 Nov 2026 06:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795442612; x=1796047412; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=er5Sntlh+vY5OmaRZ43PaY8O40dvb31OloZbrAB56ic=;
 b=ktmFL1FxmYJG/n+nNTFA+pIlhcKiPWxXiFrtL2N7FGeozuxwGVDDjEHmlciWpY5GC/
 03VTetjTSUlFXe0osoz6Pxfupj/DYj2hI8t5PCcX234veAcKpn/9Aokt7DIPpPnmkaqx
 ytOcCD4nLDgxYHslwcHdojewUezfGC0npTNr8I11DFzGMRS8Pm6S77K2THS/Igr0d+x1
 8g46VoOs90SMFAiRufW6coJvuOx+j9heseqBzbMMJNRWv3nhFDDepH0OyGyhEsiG+jIn
 kPyOywVJeq7A2yBAnjI2BOz5sf2DZupe4i7dl8mARew+qwHHZyRugBh7W4lQaBWoATU0
 X1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795442612; x=1796047412;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=er5Sntlh+vY5OmaRZ43PaY8O40dvb31OloZbrAB56ic=;
 b=yDY4JnhrFogm3QdZ1CFyqflOqZiznZJblyhlGaNPu0ZCK/yB4HE+CLTfjAh94zda2G
 7RSWPGtYiScvHY5m0PdK+ZKZ1PtXXy9wh+ZSPZbDy1R58BXk7bE9Z69LO6bYBlFmd3hu
 IGCMkoi4jE3eSryOAc/Q4gdetWVpbqGf75N6sVUdyHCSxrgoYbML5khxhKpN0fyW2XTd
 aJH+jILW24UcvL/CQPM2nlaI9kLywZOs2XKimTOEhUjE8aJ79Z6uzqjziAB6DWmPCXnt
 muLbkVfop8aF6d6Q+8pC/Xd4xTFA958mxF7ZTkuuVk1tI1Re9dhkLi7jlrEMK6SoeaQf
 k8Cw==
X-Forwarded-Encrypted: i=1;
 AL+hErHqaRUqpuVGHTAsU8QChOMMK8d3woSbKzUcUXpnPmT+2BoU7J86uUOxqgaHR2ihxW0pBFbmfDM=@lists.denx.de
X-Gm-Message-State: APuU4Z8iHQkh8lt5Snz2ibrCIdchZ2QmdhnW5csgKCuxHHtuoW4SfFOq
 Qqda5R5ZOHBIR3JwJS9eOzYeKKzn0w0LczXAFPM96rKxLnKd3esUQAu+dpOQCz6Kv8OpFLvflro
 46OdTEg/Tgb4Tda5JrcLbR35picoRsJk=
X-Gm-Gg: AZFdTZfsxvqGI8ZRVyF5oZK691lNl59DZ59n68E0qt5j7+bw4wVpzLzZ+RD/J0XY7/1
 sfcGquzJ2h+Eo3S8jYz9mpzPMoMBWNwdXDgpf6doyxnWIeqDFmrQ0JSbHFNZ8b+jvO/425CLVrf
 5Uy9lH/B+tjifvj1Se51xgNcpXSCO7EdsmMvPTuCoUzaX/s7Of+H5I8PMIQVgMQK+vndmM5P/8i
 7Ul94KlDFdBOzoViMYovGtSgyxOssmMptmPvAteHDmUi0wkpVFdv78a1y3KOVi5l2XrHPh6yE/Q
 CqlnZoapYe19ChkcdpI6uKAnPyuvALs2u5e5fP/9mOLNeSRSv2NRfkH5hfW8icre69GkuJTMTkD
 qatpHDzEQtSyUoSsjytWsTX7W65adBuMVQBv+rCEMA6xABVghlWwdSemJToJMW1qp48C0PtnuGp
 cTWY7DgLTO8aPK5vx51nhMg9WT/mcPTyPB4Uo+kkkB5/IadMJKvqY=
X-Received: by 2002:a05:7300:f68e:b0:36d:4560:dd38 with SMTP id
 5a478bee46e88-38571807cecmr11297719eec.37.1795442611627; Mon, 23 Nov 2026
 06:03:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260930075527.92697-1-clamor95@gmail.com>
 <20260930075527.92697-2-clamor95@gmail.com>
 <xhkdbfqy567t3.fsf@mkorpers-koolstof.csb>
 <xhkdbcxt65btd.fsf@mkorpers-koolstof.csb>
 <CAPVz0n3HUqT+TqyRrkyc83r-sDXMcMEXpqPPYxhinvp1rs8pDQ@mail.gmail.com>
 <xhkdbse0ypi3o.fsf@mkorpers-koolstof.csb>
 <CAPVz0n3NSBJo+n7=Km5+GmyuQ7QQ=FhKydXP=dqBnJC7w4K=4w@mail.gmail.com>
 <CAPVz0n0e1r42peR3nv9ma-nFmhsiXB+cZCa6EdN35MA_U8K-SA@mail.gmail.com>
 <53169c72-64e0-4ffe-ad62-a5d7f988bc68@baylibre.com>
In-Reply-To: <53169c72-64e0-4ffe-ad62-a5d7f988bc68@baylibre.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 23 Nov 2026 16:03:20 +0200
X-Gm-Features: Aa3M54pQmPvMqEAzlXrmXabXpy46ACnOHzy-R5AfH8Rn1pxMMzaN955SoaiUrO4
Message-ID: <CAPVz0n2mxsbEs7xzqwOeF1zsDLvq+Ab6Yhu1EC=z_gTUqQb3pw@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] fastboot: Add
 board_fastboot_flash/erase/get_part_info hooks
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Thierry Reding <treding@nvidia.com>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Ion Agorria <ion@agorria.com>, Peter Geis <pgwipeout@gmail.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_FAIL,SPF_HELO_NONE autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D0=BD, 23 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 15:3=
7 Guillaume La Roque <glaroque@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi,
>
> Le 18/11/2026 =C3=A0 11:45, Svyatoslav Ryhel a =C3=A9crit :
> > =D1=81=D1=80, 18 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
12:44 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >>>> You are mixing up. This patch does not add any vendor commands. It
> >>>> allows using native commands with vendor quirks seamlessly.
> >>> I know it's not exactly the same thing. I'm just worried these extra
> >>> hooks will make stuff less maintainable in the long run.
> >>>
> >>>> For example. Tegra devices require bootloader and bct to be encrypte=
d
> >>>> and bct to be updated every time bootloader is flashed.
> >>>>
> >>>> $ fastboot stage bootloader.img
> >>>> $ fastboot oem board:write_bootloader
> >>>>
> >>>> Used has to stage bootloader, then write is with some custom vendor
> >>>> bootloader flashing command which we have to make, document etc etc.
> >>>>
> >>>> This series allows intercept native fastboot commands of flashing so=
me
> >>>> partitions and apply vendor specific adjustments directly. So I can
> >>>> flash bootloader, boot and system with native command `fastboot flas=
h`
> >>>> but bootloader flashing will be performed with encryption and does n=
ot
> >>>> require from user any additional movements.
> >>> I understand, that it might be easier from a user experience point of
> >>> view (just fastboot flash <whatever partition>)
> >>>
> >>> But adding extra vendor hooks also means having a specification of wh=
at vendors
> >>> should do in these hooks: adding docstrings, adding documentation in =
the
> >>> fastboot.rst page and such.
> >>>
> >>> I'm not NACKING this series, I just wish to discuss in more detail wh=
y
> >>> 'oem board' is a wrong idea.
> >>>
> >>> For example, do you have a closed-source userspace that forces you to
> >>> use 'fastboot flash' on tegra devices?
> >>>
> >> On production tegra20 and tegra30 devices bootloader must be encrypted
> >> with aes engine before flashing, and bct must be decrypted, updated
> >> and re-encrypted before flashing. We decided to use hardware boot
> >> partitions to store bct and bootloader, so we do not have traditional
> >> boot partition. Hence we are using fastboot flash to intercept
> > boot > bootloader (typo)
> >
> >> "bootloader" or "ebt" and "bct" commands to flash partition and use
> >> our own implementations for them (for emmc and spi). All other
> >> partitions can be flashed by default and need no special handling.
>
>    I'm rather ok with the patch and with intercepting the native flash
>    command through hooks, it's already done this way elsewhere in fastboo=
t
>    (fb_nand.c, fb_spi_flash.c).
>
>    Some small comments for v2:
>
>    - board_fastboot_flash() returns 0 when not handled and
>      board_fastboot_get_part_info() returns 1, it would be nice to have
>      the same value for both .
>

I have defaulted to -ENOTSUPP if  hook is not implemented as Mattijs asked.

>    - When you rebase: flash() now starts with flashing_refuse_if_locked()=
,
>      please call the board hook after it, otherwise a locked device can
>      still be flashed.
>

Yes, I have already rebased. I noticed this change and adjusted this
patchset properly.

>    - A small update of the fastboot doc would be nice too.
>

Yes, agreed.

>
> Regards
> Guillaume
>

Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DEFCA5FCB
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 14:10:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 399DA811BC;
	Thu,  1 Oct 2026 14:10:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iBAzG2hqbykJ; Thu,  1 Oct 2026 14:10:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5D62B811C9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790863812;
	b=qC8/VtrXTAhRYZgWFNYKnWnZnwEX98PLpz4+ZZiFyzfKR1Jv17nGSzz6xUOy/LbvX4k3
	 qAjlLJbIt8b8yWN2qJHU/9lkKlWhVJOXkKQZct+gM6ivv1QVocYAqC/LgisB91iA6gL8y
	 /QEyxViqzqBxdl+W/lOfBUR/4tVQgWGr9x/ezGCcfNmb5xHHnZo+BOivC4RCscsSlvbCE
	 eb+oor0XuCi+a7ThK0x38lxof2W4dNURZ+9vtCv0lpaRO3M3xhHI7VhUQe7HXCBKYAim9
	 pSGhaXI+NtuN3+gGG7PrPboBVcwqew5wSnd6G9S+1+I1UfQXXO29zvtWH6Ykdqomp6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790863812;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ywh/uLB6umrFY8OyoZWeX1TnLqkpmoVBmAjY18M6gH4=;
	b=YepqeQN48431JzXht/elIZAkPUEnZv1IT1WCtJcBaIXAgLnG729MW9v4cHmgJ3nzEvw3
	 8c5ObadKSa25/cvdsqqEEU26r9XefmauvslD0dX66XRMLvmxQo1bQZ1Ud/lMwEAdiyP07
	 /1DeLmfbm2TLqNOlMPyCFv6L5by3nD8jiXGJvVSKwrcAXK1J2XnTy+LzEIxs5tBI9U2Jd
	 nIM72DP827xVY3mU3mu7KJqKAuoUSzFr1Q7QG35iCLVfaT7QGXqD7DY8pEOBX744cCUht
	 N0P3Tj+CGAz5Mfh8vIiwn04GpU2ugxaJcMCLqL+DBX73s89lGIysuZqnziHZCom5+GA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790863812;
	bh=ywh/uLB6umrFY8OyoZWeX1TnLqkpmoVBmAjY18M6gH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kgS+0lCyGU8uINNwkNplmOFUI7xjRwvYvzAjNDU7789er2hlYSZbIGLYvNoUFgMki
	 CdTS9SqUf11367c7XcHNW/DT60JQ2x+TpVkdBLZFpUtbmIlEhsBKqSAXcj2+aMFvls
	 nGGg/0rQxwrW7+rQmS9JFBhqC9XkqPCdsZRo2P8IBRCSKxlI19fZDah8S7p50soCny
	 Hfl1Wb4p+UcncSQ3EYmHiUIG4iHmJE12PhHvfCK4gR1LJ7rRzxq88VAOeuQ7yYtyv7
	 HJrS29fjX3SYQ2gnwy+n/0VayLRfy2hc2w4P6Aph+NRLWTGV3M0telTJQO+pUvU4Sh
	 SXrfYqryReSuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D62B811C9;
	Thu,  1 Oct 2026 14:10:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A0C41A6
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 14:10:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7B91340CB4
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 14:10:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BpTR-Ul0VhEO for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 14:10:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B342740BEC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::26"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790863809;
 b=SuS8pgbC+cVgnJ9Miy+XDz48Pbb/0T4JB59RLHaxKczkyRlawrcTfHodFIYrBwaPyEt5
 vlbIbC8aPSDktwcDtmoJaSsnpPY6/e/3bdOLdcGFnESXRr8ZEAmCFAzdinF3SWnANQxPh
 IZnQRavLxgJ+OLLBdPcikE13QBBordITuZYMJyAxqdCGvJNBYg1mD7Et4ldd04AS/WPyI
 DE6nuprP/R34HgWA3GswX7y9CMUqKV913fQtgqREUucsrq1s2IygzKqKvpSg1ewuJLC6v
 Xnxce2mrK3SbgBU+fFU5CFuYlLWcmGO3QbcEZ7nLnCVpmLz9Z8llKmVY6kldDWN3HbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790863809;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=ywh/uLB6umrFY8OyoZWeX1TnLqkpmoVBmAjY18M6gH4=;
 b=MF3B3gk1GMFQw4LhoVzXkdKxZaO6wCnVIUzl3TIPP5HCFi6z9b8UYGbxz6rt/+zoWstM
 8FR9q/sEskZyqPemkUxjIxPVE1P5nleyi5dFi4fAJ0P7s1h4qjCJFf3JWpiGkMfa2PRjW
 bxojOC8O6YpSvvEj/hlOqca4C2ncyFF2fg82aNUrrVMFTaFad0e9hCVlBJzpNxTsXEGXj
 IUOiv3OPCob774dl+ox88LrEoPvovj1/5aVh/4iyZTWpQAtAOPupHwx1rlVNvVeb2JGbE
 HCPRPv7MYA/AWgUCMS5OfShsFWV34RwA9UCO07b/mvtbajMB5WO15JMPccFRSERg7Mw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="T/wNa1wX"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::26"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::26; helo=mail-oo2-x26.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=T/wNa1wX
Received: from mail-oo2-x26.google.com (mail-oo2-x26.google.com
 [IPv6:2607:f8b0:4864:31::26])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B342740BEC
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 14:10:09 +0000 (UTC)
Received: by mail-oo2-x26.google.com with SMTP id
 46e09a7af769-821c01c2fc5so506438a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 07:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790863808; x=1791468608;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ywh/uLB6umrFY8OyoZWeX1TnLqkpmoVBmAjY18M6gH4=;
 b=T/wNa1wX+O3wI4dzLBK1QxEu9XAs3FBBW5ar62Xn0bMxk98wWrE43OTf+a/583RXSA
 x3uE5o1nYqF3RKGNwBWrliC9xKHYPiHKHUqF3orUwbX7eKo4gmrq32iczXP2x+uMv6H8
 hPfUf7cvaCh/ImJx57IK/pXZbqJrny/gzJBHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790863808; x=1791468608;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ywh/uLB6umrFY8OyoZWeX1TnLqkpmoVBmAjY18M6gH4=;
 b=VvpJrUwigAOiD9XW18V7uR+AHwyhNsKcp4sQGNn8+28zmOQHToCvecJ+C/Zu700BMy
 z+pFNdXX8wTpx5UOa4c9k5pUW9j/FGsNrn3qwXfaMpxg/jBJhn7Nlc9/L2x/BktnBkZ8
 0GPeEQo7b22nG+mkRZaHcEUvwyTElRWcamcRPNXeAvQ1XbncJQBBiCS1IT7ExX4gKH05
 pTHq/byFeQLV/+8mLkFSSPVdU/Vt5LCI2bB32jiZ9zvEjp4aTmsssGPQ4mhuNnMtli6O
 n4X6DY/mBstlg4U8luzL3+NSOZ+6PeLJUqDVO51JFdnOAKD0UllcU5j0Q503oGbET0fi
 Mq4g==
X-Gm-Message-State: AFuF++n+wiHYNHMyqBY1599x9qa4YtQ3nYJEUdAo+/BsoY8q9WXKA14+
 1Ov0iCBhxjd2yswrvHcnd68vIugVNKnsG7JKen7RYX6thGosJ+ECVp5k+ADGWc/apaI=
X-Gm-Gg: AYBFou22mnyVaUErQJK0ikoxzyhi62XsF1De+MU6Vwjl0MHFbLusDjoFM1vVeDn91vS
 BBSSLEoP8GsPQCg53TwmOwmXdsdIE0Eq3oeUgEQhotdGPBca3QR4zF+u6aHMUBQmZDfbrAsNHG/
 soAiNYMOzkTWsrj+lANu/v2FAld5eO6ihzlLi3JYGHaMHykdSZOyXRqNtiw7fIv34ggS4v93+hv
 Z/LpKn+Wie24wDIoa7Ej2iqNAh2S2gRhM877QmXV1U7IdNioXQIe/Oqs/5h1OR54lpqH/1Z6cYA
 nsWvhnn+rbtc8Ngxnq22RicufbA4bnKdzeo3fVnvxm/4KZQwDUH2VXhUc2oMNmGCJ9oo4vH4wtw
 FNhS0m44wDODK1PVTrjwoaFRcHRHcnCyGXFd1DgSSpcwXBGdO9IuYXbClxJRttZtHUdn4Ms0jRI
 JeC7AomjqAjwlcNpZ0KF2hPdxo+x1RTTkzXXVauQbSooLNT+hGnrJva66TOR99wuSzm62nrgBQv
 1rrWh2luz9lX0pgXlaTRxkHT35pmFzWlqKsYM9W/TdtD4ZOgoPdNnkHu3cp/TPfhRUOeeZ4O/Hc
 KOzrm9HlhJKTdTz5AMs=
X-Received: by 2002:a05:6820:4b01:b0:6cd:3fcc:96d1 with SMTP id
 006d021491bc7-6dcf7208044mr4117277eaf.79.1790863807934; 
 Thu, 01 Oct 2026 07:10:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-49decb70f38sm2601912fac.0.2026.10.01.07.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 07:10:06 -0700 (PDT)
Date: Thu, 1 Oct 2026 08:10:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Milivoje Legenovic <m.legenovic@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH] Disable SMBIOS table creation for Odroid M2
Message-ID: <20261001141003.GL858934@bill-the-cat>
References: <20260926005853.1727-1-m.legenovic@gmail.com>
 <CAFLszTh=X272wjo4_7B54hYMz4gRZ78KhUuDCKBPzOR8L4RA3g@mail.gmail.com>
 <CAGuQyfUdhhFuW-DCgw8C5hA8mkgP9DGyUW6XnLdMZ0q+Ui0QzA@mail.gmail.com>
 <CAFLszThQZy=Sj7bRsbWOFn=Sn4mgzkeo=4Sj0Qyhu9cWotO1ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AFRXat5sBxQpEBc3"
Content-Disposition: inline
In-Reply-To: <CAFLszThQZy=Sj7bRsbWOFn=Sn4mgzkeo=4Sj0Qyhu9cWotO1ZA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--AFRXat5sBxQpEBc3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2026 at 02:27:38AM +0100, Simon Glass wrote:
> Hi Milivoje,
>=20
> On Wed, 30 Sept 2026 at 23:29, Milivoje Legenovic <m.legenovic@gmail.com>=
 wrote:
> >
> > Hello everyone,
> >
> > Here are the details of my analysis:
> > The commit that introduced the change in behavior in version 2026.01
> > is this one:
> >
> > commit 209bbc4e0032228c6ea17e2172a8a6b89756c4f5
> > Author: Adriana Nicolae <adriana@arista.com>
> > Date:   Thu Nov 27 08:28:34 2025 -0800
> >
> >     boot/bootfdt: Add smbios3-entrypoint to FDT for non-EFI boots
> >
> >     The Linux kernel can discover SMBIOS tables through two primary met=
hods:
> >     1. Via EFI tables, when using EFI boot;
> >     2. Via the 'smbios3-entrypoint' property in the /chosen node of the
> >     device tree.
> > ...
> >
> > I found this out by comparing the device tree from a working version,
> > decompiled using
> >
> > sudo dtc -I fs -O dts /sys/firmware/devicetree/base -o live_tree.dts
> >
> > and difference was in /chosen node:
> >
> > chosen {
> >         u-boot,version =3D
> > "2026.01_armbian-2026.01-S127a-P7283-Hee1c-V2928-B3a7f-R448a";
> >         linux,initrd-end =3D <0x00 0xecbffca5>;
> >         bootargs =3D ...
> >         smbios3-entrypoint =3D <0x00 0xedf47000>;
> >         kaslr-seed =3D <0x00 0x00>;
> >         linux,initrd-start =3D <0x00 0xeb519000>;
> >         stdout-path =3D "serial2:1500000n8";
> > };
> >
> > In 2026.01 version smbios3-entrypoint was there, in 2025.10 not. I
> > searched for this term in git history and found the commit mentioned
> > above.
> > With git show I saw what activates this, and made a patch in armbian
> > build system to disable it and confirm it fixes the problem. And it
> > fixed it.
> >
> > Here is also where kernel hangs for 60 seconds (always at the same plac=
e):
> >
> > [   14.482048] calling  gpio_led_driver_init+0x0/0x38 @ 1
> > [   78.137967] Freeing initrd memory: 23448K
> > [   78.165027] probe of leds returned 0 after 63677665 usecs
> > [   78.166792] initcall gpio_led_driver_init+0x0/0x38 returned 0 after
> > 63684076 usecs
> >
> > As you can see, I was only able to find the cause, but that=E2=80=99s t=
he
> > extent of my expertise.
> >
> > At first, I wanted to sort out the problem with a patch in the Armbian
> > build project, but then I thought: "Why not sort it out at source?"
>=20
> Good idea!
>=20
> Does 'dmesg | grep -i dmi' show a DMI line, and is
> /sys/firmware/dmi/tables populated? That shows whether the kernel
> reads the property.
>=20
> Does the hang go away if the property stays but the region is
> reserved? A quick hack is fdt_add_mem_rsv(fdt, smbiosaddr, TABLE_SIZE)
> next to the setprop in fdt_chosen()
>=20
> If so, you could add a fix for 209bbc4e003 - i.e. reserve the table.

Thanks for the additional details Milivoje, I'm hoping that someone else
that worked on this can explain how the change in question here leads to
a kernel hang. Can you please confirm what kernel(s) you've seen this
with? It might be worth increasing the kernel loglevel too.

--=20
Tom

--AFRXat5sBxQpEBc3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCar5puAAKCRAr4qD1Cr/k
CqbUAP9ruO2k4rYy8uHv3XRHat24zpU7Z3ML2pl5LVFiOUP9gQD/euYjpI/1XKvm
1iX9Gj4f7IGgS2UfDH6xF8iKv3VlaQQ=
=6LLH
-----END PGP SIGNATURE-----

--AFRXat5sBxQpEBc3--

Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D58606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FWu+Jub4;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ah0Z7Rfo
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED4F9405A6;
	Mon,  2 Nov 2026 18:26:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2PJx0XtQz_OB; Mon,  2 Nov 2026 18:26:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2007E40360
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793644001;
	b=V7E32poUNuopNPqfyu8xIjRRdLWGfPdmjPsbC8scJHNnvJQ/oku1N1nORLXzz2UBERnd
	 1maS2ZB7g7ABwdv2ywYeLCpH16BU0d4JaGW3FbgKUluGyR8MHeCtXKnQanmwc8jBMz3CB
	 uv2uPv2iN8nBjkDuC8uKGHKdpGDpCeNwy4VVR2stHJHdIaFRK/m/7ME1L4zotmL5wU7r2
	 P/Yc0Vzbx+ljYzv8TrbynuUA0dUlMajz1n2e97SH8ZbWwRB/gAVoWuRTnGnzH6cyLvxHl
	 H6VzL1jaKPus83XyzHHmTTmhyH5XxjkhoCxcDY+sfByeaU+Piu930jiIUsW6MVP8WIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793644001;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=PWF/qXS+6Hkva+MLwDHO0syRdDUnWaGI42Y4d7P+jAg=;
	b=AwR1eLlpeZ+SPOKa+yjvgM45vdswZ/RzV5li1MWkg92T3uHcZi5IaFRFm5sPJl/s6k8Z
	 rBSDliUk9ou1MOOCt41eoW/NXMFsALzmsaIDhyGCZmQwr4s/Z4y1DPjIU5PeXm24D4xAq
	 yHRJBuS0Mpc33BqL/Q+yequeuFOckjtAImiziL304tNZd9P9IzFoNqHcw5kiIsXTeIdN3
	 UYHbAaXKQxUdIsr2GYpMi3neoiX2EfFnfeQa1cmLY1w+kmwxTuzhFQMPt8FrYLAxvnUmt
	 C+NqZyr4ZWzI7aKQyd9j4NX7IBqCAOYS4DVQfNO/Zd9cunA/wyP5iw/gCwF9CoZUlZw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793644001;
	bh=PWF/qXS+6Hkva+MLwDHO0syRdDUnWaGI42Y4d7P+jAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FWu+Jub4F13r5Z6sZPaGIdqURj5v6MzuH6w1Q6FOZ3OskCMjbPz3mipnjrpMd13ju
	 0+V/FOh+VEaik0eednzvIs/pJaaCvH8XXzc8N6r4NB+IsTco0QOSAZinB9D+e5GDbu
	 EYuVHRM8hiiSsvubT6Ueup5QlMZxRq1kn8JmCaOs/gC/g5rwVy016DAwQcos8Zg8Fi
	 mBvqGcNazjCOTEtdgd2sBlCP4J6zgU/abIRbZbu+PKf0NxI1bcO+RTj8Li6f2j7wW9
	 UMjeSl6ZKiTzzphL8kQoj8eLi3iS3Oh/HjT6iQJfHOlwwnmQGDpfJ6Ls1/UBKLZPPv
	 1z6B4I+UX+gIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2007E40360;
	Mon,  2 Nov 2026 18:26:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D234356
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 18:26:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 12E9B400E9
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 18:26:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XvU-qnIVbf1P for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 18:26:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3A833400AC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793643998;
 b=PjDa65zQM8rZW5yYwKSwZ9weiSMOsiNZAME1IQArIXM44tWgSHDI978wavEUT1DpIF1t
 T4UdKv9yuVPKZdVS1SRZ3BYS51qBQGw0/yBColYf/d49bTQ5V2jDJGux1Ipu9bEOyax53
 fuJde374TMvigMnX0/oqLfP6drMR1oCsW2W8JXu2CIFmoPNzwz/j6WUzAoHQ5qjT28167
 hGYMWalpDaf2iv6R4M3cOFB+6IM18WXH2+i2GTtmd0419iYFcgk8eoNWF5+jKk4EPTu5e
 gapLwStjC0z0wN4cvwpEsBdLvQX+/Q3bi/riNYaiAE0K0OuGC9VDX3zYTKs6Kh7N8CA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793643998;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=PWF/qXS+6Hkva+MLwDHO0syRdDUnWaGI42Y4d7P+jAg=;
 b=FPUM1+2jKqkvnhj7cEwA8l/zIB+3KUS+vlYVHrCfqbHZtSSpgipcHl/qrnOyjd1wzZRV
 w05heh9z9IctM74CG8FHkBfesLvRuN7aGttZArsAcAtblBFMfUEEIEDRcO8A2290iHKg7
 n8UPi1gFf99aQRjENshKFI12/FAr4g2Geva+LEK4AAr19zljl130PqQyN+KvsWLNljMrm
 eD+HJCn4HKtPQTu7fxriiWD9wmFpN/HhpUiJwmCFjVIXkpABapRxs66xbDSJO7nQQzTZh
 NJ48Cy+czQyRoTjPoC58/BvsKvjlH2rQVYvb37Mirn/A+cezAnXxYMFiqQXsh/9evXw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ah0Z7Rfo; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ah0Z7Rfo
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3A833400AC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 18:26:37 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-70b875f6f1fso3212237eaf.2
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 10:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793643997; x=1794248797;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PWF/qXS+6Hkva+MLwDHO0syRdDUnWaGI42Y4d7P+jAg=;
 b=ah0Z7Rfo1M7GGXWA+uh0QIAcU8wRurUObFN4C5bShVXWFHRpKbWKOnBgLS77+gCXJX
 TV5zEa1ZMnPNVvNN/4XCWpWatUpgs/WChIvFjtoEcHd3wU44y3DgU1cLk9ufNB+zOuOb
 6ktuO5vo8om9s5TwgUsh9eh8mxsJGaIjO1wH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793643997; x=1794248797;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PWF/qXS+6Hkva+MLwDHO0syRdDUnWaGI42Y4d7P+jAg=;
 b=vI4zCYcFNauXsVOTUIu9Dd7cPTuhm3Y+bQ9dfesIC8f9yiIjYQudTHZgTlyPpDPcq/
 AwjNep4JMD8N4ltCai24msMv4sHtIu2R6b5em9TU8ho4f6hDf4MC1udB2D8KMEX84FqF
 sA38u/+3crB0jw42VBY6VZIeHl77QJa7su2xXg0vFpXlovk6K/osD4p3tR9pTbbf4Puj
 OChHXUFamcxrdQs8kvZ9fM9EbeIQ6flKU94XR6EzPPybKnHw2BK1gpCFgzo7FBbQDPBJ
 YynUqlWBaEwm1ZvIGCE/AIGGCzB5Bx5fKrYuFZpM34Qj5ISbzo5Gtz9cmgwrHLuH9+UW
 9TKQ==
X-Gm-Message-State: AFq9FYKxE0UHA11yE72xvSFPv+dZ9+ABS4CItfnju2ulpe89a3Eh3x8o
 uyFdpYvL9EMDChsE24YLP1aYem+XCTpMs4dSmQJoJoNyNDerqbN8mP8O5l6u2rn/s4g=
X-Gm-Gg: AYBFou0pNokqtL0E+TE5wolj5S1J0qUpkNKfIMf6/z4v79WdA/bQH2tsk/eLEtiQLtv
 Rn/pl4qVC2eLys/RaKL4SAd/8lTG0LTwLSYLvtBKVf1YG4ZYMzYi4/j1lpMbwV/IRgVoCatvTNk
 y7TBhd9fxbP+Co9RmUCSS6uzAA6MPAt+v83j5FhBP8ka6xon23Z6+DbtmCk989PPPvZK8Iw/mSC
 LJmvpuyDsYqtWxAbXhel6wtxtFbUYV2wFb6aVJV8qJiPzrWmbfnlTB0kpmh7PPCRNqld9wWMnb9
 LD36MlZR2OLebgnIDufAlWZPUAMVNe8cEt29UW85LdA53bsVQeclpBGvRQhOUzNeHpk2S660HWI
 ANp5BCGijsnVKxcUE5qjBwYVCBzw8cBBfcUTpPBIsuKTB2Yiih6pOLQ+Q5pb6hAt8S611ggAEjR
 tqork2Nf8ox0mYa6Uaz+WQt9nOAtlDLe3yt2sSS9/Tqu8FeY7zE60buii25nktKL3xBLBR8tyoL
 ET6Hz5o4bDt1ss0YBZ6ntDRtikRKdAxjbPSs6KqNG8IVL5x5JinRBHeYTvJHfZXzXwtORd9angp
 +AQi2OwMDQXR2/vNh2zpe3FUNIfrSt/wzrTvmo74Zc+t0rB2JIk+6EspgS1DvvnWlpu53VdKfef
 84rd1uBDV9Sq3KTxFb8MQmRWj+9zqmuZEjhb7iDljgc/4gaorzV6HA2XZTPO1kWSJvCx7oiGVMQ
 WSbDfOfhX+aBigtC9xovKSbkp4OJAUlA==
X-Received: by 2002:a05:6820:f006:b0:715:453:c6e3 with SMTP id
 006d021491bc7-7150453d285mr4116096eaf.23.1793643996736; 
 Mon, 02 Nov 2026 10:26:36 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d354d05e0sm9357441a34.15.2026.11.02.10.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 10:26:36 -0800 (PST)
Date: Mon, 2 Nov 2026 12:26:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: event_dump problem on recent OS.
Message-ID: <20261102182634.GI3309461@bill-the-cat>
References: <9be46549-095b-45b5-a6fc-a527f1c7a0dc@linaro.org>
 <e5ce6ff6-2008-4f4c-bdef-b07725737f48@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FXb5et/WMkA1Ga/R"
Content-Disposition: inline
In-Reply-To: <e5ce6ff6-2008-4f4c-bdef-b07725737f48@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--FXb5et/WMkA1Ga/R
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 06:11:38PM +0000, Andrew Goodbody wrote:
> On 29/10/2026 09:57, Andrew Goodbody wrote:
> > I am running Debian 13 with binutils 2.44 and have come across a problem
> > with event_dump.py
> >=20
> > With LTO enabled it fails like this:
> >=20
> > $ ./scripts/event_dump.py ./build-sandbox_spl/u-boot
> > Event type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Id=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Source loca=
tion
> > --------------------=A0 ------------------------------
> > ------------------------------
> > EVT_FT_FIXUP=A0=A0=A0=A0=A0=A0=A0=A0=A0 bootmeth_vbe_ft_fixup=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 :?
> > EVT_FT_FIXUP=A0=A0=A0=A0=A0=A0=A0=A0=A0 bootmeth_vbe_simple_ft_fixup=A0=
=A0=A0 :?
> > EVT_LAST_STAGE_INIT=A0=A0 alloc_write_acpi_tables=A0=A0=A0=A0=A0=A0=A0=
=A0 :?
> > EVT_LAST_STAGE_INIT=A0=A0 efi_block_device_create=A0=A0=A0=A0=A0=A0=A0=
=A0 :?
> > EVT_LAST_STAGE_INIT=A0=A0 install_smbios_table=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 :?
> > EVT_MISC_INIT_F=A0=A0=A0=A0=A0=A0 sandbox_early_getopt_check build-sand=
box_spl/../
> > arch/sandbox/cpu/start.c:61
> > EVT_TEST=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 h_adder_simple=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 :?
> >=20
> > So it cannot find any of the static functions. Adding back the __used
> > attribute does not seem to help.
> >=20
> > With LTO disabled it works:
> >=20
> > $ ./scripts/event_dump.py ./build-sandbox/u-boot
> > Event type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Id=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Source loca=
tion
> > --------------------=A0 ------------------------------
> > ------------------------------
> > EVT_FT_FIXUP=A0=A0=A0=A0=A0=A0=A0=A0=A0 bootmeth_vbe_ft_fixup build-san=
dbox/../boot/
> > vbe_request.c:152
> > EVT_FT_FIXUP=A0=A0=A0=A0=A0=A0=A0=A0=A0 bootmeth_vbe_simple_ft_fixup bu=
ild-sandbox/../
> > boot/vbe_simple_os.c:53
> > EVT_LAST_STAGE_INIT=A0=A0 alloc_write_acpi_tables build-sandbox/../lib/=
acpi/
> > acpi_table.c:806
> > EVT_LAST_STAGE_INIT=A0=A0 efi_block_device_create build-sandbox/../lib/
> > efi_driver/efi_block_device.c:236
> > EVT_LAST_STAGE_INIT=A0=A0 install_smbios_table build-sandbox/../lib/
> > efi_loader/efi_smbios.c:59
> > EVT_MISC_INIT_F=A0=A0=A0=A0=A0=A0 sandbox_early_getopt_check build-sand=
box/../arch/
> > sandbox/cpu/start.c:61
> > EVT_TEST=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 h_adder_simple build-sa=
ndbox/../test/common/
> > event.c:34
> >=20
> > Andrew
>=20
> Sorry, I see that this is a known problem and the test has been disabled =
for
> CI. I came across it running 'make qcheck' however.

Yes, it is a case where finding someone to dig in a little bit, again,
to fix a fragile test wasn't found, so it's just disabled.

--=20
Tom

--FXb5et/WMkA1Ga/R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaujV1gAKCRAr4qD1Cr/k
CtS0AP9r6FWTwoePF/n2aKLS5n0oYehtXHyLzXGb/cwiME5umQD/V+8Cc0QiaOSU
PpAB9NvtmxdVkVmz/t0qoj5H6yAwjQ0=
=HH5v
-----END PGP SIGNATURE-----

--FXb5et/WMkA1Ga/R--

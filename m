Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FDD606A88A
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 20:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vvNYRehh;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=i/qgeKWh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC7F280DE7;
	Mon, 16 Nov 2026 20:04:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U9iGHTtk_8wz; Mon, 16 Nov 2026 20:04:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D421A80DD3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794859461;
	b=BFhGXLqM+PY3Q5jYhYSyQjZFv7mU3XL3r1OM1IxsGdLpTErR4TExCRlCy0yoQsNLDeoe
	 yqeTKCaz6kc9fkzPUCDvF36ZrtqZ1265YekFq6GT9BILboCRsgfgIFmRhGbmnZ2AdUGKT
	 v2k4hO50Efmk5FsEphPpmA6Q6IZjzew1YOndot00J69CG9x+WWxIfCHXF8yrg26srpFD6
	 pWhXeuuezMCfq84i1OAr3aU6GzqWrIgEQpyU+pGzoy2tbd0W4/ZQ8nU/Ln2fTUE1qsWSN
	 mtJIxcep7m3xD1Ax44UZxf2ZzukuErgRhL0EyJHLl8yXScxzLfwAuHLwuv9V1VyFODw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794859461;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AR2i6Jn9aJLvlvPBBIFT8TbcfmuwcdXR29vPS9I8zxA=;
	b=UIEypKvyaSpU4Ugr8mfrgDmJ3elmdIilUjkzGTY1kAQepl3xv3+EeQFyO8UhdPR/gehU
	 JpPRrfHKnQraKjVesB59tIxZEQbdR51MEDXGGYyfrROBr18By16XifSVumqQIeCmtnlAf
	 Kyt5OupiaFfCpzvFjxooH+wVe2rzNZ2cLo/+o73JfNmJVo0sjRkBQ+1bBeODnwVRISAiF
	 54fxANkaMx5ft4lLUMIPTWBvr5coqxMA40pgQyRK2/w3+hsyk+hJThYIOaRFJtiLyYZow
	 zVR7rqV7x5KfirRTFNRj8BA6s0num1IB4s/qOeCOpRUtXgAOmQcsESzRF5EvJ5bT12A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794859461;
	bh=AR2i6Jn9aJLvlvPBBIFT8TbcfmuwcdXR29vPS9I8zxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vvNYRehhaXQ/Ap2/9MF8+UONalDtAW3vQJLrDRMOfiv4TgK2yOY8cjrvU22eju+vd
	 7id/MWt/Tw4ugfiiABUIsupv+kfauXMP3sVjA7XYqHonFwVPLah1B4FEU5KbDo42Iz
	 3cfOoRY0snpcsRPU4HQaSkznfIy8Ayt3wbdDd6+gkCBltrA3WvYjtmAuc6dlhcX3V6
	 7PX+w3fAQAr6+OBW4fAjES3e9RTMNDmZpBvkweOEs8weF8ccn5r3tilGqh4eGAz1jM
	 aVoodl4u+HbnzYDQXtiToNZgvmJqSpfKBfrUKtnVyKj1kVlNN6qtQkZsfTYMvHTXRf
	 TtLIho0uddJpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D421A80DD3;
	Mon, 16 Nov 2026 20:04:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EAD8628C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:04:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D04A340766
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:04:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P6RW8UTwuulY for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:04:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B88994075F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2a; helo=mail-oo1-xc2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=i/qgeKWh
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B88994075F
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:04:17 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-70059e4dab6so2797488eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794859456; x=1795464256;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AR2i6Jn9aJLvlvPBBIFT8TbcfmuwcdXR29vPS9I8zxA=;
 b=i/qgeKWhUGaVYOoKXfqDsl2LpsG+8/QPagia/uB+MrLsZUCbN34gbrEMcrbHU61RB+
 C2ndJ1JuDdYtb92RcQWjXXhJcdU/qdmyorjAzMVcbnihVEbwxSs0q6tb7JPfJKd8YNbI
 QM+JAEAm3x0AE+RuXSyllGsQ19OLs7aq9g9zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794859456; x=1795464256;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AR2i6Jn9aJLvlvPBBIFT8TbcfmuwcdXR29vPS9I8zxA=;
 b=AaZVvqzGZhidCn5kMYTnnWgalM/vxRKALwoQ33b7KCEE1Y1oiJ+1kxQaYc69OC9c83
 pnQynqPVJuB6cRWcK6aDCo80IeODqco5kHbkwjiEr2vt2m4qc/oTC4TZc+zuVClF+3C8
 9AMzKoqcI1D/gRcAJgX3qd9WwYqaGanSOf/9aDdWd67HO+AuWQQe9Y/utUqjTjK/m47e
 +nKD7gpvme7rLH/PjZB6tGilOphIGZ0HgfrjbKdN8ZW/mN3ae67e87945AhoRukUSbgb
 IKBMN3A7kz18t5k+KWCoRKiE3Z5hr2dYETzghVG0z7dVl1GrHisQBrACjU1A7hQQP1Jp
 sZrA==
X-Forwarded-Encrypted: i=1;
 AL+hErFx68XdBJwxxXj0yYHF82qOGj7Ei07TfmbygJV9LGOJ5ASD+YUxsRZBi/P9NBfBj+Sv1WLvjvA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z85lp7h5Ra08CllGEHolsRMHVNooDi8CiLG8Nkbysmtfz8sHIvE
 ZPeDIEG7dcwRj9r+F+Qd7DNfK4a7BMEVt7CxWe0xRjLnNCBHPrndpHIrXwE5SD6uIvA=
X-Gm-Gg: AYBFou3eNmofdliDLne+2Rb56anpCwRkUBfNje+1nW0w+H0NkkcybH0NqoWh2SV/HqD
 aURs12tLJIMwgNRebZ3IQviiokJeq0owWOEqV7O6Q/k+4Z4ZDOE4UIM/loh88JEgEki0GVZ1enH
 JO53UH0W6JfsbG6px1W1dWCgFDR866j5rmiWWS4T6h3Pt+gG6CzxOqfpEOWGmS6sNBDIjt8nkdj
 wAakhEr8AiM6hSqpsrQ5M0t1zOWrAlc1Q13q6QUvYyEKpp37sqbYHF/oyqRU3RrEWMJMC+Z6EEp
 gUaNoiFh6HKoBAWSLDu+snORmI2gHA3n2lw8oH6ruJQNQhmcf3S/pP9lB5G/b8sjPrWXsjSSIn2
 o6ws36kxiTguQgIr4byzzmidEyePFkBgQmNACgOwnnW45cYBnqsrDFcJx49UgG+8idjwQN2SFsC
 XxtF3SsJpndvA7SCGIvSa2gc4z9M7B+igeA5vQQSdC6aVqhaci7E3ZCv9gc7elOLmF2hFXML5Sf
 GBKKPQH2iyVf4VhU3pDrWgu1osuXQVMXvy9RoilgbFbHF2NTBHxpX/u8Uf6uUxKrWskxFkgCYQ+
 Wt6O59ucSSdC68bgbpQwPhBhlkDx/euqR/1g4fH4CeXIUX2vdUGzo7atUoR6DTrEjzHmgEQFGBB
 2F4jeFudhwZLJ6/JWhE+bp3rPToHeiCL4Gq55+d9r6WNTOxaS7sI0g2RbrVrdTGtgNDXAlFSDNR
 koHUcCb1BQkeriPs6G9DixAsWIkJNXLk4=
X-Received: by 2002:a05:6820:1ca4:b0:706:5b0b:4e8e with SMTP id
 006d021491bc7-71ab51087d6mr8349147eaf.55.1794859456103; 
 Mon, 16 Nov 2026 12:04:16 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71add7dac1dsm6648932eaf.5.2026.11.16.12.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:04:15 -0800 (PST)
Date: Mon, 16 Nov 2026 14:04:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Igor Velkov <iav@iav.lv>
Cc: Jerome Forissier <jerome.forissier@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/4] cmd: lwip: wget: write the download to a block device
Message-ID: <20261116200413.GI554944@bill-the-cat>
References: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EUxMc6SAW4g608vg"
Content-Disposition: inline
In-Reply-To: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
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
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NUMERIC_HTTP_ADDR,SPF_HELO_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--EUxMc6SAW4g608vg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 01, 2026 at 07:53:22AM +0200, Igor Velkov wrote:
> wget can write a disk image only after the whole file is in RAM. This
> series lets lwIP wget write the download to a block device while it
> arrives:
>=20
>   =3D> wget -o mmc 1 -b 400000 http://192.168.1.65/armbian.img
>=20
> The target is a whole device, a hardware partition, a partition by
> number or name, and an optional byte offset into it.

Getting back to this. My thought is, the cover letter example throws me
off. I was going to suggest something that looks a lot like what's
covered in the patch that adds this, and the documentation. Maybe just
add a few more examples to the cover (not just whole block device), and
assume the default buffer is correct, which is what -b 400000 is there,
yes?

--=20
Tom

--EUxMc6SAW4g608vg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavthtQAKCRAr4qD1Cr/k
Cth5APwN84Zwfj7bi9psIFA1SVXt+pWux13N4vyJXRN2ulbtkgEA8FK9iIMGeabz
Thf5tiqBGmP/+g7wavlfYzBFKOGeTgQ=
=eN63
-----END PGP SIGNATURE-----

--EUxMc6SAW4g608vg--

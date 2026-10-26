Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5639606A322
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KrbiIoui;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=RXVhN71k
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8B9C80E02;
	Mon, 26 Oct 2026 15:31:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TRYak03Ay3Un; Mon, 26 Oct 2026 15:31:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1404F80DFD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793028705;
	b=W/2WgAudsyn94x9iTWq1HMCOPrt9Z20jP970qdWDEjpLdPgcD3K7qNh0VmoUrqIr/GPR
	 KSjRr7Qbd3jTneJ4ltkintPqeCVW/q7pxe66hVrr+pO4njQusJXt2VBQSHX+zU/LH+kId
	 7/LbtzVVyM/XnMgrqI1mskwF5wRIgCWOwHw3DYXQHJ+Fx53lKHvMpbJU1swmfyb84769S
	 mF59uBy+td3V6Ycc0FnTzT9jqgk4awTf9v2XOxnm2BVFX2FRbj9qG7H00ZBa/3AgJePKo
	 QspwsnIHfcnQrwZ+6MtAyYyrvXwZPI7UL/tlYoBJvKpudrbYS+s5yCu3eKc9P1fM6Yw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793028705;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3mltBdzatYT5fhgMhRDTQceK20jEt4F7T36wKmaH3Ac=;
	b=cPv/7mQlAXAycm5mDaguRGfDBTYZ3ynVkFFK1RBd3SyF+25YvMi6wY+U3KFOLZ5UTgDQ
	 xm3pZ2R3ZOXsS8Ki0GUkJYjBkdStvzAq6GccOmtpuXPLwccenS5oieao2r5SS9wQ+Z91t
	 3DwGwqQ2PLgoBvuHKvALNHDyqYYNUy3P40Gfex/n4mmq7xblRRWIF04wbgg9BptqPaE37
	 9+GdHdjD14SykEtqMP/gQjyoz3xs/fkPPU6tCzUt+cqoIHqys1gKehvKWsi1RJBksmTS1
	 gUL/hlzaIOgnzEDKQZjSvUVGk1NyYOkBbVX2P3+IFSoOkVhRIi4O7b/v6GC1rlPadmw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793028705;
	bh=3mltBdzatYT5fhgMhRDTQceK20jEt4F7T36wKmaH3Ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KrbiIouiiOUwmz53rvuqJEsIwMc5ODhMLKPjac8AAlni/S5N2TOZAZyqee7gp1k+A
	 TTq9ogm+GjwbmAcItaKvEhvzx99AmDe2TOfWfmsbp1evfV87fnWr9IjRRlbUJja5bH
	 D5qb/LzwxR/IF9thdAdm+lIYKVSCdEZ/EIkLdR09aDrJ9E5uvaE2/82Tnc5U07mRFA
	 V4CS1Q3qi+FTVT6Y/EeoBu8V9ycpkbAZqxaTq2HJAzuEa9kLwalXXBm528Klx5wvA5
	 I95JiDRzsj4vC8Cszv+Z4Bk/l/DBRsaquO+HI2YRcfreL0z0UJlr5szNoUQQNJik+f
	 mPUS960gaGdjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1404F80DFD;
	Mon, 26 Oct 2026 15:31:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A6D5D4BC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:31:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89C9540093
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:31:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t8o0q1wIMcfC for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 15:31:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CC0C740062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793028703;
 b=RG88V2fxrtyj9UaMNufHPdpIrM2uELIQ/ri9zIuGcF+A+enkQMFcCObWrWfafXNBN+py
 N5zjpTEEJXRfTGgHVApz7bfyihWa8PxdKKevxAw37sNSJXm/zm4Yeey+qZuoBLX7t99TN
 iUVkbLtXABoSpX1gCypiYoQDLSNT1u7ERzIJs9jVo9LY+yvo2GXSEqV/+qBI8RZUvHe+6
 JUIW6AYbOZUnHLsZxxm4Id2mQVRN4waYpDbNnzdx1gMuSEAcZa2ipAEfWarrFbMLNxIVh
 VgbQHUJp42xeszJSZdl6hyxTB3AwhayDUIhX0LRhuEj4ytul8nQvH0T4dURZpY/eDkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793028703;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=3mltBdzatYT5fhgMhRDTQceK20jEt4F7T36wKmaH3Ac=;
 b=EtTwHmCmXFPBk9CkrdXlbiwoFo8NrPJn4Pln5YvTa0XavpTzT6v22OczhjsDb4M1eVBR
 Ewrbf3NpCj7Us5PJmvWMOrUWd7GN8QF4DaZ3i0AU1RYVWz6K7RtnPexr8puOXsW5YaqM1
 K8+6zHSbU+YAmdZZyyERYbdB0q76UDQLEWJ4+lgTSSkW8JN6ujZwmjcxegX1ugnq7UQCw
 0jDitFsJTI0IxD+bG9ckWoeJXXBUO4BpVHiCgyTiqe2aTswqpA9OVUQN7WvX91+/JM/VZ
 CGe7lZ/mFmnCz5ZEZyuf9UEJhXycK13pUPfMJNhl7TcpqI5KcZPQ1zZHOtYKeEtCUsQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RXVhN71k; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RXVhN71k
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CC0C740062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:31:42 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-844a8bf7e25so2208775a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793028701; x=1793633501;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3mltBdzatYT5fhgMhRDTQceK20jEt4F7T36wKmaH3Ac=;
 b=RXVhN71kWzG9Cn9qRsUumkuOYyZwdc6msjk4yRv35ekLrzCIF8mX99gkLw7J98YSNG
 EHp0Has6ENlXNTh6ONnPg+dj26fzavsYobxkr1xaAUdWl8tdxKxa5gpfuSTwy4TwxO36
 8jzkI5h2nd57+radg/gBqM9DiWdSoFySPQQ7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793028701; x=1793633501;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3mltBdzatYT5fhgMhRDTQceK20jEt4F7T36wKmaH3Ac=;
 b=fnSKKHs6w/5pe3O07hiVK6ws+c2oDnNbHMWSUcErV2HNz5dbS8/edBWhdeAmtxOz+m
 gdM7XhsdDpFV8l+GgjGucsuC4d+xGahmnFA4kiCauhUXnODAbDbg8/I9LWPXBgUCA0Z1
 CzBHnLvZtNUOxjW0OHKZQC8nzfeSFHKOwV9IjLP4QCmuUle+S5pVwPa6CxMvc4KIo9nv
 PTGMPy6bga5isWE6McFaGlgjZEREpccec3tnZpZj93gxXQV6KR7z5fGgy50JRcGt9F6G
 FmRJs7y/Cgldw3+Aq8r9amEtofYj5ve8D/aBuFx0sLJQiFB0ni+v5lS82CtXfS8vwhse
 LuDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxc5Q0D7Lw7CI5Y3NfJi4p+dU6142YY1F62c/lyOTlemHblG+6AqN6A+APBHJ6T1SBj3+4P5TY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLNWA1QKJxVufXA/sOz6niRwUyZeltSCAYQT12D27FkDMvuhZtL
 XzF+/l9MuvaFIKtMMt+1EvW92sHLFhHgBknWQxGQCBciCs/titinh6y2miuTRzEVyag=
X-Gm-Gg: AYBFou03GMCk2/V4glQjxbvroU8ll7uKQEhBwIxxx73ChtmNTjFcHT1FON/p4V9pyL5
 5ROorY4am1bupVic2VH/wLYfwqMcqSlLFQxLozVlsQcE7FWf8EReCqmrF9qYWGwl1hyLYXd75RI
 B9kUAJvlYnlXbRXpb2V+9gziH62sn71quyTi4DdXcJABj/CVXTSNMA4GDmwPtyOKrDIS8zcd6wh
 5SgseyhbOHpmX/AhlSJ0PZ9VCIUBYSO1Oghi20I72w/VoU+vstmsngvbFE96aXQXj/zdDr1qJbo
 i0uYqg/oxsXPIunAWqe1MESGZLeF3ItJnuwV7rOrmKLsXjt3Q93+/3/MG0vQdhjL46qju0j4mw8
 ilKRNsjL2/mXOwmKt63n15eBwB2WvcpIG3JS/7SqBDAuV4dVz+As+NpGlshUr8ja7Pc/kr0ehqp
 nxG0+Vr7ZiofGqIm0dCodSg4H2bTios30K98G7B9q5BtwdUD1Pm5Q+z8IYkgO3a7z6YyWCSIsPN
 5TCqRuXzpMDdQljgPO+xxaYfgWxpDrqIOW1KFxAFQtl8pt7/K1qQEeBGz8vs+tVuoLbUzc1TE9q
 Vz2AS+28Qv6UVetPf9XzN/U0aEpXrlJDjFtCqRi9pmFV8E5R80UhJ9zAAZrpOFVXv/aqNelsfSV
 kCwHp7apZjABYUJBFZv5ffIiegbowqDGz6jUCKgUQp0gSrVejYLeH7DFpGg==
X-Received: by 2002:a05:6808:199c:b0:52b:7641:33a6 with SMTP id
 5614622812f47-55c0020ff7dmr6555591b6e.14.1793028701161; 
 Mon, 26 Oct 2026 08:31:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a84315c1easm4639874fac.8.2026.10.26.08.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 08:31:40 -0700 (PDT)
Date: Mon, 26 Oct 2026 09:31:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: ilias.apalodimas@linaro.org, afd@ti.com, u-kumar1@ti.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] arm: omap: Hardcode control_status register for OMAP54xx
Message-ID: <20261026153138.GD624796@bill-the-cat>
References: <20261026134848.1733598-1-b-padhi@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="prTc0wRUTqExKO8E"
Content-Disposition: inline
In-Reply-To: <20261026134848.1733598-1-b-padhi@ti.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--prTc0wRUTqExKO8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 07:18:48PM +0530, Beleswar Padhi wrote:

> Currently, the control status register address is obtained from the
> ctrl global pointer which points to DDR address 0x8086XXXX. The kernel
> section from the fitImage is loaded to address 0x80008000. So, a larger
> kernel image (~8.4 MB) overwrites the value at the address (0x8086XXXX)
> pointed by the ctrl pointer. This corrupts the (*ctrl) value and CPU
> goes into a data abort when it tries to access the data at addr=3D(*ctrl)

Why is the ctrl global pointer using a seemingly random point in DDR and
not something in U-Boot itself and so relocated and safe?

--=20
Tom

--prTc0wRUTqExKO8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCat9yVQAKCRAr4qD1Cr/k
Ck6bAQDmXYZ8UcHXiNNUV8uac0mTZsYTC/JvOsfmSOn++uBpMAD8Cmr6OVvpp1yM
DIbBzDw/KwGlJZvb6fU88ymPdjiy0QU=
=HaEo
-----END PGP SIGNATURE-----

--prTc0wRUTqExKO8E--

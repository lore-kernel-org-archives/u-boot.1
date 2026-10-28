Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4804A606A321
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ND7zZ5VA;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=cIKtaNkW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1EA7380D8A;
	Wed, 28 Oct 2026 16:44:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F4JZ55owMVNa; Wed, 28 Oct 2026 16:44:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D3D2280D58
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793205865;
	b=dZ2cRoz4p+/U4eVxY1DlEDs0U1UMH9BkuVpVPrM/pPvWHUob9ALpiG4LY2WjBPSuETQW
	 80ifpPv9TxQtU6qQYkeYO4P4qVekSC2zZfPIYQfH/hj7a4nh/8AbsYgPNt4RAfCk4ZjVs
	 VZLT7NoKoEVCPbX88njwwV6sUT9+V4bt3XsdCWHSfw5n4vmlp7kfYRvkGIxASQ/SPau+P
	 E7SKXZRkP6NN52RhNhbs9jcOSr2iaqGVW3vAUtbnds/E6EeUVivpfk0wzLl2J+ulmx0/n
	 iYibFJVCxwVDlXZ662FubkgIi/Hi/rNMEPczWpi6c1sP1zDol3qu4W9YDIP2KAXjctQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793205865;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=WdAcD6MCr1aCFOTDw378uibXkwO0z3k2QL167BZDwTQ=;
	b=P5hGPqr7yntLdvZ0gc7rKO6VbgV4jEGXSmwJmKoE2muUnTN4DZULi1BuDQF5Tt6ewuzE
	 by4qcINJwk6eAgbutjk0+UYL6s/SJvMt1vuVq49+DxV576cqIPjKVp2XVmEdoUgXbmFLD
	 jhfoV7rB1mbio8PyATTFCZGdAekpR+Y/+bwhjaMOO53+MwqIRugMO7L+CAGrMkDsLJzHu
	 crBW6RXt4BNDttsVusrvxVnVFo2g7Uxg8R5knOdlQmEbPsL6iRip9rB4lU+3ZOMgjYRxC
	 U+1OtMZutAGog+FIU2UYw/eubt+COTTxY5h6CeBf8cM9ZrZnjG0Oak6RPgjAanaTZtw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=cIKtaNkW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793205865;
	bh=WdAcD6MCr1aCFOTDw378uibXkwO0z3k2QL167BZDwTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ND7zZ5VAYbAY+Dk1dJYDMY1qcmhxQGoULVtIxUJGPdzs8RgFs6cA+pQ49OUaMxse5
	 XAv4SK8Fqs0zxfe8E+3g3EB+X0p8FjKN7hbvDM3uEdcsOYYwUvrIRof5RUoPKzirue
	 AVUszLYYpS5kA3H0q70xmsyz497mCrSWgfNfQdx1goVM1XCbqfEZky8OUdXZ3qpTnM
	 5u2wDtDIjD0IWQER+PLZSqZZgkwqn3bPpG0xDe5a88AZ6KI+ZyqF6+LTo7GZX0Rih5
	 Ep8MbMymZW0L7MKOU/TKmPk8ETsWFWRH2x3EQZMVU5NzsZALTwxwhXQ/0VJrS2Kg85
	 hT288Rp4Y0Vsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3D2280D58;
	Wed, 28 Oct 2026 16:44:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BB71235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D2FE80D58
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:44:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a5tJHfpEw4un for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 16:44:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7FCC080D3E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::8"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793205862;
 b=jLXr966HV/OLixAEflaLBX0Xpx6UCXzz4bXs1rCjh0JKPqCe9FDF+6pd00jiF73Kv4fC
 1pMSH7jZgMja/ZcyqhkpHcnl8be5Ss6E//RF0F+zSdU0zK+OSO6CcNyajlM7vTlY7+BbM
 N5H18EF5GyUPBcuqkQixrbE29cNbzPQ/imxmJ/nOEbP5U24xq3Sa3ki31EMHXxrbX+qbl
 JX12B7SGxXZXRAd2Iu8DyfxN7d50lUhdEV0jqSpG4a9wYbcYJ9ASF6iTFlc6oQeQsPkVz
 vaUFQQIG3zgSl4ri8Xg3n+5xFTIY+picgbk3pOOBH97bB0s6nCPUuNwcOBg3Z6PnjIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793205862;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=WdAcD6MCr1aCFOTDw378uibXkwO0z3k2QL167BZDwTQ=;
 b=OR3dT6hCy7n0QJ+HaZ9mUCFDF52hKGKHvUZk3FV1iOVkNyo5K602oZoOU9P/9UEOPAJt
 8srt3BTrUy3BA+nm352l/kxal5X7y8Nq6ERDH+rj69qKqfbm6EMrzkOxSQ4ZK2ZSOlhPM
 5lyFuIJsTqhUqXdWiEiVYdeKB0H1Q9tyH8mDtuHbPgTaHA3sAqfchcztIdFN+LHAoCzsO
 sS9T2ValYqbunSYhNWlE8nXMD0KNTKTswFKz74rGZ7P06ekBUAHhg3ON1XWUmv0XbUUWX
 tTyC2EIRqHrxrgHEVvKFk1LhxLSKgSwn62C/+Ah1uR5PKjkKTzI6T5qo5Q6jn/pry4A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=cIKtaNkW; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::8"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::8;
 helo=mail-oi2-x08.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=cIKtaNkW
Received: from mail-oi2-x08.google.com (mail-oi2-x08.google.com
 [IPv6:2607:f8b0:4864:32::8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7FCC080D3E
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:44:21 +0000 (UTC)
Received: by mail-oi2-x08.google.com with SMTP id
 5614622812f47-5187c752f46so525240b6e.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793205861; x=1793810661;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WdAcD6MCr1aCFOTDw378uibXkwO0z3k2QL167BZDwTQ=;
 b=cIKtaNkWQDd4VyRAxofepe0oKhVLw6Z6zkF9J9itd/G/a8PdPaexPZmw3uejtEEW2U
 hAe2rCBXvQPjhRd/GPYDoh/BSfOQMfEF/oIRvdcP1CRtY+IYYnYQ407F+3nlsPKhVdv9
 hCm4vJTcxfkuGpJzSd7FOtFIB6aLQ+Dfkv0hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205861; x=1793810661;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WdAcD6MCr1aCFOTDw378uibXkwO0z3k2QL167BZDwTQ=;
 b=L2Ostcp6s/1UaHypGH5eTOCehNdVkZXJdda0lsCbduOUYYPk24T8en+X5cdzgl39G6
 jU1RE+Ak5fbUSvryMcC8ZOcGksR9oWUWTqSB0T90W5dtvpJ3rFFGneGxWkkjau0W1cOQ
 6kqguabeIMmRSDYteqqkYSyiBfRUZvrWLSnJJwkSZ4apcsAvPHgx5IfJxN7BndxlY8BV
 SJ+weL5Mj075vzkmv5HQ9zw8Vcm56lBLoJZSd4Bn3A+UeIB7q44hPPL5RDX34W7h2ToR
 y0RtkZZLV6KMCV5QsBL1D321vUSqGIO4GQGPwycZm8e1x7xPkwu/cR7icMBw6mCVpLzf
 leEg==
X-Gm-Message-State: AFq9FYLHd/UmxN+v63gIatlJXu9I3m+9hxtXZ80j8gGNfENQPwH40jBR
 ATBmx2Q634vju9XOCMIdRE+VjxB463JJZU0s0OK5RwFVImtih84nSjmDV4za+xpjrWo=
X-Gm-Gg: AYBFou1E5RB13M7Qo/DMEcFy6gz2j1H91UKpBQkNkIa77YyRQpnl3CjOZOcU3L76L+c
 qDIXGJ8JAbTy+ISR1IoAoX5ZrOySgpSWK0QIaIjRRiWTy89BbmAsDdsCew1d8Q79J9vS4B3UtHN
 fBn6myP8KcN9P5iFZGGtjWfHj818S3T1jYhZ/KOBxqDclF5zayUa07d7vp/QCCuZZYEXQ+Ag/QN
 vst68rPUXCIptCs0fMKz7KG2IccZIXTrw5TpPVZMO8TgMsvHLh7XKDdIrg2Lp18HhfI+J35tr1u
 sddpWn98iEIMXjv3CaHfd6R40E61qNUZ9yoGhultNstOyeAD7+Hb4iRtyemooN7CLoliLmtqxNP
 jIYUVUZCgbVQz8/V1YYWASE5eKteJzdAYbEbXma8LMsX1Dpi61c0b34aQMx4NoD3dzH9E3dw8US
 mpt4OyAv+hAAih3C8Qhn4oUgLqzKwlSws5i77X6UhFWnL7NCjY4BwoI1jOaUFO1wWIHg6WSaJh4
 b84oMSKl4PNz7xNxSCAO5OswWoVtibS41W6ftpw5nAdOBy5pT1zfphPC8C8/wfw84G73qTVHF0F
 66T9kmhuGw2rcGLP4bhhzTxz8F04dnvTuPfBTP1wn4FF4g1qHnbNxo0J54723YyY2rL51JjCN7A
 moMoRbHGdvDfUZp45Tu4wn06ZwR1EcNRE1IrQFdoGagwORyZe5IvspdWJS8M66nN3XYJi/89u0k
 /XSVqIrueq8Zyl2OiS3ZvQRA8ZAIWDQIg=
X-Received: by 2002:a05:6808:c234:b0:552:1042:5c35 with SMTP id
 5614622812f47-5638459530fmr2105909b6e.41.1793205860741; 
 Wed, 28 Oct 2026 09:44:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-563c6a50707sm1739087b6e.16.2026.10.28.09.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:44:20 -0700 (PDT)
Date: Wed, 28 Oct 2026 10:43:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Akash Nair <akashn@marvell.com>
Cc: u-boot@lists.u-boot-project.org, jerome.forissier@arm.com,
 rkannoth@marvell.com, naveenm@marvell.com
Subject: Re: [PATCH RFC 0/2] net: pcs: Add generic PCS interface and Synopsys
 DW XPCS driver
Message-ID: <20261028164347.GC2677024@bill-the-cat>
References: <20261028100259.2491887-1-akashn@marvell.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qQhtTzRKtaHXyKzB"
Content-Disposition: inline
In-Reply-To: <20261028100259.2491887-1-akashn@marvell.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--qQhtTzRKtaHXyKzB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 10:02:56AM +0000, Akash Nair wrote:

> This RFC adds an interface for Ethernet PCS (Physical Coding
> Sublayer) devices and a driver for the Synopsys DesignWare Ethernet
> PCS (DW XPCS) that implements it. I would like feedback on the
> interface and on how the driver is structured before I post the MAC
> driver that uses it.
>=20
> Background
> ----------
> On SoCs with a DW XPCS between the MAC and the SerDes, the MAC driver
> has to configure the PCS and read back its link and auto-negotiation
> state to bring up 1000BASE-KX, 10GBASE-R and 10GBASE-KR links in
> U-Boot, for example for network boot.
>=20
> U-Boot has no reusable driver for this IP.
>=20
> What is in the series
> ---------------------
>   1/2 net: pcs: Add generic PCS interface
>   2/2 net: pcs: Add Synopsys DesignWare XPCS driver
>=20
> Patch 1 adds include/pcs.h. Patch 2 adds the driver in
> drivers/net/pcs/ with its Kconfig and Makefile, and hooks them into
> drivers/net.
>=20
> Architecture
> ------------
>   +--------------------+
>   | MAC driver         |  (follow-up patch, not in this series)
>   +---------+----------+
>             | pcs_set_config()  pcs_get_state()  pcs_disable()
>             v
>   +--------------------+
>   | include/pcs.h      |  patch 1: struct pcs_ops, pcs_config,
>   |                    |           pcs_state
>   +---------+----------+
>             | ops of the PCS device
>             v
>   +--------------------+
>   | pcs-xpcs.c         |  patch 2: UCLASS_MISC, "snps,dw-xpcs"
>   | indirect window:   |  page register + register offset
>   +---------+----------+
>             | MMIO  reg-names =3D "indirect", reg-io-width =3D <4>
>             v
>   +--------------------+       +--------------+
>   | DW XPCS            |<----->| PMA / SerDes |<--> link partner
>   +--------------------+       +--------------+
>    1000BASE-KX: C37 AN   10GBASE-R: no AN   10GBASE-KR: C73 AN
>=20
> Interface (patch 1)
> -------------------
> include/pcs.h defines struct pcs_ops with three operations, and an
> inline wrapper for each one. A wrapper returns -ENOSYS if the driver
> does not provide the operation.
>=20
>   pcs_set_config()  select the interface mode, the auto-negotiation
>                     type (none, Clause 37 or Clause 73) and the
>                     speed, using struct pcs_config
>   pcs_get_state()   report link, auto-negotiation complete and speed,
>                     using struct pcs_state
>   pcs_disable()     stop auto-negotiation and power the PCS down
>=20
> Semantics:
>   - set_config() can be called again later, including after
>     pcs_disable(). If it fails, the PCS is left unconfigured.
>   - get_state() reports the speed as soon as the PCS is configured,
>     not when the link comes up. A powered down or unconfigured PCS
>     reports link, an_complete and speed as 0.
>   - A negative return from get_state() is an error, for example a
>     failed Clause 73 negotiation.
>   - Calling pcs_disable() again has no effect.
>=20
> Driver (patch 2)
> ----------------
> drivers/net/pcs/pcs-xpcs.c is a driver model driver for the
> "snps,dw-xpcs" compatible. It is a UCLASS_MISC device and is enabled
> with PCS_XPCS, which depends on MISC.
>=20
> The XPCS registers are Clause 45 registers in the PMA/PMD, PCS, AN and
> vendor MMDs. They are reached through the memory mapped indirect
> window: the driver writes the page number of the register to the page
> register of the window, then accesses the register at its offset in
> the page. The selected page is cached to avoid redundant writes.
>=20
> At probe the driver waits for the PCS to come out of reset and checks
> the Clause 45 device ID. It does not configure a mode. The MAC driver
> does that with pcs_set_config(). The driver checks the whole request
> before it touches the hardware, so a bad request does not leave the
> PCS half configured. It then stops auto-negotiation, programs the
> mode, power cycles the PCS to latch it, and starts auto-negotiation if
> the mode uses it.
>=20
> Supported modes:
>   1000BASE-KX  Clause 37 auto-negotiation
>   10GBASE-R    fixed speed, no auto-negotiation
>   10GBASE-KR   Clause 73 auto-negotiation
>=20
> pcs_set_config() accepts only these combinations. Anything else is
> rejected before the hardware is touched, with -EOPNOTSUPP for a wrong
> auto-negotiation type and -EINVAL for a wrong speed or interface.
>=20
>   iface         an_mode        speed_mbps
>   1000BASE-KX   PCS_AN_C37     0 or 1000
>   10GBASE-R     PCS_AN_FORCED  10000 (required)
>   10GBASE-KR    PCS_AN_C73     0 or 10000
>=20
> Auto-negotiation completion is polled from pcs_get_state(). The link
> status bit is latched low, so it is read twice and the second value is
> reported. For Clause 73, pcs_get_state() returns an error if the link
> partner cannot do 10GBASE-KR or uses Next Pages.
>=20
> Devicetree
> ----------
> The driver uses the existing "snps,dw-xpcs" binding from dts/upstream
> (Bindings/net/pcs/snps,dw-xpcs.yaml), so no binding change is needed.
> Only part of the binding is implemented. reg-names must be "indirect",
> the window must be at least 1 KiB, and reg-io-width must be <4>. The
> binding default of 2 is rejected, so the property cannot be left out.
> The clocks and the interrupt are not used. The driver does not enable
> clocks, so they must already be running when it probes. The gen*-PMA
> compatibles are not matched.
>=20
> Example node:
>=20
>   pcs@1f05d000 {
>           compatible =3D "snps,dw-xpcs";
>           reg =3D <0x1f05d000 0x1000>;
>           reg-names =3D "indirect";
>           reg-io-width =3D <4>;
>   };
>=20
> Origin of the code
> ------------------
> Some parts of the driver are influenced by the Linux XPCS driver
> (drivers/net/pcs/pcs-xpcs*.c).
>=20
> Design choices
> --------------
> UCLASS_MISC: a PCS is a UCLASS_MISC device and the MAC driver is
> expected to get it by phandle. This is what the Airoha PCS driver and
> airoha_eth do today. A dedicated UCLASS_PCS would be cleaner, but I
> left it out of this series on purpose to keep the scope small.
>=20
> No in-tree user yet: the MAC driver that calls this interface will
> follow as a separate patch in about a month. Until then PCS_XPCS is
> not selected by anything and not enabled in any defconfig. This is
> why this is an RFC.
>=20
> Questions for reviewers
> -----------------------
>  1. Is UCLASS_MISC with the ops in include/pcs.h acceptable as a
>     starting point?
>  2. Are struct pcs_config and struct pcs_state enough for other PCS
>     drivers, or is something missing?
>  3. Auto-negotiation completion is polled from get_state() and the
>     interrupt is not used. Is that fine for U-Boot?
>=20
> Testing
> -------
> Not tested on hardware yet.
> Build tested with CONFIG_PCS_XPCS=3Dy on qemu_arm64.
> checkpatch.pl --strict reports no errors.
>=20
> Not done
> --------
>  - Interface modes other than the three above. More modes are planned
>    once this is approved.
>  - Clause 73 Next Pages: a link partner that uses them is rejected
>  - Register access over MDIO and the "direct" mapping
>  - Clocks and the interrupt from the binding
>  - PMA/SerDes initialisation: not done by this driver, it must be set
>    up before pcs_set_config() is called
>  - SPDX tags and a MAINTAINERS entry (checkpatch warnings)
>  - Sandbox emulation and a dm test
>  - A dedicated UCLASS_PCS
>=20
> Akash Nair (2):
>   net: pcs: Add generic PCS interface
>   net: pcs: Add Synopsys DesignWare XPCS driver
>=20
>  drivers/net/Kconfig        |   1 +
>  drivers/net/Makefile       |   1 +
>  drivers/net/pcs/Kconfig    |  12 +
>  drivers/net/pcs/Makefile   |   1 +
>  drivers/net/pcs/pcs-xpcs.c | 881 +++++++++++++++++++++++++++++++++++++
>  include/pcs.h              | 140 ++++++
>  6 files changed, 1036 insertions(+)
>  create mode 100644 drivers/net/pcs/Kconfig
>  create mode 100644 drivers/net/pcs/Makefile
>  create mode 100644 drivers/net/pcs/pcs-xpcs.c
>  create mode 100644 include/pcs.h

First thing is that none of the new files have SPDX headers. The second
thing would be how is this tested then sine you don't mention running it
in an emulator of sorts. The third thing would be you should include
some documentation, especially since you plan to move this to its own
UCLASS, which you should probably just do to start with. You should also
make sure that this compiles on sandbox, today. Thanks.

--=20
Tom

--qQhtTzRKtaHXyKzB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauImPwAKCRAr4qD1Cr/k
CpDGAQCoKd/JncMl4JU39HBOgcBKCXOxHrkaZdYgz8f5GbfPJQD/ZPkUwzty0q9Z
5gHTU6w0UluKKGWVWRq+lbMOOkcNSQs=
=+hi1
-----END PGP SIGNATURE-----

--qQhtTzRKtaHXyKzB--

Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97590CA5FE4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 20:59:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A6F840E0B;
	Fri,  2 Oct 2026 20:59:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e_bG23mfsgJz; Fri,  2 Oct 2026 20:59:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9E94940A74
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790974771;
	b=htq3ajFAs72xOHwY1bFghmLrh+aM0RVfknafG+h6x4+lRjUlQLUpuPLj0EdbUNxhAiXw
	 +OT1+1pYYIrGyVh9uuQ2x83FR2ct+tSG/8yk/pFqKKbl50/XcW6m2SJe4OJokJJD89a0l
	 6hN0FwesfZj5CTyM6s67upEeGgdL591SUKMG/Zk5M7HgB57gSWfmbI1Ck+ft9yZkbX3Rf
	 YUTptH2X95GMxAstMEq8wnjYW+ATCxKqbzu3bmB29ElsUDyOQ1j1j/P6cG8UzewPRvIc3
	 QIsWe6L8HJ4I7CzHb7wRfduZq7lThZi0Tr4geBlzo+8Rebhb4BbjPitVDLoAHemD1tQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790974771;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nF5GjfJpyc1tTPkLUSsPALUNiJORd3xt6KZefE1++EM=;
	b=Huw+LBAFjwvfEX38DtJWRptXla7m9eQbeg5bdtm5W9IfKCgLTKbyW6P85pz18vDAo4QV
	 BoS3mnLOq4IKAlkKMKO1RFiUockpbQIcj1PiBdxfpcIuzFsMzk0gd2Nr4tCBncS5d1P60
	 TGvw+lq1uUrADMBV5vCpi5K4twTEj8SzwobHftLivNOQLGg4mbJfBVarSerWDzhN62rWv
	 CBaUEgCmQQj1lZ8c7iTnazAHrPjisnN6vJrGyWaKcE6ex8gBY5fJVBthw6A9CiOu9wLVa
	 xAXcGBtfb6LFeUViEGDLHnBA7i5fPzsACmbebNreOceuJKlKDEwNK7U2xlgdKDjogDA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=jidSXEw5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790974771;
	bh=nF5GjfJpyc1tTPkLUSsPALUNiJORd3xt6KZefE1++EM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rjhYwAEmM+7Hl8h721dSMFFpcSGbbMUiJyzDOs0vKSfikVIPcBMOA2GWPoJ7e1wef
	 S423ZSZJPjRbVRKiyVdq+e6lO9Kgy3uuSa8eNaaVMjU0FaPHUzFTW5rDK0JHt4CjGp
	 4mHjk/szc4uH90dV5i0Z5bfVtSdyycYb/RIYFG0xbYYm2oFDU+HnY4ADxGoST9XI8y
	 mBkNrM2Tu66MQ1F8mwHYUAZaLncjdz/NiVVHZzpSGGjgDLb19j4H1HTAkLl02FNYdQ
	 AebraNVvkLEtSAdyf2sTpH4bcUlSuk7XC4ups9qbslmPlY2Evw/GJjJKMtZS5ca1OS
	 6yDUr+SBjWNnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E94940A74;
	Fri,  2 Oct 2026 20:59:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BE69A2E0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 20:59:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 988F640B5F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 20:59:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id isFza1qu0Bzg for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 20:59:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BBB9440A74
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790974770;
 b=F3YsFQPDbS/zoci9GAcK7Oc70LjovystfEjnpWO2wfROIh2XvdtHpCCb7QFCL9bMs7OV
 PKSt1JA/mG0nmPoMUrA16UYSEDX4vMq0wXQvlWReko+ess0lLdAOefN71bmfkyPgOx5Y8
 9oAxs1H/iOfqmtfE5mqNVqi2zP6BL/FYeHptV6P/gSP5OAokZsUAeZ249srPTBD9e5gTL
 V9GIfDPkjem2TuOQogsoQhzPCqZLmrEVwqQkUwLEZAZP01wpLbXJi+NSaVgwBTfte2VAR
 +nFikKHA8OaLfOiZKM8dcR+s9/gxfYqmj08L1fa9/I16sMzsouse/47HYSDkPiIjX/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790974770;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=nF5GjfJpyc1tTPkLUSsPALUNiJORd3xt6KZefE1++EM=;
 b=eGzXbqFVwlkWRtks99n/cd/33FRCLkL/K7ueUwp66+5SeM66Jzh54VX3UUR4Dz59zJXb
 RCx8vHV4FOWhV1TKtzW+Qp6Rb14sAvmTRVeqrtyTS6MUb4jwVVbe2ahyECxTAqe4yH3NH
 B/Q82lnXUWeSBMsf1/iApbu/cHd9sCSrqoj0dtrXLCf6wldUSWkzQ4J5nOWMoSBKBjIwu
 ryK3nlq9r2kVTtOvhReq9tkK65dVmSQR4y0jVysKsgDg0uTnTFg7A9sI+cNp1UuDTff/f
 CvABaSxaWF6bXUfS7I/o1r1OlspnfuNuZ8IxUM50DldspGCubxoYHxtRFVIADkRzQyw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jidSXEw5; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::f;
 helo=mail-oa2-x0f.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jidSXEw5
Received: from mail-oa2-x0f.google.com (mail-oa2-x0f.google.com
 [IPv6:2607:f8b0:4864:30::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BBB9440A74
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 20:59:29 +0000 (UTC)
Received: by mail-oa2-x0f.google.com with SMTP id
 586e51a60fabf-492d8c4add0so214973fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 13:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790974768; x=1791579568;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nF5GjfJpyc1tTPkLUSsPALUNiJORd3xt6KZefE1++EM=;
 b=jidSXEw5nX2YJAuE6unthanZdMw8nKwZbMFweZzh31UedvMJuK6xaXwR4um/oFfY6S
 kVlD72xV8pcyCc8MqfUz8EPN+yBGvDlFxgQ9X0120FIuC5ABOg4ePsvVa70xgeDduTOn
 BUROU/a5bw89iU17qtlK+OsBXdJHZDBoLth30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790974768; x=1791579568;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nF5GjfJpyc1tTPkLUSsPALUNiJORd3xt6KZefE1++EM=;
 b=pTIGfoaSJrjupyVd6NyK7/a2janf5s/P0ZxwPbsP+t/eNsrZkhX908RzjOdMkhLANY
 /JLwR6brxH1Ce5QHOQmuiYpM/TZAJMHKIs8fUrFJ+fjdRXON4kxuiA/GXSEg0Wa/6MxQ
 Hz5axK//DIKOke/c6YBWw1KOMbuL9GVaGf0QK1/urPc0Pkt716lQbMpR0aAYwFptdExl
 a682zE65Blpewl2Szkvzhei9Wfso0vSsOe01Dci3gYqi7dQiCLJBRmlW14Zmzmo+GlUy
 H7gaYSBbIvcSKJcTtDwnDXr+No1hf6/X9pHzgJHEgSpsDd7MzMw+haxVIRAq1VAFZxGC
 JXIA==
X-Gm-Message-State: AFuF++mqic8P7wlGp2ps3R6oKi5GkuOWyOOQg/XVe/sudpZu3jqN9QBa
 63eLQyhMf6JU4DrDA+jtQ6Yl9I6s6ORegJlALXvLHoHDjr1ONraVWEm8dTbHbkeYhScfDOtYji/
 gJay/X3EtG6Dg
X-Gm-Gg: AYBFou1ZbRAKzBa47FudxZAmZJ2M1tSJ4Bit9Pioe4ycakaVUQRqmsOO3GT5T5yt44u
 geZ6uOp9W41d15wsYdgTwK+ODTnnHYs1dyseCBYGdEvhy53djCEihkoudbIlNzB69Z3AUHH90g8
 e/9O6lxp0X3xoMBCzZT9+rCoU0BTgqlkAzSFB2OwPhARXT3y2KujEAVFbB5TUYo2+m5CboFmMd9
 YFH/+ZN7UyMItKW0BEnJysApWXOAsvssXl/yhjL1k29O3qoc1V2gyghbDOG6n6gIJSnLtnUrOWq
 T7ac6LPX5RyRqeTnemOWtEKzS1Q97Vidc/tZ0AzS8SKPgtX/YbVwrSFMy/TkxWSMSaH6C82OkUh
 iUCzloP2K9LfKmkM6nc7w/YDVVD1GrrK7u0hnScEI2oNIPXhyNYE/jdFzNB29HGNdqFKVNBNPAW
 FoB0x2oCgk/XS+toFPIQQ/3T6Oby39O/bP/HXzfy5SvnoPrwjLBUJikQheYHtBff6LEXNQ43IWz
 afqtVG/gKuO0Xi0Kev71gdgJbWDbdvGN/Fu9v0VyEc6FGAUSJa2wbvIWs9XltWU9PvCDPKIKpYH
 0XTC+cB+kx9fedyeYJT2weRjv3X6r+w=
X-Received: by 2002:a05:6870:142d:b0:48f:e116:db7a with SMTP id
 586e51a60fabf-49e15f8e21emr3584108fac.56.1790974768061; 
 Fri, 02 Oct 2026 13:59:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-49e16f4b59fsm3035258fac.16.2026.10.02.13.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:59:27 -0700 (PDT)
Date: Fri, 2 Oct 2026 14:59:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615gmail!com@bill-the-cat>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 0/6] arm: npcm8xx: fixes and updates for Arbel NPCM845
 EVB
Message-ID: <20261002205925.GA2931226@bill-the-cat>
References: <20260922104124.4133659-1-JJLIU0nuvoton!com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rr/sNlI8OHRuvoy5"
Content-Disposition: inline
In-Reply-To: <20260922104124.4133659-1-JJLIU0nuvoton!com>
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


--rr/sNlI8OHRuvoy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 10:41:18AM +0000, Jim Liu wrote:

> This series collects a set of fixes and configuration updates for the
> Nuvoton NPCM845 (Arbel) SoC and its evaluation board.
>=20
>  - Report the correct DRAM size when a 4GB module is used with ECC
>    enabled, where part of the memory is consumed by ECC data.
>=20
>  - Drop the system counter setup from U-Boot. On NPCM845 those
>    registers may be marked secure and reject the access; BL31 is
>    already responsible for programming them.
>=20
>  - Select GFX_PLL as the pixel clock source on the EVB, and enable the
>    matching command along with a few other commands and drivers in
>    arbel_evb_defconfig (watchdog, GFX, GigaDevice SPI NOR and SHA512
>    hardware acceleration).
>=20
>  - Relax the default network timeouts so that large images can still be
>    fetched over a slow link, and add a 'stopwdt' helper to the default
>    environment.
>=20
>  - Adjust the Ethernet PHY reset delay on the EVB.
>=20
> The series is based on u-boot/master and was build-tested with
> arbel_evb_defconfig and boot-tested on an NPCM845 EVB.

This isn't showing up in lore, can you please re-send to the current
u-boot mailing list address? Thanks.

--=20
Tom

--rr/sNlI8OHRuvoy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasAbLQAKCRAr4qD1Cr/k
CuzUAP0X+xc5d9BdF+D/WUjGTERvJaqcB/VG/NXPhCLxb49tCwD/Uvb/gBfehspx
8aut3gTXmPt63Ik2St0vqBh+K+lTeAM=
=FW4O
-----END PGP SIGNATURE-----

--rr/sNlI8OHRuvoy5--

Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D139DCA5FA7
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:05:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BCEC60632;
	Mon, 28 Sep 2026 22:05:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X4AmPdTjXnqc; Mon, 28 Sep 2026 22:05:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 84605605F0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790633145;
	b=XImDKwcCYk2v34diUNLhjilr4MM3/vaGV7W042Y8HfDgTEaTJ2qa86mzg9FHOc9M7J4w
	 rxF0AwKUEDx9v36rbA8ee0RXQ/9JR6T8UcZsAs3ZbefEcEkaXDYlC7zuFYiCfVbIADfOV
	 THb0ajaes6cCSMQnS/fQaAQRq57mcysOhPZsPSfnrx11L88fxCX8uD0W+Cruyxpt5kAeR
	 kiEHglz8G9akxtPiamFEaAbOpqsYOOAdP3ALhfSU2D71VSKeJeLanLezcjkI13UBgFKy1
	 SaJTPAKY5tfbSGwCvNK6qGJtenLTIZQ7VTpLs/CPg11IsMsuxnu7aQsBfwgWxmfFFUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790633145;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2m8cLy4mhgV0VF9gIciUrJ+IZnWQox8Y7LYjGPQfM3M=;
	b=L7W8WDNo2+1vcgv7QdC21hAvqFeOZmyb32evwPue2NUoVJJJe2idebNyVFeDblE+F1z8
	 mwPFxDjBSIqZDekE6/Z2WhinaloPxJN52DsSLu9BIox9kXtEUdFE7pkucF4aZ3q9HzCHC
	 EJjKgEvUf4/l0l2XPqzCieHLDPUCeOV4s7xIQg3M5goBlS9h3oiqDi6bjGxr9NUSdVCgz
	 3rVAB/2+Bdacmt9r2L8rD5mMbM/B7hiB+rssR+jVJ3WpzGMJfAID9sqB1uoyRjo1Bok5t
	 eEg7k9T2/wm5dsTji0mrD1EZasfelRtsCDcAV+CIJRXTz+bnFCQUr82k722i5/bX29w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790633145;
	bh=2m8cLy4mhgV0VF9gIciUrJ+IZnWQox8Y7LYjGPQfM3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XhVO5JzF61FBKVhvaQJo86E+FQvxGJ1X025C2kLH+bp+/TrtvekG2N36aa1QYhuC0
	 KKdRVpFNQZZjBzK/Tfyy6BF8oeRe/Q1u37+XQNFk3NI17y3Vz58SOpipjipceSMvq0
	 ykBVWP7UVAP2LVRFB1yhCGamp+fBX0FcowX3Vm0/heuCu1+aKG+0yOFwVXgIBFbsvB
	 nviuvO1P4qKtUDEJ07XhtFFOa3YrcrWY11hr5teXswuklZF3v2EVa/x8fX4H8Ro1Kd
	 vLaHyiU4WF5yb4mntsXHZGiyEoL4zXceGJMBsWzYJcHJFCELE1m6PYDe8JALhwoJ6q
	 DS934pp5n0Bfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84605605F0;
	Mon, 28 Sep 2026 22:05:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 704D372
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:05:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5EA1F40090
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:05:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yysqg3cLXwnJ for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:05:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 69ECC4008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::343"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790633142;
 b=P3i+f0AU6UQUtNA5y89pnkJpIik81M+t/MN91H/4Q83LkmXXRI9nDS3zXVkWdk1ZEFl9
 iybr4a/B7Pj7c/zpMXofKn5PE4dJjU0TxfvOlHRQSnLQrRll1LpRprt7SKHFvDlE2u0E5
 4uR9Ty7nrnd2Hdn4e3+HulDBz6TdeRoLAFxvrWM+gMIevBdl/YifcREV6+9a91RFldMQt
 YWKFaJmgLyrV0UtAZaZOFUvSo7Wc60mqicP46SC10f5Ltoq8BZApmzDc4Zrt0S9WHRfFd
 A5GF0v/R8t8GmA5by5m5wFvCQ/pQraaumpBDxl0x3fc6Cn6EUlLF1ap2Apv6Sx3HxPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790633142;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=2m8cLy4mhgV0VF9gIciUrJ+IZnWQox8Y7LYjGPQfM3M=;
 b=EthfczCygBp8LOn+hw3WRZXAQ0rorlCeY5UcGgg2bg0G+Gmgb3imRjUqHJP85naRclB+
 c1eqBbHp0xi++G+Q8UyfIbMU1+gl1YbboEohoq+0vtQ3koMLyYNBHgbLAKZ9SRPi+2fmW
 g9jjn9saUTCqtUwZSHTYtcLzYQCgRNZ0Kow4au4T66181fBL1L1GL17NTi89oNpr/JTXo
 yFpGHmgez+Z1M7ug7SKDfYijio9aQz3pxEpSHXi70YG670QWt0rWQMv/sOZ6FB38bQCtC
 52PbWh/Y8YyGbQoXoFZN7MMPAeedqNtkX0fKWKycbMW5fqoxTefENkm7VDPjTUbVxRg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gPr0elMd; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::343"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gPr0elMd
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 69ECC4008A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:05:41 +0000 (UTC)
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-8121458be2dso309685a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790633141; x=1791237941;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2m8cLy4mhgV0VF9gIciUrJ+IZnWQox8Y7LYjGPQfM3M=;
 b=gPr0elMdci+c3mfpOKy1B8RPM3H94jgEX015a7AHTloozNWyrPcitvBed8TX0QzEwR
 mZNRR5WMDdF3Yr2iOqMe6id/oSB9zvE0CzjljreRBjEKg6yaQ+r9zXJNYk7f3AFwDq2L
 bi/pV3NSs8ftptEnAIg1/cemF4WyO1/7Tejqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790633141; x=1791237941;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2m8cLy4mhgV0VF9gIciUrJ+IZnWQox8Y7LYjGPQfM3M=;
 b=NHfxqCMaulbL3ZMa2W8aTwbcnwznir3AEE/pG5E9734db8HPVqROZYHEQSeJp0f4Nr
 8cafKIjrWUKFCaKbK0xR7bv6D1zo+pubdZilazgXtW5S2AbHImRGjeUVRuK/J4n0Tr3N
 plZn7MSTQPulVNzkhOfbHV5juUUv//WFg0X77hj8pxXVbY3i4QR6mAHUZ7Vg3rXZ0i7l
 6tpH9Ed/vGpdxk1g99AN13dnQcDMIvQopBSQMFezhp0OxlSb3sowVp9XMiABAKZ7G27V
 O3mob+1lJJZ4/LmnVbxG9IyNULyz2wMGw+hOqmQc0N6Y/hBSmYDq0eBLm3DCaZz5j/Bp
 TIlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw9XBCBRNMMbJKn+4SNxYCSmcn5FJT5G10jd+gXAKTDaIY8/TWujvZsxrhEBw5CCMMlZ1lb3+w=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nU9BPlHVUSzvTpXWOmr3zC3O89g59gAjFZ3cAXJT0tu3Ungzw9
 cLekqYQGabEYpX35N95J9jojX1bfcxET7/L5Gn3oUk4GXyxqjmgs2b1V3DJYna8314Q8+l9uKf6
 kWtaY01F3iO9aseM=
X-Gm-Gg: AYBFou30Or/i349jwSU0sBSYEbkviFDMgXcC9yfPXWBTx5TRoMpK7o07dTYGLZjHHr0
 ANoILeOqLydZH8DpBjBLZbkX0BZ12oOD1geQXFCC1ZX5/mcOM4/d3YaLhfJ0IeIe4vqNNNo3BC8
 80nihqVp2kiyoYT6yxQTbrNdiolhKDXnxXocOcfFjhnOj+nAuqp8tfuCiBA4oTn0kP/S58nZ7rZ
 bdjBWMwEn7vSSWLOlMHbpkef+yq5Iu5DchjVZly1c3pR8R9CzzFPFXQ+P6ZpnpHRxUmwLMf0EIo
 u07zPOF5qHp5KsgI/DmMcqmbYih+doFPR1AKPxB74JrLpsCvr7S0qoFKPXaDc3zCgMm1a81Zik8
 cxeQQiwka2rvgKYA/0kkgXRAbhh4HDtsoGr5bsdfwO1BC7DeUu+rJZ81Y8kw+Gn2KvSmj7+tFrx
 Fb3S0vrPUAPEplWTXLusal5/ZNAoMw/loiW+jdYkVXTJSbxvo5R5OsLTgfTsm6HwOB/iDGDxWhA
 Bo9GgJKWGit4feFibZkhx8nBh1JdCvHdtnqJ6BSOwuPKRNx0Xmn7utPHSzzP4fARvLdLsTVg/gn
 pAMBwxPuC2TLSg5Tx9c=
X-Received: by 2002:a05:6830:2e11:b0:81d:338f:fb44 with SMTP id
 46e09a7af769-81e76bb069bmr489254a34.25.1790633140917; 
 Mon, 28 Sep 2026 15:05:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81d57ef33b1sm2833412a34.5.2026.09.28.15.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 15:05:40 -0700 (PDT)
Date: Mon, 28 Sep 2026 16:05:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] net: e1000: use all RX descriptors
Message-ID: <20260928220538.GW858934@bill-the-cat>
References: <20260928213011.290839-1-sochnev.v.74@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="186GciHrSFHOkplF"
Content-Disposition: inline
In-Reply-To: <20260928213011.290839-1-sochnev.v.74@gmail.com>
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


--186GciHrSFHOkplF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 12:30:11AM +0300, Vitaliy Sochnev wrote:
> The driver hands one RX descriptor at a time to the hardware and points
> every descriptor at the same buffer, so the ring holds a single frame.
> The legacy stack mostly copes, but lwIP opens a TCP window and the peer
> sends segments back to back. On QEMU with e1000, lwIP wget of 1 MB
> takes about 300 s; virtio-net transfers 20 MiB in under a second.
>=20
> Give each descriptor its own buffer and keep the ring filled. The ring
> grows to 16 descriptors. Descriptors are handed back one cache line at
> a time, with one line held back, so that flushing a descriptor never
> overwrites a neighbour the hardware has written back meanwhile on
> platforms without coherent DMA.
>=20
> With this change, 1 MB takes under 5 s and 20 MiB take 5.5 s.
>=20
> A similar change was proposed in 2023 but not merged.
>=20
> Link: https://lore.kernel.org/u-boot/20230303204844.112105-1-christian.gm=
einer@gmail.com/

Note that 4/4 of the series introduced a warning and so the series
wasn't merged.

A quick check and this seems like a reasonable size growth for
performance gain to me, I was a little worried, so I checked real quick
on ls1043ardb_tfa:
            ls1043ardb_tfa : all +124 text +124
               u-boot: add: 1/-1, grow: 3/0 bytes: 288/-164 (124)
                 function                                   old     new   d=
elta
                 e1000_arm_rx                                 -     152    =
+152
                 e1000_free_pkt                              28     104    =
 +76
                 e1000_eth_start                           7172    7212    =
 +40
                 e1000_eth_recv                             132     152    =
 +20
                 fill_rx                                    164       -    =
-164

--=20
Tom

--186GciHrSFHOkplF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarrkrgAKCRAr4qD1Cr/k
CmvWAP9d1P759aiwBK3nfbKNP0dWOTTFZP6aFCHQQv9/hd75BgEAuy0VHcYo8COz
+uqYVaQaJPdGmOlf/YWUGZeXJP6a9ww=
=UorS
-----END PGP SIGNATURE-----

--186GciHrSFHOkplF--

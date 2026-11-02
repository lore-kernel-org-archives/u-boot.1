Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB39A606A923
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IS9mVmo/;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=oCSjcQJD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA079605A7;
	Mon,  2 Nov 2026 17:15:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AfdrbWGfvayF; Mon,  2 Nov 2026 17:15:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E7A6060814
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793639742;
	b=duWzBrJ8wwxVuDySDdruN/KN574zQ+42pxwg/oCJSj/8enS4gzeKceIGcpqY6fYUUulR
	 V/BeB2MEm9i1p6O/8XmgQBy00aZnkF8B9cnPZFkHM0l0SNE72AK4959r1tHidZ8PINH8S
	 1uwUpdhYZx5tjrqI+pq1KDEoZHX1TyY3t+xWICm3iprIRQZbuJt12UY86S17/I73kO6yq
	 V+Jcx5Rd4TONjKfy5g62p6vq7nvRuZNtUVQiK6p1DqgGJqdNQd9gvUc9f2jebZ99OK4wJ
	 nVVoc08GCyLH5VKmXxMrWAk9AsO8l7aUFekiozLn7WwZ3okF7nDAMSpRsaGN6/qspcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793639742;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Go0r42qfycQYNXjpiymR5k9E2gLeP2W9ia2KiTW2SdU=;
	b=SS7vOJQxWUdvp/ufNjqWS7yhiCunT0oAtva9Hh6J3CNPcQ52cSjaYQA7bftx3ZQbBYdo
	 /Q84XcWqwhPcBZOIuf8jaqb4cJ++Imtl7Qn75Fnc9tWUWd/p1d4+zIVjXHBJshBRtIRDu
	 W7mCXKri1TDzN+qwS39GCm4umilQi3og+KwJuB0TUc7gWH09tEWmIwIdFTsp6mjGmEP9V
	 SaU8DIpE6lwUZxRxnnZ0VsHKbnjFq83irpUSFibTDrK4x6WoFSlsOwrhyseWRbXXzf8f7
	 Ar/2MyJJbuEgtkDDm90NYaRcxHCVfKdqFumdrnfgjRozJxqQzWMoKnDcvU9YqeocZEQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793639742;
	bh=Go0r42qfycQYNXjpiymR5k9E2gLeP2W9ia2KiTW2SdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IS9mVmo/Z69ARhCQIqhm4j4VdCJQv5z6NvMDSWffjUAex5KQFv7xKaDpm7a2BCrNR
	 iDJrsGrtk+c1+5ZLidjd1i5NvnksIhBsLSZ83h89lPBs9b4RJ7yHZlYXH26P13b+EF
	 6FtImTskUgLvSmryaS1cKSOJqiOpDMDlHFfL/IDBOdQYWNnx+ppiuol2r2veJu4Ed7
	 HUOprD00PSpmYJvjhtPYNwY3VsZ+misJQ/atHkngnIvpbiLSMA5BcUCabQ3OqDzoz4
	 vuwtPFf9jBNm77QegKdwqGrRuf/+Hzgse8jyDLFH0oRKDGCyG9HVN2zQ4Prc4BriMn
	 13rJItHdygKYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7A6060814;
	Mon,  2 Nov 2026 17:15:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E75C54BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 17:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D906B40203
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 17:15:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r9DdZZPWH6fH for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 17:15:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 07F9B4007E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793639739;
 b=ppBHRIPKEABUfHaG2LrQFjUgshFAEE5T/rMJz8pUQMrE5nHEdMvxCuAnV3HqCi11YLG6
 v7MBxn/QEQXmC03d1I2MOtO1cwpZE0eFSD723Ecy/4L5/Hzl1b9Gos1UIZkekxi1+tElh
 LXnspoiPdCyqpVzZ+EWxTBuFrlyIFZtZnkjmskOiV08lnmd7dakjRzV3xXUDJdEcexZ/Y
 nGmFQZUGaYxs7v3mOB4mSGkZRAhUEr58Y76ry0Tq1TltM4Jl/q67miyMO9xGFkdWQ8EUK
 ZtevDZbi5unmh0YnqoVwENsOMZmeh+IdNorqxtIkzg/SZhgs+1+qCFm4XyxUOM7bpRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793639739;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Go0r42qfycQYNXjpiymR5k9E2gLeP2W9ia2KiTW2SdU=;
 b=R/U/tF8/pWsCRxNTOhc3QWLgiSgNupAoayyUPBH5GSKGLxmECJ7RqKajsPkhVnd4bUes
 ub2/rv6T2l6gzaBowqKu3oi23BJvqtnnZ2UyfP//2q3UI93CUQZDfTrneI5asCxrkEGGw
 sRjyuhcsFXiNaDf/iCu9Yr6mshl8ExZ4QPfmWWAqZJAn3XdxWSJyHmpmxdxfxhUeaeTA5
 LW//ARbr0MT1t6udPyhENOIQhpdZYItbjnLqG3+OriR375AAZcLrQIlFb0huLNoFOO659
 Tj9VM2VYUJB+8AieaP9HGUtNtMrjNXqHFCrI9O04qvZF5NCEpZPuCDkiJ7KHYEBr0Bw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=oCSjcQJD; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=oCSjcQJD
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 07F9B4007E
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 17:15:38 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-85ac281604dso1939784a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 09:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793639737; x=1794244537;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Go0r42qfycQYNXjpiymR5k9E2gLeP2W9ia2KiTW2SdU=;
 b=oCSjcQJDH+S2C1kZIyzePIqMWTicA4pBXkVeMdTnCu2xgSD0XbSodwaS81tLZdD5cW
 kxiRBkRlONB7aF3AP+jjqv0O4cFZ4LZdZ8T5vcvu8qCA6Al6qswhBR7F7GJFAvT9RrM6
 3yCaNc0WAOy1jJJt5YQ7kQnYpl593n9+fywK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793639737; x=1794244537;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Go0r42qfycQYNXjpiymR5k9E2gLeP2W9ia2KiTW2SdU=;
 b=c2x+vu97ObwAVURafIhWX1VfAUieb0u7LnI6zaJcIcBlny0qeBEkfjrsmdo7DDoBcx
 O5ko0AEKcoqIqO7ef5V9BwRXwtezD2DTZW4hTVGItLK/qKJKTAEy0bDzsW0NJb5z03V+
 csXxaj30km5vmqQK+3LFdCdD60KzOc4qVKMgvCSToUyGFu/m7o17pEp8KKv+ZfUhUgVB
 Rl4D3p/VvN6Srl/0wBuSxpjuDHMYyWPoMPUuRSSktJpg1ljnZuY4IsJ5n7JKb9zIgBBu
 2TmRQ0Gz63sc2ZnyzLY1Eejycn6c0/YRJ40iuj/Ja6zAXyK/gGwypEyc5TOgebnS0Hkw
 DdzA==
X-Forwarded-Encrypted: i=1;
 AKwUvByFb6bSND+yDbkigiGkGEkMAjS29jxHzfqLfXs1TsgoQmyVoUJSJiLmFHM7XFmM7xx9DAax4KM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYICn7HFr1hsz8svFMnCglTAAAQNvbk5RwIGCXxiLk1HL8c2w7UF
 aldp4xMY1SzSbubDp5XlWncPUP5Mege0DHFEd9er2sbt2J7KKtdv5VweY69M9LgD+YE=
X-Gm-Gg: AYBFou1JZQ2u/gMi+yJ8s6vdbK+uOM3VzOQnhVJzsgMfQ1y578hyhF1xUABfJno6jUR
 GdBr5BfCEaa5/+ytwiVsD/I4aOpYmSa+c4ndxjlVwx+3KRpnN80dQ7GElzo1SsAMD9KUkeZY6wT
 9hvdbsjW4YC05VDeabCJW5idw95SyYOS52bFz9Z0tmMUC+BstC9k1/tTQZMFKc7h7qxsGQvK7xv
 okwf8KuBzh20iUMrj+eXTxlAAv25HpgQ7dhjlSfsxWOr0Mv9oK2nkVj2CZ5cCHePHNL6XutUFG/
 dEwZFq6JGXoSCw7d7Z3Mb5QlZM3bAtE9quJWi4qBNDHZST3Id8fA+Ut/yKYLLPGIbcK1kDN6deU
 eDs9P7qKJnFeI/oMKQQNaxyOVQX+qdR5hUrSWWol8yXYz2RTEpbfxm0wW3vAOycc8NVCo6XDwTe
 TW4Aon89S0T6CbztziJ/FvnDdfuosH+vsougwPxyStRI3K1MI2lV1TlkYOKv9MBhjlgmbdjRqDY
 yDx6den46pZHYQTwWeGij25BgMmp6GZVwYNwFYa4MVQebyv3V8rMIacCUpgaruRwKWRSdgw1nAV
 NFPPayPuVkTvInqSXQmGipWYZ/59RG2ZgvppJL0yhtRTvOt4gSvMeh6T9MR1zZ3wdPJB2WiT9cf
 ygtVVaGmXWSrdXUHyQrsxm+dBwpjJcSo9iMFdW2xz6noHowEdwWQg9lslISrh/Sf08BM3avb5UG
 gTe8LJBoZSK5vxwAVE9S4cPsa948d9PA==
X-Received: by 2002:a05:6808:6404:b0:4f2:4d2f:7ba with SMTP id
 5614622812f47-5640d953debmr7691202b6e.8.1793639737596; 
 Mon, 02 Nov 2026 09:15:37 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5640fdce900sm8823547b6e.8.2026.11.02.09.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 09:15:37 -0800 (PST)
Date: Mon, 2 Nov 2026 11:15:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>,
 Richard Genoud <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Julien Panis <jpanis@baylibre.com>
Subject: Re: [PATCH v3 2/6] dm: core: Add SPL_DM_EVENT
Message-ID: <20261102171534.GD3309461@bill-the-cat>
References: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-0-2a67384ed0ef@baylibre.com>
 <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-2-2a67384ed0ef@baylibre.com>
 <CAFLszTi54DouCiL-JPo_1NztwBbRNve-dyQjo-s1Od-kQCG71Q@mail.gmail.com>
 <DMKM8ZUYIQG2.J82LOEGKW71T@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u8S4QrzpegelTY7V"
Content-Disposition: inline
In-Reply-To: <DMKM8ZUYIQG2.J82LOEGKW71T@baylibre.com>
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


--u8S4QrzpegelTY7V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026 at 10:26:44AM +0100, Markus Schneider-Pargmann wrote:
> Hi Simon,
>=20
> On Sat Oct 31, 2026 at 7:44 PM CET, Simon Glass wrote:
> > Hi Markus,
> >
> > On 2026-10-30T12:27:40+11:00, Markus Schneider-Pargmann
> > <msp@baylibre.com> wrote:
> >> dm: core: Add SPL_DM_EVENT
> >>
> >> Add an option to allow DM_EVENT in SPL.
> >
> > Please can you say why this is needed, i.e. that the K3 SoCs want a
> > spy on EVT_DM_POST_INIT_F in SPL, so they can unlock CTRL_MMR after
> > TIFS is ready but before any device is probed. It is also worth a
> > sentence that CONFIG_IS_ENABLED(DM_EVENT) is currently always false in
> > SPL, so with this option dm_init_and_scan() and device_notify() start
> > sending events there too.
> >
> >> diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
> >> @@ -117,6 +117,16 @@ config DM_EVENT
> >> +config SPL_DM_EVENT
> >> +	bool
> >> +	depends on SPL_DM
> >> +	select SPL_EVENT
> >
> > SPL_EVENT is inside 'if EVENT' in common/Kconfig, so it depends on
> > EVENT. That is fine on K3, since ARCH_K3 selects both, but another
> > board selecting SPL_DM_EVENT without EVENT would get an
> > unmet-dependency warning. DM_EVENT selects EVENT, so I suggest adding
> > 'select EVENT' here too.
>=20
> Thanks for your review, good points, I will fix both.

I didn't chime in, in time I guess. Being able to have SPL_X and not X
enabled is generally speaking allowed and a feature. So it's probable
that some symbol needs to be moved and/or some Makefiles updated, but
SPL_EVENT / SPL_DM_EVENT select'ing EVENT is wrong.

--=20
Tom

--u8S4QrzpegelTY7V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaujFNgAKCRAr4qD1Cr/k
CkUDAQDBbvpxiRikv9al4fJmMY+Ga+diHd7rmmrBC6msQX3lugD8D7jWlOp9RSfZ
1Nanz+4emXsX3nDhBu3n+EwDfHcj9AA=
=26bx
-----END PGP SIGNATURE-----

--u8S4QrzpegelTY7V--

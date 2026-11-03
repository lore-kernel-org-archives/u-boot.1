Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3C1606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rgoyezf3;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=MSiBQPs7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8082C606DA;
	Tue,  3 Nov 2026 15:26:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CmM4Fe6i74lY; Tue,  3 Nov 2026 15:26:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A985B60686
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793719566;
	b=MsPAnegD25NrdsvAoXJOatlUv+g/jo5kB9nCjdEtLfL/fXVTbN5U05qesTREF/igxfnc
	 MRtxX7tGIsmzsfbpCRu7WUkx+GEgfNFqBxJpcPYwaUKsXBAyN4gLIgZpnIrAnpBOLB2pU
	 ZWZo6gyPQOYY/lKyhh+bKTzoGRwCQ8GBwOUQm9lL3l03kG03uWNiVBDi7gw+zFqPeOW0R
	 5hDrAeAG2kXsA4oKVnhy4u2jpZkI4c2iCiAVEVyq0TPKT35fm6BaeLIDpAfMi2TnEGpyv
	 qkIXi/q+QmSKb/j888qY+rZ72Jr7RxXVI8SS2XAd4LnO8yMtpATijiuLGwDQNmCeX1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793719566;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CFCbIcREsBDkETf3Qmb8rUoUPXSrxHmiLumZa4/ka9c=;
	b=EtBYFYUXnSj3qoCTDVHC+yZ2//wgwLhGUpnuN/gJbxuy2ZUoggj8bAJSbu6yuvld0BXn
	 Sn8vt4EAF5Xa5sgOolqeCUKlJ3psRliNZ0OvJu1XKDlx4J9p6SfSl/qcbUgYHBDvhfkcb
	 PudB7zKRlK17ZItwlX17ggxM0NkgLx/gcBihwFPmzFrThPcVCCzL5yvp0x4RyZNMIzauW
	 IqVZ+Z9n11O1Mru/jHnsrzou6hjK5Miu5ya7jbQtnm9CEERstWfOcF1AMWBWLQQMap74Z
	 xCuFA7VXfMAlWr1WMPYCX3GxuZomSNE1on5vuoaVWfzWv0a1nr0heydjRuNukVb26sg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793719566;
	bh=CFCbIcREsBDkETf3Qmb8rUoUPXSrxHmiLumZa4/ka9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rgoyezf3Ij9OkbDrf3Ezjes8GMqvyRVgNXa1fGZG/Vq63/37+vHyImSTvEQzemvuD
	 +szkix6pNhZwvXSZuw+SKeIH6lswlNX06RN3Meq5b5lDqbohRshkSHOQkD2vVfqhIl
	 eDHM92dG6vuhN2MX8YyVUhH2z4vXSrgBY9i3Xjw0O7iRUhKxnd+oQE/V8Lnw6zEXny
	 HMJWR62afEvPyxfdB+CMKTiXP9YzkMY2WdwU8QDs+v3n3kd79Ky0CKSle+DLtxYFSj
	 jexS+2U5cCwvgNB9OvLBpCOLvlUfZUApe7/bWiAJlx+o4PmwWudK5GYOowklvoV6iB
	 ZadhNq9adOTMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A985B60686;
	Tue,  3 Nov 2026 15:26:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 302CB356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:26:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2CFF080C3D
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:26:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vtdPzrvrMz48 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 15:26:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5874E80BB8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793719563;
 b=lArvmJY9gNyuufKD2ZH1At0Ny476fLOgLSLv3nFspmHIaY6dOaViy6Oj7VxFcsE1U8Dd
 9IWyyWURjlhUIWMDNdCxU0HtPhMgHA0FXPPYe+rTCzhrAXmteTRRCHscuaA6S2STRUo+v
 4TDZ12prHX6TnsnK5hnnWx8KlgCE7njy3SDV3k0v3vcgAzDYGu/zgvyKGy0hnzyLCdpuE
 f1yWIh2EvIiiYNo7kwer1QwcDNhlDcpYMlgOE7/0BjPpdQ+9YK33899HLIM1GyMsSfwRb
 cHxiDVW/4srNjucZFVPcxKoCMgfnIdjTfhfe2jZ9k5HeLrrpPVbK+/tOSmo+8z3jPMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793719563;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=CFCbIcREsBDkETf3Qmb8rUoUPXSrxHmiLumZa4/ka9c=;
 b=Uqq1VBaifF3ZHM9+ArzkVPyoh0IQ5MNnw8/6fYWKyfgatPqB+lfxmJgna6L/0rw+b1AM
 lFXTkdPEXHVigRA4i8hHWs7rjy0qdC0DwP3FpS6YiJ87hozDTvdIf4QTi5ZeZb8yxM5/p
 ttZkYqu/z5oLHkphJCS4GN2Wz8VmZEsB9RmgjAVaaDZ/rlrUE4EiRKWMX0WenNsnL5mzM
 v9WKby7hN4Niz18KSI548zYUy8SC/AYjpNbmvMQO9oczkM8kVh/oJMIF7BYY4klyI1qvb
 cUE1XLTYHilR07RQ/dk6nke8anz/EAS+mdkEHRCr8R/H0WyiifpYbjFt/nVd2uYjAZA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=MSiBQPs7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=MSiBQPs7
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5874E80BB8
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:26:02 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6df0b02fe91so534829eaf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793719562; x=1794324362;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CFCbIcREsBDkETf3Qmb8rUoUPXSrxHmiLumZa4/ka9c=;
 b=MSiBQPs7UFf63wyMmvIPjgXlyursHOCNmSCkTCjldzegIPSJrWBTTU9QM7auOy8JYR
 ssGgdh5Wh/1jPYe9h0NGnx6H2U2z1z1TSF3qoteyt3reW8I5bTwcAKqmr/UL+Spdicae
 9pmn+AHSPjeie6V2ou311Gw/sdXiNJe5jxMiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793719562; x=1794324362;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CFCbIcREsBDkETf3Qmb8rUoUPXSrxHmiLumZa4/ka9c=;
 b=AsTicJ2xcGa5fxGoNdKjzEfXQr4amKWvv03er/aLOgKEW6mM7TCskPbwJZAkbo028C
 GHNc05vcQx0cCgrow7LLISkhMcWhqiCY8iwHENjStyE6w7U+SlM/hx/Q7rzZemxLigWW
 C/mgxgTHGj+2DsKwiWDLd+VOMmGakeRjGmRo0WGd39NxK6h2Fzh2ngaMB3OJ8jtOCqWx
 DIdtG03lZv5IWXZtwxyhy72lO3jbn7/07p8SiJyqRcU337PcZ+Wa5+z1wwxFv0keboXe
 WAXXm4y7TQoIAI6ejITRUXLf0PmP8BOpAMGQd54wK8/peDGfr8NQ5tof5SmFP+jjmh+t
 ux3g==
X-Gm-Message-State: APuU4Z+U4Kcd5AhgA1xh7F+8PfNHR2pwlhmJZJKgWfs8Zqc1tNvrDg/v
 PlSa6quZEreKzqaD3B8UFdCiFz4xS8GE91KEuEHOk1kDh/k4f8zkUX0y4mHiNBnGVOeBBwaQwfk
 7UlkVSv9KaI1V
X-Gm-Gg: AYBFou38bl83j5DXOQD8oeCfw1Oib5y/GQ2q7IhTsIWrLhBkpyrYs18nLhO7ALEFS4s
 TpMIhFoKiIeprl42TlQFP9bM7AeQ36oWBatgSOiwG8iIV2kpioYZWx9OcEjj01rHdb1Fm5Zdri6
 9YOwjt2iIAaKbD5bceuKLq+F9Z5gtgIZlQ3/G/RNZgqMLLrKJcthe+w8+ZZBZPkjHCS84e7xDkv
 zr6l3GvKRBRvKHchEgeM6zm8MG1uTZezJXwbtFZSQnA1+tghrLyq0lHqgd/gArxa8m23TN5Djch
 p9ECQNMpvBRsoCdBGcgkfAnnhQZtd1Ye8fPmMj+p/asyC8KaPNHHlHjygX1yyDRVXe30h5EWQvs
 1aZe14Vf+/xa2RlSSPkP4xLopAxlpX56SMstxfIe8fKQshigkciWD+hq2ybizQ8Awm7dDjip+WZ
 ZW5s2tILolHxumuUCiUiknbUe0sTLRDBuEK7rDQ0cktAYmCwJ7TyMKkERldcBN5nBg3xnK8aEMB
 2sGUS0sIZB33R+1vF+6Tlgw84Bm4Nzm6YpYe+2Aa6o+mr0OztFXePGscWQJXjj6LyLQiL8x0BHF
 T7AAdoSsfLKfvW8Phj13qVYhIBvh3A3H79H5zRi5O/VKjWvfbdkdD0h5dpFA2J59xEi9OlvQipy
 Y+GXkSAo8e7LAN6TkdnUTFw/Ij/0e0SdGvImaeU+/piTBcmTNhIy8mBC1kdBp0RkLcj1GCO+RFj
 l+VVRkK6U5DqoBhLzabyufQ29Qk/lEBw==
X-Received: by 2002:a05:6820:1986:b0:6fa:3c7:8798 with SMTP id
 006d021491bc7-714ddfc94d1mr8382477eaf.56.1793719561734; 
 Tue, 03 Nov 2026 07:26:01 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a9219e594fsm9354937fac.11.2026.11.03.07.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:26:00 -0800 (PST)
Date: Tue, 3 Nov 2026 09:25:58 -0600
From: Tom Rini <trini@konsulko.com>
To: khaliforce <kforce@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marex@nabladev.com>
Subject: Re: [PATCH v2] usb: stop generic OHCI and EHCI at OS handoff
Message-ID: <20261103152558.GA752719@bill-the-cat>
References: <179128521948.5.12131679420803093421.uboot-usb@gmail.com>
 <3ae0a18e-0fa5-477d-bf5e-89072b9634ba@linaro.org>
 <20261006155833.68374-1-kforce@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6FEYLAe56RdbWXy9"
Content-Disposition: inline
In-Reply-To: <20261006155833.68374-1-kforce@gmail.com>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--6FEYLAe56RdbWXy9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2026 at 12:58:33AM +0900, khaliforce wrote:

> The generic OHCI and EHCI drivers provide remove callbacks, but do
> not set DM_FLAG_ACTIVE_DMA. Their controllers can remain active
> when U-Boot hands control to the operating system.
>=20
> An active controller may continue DMA after the operating system
> starts reusing U-Boot memory. In particular, OHCI may continue
> accessing its HCCA.
>=20
> Set DM_FLAG_ACTIVE_DMA on both drivers so their existing remove
> callbacks stop the controllers during OS preparation.
>=20
> Signed-off-by: khaliforce <kforce@gmail.com>

Signed-off-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--6FEYLAe56RdbWXy9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaun9BgAKCRAr4qD1Cr/k
Cnf6AP0ad2Kaj7ZjdWTaSGVto1mnGKcZGvvgVOqN0sCUaBhDxQEArPtSBNEFzPC4
+4d9i27cRgn7FuwcWYJvQtxrK6vCDQM=
=RnSW
-----END PGP SIGNATURE-----

--6FEYLAe56RdbWXy9--

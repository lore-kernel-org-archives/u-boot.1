Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBFA606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tLeMqqUu;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=QXRBzwLa
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DDC560A90;
	Wed, 21 Oct 2026 22:29:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GtIJpKMVgoMU; Wed, 21 Oct 2026 22:29:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5D71660B0E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792621781;
	b=Ef2tDUfRSIBIxjqJ0dgE153KHxYtq70x+PYw8oxYg0SyHon2NszpPJQxAmT2hW4GmSLq
	 71j/pcKW2xJuUeNgUiwkfBEXQ2IAdmtrSx2BainSy8NQgitD3JKnh85xKZ0eRnV1SiF9W
	 nLENL3038gYH7b5asOC22OEDfEY8p6x0cATW6pxu+ECU88MPnHenXwlp2/fjD3j9+aFe0
	 IzjleH4cMPqkr2LZutAeQipdugHpmLcHUj7ru3KD0z6TWVV7bibvyouqsoFgACFQ8DcZ2
	 BC+RCxO2hetm9aW2WHmWDlTlxNDrEEQGgNQo4yaGsAWcdK3UG/OSbvDFaMg2an/wi6w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792621781;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hCVQ35O6aH7scw4SgxkQzLVkgp32P1klKFJFaAT/SIg=;
	b=jla6DBJ0fydml2mX2BQJeliDiCjfKrt3V1xJeuchKfKTrKSmeAyI2BcYIV6dGlu4SEOb
	 2qoOrXpdJyYlj1yen7aGfM6BczuBTIKLL70rHkxCmVquffpURhHtt0hH3KI6qnARz/ETX
	 H3ELFNA17jg8xquQC/intXa7LjrmVcuGU/xnWKJj6KxKjg0k3Agtcq3G6Tt9M1I1pbFO4
	 2FwXNOxieQEZovFyAlrl3NFdehnRG59l/9FjiGiQUh6tvIOQ6Azmoyvr4DDJ9hzFK/X0V
	 mD4CCfmKLZG3VPyhWifOXfv4wHIMFAqjZRztLdO+CzVm01uNx1K1rVQrq8+0eJqQXEw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.tenstorrent.com;
	dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=QXRBzwLa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792621781;
	bh=hCVQ35O6aH7scw4SgxkQzLVkgp32P1klKFJFaAT/SIg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tLeMqqUu3seHhmygbHLr9WSGX0d7cEM3ssv0fHM1+0MkljieX+uFFk2PxKx3jyowF
	 3WFAyB5SHkV7AcJ/1RZMWrU+SjqIF/bp/cpyvnoEkBF+X67/UpV63lQhfuhK/e+lAu
	 tBH7F6/OxWn3s0jMQ438fsue9Kw2XTGX9Ktjn4cwM3oqqOePaf7Bnj9dzhOdiHT/OG
	 radeDt3hWobtGB94SHQXBJ1WNjCh5WUgZZnU7s3NWUP/wy/7+nEUAuvHU9AjLK6DAI
	 2M7tQn5UTCBoHmrSjuFTjTm2rxdnh5dW2t0DaAu5JJEDc8/zBnC4EymCoO34Cw+Ygu
	 KtvpJKN4p0c7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D71660B0E;
	Wed, 21 Oct 2026 22:29:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9FD0C3C1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:29:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 916CE60B0E
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:29:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K2-_OLEbi5ug for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 22:29:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5CB4260A90
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1135"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792621779;
 b=EZaYvZGMJQqAEPSZDOwzjLzxil5KN4xDRADQmo1tm8beHjan1P4ZDaVK/Ron6uZYPxPP
 MYAJGn+jcA9tX5/qNRsNxGE7kdqQu4rYSKn0Vz1OO/qVGTLyQ6/n8bVVZEuiZAIajae6b
 PkwcpHwGGsZl3HFklJHGpbHxEBOeMsMKrNGGwO66uQNqprS4PF1+QhUdzdgVyGF4r7cnQ
 CoAiFtKr9nQ8L4Og2EuuhZaOay21kBh4E6x1d6z5ram8MS0CDq6aJmGd8V/CXOb5OT4ly
 agU++EvbN13l+HW7/XGHV898LaVdezKUazcRliTbpU+mXkISY0pRCAN2B8a+Rih5ZCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792621779;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=hCVQ35O6aH7scw4SgxkQzLVkgp32P1klKFJFaAT/SIg=;
 b=JUkbGCctJi8xxAnG8/RkUv3uFcha3XZsrkQZra3Y5t/zyAnUfqAiBrssyTzKXN3b9z6R
 syX7bnYc/vOfijyRal3PD6H05r9sqP0+JcKayj1T/3MINlVPxdILHHUNbRhUPc/rjWj0i
 fMqymeF5JY0RkhHa0hYrnhTl/kr/s86ApTUJcPvpmBP40u42c7bZJutGgVQavowxfYhb4
 SKPVrN3atMbpuy6vZeirPDO6wIEbnpY+40yU1fCU1L/ajvucdbM803DVKMU755RqShkis
 ugUNz+EkkKOlirYckEuPgZRjSE48vwHNq1HRlAUmiChqLTt/uH1PRsGX5zCOBMvrktQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.tenstorrent.com;
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=QXRBzwLa; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1135"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1135; helo=mail-yw1-x1135.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=QXRBzwLa
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5CB4260A90
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:29:38 +0000 (UTC)
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8ab432273c5so12640307b3.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:29:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792621777; cv=none;
 d=google.com; s=arc-20260327;
 b=CBlf9oG1EJDQYTs6vqvRDHDfWfkxeWrQxfT7VvThKSesyQC5N62SDiNYk/ldi/r5pi
 XAyn5mi2SqGYzEP4HnK4p4VgJYTafVHmHfcIhIkLH3Ta0bhkFLfXs+s8gEDcGb+OTqLp
 pNPGbpBCADgtJcTRnTnFoSvFxXs8286RIVYeWAKH5nY4gTb9bdCgeRvvm5XvPetkOzfY
 7FckgEbmcJRiAmfidNayNeSyGfoPxkVOpl9LpaccHQnKAjLCUVQwOi/PyT34/pMjyMty
 XMu1mXBcZON6FDMappaKIRe/Muxt/6e1REzJVmiZcNhOiyevQTIMS+T30ZU5LIDALkUU
 jS0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hCVQ35O6aH7scw4SgxkQzLVkgp32P1klKFJFaAT/SIg=;
 fh=TF8Zm/geKf3C6JPdxXEXEBEeh5XLjJqH0QZr/tyxH0c=;
 b=lGmw+j6tBA41syEhlQ89Jw1ptFWsGmj5Oi3VOSyPs+SkJ8bI54w0WyLSPQG0rn8qC9
 b0Rjub4P5pRXtxWQjwfvagjoA0pZfMTxusAq7zblQgEpqo/GktDvN6FRdzU/SsWkdUZL
 MeslIi+Sxt1TXoafzic+v9xZez50yBx582hmAA4vbV9Pc3VJbwA1LuNdjTAGRUGro8Xg
 GW3ZHF3kEmVHO5DMtoxsQ5q6mNckxQgMtDZ5j4+weRZiGZ2nfRSliy7L9+rJfsfn8i8G
 e/wUg4X45KaZTXcG7u+XiY6AdHDxurUm6Zhrf9k2odQTQkcbxMahGM2tY8XIfzX74T7j
 WI9A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792621777; x=1793226577;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hCVQ35O6aH7scw4SgxkQzLVkgp32P1klKFJFaAT/SIg=;
 b=QXRBzwLaSfqF8wLkJrwSO39hotmZdDZ/t0m3gbddpe4O+399I4UDt0J9VQAeZaHcMg
 OD4dF2uD48790hskJckrh1VzxAkVLz0jx5MI2LZKERD6sRdw0dPb2SLFtGsmAuBdLDLn
 sNFxlwIGswzzOaSyGnpOHHyJQAMC++hDSQ0hwqnN5zOyG3J6DoF5Our2dgeFU/FjB+G+
 fzXSQpNxFUMRK81cLBtq8JwBdA9lZxy9YAAEr9HdSeFGWslUm14tJAuZuLk8a1beWuhM
 PjxMCLKItqZBxjDcBfQm10ufImn9MBJTiS+jSE76hbnXS/EZhrF1CW/wgnpjl+pSK7sC
 WOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792621777; x=1793226577;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hCVQ35O6aH7scw4SgxkQzLVkgp32P1klKFJFaAT/SIg=;
 b=SijRrQ+PtkE6I5FgBflF4mHFOHxaFowcD/N6xU5X+fhd7e5RGFZwreUsyWRzljXXCS
 3OFZL7t0ob8K0PjskXzdxJTJVb422E0ZuD9V9GNEke4C0H6e0uahow89SPD3TqjbES6y
 9TD7ILxm1+YJ0r0XfJUBBrC5QFJIPax/C1hvSl30kBp3QpTSwzmvFgtgN4Ur34TfLrJi
 o9hKb1ApsLkUpQfB30HknGyXq8Y0ZvyxIgWwSZdWpKNccJrVg3G2IyrkBWXTNoOZSUyN
 pi1g3HJ3qEEDM78u6W5hhhcP6W9Y0yuV90cScMoWjqUYroIcFdKdC0/ID9a9DFIxgcAH
 zwsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcrBlgtDmoFyQHmKtxXxDIOlQe9+uwaT1UF3q1Lvh+IR1IvKP6gYKKPOyHeqtLuqzv1YmXAJY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLfJqGunquViwPUk1cYCVNfQJRLeJg+liswqVL/qhEhXsv1HVQM
 IxHYJayXkgaUNjeDxlq0XTqWenNmXcT2/wj9H8LtKeMxpiDWd0m6OXjTEkbt5dd1MqVy+K+GrhQ
 9opi1vEdbZHAzWdy3c3QEfu0kNY8U7CTMClU4yRJJ2Q==
X-Gm-Gg: AYBFou3F5ISgxhr3g3HRwm1lA0cxSE2T30QySeLLksulenBq4e6NDWRNTkJ04VTi7Xb
 ub7DwF8/rmtsFcNZxxwSd1leLuUGFtRwZKSNDw7CsZ/Zby+zJRVOABflskHnVeXgqV2DlJw2Diu
 Mgfk9Z1aeseWsxrbOoE1ozJCn2ELVMDKy+F7rVIZkFPdFwUslprp95dnykf5tqtd03wD+qmT4cS
 vUE7WvJ6WvMm/6Diz5b5S171tIdp4agvs3Fo5HjlB2AFKPvE8mX3RFVk3wBB8WULbu+7/xymIH5
 K6ebQDA2YjYFGgrTBvx8Y07gpgS+IrJomalvvXKikTPMkVLVYJNYigWMefPhNjyCL47CsbBVCzG
 sgn108OrwX692YOQbRdFwZJ4cfOBm2UpImcMpO04zttQKLybyud5uSIL1zbyrYWxjnFpRaOPdS0
 I6JAoqYHfqgEvAnX+gEKMdwBOCwQ==
X-Received: by 2002:a05:690e:454b:20b0:679:980d:9986 with SMTP id
 956f58d0204a3-67a0e040ebcmr1375695d50.13.1792621776949; Wed, 21 Oct 2026
 15:29:36 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260803-spi_fixes-v1-0-33f36e764104@oss.tenstorrent.com>
 <20260803-spi_fixes-v1-2-33f36e764104@oss.tenstorrent.com>
 <20261021205719.GA3366009@bill-the-cat>
 <CAEev2e-afN=ryWtttsRL7UYWqawRggTPA3jrn87Ux6h2YycTfQ@mail.gmail.com>
 <20261021220037.GJ3275858@bill-the-cat>
In-Reply-To: <20261021220037.GJ3275858@bill-the-cat>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Wed, 21 Oct 2026 17:29:26 -0500
X-Gm-Features: AclHuK_xxmTKKAWoUGCb0KAwF-jq8O9NflTnqo3bB-ibqobT2Y9HvfIJ_WF7LOk
Message-ID: <CAEev2e8o97gL=6tud=yYcadSNbJjM8aN5eqY7wx235t94E0WXQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: dw: Add supports_op function to reject
 unsupported transfer modes
To: Tom Rini <trini@konsulko.com>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 u-boot@lists.u-boot-project.org, 
 Vignesh R <vigneshr@ti.com>, Ssunk <ssunkkan@gmail.com>,
 Jeffrey Yu <jeyu@issi.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Boon Khai Ng <boon.khai.ng@altera.com>, 
 Flaviu Nistor <flaviu.nistor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On Wed, Oct 21, 2026 at 5:00=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Wed, Oct 21, 2026 at 04:14:42PM -0500, Anirudh Srinivasan wrote:
> > Hello Tom,
> >
> > On Wed, Oct 21, 2026 at 3:57=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Mon, Aug 03, 2026 at 02:00:35PM -0500, Anirudh Srinivasan via U-Bo=
ot wrote:
> > >
> > > > The designware spi driver doesn't support dual/quad/octal modes, bu=
t
> > > > the driver still tries using these modes when it sees a capable fla=
sh
> > > > chip in the devicetree. Add a supports_op function to this driver t=
o
> > > > prevent this from happening and force single lane operation.
> > > >
> > > > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> > >
> > > This introduces a failure to build:
> > > +(socfpga_secu1) arm-linux-gnueabi-ld: drivers/spi/designware_spi.o: =
in function `dw_spi_supports_op':
> > > +(socfpga_secu1) drivers/spi/designware_spi.c:707:(.text.dw_spi_suppo=
rts_op+0x18): undefined reference to `spi_mem_default_supports_op'
> > > +(socfpga_secu1) make[1]: *** [Makefile:2131: u-boot] Error 1
> > > +(socfpga_secu1) make: *** [Makefile:189: __sub-make] Error 2
> >
> > Thanks for catching this. I think the solution would be for
> > DESIGNWARE_SPI to select SPI_MEM. Other spi drivers that call this
> > function also do this (nxp_xspi, spi-aspeed-smc, cadence_qspi....).
> >
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > index cfbedd64c4c..a5623a2cec6 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -222,6 +222,7 @@ config DAVINCI_SPI
> >
> >  config DESIGNWARE_SPI
> >         bool "Designware SPI driver"
> > +       select SPI_MEM
> >         help
> >           Enable the Designware SPI driver. This driver can be used to
> >           access the SPI NOR flash on platforms embedding this Designwa=
re
> >
> >
> > I will send a v2 with this fixed.
>
> Yes, and please have that in its own patch as a bugfix. Thanks!

Is a bugfix required here? The designware spi driver currently doesn't
rely on any of the symbols provided by CONFIG_SPI_MEM. So it doesn't
need to select SPI_MEM currently, right? It's needed only because my
patch introduces a dependency on that symbol (so it should be selected
in my patch only).

If there is something else I'm missing, please let me know.

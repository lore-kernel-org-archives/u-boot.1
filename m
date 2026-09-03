Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFE8C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:40:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E934360B99;
	Thu,  3 Sep 2026 14:40:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KOM-8UlfHYqE; Thu,  3 Sep 2026 14:40:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 52C5360B4B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788446439;
	b=q64xg0Am645YSvz2DJQffYnLC/jEeiXjihfEab7spCsHiJXBDaNIgiEHLGirn6rc4VMz
	 FnM9leLbGjyGKBIhkR2EIiRXOdU7wokzcT8zsS9VMp9dBdCYUfY4A/8j/Lb/FqUTGzROl
	 sQ/szv6n2bx8Mzm3+L+AsCnhbfpnGy4gPslvMW9J2Jk3E9ExRlOxISq4fyRvsjWhRgKFL
	 7F4sUZU/05J/lOvvGFZEFnTKQ2TbiRhdULJxtZmpENcTKOT254LJbGu/0QvJcqZL1PV6Y
	 n8Mthz8UEFnajL5NuKVJgFg0K5MaB2+JLatSfMgGHlzxnaagg29yPIIiB0ZEiPSU0vw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788446439;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=g34QTDylgJ0vrgZr0qR6GVNWV6xqVR5gl8/iuJBklQQ=;
	b=QeOWLPq5MXGO7B9ECWVcliGCwknm64dWMsgCUSDAGa5OYxzPS9eNfmw2rZKFYOAuz8DN
	 3pSqZgndinp+wJgZ8BdaHymidIZfc5NTSfiwRyAmVDDmWG5F7iQMcY5ler2QuoHt+9O1/
	 SQ6LzjUrxgLm2s21Ej5qUZ9e0iS2yCBEq9xsMNShvcQ4i05EC+oQRyd/pIThaXbPL0UAt
	 zWO7+LQSmmapeIGA/DcSo3k3DjqVN/gHQynTlQYpu6P976T5VKdsH6vnOYjNX+rFbzTO6
	 5NHa1VxGuK4gy1tVbiXfjgd3yu01ynZt+0rEj7fZQ0I1Hvrjf000FI04X5ISM/xg89w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Qr4Gsj6I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788446439;
	bh=g34QTDylgJ0vrgZr0qR6GVNWV6xqVR5gl8/iuJBklQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gHPVWCOqKHYBrVQWhw1dtyAXq5TY4fK+k5O5C6GIeYlnasg9JtYIXAX45Vw17zh1Y
	 8xYUNhZoJxEdL5u3mshWkn8cOLME8MXguexu2lHPk+bYVTdmsVZ/2Hi0ETckzKfzzE
	 DMNSp8pkk7A90NkMQnsXNWDRWSNJkN9xkeSjZkd1+upCMmt0gUL3y++RgvFBI1oKk0
	 GJH+cKSi1/43mOxnUE//EFDKaBWDCpfouem7ZcudHjZLk2mPdl3/rErbfhFM7tYt1D
	 EtikMf2lfvz3coCgCd5YYx6+dYXkgkROgQP7vO1DKuYcWw2jUeNZ1MpUurJQUgJEsW
	 Gtwt+P7LoObpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52C5360B4B;
	Thu,  3 Sep 2026 14:40:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2737A34E
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1646160B4B
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:40:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gAY9IM5xG0lA for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:40:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 59FB6605DA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::236"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788446437;
 b=geygtKt7bqYywTv/rAlKLxZ7aUPg/ATm0PAsL6YvarF3RCaGwQxUZEjTDs6kUlMcTapU
 +G3B7efC2HDwD8jDcK4AIieD+hVDSIoynvU3tDgR5qhhgpjPQpQC4ER38QdraFZhRc3fD
 00z45zT4iODVBO5Kq5ssoM2FLklPlvh2Z4vWhCz1hS3QNHcvVZh8qU19s8q7hYfmTVRih
 kVzIcg+VMDUur1D9v7LaE8COKu2sblcuSfirfCOMTpS2zTEh6jNRkNznHcc2VOYFGWe14
 jB4IjX550kQqrdFP1WNUm2RsKluP4RGiIY6WzMQJb39amI4xC40g3FE/Y2YIUpujlgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788446437;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=g34QTDylgJ0vrgZr0qR6GVNWV6xqVR5gl8/iuJBklQQ=;
 b=VJmXv6tlKR6ICTRfaGXvag7V0IzAgqCOBM2kALayO7IwF/m7efkLuWHSjY7m4Z0mpRgc
 xlBUP2cAc6PO9ak02fWh/z6KB8uJtxT8qVrydUyp0IVNcsKQ0upAW2bIRXAGXn4X6s1Df
 M1AWF0P3xIjVp+ytHGmwWe6FXvy1fejvwtsSnJthsta1GDpwPc6f+gLbMJepFe/y8pR/E
 VVObU5oj0lLu8m/gNpSMuOidRPpR959nWcyWAzAezIe0iQAehV+FfgQUIXQC4YQsj0YLr
 BqlXES4HzqXt+2IOMA6gd2bcvIXEDnb7JFIbsrVoPEaevwzNJYRLBqt5kLE5/rYk/iQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Qr4Gsj6I; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::236"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Qr4Gsj6I
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 59FB6605DA
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:40:36 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4b28db31b89so1306461b6e.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 07:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788446436; x=1789051236;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g34QTDylgJ0vrgZr0qR6GVNWV6xqVR5gl8/iuJBklQQ=;
 b=Qr4Gsj6IPNMXdW6lgGdy/UZoVrACACP9itO8Vbzb731smCpSGV9prsIMmovhESqNd4
 jgpVxkAxFY0kE1l8a/fs7mlCTd2hg5eNEiwr+QxmMjSNIbIfuRfxPyfxgkDeGQCV5qBf
 oIFQbKw2ir6J8g9Io3kFD2PHBemEbehUFMq3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446436; x=1789051236;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g34QTDylgJ0vrgZr0qR6GVNWV6xqVR5gl8/iuJBklQQ=;
 b=DQaGyQAeN4JLr/xCrVfJch8hqjXAFDiadmHrplbZvt3eizwNLSsoYe5Cm2VEQcMuqQ
 viv8iXaqdKFMQ5ISPp+zpj1fRMN+4bzqy2dTP7nazwlpkJMXbzXk+jr4bhzE35C9sA6A
 J40vgr3BWfPnLILyd3vh3hCyjNu824+UocwhGQV1jZypIgKipfuHYhaefIBbK3ORUebv
 8U1S0J8uGWzillK2ir7ceXvZm1yjiJ28HSt4EHhCI27ubyWpgpBCKE+YizlWZfmgu9yQ
 T5EySyvaGIOLVo0Akf9hJV3oD29MQdieVpPX6WVNSR8Q8fv8WsITwCEWMopVQxoGi5k1
 jK9Q==
X-Gm-Message-State: AFuF++nwZbhn0Ijek960oqA6LLqDjuD2CuCxJxjKRapVBg9PJ5GWp22D
 xdfRbJEWih/6m/bRakVIE8lPWY5vnJi6n25ahz/ad8BzISZ06UvKJu5Ido0lpanKMP4=
X-Gm-Gg: AYBFou1cHV363CjtbYFzi60zm60UVdV/us1aVniumh3+jTMzYzIj2Dt7/ZFOrxDY3s0
 Hr+7hUux9sURZ9M+iq9iF6sCkGvQxzuwZ8xtR1JnrhwoGoJhseOc8+t6d+B4Wo3b4pZ5P6ibtX7
 UdZW1l0uA5Qd92lQJx29z7FPuXIyOmWHueWXGlupPRtTiJjBbpqUJB20fr2kJAgtASHUkI5CxlU
 1hNgcLxjTCK8oNPJNpz6hfjbVR6Yg7LdeoX9QqJ5H4oSCFUd963zyv2GN4WHRSsUCtn0auJbvLQ
 CO+UZzuLOd7c6gaRdjzoYii9OCHY5n756WjbfeKSpTof85WGSd1SCsIuBJoZR/r32/O7JP7aBbo
 z5YemBjWEu4I75sc2pn3oXBeBpSipz2fSb4xRsQj6M4q5sfZzIDl9JTtv0qaDY3MGFINp4NHfpi
 b5P0hfbgGTeHdlCNX5Ug3ipf8eMRY1SSEvgpll9RzUg+R7x5OAJMZTQFOXGdDQtSa6nZCEJrRk6
 hv61f5LhMUKcm3b1Ug0roc7A+jBdSNzB1PjWc4zuscP9pqsWKOAlsUC7jO0gwpHoiYwT5cKmmO2
 FGbOX22ByQ==
X-Received: by 2002:a05:6808:1385:b0:4a4:ed9a:e793 with SMTP id
 5614622812f47-4b91e540cefmr635113b6e.16.1788446435825; 
 Thu, 03 Sep 2026 07:40:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b69851d47esm5006316b6e.4.2026.09.03.07.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:40:35 -0700 (PDT)
Date: Thu, 3 Sep 2026 08:40:32 -0600
From: Tom Rini <trini@konsulko.com>
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, "Andrew F. Davis" <afd@ti.com>,
 Nikita Kiryanov <nikita@compulab.co.il>,
 Peng Fan <peng.fan@nxp.com>, David Lechner <dlechner@baylibre.com>,
 Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH 1/4] arm: dts: am43xx: Add missing board u-boot.dtsi files
Message-ID: <20260903144032.GI1764417@bill-the-cat>
References: <20260903-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v1-0-47e1c63d188c@baylibre.com>
 <20260903-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v1-1-47e1c63d188c@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IhDf8u3ly7vCeIcg"
Content-Disposition: inline
In-Reply-To: <20260903-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v1-1-47e1c63d188c@baylibre.com>
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


--IhDf8u3ly7vCeIcg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2026 at 03:43:12PM +0200, Markus Schneider-Pargmann (TI) wr=
ote:

> am437x-cm-t43 and am43x-epos-evm are currently missing a u-boot.dtsi
> overlay file. Add these in preparation for OF_UPSTREAM to include
> am4372-u-boot.dtsi.
>=20
> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
> ---
>  arch/arm/dts/am437x-cm-t43-u-boot.dtsi  | 21 +++++++++++++++++++++
>  arch/arm/dts/am43x-epos-evm-u-boot.dtsi | 21 +++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>=20
> diff --git a/arch/arm/dts/am437x-cm-t43-u-boot.dtsi b/arch/arm/dts/am437x=
-cm-t43-u-boot.dtsi
> new file mode 100644
> index 000000000000..bb40317cb28c
> --- /dev/null
> +++ b/arch/arm/dts/am437x-cm-t43-u-boot.dtsi
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "am4372-u-boot.dtsi"
> +
> +/ {
> +	ocp {
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&uart0 {
> +	bootph-pre-ram;
> +};
> +
> +&i2c0 {
> +	bootph-pre-ram;
> +};
> +
> +&mmc1 {
> +	bootph-pre-ram;
> +};

Not a blocker but a question, are you working to upstream these
additions?

--=20
Tom

--IhDf8u3ly7vCeIcg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapmG2QAKCRAr4qD1Cr/k
CiAAAQDxRvOnDs+FV0e8CqH5+SnUKoQbKh7Qu+dPlXtfvL++kAD/QVLOHyJ6+1qm
Ola9iqRWeVnQiQtp8dREOvZvVMUkKww=
=kb7L
-----END PGP SIGNATURE-----

--IhDf8u3ly7vCeIcg--

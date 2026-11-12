Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFDC606A32D
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y6ZyDRjF;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=IL9d6425
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30E66607F7;
	Thu, 12 Nov 2026 16:36:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zFzmY8K_8QBP; Thu, 12 Nov 2026 16:36:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3EE51607DA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794501413;
	b=UX8mlxlmhbcB9q+momvIk9drYOvFVvA1U1JfIi1oYFz/ctekBMaoVoEqMBSZhhb/5c4z
	 Xf+X5tQbLsvbAmgItMLQUsDlJnWPXiRFcmZ2Pcc55PyTR2jHOtrHF19/al3fIlxoXbHlg
	 hZD/FW4h1qhHlqE0YZSB15XvGEDO8J6WaStJ/MXPnp8DDjfQnVCDxs3l1t9Nq31sTu+kt
	 /pBM9QioIvRHwzPvr8QcARjjKBQ5/4JktpBfRxgQt/aDxyWYw/zjXupXMLXo4yyJ3aagC
	 9tOrfxv3Ab6hTN7WpGI9mxjmPuaag6u4PFU5NCg0T4fY56TJ23h6RXg78/ePvglyAeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794501413;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QSPzrqQQMAFa5nHco4hARE0g6Q67EuHlczXi0+51ObA=;
	b=Ak3xJctI0XR4zr556dbILI6sLrtDSntouKlKKMUdlR/KcK1hcoDMOvHY9Mg7koiT5zsI
	 XhKJ2FV9UuPlwXLbfKrygiZNa693zmdvFikpuWj2dS7EVRmjkxseee74o6zmrx+Z47LEd
	 3TLugWzO8asV0Re1VT4TwtcSDVwe6mGwp0bNq8rFEgXj4vKGdGuGkss7oiNmLdrCAwPPJ
	 Mzb56kPP+nJCvsLmL6QsysXGl7mWODLrNUSDUlMKPw8vHfNpQ891dy1AJEy+nyh6SP3iE
	 N40nt22hzNJs03CfvEYu6OoZOXneWOdlVzA7voQwSxaAT33dwS5T70J1f0vufduLsOA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=IL9d6425;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794501413;
	bh=QSPzrqQQMAFa5nHco4hARE0g6Q67EuHlczXi0+51ObA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y6ZyDRjFYMkQWCRsbmHY3rFvhm+q/uSMAB2RETGNuEjh3f6GwXHVVxcsZ3Ovg3XXN
	 Z1GThpLUFyiCMsmCwLHuLM5djf9Mq1mMfkrEfq5gIkIQVvHVWQzWi86TZbhzkGvlgU
	 wv6r+MHJB63v+3iil5cR2Q1K0UbRkT6dLvh2k4TSQsFyhwxGm5k1i6ZZxP40pFLdU2
	 SrdOADVa7h+q1VFl5t7YJ3F6G+Qi7aVJtd7pAljKdFpWGWLbp60s70GjL4Ccj5WR/8
	 Dx1rD1ljLZ1U1wY+HU9ZKBfWRtO+TobG6NFyaw/tm06D7hatyclGthj7SsmV8B0CEh
	 3L4scPNZjVf2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EE51607DA;
	Thu, 12 Nov 2026 16:36:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B51AF2E5
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A68BD607DA
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:36:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l_hRpm85wu2w for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 16:36:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B56EA607BA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::3"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::3;
 helo=mail-oo2-x03.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=IL9d6425
Received: from mail-oo2-x03.google.com (mail-oo2-x03.google.com
 [IPv6:2607:f8b0:4864:31::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B56EA607BA
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:36:49 +0000 (UTC)
Received: by mail-oo2-x03.google.com with SMTP id
 006d021491bc7-6f436312596so1642417eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794501409; x=1795106209;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QSPzrqQQMAFa5nHco4hARE0g6Q67EuHlczXi0+51ObA=;
 b=IL9d64257fiV9tndzUqbPvps5DLnUqsgMjHMSnREE13UDbMYkgIDHUhhQoyTo4mkVC
 60Lj9W6wMN7Ug7jRddzCQ+c5H+l4npqyI50x8ooq/KFWOKmIYLy6lWYxCFUampo+vYDt
 0ocZeVhfmazuIQKYGQjScPkflcy3gsz1/mQy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794501409; x=1795106209;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QSPzrqQQMAFa5nHco4hARE0g6Q67EuHlczXi0+51ObA=;
 b=tKuWZFIHeVglskUYW3DZK6UMNn2XAm/XoPqVol0ZBG2sblDCMnb1sNhUjc531GJxl9
 agQo2n27JkzzPZc7oNft6TCZTY1tglR7oBXik9esRoKg5gh9IjGsBYIpVItNagE1QCeF
 z6WnP4WGxY01LhDLawF9f49Svnu5o34vMCBUqPgCbj0d/ymGIAK/lSxi7O9NLuUCYnE1
 bFh0sOAK351dnZfqadOEbQa4sicKHnIQw04DxCU2SFeOSxX9bPxq7JUgIUVBlhzg6ggG
 9pU8iyFEG/NE670bJLfFBOyx9D2WmRCJ23E8VgMh9Ig91F2oucMaI/W4FrnfCdYlBP3H
 NxtQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGweUesPQtnu5A9g/UnZ0TfEstYDojT4WFUJv0Z/PWFO3qvAx8soGbU09ITIpFKciUCfrOElS4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/Zv/WscMHpSoa2EfOlYWpjP0Kio3P6+Ls65jDXlsmpNzcjz4BN
 JDV9bw9rjSOOCainkG3SlwZd5wqJ75Hzq3OYJ0ICXaELAPSFF8XAIAxOetjg1ZXNI3w=
X-Gm-Gg: AYBFou3htOUjzKAuzgIgcsVGgHkbDOvqFTOkwBm3a/b3z+8zg90qg1Z59+J81d+KKR1
 kM/iJjSGb1XHt+UP226h+yBPdYsa9rIyICepucEUxh/3T7K8jkus20Lcm31sKYPfGtVuI4vYFcm
 V9ZNk9X6xIiKE1d9QIlR75VErfeqNY3SA4gASr6XXZsfV3adKpx7s68U2fLb83jfi3z2KwBSnRY
 qZm2EvIwFdcUAYio1osfif7cicUxtz31i8H/dPW70d9xN4XRgKjJ+IVicRJICCoRxsqz3Rv2YN7
 TZc+GxN6RqZL3UEJD3Cd77QGj59rzIF9KI8YKUSjbUarXfS9Cs2vQ22IkwnqiKY4yCvvsqHgc8Y
 JKRmPaRAhrjxsvs/R606wRAdZMLxlHxZP68d1WxY/gY24zEqwPTzHjq1nx6PlETNxx7agblNsR7
 V1anGc/9KaRYaS0PuBkZncptHljQ6PlcFlyhw7+0yXvee5xlSZN9GfAwVaTNikJj6kdnVtOmf9v
 KY5/NU078hCyjQ7hc1FMMDrLeaVsWVBuioRUSMo4ypL1i3KKtGoKGnzpICWGSgaFbAcuTrd4w5M
 5KQsuySqmjLfcRDn0R0hLeZ11SoOtkk/JhbA70OZ7u/+3or+EMMyHEf5zpy6UL09R0ij5CldEqS
 fHkeakjj50ZVkLaSkCgOti3E7uSLNa00pMR+U7N3zAo2OrpA82aivsLqSK0uwOtuYKgqRlOeSF4
 vkJsNfyrc+bMkQiuMfJe1hYIZiVCOVaag=
X-Received: by 2002:a05:6820:1621:b0:6d7:4af6:e292 with SMTP id
 006d021491bc7-719175f26ecmr4344802eaf.2.1794501408824; 
 Thu, 12 Nov 2026 08:36:48 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71ab08a2f0bsm290724eaf.0.2026.11.12.08.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 08:36:48 -0800 (PST)
Date: Thu, 12 Nov 2026 10:36:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/4] tools: qcom: mkmbn: Updates to support ipq5210
Message-ID: <20261112163645.GE554944@bill-the-cat>
References: <20261106-ipq5210-v4-0-5af12cc2b601@oss.qualcomm.com>
 <a2b6bc3d-db58-4882-9964-ae0a1fb218e1@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MY0q6iH0EyUW+5UX"
Content-Disposition: inline
In-Reply-To: <a2b6bc3d-db58-4882-9964-ae0a1fb218e1@linaro.org>
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


--MY0q6iH0EyUW+5UX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 05:21:36PM +0100, Casey Connolly wrote:
>=20
>=20
> On 06/11/2026 07:07, Varadarajan Narayanan wrote:
> > As part of adding Qualcomm ipq5210 SoC U-Boot SPL & U-Boot proper suppo=
rt,
> > the mkmbn script has to be upgraded to create images that can be used
> > in the ipq5210 SoC.
> >=20
> > These changes are to address the feedback in the 'Qualcomm IPQ5210 SoC
> > bringup' series [1] to use mkbn.
> >=20
> > 1 - https://lore.kernel.org/u-boot/78ff6a8d-5c63-4bc2-bf1e-6b71b8f9c6cf=
@linaro.org/
> >=20
> > While at it, fix the MBN version number for ipq5424.
> >=20
> > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcom=
m.com>
> >=20
> > ---
> > Changes in v4:
> > - Drop sm8550 full defconfig and instead add a config fragment in board=
/qualcomm/sm8550.config
>=20
> why this change? let's keep it consistent. please resend the defconfig
> patch standalone, i'll pick the others here.

I asked for moving some of these to fragments because that's how tegra
handles the case of N platforms that are defconfig + switching default
dtb (and more or less nothing else). It's just a tiny bit more typing
for humans to do the build and easily supported in
OE/buildroot/deb/rpm/etc.

--=20
Tom

--MY0q6iH0EyUW+5UX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavXrFQAKCRAr4qD1Cr/k
ClodAQDiHzjg8dvUAy8Smkp670FAata0P1AIYmp2NibB6+vXPgD5AfbQ8UO/mGOM
r+QJ+wCKJVRnA6zcjxfa70k0W+WS9wE=
=AubV
-----END PGP SIGNATURE-----

--MY0q6iH0EyUW+5UX--

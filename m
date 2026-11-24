Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4279606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UjM811kZ;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=plaCZxYf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 760126069B;
	Tue, 24 Nov 2026 18:34:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fsw8RZ8vsacP; Tue, 24 Nov 2026 18:34:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A071260749
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795545276;
	b=Wi1epRwB339tmYlpnYTntric2vM+sByWEf5evEEfLzNJ0fClSLakw2Wx1NZrrDUA/J8M
	 4Y8h1iBunmW2lr/xGOzynpgHFgn9+785sT+TB+eFATjKLllLj4UlaI+f/EoVfYnH87LPP
	 1T0oe/ZLyhyD5+A7bIL0yzZ9INNK+73JFbA71vCulwniz4PsisRrwxhvzy/I7wi8yflZ9
	 0/m6iMQ7Z4teGmJRd+avql4F+m2JsTODwFfp3+xz5/AiayhsB+mdmzyVuCmBOJCdAAcTl
	 EfnBGXV4oCjmC/SV6Qhw+m6XG3C1zhl8j/h6vTK+RCzaYh4ECxeqGLdxpyRl/nLxPjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795545276;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=oUONfv0s39/dHYvObzOYeCoj5V/yNf0NNQ4CALS/feQ=;
	b=p0CeSWOUdBwPDA90bEzXZ1bOQYbv/wT7BLYKRL0DOnJ1BMBlVwZxpkCcYCaFWOC0UQ6p
	 RRB30CrDz4YvAOrXVk8tABT000CYmnM5umR4lXHEqzK2hQly4xoc8bNP/GgOjQBeV4oST
	 GjR6Z6fViwQSBTWTO3/OYTgL9EZxmrYQfRbRnBlhGaABAcXhDb4BuwhCEdGUmTjjSIlCO
	 DEo/d916yh98ZHXS4oJfnwEU5NJr5u/TNOgJ5mp+VxjcTL2QXE9JHL7c9x43P9uQ8LVx1
	 +XzInkawtjEOzktYjbB1yKim4NJMsIwztAM/+6D/fMYRudNGs7Kpv+AyYsKJI0OwMWw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=plaCZxYf;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795545276;
	bh=oUONfv0s39/dHYvObzOYeCoj5V/yNf0NNQ4CALS/feQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UjM811kZ4XX6eAo78Mic3afbYgbbpzkf/4xLFHIyd8bxDnl/iSfBvtDnp/urGcSWu
	 F6dyZKq+Zw6mSHmQEBK1TDhvYLWIcq46RsgGWkrdISXl5NS+TF4jQ1xqmwXAzoFYp9
	 SfPjmrXCLiSqJsppav1yfM5yJ0icD4yrl6b7kDxbUg0gBS/hmiwzA4cukHtwNfUWDK
	 7osfxdzLFd3f4SMYgHfWrmwLOIUgaMCvv0B+JouEr46PbncUV7aytJoHRH6qIm6pfl
	 X7a2xNuP2om4VuyaTupa22judQFaZpANoB9W73LyMgKd4DTu2F9FsaW3cZxuMG9dfE
	 mzRxuiw5Kg/yA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A071260749;
	Tue, 24 Nov 2026 18:34:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 056AC2F5
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E030060749
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:34:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4MeNZZAcFgvt for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 18:34:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EA7FC6069B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=plaCZxYf
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA7FC6069B
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:34:34 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-57728d87699so1953954b6e.2
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795545273; x=1796150073;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oUONfv0s39/dHYvObzOYeCoj5V/yNf0NNQ4CALS/feQ=;
 b=plaCZxYfaRxbq+GlOjSYkFe8tLWzyIjqGaXN+uJKcPu4TYgQyIEuu51B8sPTYRXebL
 GPPgxoNGNoel8gWobhLOBB4cZ9e3y6ilTPUiWXB/jNg0M2lDfx1OhWs26BopuFhWSDnv
 sxSnphwoHB/nSgK2PqhJc6D1IzdIHWrchEv+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795545273; x=1796150073;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oUONfv0s39/dHYvObzOYeCoj5V/yNf0NNQ4CALS/feQ=;
 b=UHv6OW0tj64pfvIf3pZ2kEUoXZSyofvSXNWZ/dy4Fntdq1pMwAscOmy+KFkDhk59Uv
 dO0UE3cc2940QN8e9K3hJpXgpuKkk8CZqjF4wzaeHu/RMVwfMSwAi3PYr6Gi/ca5JWOH
 JXKjPGo7ilnTdJ07M5tvDwKjmHiNidcn7Jv4DjkC9Imyvd4Z5vPbQrAH1mtiS84MEEYJ
 x3Rs003RxQrEr3oXNLzFPA550scH/ot6GLaYbQ3g2rcmDq15V7ZL6LWHBSrknmfexvnt
 PXINUYFr5YV/G6hWv1dduV16CjCZ13C3q87/fSYRrrQLJkZzEThjTEPJWPaUOhuuoZmS
 MYKQ==
X-Gm-Message-State: APuU4Z9T5iylP4h2GOo5kbP/LH69R3l9MdE9FacyxQv+sb94dmHZGSWG
 rXIa7+C1UC4OYn6nUM6PC1wMbAfi1k90rBfaQah4TjmWS3IGm+daCSgART8tVi3tOgE=
X-Gm-Gg: AZFdTZfBqYd1k2/60j3OElMdCyKUlAqjM+xIz3OHT3KO+QFauVb/75lXQdVn+UOQtTM
 gX6rbdlJP0LmQrLe23nR5blnHOM6X/5eCXFBmWyhj8VWpgU4NR04n7HBlwcEwJwAImIZso1LjpD
 6lRSxsGMSgIlEKxK4ftY1qC80+c6whaCPxNOZ0x3c2EjU5OloxH3a8H+midi0n7jHmP4Zjw8zKG
 XggDvjIg4MB96RY80QlRhs2vMAavrQ6H7fXZgsq6q7Dg2djm3TLLJ/KhxdhjmwfzsGivT9yUKsp
 +u9004xQRCYs0EBS6NUkQewVzaFuPieJA+GGsdlc+6Bo3p4qKxTD46mCBAKr93A+ADRCZG28cfE
 PoA3qfmUvRNcVGvk/tQ2BCcOxC8IBoKLI99Swi06xMt8Ua8Ds8Homczr9C5NeeVcnlZt4CcmdjL
 8u4Z5DvD1mR+qQqszr8A84DvkhhqfJQjJeZ5cEpfUZ7ay6KuJDCbHe2xQQbiuYiwKw1T+b2E5DN
 sSxf1nJP87xnmlLP++oemklGESOdVFP32/XoHT4H0mzTr1gh2qXYtUu2sXaK8UpaRk/mZdRcI+4
 VwqBm52tgrbMCIhYtuzvmTK+X0iqhgUDIiO0fhu97nzG3O7jcJ8poMgpqFqUkZcgZ65S2a5v8Yj
 qOedlIR5lHLb+krEGmIOSswq9sOtHXhL2c4Abav6SVEtdTDFJNMpCZcnhlykTpU4+Dnag1O3rIL
 NEsXtfZgGkuccHm93isJzeBeyWpxYH8mM=
X-Received: by 2002:a05:6808:2224:b0:572:d0fb:ae56 with SMTP id
 5614622812f47-57a0ab2d70fmr17313051b6e.34.1795545273514; 
 Tue, 24 Nov 2026 10:34:33 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a3485e3ecsm11412840b6e.9.2026.11.24.10.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:34:32 -0800 (PST)
Date: Tue, 24 Nov 2026 12:34:29 -0600
From: Tom Rini <trini@konsulko.com>
To: "Richard Genoud (Synaptics)" <richard.genoud@bootlin.com>
Cc: u-boot@lists.u-boot-project.org,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Terry Zhou <terryzhou05@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Michal Simek <michal.simek@amd.com>, Linus Walleij <linusw@kernel.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Chris Packham <judge.packham@gmail.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@nabladev.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Peng Fan <peng.fan@nxp.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 David Lechner <dlechner@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Guodong Xu <guodong@riscstar.com>, Yixun Lan <dlan@kernel.org>,
 Jisheng Zhang <jszhang@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 5/8] clk: synaptics: add Synaptics sl2610 family clock
 drivers
Message-ID: <20261124183429.GX3176972@bill-the-cat>
References: <20261123-sl2619_base-v2-0-9e3b28c77cda@bootlin.com>
 <20261123-sl2619_base-v2-5-9e3b28c77cda@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5vN9Z32OMTlRVcpT"
Content-Disposition: inline
In-Reply-To: <20261123-sl2619_base-v2-5-9e3b28c77cda@bootlin.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--5vN9Z32OMTlRVcpT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 03:22:04PM +0100, Richard Genoud (Synaptics) wrote:

> Introduce Synaptics sl2619 clock driver.
>=20
> The code is based on Linux driver by Jisheng Zhang:
> https://lore.kernel.org/lkml/20261115102401.3520-1-jszhang@kernel.org/
> It has been kept as close as possible to the original Linux code, thanks
> to U-Boot CCF.
>=20
> The main difference is for sl2610_soc_clks_probe, where we force_probe
> sl2610_aio_clk and sl2610_system_clk, to resolve dependencies.
>=20
> NB: this driver has no compatible string because it is bound by the
> system controller driver
>=20
> Signed-off-by: Richard Genoud (Synaptics) <richard.genoud@bootlin.com>
[snip]
> diff --git a/drivers/clk/synaptics/Kconfig b/drivers/clk/synaptics/Kconfig
> new file mode 100644
> index 000000000000..295a126ccea5
> --- /dev/null
> +++ b/drivers/clk/synaptics/Kconfig
> @@ -0,0 +1,12 @@
> +config CLK_SL2610
> +	bool "Synaptics SL2610 clock driver"
> +	depends on CLK && ARCH_SYNAPTICS
> +	select SOC_SL2610_SYSCON

This option depends on SYSCON so you can get invalid configs here. I
think you need to add select SYSCON here, if it's required rather than
optional.

--=20
Tom

--5vN9Z32OMTlRVcpT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawXYtQAKCRAr4qD1Cr/k
CgGbAPwNDOX8foOaaLeoL0tduO4H5k5aSX0o86pTV62drsJkKAEAmlkMP2CgD5pk
/voRuhKVn/Bjgae6pVAejUeiHyiv9AM=
=RSvS
-----END PGP SIGNATURE-----

--5vN9Z32OMTlRVcpT--

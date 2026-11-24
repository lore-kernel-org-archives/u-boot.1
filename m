Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9728606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l6+adaBe;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=FWS6liGv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A53980E13;
	Tue, 24 Nov 2026 18:30:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yTzzsIkCBAyn; Tue, 24 Nov 2026 18:30:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8750D80E04
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795545038;
	b=S1dA9xQyoAqR0Yw2aaq2+vvMCyyLWBhY7TeFbzpeLM09Iet+3kM6z363WU2f0Ybmd7T3
	 cmXCYDXfCfCaSvrVIkgwExLcHo0R9nmuGZA+RhF9xRlqh1B8Auv+puz9ulxu20qQHTXja
	 p/iS2qYHzxw5/+1FrEbsmHUce57JhrE7CfCUlwIpLRg3KtmU2M+/rgg3/cpAecgGNTdJq
	 LtQ3SLflN1tzQ8do7mvuJC3gSbhWVrJ+yP9R5Y7XYNKIluEpPWqB+VDOsO1VgeEw9Atgd
	 D+HUIyGZzRDR0rawI0QgzmB2LevYQ/YykLhFnNpu5gL+IWCPoN8oOXoaltbN6SG6sCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795545038;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=H9W0PYwlhbPcfcK0xh+GfKaQoRpqYERpsde5B+ayOSg=;
	b=JigMljt65Bz7OtMvU/u6FjiBCsBrrbY2coSSv8bXbhBkKWV9lW+p7001lZDxSOaYHg7Q
	 +vNZwdmwbY5iEZJU81iLkqZ1h2Jt+YQ/LufiGSVwEPRI/EnCTCWnWKQFKuPQAIXZWq8Vg
	 27VIr5DjUuscxhYya65BqLMIwKJ8+XC5LreBEzq7rpHN/smf7C2/ORhBn6UyBNznW2p8A
	 9UXPwsxiPWh80lhuw/oiBEs4XxSHazp5GxJZem9FLpkipIwI9lUudUtU28I+EDRY/YPre
	 8EchUv+LIeYIrSwo76wPakp8vJ3hMaTGHsetBFvGGEG2ksaBb9zJQ9vCJ0rus+VlcAw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=FWS6liGv;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795545038;
	bh=H9W0PYwlhbPcfcK0xh+GfKaQoRpqYERpsde5B+ayOSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l6+adaBetgqGZwdygzJh8X4uP5kmq97gLhwy5AZRgfcWQBtMBnOogi/eKAw701eFU
	 eCQWsgFGhxwraIi7jW1zECf9FptZxanVY3j4qWHhQKl25NSqrltYMqFKpgrweW7YGs
	 NZbU1TlqwFx7JN43kQbyP0EvDCT0xLipFBjSj690KRZ+2FGz6QUDdGpxmQjGb5IzAW
	 H8S9s8gIui1kX0KiEuz9ER4QvhzyfV4D/o0nY12f1zVAqefWSRJiEZvx/ih9ZmCEk7
	 5ssryg8TLOC2pmlzyHgBDpqhFpVt5PkRREZP9GPyC02W+f0xzWSH//U470XktfpTGd
	 9SPQW+Hj+tbUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8750D80E04;
	Tue, 24 Nov 2026 18:30:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C56C42DF
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC13580E04
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:30:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w0Rdq80obQTO for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 18:30:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A697A80DF9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FWS6liGv
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A697A80DF9
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:30:35 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-703be215729so2120913eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795545035; x=1796149835;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H9W0PYwlhbPcfcK0xh+GfKaQoRpqYERpsde5B+ayOSg=;
 b=FWS6liGveQ7w9cpsdakLvqdLJrhyJQT241xQtrwqmuAbzEYv7uSMKXD9x/obKadTq+
 OSZBq8DslfRdoZ7lZ+mN1pH/02wyxhacs08vVR01uSN70UonozoNI7EkfWdIoaQ5GuR1
 6Ea6I4EVhr++2FqTJGAWvY1e0+2ire7DMg73E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795545035; x=1796149835;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H9W0PYwlhbPcfcK0xh+GfKaQoRpqYERpsde5B+ayOSg=;
 b=uAj2HxHOzcGirlr4FMVjbkhilUAUvUxfSi9XOMI+9PynwOHrM98gxX8H93DpLqLNMe
 qO/APdFc/Ud5yn1mJJ+IqF5yIUKNPRs91ontQEjfhOC5td8rOguuzOin3BX1uzBOejHK
 VaXZqJnhUR5frdbpA0Llek+VscRgWf0dcMVrkf7MqsIdYRWHu0tJ+OrCPpz5fi2QbSJ8
 Il7oQhsb1nak7lelYd6u6SXkBu1bHUdiJYqWBkD5PVHHzsrSV3dhcc0IempkFjr4kxzo
 gjoggteYFi/omEtoIlkTZoICzGEQwq+iQEK1PbIRmLXSolqyKVD9o2kMWBjaO/LlK4t8
 PqPA==
X-Gm-Message-State: APuU4Z8LPycxjneq10do8tehCja6tccA4++bZOGBm26rxDoYJKfO7m3c
 Klhrh+BXslQ9x8OfTJbzlJeLKCjx0VtjcAx2D/mp5Tx0nQlB+dZlWvBEuHRAj/1oDdU=
X-Gm-Gg: AZFdTZcwa8k+E3IVRR3/g4vvaPbTGMf5o2exmU8hb9PvGT2qsVLJGcrrZyn4KzS2BVV
 xi1H/YteuDokLF4EhRFBAm5N6Vryc2oWxn+DnPaN7EXWJWEEqOzNXqmoF6hix3mdGM/enZGf5f+
 GcTLoG/Iw8In5truMPXboSBYstRQ4ueP+PmG43SYuefiNgfJQNDQhlquRXocAPGM092RXfqrch8
 KxWtRBeRK10RQMWdP2qCn74kZog9A+TkIdnim1iSG99qHr/4Q5GzL9VzhWU2hO+jieNCEyavlIH
 CGr3nGzqWo3tfvs6dXkTUbo2wwZAYcXTO0lOXpLN2v1w2CbcbAP8MK3KYfVxzwIFaC+YONAzHtg
 jy6HZ7Hr5CGYEoiipgaa8+VHFqeJbRVGC5Kz/+3sZiC1vIq/KutqXLI/XgkbzjuQOYYLbU+PPze
 Ex026WMWZDksO3bUB6ay2dFLiTaDbuF9NMsH0YxW9u+lCztvWO2LRcwqMXV8eB6N5lUB12wPoEc
 LWaKG0ZTeVdUjhU3kHq59NQd1z/y0vU6sPlruD5p4W/5gLg/AMeSBDH6BoBf3nrcKQA2HL0rDx3
 2AMTAA+BOPQS6X3OrQ84srsDDPy/0hYNdgdpGs9xLe5qM7rSHURtx+52J4tGLs4JV5pIMI6e1d5
 5b6SzYJWE57DjRAJLassMR5nAIvMAdE4846hL5XLhE+dnWkWkk3TUtCCGSsV0+WNTj12KsAuDh4
 Sa0Y84ZRaOq0RX+KQxNkwc9PkVnrfhDtHMHhbuIxKZC2cXTZek1II/
X-Received: by 2002:a05:6820:55ca:20b0:71a:f042:196c with SMTP id
 006d021491bc7-71b394fcf85mr9162721eaf.52.1795545034913; 
 Tue, 24 Nov 2026 10:30:34 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863607d0f48sm1822683a34.7.2026.11.24.10.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:30:34 -0800 (PST)
Date: Tue, 24 Nov 2026 12:30:30 -0600
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
Subject: Re: [PATCH v2 4/8] soc: synaptics: add sl2610 system controller
 support
Message-ID: <20261124183030.GW3176972@bill-the-cat>
References: <20261123-sl2619_base-v2-0-9e3b28c77cda@bootlin.com>
 <20261123-sl2619_base-v2-4-9e3b28c77cda@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gyp979c1eRnWbSbr"
Content-Disposition: inline
In-Reply-To: <20261123-sl2619_base-v2-4-9e3b28c77cda@bootlin.com>
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


--gyp979c1eRnWbSbr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 03:22:03PM +0100, Richard Genoud (Synaptics) wrote:

> Introduce Synaptics sl2610 family system controller driver.
>=20
> The code is based on Linux driver by Jisheng Zhang:
> https://lore.kernel.org/lkml/20261115102401.3520-1-jszhang@kernel.org/
>=20
> Creates and binds the clock, reset and pin controller platform devices
> implemented by each SL2610 system control block.
> The platform device driver gets the block id (muc, soc, avio or cpu) as
> argument to select the appropriate private data.
>=20
> Signed-off-by: Richard Genoud (Synaptics) <richard.genoud@bootlin.com>
> ---
>  drivers/soc/Kconfig                   |   1 +
>  drivers/soc/Makefile                  |   1 +
>  drivers/soc/synaptics/Kconfig         |  11 ++++
>  drivers/soc/synaptics/Makefile        |   2 +
>  drivers/soc/synaptics/sl2610-syscon.c | 118 ++++++++++++++++++++++++++++=
++++++
>  include/soc/synaptics/sl2610-syscon.h |  23 +++++++
>  6 files changed, 156 insertions(+)
>=20
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index 8ef408d9ba1b..0d5990cdc381 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -50,6 +50,7 @@ config SOC_XILINX_VERSAL_NET
> =20
>  source "drivers/soc/qcom/Kconfig"
>  source "drivers/soc/samsung/Kconfig"
> +source "drivers/soc/synaptics/Kconfig"
>  source "drivers/soc/ti/Kconfig"
> =20
>  endmenu
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 00e6a5ac8e2b..de28c93160d5 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -5,6 +5,7 @@
>  obj-$(CONFIG_SOC_AMD_VERSAL2) +=3D soc_amd_versal2.o
>  obj-$(CONFIG_SOC_QCOM) +=3D qcom/
>  obj-$(CONFIG_SOC_SAMSUNG) +=3D samsung/
> +obj-$(CONFIG_SYNAPTICS_SL2619) +=3D synaptics/

This should be key'd off of SOC_SL2610_SYSCON instead.

--=20
Tom

--gyp979c1eRnWbSbr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawXXxgAKCRAr4qD1Cr/k
CrVUAPsHRUJqhWjZgIwhc6NzSQyP7TYR/3Iv/1uqCz3p5a58pAD/VnXUQHRLUAtD
FE+mTw1fO9+ZXkiMtCc9x0Vw8yB40AU=
=6Ul1
-----END PGP SIGNATURE-----

--gyp979c1eRnWbSbr--

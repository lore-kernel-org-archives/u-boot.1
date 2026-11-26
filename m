Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F3D606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0dCm11nx;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FolUR7CP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C497340A41;
	Thu, 26 Nov 2026 13:34:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9h0di1CnmL_L; Thu, 26 Nov 2026 13:34:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 22CCB40A4A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700052;
	b=EnbLmBLa9V1wAssSOwZ1flYo6qMEGyPCr91YwoEGx+1ynUEZIzmutVTKanB2xCpgnVCS
	 fuA4yFN0XFiAg12Oil5GuWyz/STjIJfHEzyQMG3PFSu+ZKcBJQWSjwDmpYSVhAvYAYMzW
	 oAlGEboQ+zainxUHa525bCB0ruFRfI5ISZ3Ise8Qz1dnOm0ZGsW7sgCfQdvR2IYmlmhVP
	 bk5Dqfv0rqYcFQ1lImfPu/V2rYpispmCvzD4lg6wZy2zc/W/cCzJp2hhcSsAb7R1k4gw3
	 WdS6mAAh0NtZNbyzhAZ7IY7zkGVHVO2R57pyVyI8uQt9zUNCrYjs1kp6PZLl7zBR4IQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700052;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-Cookie:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=piKvIjDDZyjq9V8NAy1XEffSC0I0u2YcXMSzZ01p6rM=;
	b=RPOpcObMJlvsMU90S/L0Htc362gTjuak4ecVdEBq83B7R+Hp7FBXbU4G7212eyf73g3s
	 bAlAndhsvfIUQtxwKDxGcjav/7qICoe5H5Yb/HRwWWr21cN4dqDrTRVRD0BY1h+8Feml0
	 XHI4Joo/Gm+ZpObk1d45TVjlqP5z1f2PU0kbjwvIHLM4BTjyDVgh8GMySZOlwzSYgkUOh
	 oMzV9/MJiOJgjbzA4lReA1R7mk3V2AzJ2iEUsgjhInbejQi5ft7IKdNhfvF1NGiTC6ePQ
	 jMKH91+IKW9GiZxUzs1e+/e+uy8whIFEJM4Zt0G7SvHVC2kzBTy66vp9wOxx46I7AwA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700052;
	bh=piKvIjDDZyjq9V8NAy1XEffSC0I0u2YcXMSzZ01p6rM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0dCm11nxryzP8eYvh1Wa5+pH93Utr24I9Wpb7i+RohH/KfaOUhlHNmglDkvtFkwkW
	 iAbV6oK/5o0ACUm3AHsdosom0XLQHhZEdX1jm+isIayyaCOtCdDpgUOpu1rh0wnrEx
	 QIer3dK2U3pUtS5gHAbHF2mBQv964iJCf/7Z/U9bufz3sX0XM/Sm3yaI+ZCGS9CTXM
	 pE16auLvg7IuT4h6c1RGBCw8vUmjFgiaeo+LaYNm/8o6eovQ/YxXsyP3rcDLN+8JmV
	 v4Td91ZnfHUnvgk9xwMcuawwxqXAqe4NngCoTvlNchhSNG8zfqs794cVLVboxSyGmF
	 oR3D7OvD75tTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22CCB40A4A;
	Thu, 26 Nov 2026 13:34:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 608D3311
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:05:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 51DEE608E4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:05:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M3nNgOJzjM5q for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:05:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6EB006066C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=broonie@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FolUR7CP
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6EB006066C
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:05:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9F02861274;
 Thu, 26 Nov 2026 12:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786811F000C4;
 Thu, 26 Nov 2026 12:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795694753;
 bh=piKvIjDDZyjq9V8NAy1XEffSC0I0u2YcXMSzZ01p6rM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FolUR7CPb+WngfnPzqfBgNawfGjYuT39YT/xOxiOqpStX4wIHT2zT8bzazE165qIa
 Xrtb3Hgsw+O3GEdoDRa9DTYMxa/e7P6ZqBj107wPw2hzKVTdjkArEQhk2yuVxhGxut
 ij2YQ5FubbPCxSK5IRwQ4RkZeaO6hSHLhhXa2XgWtPbOpdzyM23wn48nO53wIIO3Kr
 A1YNs2FZ4yj72sZJ3z5p/L/pFjhxcZIF3iabbe/Ezt7NK1rJTSgZYTIs7kHiQx67vS
 6+Dpl442jVXL58RCQajU0kxUkkVm89rGhNY9iSPiEDG9wyAgN8wuE8EO4/EFXAvBxT
 dX4D8Tewhl4oA==
Date: Thu, 26 Nov 2026 12:05:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, Daniel Golle <daniel@makrotopia.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Aleksei Sviridkin <f@lex.la>, Zunyi Hu <roberhu001@163.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Yuho Choi <oss.patchbox@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Akshay Belsare <akshay.belsare@amd.com>,
 Cooper Huang <cooper_huang@aspeedtech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Cole Munz <Munzzyy1@proton.me>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 1/6] spi: spi-mem: add spi-mem caps support
Message-ID: <4c89e6ba-6209-4a62-9e49-59dbcd0398c0@sirena.org.uk>
References: <20261117224236.3150882-1-mikhail.kshevetskiy@iopsys.eu>
 <20261117224236.3150882-2-mikhail.kshevetskiy@iopsys.eu>
 <0a795dd8-8beb-4c93-9dd5-2a13512f34eb@kontron.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CUlnuOGK+AK4z6me"
Content-Disposition: inline
In-Reply-To: <0a795dd8-8beb-4c93-9dd5-2a13512f34eb@kontron.de>
X-Cookie: Sank heaven for leetle curls.
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:33:17 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--CUlnuOGK+AK4z6me
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 26, 2026 at 09:13:20AM +0100, Frieder Schrempf wrote:
> On 17.11.26 23:42, Mikhail Kshevetskiy wrote:
> > This makes code more generic. Also it allows check for DTR support
> > and emit DTR operations only if it supported by the spi controller.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--CUlnuOGK+AK4z6me
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsIIJEACgkQJNaLcl1U
h9CINgf/W15qrum2ZHunq1xupN2J0lMq9YLRdAZco9dhjzwABR/58linv6Z1pz94
tlMpiYR+hilh1o2i/8OtuDrfPdFuFe/6eQAaKdz2Wth3P2d+tKrL5xE7V8zlluDn
Slb9cuQ5zaI7ZsiU7WXBiTiQcTGHiBw9nx5hgL2/aS4OHCewjBT0cqU5HugX7mJh
Hp13oqkPFNjcQFzmVh7tXyBJfqb5aqNTPZqIWKaOQTwd2bQhGr1LH2utUaAGK0J+
wupug4xm3WrXqx9LypbsCnzd5AnzhVoDN3teZt++wtAlCkVDIjwnatXRE1VUtgRN
CAWyjGrKsqOn7DsVAT/euCbTvX8kcg==
=QhKH
-----END PGP SIGNATURE-----

--CUlnuOGK+AK4z6me--

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF832CD3424
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 12:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C8A08460E;
	Fri,  1 May 2026 14:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=couthit.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=couthit.com header.i=@couthit.com header.b="UZ07d2X2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF29883E36; Fri,  1 May 2026 12:20:03 +0200 (CEST)
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E86384198
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 12:19:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=parvathi@couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
 ; s=default;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
 References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=g1K+N2fuaWlcHTM1FtV69LP2RMmBNA2w8ouMegDZbxA=; b=UZ07d2X296rp1AhVh1ok4X1ouO
 5UhVZeZZU3IHFQ4+D2EtaUSgjs9YKNWJ1ljSnTA/XNs54BeAWNU9USr8IHFMtLFR77CWkI/H6mbGu
 SboeXISg5Ui9Ky5PQRvHYzK3+6FaT8vcol7A/aBznhmejXrk1w7v/HdTso8ZOrbXNOxLCY/2oZ8IB
 AEGf3sIY2TEiFliZR3SD05SaOd7xRd36McKT92U+9F/ajd9MxG07tzmssGfIoCXw7gqB8RxeaTfwg
 jRA64LeS1OmgmV2UYUylRVkHwR4BHCQoWpsL+fVQ3HnyU9IOfdjXQSU3wEjA/e9qbs8GrbxOw/5xS
 Rc1iemmw==;
Received: from [115.246.246.98] (port=38472 helo=zimbra.couthit.local)
 by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <parvathi@couthit.com>)
 id 1wIkyN-00000000gh9-4B71; Fri, 01 May 2026 06:19:52 -0400
Received: from localhost (localhost [127.0.0.1])
 by zimbra.couthit.local (Postfix) with ESMTP id 40CD01A48E47;
 Fri,  1 May 2026 15:49:44 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 7g4YPlQPA5jh; Fri,  1 May 2026 15:49:42 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.couthit.local (Postfix) with ESMTP id BF60D1A48E46;
 Fri,  1 May 2026 15:49:42 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 33upqqUsDo-Z; Fri,  1 May 2026 15:49:42 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
 by zimbra.couthit.local (Postfix) with ESMTP id 9EBEB1A48E47;
 Fri,  1 May 2026 15:49:42 +0530 (IST)
Date: Fri, 1 May 2026 15:49:42 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Tom Rini <trini@konsulko.com>
Cc: Parvathi Pudi <parvathi@couthit.com>, u-boot <u-boot@lists.denx.de>, 
 Maarten Brock <Maarten.Brock@sttls.nl>, 
 kory maincent <kory.maincent@bootlin.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 sbellary <sbellary@baylibre.com>, 
 romain gantois <romain.gantois@bootlin.com>, 
 pratheesh <pratheesh@ti.com>, j-rameshbabu <j-rameshbabu@ti.com>, 
 praneeth <praneeth@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
 danishanwar <danishanwar@ti.com>, m-malladi <m-malladi@ti.com>, 
 krishna <krishna@couthit.com>, mohan <mohan@couthit.com>, 
 pmohan <pmohan@couthit.com>, basharath <basharath@couthit.com>
Message-ID: <239785101.1054803.1777630782561.JavaMail.zimbra@couthit.local>
In-Reply-To: <20260430211948.GA1717275@bill-the-cat>
References: <20260422123353.2902537-1-parvathi@couthit.com>
 <20260430211948.GA1717275@bill-the-cat>
Subject: Re: [PATCH v3] board: ti: am335x: Conditional MDIO PAD
 configuration instead of static for AM335_ICE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.10.10.233]
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC138
 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: board: ti: am335x: Conditional MDIO PAD configuration instead of
 static for AM335_ICE
Thread-Index: K8075A6gvVYzkjPJG2e1SoCRJR2HCQ==
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id:
 smtp@couthit.com
X-Authenticated-Sender: server.couthit.com: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Mailman-Approved-At: Fri, 01 May 2026 14:38:15 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

> On Wed, Apr 22, 2026 at 06:03:03PM +0530, Parvathi Pudi wrote:
>=20
>> This patch removes the static MDIO pinmux configuration from
>> rmii1_pin_mux[] and instead configures the MDIO pins conditionally
>> during board_init(). Previously, the MDIO_CLK and MDIO_DATA pins
>> were always configured for CPSW in mux.c, which could lead to
>> unnecessary pin ownership and conflicts in scenarios where CPSW
>> is not used.
>>=20
>> With this change, the MDIO pins are configured only when required,
>> ensuring that CPSW Ethernet functionality in U-Boot remains unaffected.
>> This approach keeps Ethernet boot behavior intact and provides cleaner
>> separation between CPSW and other Ethernet use cases.
>>=20
>> Reviewed-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
>> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
>=20
> This leads to failure to build on:
> am335x_evm_spiboot am335x_hs_evm am335x_hs_evm_spi am335x_hs_evm_uart
>=20

We tested the patch locally with the mentioned defconfigs (am335x_evm_spibo=
ot,
am335x_hs_evm, am335x_hs_evm_spi, am335x_hs_evm_uart), and we get the follo=
wing
warning:

=E2=80=98rmii1_mdio_pin_mux=E2=80=99 defined but not used [-Wunused-variabl=
e]

Are you referring to this warning or do you see any other build errors?

Thanks and Regards,
Parvathi

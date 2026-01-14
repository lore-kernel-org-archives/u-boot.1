Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F285ED31A25
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 08:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91FF1835B3;
	Wed, 14 Jan 2026 09:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="nNCQ8Ciw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F03DB836D3; Wed, 14 Jan 2026 09:30:20 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19587830A0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 09:30:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=Q0NatM9xgpu06Rs7KWfJy4wYJrXSVsH/f13Kan+Viz4=; b=nNCQ8Ciwn79pUKfF4prsS/vIsv
 KzkYhJ/VOZ4PRoE+9awOz1Sdj3fCfqCc0bhK7TaOE8scHmWR5yj8QkOAs4ozkO7oCAv+q+M3hdQ7r
 b3NtQTx8TsNwb1ig+9UZ3bypUhKmLEf4rjhygJYaEuu5k7censxLF32bfed1TbBi7HmBgm5yRaRJ6
 grG4ZE5nZJhZT4yoSKxkRPoUds2QGY0MTJu/SJLZDJo3FmOTDcexC23Dwcrp12vQFl3bIOYT28+dR
 goDHYkJ/BBq3KXmW54DiFnI0FUOXNHSUOXSEGW+gPs8vJJSOC4FPRvhbT6cpIsnT7guLjR91O+ebY
 JwaN8mJg==;
Received: from i53875b96.versanet.de ([83.135.91.150] helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1vfwGf-002G2o-1a; Wed, 14 Jan 2026 09:30:17 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
Cc: trini@konsulko.com, u-boot@lists.denx.de
Subject: Re: [PATCH 00/12] board: qnap-ts433: Cleanups + add support for TS233
Date: Wed, 14 Jan 2026 09:30:17 +0100
Message-ID: <7897491.nlapOpYt14@diego>
In-Reply-To: <20260105194723.2928608-1-heiko@sntech.de>
References: <20260105194723.2928608-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Am Montag, 5. Januar 2026, 20:47:11 Mitteleurop=C3=A4ische Normalzeit schri=
eb Heiko Stuebner:
> This series does a number of cleanups for the existing TS433 NAS,
> and also introduces support for a second device.
>=20
> Right now the code can detect the variant from the I2C eeprom(s) and
> set the fdtfile accordingly. Later on (once I figured out what is needed)
> this should also select an optional overlay, because later model-variants
> do have additional per-disk presence detection and also regulator-handling
> that is not present on the earlier versions.
>=20
> Heiko Stuebner (12):
>   rockchip: board: qnap-ts433: Fix TPL binary in build-example
>   rockchip: board: qnap-ts433: drop DW_MMC config options
>   rockchip: board: qnap-ts433: Fix dir naming to allow build-system to
>     find it
>   rockchip: board: qnap-ts433: Update documentation to recent tool
>     versions
>   rockchip: board: qnap-ts433: Add instructions for how to use upstream
>     TF-A
>   rockchip: board: qnap-ts433: Support multiple models of the TSx33
>     family

I've updated the board-ident parsing in v2 to support all the types
of identifiers used in the fielt (there are 3 different types)


Heiko



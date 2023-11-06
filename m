Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2A4C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 14:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A30287091;
	Mon,  6 Nov 2023 15:35:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="n805Usw9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86C9687092; Mon,  6 Nov 2023 15:35:01 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 667028708A
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 15:34:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A6EYqL9023092;
 Mon, 6 Nov 2023 08:34:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699281292;
 bh=hfgRuPuD5nYLJyL1GLQpQqVbYMBivICVdgJoZwXajVM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=n805Usw90l3EEEdRJ5NwcAYB/5znnIhPasgrS+zHPLrx89Ar+PksstHnrB3cofgzk
 udm4ewe0jruLISzpw5h7hrW0Wtl3icPXm3XcRLvPZ/wlckRpj6B9w3ZpzLQP3fBIjO
 3azIundlHzPqoTkkWTaVlX/bZjSCIEsEunn/kuK4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A6EYqLe103055
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Nov 2023 08:34:52 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Nov 2023 08:34:51 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Nov 2023 08:34:52 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A6EYpZF081777;
 Mon, 6 Nov 2023 08:34:51 -0600
Date: Mon, 6 Nov 2023 08:34:51 -0600
From: Bryan Brattlof <bb@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sinthu Raja <sinthu.raja@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Reid Tonking <reidt@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Simon Glass <sjg@chromium.org>, Robert Nelson
 <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, <u-boot@lists.denx.de>,
 <praneeth@ti.com>
Subject: Re: [PATCH 1/5] arm: dts: k3-am625-beagleplay-u-boot/r5: Just depend
 on k3-binman.dtsi
Message-ID: <20231106143451.w7qqaisbx34zqtlr@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231104080137.9628-1-nm@ti.com> <20231104080137.9628-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20231104080137.9628-2-nm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Nishanth!

On November  4, 2023 thus sayeth Nishanth Menon:
> With the upcoming folder separation, there is no further need to depend
> on am625-binman.dtsi. Duplicate the existing definitions to u-boot.dtsi
> and r5.dts as appropriate.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Bryan Brattlof <bb@ti.com>

> ---
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 160 +++++++++++++++++--
>  arch/arm/dts/k3-am625-r5-beagleplay.dts      |  39 +++++
>  2 files changed, 184 insertions(+), 15 deletions(-)

...

> -&spl_am625_sk_dtb_unsigned {
> -	filename = SPL_AM625_BEAGLEPLAY_DTB;
> -};
> +	ti-spl_unsigned {
> +		filename = "tispl.bin_unsigned";

If all of the beagle-plays are using the GP security variant shouldn't 
we remove the _unsigned?

> +		pad-byte = <0xff>;
> +

...

> -&am625_sk_dtb_unsigned {
> -	filename = AM625_BEAGLEPLAY_DTB;
> +	u-boot_unsigned {
> +		filename = "u-boot.img_unsigned";

And here? I don't really have an opinion either way. Just curious if 
we've thought about that.

> +		pad-byte = <0xff>;
> +

~Bryan


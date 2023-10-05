Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB56EE7B614
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 17:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA3CF86C78;
	Thu,  5 Oct 2023 19:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vkh9YfZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E84186C79; Thu,  5 Oct 2023 19:04:38 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AC8086B58
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 19:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 395H4W45077785;
 Thu, 5 Oct 2023 12:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696525472;
 bh=q+pkRcLvyBJ/P9/CId2WSvNYhsSjqH2QJ6yeATC3JEg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=vkh9YfZTZqkz5tVVU+lvTDNHVeLBtsHJE8VqnuAWzIJUbpfhgYJnROsOF/xfNBKV5
 iX8iTs7hU27x30rhPUItEJ7o/4ms8o3YVx/AOGRu5/CcDX1m6aQhee5OnDKsTNSmYv
 A2VPP4QvxkYZQgH0I/rbhNW7ts4upH2wEMiaLcEs=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 395H4V6F010556
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 5 Oct 2023 12:04:32 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 12:04:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 12:04:31 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 395H4VVg030266;
 Thu, 5 Oct 2023 12:04:31 -0500
Date: Thu, 5 Oct 2023 12:04:31 -0500
From: Nishanth Menon <nm@ti.com>
To: reidt <reidt@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>
Subject: Re: [PATCH v4 2/2] arm: dts: j7200: dts sync with Linux 6.6-rc1
Message-ID: <20231005170431.razxwweozepsweft@stagnate>
References: <20231004165629.506664-1-reidt@ti.com>
 <20231004165629.506664-3-reidt@ti.com>
 <20231005113336.tysphzl4dvc65oks@litigate>
 <20231005140426.44wnkiguqa2agb25@reidt-HP-Z2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231005140426.44wnkiguqa2agb25@reidt-HP-Z2>
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

On 09:04-20231005, reidt wrote:
[...]
> > > -	clk_200mhz: dummy_clock_200mhz {
> > > -		compatible = "fixed-clock";
> > > -		#clock-cells = <0>;
> > > -		clock-frequency = <200000000>;
> > > -		bootph-pre-ram;
> > > +		bootph-all;
> > 
> > Here and else where in the r5 file: why switch from pre-ram to bootph-all
> > ? dont we need these prior to ddr initialization?
> >
> 
> Due to the change in how booth-pre-ram works [0], bootph-pre-ram alone no
> longer works. U-boot docs Pre-Relocation Support section says some-ram
> can be used for u-boot prior to reloc, but not spl. So like Massimo
> mentioned in the linked discussion, some-ram + pre-ram can work, as well
> as -all. Outside of affecting the TPL phase, I'm not sure I know of a
> difference in regards to how it affects pre-ddr.
> 
> 
> [0]: https://lore.kernel.org/u-boot/CAPnjgZ3MgWX8T0A0SofphEr_Xd77pE3hte9DNye1RuBVeB9N8Q@mail.gmail.com/
> 

Also see:
https://github.com/u-boot/u-boot/commit/0cb6515cdab483ce8b30680803cbed0a63044cdc
https://github.com/u-boot/u-boot/commit/7e5b6f1cff846218b824a4d906e2831c15864a53
https://lore.kernel.org/all/3376a0eb-57f4-416a-b4b8-86cee769d6eb@siemens.com/
etc..

as a rule of thumb: u-boot.dtsi uses bootph-all; r5-xyz.dts uses booth-pre-ram

Where this failed completely is when A53 started using booth-pre-ram in
which case the u-boot stages failed on A53 side.

The rule of thumb I explained works across silicon (bar other issues).

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

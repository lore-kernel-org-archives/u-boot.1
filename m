Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CABEEB560
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 17:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2210186A35;
	Fri,  8 Sep 2023 19:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G9SD9CMu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D60DF86A97; Fri,  8 Sep 2023 19:36:22 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01C97863F9
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 19:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 388HaHZE075428;
 Fri, 8 Sep 2023 12:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694194577;
 bh=mOhkLAkmUmQtnA9wd2mRixEFLKfFkeCCDiNT2A+M574=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=G9SD9CMuTgK2KR+S+GLOu20Zck3lc9wSHlUOpwODjvKu82E1Eo1LRmdJL28JKMLz9
 CVHpk0SU3aW16nXPsb1XNdgQpQ3yQN4SLjJmM+mWjiOH9RLd96n+B7u2l5f6HMbkE8
 H2rN4OOUTiEFrzY9+8kExPGOLNWevMjbViuIpKEk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 388HaHOC041350
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Sep 2023 12:36:17 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 12:36:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 12:36:17 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 388HaH2b025098;
 Fri, 8 Sep 2023 12:36:17 -0500
Date: Fri, 8 Sep 2023 12:36:17 -0500
From: Nishanth Menon <nm@ti.com>
To: Trevor Woerner <twoerner@gmail.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Pierre Lebleu
 <pierre.lebleu@pile-engineering.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH] ARM: dts: am335x-pocketbeagle: choose tick-timer
Message-ID: <20230908173617.7c2xto3n4hqltnf2@ferris>
References: <20230830152553.15465-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230830152553.15465-1-twoerner@gmail.com>
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

On 11:25-20230830, Trevor Woerner wrote:
> Commit 4b2be78ab66c ("time: Fix get_ticks being non-monotonic")
> requires '/chosen/tick-timer' in device-tree. Otherwise we get:
> 
> 	U-Boot 2023.07.02 (Jul 11 2023 - 15:20:44 +0000)
> 
> 	CPU  : AM335X-GP rev 2.1
> 	Model: TI AM335x PocketBeagle
> 	DRAM:  512 MiB
> 	Core:  154 devices, 16 uclasses, devicetree: separate
> 	Could not initialize timer (err -19)
> 
> 	resetting ...
> 
> Suggested-by: Pierre Lebleu <pierre.lebleu@pile-engineering.com>
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  arch/arm/dts/am335x-pocketbeagle.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/dts/am335x-pocketbeagle.dts b/arch/arm/dts/am335x-pocketbeagle.dts
> index b379e3a5570d..02e3aac56064 100644
> --- a/arch/arm/dts/am335x-pocketbeagle.dts
> +++ b/arch/arm/dts/am335x-pocketbeagle.dts
> @@ -15,6 +15,7 @@
>  
>  	chosen {
>  		stdout-path = &uart0;
> +		tick-timer = &timer2;
>  	};
>  
>  	leds {
> -- 
> 2.41.0.327.gaa9166bcc0ba
> 

Does enabling CONFIG_SYS_ARCH_TIMER solve this?


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

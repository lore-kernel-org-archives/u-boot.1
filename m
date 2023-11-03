Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3514C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 19:06:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18E7587239;
	Fri,  3 Nov 2023 20:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Uvq4jbCP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D43B8708D; Fri,  3 Nov 2023 20:06:44 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73C3087239
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 20:06:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A3J6Thq122195;
 Fri, 3 Nov 2023 14:06:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699038389;
 bh=28uZJ3qDf/fRgPLwKF+pbr8VXBBmlIYo5D39+99PlcM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Uvq4jbCPBniFgdtOCd2BFOa06gCo/ho+NENj7FFfy4tPWYcK3QWOLxvmkwWs+cvc1
 +Axwy0/BIr+xOrxMMXQUUyrt9BywSs3j7ybq97A/hLgDYM0G7fQhIHd1VEqvbX1JKs
 ao5wgVBcdJcH2Zju5sjFJ4Wbax6qQ8rnyPOJqBP8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A3J6Tnt123827
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 3 Nov 2023 14:06:29 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 Nov 2023 14:06:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 Nov 2023 14:06:29 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A3J6Tvt012626;
 Fri, 3 Nov 2023 14:06:29 -0500
Date: Fri, 3 Nov 2023 14:06:29 -0500
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sinthu Raja <sinthu.raja@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Reid Tonking <reidt@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 14/15] board: ti: Add j721e_beagleboneai64_* config
 fragments and env file
Message-ID: <20231103190629.flhz4cr5wyjyym2g@remix>
References: <20231103003805.2420005-1-nm@ti.com>
 <20231103003805.2420005-15-nm@ti.com>
 <f0f4b6af-9831-4231-8316-1e0b0dd2dab2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f0f4b6af-9831-4231-8316-1e0b0dd2dab2@ti.com>
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

On 13:51-20231103, Andrew Davis wrote:
> On 11/2/23 7:38 PM, Nishanth Menon wrote:
> > Add defconfig fragments for J721E based BeagleBone AI-64 and
> > corresponding customized environment.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >   board/ti/j721e/beagleboneai64.env        | 19 ++++++++
> >   board/ti/j721e/beagleboneai64_a72.config | 55 ++++++++++++++++++++++++
> >   board/ti/j721e/beagleboneai64_r5.config  | 19 ++++++++
> 
> Beagle boards are not TI boards, add the board support to board/beagle/

Huh, why bring in commercials and organization changes here? am335x
and am62 are under the TI umbrella.

$ git grep beagle board/|cut -d ':' -f1|sort -u
board/ti/am335x/board.c
board/ti/am335x/board.h
board/ti/am57xx/board.c
board/ti/am62x/beagleplay_a53.config
board/ti/am62x/beagleplay_r5.config
board/ti/am62x/MAINTAINERS
board/ti/beagle/beagle.c
board/ti/beagle/Kconfig
board/ti/beagle/led.c
board/ti/beagle/MAINTAINERS
board/ti/beagle/Makefile
board/ti/j721e/beagleboneai64_a72.config
board/ti/j721e/beagleboneai64_r5.config
board/ti/j721e/MAINTAINERS
board/timll/devkit8000/README

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

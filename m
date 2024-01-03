Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66364C47073
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 17:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D1F3876F8;
	Wed,  3 Jan 2024 18:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="txtqdU14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3783B87705; Wed,  3 Jan 2024 18:36:52 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF5A586EE2
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 18:36:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 403Hac0g056207;
 Wed, 3 Jan 2024 11:36:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704303398;
 bh=YLrR8u5e5jB/+f164Etve7j6Fd2R238b4xEhY0/Mv10=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=txtqdU14BBiJNXufmTeP4cFSyLfiethVSF1NJaJWAYm4sQZo0Kb7aMJKrOMXvYgsJ
 W03DxGdvziKvu1OnFaWJ/0EatUm9yFU/4DvO+TRktGeWfuO0zg9rPfqAZmETNYLd8P
 y5ro2X7GgLmPMNmySPRYjIw8ldE1yUSN1H1ML75E=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 403HacUX034635
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Jan 2024 11:36:38 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Jan 2024 11:36:37 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Jan 2024 11:36:37 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 403HabSf005103;
 Wed, 3 Jan 2024 11:36:37 -0600
Date: Wed, 3 Jan 2024 11:36:37 -0600
From: Nishanth Menon <nm@ti.com>
To: Apurva Nandan <a-nandan@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha
 Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Andrew
 Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Roger Quadros
 <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>,
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v7 09/17] board: ti: j748s4: Add board config yaml files
Message-ID: <20240103173637.fdhfwgmsmqrfpzdp@manmade>
References: <20231219191537.4039361-1-a-nandan@ti.com>
 <20231219191537.4039361-10-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231219191537.4039361-10-a-nandan@ti.com>
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

On 00:45-20231220, Apurva Nandan wrote:
> Add board-cfg, rm-cfg, pm-cfg, sec-cfg, tifs-rm-cfg yaml for buidling
> u-boot sysfw data.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  board/ti/j784s4/board-cfg.yaml   |   37 +
>  board/ti/j784s4/pm-cfg.yaml      |   13 +
>  board/ti/j784s4/rm-cfg.yaml      | 3058 ++++++++++++++++++++++++++++++
>  board/ti/j784s4/sec-cfg.yaml     |  380 ++++
>  board/ti/j784s4/tifs-rm-cfg.yaml | 2656 ++++++++++++++++++++++++++
>  5 files changed, 6144 insertions(+)
>  create mode 100644 board/ti/j784s4/board-cfg.yaml
>  create mode 100644 board/ti/j784s4/pm-cfg.yaml
>  create mode 100644 board/ti/j784s4/rm-cfg.yaml
>  create mode 100644 board/ti/j784s4/sec-cfg.yaml
>  create mode 100644 board/ti/j784s4/tifs-rm-cfg.yaml
> 

Cursory review.. but btw, when I run:
$ yamllint board/ti/j784s4/rm-cfg.yaml

it throws a bunch of warnings, but it does the same for other yamls as
well. Not sure it was supposed to be yamlinted - Neha? Might be good
idea than manual review to ensure some basic checks are done?

Either way,

Reviewed-by: Nishanth Menon <nm@ti.com>


Ref - I used yamllint 1.26.3
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

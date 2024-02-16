Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E4FC48BC4
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 15:59:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5896287C45;
	Fri, 16 Feb 2024 16:59:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yTlCfi5G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1076187C45; Fri, 16 Feb 2024 16:59:00 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4552687C68
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 16:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41GFwdXC130975;
 Fri, 16 Feb 2024 09:58:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708099119;
 bh=vatiUXfK7n0K/vAVD/5OR9evmfKmH/sspTwfOwdXoy4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=yTlCfi5G1G3qgWBtfiErKSzEgI/DOihyQVa+c5z4QV1lvOMpXMegkPcXbjjIEUuU2
 IrJrvxnL1vdBF5sh7To8AY1bKLFq2tYJa2/b3Cj/OaWpTXoCWoeSAkvcAOTSu3o6YC
 1rJ0c6XN5j0mzeYfclXn40SMUoicUffRR9S/AeM0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41GFwdLf071096
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 16 Feb 2024 09:58:39 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Feb 2024 09:58:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Feb 2024 09:58:38 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41GFwcdF098576;
 Fri, 16 Feb 2024 09:58:39 -0600
Date: Fri, 16 Feb 2024 09:58:38 -0600
From: Nishanth Menon <nm@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, Andrew Davis
 <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Roger Quadros
 <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>,
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v8 12/16] arm: dts: Introduce j784s4 u-boot dts files
Message-ID: <20240216155838.nccgrnojkzxkdacq@riverbank>
References: <20240119175043.3904751-1-a-nandan@ti.com>
 <20240119175043.3904751-13-a-nandan@ti.com>
 <20240119191743.xtxtuhnmhw7eq662@bonus>
 <f7cd5cbe-7c14-429e-b5c1-9f994f3ea4f7@ti.com>
 <20240123205255.i7eynu6vdpoxwybf@irregular>
 <d7298f55-c565-457b-a9b5-52980ae63f1e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d7298f55-c565-457b-a9b5-52980ae63f1e@ti.com>
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

On 14:33-20240215, Neha Malcom Francis wrote:
[...]

> > if the templates are abstract enough, the additional code will be so
> > minimal that we wont need a board-binman.dtsi - just u-boot.dtsi and
> > r5.dtsi can include the relevant templates.
> > 
> > Hope this helps.
> 
> 
> So I took a stab at working on this for couple of days, a fix was needed
> within the tool to allow binman to handle multiple consecutive templates
> which is needed here etc. which is why it did not work as is; but the built
> binaries are still not stable for boot. I think this will need some
> additional work and debugging. As of now, templating is not widely used, so
> I'm guessing some more minor fixes would be needed to get it building as we
> intend.
> 
> If you are okay, I think we can take this series as is for now, I will take
> action to start off a series cleaning up and using templating for all the
> devices.

Sure, as long you can do this by the next window.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

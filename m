Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E355C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 14:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34539870BC;
	Tue, 14 Nov 2023 15:54:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fN3wP3q4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D525C868AE; Tue, 14 Nov 2023 15:53:58 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E35AE871FC
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 15:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AEErfN0107642;
 Tue, 14 Nov 2023 08:53:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699973621;
 bh=sseGPd8O2fTnYklywowD4KqhJNGvfKPT4tznwylktTo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=fN3wP3q4ZQaT4tq+TJatRiDrE90eNB/SqN0xfO3WNsnxpiImI9HOP3eNlqv/oCu9g
 HlpvnALGQeSxSin1mJrNgmzD8D3THLZhRlL6k8L0BKxge+NUlB2wk6qMkItl2gzgHy
 xhNOeWmSUoEPiWErTfDMl5gjRqOGpvSTl4GN/EwY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AEErfFw086839
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 14 Nov 2023 08:53:41 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 Nov 2023 08:53:41 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 Nov 2023 08:53:40 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AEEreZj097131;
 Tue, 14 Nov 2023 08:53:40 -0600
Date: Tue, 14 Nov 2023 08:53:40 -0600
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: Marcel Ziswiler <marcel.ziswiler@toradex.com>, Tom Rini
 <trini@konsulko.com>, Neha Malcom Francis <n-francis@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Jai Luthra <j-luthra@ti.com>, <u-boot@lists.denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Sjoerd Simons
 <sjoerd@collabora.com>, Robert Nelson <robertcnelson@gmail.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 3/4] arm: dts: k3-am625-beagleplay-u-boot: drop duplicate
 bootph-nodes
Message-ID: <20231114145340.6f74stumstihmpnu@snowiness>
References: <20231113145919.1928812-1-nm@ti.com>
 <20231113145919.1928812-4-nm@ti.com>
 <20231114033326.l5zmqdyzogm5mozw@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231114033326.l5zmqdyzogm5mozw@dhruva>
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

On 09:03-20231114, Dhruva Gole wrote:
[...]

> >  #ifdef CONFIG_TARGET_AM625_A53_EVM
> >  
> >  #define SPL_AM625_BEAGLEPLAY_DTB "spl/dts/k3-am625-beagleplay.dtb"
> 
> You didn't talk about this in the commit message?

There is nothing changing in this patch here.


-- 
Regards,
Nishanth Menonh
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

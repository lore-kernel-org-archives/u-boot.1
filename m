Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59EFCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 15:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0693C86BB3;
	Mon, 16 Oct 2023 17:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rCvgucMU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CDE986AE9; Mon, 16 Oct 2023 17:52:28 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 156F586D4A
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 17:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39GFqAi7039369;
 Mon, 16 Oct 2023 10:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697471530;
 bh=X8i3lB1xZ8bcyDTdvbdTsZ5s7fhJcSfvs4FDRa2P4gc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=rCvgucMUs5DeHOE9YSUFj3ohsxmTFulA5Q852uxg7mS6iDyxdvoBc3+4di1vdqBmU
 +eDXmIlV8zvu8uHNXn2mfuTsGIx8M9IH6fmxuGEr+fnRA6jPqIYubep4XMIxsaIXcy
 scf2FMUHKs0jJd8Xzq2fSLX00NjAQckLKc6Xpt9M=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39GFqAjj093734
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 16 Oct 2023 10:52:10 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Oct 2023 10:52:10 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Oct 2023 10:52:10 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39GFqAmE000879;
 Mon, 16 Oct 2023 10:52:10 -0500
Date: Mon, 16 Oct 2023 10:52:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Hari
 Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, UBoot Mailing
 List <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH 00/11] Introduce basic support for TI's AM62Px SoC family
Message-ID: <20231016155210.22rlldfh56pjwc23@designed>
References: <20231012230616.2101992-13-bb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231012230616.2101992-13-bb@ti.com>
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

On 18:06-20231012, Bryan Brattlof wrote:
> Hello Everyone!
> 
> The AM62Px is an extension of the existing Sitara AM62x low-cost family
> of application processors built for Automotive and Linux Application
> development. Scalable Arm Cortex-A53 performance and embedded features,
> such as: multi high-definition display support, 3D-graphics
> acceleration, 4K video acceleration, and extensive peripherals make the
> AM62Px well-suited for a broad range of automation and industrial
> application, including automotive digital instrumentation, automotive
> displays, industrial HMI, and more.
> 
> Some highlights of AM62P SoC are:
> 

This is Nice, BUT, I suggest cleaning up AM65 and AM62A prior to
attacking AM62P.

I would like to see:
a) dt sync
b) maintain the bootph - so that the boards finally boot
c) switch to stdboot.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

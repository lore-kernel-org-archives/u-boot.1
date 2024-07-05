Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C0BC3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 15:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB4968861A;
	Fri,  5 Jul 2024 17:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Vux0Vveg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA0B888621; Fri,  5 Jul 2024 17:18:02 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B20968839D
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 17:18:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 465FHrQK036655;
 Fri, 5 Jul 2024 10:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720192673;
 bh=75tzrt1VxFEA3U0W53muiGcdrmuxWvKOFu/vOJrxFwA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Vux0VvegP3TEeMGhD7HSsjG8xDlW7PMOKWmCx+czgvOandx27OXm456MjljbTC7LU
 f1Gy04LT2N5P6WNm65PP/YVN2bzOv3SqqcKDAusXb9QTeHs7U6iNXdPYmt0lpKQt86
 Zo9MAplRA19+D5xnhTDLP4yWndMbXaY9ZhChQcAk=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 465FHriH064647
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 5 Jul 2024 10:17:53 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jul 2024 10:17:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jul 2024 10:17:53 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 465FHrJ2111714;
 Fri, 5 Jul 2024 10:17:53 -0500
Date: Fri, 5 Jul 2024 10:17:53 -0500
From: Nishanth Menon <nm@ti.com>
To: Sebin Francis <sebin.francis@ti.com>
CC: Dhruva Gole <d-gole@ti.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>,
 <c-shilwant@ti.com>, <m-chawdhry@ti.com>, <vigneshr@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>,
 Vibhore Vardhan <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>
Subject: Re: [PATCH V3 0/4] Low Power Mode: Pakage TIFS Stub on BeaglePlay
Message-ID: <20240705151753.7v3geqkupqu673x3@ambiance>
References: <20240628093252.1864609-1-d-gole@ti.com>
 <20240628130323.vxy7rruh3bdcklxe@brownnose>
 <067d0bd4-867f-4d48-8852-f5d8e04ffc2a@ti.com>
 <20240628174008.tjdhwvzj7mxaka6z@destruct>
 <7769855e-8e08-47c0-b4a0-a466f44044de@ti.com>
 <20240701152419.zptqmwrqcwabyrx3@lethargic>
 <629315ea-8198-45af-bf92-6a6e7860e1df@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <629315ea-8198-45af-bf92-6a6e7860e1df@ti.com>
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

On 17:31-20240703, Sebin Francis wrote:
> 
> On 01/07/24 20:54, Nishanth Menon wrote:
> > On 15:25-20240701, Sebin Francis wrote:
> > > For HS-FS device we need to sign the fs-stub with customer key. DM firmware
> > > cannot have a component which is signed using customer key.
> > Please explain please why DM cannot have a component signed using a
> > customer key for the public record?
> 
> 
> For HS device customer is owning the customer key and only customer
> 
> has the access for the customer key. Because of this the signing has to
> happen
> 
> from the customer side.
> 
> DM is release by TI, Since TI doesn't have access to the customer key it
> cannot
> 
> have a component that is signed by customer key.

please resubmit the series with this documented in documentation and
commit message.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

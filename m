Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73F8C52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 12:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34BC888360;
	Tue, 13 Aug 2024 14:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gUDxpxM2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A02F888842; Tue, 13 Aug 2024 14:52:50 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F72987E30
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 14:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47DCqkpC122916;
 Tue, 13 Aug 2024 07:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723553566;
 bh=R5BgH0GfCbduqb0jfjGI5Xyu/i0pp7gLhXT4Sn8oaPg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=gUDxpxM21vwB1XwERVwmR7nNOOezRDgLLcMR6PFIFo7jeybfkTrHJLqvNu/xblizO
 F0Ge2rcDxkcEzImNsSE+KtchuPjxqq0XbmAfP1qNac26GMElikmRYgeCISt7BxtjtA
 AFXIwk/f06QICWK5AWbEYSdf6s164WGaoJrJ8Bbs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47DCqkef099579
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 13 Aug 2024 07:52:46 -0500
Received: from lewvowa01.ent.ti.com (10.180.75.79) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 07:52:45 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by lewvowa01.ent.ti.com
 (10.180.75.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Tue, 13 Aug
 2024 07:52:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 07:52:45 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47DCqjIr119230;
 Tue, 13 Aug 2024 07:52:45 -0500
Date: Tue, 13 Aug 2024 07:52:45 -0500
From: Nishanth Menon <nm@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Sumit Garg <sumit.garg@linaro.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: OF_UPSTREAM vs. additional dtbs
Message-ID: <20240813125245.ezlu6me3ljwx6dkj@margarine>
References: <7765273f-7f36-41e4-a604-1901e4fbec62@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7765273f-7f36-41e4-a604-1901e4fbec62@siemens.com>
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

On 11:16-20240813, Jan Kiszka wrote:
> Hi all,
> 
> I'm trying to migrate the TI AM65x IOT2050 boards to OF_UPSTREAM but I'm
> facing issues because I need to still build the u-boot-only overlays. It
> is also a bit weird (but works) having to specify
> 
> CONFIG_SPL_OF_LIST="../../../../arch/arm/dts/k3-am65-iot2050-spl"
> 
> for our spl dtb.
> 
> Are there means to still build certain dtb[o] files in arch/<arch>/dts?
> I'm a bit lost in the Makefile forest.
> 

Sumit: Any suggestions?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

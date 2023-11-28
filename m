Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6095C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 21:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2882787776;
	Tue, 28 Nov 2023 22:16:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wQTEa62D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EB0B87776; Tue, 28 Nov 2023 22:16:51 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26A39876D7
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 22:16:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ASLGjam004121
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 15:16:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701206205;
 bh=IVuELNGEtJyCrW1zAUgSetvsmXkz1v/5UY4wAvuK/hg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=wQTEa62D73O6tIJ4pqOHou+QgnJY41om7eETfdT1fgVAcKOWSFRgh6in7cfUvktOS
 hGbMLWsiTIV6dIhMZyaLJK2l2lSyWqkPVinAfPOIFEX6+dAuWdNpfm8WcO2wd9d5DK
 cEka0WxqWAO/CPvzP8JsSyVwwigMxhFJN7k1fdlw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ASLGjqW082802
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 15:16:45 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Nov 2023 15:16:45 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Nov 2023 15:16:45 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ASLGjjD004852;
 Tue, 28 Nov 2023 15:16:45 -0600
Date: Tue, 28 Nov 2023 15:16:45 -0600
From: Nishanth Menon <nm@ti.com>
To: Vishal Mahaveer <vishalm@ti.com>
CC: <u-boot@lists.denx.de>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan
 Brattlof <bb@ti.com>, Praneeth Bajjuri <praneeth@ti.com>
Subject: Re: [PATCH 0/4] board: ti: Update to latest board configuration
Message-ID: <20231128211645.cfgktxv2yxsoibjg@hurricane>
References: <20231128194024.20809-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231128194024.20809-1-vishalm@ti.com>
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

On 13:40-20231128, Vishal Mahaveer wrote:
> This patch series brings in the latest board configurations for
> am62 and am62a device.
> 
> Patch "board: ti: am62x/am62ax: Update virtual interrupt allocations
> in board config" is needed for booting with the latest TIFS and DM
> firmware [1].
> 
> [1] https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/log/?h=ti-linux-firmware
> SHA: e891ddc65c55bfa7111e4f45834b7c26444dff72
> 
> 
> U-boot boot log - https://gist.github.com/vishalmti/6b38fb80d557478131d5aaed5aeb3596
> 
> 
> Vishal Mahaveer (4):
>   board: ti: am62x/am62ax: Formatting updates to board config files
>   board: ti: am62ax: Add C7x resource allocation entries to board config
>   board: ti: am62x/am62ax: Update MCU GPIO interrupt allocation in board
>     config
>   board: ti: am62x/am62ax: Update virtual interrupt allocations in board
>     config
> 
>  board/ti/am62ax/rm-cfg.yaml | 522 +++++++++++++++---------------------
>  board/ti/am62x/rm-cfg.yaml  | 481 +++++++++++++--------------------
>  2 files changed, 396 insertions(+), 607 deletions(-)


Sorry, but this is completely confusing. There is no documentation to
indicate there is backward compatibility break in firmware. do all
users need to upgrade firmware along with board config updates?? what
is the minimum firmware version that is supported? is there an ABI
version check that should be enforced?

Is there absolutely no way for people to use the new firmware and keep
their old u-boot? Rather disappointing to see backward compatible
breakage occurring this stage of the device. This is not appreciated.

Please see if you can fix your firmware to maintain compatibility (as
has been the case for year+ now)

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A6FC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 18:52:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4ED58798A;
	Tue,  2 Jan 2024 19:52:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="y1VoKyFx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BDD087968; Tue,  2 Jan 2024 19:52:35 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E2A08798F
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 19:52:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 402IqSMw104915;
 Tue, 2 Jan 2024 12:52:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704221548;
 bh=K/NU3tijazv/ep9Z1AzHMbB6WmrR8kkVJNqUIFyCFiI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=y1VoKyFx7ktpev1va3lqeZwIlu+om8Jqww9gCJB2jtTgTWaVOw9Ru1lrHLkMrXRRF
 Oir15p2P/zAoj13vOl5A1VN+RA5HLr+Wd3iV0ZCMHcNs+ptZL12aVlyOLERhrvoA88
 sfe3YksWCgec1qcO0ruaINPA6iG2VoVdR22YQaQA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 402IqStv091635
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 2 Jan 2024 12:52:28 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jan 2024 12:52:28 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jan 2024 12:52:28 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 402IqSB8120863;
 Tue, 2 Jan 2024 12:52:28 -0600
Date: Tue, 2 Jan 2024 12:52:28 -0600
From: Nishanth Menon <nm@ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: Tom Rini <trini@konsulko.com>, UBoot Mailing List <u-boot@lists.denx.de>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Martyn
 Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon Glass
 <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2 19/26] arm: dts: k3-am654: remove usb0
Message-ID: <20240102185228.nr64z7yepb6zui2r@sandpit>
References: <20231229174656.634065-28-bb@ti.com>
 <20231229174656.634065-47-bb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231229174656.634065-47-bb@ti.com>
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

On 11:47-20231229, Bryan Brattlof wrote:
> The pinmux for usb0 is missing from the Linux board dtb file. Remove it
> until we can introduce it in Linux
> 
> Tested-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
[...]
Reviewed-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

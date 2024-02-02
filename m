Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14744C47DB3
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 13:13:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D4CE87C74;
	Fri,  2 Feb 2024 14:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="adDeG9G8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AA9E87C7A; Fri,  2 Feb 2024 14:13:34 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16AD587C00
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 14:13:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 412DDTbN087728;
 Fri, 2 Feb 2024 07:13:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706879609;
 bh=fyEs8u2ZwN7sNGPxvQ4knQrKKl8tWR7hI0+xG49y0oE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=adDeG9G8SbSkxmhY1fbT2hEUI+LthKpcDUtzS6/yhXSi3+rQjaJqvuoJ9kGe0/jgC
 zb+LXvVBKv370tagCJrTGdjFapjR+dVW+xPixKz/T+yu7G1eVVuQR1Tdd2x/2I7N34
 egJl4HlYvjG/wae/w9FXyD7j+nFx72BOo4oLpums=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 412DDTNF081923
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 2 Feb 2024 07:13:29 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Feb 2024 07:13:29 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Feb 2024 07:13:28 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 412DDTi1096823;
 Fri, 2 Feb 2024 07:13:29 -0600
Date: Fri, 2 Feb 2024 07:13:29 -0600
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/2] arm: dts: k3-am64: Sync with kernel v6.8-rc1
Message-ID: <20240202131329.wcqragoj2hcxrqbe@directory>
References: <20240201222741.141074-1-afd@ti.com>
 <20240201222741.141074-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240201222741.141074-2-afd@ti.com>
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

On 16:27-20240201, Andrew Davis wrote:
> Sync with kernel v6.8-rc1 and sync up the u-boot dts files accordingly.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

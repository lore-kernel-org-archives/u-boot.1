Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD332CAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 13:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCA9E835B2;
	Wed, 17 Sep 2025 15:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="d74vDvnr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02BEC835B3; Wed, 17 Sep 2025 15:34:07 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86CDC833D0
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 15:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58HDY0WL1616628;
 Wed, 17 Sep 2025 08:34:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758116040;
 bh=Lpx5C2v1DSHAfiSt334oKeqVOTF//1C+Zo6PNIwYWnA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=d74vDvnr4ZMG1o8q9GNslJAV4l2rtW0mDS91BF0gD4H3uml75uGi8M5QqhZ34sBNy
 a6CVnnuJhPQ636Rp6IKhnHAuGlu+W0W3Z6RZKkrXhZoD0Px1s+s1tbYs0ER5wxSw6s
 L5SwFxr5LFiAGZPsF18arTVDrgSaiolGyajs9PeM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58HDXxAk793787
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 17 Sep 2025 08:33:59 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 17
 Sep 2025 08:33:59 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Sep 2025 08:33:59 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58HDXw4R3414959;
 Wed, 17 Sep 2025 08:33:58 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Sep 2025 19:03:57 +0530
Message-ID: <DCV44DR20153.VU49F4CU2PF0@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <afd@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>, <nm@ti.com>,
 <bb@ti.com>, <kever.yang@rock-chips.com>, <hl@rock-chips.com>,
 <tim@feathertop.org>, <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v1 4/8] spl: ubi: refactor spl_ubi_load_image for falcon
 mode
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250916105857.163951-1-anshuld@ti.com>
 <20250916105857.163951-5-anshuld@ti.com>
 <20250916183433.GD124814@bill-the-cat>
In-Reply-To: <20250916183433.GD124814@bill-the-cat>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Wed Sep 17, 2025 at 12:04 AM IST, Tom Rini wrote:
> On Tue, Sep 16, 2025 at 04:28:52PM +0530, Anshul Dalal wrote:
>
>> This patch moves the falcon mode handling logic out of
>> spl_ubi_load_image to spl_ubi_load_image_os, this allows for cleaner
>> handling for fallback to U-Boot in case falcon mode fails.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> [snip]
>> -		puts("Loading Linux failed, falling back to U-Boot.\n");
>> +		printf("%s: Failed in falcon boot: %d", __func__, ret);
>> +		printf("Fallback to U-Boot\n");
>
> Switching from puts to printf doesn't gain us new information here and
> may pull in printf when we only had puts before. SPL needs more
> consideration than usual about size growth.

You're right, I'll revert back to puts in the next revision. The
existing log should suffice.

Regards,
Anshul

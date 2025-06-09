Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF54C61DB2
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 06:22:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B97281F0D;
	Mon,  9 Jun 2025 08:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Jwdh67tx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E438682A0A; Mon,  9 Jun 2025 08:22:36 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2808980FA8
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 08:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5596MSEd689464;
 Mon, 9 Jun 2025 01:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749450148;
 bh=Br6B/2hMreoZIGv1rguhjY3/9oupYb2fe+fjPft29s8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Jwdh67txAEsa3w/H7YSiToLHYoBtug7X5B9plK5UDEpp8Qhy7nQHAqmVsTXNwXWIC
 OYmUnI7ZXhsQDHtNmAw3yltblkAr0/i0unzC6efCZocfSrfvTnFnz8whhEFibVuO7Q
 l0AQEa8+ReodGRM53ouiyqXHZB9BE37zwvvptnuQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5596MSH91182604
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 9 Jun 2025 01:22:28 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Jun 2025 01:22:27 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Jun 2025 01:22:27 -0500
Received: from [172.24.227.136] (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136] (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5596MOjH959736;
 Mon, 9 Jun 2025 01:22:24 -0500
Message-ID: <f2e58917-85c0-42ef-8e26-0a059da0c6ae@ti.com>
Date: Mon, 9 Jun 2025 11:52:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2 v2] Propagate bootph-all and bootph-some-ram property
 to all supernodes
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <quentin.schulz@cherry.de>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>
References: <20250516114148.3862114-1-m-shah@ti.com>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <20250516114148.3862114-1-m-shah@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hello all,

On 16/05/25 17:11, Moteen Shah wrote:
> In the U-Boot pre-relocation stage, if the parent node lacks
> bootph-all/bootph-some-ram property and the driver lacks a pre-reloc
> flag, all of its subsequent subnodes gets skipped over from driver
> binding—even if they have a bootph* property.
>
> This series addresses the issue by scanning through all the nodes during
> build time and propagating the applicable  property to all of its supernode.
>
> Changes since v1:
> - Carry reviewed-by from Simon
> - Add a subnode-4 in testcase
> - Change commit message and comments in control.py
>
> Link to v1:
> https://lore.kernel.org/u-boot/20250512115028.1783305-1-m-shah@ti.com/
>
> Moteen Shah (2):
>    tools: binman: control.py: Propagate bootph-all/bootph-some-ram properties to supernodes
>    tools: binman: ftest.py: Add testcase for bootph-* propagation
>
>   tools/binman/control.py               | 54 +++++++++++++++++++++++++++
>   tools/binman/ftest.py                 | 24 ++++++++++++
>   tools/binman/test/347_bootph_prop.dts | 21 +++++++++++
>   3 files changed, 99 insertions(+)
>   create mode 100644 tools/binman/test/347_bootph_prop.dts
>

A gentle ping on this. Does this series requires any further changes?

Regards,
Moteen


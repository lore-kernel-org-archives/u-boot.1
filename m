Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE0FC369BD
	for <u-boot@archiver.kernel.org>; Sat, 19 Apr 2025 13:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C50282977;
	Sat, 19 Apr 2025 15:22:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KdA4M+OG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 690698298E; Sat, 19 Apr 2025 15:22:21 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8911828BC
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 15:22:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53JDMEc21205700
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 19 Apr 2025 08:22:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745068934;
 bh=T9bJrRjzwnVnAA82WKMgp9LfYWhYCPwLxBERkR9AjoY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=KdA4M+OGcLybY/xF27doizMrmmFAiDZYRq5AnAzvWrlGY8JtcVg3OvDPK14UBhrLp
 u9H8l0s/SpwmJYZ75WI+0MNzmGGRRo1iOwVk4PNo4QZR6RUyuAadjYcME03rf/tnJI
 uULYjMn5PpN7kEVVm4BuC0x4u1SZU25AUO7SMhEg=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53JDMEKG121771
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 19 Apr 2025 08:22:14 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 19
 Apr 2025 08:22:14 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 19 Apr 2025 08:22:14 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53JDM92T042952;
 Sat, 19 Apr 2025 08:22:10 -0500
Message-ID: <5e473bc3-c7ce-47ea-96af-7b93107ba3a6@ti.com>
Date: Sat, 19 Apr 2025 18:52:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 9/9] doc: beagle: Add BeagleY-AI documentation
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Neha Malcom Francis <n-francis@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>
CC: Beleswar Padhi <b-padhi@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>
References: <20250418193943.953952-1-nm@ti.com>
 <20250418193943.953952-10-nm@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250418193943.953952-10-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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


On 4/19/2025 1:09 AM, Nishanth Menon wrote:
> Document the BeagleY-AI usage, build and basic debug hints
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes Since v1:
> - Included the manual partitioning option suggested by Andrew
>
> V1: https://lore.kernel.org/r/20250411225717.3117370-10-nm@ti.com
>
>   doc/board/beagle/am67a_beagley_ai.rst | 244 ++++++++++++++++++++++++++
>   doc/board/beagle/index.rst            |   1 +
>   doc/board/ti/k3.rst                   |   1 +
>   3 files changed, 246 insertions(+)
>   create mode 100644 doc/board/beagle/am67a_beagley_ai.rst
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
> diff --git a/doc/board/beagle/am67a_beagley_ai.rst b/doc/board/beagle/am67a_beagley_ai.rst
> new file mode 100644
> index 000000000000..3d2fc4a31950
> --- /dev/null
> +++ b/doc/board/beagle/am67a_beagley_ai.rst
> @@ -0,0 +1,244 @@
> [..]

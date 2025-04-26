Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDE5C369C2
	for <u-boot@archiver.kernel.org>; Sat, 26 Apr 2025 02:25:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 637398291D;
	Sat, 26 Apr 2025 04:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UuIiRosV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5908A82977; Sat, 26 Apr 2025 04:25:05 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D2B0828BC
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 04:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53Q2Ou042927450
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 21:24:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745634296;
 bh=+mrsrkorn0wCmQnnjyb6TgDFenVYZOkFYK3yIpsyS8w=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=UuIiRosVmB8oVR+iR8F7Q1Z0ProZgEUypMpGcM1ghI6ju5BU9rcYejFdKzK/m9Osz
 cRUYNxunO+LQHFR4zbq61rvdqUX7r3gFw1S1BvxOp/tqJj7V6vp7wPf4vBO+9e/eEw
 lF4H3UT6AqOs7JAI411Qcbmk2Tfoeg6srCCrqR1g=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53Q2OuOC121548
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Apr 2025 21:24:56 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 21:24:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 21:24:56 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53Q2OqLd037916;
 Fri, 25 Apr 2025 21:24:53 -0500
Message-ID: <40fd7eed-d6f0-4b19-bf9c-3261ba4108ed@ti.com>
Date: Sat, 26 Apr 2025 07:54:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] board: beagle: beagley-ai: Add pattern match for
 MAINTAINERS
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Neha Malcom Francis <n-francis@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>
CC: Beleswar Padhi <b-padhi@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>
References: <20250425173120.141503-1-nm@ti.com>
 <20250425173120.141503-2-nm@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250425173120.141503-2-nm@ti.com>
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


On 4/25/2025 11:01 PM, Nishanth Menon wrote:
> just use beagley_ai as pattern match for the files and folders involved.

subject, line v3 :)

anyway

Reviewed-by: Udit Kumar <u-kumar1@ti.com>

> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes Since v2:
> - None
>
> V2: https://lore.kernel.org/r/20250418193943.953952-2-nm@ti.com
>
>   board/beagle/beagley-ai/MAINTAINERS | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/board/beagle/beagley-ai/MAINTAINERS b/board/beagle/beagley-ai/MAINTAINERS
> index 1623329b7140..04d5f67aba6f 100644
> --- a/board/beagle/beagley-ai/MAINTAINERS
> +++ b/board/beagle/beagley-ai/MAINTAINERS
> @@ -3,6 +3,4 @@ M:      Robert Nelson <robertcnelson@gmail.com>
> [..]

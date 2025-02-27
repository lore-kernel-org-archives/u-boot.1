Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E25C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 08:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AA3B807FB;
	Thu, 27 Feb 2025 09:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YxqmHoN4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAE6080FE1; Thu, 27 Feb 2025 09:11:03 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C42C801FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 09:11:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51R8Axr72318781
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 27 Feb 2025 02:10:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740643859;
 bh=jzr2oblyvBznrcUiddWGVbScBcL6AyvZA/1iTBV5Ymo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=YxqmHoN4chK08bCY2yxbf0IYNmbt08rU9v2QJJUgW9s4nExZy8irLuIqTc1iixXVL
 RRSRyyslFv28DIvwNuSoWD/uExy6fXAjC1m3FhZ1ru7nJqqc7TM1nU/PhKQsJcGGvD
 fFm3qeD5eb1QPeaaQMdIgDy+nJnqDQ1wNccL3cCw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51R8AxFv084593;
 Thu, 27 Feb 2025 02:10:59 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Feb 2025 02:10:58 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Feb 2025 02:10:58 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51R8AuEr039271;
 Thu, 27 Feb 2025 02:10:57 -0600
Message-ID: <a9a79115-2ef3-456c-8fa1-e80fbfc40bb0@ti.com>
Date: Thu, 27 Feb 2025 13:40:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: ti: j784s4: Update Resource Management configs
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>
CC: <vaishnav.a@ti.com>, <u-boot@lists.denx.de>
References: <20250227064947.2475315-1-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250227064947.2475315-1-n-francis@ti.com>
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


On 2/27/2025 12:19 PM, Neha Malcom Francis wrote:
> From: Vaishnav Achath <vaishnav.a@ti.com>
>
> Update rm-cfg.yaml and tifs-rm-cfg.yaml to account for the
> latest changes added in the K3 Resource Partitioning Tool.

Please give the version of this tool instead of latest :)


>
> The change enables resource sharing between A72_2 and MAIN_0_R5_0
> for the BCDMA CSI RX and TX channels, J784S4 supports upto 12
> CSI cameras and 16 channels would not be enough for all such use
> cases for RTOS and Linux, thus sharing of resources in needed.

Please add in commit message, what you are doing to overcome with 
limitation.

Something like, increasing channels to 32 or so .

With above changes in commit message,

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> [n-francis@ti.com: rebased and sent on behalf]
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   board/ti/j784s4/rm-cfg.yaml      | 24 ++++++++++++------------
>   board/ti/j784s4/tifs-rm-cfg.yaml | 24 ++++++++++++------------
>   2 files changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/board/ti/j784s4/rm-cfg.yaml b/board/ti/j784s4/rm-cfg.yaml
> index a448bd2e1e0..6968d317522 100644
> --- a/board/ti/j784s4/rm-cfg.yaml
> +++ b/board/ti/j784s4/rm-cfg.yaml
> @@ -406,49 +406,49 @@ rm-cfg:
>               reserved: 0
> [..]

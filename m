Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B81CAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 04:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FE67808AF;
	Wed, 24 Sep 2025 06:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ezRg6nnu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7195180B9B; Wed, 24 Sep 2025 06:41:13 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14FD1800D7
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 06:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58O4f0cn1133579;
 Tue, 23 Sep 2025 23:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758688860;
 bh=sMiLqjRCdHt1kVSLfKcwxaN/9NvgM5oWUy3FIYsr5Oo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ezRg6nnuh41HmtrRxWEjLTnwvPWjOhQ5tgsAEL1IYRF97nvRn0sW0uRhwcwIhgxta
 lgROBc1T3aHvQI732pNUs3SMYJzBNEi5HhrhZySelxB30LC8j38mTycHHu9371f1o/
 0csCoLPmbp4s8rfpzPQyGQTNvpm6WfHYMEjo077c=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58O4f0bX2489724
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 23 Sep 2025 23:41:00 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 23
 Sep 2025 23:40:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 23:40:59 -0500
Received: from [172.24.235.200]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58O4eseF1146225;
 Tue, 23 Sep 2025 23:40:54 -0500
Message-ID: <5068d614-1383-4f87-8a4f-3966ae5ebc33@ti.com>
Date: Wed, 24 Sep 2025 10:10:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] mkimage: Detect FIT image load address overlaps
 and fix related test/DTS issues
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Aristo Chen
 <jj251510319013@gmail.com>
CC: <sjg@chromium.org>, <alpernebiyasak@gmail.com>, <al.kochet@gmail.com>,
 <paul.henrys_ext@softathome.com>, <bb@ti.com>, <y.moog@phytec.de>,
 <w.egorov@phytec.de>, <francesco.dolcini@toradex.com>,
 <ggiordano@phytec.com>, <afd@ti.com>, <d.schultz@phytec.de>,
 <d-gole@ti.com>, <ravi@prevas.dk>, <carlos.lopezr4096@gmail.com>,
 <quentin.schulz@cherry.de>, <alice.guo@nxp.com>,
 Aristo Chen <aristo.chen@canonical.com>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <175867368257.246129.3001464313456637551.b4-ty@konsulko.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <175867368257.246129.3001464313456637551.b4-ty@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom

On 24/09/25 05:58, Tom Rini wrote:
> On Sun, 14 Sep 2025 10:59:25 +0000, Aristo Chen wrote:
> 
>> This patch series enhances FIT image robustness by adding **memory
>> region overlap detection** to `mkimage` and fixing existing overlaps
>> in DTS files and `binman` tests.
>>
>> The primary goal is to prevent runtime memory corruption from
>> conflicting load addresses in FIT images.
>>
>> [...]
> 
> Applied to u-boot/next, thanks!
> 
> [1/7] binman: Fix typo for the test case name
>       commit: 88392a59bf87bf2c1c5aedc0b76f459d702f71a7
> [2/7] binman: Fix FIT image overlap issues
>       commit: dade54edaff659c4ed6fc40db0b2dd446714c573
> [3/7] binman: Fix FIT image overlap issues for testFitSplitElf
>       commit: a06733fc83f07dd975a9e220a44392f3455c7c21
> [4/7] arm: dts: k3-am6xx: Fix FIT image memory overlap in binman configurations
>       commit: cbc4da1dce3f8dd828a2e613676fdceefd87e1ea
> [5/7] tools: mkimage: detect overlapping load regions in FIT configurations
>       commit: 588094f2c8ec9a4f7d2dcda11ffae8db8462149c
> [6/7] test: Add test case for FIT image load address overlap detection
>       commit: 8f3d3510e31ebc7b2057f431322a7174b6b60ea6
> [7/7] doc: binman: Add guidance for determining ELF load addresses
>       commit: 4907a920e8292e9e38ddab4d211dfd5499097a8c

As I had mentioned in a review comment in v1, also Bryan had mentioned
his similar concern; this may break our AM6x platforms. While the FIT
seems to have overlapping TIFS stub entries, in reality only one is
selectively loaded. The load addresses are designed with our limited
SRAM in mind so changing it like this may not work.

-- 
Thanking You
Neha Malcom Francis

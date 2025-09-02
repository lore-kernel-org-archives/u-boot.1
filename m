Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E06BCA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 10:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 616B683A7A;
	Tue,  2 Sep 2025 12:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oQS1mr3F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9C2083A8A; Tue,  2 Sep 2025 12:35:37 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 699F783A6A
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 12:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 582AZXMW2566866;
 Tue, 2 Sep 2025 05:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756809333;
 bh=9vJOg9rcf1ap7s0UCGE8A9BG44shrG82YEMITeXsc8M=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=oQS1mr3F5h1ZWF1jTiDn9tQalpbKNUARbsbetxOEJIh3V/A9J4BPafF5pXsOulEEs
 6kNjRXvC1q8BZB5U28UHL7QQc1tm1e7yDVQFkgDoA2fagKeFEG3ap6emwJvypJUNzN
 r+X75DFSchmO9Y9NmHPjXp2weS899SI9Usu2wlXU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 582AZXVs3423233
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 2 Sep 2025 05:35:33 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 05:35:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 05:35:33 -0500
Received: from [172.24.19.53] (ltpw0bk3wf.dhcp.ti.com [172.24.19.53])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 582AZVVP3650216;
 Tue, 2 Sep 2025 05:35:32 -0500
Message-ID: <d5a66db7-5474-4940-a245-ff79913585a0@ti.com>
Date: Tue, 2 Sep 2025 16:05:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] AM57 boot fixes
To: Tom Rini <trini@konsulko.com>
CC: <n-francis@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20250901061659.986164-1-a-dutta@ti.com>
 <20250901154812.GB124814@bill-the-cat>
Content-Language: en-US
From: "Dutta, Anurag" <a-dutta@ti.com>
In-Reply-To: <20250901154812.GB124814@bill-the-cat>
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


On 01-09-2025 21:18, Tom Rini wrote:
> On Mon, Sep 01, 2025 at 11:46:55AM +0530, Anurag Dutta wrote:
>
>> Hi all
>> This patch series migrates from .h to .env format for am57xx/dra7xx.
>> Also, we do relevant changes so that the fdtfile can be set from C code.
>>
>> logs : https://gist.github.com/anuragdutta731/82560cc9bc958ca70a25a95a7031eeea
>>
>> Changelog: v1:
>> 1. Converted to plain text environment for am57 and dra7
>> 2. Added dra7 support as well
>>
>> Link to v1:
>> https://lore.kernel.org/all/20250425053431.1622267-1-a-dutta@ti.com/
> Is this a fixes that needs to come in for v2025.10 or a cleanup for
> v2026.01? Thanks.
>
> The patch series contains both fixes as well as code cleanup.
> So, it needs to come in v2025.10
>
> Regards
>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40457C83F09
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 04:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61C5583390;
	Wed,  9 Jul 2025 06:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Drunpr09";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 727E283394; Wed,  9 Jul 2025 06:17:09 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 796DB83371
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 06:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5694H4X21359567;
 Tue, 8 Jul 2025 23:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752034624;
 bh=iqwZBdglvRWuTGe5u+1ojhH+BDvfxmdnRmY/iILJ5Ug=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Drunpr09soR9f2/decfy69QCPEXkYR5DGWg58y+FtsndiWsnOOOCMqYkoq1RF/0nY
 awY3f6lXR/pv9BYyU0AhZbG2AOXnlV1J71WJop3zSIWZQZ9Z27k7MkwQK4t99nzHBO
 RnUeHnEn49/rbDgFLlonOlyNl3KWEkfUQyrFbHkc=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5694H4Br3955012
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 8 Jul 2025 23:17:04 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 8
 Jul 2025 23:17:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 8 Jul 2025 23:17:04 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5694H1A32974380;
 Tue, 8 Jul 2025 23:17:01 -0500
Message-ID: <d8f780e1-635d-403b-9c33-e6c2b3549d97@ti.com>
Date: Wed, 9 Jul 2025 09:47:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: ti: Clean up formatting in rm-cfg.yaml
To: Bryan Brattlof <bb@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>,
 <vaishnav.a@ti.com>, <j-choudhary@ti.com>, <afd@ti.com>, <u-kumar1@ti.com>
References: <20250704091234.3218906-1-n-francis@ti.com>
 <20250707163626.4trdbcgiuzlibm6x@bryanbrattlof.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250707163626.4trdbcgiuzlibm6x@bryanbrattlof.com>
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

Hi Bryan

On 07/07/25 22:06, Bryan Brattlof wrote:
> On July  4, 2025 thus sayeth Neha Malcom Francis:
>> Move to using the latest generated RM YAML configuration files generated
>> by the K3 Resource Partitioning Tool which updates them to have standard
>> formatting with respect to indentation.
>>
>> These files were generated from the untagged commit 41718bd5f915 ("docs: Update
>> docs and move them to docs folder") of the K3 Resource Partitioning tool. This
>> tool is packaged as a part of the public SDK and is not otherwise
>> publicly available.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>> Changes since v1:
>> https://lore.kernel.org/all/20250702105533.1533178-1-n-francis@ti.com/
>> - commit message changed to include the generated tool commit (Udit)
>>
>> Boot logs:
>> https://gist.github.com/nehamalcom/73c1c66d674c32f71a6ade8049c97d21
>>
>>  board/ti/am64x/rm-cfg.yaml      | 2416 +++++++-------
>>  board/ti/j7200/rm-cfg.yaml      | 3554 ++++++++++----------
>>  board/ti/j721e/rm-cfg.yaml      | 5498 +++++++++++++++----------------
>>  board/ti/j722s/rm-cfg.yaml      |   66 +-
>>  board/ti/j722s/tifs-rm-cfg.yaml | 1552 ++++-----
>>  5 files changed, 6543 insertions(+), 6543 deletions(-)
> 
> Are only these boards affected or should we do this for all the 
> reference boards?

AM62P and AM62A also require an update but this is along with changes in
the values themselves not only formatting. It would be better to send
them as a separate patch.

> 
> ~Bryan

-- 
Thanking You
Neha Malcom Francis

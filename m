Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6EDCA0EC6
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:10:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C689C83093;
	Mon, 18 Aug 2025 12:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iNoqqf53";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D1038313B; Mon, 18 Aug 2025 12:10:53 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1246A803DF
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kamlesh@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57IAAfj43059103;
 Mon, 18 Aug 2025 05:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755511841;
 bh=DwYos7INMIp5Yea2RnpgQyPYqMpqJJZsZiaplyHG9x4=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=iNoqqf53z9mW8DFvJZR89vT/cCtMOtRTc6EwgJHn8JuJ0CMbxxsQdmVwA2pb46Eg3
 BEuiQ82UgGoeKQ6VI+ZYixP1PWnc8WtlJBKLokJzmSve4HcYKsIKggQ6yVevMl7N82
 vMIptIrkCkU7n7ANrEPXIb75dDRS0h5UgFRc9VSM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57IAAfQH443677
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 18 Aug 2025 05:10:41 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 18
 Aug 2025 05:10:40 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 18 Aug 2025 05:10:40 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.233.19])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57IAAdeK1135216;
 Mon, 18 Aug 2025 05:10:40 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: Peng Fan <peng.fan@oss.nxp.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, "Tom
 Rini" <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Ye Li
 <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2] clk: scmi: fix set_parent support when CCF is not
 being used
In-Reply-To: <20250818044707.GD13772@nxa18884-linux.ap.freescale.net>
References: <20250813-b4-scmi-v1-v1-0-bef20fc32d4b@ti.com>
 <20250813-b4-scmi-v1-v1-1-bef20fc32d4b@ti.com>
 <20250818044707.GD13772@nxa18884-linux.ap.freescale.net>
Date: Mon, 18 Aug 2025 15:40:39 +0530
Message-ID: <87plct6iu8.fsf@kamlesh.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
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

Peng Fan <peng.fan@oss.nxp.com> writes:

> On Wed, Aug 13, 2025 at 03:59:35PM +0530, Kamlesh Gurudasani wrote:
>>When not using Common clock framework(CCF), calls to
>>scmi_clk_set_parent returns -ENOTSUPP, which should not be the case.
>>Fix that.
>>
>>Fixes: 15fdfef6642c ("clk: scmi: check the clock state/parent/rate
>>control permissions)
>>
>>Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
>>---
>> drivers/clk/clk_scmi.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
>>index 0c9a81cabcc..83ea7bb4286 100644
>>--- a/drivers/clk/clk_scmi.c
>>+++ b/drivers/clk/clk_scmi.c
>>@@ -359,7 +359,7 @@ static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
>> 	int ret;
>> 
>> 	if (!CONFIG_IS_ENABLED(CLK_CCF))
>>-		return -ENOTSUPP;
>>+		return __scmi_clk_set_parent(clk, parent);
>
> The CCF check should be dropped per my understanding. The function should
> work w/o CCF.
Hi Peng, thanks for the review.

w/o CCF clk_get_by_id returns negative.
so function fails

Regards,
Kamlesh
>
> Regards,
> Peng
>
>> 
>> 	ret = clk_get_by_id(clk->id, &c);
>> 	if (ret)
>>
>>-- 
>>2.34.1
>>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42C2CCA472
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 12:27:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FFB68394A;
	Wed,  8 Oct 2025 14:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="thfdJDc9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7635083C91; Wed,  8 Oct 2025 14:27:54 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EE288393D
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 14:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kamlesh@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 598CRgkI3973794;
 Wed, 8 Oct 2025 07:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759926462;
 bh=uPIc4zNEryOgu7efpiw3a36d/FJ0AeIIYgqcG6hGXZA=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=thfdJDc9iIIFJQE3KVqBzI6DJEhaB3CfjXD38jyXAYU8+HW4i0OKS4KRagrmH7gyM
 sW4f6wuZny7yx+n+fAPmmc8FgbMm0sMu4ZZlgfqXG+KSBw9wbP50Gx6U1Iw/I0Uf48
 aUE4f8h1U/KTUW6SP59OhvJfNUGuasRlbQnCuKMk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 598CRgJt3715792
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 8 Oct 2025 07:27:42 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 8
 Oct 2025 07:27:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Oct 2025 07:27:42 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.233.19])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 598CRfxe2526965;
 Wed, 8 Oct 2025 07:27:42 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: Maxim Kochetkov <fido_max@inbox.ru>, Dhruva Gole <d-gole@ti.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, "Tom
 Rini" <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Ye Li
 <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 2/2] clk: scmi: add compatibility for clock version
 3.0 and onwards
In-Reply-To: <dd60557d-e8ee-4ea1-8045-e442db38a5c8@inbox.ru>
References: <20250819-b4-scmi-v1-v3-0-360145076b3b@ti.com>
 <20250819-b4-scmi-v1-v3-2-360145076b3b@ti.com>
 <ccf326ff-b4d3-43f0-92df-07a22bd5c60e@inbox.ru>
 <20250909101806.bymqunywxu6pe33o@lcpd911>
 <dd60557d-e8ee-4ea1-8045-e442db38a5c8@inbox.ru>
Date: Wed, 8 Oct 2025 17:57:40 +0530
Message-ID: <874is9h937.fsf@kamlesh.mail-host-address-is-not-set>
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

Maxim Kochetkov <fido_max@inbox.ru> writes:

> 09.09.2025 13:18, Dhruva Gole wrote:
>> On Aug 25, 2025 at 16:49:30 +0300, Maxim Kochetkov wrote:
>>> 19.08.2025 10:33, Kamlesh Gurudasani wrote:
>>>> Clock version 3.0 specified in ARM SCMI Platform design document
>>>> v3.2, adds extended_config_val parameter in CLOCK_CONFIG_SET.
>>>>
>>>> The SCMI server with clock version 3.0 rejects the message if
>>>> they don't have this field.
>>>>
>>>> Add support so that both SCMI server with clock version 2.0 and 3.0
>>>> can be handled.
>>>>
>>>> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
>>>> ---
>>>>    drivers/clk/clk_scmi.c   | 43 ++++++++++++++++++++++++++++++-------------
>>>>    include/scmi_protocols.h |  6 ++++++
>>>>    2 files changed, 36 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
>>>> index 83ea7bb4286..b33cc05685d 100644
>>>> --- a/drivers/clk/clk_scmi.c
>>>> +++ b/drivers/clk/clk_scmi.c
>>>> @@ -131,19 +131,36 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
>>>>    static int scmi_clk_gate(struct clk *clk, int enable)
>>>>    {
>>>> -	struct scmi_clk_state_in in = {
>>>> -		.clock_id = clk_get_id(clk),
>>>> -		.attributes = enable,
>>>> -	};
>>>> +	struct scmi_clock_priv *priv = dev_get_priv(clk->dev);
>>>
>>> struct scmi_clock_priv *priv = dev_get_priv(clk->dev->parent);
>>>
>> 
>> Could you elaborate?
>> I think clk->dev should be fine, similar to other instances in the same
>> file. Maybe I am missing something?
>> 
>
> clk->dev points to hw clock device. It has no struct scmi_clock_priv
> stored in priv data. So we have to step up to parent device to get SCMI
> protocol device to get struct scmi_clock_priv to get protocol version
> priv->version.
Hi Maxim,

in probe function, we are making sure that priv data is available
	struct scmi_clock_priv *priv = dev_get_priv(dev);
	size_t num_clocks, i;
	int ret;

	ret = devm_scmi_of_get_channel(dev);
	if (ret)
		return ret;

	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK,
					    &priv->version);


Also, the code is working just fine and returns correct version with
clk->dev

Let me know if I missed something

Regards,
Kamlesh

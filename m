Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0A2C282C6
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 23:13:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF12980786;
	Tue,  4 Mar 2025 00:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bMxZIXes";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Vo+efW27";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 164FB80842; Tue,  4 Mar 2025 00:13:40 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A907D8059D
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 00:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Z6F402DGTz9tbb;
 Tue,  4 Mar 2025 00:13:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741043616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mWFredA2H5DhNieb5BPVINoV2hl5dpzv0oKh82kQk3I=;
 b=bMxZIXesKLkZzabxW1h7WFc7Ey9M7QzxWGKGNMJ9juVrPiLQMjEyn58U9dxAibtl9jjT47
 W6NphtlbxZsXEKrR4IP8SaJ+y1SksEFfMsIBN3FFdnlcMpKe29sK3MBy7WHoviwbYJk2U/
 2tl2QwK4dbbMc8MaZqklEszXXPetd0tvw5EuvV1DK3lhZwpR1bKr/mlmb3MQTQHp6IgUki
 ts6ofES5pgIZrAA4KV+XaMfFiSRWCvNPzhLu8jz1aJhJQoCfchtVMKO+880LQwRLT5qAez
 WW4zYCPS5PeFh93fIKF0TS61izxFU8xr3+RFtvRUqQPOleZmxsCCwf3hxJUuBw==
Message-ID: <2fdff05d-32c8-4267-83ce-e04e484ea6ac@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741043614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mWFredA2H5DhNieb5BPVINoV2hl5dpzv0oKh82kQk3I=;
 b=Vo+efW27P2UVafLSGVaR8z+6pQt4Tb2C2DR3dU/6SU2WgumVR056e1BLk7TuuXGkOn3AaC
 GyBDVYaQh6UmHWpYqy13LsbGVrSfs9fe/syKVViD9COhZzra32NebmznBzg6viASJvP6h/
 6CJFxo+zVGieUw+vaRcq2FUOoWCBj+cU8Tao39O7+2H4x2Si71b3CmFMDSFq+X0sU7OK6z
 6k/xe23KRlAl1OYWnKLqA5HgdLFCQr4zneL7a6z/6mLCibJ6mIWxsukSzrfHfNCvuR19LB
 J6Try8mvThJ2YGM3BGSP29kinZqUzGunj94hDluxK/l0G37xkCEi+pT133D/uA==
Date: Tue, 4 Mar 2025 00:13:30 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 15/23] net: ravb: Allocate bb_miiphy using
 bb_miiphy_alloc() and fill in callbacks
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, Jim Liu
 <JJLIU0@nuvoton.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
 <20250222203511.195437-16-marek.vasut+renesas@mailbox.org>
 <b97cc5fc-b622-419c-a556-655de50a4312@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <b97cc5fc-b622-419c-a556-655de50a4312@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 19023957ba1b04af6d1
X-MBO-RS-META: 5b51f4s5zxnrxow8ox64tqu8kf3e4omc
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

On 2/28/25 2:28 PM, Paul Barker wrote:
> On 22/02/2025 20:33, Marek Vasut wrote:
>> Allocate bb_miiphy using bb_miiphy_alloc() and fill in callbacks
>> currently listed in bb_miiphy_buses[] array. This is a temporary
>> duplication of assignment to avoid breakage, which will be removed
>> in follow up patches. At this point, the bb_miiphy callbacks can
>> reach these accessors by doing container_of() on struct mii_dev.
>>
>> Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Christian Marangi <ansuelsmth@gmail.com>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Jerome Forissier <jerome.forissier@linaro.org>
>> Cc: Jim Liu <JJLIU0@nuvoton.com>
>> Cc: Joe Hershberger <joe.hershberger@ni.com>
>> Cc: Mario Six <mario.six@gdsys.cc>
>> Cc: Michal Simek <michal.simek@amd.com>
>> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
>> Cc: Ramon Fried <rfried.dev@gmail.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>> V2: No change
>> V3: Add RB from Paul
>> ---
>>   drivers/net/ravb.c | 19 ++++++++++++++++---
>>   1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
>> index 381cf250ea2..0018b694ec1 100644
>> --- a/drivers/net/ravb.c
>> +++ b/drivers/net/ravb.c
>> @@ -553,6 +553,7 @@ static int ravb_probe(struct udevice *dev)
>>   {
>>   	struct eth_pdata *pdata = dev_get_plat(dev);
>>   	struct ravb_priv *eth = dev_get_priv(dev);
>> +	struct bb_miiphy_bus *bb_miiphy;
>>   	struct mii_dev *mdiodev;
>>   	void __iomem *iobase;
>>   	int ret;
>> @@ -564,17 +565,29 @@ static int ravb_probe(struct udevice *dev)
>>   	if (ret < 0)
>>   		goto err_mdio_alloc;
>>   
>> -	mdiodev = mdio_alloc();
>> -	if (!mdiodev) {
>> +	bb_miiphy = bb_miiphy_alloc();
>> +	if (!bb_miiphy) {
>>   		ret = -ENOMEM;
>>   		goto err_mdio_alloc;
>>   	}
>>   
>> +	mdiodev = &bb_miiphy->mii;
>> +
>>   	mdiodev->read = bb_miiphy_read;
>>   	mdiodev->write = bb_miiphy_write;
>>   	bb_miiphy_buses[0].priv = eth;
>>   	snprintf(mdiodev->name, sizeof(mdiodev->name), dev->name);
>>   
>> +	/* Copy the bus accessors, name and private data */
>> +	bb_miiphy->mdio_active = ravb_bb_mdio_active;
>> +	bb_miiphy->mdio_tristate = ravb_bb_mdio_tristate;
>> +	bb_miiphy->set_mdio = ravb_bb_set_mdio;
>> +	bb_miiphy->get_mdio = ravb_bb_get_mdio;
>> +	bb_miiphy->set_mdc = ravb_bb_set_mdc;
>> +	bb_miiphy->delay = ravb_bb_delay;
>> +	strlcpy(bb_miiphy->name, "ravb", MDIO_NAME_LEN);
>> +	bb_miiphy->priv = eth;
>> +
>>   	ret = mdio_register(mdiodev);
>>   	if (ret < 0)
>>   		goto err_mdio_register;
>> @@ -599,7 +612,7 @@ static int ravb_probe(struct udevice *dev)
>>   err_mdio_reset:
>>   	clk_release_bulk(&eth->clks);
>>   err_mdio_register:
>> -	mdio_free(mdiodev);
>> +	bb_miiphy_free(bb_miiphy);
>>   err_mdio_alloc:
>>   	unmap_physmem(eth->iobase, MAP_NOCACHE);
>>   	return ret;
> 
> Marek,
> 
> I've rebased my RZ/G2L Ethernet patches on top of this series and as
> part of tidying things up I spotted an issue that I'd missed -
> ravb_remove() still calls mdio_free(eth->bus). The error paths in the
> probe functions have been converted but the remove functions were
> missed. It should instead use something like:
> 
>      struct bb_miiphy_bus *bus = container_of(eth->bus, struct bb_miiphy_bus, mii);
>      bb_miiphy_free(bus);
> 
> The same applies to the following two patches (sh_eth.c & designware.c).
This should be fixed in

[PATCH 01/11] net: miiphybb: Split off struct bb_miiphy_bus_ops

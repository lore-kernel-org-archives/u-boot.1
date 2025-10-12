Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A6BCCD184
	for <u-boot@archiver.kernel.org>; Sun, 12 Oct 2025 15:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 378F18385B;
	Sun, 12 Oct 2025 17:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=inbox.ru header.i=@inbox.ru header.b="W7AaALcu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D387C8386D; Sun, 12 Oct 2025 13:58:48 +0200 (CEST)
Received: from send172.i.mail.ru (send172.i.mail.ru [95.163.59.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BB7C8381D
 for <u-boot@lists.denx.de>; Sun, 12 Oct 2025 13:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fido_max@inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
 s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
 :Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive:X-Cloud-Ids:Disposition-Notification-To;
 bh=49W8rZ9nOV/sJ3eyXbzYesLetOtUe6kcf35DzUs1syE=; t=1760270326; x=1760360326; 
 b=W7AaALcusZj+ypJ1W3lizCB6HLD2Qq/jiMz/QoswvW+aw1bOyWFcOoIbVlIQ3Mg2MEM8XO40b68
 tscngjOZXjjlFFPtFvk6o1EDyY23Ac/M0VJJpVHn0OysJBNcszcJhYfkIOh+e+xqd/zHAOppoMSyG
 F4e3eFWWT+3vJz+YlZ8cjPD8RkYkBaIoIhpJ1zuGgfxNAIncYFYD4iQAFugBw03HUED0V9Fm1p/Hm
 ENKAG0J/IReoYjPxYjm9XW9hvRt4fcUnlxLDpgTCp1pKimzgyj7f4yeQmbCyUPsJAJIduiH7Dj1uB
 Te3nyz6NQj6TVEAM+s+sPPf38bIa5gOmas6Q==;
Received: by exim-smtp-58f6d75f4d-8qpf5 with esmtpa (envelope-from
 <fido_max@inbox.ru>)
 id 1v7uiq-00000000FjW-2XjJ; Sun, 12 Oct 2025 14:58:45 +0300
Message-ID: <7e1881e5-3feb-4b26-b9ea-e6e56a090873@inbox.ru>
Date: Sun, 12 Oct 2025 14:58:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] clk: scmi: add compatibility for clock version 3.0
 and onwards
To: Kamlesh Gurudasani <kamlesh@ti.com>, Dhruva Gole <d-gole@ti.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, u-boot@lists.denx.de
References: <20250819-b4-scmi-v1-v3-0-360145076b3b@ti.com>
 <20250819-b4-scmi-v1-v3-2-360145076b3b@ti.com>
 <ccf326ff-b4d3-43f0-92df-07a22bd5c60e@inbox.ru>
 <20250909101806.bymqunywxu6pe33o@lcpd911>
 <dd60557d-e8ee-4ea1-8045-e442db38a5c8@inbox.ru>
 <874is9h937.fsf@kamlesh.mail-host-address-is-not-set>
Content-Language: en-US
From: Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <874is9h937.fsf@kamlesh.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: exim-smtp-58f6d75f4d-8qpf5;
 auth=pass smtp.auth=fido_max@inbox.ru
 smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9D900DBA39F17EC00D0A88A764556E53204B8A10E138077EF00894C459B0CD1B9FD93395C5BC70824411046492FDDF80696F35E7749614AD9B8B7B30C384420788472923344694FB0
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE79379E597596E9183EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB55337566731632CDAE143BBF16F81FCF8CE87B1A4AAFA08282E0AA7E1D0019F9A9ED9B898EEF46B7454FC60B9742502CCDD46D0D7AE820D2C17D0E56F6B57BC7E64490618DEB871D839B73339E8FC8737B5C2249E232F00D8D26902CA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751FF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA7E827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B953A8A48A05D51F175ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A59934CA3D0DFE400F5002B1117B3ED696C6D17DA4BC3A3CCF72305013E4AE841E823CB91A9FED034534781492E4B8EEADDFC043C56F70D752BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF526657DACEB5D5BEDE4F7A5FDF9373512942BFFBA04E65857EA0A9DF48C6BC3DF09515A9A3E4BB8DBF464741F6CDF9F0AE32C146623D92DFF2048F620D7329CDA2502C4472E65607034D55ECCE8C67C6913E6812662D5F2A17D6C1CDD2003EB8E03787203701020945C72C348FB7EED3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVcdLHwQdsTW9wpPDySwmE2Y=
X-Mailru-Sender: 689FA8AB762F7393DDD5FD59B456EAD201F74A237A5DFF2114D8EBBFA016298969614F25443FD68D90DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Mailman-Approved-At: Sun, 12 Oct 2025 17:53:41 +0200
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

08.10.2025 15:27, Kamlesh Gurudasani wrote:

>>> Could you elaborate?
>>> I think clk->dev should be fine, similar to other instances in the same
>>> file. Maybe I am missing something?
>>>
>>
>> clk->dev points to hw clock device. It has no struct scmi_clock_priv
>> stored in priv data. So we have to step up to parent device to get SCMI
>> protocol device to get struct scmi_clock_priv to get protocol version
>> priv->version.
> Hi Maxim,
> 
> in probe function, we are making sure that priv data is available
> 	struct scmi_clock_priv *priv = dev_get_priv(dev);
> 	size_t num_clocks, i;
> 	int ret;
> 
> 	ret = devm_scmi_of_get_channel(dev);
> 	if (ret)
> 		return ret;
> 
> 	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK,
> 					    &priv->version);
> 
> 
> Also, the code is working just fine and returns correct version with
> clk->dev
> 
> Let me know if I missed something

Here is my debug path:

--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -135,6 +135,10 @@ static int scmi_clk_gate(struct clk *clk, int enable)
         struct scmi_clk_state_out out;
         int ret;

+       printf("%s name:%s dev:0x%px dev->priv:0x%px     parent->name:%s 
parent->dev:0x%px parent->dev->priv:0x%px\n", __FUNCTION__,
+               clk->dev->name, clk->dev, dev_get_priv(clk->dev),
+               clk->dev->parent->name, clk->dev->parent, 
dev_get_priv(clk->dev->parent));
+
         if (priv->version >= CLOCK_PROTOCOL_VERSION_3_0) {
                 struct scmi_clk_state_in_v2 in = {
                         .clock_id = clk_get_id(clk),
@@ -288,6 +292,8 @@ static int scmi_clk_probe(struct udevice *dev)
         size_t num_clocks, i;
         int ret;

+       printf("%s name:%s dev:0x%px dev->priv:0x%px\n", __FUNCTION__, 
dev->name, dev, priv);
+
         ret = devm_scmi_of_get_channel(dev);
         if (ret)
                 return ret;

And output:

DRAM:  510 MiB
scmi_clk_probe name:protocol@14 dev:0x000000041f51fc50 
dev->priv:0x000000041f520ae0
scmi_clk_gate name:UART0 dev:0x000000041f522710 
dev->priv:0x0000000000000000     parent->name:protocol@14 
parent->dev:0x000000041f51fc50 parent->dev->priv:0x000000041f520ae0
Core:  132 devices, 22 uclasses, devicetree: board
MMC:   scmi_clk_gate name:EMMC_S dev:0x000000041f521950 
dev->priv:0x0000000000000000     parent->name:protocol@14 
parent->dev:0x000000041f51fc50 parent->dev->priv:0x000000041f520ae0
sdhci@0: 0
Loading Environment from nowhere... OK
In:    serial
Out:   serial
Err:   serial

As we can see here, we have two different devs in scmi_clk_probe() and 
scmi_clk_gate(). dev from scmi_clk_gate() have NULL in dev->priv. So we 
can't get scmi version form clk->dev direcrly.

P.S.: I have CONFIG_CLK_CCF=y



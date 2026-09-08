Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D72C79FA1
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 21:03:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BD7B80879;
	Tue,  8 Sep 2026 21:03:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O_IUIcP0YPPs; Tue,  8 Sep 2026 21:03:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 24FEB8085C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788901392;
	b=b2MT4wrvkD0XI3i9r6E1EGD6RYIfcRRNTbTp+aVBi0tQTDrLc6RuWbp6gFDK+p6VIwi4
	 w6duJYI2/cgEcXRIICS4SQ2QC7Plrq8AVUSXm9PsCEFijdDiDcb0B0bzHCJVDxRgvIg4a
	 L2KSqyoVCgmw+9V1XyNF/8vAXnHNRAAAh9IRcjczICJE/GpZVofV1CnMzOvp/unSudbNJ
	 Nu7VjWVeicz66bnVKUKwsrENOTQDS14UlW2tQmsM7nm8UI1izS40gNsyjkoghED/mYCc0
	 jZbjuMVfy1h+w8tSuszJp74cT7gBPlMt9cO5d366CU1UIBLEYQzCTr8IND0UR+zkeOA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788901392;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=B3f8adbztUDW11yGZakkK39VqiMmnDm/4lzMl7T5m5s=;
	b=IY+y4kbhY7QU+DMMiCjXOUUs/8etV8ZDwrFHe+IXDj39Jmk5fiYIb9uMCTBqInXfZ9iw
	 MZQSTzc6I6HXLTpLKnYFQ+DtOidWcz7eY29kH3XXAFI8ZEJCppPqphj3XLMU1h9toQG34
	 kCp+MtJRhRXiysmb3Poh0lUjdAU49kaMBN01if/QUG2C45zqaXljIxzS50M77XRIcGvaN
	 qgXS1omlW+riYZosWHowQPj8GS2mD3qkZ29G9H7u/zdA15LIQ5o76e50FdXYrquUclM+H
	 91b0MDgLBKquQAQXuDVZvUr2V5Muap69o8EChKobQCTXiLMbEQlN14hegm/+Xx7dRIA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788901392;
	bh=B3f8adbztUDW11yGZakkK39VqiMmnDm/4lzMl7T5m5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UG4wSXhXfYn4bfcOMFuZEwdQTDEaT6yd3SjLHNxBd/Xdq+MiLe7gesSacXVfScwuC
	 iXFk4juR2gfkg3g4cnw4T02yw6DefRb3MCdxM1QyFcRDxkYuhPv5Yj29llaGU3cYkL
	 XxMLTlwKl0aGim6U8XWkLtatizjJSCHiRmIykTMXYR4dutWQxUb0/lQUAeBwb9mRCM
	 3y3h1m8qJt24HL5MEGZgjhkrzSgP2aW4+E2/TkSCtuYZhR0rN8sK/Y2x1FqEpdfqQm
	 U4tjkWBJJQ4sVYzvNQLpvDPCMd9cNB5AUfqmUKqDmyV8XvOH7EywRSeaOnDFnQeFtC
	 b6fRfVCtYd/VA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24FEB8085C;
	Tue,  8 Sep 2026 21:03:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F84F230
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 21:03:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B72460702
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 21:03:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id puW4hlVWfuDj for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 21:03:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D05B7606D3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788901390;
 b=R5MDuueK97Kht24+6I5GpEaIlsTfa+HlXfse38wO8R85xlgOu42nRyycCkDBQ7c+9edA
 mSJ5AtKfcTwRDYQ1G/AQRqgzwgD4RCaNsSmrfJrQGJmEvLtzhH6V6hc4K8KX29pL8TeSU
 t6YPzwDv7bJOrhGdD9WHYDi0saObi+KAQ9QAA0N0lt85E/FJHPisZmCgwze/McXrajRjj
 RIgsBtnH/GcP+hYbkJXjvRqruEXJrgym3KeyRaJ11oU9PMx1CZ/5BjV3Fwk29a1hEvgLV
 sL+/EO1whVQ/McQJo7F073QtCyOlsYJYd+2a5HzC/X1Y7LbzBMqZfGhmQjLuteFz9XA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788901390;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=B3f8adbztUDW11yGZakkK39VqiMmnDm/4lzMl7T5m5s=;
 b=NwRSCxcHMn1NYIRAoieQ8EJSkrF6CBvWr82KMS0xhlfRfMBnY3DU5waRUypEe3brFpPC
 nLpn58I0JgzcakYd9qnNWfPr/cwMJtV0wqtxSzEeop2FoZgiJ9iNBvgcdZGwWa/99VC4A
 WhfJkJNI1i1tN6WxTZyZDyC45utJHE7bhYmAUw2qr4avjZDqZ/P16BS+EJCUa1Nhlv0dp
 5ks/bOYCycr+iJmD19V5p6orumA1Rt2hLMJITZRmWs3TtJB8vhNN08HcIAow40xA+piRu
 uS64V0SxkcMwy6Fn6yD030ThTih2STQzrXSxORkTee/hnmX0+K7Bi2YLKwrH7CMOvzQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=fFQPXHNl; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=fFQPXHNl
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D05B7606D3
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 21:03:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788901367; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MqSXF6xoP7PcrBDIjjykpK4DyITZtc9safxuEzIQsd9LBSGLuTXu/GZ2Jq5LSuyYHw4xImByUSlhHznYtT1q0qNDmFUT9i56PuukwDim12tCQztrMIzdVuwNrvSykMOw/Eca7nbRiGe4D8ugdMEBU6yZdShgYwLqZqitp5MKoe4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788901367;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=B3f8adbztUDW11yGZakkK39VqiMmnDm/4lzMl7T5m5s=; 
 b=VgEx/OGRyQkUokhQm1vcakw9im5p/dgzrLxX9NdHtrvbZbNB0VtUba0ZHlCLoiDdIEGWBwIBPuXCdWA7QnSM5Tr+wxWB3rmTjMoNjrGZbU/c0oyspTCdX8M+Tiy//LHFYjkfqcDBaNTwLZSUlZY3zUUIgyttP4y3uJa1TkJzzfs=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788901367; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=B3f8adbztUDW11yGZakkK39VqiMmnDm/4lzMl7T5m5s=;
 b=fFQPXHNlALcn+IyT3e6ginWiyFyEeragkgUMjA2iBiWNR0e6Q0MVyK8gzM9w7fC2
 d3V2u4GdhxyLlVYWtsPUkoHsLKHmPIz0aeH/8sJcpsPZItDKJ7D0JHrdG7ZezzMWpFJ
 2WETbzDu2O58Ovq/GOuzf35FrZRtHnPHCXT4/ZkQ=
Received: by mx.zohomail.com with SMTPS id 1788901363965724.0991187610223;
 Tue, 8 Sep 2026 14:02:43 -0700 (PDT)
Date: Tue, 8 Sep 2026 21:02:36 +0000
From: Yao Zi <me@ziyao.cc>
To: Andrei Lalaev <andrey.lalaev@gmail.com>, Yao Zi <me@ziyao.cc>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Hiago De Franco <hfranco@baylibre.com>
Subject: Re: [PATCH] mmc: cv1800b_sdhci: configure SDHCI PHY
Message-ID: <aqB37CllzDTb9ggX@pie>
References: <20260907-milkv-duo-sdhci-configure-v1-1-606b59eaafa0@gmail.com>
 <ap79pdnPCUfaG5gE@pie>
 <f26f9e30-2f18-46aa-9d02-58933dd1ebc2@gmail.com>
 <0b3c324e-b1fe-4c87-a89c-887f6306def6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b3c324e-b1fe-4c87-a89c-887f6306def6@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.888.69
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue, Sep 08, 2026 at 05:27:43PM +0200, Andrei Lalaev wrote:
> On 07.09.26 20:44, Andrei Lalaev wrote:
> > Hi Yao,
> > 
> > On 07.09.26 20:08, Yao Zi wrote:
> >> On Mon, Sep 07, 2026 at 04:54:35PM +0200, Andrei Lalaev wrote:
> >>> Some samples of the Milk-V Duo and Duo 256M have issues with SD card
> >>> communication. As a result, the SD card is not detected, or the correct
> >>> mode is not selected.
> >>>
> >>> Configure SDHCI PHY in the same way as in downstream, to ensure
> >>> that the PHY is initialized properly.
> >>>
> >>> Fixes: eb36f28ff721 ("mmc: cv1800b: Add sdhci driver support for cv1800b SoC")
> >>> Signed-off-by: Andrei Lalaev <andrey.lalaev@gmail.com>
> >>> Link: https://lore.kernel.org/u-boot/20260822091510.3253162-1-andrey.lalaev@gmail.com/
> >>> ---
> >>>  drivers/mmc/cv1800b_sdhci.c | 25 +++++++++++++++++++++++++
> >>>  1 file changed, 25 insertions(+)
> >>>
> >>> diff --git a/drivers/mmc/cv1800b_sdhci.c b/drivers/mmc/cv1800b_sdhci.c
> >>> index b756649f90f3..5c129682daba 100644
> >>> --- a/drivers/mmc/cv1800b_sdhci.c
> >>> +++ b/drivers/mmc/cv1800b_sdhci.c
> >>> @@ -8,11 +8,17 @@
> >>>  #include <sdhci.h>
> >>>  #include <linux/delay.h>
> >>>  
> >>> +#define CV18XX_SDHCI_MSHC_CTRL  0x200
> >>> +#define CV18XX_SDHCI_PHY_CONFIG 0x24c
> >>>  #define SDHCI_PHY_TX_RX_DLY  0x240
> >>>  #define MMC_MAX_CLOCK        375000000
> >>>  #define TUNE_MAX_PHCODE      128
> >>>  
> >>>  #define PHY_TX_SRC_INVERT  BIT(8)
> >>> +#define PHY_RX_SRC_INVERT  BIT(24)
> >>> +
> >>> +#define CV18XX_LATANCY_1T BIT(1)
> >>> +#define CV18XX_PHY_TX_BPS BIT(0)
> >>>  
> >>>  struct cv1800b_sdhci_plat {
> >>>  	struct mmc_config cfg;
> >>> @@ -64,10 +70,29 @@ static int cv1800b_execute_tuning(struct mmc *mmc, u8 opcode)
> >>>  }
> >>>  #endif
> >>>  
> >>> +static int cv1800b_deferred_probe(struct sdhci_host *host)
> >>> +{
> >>> +	u32 val;
> >>> +
> >>> +	val = sdhci_readl(host, CV18XX_SDHCI_MSHC_CTRL);
> >>> +	val |= CV18XX_LATANCY_1T;
> >>> +	sdhci_writel(host, val, CV18XX_SDHCI_MSHC_CTRL);
> >>> +
> >>> +	val = sdhci_readl(host, CV18XX_SDHCI_PHY_CONFIG);
> >>> +	val |= CV18XX_PHY_TX_BPS;
> >>> +	sdhci_writel(host, val, CV18XX_SDHCI_PHY_CONFIG);
> >>> +
> >>> +	val = PHY_TX_SRC_INVERT | PHY_RX_SRC_INVERT;
> >>> +	sdhci_writel(host, val, SDHCI_PHY_TX_RX_DLY);
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>>  const struct sdhci_ops cv1800b_sdhci_sd_ops = {
> >>>  #if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
> >>>  	.platform_execute_tuning = cv1800b_execute_tuning,
> >>>  #endif
> >>> +	.deferred_probe = cv1800b_deferred_probe,
> >>
> >> Is there a reason to create a new function, instead of including the
> >> logic somewhere already existing, for example, cv1800b_sdhci_reset()?
> >> It seems to fit in cv1800b_sdhci_reset(), too, if it's for
> >> initialization of the PHY.
> > 
> > 
> > No, there is no particular reason. I simply didn't think about cv1800b_sdhci_reset (:
> > 
> > Thank you for the hint! I'll check it and will probably move it to reset.
> > 
> > 
> 
> I've rechecked, and unfortunately, moving it to cv1800b_sdhci_reset() is not
> an option because reset is called only from cv1800b_execute_tuning() and
> not accessible to SDHCI core (unlike in Linux MMC subsystem).
> 
> So I think I'll just drop deferred_probe() (wasn't actually required)
> and call the function directly from probe().

Sounds reasonable, too. Thanks.

> -- 
> Best regards,
> Andrei Lalaev

Best regards,
Yao Zi

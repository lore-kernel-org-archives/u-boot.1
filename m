Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE99C4453D
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 04:31:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0664281107;
	Fri, 24 Jul 2026 04:31:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kfN-Dh9Zp1Zs; Fri, 24 Jul 2026 04:31:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 152D3810EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784867475;
	bh=oY5vRWimzjpWcEmzvMgPC1/48JqNSZnUQGuFixcoc9Y=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=IQnTCPdBb5gWq9AIAQvbJORLEunHxaHCUZVLzcLwZyqw87e5K5XUE4yCvCkvi21HE
	 lojpFZHhSTlQZuEVS7RuhdX/MVOb5toQ6+Abxg5VEYGyMoylPXq4ANdLbHm1saJaDq
	 8MZwtqIkLGST+T3PbpjkYL1U8lTpAjQSHYF9TWQ44ws88v1m8czHARC0x+ZTN0MmSs
	 cZZTnGq9/gMR+AOqD5bWqC39Jn40b6GXkn0DHLKYnDEqPHnr0gYWpBzYuSbMuL1LO0
	 ttDrS6x0a2r/eC5ejabLAhkllBo4XYlpgDX+IPWpKoi3Ygxpo8a2WqspVdJUJOokqE
	 cOChmfKquERqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 152D3810EE;
	Fri, 24 Jul 2026 04:31:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 189832E5
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 04:31:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A38640072
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 04:31:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aqUdCOD41SdF for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 04:31:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8CFF64008A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8CFF64008A
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8CFF64008A
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 04:31:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DE3D411B210; Fri, 24 Jul 2026 06:21:35 +0200 (CEST)
Message-ID: <6c83c636-dc3c-4463-a087-b1cc489cde86@nabladev.com>
Date: Fri, 24 Jul 2026 05:30:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] net: fsl_enetc: Add 1G SGMII mode support for
 i.MX95
To: alice.guo@oss.nxp.com, u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Ye Li <ye.li@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Alice Guo <alice.guo@nxp.com>
References: <20260724-imx95-v1-0-7131a9e17fe1@nxp.com>
 <20260724-imx95-v1-3-7131a9e17fe1@nxp.com>
Content-Language: en-US
In-Reply-To: <20260724-imx95-v1-3-7131a9e17fe1@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nabladev.com; s=dkim; t=1784866896;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=oY5vRWimzjpWcEmzvMgPC1/48JqNSZnUQGuFixcoc9Y=;
 b=TuxpKrSV+kENilVWbmrUyqp+aFsh5RTrSJf3YQjUCPX+CXFo3QLWXzAYVU3ytQ71kqezCi
 6qFt5tedPbKt5td1YslsXceKCY+tq8g3bq2lx01o2pbgdKcNGWpslKTdyduLNIDwlVTCVG
 jO94fh1qbJqx7PGGmUdkcDQ//OH0/IFe7WV0FUuQBE6vA/SL5Ip+apKJI4HBxh8+XZM8tw
 2SlnVLF4CWADqtSWRLiB9vzQ6CKHWUJXmiCWGuW4a8+p5KvbA/Rc5T0FWOdSXQA05ADVxA
 SkPatb+XgEkl1BUC/pMRcJ4hw17Tt2I6xx275E7dzEyah9WTpZ2ztfB2ZubFDw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=TuxpKrSV
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marex@nabladev.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/24/26 5:10 AM, alice.guo@oss.nxp.com wrote:

[...]

> +++ b/drivers/net/fsl_enetc.c
> @@ -35,6 +35,12 @@ static inline int xpcs_phy_usxgmii_pma_config(struct udevice *dev)
>   {
>   	return 0;
>   }
> +
> +static inline int xpcs_phy_sgmii_1g_config(struct udevice *dev)
> +{
> +	return 0;
> +}
> +

The trailing newline before #endif is not needed.

>   #endif

[...]

> +++ b/drivers/net/fsl_enetc_xpcs_phy.c
> @@ -1471,6 +1471,15 @@ int imx95_xpcs_phy_sgmii_1g_config(struct udevice *dev)
>   	return 0;
>   }
>   
> +int xpcs_phy_sgmii_1g_config(struct udevice *dev)
> +{
> +	if (is_imx95())
> +		return imx95_xpcs_phy_sgmii_1g_config(dev);
> +
> +	dev_dbg(dev, "SGMII 1G config skipped\n");
> +	return -ENODEV;
> +}
Shouldn't the changes to drivers/net/fsl_enetc_xpcs_phy.c be in patches 
1/3 or 2/3 ?

Also, shouldn't there be "int xpcs_phy_sgmii_1g_config(struct udevice 
*dev);" in some header file ?

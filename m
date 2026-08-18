Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EABFC5DF7E
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 11:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5092A40762;
	Tue, 18 Aug 2026 11:43:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qov54LJxC1a3; Tue, 18 Aug 2026 11:42:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3E6140699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787053379;
	bh=4nVTAXZ0UfTyNPLMjaxWsV+GyYviHuRHW2lLrcP2aoo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BLCHqii0D3ai0iQ5v8fnZALm+U+MXqwa2JgxGuTKW6Yiq+RNGzrQzYynihX7OgzAO
	 tgeZMs9P+uqhD3IAL7h8v/Znwe8G14W7BvIo5Lfyi/8eVuMovcy7KYEGb+yr7k7Co6
	 T+AFSIvE8tz6X8YHkpbDTdYlVjaTk74q71Eo9Js+bm6GxR8ZeqY0IlrjtATlaO5hke
	 798xAdKfnQc5VepNCA0l12WCk58EQ92rl+f+5aU2SLCjvvUhRBKVLbWpsZLV+nXsP6
	 z3B09ZiaMpOIGe2FGIZqySKRcgXbJp/Fa4PrO/4wCO/krb9cjrfMPz5pHeA4qp5iLl
	 hugwKjsqvDcPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3E6140699;
	Tue, 18 Aug 2026 11:42:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A96B7194
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 11:42:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8FCA180F42
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 11:42:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OdwKhsc1W0SL for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 11:42:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 65F5980F58
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 65F5980F58
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=CBSEiQTm
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 65F5980F58
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 11:42:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AEFB711AD63; Tue, 18 Aug 2026 13:42:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1787053369;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=4nVTAXZ0UfTyNPLMjaxWsV+GyYviHuRHW2lLrcP2aoo=;
 b=CBSEiQTmA5MWbuhp/08nW6I+uWnkitZnkasI/NMMiJkiGaAAGfNQ1yVtB+feSRMH+5xfEZ
 ISPCSIuWRzv9IHR4Sp43m18GIPdv/U/kNKf6mCBsUnYhEPqYnOQc0K0ZB9IG0EOE3RBUf+
 JoFCyQqZZdpgGbMMGdpZ3QUjcHpDlWc5XpMykVirtTJ6EZX7YTrk3/oSZUKhRLCuHA/A1A
 fjmrT0toytoktpKrQ1MUSiyXS9IHlVJGPveNAmoAt3PqfDsuIneVjBRKCMVg3uH6IHIU/f
 xHqpi2vAaMiyHME6srUndg0deozRWtA1cd9xIh/KU3ckv0pDrG14f9aNNttzEQ==
Message-ID: <55aa557b-91f9-40ac-a347-94b890297e1c@nabladev.com>
Date: Tue, 18 Aug 2026 11:12:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] net: fsl_enetc_xpcs_phy: Add SGMII 1G support for
 i.MX95 Ethernet PHY Wrapper
To: alice.guo@oss.nxp.com, u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Ye Li <ye.li@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Alice Guo <alice.guo@nxp.com>
References: <20260818-imx95-v1-0-12ef3eea3943@nxp.com>
 <20260818-imx95-v1-2-12ef3eea3943@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260818-imx95-v1-2-12ef3eea3943@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 8/18/26 5:18 AM, alice.guo@oss.nxp.com wrote:

> +	/* 4.2 Poll for SRAM initialization done */
> +	begin = get_timer(0);
> +	do {
> +		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_SRAM);
> +		if (get_timer(begin) > 500) {
> +			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
> +			goto timeout;
> +		}
> +		mdelay(10);

Could you use read_poll_timeout() for this ? read_poll_timeout() "op" 
would be "xpcs_phy_read_pma" and "args" would be "dev, 
PMA_MP_12G_16G_25G_SRAM)" , this:

"
ret = read_poll_timeout(xpcs_phy_read_pma, val, val & PMA_SRAM_INIT_DN,
                         10000, 500000, dev, PMA_MP_12G_16G_25G_SRAM);
if (ret)
  ... timeout ...
"

> +	} while (!(val & PMA_SRAM_INIT_DN));
> +
> +	/* Assert SRAM external loading done */
> +	xpcs_phy_write(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_0),
> +		       GLOBAL_CTRL_EX_0_PHY_SRAM_BYPASS);
> +
> +	/* 4.3 Poll for vendor-specific soft reset */
> +	begin = get_timer(0);
> +	do {
> +		val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DIG_CTRL1));
> +		if (get_timer(begin) > 500) {
> +			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
> +			goto timeout;
> +		}
> +		mdelay(10);
> +	} while (val & PCS_DIG_CTRL1_VR_RST);
[...]

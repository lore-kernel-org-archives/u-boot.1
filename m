Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F387C5DF84
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 11:43:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57805608D4;
	Tue, 18 Aug 2026 11:43:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U8n4r_K5ENXT; Tue, 18 Aug 2026 11:43:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BBD65608C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787053382;
	bh=rXj11qU6w5WcZgyy6H10xiT30TEia19Qjq88TS7XJSY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qBdi01dDthDwZwBPr87LQV6uoSUIWnOw6EE1oUmaNE5vzsb5uJwfcf31NdiIo85yB
	 JJ68ehkyAatGafa2HEpcEBclCF1VXeaZFuNoGc0GiUov/+7JXB19HNEe2nA/6Ml4KX
	 7x6WDpElXE9/lllt71htnIy5+HCAoF24wO+47FNVPX8Xh8vq6Drw9dgIHbroqHddXz
	 ZDz6RvddjiOTANcsCZP6l6Z7RyDTP21aFaFA3WOfqDd0BVYmfFHiVRwHzUaIoYOFMQ
	 0ReR+LuVZKp7SI83bZqrduPziInRiEUzQVhV5oGWxEXVcHmo1+jz5gym4NDGs+I7jY
	 Nl8JjFtxjPJIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBD65608C2;
	Tue, 18 Aug 2026 11:43:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1004A333
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 11:43:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7D1A40762
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 11:43:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ZOZCXWwOrxK for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 11:43:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D8A684072F
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D8A684072F
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=KSVSVrQW
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D8A684072F
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 11:42:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A001911C338; Tue, 18 Aug 2026 13:42:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1787053374;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=rXj11qU6w5WcZgyy6H10xiT30TEia19Qjq88TS7XJSY=;
 b=KSVSVrQWPzpGv2ITcJGVA1nh3jdeQZm523VzmGuKIehSek085FIQ+48bM/B6XgBk8wi6Qu
 uxHYantA6ac6TpKFvxiAV8NBmYXNjSDwJqZtiZsr8dB57Cc9HjPEU9dqPX+10gzCN73OQc
 zPyWA94IYuPB1DH+5SD7/BpV+8n9T8cUDC+ITwc7KuUZBKJgvuJ3VqGF+DrSqx/bOdFftJ
 A9mvgzrTxr/iFRrB4cF3c6LVxpU9T8H7yqZlOQ6lfE/YOyRl0HzmR9k4qBodi9ElyLMNKY
 samvWXrbZ9MwSyr9Cmn3xBxi+U1uBh5aUrQwfsKABAAHJ/bsOjR/asNqbtF9ZQ==
Message-ID: <c5e3aa4e-4b84-4175-a46f-b023682df4da@nabladev.com>
Date: Tue, 18 Aug 2026 11:14:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] net: fsl_enetc: Add 1G SGMII mode support for
 i.MX95
To: alice.guo@oss.nxp.com, u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Ye Li <ye.li@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Alice Guo <alice.guo@nxp.com>
References: <20260818-imx95-v1-0-12ef3eea3943@nxp.com>
 <20260818-imx95-v1-3-12ef3eea3943@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260818-imx95-v1-3-12ef3eea3943@nxp.com>
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

[...]

> @@ -565,6 +581,9 @@ static int enetc_config_phy(struct udevice *dev)
>   	if (enetc_is_imx95(dev))
>   		supported |= PHY_10G_FEATURES;
>   
> +	if (priv->uclass_id == PHY_INTERFACE_MODE_SGMII && enetc_is_imx95(dev))
> +		supported = PHY_1000BT_FEATURES | PHY_DEFAULT_FEATURES;

Shouldn't this be clearing out the supported features ?

supported &= ~(PHY_100BT_FEATURES | PHY_10BT_FEATURES);

>   	priv->phy->supported &= supported;
>   	priv->phy->advertising &= supported;
[...]

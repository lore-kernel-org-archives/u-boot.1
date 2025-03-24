Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671D6C28B30
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 01:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D1FA81BC0;
	Mon, 24 Mar 2025 02:15:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tF9T2Q6l";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ahz7Ays4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66EC181E51; Mon, 24 Mar 2025 02:15:30 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C10681BC0
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 02:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZLZqN0SXnz9sbl;
 Mon, 24 Mar 2025 02:15:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742778928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9/tRgjannP/Y+Kw90RjhpQyec7Xq7xkcOO64p9ktgaM=;
 b=tF9T2Q6ldUHA1SBG4JJW69cQ5jvm/AnOM5CiJDyogJ9ma6a4Dfy3K8VYqYj/TH25/nh6BO
 CBz6dlUs0U5SFDVri8vHXWs+NTPoZGB4DYfoCH2mLILyCSXiCALpDYFhLmMZjJE+QIIag0
 /locCaqykEBaQDpjJGl5HgqYz+jdeZ8BF2UtKKBWnWgRxQe6eEXbXVIPwST0QIUZzzku+9
 JToum+ZZb26r1F5Rp4d4177Lso3s3XV4aWT5aOV/8taGxqNREpiyk2w//g6LjfDDkWmiET
 0QK1ip9v9OsQPFg4H8eua5rvVWz/MJChR6tmRUFk3+cEs1LZMjr++8+OpVNm5w==
Message-ID: <fa596092-ac67-48c0-8178-1c78b86c9306@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742778926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9/tRgjannP/Y+Kw90RjhpQyec7Xq7xkcOO64p9ktgaM=;
 b=ahz7Ays4mPyv8ySKKMdL2eLOT4tvPwup9nfrYaWUfGN04GKSVv2QBOgv0F5Cl/uxPodq2P
 Fpw7Su9PEMb33RDUSAZV81jwGKfdmcckQXJACj+Ai54F2LK2K5em95sStak8tRZcIY4mff
 ppgOzWQCtUTjRfH8WQVpDfdtKC18jltx5IbYZCHIvMJDrcIkHxmPInNe1bzhdmX9LtXPDl
 kz4gX9RL7wQ3CZvPcCfNgcxR1gz84EblPEMm7pVCLrQQ8+n5ttEcqx2xx5QANpNH3ICtBa
 w2AUJ3WsegXhhqcRkm8opfbxJwyVq72lcbeOywwGrLUcIXos7fBOsEM2sKt9Jw==
Date: Mon, 24 Mar 2025 02:08:13 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/4] net: ravb: Add optional reset deassertion
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250319120401.8297-1-paul.barker.ct@bp.renesas.com>
 <20250319120401.8297-3-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250319120401.8297-3-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: aykirgnk31ympk8mf4chuncdeu3giecu
X-MBO-RS-ID: 11e6b68db25fc41fa35
X-Rspamd-Queue-Id: 4ZLZqN0SXnz9sbl
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

On 3/19/25 1:03 PM, Paul Barker wrote:

[...]

>   static int ravb_probe(struct udevice *dev)
>   {
> +	struct ravb_device_ops *device_ops =
> +		(struct ravb_device_ops *)dev_get_driver_data(dev);
>   	struct eth_pdata *pdata = dev_get_plat(dev);
>   	struct ravb_priv *eth = dev_get_priv(dev);
>   	struct mii_dev *mdiodev;
> @@ -648,16 +653,32 @@ static int ravb_probe(struct udevice *dev)
>   	if (ret)
>   		goto err_clk_enable;
>   
> +	if (device_ops->has_reset) {
> +		ret = reset_get_by_index(dev, 0, &eth->rst);

Can devm_reset_control_get_optional() maybe be used here instead of the 
flag ?

> +		if (ret < 0)
> +			goto err_clk_enable;
> +
> +		ret = reset_deassert(&eth->rst);
> +		if (ret < 0)
> +			goto err_reset_deassert;
> +	}
[...]

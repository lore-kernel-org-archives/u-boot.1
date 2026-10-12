Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AD3CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 12:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A08EC80D5B;
	Mon, 12 Oct 2026 12:27:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HeWoV7gB_R4G; Mon, 12 Oct 2026 12:27:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8832680BA6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791808053;
	b=io8Hir1Q7tU4gfp/MleMiOq+q+hrPo2Sl5WZG26jO3yRF6hHS81n2dVkAaLFotxFy30M
	 ZH5fr7BihwIwU9jWN2AmNudSp29lNgA2P9jOtLRxDkI09K3vDoAf8tFNYK0q3fRuX/4zY
	 uAJtL0+zxsiwVTBasRdVX7lLAM34FmLFadAfJN5plvdQBfbiQvw2ieXVuIQFMp04+1j+F
	 F7xTWVQUagYNuqUJdazGkZ+j0RxoKiSH+A2KsPYuZStifAzVzZcIgM54dK4vr3zdoBb9f
	 Sce1P+u3SzAq7nyK2AeW73cKjPqmdnZp/xo2FphHBAwMU/Oglfofii3zyraIIcNjJRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791808053;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jHikXMGqYIwRr1a3ZwPkWOzdtZbewXO3osMzgy7XPMw=;
	b=Wx/WFH3J/el5UotdlS6PMIOTUY+KpXXb9BnHVHjspJp0oUv6/6EQeNJ/FkbLZXJd/D9K
	 rxP4iYLvEYCJ58/S2a3I1euX3R7yjZ9RrRestwsfFR117waWGj8l6yzjYNBSRLKsq8B9u
	 qul/ROpnvKzw60lkRdKoMb14P9RU4rwGiTkvIE5aC6GdzLeef9QUAKmsgiaJSKbsqAB5g
	 vyUsQcNiA4cR4GdMAXLS6Wi755kg6KAfgsi2HyO05Usic1MLQFhb1sRpnXuz7mBTXJf3/
	 ISR0Sj/cyiMLLHOlduZm+pGAwwlFRGURrdcY106CYajDSvyfFYguIVNjLPmONw4Wq3Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PaXSqpHY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791808053;
	bh=jHikXMGqYIwRr1a3ZwPkWOzdtZbewXO3osMzgy7XPMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gWFm4EKBrARpruSat8eC7FOoHEKFdGjK0iyS4z1ORjBY1ZOiShD0eMrc0EkQmI7Es
	 ReNFKR8ZWQJSkirZDC+qC23b09EnhlAF/Q5/Z6wP5m4prGMQcZU2SZrKpJWlahOJEj
	 kQXNr8qse6dE7zewjpiBv/n+tt58XSaQDlnVdb73Nds7c70fMHFbOdJohBhplMoTLO
	 g5U83zLCP/lsFWTw2KkIr5xAhYvsM3VpFg5UTgSzwCfgb8/1fWA9ywl+UPWIGEL6BQ
	 WIQNCIqRK1aarUKrY6CXzdN+v5twHRZ22zG5frkXEg24VbS3oDgWXmzmpxhyzsMxMl
	 4jxWkZys+nlEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8832680BA6;
	Mon, 12 Oct 2026 12:27:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0643C179
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 12:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E05E680BA6
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 12:27:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2tpmQsBOP4Eq for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 12:27:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 04E1380B97
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791808051;
 b=Cv8bFXbExhD7hfZ6V1JpFwMiN6DVlbW0kz7kkdokKUkPriFepHHYABjc758fgQo0J40o
 Ur76G96Guo40mTe4KjuXk1UtAL2iSMhurZ5YMPDAMp6ObjadTHFoVZ/zI1aLf+L5q4m4n
 BxYE3KvePnTgPfWAlsfqLFtSDWwMUmxpss6YtkkcKA0Hywa56iUgj8vb5ArTPuiJL1bZ9
 SRzEd0oXLJJ0JtKsRR3nMT81j0JJa8ONXEdXCa1Tw7crRalX1Sn0tuN8xs4wdW/UpaNmU
 SkmfKz9xmi9g+4iR9RLlddANZXSDOdeKwMJoAVjjx6mtWnLi2BDHj3GDmj9PdqFkydw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791808051;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=jHikXMGqYIwRr1a3ZwPkWOzdtZbewXO3osMzgy7XPMw=;
 b=CV2ZogphNEEX6ZOAQNBlLoqBJQuM3MuwUu/NngEOH86N1BmkUxNmflRZ2JXbXk8JbW9R
 HJmBt71Y5xyAq2QihSBv0aptBQKqD8inWb+ozHoz7iGa7o9uhaUvTuK0PXKbPEtSzgbyR
 ComAYOA0mhwg0dV7f/01Mwy2fDxsDFGuDl3o51HE/tiNYBKQxsbLWbvDS3aEO2VdG278Z
 0DZZdHqD4WIkAcsnHINmfrwFuvSI1nVtOIrLPfBh1A2u/SNQXDB518zTauE8eY5bAbW33
 bjhvuEq3QtLeOJhj6QHGnDkGgg4Uu2nIhMb7x8tTnGOiTkCvheIUT9PTGMi9Crr0h3g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PaXSqpHY; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=PaXSqpHY
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 04E1380B97
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 12:27:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3BF4C60AB7;
 Mon, 12 Oct 2026 12:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D081F0089C;
 Mon, 12 Oct 2026 12:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791808048;
 bh=jHikXMGqYIwRr1a3ZwPkWOzdtZbewXO3osMzgy7XPMw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=PaXSqpHYOLeHUfLiiXa/5wsjzlwPMcQcbRf4fXtwFipMqMS8bILtQWjQjJ835aURA
 CtxenTVSabw/kPXeOx2X1gsQUdOYIWTnp/goFjVUYnBK/BOms3Ycj/4cYVereQ6NQM
 otuu1qzEw+kw6l95RMqk9hvE7CA2BdRebddjTOwiseWCN3wlIGlxjVf7R9juCeICRF
 Pv7kqAc/M5/uJstU+QcsFFd0hTiYGnJJ3X/RAe4KuCmsl1gPVjdXdNOUqHSs2r2l2P
 OrTB5I2E2GchSIhnR7c1FIj4ziCJrGeIJrHYNi9ZA6O8VF4xhf7KhaX93HbKVrkrdI
 gI9QLopsSLSBA==
Date: Mon, 12 Oct 2026 12:27:25 +0000
From: Yixun Lan <dlan@kernel.org>
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: Re: [PATCH v2 2/2] usb: dwc3: generic: add SpacemiT K1 support
Message-ID: <20261012122725-GKI26088@kernel.org>
References: <20261006T002406-0400.uboot-k1-usb-cover.DaveWK225@protonmail.com>
 <20261006T020608-0400.uboot-k1-usb-v2-cover.DaveWK225@protonmail.com>
 <20261006T020608-0400.uboot-k1-usb-v2-0002.DaveWK225@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261006T020608-0400.uboot-k1-usb-v2-0002.DaveWK225@protonmail.com>
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

Hi Dave,

On 12:32 Tue 06 Oct     , Dave Klotz wrote:
> The K1 describes its DWC3 controller as one flat device-tree node with
> the controller registers, clocks, resets and PHYs. It has no separate
> wrapper registers or controller subnode.
> 
> Use the existing flat-node callback through rk_ops so that the generic
> wrapper binds its host or peripheral child to the same node.
> 
> The generic glue handles the K1 controller clocks, resets and USB 3 PHY,
> while the child uses the existing generic DWC3 host/peripheral path.
> 

https://github.com/torvalds/linux/commit/764c2e6e60bf17910d84e7179fee14129e053b96
"usb: dwc3: Add optional VBUS regulator support to SpacemiT K1"

Can you check above (for board OrangePi R2S), see if need to implement
similar support in U-Boot? I'd accept this patch if the regulator is
enabled by default, can leave us to improve later..

> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> ---
>  drivers/usb/dwc3/dwc3-generic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 2356b3bc0a..cae627b587 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -724,6 +724,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
>  	{ .compatible = "rockchip,rk3568-dwc3", .data = (ulong)&rk_ops },
>  	{ .compatible = "rockchip,rk3576-dwc3", .data = (ulong)&rk_ops },
>  	{ .compatible = "rockchip,rk3588-dwc3", .data = (ulong)&rk_ops },
> +	{ .compatible = "spacemit,k1-dwc3", .data = (ulong)&rk_ops },
>  	{ .compatible = "qcom,dwc3", .data = (ulong)&qcom_ops },
>  	{ .compatible = "qcom,snps-dwc3", .data = (ulong)&qcom_flat_dt_ops },
>  	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
> 

-- 
Yixun Lan (dlan)

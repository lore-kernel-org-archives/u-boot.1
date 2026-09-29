Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE74CA5FAD
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 22:51:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6D7F60821;
	Tue, 29 Sep 2026 22:51:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N4x4qDkm3fdU; Tue, 29 Sep 2026 22:51:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1AAD6607FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790722295;
	b=k/kaAErI8dpEPnqldJEYxfGKaBhPxDnw3O3yhKs0Qt6eV6U/867WqWtyfCWAzdAY/INc
	 mYj4dVEK4bgN5GUYm8W70LysP6zJgfW/hDoSPLIxWmz1iJDD49/xH4wkOD68xi2BeTwSm
	 7RBZe7kiLGXR2SbXIcmGGTKg0cMNbk7eOIsYijBI5XGZdF2Vzhg00sr2bkU1mKsIhhzLv
	 MsRdc/cb56sL4EGtFj15qTHggvH0iRcVn9wNM6/4D3OQU5vNI5libGwK71/r6+ceDpgao
	 iA2CraEUTIyN1zKPO7GFVhI3QF4dlCWG9Nz0gi7fumbxKBGWLH6f+RNCQJ5876QsMcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790722295;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gk0xHj2SvDkM2lli5tGaBekY/Rylxywg4WNsXQMvfmU=;
	b=lcL0kq9QqfGmWerS3cBXNv/lyI9HWQiB5dJYHHcyaJojt8wLFJqMSe5lzzuV7wPrYQ2v
	 qROru+p3tHw95wEmF+vFlrEdK7QBxTt7rHN/7hhg0K3g7tYAI7SsquzZNntw6EccLnIBz
	 1T+HGIvDk0+aUFxa0auvoaSbCmBf5OQ+A10IF9rWGjjj5z2OxfbuASoWB8yl9jYI5enzM
	 bCMMOs7xWSj0No7D/gynUuMODDsw9z4CbHUzIMzXTolQUQS7blT8M3vxfIlt78XKEZnL+
	 cN9SI2dTsIKIxVvC0LSK3LBWyiQLM2ZdVOS6VuPLrYnohUF4HwGGh2upCE+vYmD7Vhg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790722295;
	bh=gk0xHj2SvDkM2lli5tGaBekY/Rylxywg4WNsXQMvfmU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lw0rbnnBkGgg+5v0HGTxUJAeteHwNdCrj6r1ktMuLxzudDZJ0p2N+Y0PZqAbiq5j+
	 Z/dV1hXV4+4J4OXzpWGGTWkuGN/W7GxFXaXQbD43qXBUwfLRysZ0ggN0lIZJfBNXEy
	 Ya+Gd/Ry3IlFdx71q9ldmW9Yzcff+VgybnPD8B6+67Uv/NUmG2AJmRQsLhC0E2KJn5
	 F23UJ6jwQiqSg/iQ7wDzdH4VukLVCrsJUBmUnDceElXWwc9f0PWgG2UawxPU85mAfV
	 +9+80wq+8RZ2QO2SM2m1R5jhRDV8cHiUayffj9qCnpzp42y96jD+uLVRAxjaem8Zzj
	 wx0+vWblv1f1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AAD6607FD;
	Tue, 29 Sep 2026 22:51:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A057733B
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 21:08:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8618B4069F
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 21:08:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K4lXfkxIwbde for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 21:08:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 21626406DF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:34::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790716129;
 b=OurUFsfdHcC6TqCPuNtBPP7jh5WdL53Q0/KnA2WCDQy0i+sXZe9xJhM695OIbz+tCMDr
 vJmzp0PEEKS/gn84bHqaHNeHONusPYdd73t5hfXiTNlkPuDqArDBOB/wjmEOW7EYd1V4R
 apuiN3yulS3kqmiPJ+tv/5DEsn8OQjcXBkGoWQk4g6kXSGRpGiHV7YKYMwyhvkfN41RAC
 pW9PJUBRcZmJgWHKeepG+QtWp7bjwvJZa8qW9p7B0qbjqayt60LmZUeKvq7+r0hp/5734
 bE1LBD9bPCyeL0tF0VtOiMt2JMTXrKtxqHGhMAC7EfV9ZvHv25JB/DH1YgNTNe41Wyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790716129;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=gk0xHj2SvDkM2lli5tGaBekY/Rylxywg4WNsXQMvfmU=;
 b=DVNxBHkOhfeX0ttA95lsXZFMxkHLEBkesbZato10lE9m/jp5ejGgexMtCmTD2VVnzTK9
 lhEXOUFilKh9WW5pPf/IPfYOwLG5cNv9dzzD0kpYMxtfqJwOsGkE9fHn7z+d89F9E5DIH
 uwMJY7fygzGnEH3MYkUztzzm7JnnHzYe3Zy31QW9sSgUI6hjKopUP/BLi9nVHtCRFK4qm
 DGRqqd9BuUpOblZbtARahf9jtoDiJff5gH8fG7it3mYz0watr9433cj2NTasCZGyhMdjf
 uWe8dwZfSdq57qucZUeMjfzCz6SGlfL/HwZb1fSGW2bXa0DHYKwtogWQd8i8s03FlZA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=R8Bg7mpA; 
 arc=none smtp.remote-ip="2607:f8b0:4864:34::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:34::c;
 helo=mail-qk2-x0c.google.com; envelope-from=sanderson@brivo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=R8Bg7mpA
Received: from mail-qk2-x0c.google.com (mail-qk2-x0c.google.com
 [IPv6:2607:f8b0:4864:34::c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 21626406DF
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 21:08:48 +0000 (UTC)
Received: by mail-qk2-x0c.google.com with SMTP id
 d75a77b69052e-53324cfe178so32402281cf.3
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 14:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1790716127; x=1791320927;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gk0xHj2SvDkM2lli5tGaBekY/Rylxywg4WNsXQMvfmU=;
 b=R8Bg7mpAF+A3PhLhsk/iizewYke4hrpppPxt7KIYAPd2SVcIxVB1Z/o17dQku05xxJ
 YONqsR1184Kzz5aGCGxSrCQr1FCoIQIMA1ahECILUwq1PuJ53a250ulxUq2KDGKeRMwT
 ldPWdqdGvw/x/kMP83ZLwWxaECYGZWDs7DEfINRBI4am5jUINrkc7mk3IJZUl1uJ3vsC
 k2KA2THCMYeSCEU9ij4D9Vuh5jIQdGqSho8kF9evhny3Xh8158WFELdXXoM1o0Zcwwj4
 zziPs/JY1IR4T98fiDP2URobPD8+YFyubAAakAKDHYf4ElPa662O5BXY7t3JkGgEbs5r
 XGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790716127; x=1791320927;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gk0xHj2SvDkM2lli5tGaBekY/Rylxywg4WNsXQMvfmU=;
 b=oMvdAizHohAkpqTddU/OFp0vfrnuV6P8AjBaEi6rotYO6C9cu6f2QXm/MlgJwITTLr
 xwNP1CoMHv/BPt11CpqpsBnry6S4Z+7RpOe5n+si3O4Q/zFn5nbs6BXDakbhrce22Y9B
 FisVvNm0SzhuS1ehEpAppcuQqdl1qWBLYZik8A/0bPOnDrJz851hJVD6pXCAGWjL4BLE
 FQTlBQQpNiA7K5ROQ251cVI0Y4TNzeFzQr83U0UqAEwy5mw1HSsoBAizZoAmPyz1nJzL
 lodatu1eNMQ8stm4ufhAuD1U/p8h4pRdORejZC3pLRSkaD28avI9j2SYD92cAUGH6hqb
 Qobg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/9jJJ7pPYZh5gyhPuR7I4Oqq0m8XUMqQsVVJnhRsirzQfe3+oKtJJY9vXr1U4ra7MPD+WT/0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lJxznledjuY2kXSbsPhH/e42LMtbOMvVB4yvlb8WHsRU0b4EaE
 UjSqha2cCW3nhblCM6MGMeSic5j8mPPL+vGGPAv+Y3xbsumZoySXgUyedAVh+DFfcSc2TlvSy/E
 j9xnSF01Z2XmbwmfCs/AkhHDumU5QhwDLiiPpxl7FlT4Sh0v1iklfQ/NOvsY8Sgo=
X-Gm-Gg: AYBFou2hIi1BzVvygYzdexUc+zbC7U9sURUbIcL4cZ4PiZ22wftx3fE/aNpRj/BUPmA
 taskTAX0tHfjHcb56/1I3Z9JPp/n9z9/vTofNpnmD2IK13ss7q9IWIdPkgxtj4OwE2/aRgGlQO0
 eU0P9AuZUglCw7JVLfmki4X12gp21PySHIiiWMQ+J4kdKj83ZswuhKDFU0UM8zxssghlKlxPubs
 dKveKZLkxukJmwEsR/0dEVQhUovtDEttzSz55ndtDXYqC+Vml6/jFcQ5jR52VHntMJri9A9Ai7L
 Kc5ShxeyQz/N+PI3V5CqyiLXL9KRKBcPBK35sMLKF1JsTVwBa3fCN5ASdzKHT14KvSHaQM/Tw9F
 ON6ev8+tG5RaBPEreDCNq0SNWga6q2XkYLGfkF4fF9e2XXxskVXK+gNrZAwlEORj8Ca/CA6q0co
 1Ed3K8lt4umSTIN+aQXUFtJ2X20jzGajT3VuYj/Q3jPfy5som9BCP7WB0LKrvlCuuNMmjjUvuee
 Fdz
X-Received: by 2002:a05:622a:118a:b0:532:c7bf:7f88 with SMTP id
 d75a77b69052e-5336a4d6296mr10668931cf.9.1790716126998; 
 Tue, 29 Sep 2026 14:08:46 -0700 (PDT)
Received: from [10.200.233.210] ([71.163.254.246])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917987e2746sm4303226d6.20.2026.09.29.14.08.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 14:08:46 -0700 (PDT)
Message-ID: <4393349e-d4cf-4bf3-b4d3-5b6fee378051@brivo.com>
Date: Tue, 29 Sep 2026 17:08:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: mdio-mux: Remove ourselves when our parent is
 removed
To: Jerome Forissier <jerome.forissier@arm.com>,
 u-boot@lists.u-boot-project.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>
References: <20260929175936.3374213-1-sanderson@brivo.com>
 <20260929175936.3374213-3-sanderson@brivo.com>
Content-Language: en-US
From: Sean Anderson <sanderson@brivo.com>
In-Reply-To: <20260929175936.3374213-3-sanderson@brivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 22:51:32 +0000
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



On 9/29/26 1:59 PM, Sean Anderson wrote:
> Normally, all child devices are removed before their parent is removed.
> However, mdio muxes are not direct children of their parents, so they
> can stick around even when their parent has been removed. This can cause
> crashes when the mux tries to access the parent bus.
> 
> Fix this by listening for device removals. When an MDIO bus is removed,
> we remove any child that has that bus as a parent. It's possible we may
> fail to remove a child if there are multiple children of a bus and the
> first child fails to remove. However, there are no such configurations
> in-tree so I went with a simpler approach.
> 
> Fixes: 8880edba06d5 ("net: add MDIO_MUX DM class")
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   drivers/net/Kconfig   |  1 +
>   net/mdio-mux-uclass.c | 29 +++++++++++++++++++++++++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index c057504cf66..5124c4a644e 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -30,6 +30,7 @@ config DM_MDIO
>   
>   config DM_MDIO_MUX
>   	bool "Enable Driver Model for MDIO MUX devices"
> +	select DM_EVENT
>   	depends on DM_MDIO
>   	help
>   	  Enable driver model for MDIO MUX devices
> diff --git a/net/mdio-mux-uclass.c b/net/mdio-mux-uclass.c
> index 14143ca0ab6..a45575f526c 100644
> --- a/net/mdio-mux-uclass.c
> +++ b/net/mdio-mux-uclass.c
> @@ -7,6 +7,7 @@
>   #include <dm.h>
>   #include <log.h>
>   #include <miiphy.h>
> +#include <dm/device_compat.h>
>   #include <dm/device-internal.h>
>   #include <dm/uclass-internal.h>
>   #include <dm/lists.h>
> @@ -231,3 +232,31 @@ UCLASS_DRIVER(mdio_mux) = {
>   	.per_device_auto	= sizeof(struct mdio_mux_perdev_priv),
>   	.per_child_plat_auto	= sizeof(struct mdio_mux_ch_data),
>   };
> +
> +static int dm_mdio_mux_parent_pre_remove(void *ctx, struct event *event)
> +{
> +	struct udevice *mdio_parent = event->data.dm.dev;
> +	struct udevice *mux, *mux_next;
> +	struct uclass *uc;
> +	int ret;
> +
> +	if (device_get_uclass_id(mdio_parent) != UCLASS_MDIO)
> +		return 0;
> +
> +	if (uclass_get(UCLASS_MDIO_MUX, &uc))
> +		return 0;
> +
> +	uclass_foreach_dev_safe(mux, mux_next, uc) {
> +		if (mmux_get_parent_mdio(mux) != mdio_parent)

This needs a check for device_active() which I will add in v2.

--Sean

> +			continue;
> +
> +		dev_dbg(mdio_parent, "removing %s %s\n", mux->driver->name,
> +			mux->name);
> +		ret = device_remove(mux, DM_REMOVE_NORMAL);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +EVENT_SPY_FULL(EVT_DM_PRE_REMOVE, dm_mdio_mux_parent_pre_remove);


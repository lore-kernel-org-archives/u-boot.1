Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284F5C4451B
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 10:16:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 593FD80287;
	Sat, 18 Jul 2026 12:15:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="K5kA0V01";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBB5B80517; Sat, 18 Jul 2026 12:15:58 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41A3C80117
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 12:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so1258484f8f.0
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 03:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784369755; x=1784974555; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=C6AWzS/W2DAbljv9wAgfM8NUYuiTV2ctwb9zDDvJZ58=;
 b=K5kA0V01H9O11fgLR11zyzImRGPzhYjPR8ykDv7GGyn0X2/Zqwy+yb3gSkLZBG1Kxr
 fGm+ZuK2lHvN0moBV0Rtw/jnEx2RCwUEn72+h4v3bQwYt3b2m2PHw+U06u5o2pi5ZUI1
 n4KQQkv50ZrgitLvELhvgvdnADE4QGyEDIQOOZSlOx9xjBoQ6ivF9aG8AN23WPOvchrR
 n7lkh9i207CgehZzdljT4G9roT1ZHAOWo3qHCbv+EXGwS57S6jCMFbgMDYSCU1dF3AkA
 J6nCFwufB4ILkkE+raEhFdQhr3FeI0f2KGmDH+J69XH5c41YaE/MFdf5uIA87biyBO8h
 lAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784369755; x=1784974555;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C6AWzS/W2DAbljv9wAgfM8NUYuiTV2ctwb9zDDvJZ58=;
 b=eu3CqYhUtXpVglDo1kuRHKhGlTSA4japfmAs1kNBcFdl8fOpdCHYGl1TP/cruq5AK1
 kXx1zUYjK1CdmftYDpTeDGZ0WFB+B6ETpyS/zeFZx0oMunqU3SX3yIwvOZ8vq0i2QVh0
 UGMbV90gjRD8LbtXJrgj2FTheiJH8NnXReIMmPEh4HbueU/RVUft1nV0ACNkDB+6NHOR
 2Y3PcCPHFoznpwf9LXd/TaxijMN2vs7N/YWtRfJSOANO3BRauF/Qb4wawHDBTJICix8R
 WAybvWYN47x2iMwq1X20dvhKs7kkdfCr/7eJKU7D4flWKTp0edrsir4JYJjmIwJ0XbIE
 5EaQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqiptuDamKXF6kSwCPU6vsVWmdeepIYTWT39pGd2el2lI+ttBxIJrSuqoxPlSgZ8drzLgzGmCM=@lists.denx.de
X-Gm-Message-State: AOJu0YxEUj947QGBSoJYXIZXnzR8DVMLQLJxtU31iVpsXzySNroId1mw
 p/xtT1fc2tckVH3O0OkfBbgjNQcfC1dohWpi3nD+N+SXuRi3LxfaGWY6rMaf3eKhtsA=
X-Gm-Gg: AfdE7ckMrDkAbUEd9YbY8gDSIUQ+I84cS/05oAq5eu8thjg7USuBljqhVE8Er68S7ct
 GUlSI8UMFZOqVNRVOv1++AepqksBbFl9sXMkhXVuw5cq0LUVp8p/KgPycEy6o7BuEBcb7898kqx
 7Br9cKbIBN1vNwJ8ZrIrKSLIfsDQ+zikvTodixBLD/ePAj70R2zR/lFezyPHmrfJSqwDDgYx73T
 h3/pmFNn/hQhgZBD8LAj07Ih4f6Mm5HMNbdAAXSgttPbA+Ej+uh2z6qiYRrd5fr1vWMAHEBS4xZ
 vfSJ20/JkAe540XaasUXUOAEgXX55ajZj6sz+ubA4j7jj26ra4bE/GVteB0cHYDwIbpm3yfutv8
 /u6IwRkeX9fWghnW2QisjeX0hvXC6JV8xR4p+aWVVWvTAlkdUhodQpvQ+wuaqTc4cPeBVEBC6Z5
 Xm2QmNJ+vF37ZUbWsy48yl9t6cKbgxbaFMWgTn4BI3UUapaCWePv9GUdP7RWpjyA==
X-Received: by 2002:a05:6000:4b07:b0:47d:ef38:260 with SMTP id
 ffacd0b85a97d-47f6230aca5mr7999206f8f.27.1784369755507; 
 Sat, 18 Jul 2026 03:15:55 -0700 (PDT)
Received: from localhost (host-79-16-115-126.retail.telecomitalia.it.
 [79.16.115.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63edcf8dsm12390408f8f.27.2026.07.18.03.15.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jul 2026 03:15:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Jul 2026 12:15:54 +0200
Message-Id: <DK1MACIGH68W.BZCEOOOEM7EN@baylibre.com>
Cc: "Ryder Lee" <ryder.lee@mediatek.com>, "Weijie Gao"
 <weijie.gao@mediatek.com>, "Igor Belwon"
 <igor.belwon@mentallysanemainliners.org>, "David Lechner"
 <dlechner@baylibre.com>, "Julien Stephan" <jstephan@baylibre.com>, "Marek
 Vasut" <marex@denx.de>, "Tom Rini" <trini@konsulko.com>, "Vitor Sato
 Eschholz" <vsatoes@baylibre.com>
Subject: Re: [PATCH] usb: mtu3: wait for TX FIFO to drain before disconnect
From: "Carlo Caione" <ccaione@baylibre.com>
To: "Marek Vasut" <marek.vasut@mailbox.org>, "Carlo Caione"
 <ccaione@baylibre.com>, "GSS_MTK_Uboot_upstream"
 <GSS_MTK_Uboot_upstream@mediatek.com>, "Bin Meng" <bmeng.cn@gmail.com>,
 "Chunfeng Yun" <chunfeng.yun@mediatek.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0
References: <20260717-ccaione-upstream-mtu3-tx-fifo-drain-v1-1-f867bdfc5d00@baylibre.com>
 <804b4b7b-3c81-418b-81da-bacee46b8d46@mailbox.org>
In-Reply-To: <804b4b7b-3c81-418b-81da-bacee46b8d46@mailbox.org>
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

On Fri Jul 17, 2026 at 5:21 PM CEST, Marek Vasut wrote:
> On 7/17/26 3:05 PM, Carlo Caione wrote:
>
> [...]
>
>> @@ -66,6 +69,28 @@ static inline void mtu3_ss_func_set(struct mtu3 *mtu,=
 bool enable)
>>   	dev_dbg(mtu->dev, "USB3_EN =3D %d\n", !!enable);
>>   }
>>  =20
>> +static void mtu3_wait_for_tx_fifo_empty(struct mtu3 *mtu)
>> +{
>> +	struct mtu3_ep *mep;
>> +	u32 value;
>> +	int ret;
>> +	int i;
>> +
>> +	for (i =3D 1; i < mtu->num_eps; i++) {
>> +		mep =3D mtu->in_eps + i;
>> +		if (!(mep->flags & MTU3_EP_ENABLED) ||
>> +		    !list_empty(&mep->req_list))
>> +			continue;
>> +
>> +		ret =3D readl_poll_timeout(mtu->mac_base + MU3D_EP_TXCR0(i),
>> +					 value, value & TX_FIFOEMPTY,
>> +					 MTU3_TX_FIFO_DRAIN_TIMEOUT_US);
>> +		if (ret)
>> +			dev_warn(mtu->dev, "%s TX FIFO did not drain\n",
>> +				 mep->name);
> Shouldn't there be some interface reset on failure ?

Agree, I'll issue a reset.

> Shouldn't the failure be propagated ?

I'll propagate -ETIMEDOUT in v2.

Thanks,

--
Carlo Caione

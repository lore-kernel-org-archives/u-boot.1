Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C29CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 09:24:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 423FD60601;
	Mon, 12 Oct 2026 09:24:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BpXgp4mQSGti; Mon, 12 Oct 2026 09:24:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8FD4C605EA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791797040;
	b=Lf84zlvyJ5QijG7HwM0NBJO7ZZ8VGAXDtDTYG89rG5i3fMCpKw3YLOlD68FJOpBsIdV3
	 0bjKUGDNW0lAw+1SeFgvVvNOVIw2x89lN6ZUvjfUgNJXyZhuiW5xXk1U+NjU8Xf9x8Exd
	 nLtO8cmhCnciUzHNH+odoBujF/8dWwrUohcepM4QxAZ6MXm086S6Sxra9ayRMmIL7brny
	 VQg6/Wuo1UgD8uAPT6/HI/PSgdDnWNpKnegl7hxRA4c5fSCt5rTzIVRiXp0IsyXiW5oZv
	 yveNVsMmDTuRPYTKsJED+ev/NY27jHqoX3SwL29Um5RylHYFC5vCkwX/2c6vgc8Kv/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791797040;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=swUimynN72sBvBBnsSN07T8EcnE4KZ5ih1p2K07utiM=;
	b=rEZxhp+j/1GCl31c8JvRDArptwexasnB23jI33MOBjgrGrzfRx6ObMBmz6mXmDs2ssG8
	 TpuOdGSSY6zK8QuZorAhqnbte6zL+XjSw1l0q0+ooZpuyxeYdqKeAajxfk/B0OUoyur1+
	 0UqMkZJvY8c/Jnn880uIgbENH4Rw+CZqnTuGzASNl7VpFeYsnBZDbfad3xoG7SuDZb90v
	 EqH1ZczPSqE3Czq9nr+axqEjmuIeyNCV38IZyF/wwjysPFoyOy7oGyDT+FdFKRS+UrhnZ
	 mSdZmllGt9rNggbLz3o1J1rjZwnlgRGIYWM3jL0EVn0s79/XTFWFUMWFvqapssonEGw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791797040;
	bh=swUimynN72sBvBBnsSN07T8EcnE4KZ5ih1p2K07utiM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xZ2CRivpPjPda9VKlE1/z6cIGb9rjUwxuTt9ve8zgH6qi78CE24BUElwH8Cx4Uhkc
	 JaF8LNvum+DGoEu1GP1+QYfGEQrxrZpE2Yy7y1fNlQB6HaAm5tOr0rQG384M/QPRy9
	 w0tL5CakZJEj3qC0SKQ5x61VTNm0PvWkct7/jXB/xV6vAysuSlZKLePdPeVWtbfk7u
	 dBsrktq/7Vkc278wLyo1KPjNmdJNBu/N0houVgQ8O4HtkEnOXc+UQvUnAirJPz6sZb
	 7R3YhBthveaB/w6Im8hMYIya/AUqEa1ueCBNAS+7KbnWvBzytFhJ79h6GrVOO2FXZE
	 O7AfePQjxLo1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FD4C605EA;
	Mon, 12 Oct 2026 09:24:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C340B2E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:23:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B4FA74008A
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:23:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8qB-XA2d4s0B for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 09:23:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 64A5140024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791797038;
 b=FXFpsxRjTgPnKcIsCB9kYSVX2Ln1cw44w2ulAslk10re8p3vpn188xpoAr2L6z4IY2tm
 uhcD17N2djyWZmaymTxmC8f+lNeGDYAEXh6Ts863DV+m1Ea9L52DOtEHLjsB7pXAJBPhH
 qRrq4g/3B8VU2bZB1XaXtcE8kSzn++4KKIVGsSNn5+HDbaog6tf/fvdaR7V9GcurBd5e1
 s/cfmiz8WId4LARFQft7WIxm93y0N3Yp1e+w2qD1BMAnOLRD4+EPKUat24DSWDVJKzac8
 7zS/jTfNqK2vDcmtfHVctlbJvtzSWSiIVlmmWNon6sqZQQE/dKkg4grzeDtaRUP/DFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791797038;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=swUimynN72sBvBBnsSN07T8EcnE4KZ5ih1p2K07utiM=;
 b=pecQH844KvXJlFwMhfPqAsJmFcnQHDvHrwkyBHIv9VU1bCidq6GRG8xrBEM4xz7S/mwx
 eorDd7i2Ws58v/aZOMNiRs3SY5TyIwuzPFrvudt9bqd3LlMhgC9QdFFE2siVzsdlQM9l4
 FUXWgfNVVKIYh0l8au/xEaTXulOeJCzRZwlriRWEFUnN1AhVl8zIL8tlWCvYkDXSg9R8b
 90yWhUI7BQYh57+QD9fQxvqksatmBSJCsL5i0UNnE9gaY5dLNEG27wW53v50TISPIAZ0l
 Arss3NFqZFowLi0rUxVNRiCWwzodGdH5HvGYbroZZA4NTNA3DbDmsRoJNST9AzfuVzA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=G7OEkKDK; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=G7OEkKDK
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 64A5140024
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:23:56 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48b0946c2c2so902076f8f.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791797035; x=1792401835;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=swUimynN72sBvBBnsSN07T8EcnE4KZ5ih1p2K07utiM=;
 b=G7OEkKDK6MOIfj57Plj6TBHXD9Z5OuSWzDMVBDnyx7BuSamYjkxfB/RdJT0mqk7ETX
 FJ60CxM1ERCC+Cb38bCBqf8+T53el3VoGMj3S3ejMOfaD2zrO3CQULuh+z0kvakjw7ux
 MQkZuSNGAX6WbtjJKaSKhixNbj3zWOeC2kvveUfb0aJ1S/H2FRc1rM+KY6W4LzoLgTYw
 UaAhI0BZfR1FilGh14ZVGIXnxsojZTGVBnGqYhV9x35790LT3KRr26h15+XWG5Jf4uzm
 LCNZcVTLBunbhmR5DFImw+7jhIzrqOe4zuj910crH0v2QbPJulh4bKGKOdtdNsK5HQgU
 +veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791797035; x=1792401835;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=swUimynN72sBvBBnsSN07T8EcnE4KZ5ih1p2K07utiM=;
 b=E4HkuZJdCJ1i5NCMvFy20jLwksN+PTJZvH/RaOnXBmVVTRyB0gBEnBEHuaaSc4W2gd
 vLp8LiBf6bzGm2wubl+44giGQqnav30pYuSbTRb1BrtKQjeC3Fp8Q01h9XrZU+AxeIWK
 MCCtdsq85WTOokzw+a9V9qwKQFTIWnhL5zIf0HabOy52+RiKY2C+g3niTZTkWen8L53C
 1Uq6S377lX8zfk0i05ye95YiGEh43oC0xh4jSiYSXWrAq2whKLFNqvt3lGiyyExxa5Fb
 X01wTyVQ6fr0bdvZqOGBa9nfjCcLT15N+WUTzgolb8nFXEhKikNObfKGlzyQCD/9E4bW
 4jPw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz31jCCtCOd59s312VBJc1pEHFVzxHpK+He3zHBkqmxQIrvVLb1JNBsdGjhaZhHY1fqEoGFjRM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKFgaaNcZi6BposJd+v7rmRoYzXdkzmNFXb1n/LrjIsBnM7Uz1q
 FZAeSuQ8+h4YahOHXDifvV/VwG6CWdi0w4yHtGS45pFiT0a4sKSIKL0+9HiMm2BYuPU=
X-Gm-Gg: AYBFou22Me+6ONvdBnPf1ZDs2NzwvjfGTuhrZvnI10m0CdWU80cg2P2isopYRrIlkU9
 2FxTBScAF3lVm3Dc/ZqN3HUdSJtw+lpxvgTDOc61v4xqvlg8glJc8MjDnbkzhCVms5pPCdG1LTm
 df7I++Zkf9xT7J2ufRAIABVdMDQl0cOe11R7Zt/x0qjoqvNBIGVHApeQlZFppWwsKBQBUNAEil4
 w96u8/TElEZzpmBMy49N+2uKMbryba+PbCxstwePjPpGWEhIsqV2z+J6iR+LVrRiPzs9qFph/RQ
 JcNwvDJq8YjvCWp7lVNMAWaFO+y8Cmv4L1aYBWv22UMyJwwis9vG3tY/1Yt10TotOvkSZ9wSF/R
 cJ/p4wyCODpqZ+etCNU0zbHGJzMqlVokoTsw/JHjmDz1BdyLbhfYqdmFiVCIOEagyGCs+VuGf74
 aXrvPMQEw052nwiEjDCWFv9T0hw+gmAJPLpXcZe+C5XrbhwTBV8GcHnLFNGwGdFGhyUHb4CSepN
 fCxOiP3CqrE/QNvfKemq8euDMQhlwaPVPQcCbVtrBiVIUmmrHQZ8X3eiZvS5xpTRr3Nyo424XAn
 9Cz17JtKQqBTMf47NvW7zZ18YCteuNqllIEEMJHfZfhXkm9mU8T+mLY=
X-Received: by 2002:adf:e80b:0:b0:487:342:d141 with SMTP id
 ffacd0b85a97d-48dbaae8b8dmr11734151f8f.23.1791797034444; 
 Mon, 12 Oct 2026 02:23:54 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-8434-7c41-c701-f269-609e-a542-3b36.rev.sfr.net.
 [2a02:8434:7c41:c701:f269:609e:a542:3b36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dd21e6b5bsm7554779f8f.40.2026.10.12.02.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 02:23:54 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] power: pmic: mtk-pwrap: add mt8366 compatible
From: Julien Stephan <jstephan@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <20261005-mtk-pwrap-mt8366-v1-1-db6b3d29ce17@baylibre.com>
References: <20261005-mtk-pwrap-mt8366-v1-1-db6b3d29ce17@baylibre.com>
Date: Mon, 12 Oct 2026 11:24:10 +0200
Message-Id: <179179705072.53105.1799121012568085109.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1791797054; l=596;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=3QF0ZiZFjH5dZDU42IDEn85RiXRWfBbeLaDq/kKguo4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QE85+cbqnYqocwtePhIXhIi4/KBBUJPyUclYAV7Om5nOWzhoFrPhTjtztso533of68kKiPb3YND
 LKEl2LOoBdgQ=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
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

On Mon, 05 Oct 2026 16:33:20 -0500, David Lechner <dlechner@baylibre.com> wrote:
> Add a match for the MT8366 pwrap. It shares the MT8195 register map
> for everything this driver uses; only the interrupt enable register
> differs (INT_EN is at 0x450 and there is no INT1 block), and U-Boot
> does not program the pwrap interrupts. Reuse the MT8195 data rather
> than give the device tree an mt8195 fallback compatible that would be
> wrong for an OS that does enable them.
> 
> [...]

Reviewed-by: Julien Stephan <jstephan@baylibre.com>

-- 
Julien Stephan <jstephan@baylibre.com>

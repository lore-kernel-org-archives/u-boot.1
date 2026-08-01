Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF4CC54FCD
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 06:43:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 425B160BA5;
	Sat,  1 Aug 2026 06:43:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qdVm6henlIGq; Sat,  1 Aug 2026 06:43:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 081DB60B8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785566584;
	bh=LuzpVggCxCXxVmeoJGDptvkuoevMvXNJn0x87c6mM7E=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ckmuC3CNkrg/X4+UP8ADMBsmD79czWZw1oUhBreFf8JQJHUoSvVHCHu3h41/AOYeL
	 xj3JuM3++7ZFHNsS53LWIzTS3rHghKODMpFN42v0PS4pouO3/FT7Q+w92rJFUIq8ov
	 wAHLlMLibSdhdvJkvT7y/zo8sbVgsvTOqY+NLl66OBgTGOllCYTjVXPKEuoKgyepEU
	 vslt0QOvbUj/Yh7a/DixRqoeqA2508zZzDTErNT472u1KYGAIw8B57mO7lYcPTzrhE
	 IuJoiuZ1lNjqmgscNb7YC+7cVveU7+qE7QvicnH1Yz1Zelk6ctMGet1oRAc4qQVqCl
	 tBMQ2UjpVORLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 081DB60B8F;
	Sat,  1 Aug 2026 06:43:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 382233B6
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 06:43:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E13F407E5
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 06:43:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TV6IzToJrxJl for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 06:43:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3FA1340684
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3FA1340684
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3FA1340684
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 06:42:59 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59FE3844F6; Sat,  1 Aug 2026 08:42:55 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9367480117
 for <u-boot@lists.denx.de>; Sat,  1 Aug 2026 08:42:52 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-495757ccbc1so4551595e9.2
 for <u-boot@lists.denx.de>; Fri, 31 Jul 2026 23:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785566571; x=1786171371;
 h=in-reply-to:references:to:cc:subject:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LuzpVggCxCXxVmeoJGDptvkuoevMvXNJn0x87c6mM7E=;
 b=K9qg1MnwEAqJw9t2h3DOj8Jm92CfLpTsqiY5ilGUUz4hI4txcsjjB5mlkapbfOGOSj
 qadWw+mIrfnRq/LzrxkZMF532YMX/bAZMp98E4NRANCSClnrsX4B1ZK+LR7IPqAeRm7t
 yP1EroGrg2L9mOGiepc1SOio+Viyt88HRpQ6HcUgS9981RVJBay9t8gETTgnd1W1DeZ3
 dy+vv+3CTCwpQrIyar8xAvu2o/BMTtZmTsL85vBz0+jb/XeHIgHZ/bA0g5w8Az1yDjUH
 CInzvJkv6rVwjtJVLAXezhcInN13zFcPdkgmzOJBXuCShUEV0CWQONWe3eT3QWzT8PIv
 lbMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtfN81wOUGzthXz+lvqz7WKcwzvXIghB6zAQkGw0rJzPm/sDjUtb2n+J2FJf47sgE3VRw8TU0=@lists.denx.de
X-Gm-Message-State: AOJu0YwhoxAaxD4IT0g9BWT6pIlHg47MK0m/3OKYtM7gN9hGxRNmyIhy
 m0nAIBrT5bkT124DRv1KfTnvYjuBAC1UUNR9Wbmnr/ku9uxEjYWnffUZMe9hZlNUfQs=
X-Gm-Gg: AR+sD13C2haPraz3k01cU1c9h/vRgoQmEfpKVEVK6GK5lWrXh8pXJqXGeL49I8u57Zh
 M8jnAvTn0waizhXuUy8EdTdvQwk7RO3v8RCoBKVd94sY2DxZUr2yFjW7sjtZfUV5i1VmclgHH2H
 lVRid4Aheb9j3gYbMsZ+D9dybUg1YNj9aQjX1I89lJKjo0vNEhkGWTiMfqDFeycCMfI2caGocv7
 fC+xy53EJ24dBkrJfQ1iA7CZtff8CKEvcmCdL/39gfyGUW7XomIYh6clLWk7K1Cq7nRuL3xL6Jj
 mR96S1JD/XNpEZv/OfO6NvijTX+MG/yOMySvWyrmQpUjFfxxqrO3wnJLyrKLB5VQStcnAVqxmOr
 aAHnQE68JcI7JnOqYrKORN7w1/BqnrUxw3rxqrCP5k1QNCbOKl/lFUZrvxNzP7KPevEhnxPHShT
 KbYRXNJwr/Grb1CZ1Q5UbKP4KyPaZyD+PJl+3tFqK/tzStR9MZ+ePrsoZsLW7ckXYi6Go9Ysw35
 TQbyCHsqnBMy/GliyNs5bwrxYmCY03qx3fXhn2TVuW73/wuigo=
X-Received: by 2002:a05:600c:46cc:b0:498:ee7:e407 with SMTP id
 5b1f17b1804b1-4980ee7e5e9mr15803135e9.17.1785566570721; 
 Fri, 31 Jul 2026 23:42:50 -0700 (PDT)
Received: from localhost (host-212-171-227-71.retail.telecomitalia.it.
 [212.171.227.71]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd458adc9sm14137578f8f.27.2026.07.31.23.42.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 23:42:50 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 08:42:49 +0200
Message-Id: <DKDEITT18XJS.18WZM0Q9PGROO@baylibre.com>
From: "Carlo Caione" <ccaione@baylibre.com>
Subject: Re: [PATCH v3] usb: mtu3: wait for TX FIFO to drain before disconnect
Cc: "Ryder Lee" <ryder.lee@mediatek.com>, "Weijie Gao"
 <weijie.gao@mediatek.com>, "Igor Belwon"
 <igor.belwon@mentallysanemainliners.org>, "David Lechner"
 <dlechner@baylibre.com>, "Julien Stephan" <jstephan@baylibre.com>, "Marek
 Vasut" <marex@denx.de>, "Tom Rini" <trini@konsulko.com>, "Lukasz Majewski"
 <lukma@denx.de>, "Mattijs Korpershoek" <mkorpershoek@kernel.org>, "Vitor
 Sato Eschholz" <vsatoes@baylibre.com>
To: "Carlo Caione" <ccaione@baylibre.com>, "GSS_MTK_Uboot_upstream"
 <GSS_MTK_Uboot_upstream@mediatek.com>, "Bin Meng" <bmeng.cn@gmail.com>,
 "Chunfeng Yun" <chunfeng.yun@mediatek.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0
References: <20260720-ccaione-upstream-mtu3-tx-fifo-drain-v3-1-45c0e072b64a@baylibre.com>
In-Reply-To: <20260720-ccaione-upstream-mtu3-tx-fifo-drain-v3-1-45c0e072b64a@baylibre.com>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785566571; x=1786171371; darn=lists.denx.de;
 h=in-reply-to:references:to:cc:subject:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LuzpVggCxCXxVmeoJGDptvkuoevMvXNJn0x87c6mM7E=;
 b=d4AJpGXoot9WBjLdESIah5Se5MNGSfB7o0rmMiUpkm0cD8JK0sh7UGYVdNST3Z/2m5
 NX5jXpl25jFh2LhmWJocgqF6xlfclsxwDSd6GWXBWjvFKH+pbJ+U5LhZSSeVh9dBaptR
 VciaedNzvf/dssr3+eEJ5raC+yW7Iq5OdR6nH/oapqw8M1TB4ZtKxqgb92n1urg+puUj
 4Q4F0JDdiWi+4IQZmV8Ib1EaGsNlV2FTuuLEynidnO0bJVI/oIDnYbcGTtiRuuHKYcfi
 ozjEN9VPbtD2BgodHvEI95F1numuFpJEx+DclbRCwxKWd6Eqz1meFEAOQFlOK99R2thF
 uYSg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=d4AJpGXo
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ccaione@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="d4AJpGXo"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon Jul 20, 2026 at 10:03 AM CEST, Carlo Caione wrote:
> Fastboot unregisters the USB gadget from the completion callback of
> its final OKAY response. MTU3 QMU can report that request complete
> while bytes remain in the endpoint TX FIFO. Disabling the USB function
> immediately can therefore disconnect the host before it receives the
> response.
>
> Before selecting the high-speed or SuperSpeed disconnect operation, poll
> the FIFO state of enabled IN endpoints that have no pending requests.
> Bound the wait to 1 ms. If a FIFO does not drain, reset its endpoint,
> force the disconnect, and propagate -ETIMEDOUT through the gadget pullup
> operation. Endpoints with pending requests are skipped so an ordinary
> disconnect does not wait for an active transfer.

[...]

Hi Marek,
can you PTAL? Thanks,

--
Carlo Caione

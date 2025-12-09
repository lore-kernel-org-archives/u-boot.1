Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D43D3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 15:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D60D283C91;
	Tue,  9 Dec 2025 16:03:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sHFFz1dh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC15C83C64; Tue,  9 Dec 2025 16:03:19 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43A3683C40
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 16:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b7a72874af1so85951066b.3
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 07:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765292581; x=1765897381; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KxzJcDKJq56KdTp6oNujgL5yP+U2JKqjYUvOC38LBgM=;
 b=sHFFz1dhSYWU4GsVOOR9qOYz5vY14KCC5SUlEIM9dry+NDzimCJwkQ9b7iUoIO0EoB
 H3j7kG2PKn2HxkzuQ7LpfnxVOE17jUvV6L6NtbZZ1rCho5W4NBfNWjV7bB491IqXcde4
 F1fZw6tlpbg4bYWnfnmA+rBSiQ1rozDMWgkMPkKSYGMPp2O+AkIJDk714ZbaAULtlmUz
 5b4J8yZHemT5xgobZC3gD2ERJz72Tb/KcuiW2y3nCGPIOJfd5QYGyWBbUe9ribTbpk8S
 O9gNC++4UseQL2I95/TW09pBdvoneayniYXQuJuh8dBJD/bGHppCBco4/mAPuTqdqhAs
 fBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765292581; x=1765897381;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KxzJcDKJq56KdTp6oNujgL5yP+U2JKqjYUvOC38LBgM=;
 b=RTejzffaxQmkHMqpFwB8iw0RgZwL6Q7c8pvrtpcd0jROY2RJV7Kt/rHHRqmId7+OTV
 A5hsvhjKaCcqMoOwZrqSBtoBdV+HXViAojCwhMrnHcyAE7aL4fxe7PxOC3MbY50MZls8
 pc1hdmbXsTJUktujLaoCdCB32osbdfL8WzSlNTFry4Af6r2Piks6hoXnNAcr43+HOUt0
 OtepxAKncJX03+Rg3UTsjRkmP0tBYhOf+ZM9eieTkP76mHgXGHZeumUFGw+J0VYZMX91
 hmfS7v/+/s0oqgh+SSapXmXcEeePfDgTehb/aY2olS74P4z0AIAS31wLICPV/fu845em
 sANA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFv7PekSqHFY7mLyTbeuoe3pe98JJyoqnoGPbt8FaQD1JDCMqshpUPZYaFhnR/IYFpQJN/aSI=@lists.denx.de
X-Gm-Message-State: AOJu0YxhZZy4eB9msYVa8aqt/Zq5wFvG1nPGQS1tFw7kQooHRJ+AastW
 xfRoDpM1xpicLgbeoGMLPcj/TZfjKPPapEN+dPXMoYhytJGCSU+G088cTBXs1JnN8E4=
X-Gm-Gg: ASbGncvsGN1h9izQOOTYPaxarbChPwg0yjHWweOaKnbOh4F8giUL9Eeo1ssXqa3bhhA
 WnqDinLGjjGsxRsDB6B9BpIqhABpWCJt/vqVHFTrfrlxVnsvIE1ZXE2Fk4QaVkUzeKmhGxZZE2w
 L+HoZGBWc82jkEB731K5J6yf0ZrhXgC5QvyR/ofC7hzi8GbBDFDgiu+MhJbH26ztcAhic/oAZOv
 2Oc6mq3mDb2Z6tzEqtjVwhuh1rg6WNL0WnyfQkTzpqpJg47k5AlgdWD/W4uMEJIjBcKorLIUnJK
 nnhaYwG/QUJtVgOnY502XvD41NSX9u0+TQx+9/yKmwDDAEoLwfungeUEKb6QbbZCAcfOF4tnYnT
 cZNO0n8WFsgXvPUlH2QM79Lnyh/YZKbsk/OjyEqSudB6+TtVRFe4FWe7jdyW0DYhnfu/VUoBCez
 V1ZO8rsjv8aTK44jT+hWbq8A==
X-Google-Smtp-Source: AGHT+IFIVprGQQkGqpah7w9QtE06dEVfVnwCUrWXIBz/1UCl/6uhAxRIyiEcKbvK9gcrnsjWCsSGMg==
X-Received: by 2002:a17:907:26c2:b0:b73:6b24:14a0 with SMTP id
 a640c23a62f3a-b7a24324539mr1130925966b.18.1765292580478; 
 Tue, 09 Dec 2025 07:03:00 -0800 (PST)
Received: from [10.100.0.2] ([194.15.111.143])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f449d181sm1438041966b.26.2025.12.09.07.02.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 07:03:00 -0800 (PST)
Message-ID: <f3000518-8ddf-49ea-80f6-077da7f009bf@linaro.org>
Date: Tue, 9 Dec 2025 16:02:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] net: nfs: Add licence header
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Benjamin Hahn <B.Hahn@phytec.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andre Przywara <andre.przywara@arm.com>, Tim Harvey <tharvey@gateworks.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martyn Welch <martyn.welch@collabora.com>
References: <20251208-lwip_nfs-v1-0-1f5d31e15d00@linaro.org>
 <20251208-lwip_nfs-v1-3-1f5d31e15d00@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251208-lwip_nfs-v1-3-1f5d31e15d00@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Andrew,

On 12/8/25 13:52, Andrew Goodbody wrote:
> Add the same GPL2+ licence header to the NFS code as appears on other
> NFS related files.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  net/nfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/nfs.c b/net/nfs.c
> index 537d4c62de267527c85c5b1ddf2cda696f4ebae4..7bae7c78642cb33e5040c44ed9d0378222069923 100644
> --- a/net/nfs.c
> +++ b/net/nfs.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * NFS support driver - based on etherboot and U-BOOT's tftp.c
>   *
> 

AFAICT this is OK.

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1AEC71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 13:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3045682BCD;
	Tue, 17 Jun 2025 15:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="vepqLvcy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E087C82C87; Tue, 17 Jun 2025 10:27:35 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F337981E18
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 10:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-60780d74c8cso9848471a12.2
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 01:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1750148853; x=1750753653; darn=lists.denx.de;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fb3tWC38qrfMQmfjHoWH7A0eCJsYkvUE9kNqO0ffKCw=;
 b=vepqLvcy/9hEl24lGqdKuR78YNmslsbIlribFtfd5SxniJ1joVmj2PMakP1/LEwhmv
 8PFinc5Qr1eX8VS/xJICuD72kRDPzRDdxEGtI7X7E2NmbyP1quA2yNpIwQr6lOniRdPA
 nKSybOtQM9pXOlAAg95FHJXlwve4htkNpnRmhgbCsN0/O84QKeBfXolQTtUyog4d/+kp
 yxSQWt6CAhaaH+74GLn1ShcgYE6y908Rc7lOWkpuDzcMWxKFfiy6k2YReqQqC/EqaZ/I
 Jv6rSxnCfhpPeK5Du15vyVU34nGnpoXNwdeiMxSPYyK8sqRDWnXetR0fZKIiUE3Qjk8f
 IP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750148853; x=1750753653;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Fb3tWC38qrfMQmfjHoWH7A0eCJsYkvUE9kNqO0ffKCw=;
 b=inrkTVEA1Tz90opmQdJHOWt1y55dtOremOFY0hl3EJ5g++6JZ9n59Rk3hp1CsPh9+s
 7N/VGWAy4E19p8oAmiiiPbWyxMCqICf2Eu8KqCiRQ/dRzh8ZL/frs+/fBl//tqQzuwvi
 PGSXsYo8YJubIcdMHJ8unY5z/Kcr1Nc7A28qmV3c5/mBPL/oe+EzIL0nZKRWrN6mYWjb
 +i3RcnaZjfbS9hbmbBrVXk4Ksr2mkzNKBAS75TyN89/5T27LilBYz1aLZJkYPgOF6tZQ
 OK9PA2+32lBxrudPWgYXLGpNumu7CBTemHMAtGgU7DbyqslkPrFG6qnQi48v2DzWKEsE
 iKEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv5neOKalEO2WMfdojj7/6BLwdiirjh/Rh28a0rM/iKvdjioioiLkZvNd7fIADZ+yTR7Geetg=@lists.denx.de
X-Gm-Message-State: AOJu0Yz268IcxiDntNSCDPvqmWP00U9HXyGY7711Cp3ochQGj/7aJhNn
 z8zsqaDJzuqgAJRo8g7eVK7LTsFrmjmekqVUtMvuKDCEVCfgw6hAiAi40FUWqwYOf58=
X-Gm-Gg: ASbGncvmeGXiP234JpNRWeanxudut8d29YxXyRv/U9OabQxDERsCzHdBafQ6Zml2NNh
 2uxc6W9Wmy8umX4D90IXwhsQSyVgSyVRCU6A9SWlxl/KXDQptQeCwQDFCiUBoOWH5ICSKUiEbqj
 qSWI29SlCv6eKMNW1mFcN1RFJyB6jVXCcHi4gwJazInwALnUD4EeTc33mHy+3eaN+GgrdAABD52
 zDqPTRQ59fGjfKk/otZxprTjEkkbYTv4sMjPZVy6UXnQ7nvefxQSJdw8cNEPWO06qs0DNuIh8xn
 G/YtEI7Ukq4j2efJ4OAC7LrITSCl+6vDzmqWKTa40WHhbEVodc9GvgUrjvnc52KHEUyARnPdTpy
 UJimo0k1xJdiBtp9k23uSeqB3Kr4eTJo=
X-Google-Smtp-Source: AGHT+IHPKnsNM9Myxjk2irDZRpItRAxe2+g3LSq7/Rnhd9pd1eqcyaKD7HyICF7c1wM1+XAkqf3pjA==
X-Received: by 2002:a17:907:2d06:b0:ade:433c:6405 with SMTP id
 a640c23a62f3a-adfad354a32mr1240394766b.21.1750148853319; 
 Tue, 17 Jun 2025 01:27:33 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec8153529sm809804166b.23.2025.06.17.01.27.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 01:27:32 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Jun 2025 10:27:32 +0200
Message-Id: <DAONZND9ACD3.35GQ47V0IVE46@fairphone.com>
To: "Casey Connolly" <casey.connolly@linaro.org>, "Alexey Minnekhanov"
 <alexeymin@minlexx.ru>, "Sean Anderson" <seanga2@gmail.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Sumit Garg"
 <sumit.garg@kernel.org>, "Tom Rini" <trini@konsulko.com>
Cc: <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/2] clk/qcom: sm8250: Fix variable name of msm_clk_data
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250611-qcom-clk-variable-names-v1-0-37615b74daad@fairphone.com>
 <20250611-qcom-clk-variable-names-v1-2-37615b74daad@fairphone.com>
 <267f957f-f74d-40f9-a65a-da00ea12810c@minlexx.ru>
 <DAL7BBN0YH1Y.1HOHC7JM44TFF@fairphone.com>
 <6857eb08-c3d8-4a02-b8c0-b608977ffea1@linaro.org>
In-Reply-To: <6857eb08-c3d8-4a02-b8c0-b608977ffea1@linaro.org>
X-Mailman-Approved-At: Tue, 17 Jun 2025 15:01:34 +0200
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

On Fri Jun 13, 2025 at 6:55 PM CEST, Casey Connolly wrote:
>
>
> On 6/13/25 08:45, Luca Weiss wrote:
>> On Thu Jun 12, 2025 at 5:49 PM CEST, Alexey Minnekhanov wrote:
>>> On 11.06.2025 15:08, Luca Weiss wrote:
>>>> Update the variable name to sm8250_gcc_data as it's in the sc7280
>>>> driver.
>>>
>>> Hi!
>>> But why are you mentioning sc7280 here, while fixing clock-sm8250.c ?
>>=20
>> Copy paste from the other patch :'(
>>=20
>> Will fix, thanks for spotting!
>
> I'll fix this while applying, np (already picked this patch up...)

Thank you!

>
> Thanks>
>>>
>>>> ---
>>>>    drivers/clk/qcom/clock-sm8250.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/clk/qcom/clock-sm8250.c b/drivers/clk/qcom/clock-=
sm8250.c
>>>
>>>
>>> ---
>>> Regards,
>>> Alexey Minnekhanov
>>=20


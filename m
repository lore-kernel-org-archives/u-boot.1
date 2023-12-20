Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE1EC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 08:51:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C298087695;
	Wed, 20 Dec 2023 09:51:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="DtGFwc2p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D40D87695; Wed, 20 Dec 2023 09:51:22 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A835287480
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-552d39ac3ccso944831a12.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 00:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1703062280; x=1703667080; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NKC0RIF5PH0nL/YwFwQUJ0O42qdNPOjw7t5j0XDRLj4=;
 b=DtGFwc2pqrTYJ6HynpCglSAGBX8Ah9vggKk7Yn4MSSRI8NutP5BoN8v8HKByZgeCXT
 6E9EhrE4TGr5fECTY+m3euauMwX7WBDCysTJLy/iCZ3AhXoSzbrQePNgFjsReyAk5GSF
 r4Z6mxEYWfxjzXvALBkY04j3EBPleBQRV/pp8vhkaYKYEmshA+a4Wouh9426mUD/+YiZ
 lk/uT0yWuNrovdE5U8g3mLFYo7rpvezZzzFkIGsZvS2CBLrgAl+otSPJWvyXawbK2Z/w
 /DCflSapNBM4cj710wERciHYtOv5oKgD4YtfPb/D+cWRg7KhnrsRjmvVV1H6CcL8Hs3R
 A0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703062280; x=1703667080;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NKC0RIF5PH0nL/YwFwQUJ0O42qdNPOjw7t5j0XDRLj4=;
 b=JPTWbTuytTy7Oj8W9/NOUc1H9in0Ix9SN/8jtvdxHtwrqXnZ72Y2ix3vUfshezhOIu
 7Tk7Pt4c9cD/0c/2j0ADUZdPLSAucOo5yKAaoezPaFg/f7yu2NrzVtF6BCxYTKJaXa8I
 hN+5OCmRIkDAwlE3U6yRrQfndz1O+UQEnsjKTNwmaKvaP02by/i5IMmnxo9piUnF35V1
 Cv1sWkG3VTqsNu4w8uoIuvn8P+5HNz6S8lwqOQbkFzc/x3+ES0EoegZ1LcDqGf01IzbA
 kMNdZeIgyz6d3NTwJBjep3sm3vNfQsT4T9gIbCM4ceSe+cl2mV0+lI+st+iaRbbJfAis
 WVTQ==
X-Gm-Message-State: AOJu0Ywp6jHWRaDKmPqiVx3T/NN7udHSQo2C7RH9hwRfMSnUOcLSgxT4
 Gj/K7VBu6tD6Frry7oqUPgy/lw==
X-Google-Smtp-Source: AGHT+IG5Mp/Ojq9TZtHtvatWe3sVmWGUfZ4NTcQgtlb4uoTALkrF3doEPK3bgAGAbwzjvrYmjU3/2A==
X-Received: by 2002:a17:906:1045:b0:a25:a0c6:ebf5 with SMTP id
 j5-20020a170906104500b00a25a0c6ebf5mr1783006ejj.21.1703062280204; 
 Wed, 20 Dec 2023 00:51:20 -0800 (PST)
Received: from ?IPV6:2a02:810d:8400:17a8:8ea:59af:d317:9dff?
 ([2a02:810d:8400:17a8:8ea:59af:d317:9dff])
 by smtp.gmail.com with ESMTPSA id
 u25-20020a17090617d900b00a2328f844d2sm4965392eje.85.2023.12.20.00.51.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 00:51:19 -0800 (PST)
Message-ID: <27611da0-a16b-4392-9c87-68e03289ccbe@suse.com>
Date: Wed, 20 Dec 2023 09:51:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] bcm2835: brcm,bcm2708-fb device is using r5g6b5
 format
Content-Language: en-US, ca-ES, es-ES
To: "Ivan T. Ivanov" <iivanov@suse.de>, Stefan Wahren <wahrenst@gmx.net>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 florian.fainelli@broadcom.com, u-boot@lists.denx.de
References: <20231218210341.30073-1-iivanov@suse.de>
 <20231218210341.30073-5-iivanov@suse.de>
 <7764be07-c3cc-47e0-a284-4ba9420a843f@gmx.net>
 <tosej62qjugymvxevjaqq6kqkkjlo3qpkbzaw4xx4ot6fk3j54@evih5bgvfdtf>
From: Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <tosej62qjugymvxevjaqq6kqkkjlo3qpkbzaw4xx4ot6fk3j54@evih5bgvfdtf>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 19/12/2023 09:51, Ivan T. Ivanov wrote:
> On 12-18 23:32, Stefan Wahren wrote:
>>>
>>>    static const struct udevice_id bcm2835_video_ids[] = {
>>> -	{ .compatible = "brcm,bcm2835-hdmi" },
>>> -	{ .compatible = "brcm,bcm2711-hdmi0" },
>>> -	{ .compatible = "brcm,bcm2708-fb" },
>>> +	{ .compatible = "brcm,bcm2835-hdmi",  .data = VIDEO_BPP32},
>>> +	{ .compatible = "brcm,bcm2711-hdmi0", .data = VIDEO_BPP32},
>>> +	{ .compatible = "brcm,bcm2708-fb",    .data = VIDEO_BPP16 },
>> this change looks wrong to me. Before we used VIDEO_BPP32 for
>> brcm,bcm2708-fb. I think it's hard to explain why we should downgrade
>> the other boards. I would expect some brcm,bcm2712 compatible at least
>> this needs an explanation in the commit message.
>>
> 
> If you are confident that this semi device was working before with
> BPP32 I will try to find better way to handle this. Do you remember
> which RPi version was this?
> 

I think that was RPi1 maybe RPi2 Zero W as well.

Regards,
Matthias

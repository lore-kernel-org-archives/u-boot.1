Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7C7109C02F
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 15:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A2B183A91;
	Wed, 25 Mar 2026 16:31:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="M2V9X5at";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70CD983AAB; Wed, 25 Mar 2026 16:31:26 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82CE081E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 16:31:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43b4d734678so2465017f8f.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 08:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774452684; x=1775057484; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=t1GExhSWuz6W80lZOfKQ4skaQjWfvh/+Yp/jUqj93Bc=;
 b=M2V9X5atE7jyoNZSQEvg43U5GJdqAlSSEOpcJq/4Nt1GWFXDKTNjYxhmhPcT24xjS7
 33mkSfE09g7eaXsI9gw1ZCzNGUE7kLC7miasQzyZ3zDDIqca4PE5f/9eRfcmrVf2r8IC
 amWFfUOgODkpbuNuoEic6j5X919a7zfF7hLqY6M6xMc9NmzCN6BBtAhXS9O3HDL1BqjM
 hQiAzAyoZZQOUgEyWFig3E9iY5XzfBeF4RJduLJFVZ8JLP/spgEXidsfoTXOcAySOB9L
 Y32t4LCHNn5kYZleySV3keRZEvi5oJvIbSZ02iIxz7yeXy6dKjwAsrt7RvMIw81DIVRe
 pA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774452684; x=1775057484;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1GExhSWuz6W80lZOfKQ4skaQjWfvh/+Yp/jUqj93Bc=;
 b=gimGGQWO80HEW9Ey2IK9QKeOa1xzB+qMfHyZ2la81j5aDCzoezFrm4wzHBOP9IRuSn
 Ir3fYtaK0dC9TmRfNJi9VZkbS43LXSCIkmJbYaJRcaYtXCghXE9O/XziqV3zxzabqKhv
 Xj6++0TZCQxhkEt9LJ0NA5hxhtv4VZzWC0gVs8w+DtXNSBnVgkFvyamwjg5znhDxdDc4
 GHLduBGCXrK531nyKDcF+69JOXOkQUueU/O9gX7FxEnKyBSClv8+HL8Q8Oz3nrNoFfl0
 fJGlBFkSTV6K4xQ9hpywwjH/1wCU+UhQKvTrPjrU7ZSjt2pBUPkd/v2hI+7g/QkEoMIv
 5vpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLuiZrD4CbAsx1vXCjNcCmBl60wNLYoxJbHjqgWcPz6pNOytG6EzWFA1eGETCUCQzqxSgs4BI=@lists.denx.de
X-Gm-Message-State: AOJu0Yzzk0DRibFIPKN5tFwjWy5bD6/Ehj5pq3XTxB1eUozY6rEv7LNy
 PsAHS2KTteIdm0UXIdB3BVlfy69FEJCaQGRVbOsWS5eHIW48uAetC249vBH9nbKILjM=
X-Gm-Gg: ATEYQzzdGEfmgoOB8obamshkC2FvFjDqUCVfilfoTfgLLCKukTGqt/0oNBLnfloQw1a
 o/1eA+k2kF2QGoEhgQelY/cowyg7SJgovuvc7pO+AQBax8xL03dFwKAYSNCmuKW3JQKWy6K67qU
 mQ7jxb3nkg/71X5XMPM4V6tD1GmNViVt2KD66Orav9NOozayxH4vWTcZdrNfXwwLo+1/O3Izjaa
 E14t72C5zE0/D2GqFpD/dG1/B4ZJC10wD8bKrMGr7WWl5jgE/PN6Xazfx++bqxaidEu248TNrLK
 e6eZ3AJeW4xU2GpYJuOKGlo/P5Et2o+KYrccMemWUlFLJOstMYjuEai6CmnF7F/pA315aLAfkBw
 WP07Gjobbhm9+6K/acaU4C1UWWnU6q7thd/KO4QctTfPpSWTwSDqgxH06N19vfQ0X+DXIgRDaoO
 qFC6ZdSV6bCv9ZPsKixTaoWS3u4Cm6ZAzTKJ6lt4S1n2KLDoeEfrIsX8bZXQj3bR43NW5qFdwxR
 g==
X-Received: by 2002:a05:6000:2912:b0:439:ac98:751f with SMTP id
 ffacd0b85a97d-43b889bd9b8mr5778342f8f.23.1774452683774; 
 Wed, 25 Mar 2026 08:31:23 -0700 (PDT)
Received: from [192.168.2.177] (156.85-85-163.dynamic.clientes.euskaltel.es.
 [85.85.163.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b9192e3f9sm703739f8f.7.2026.03.25.08.31.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 08:31:23 -0700 (PDT)
Message-ID: <f5fba242-a2ee-450f-a45f-17197c9a850b@suse.com>
Date: Wed, 25 Mar 2026 16:31:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rpi: Update the naming for bcm2712 SoC RevD naming
To: Peter Robinson <pbrobinson@gmail.com>,
 =?UTF-8?Q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>,
 u-boot@lists.denx.de
References: <20260313170839.2720191-1-pbrobinson@gmail.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20260313170839.2720191-1-pbrobinson@gmail.com>
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



On 13/03/2026 18:08, Peter Robinson wrote:
> The downstream Raspberry Pi uses two namings for the revD
> SoC device trees, both bcm2712d0-rpi-5-b and bcm2712-d-rpi-5-b
> but it seems upstream has settled on just the later, so lets
> use that as it's the name that maps both upstream and downstream.
> 
> Fixes: c15a7919725 ("board/raspberrypi: add bcm2712d0-rpi-5-b for Raspberry Pi 5")
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   board/raspberrypi/rpi/rpi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index 7f69e5b6163..b0a1484c0fa 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -199,7 +199,7 @@ static const struct rpi_model rpi_models_new_scheme[] = {
>   		"5 Model B",
>   		FDTFILES(
>   			[0] = DTB_DIR "bcm2712-rpi-5-b.dtb",
> -			[1] = DTB_DIR "bcm2712d0-rpi-5-b.dtb"
> +			[1] = DTB_DIR "bcm2712-d-rpi-5-b.dtb"
>   		),
>   		true,
>   	},


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E172DC3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 22:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA8A187561;
	Mon, 25 Dec 2023 23:43:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nUUmoLHj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 082E3876F7; Mon, 25 Dec 2023 23:43:51 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 820F386FF4
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 23:43:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-78132affa95so179235685a.1
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 14:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703544227; x=1704149027; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=orqCRGGb/7qiT85Z5UIJHYWKM1xIIZrAsR8+j3kvdvA=;
 b=nUUmoLHjLmq00yhyxZVFohMmJG5NJwveRUlwu+kMaAVmyeKfR6QUP79OwxfSNes2vf
 OT5CVBLOAbI59LHkSvVKM4AhPolrXuRgLY5R3EjFymvlCajBDeRnmJH3ZD1B+wJ2cbFi
 r6SOoUAbrjSp9sWTPf26Y9PdqfbPHem8kNjUfeW4U41oyz5kNIcXHegoyCPHHjjWTT6E
 tHEE3HwTu+xPTjQg4PfPO+jnhUZ8ykw9hL4pW0pFsMCLOazuosEDmg5QhOVSXiLTEk+L
 ehvKm5A12Z3hv3pn2ESGMA+X2YyHBQyifZCJh1lfxF2kMfk7y/Bb9VFMelLguGstrAaW
 dbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703544227; x=1704149027;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=orqCRGGb/7qiT85Z5UIJHYWKM1xIIZrAsR8+j3kvdvA=;
 b=v3/a2MnvIWl3+gAeiyRcadtTmGtM1H9ClLqsBIbjpDuiye4cBi4ZU22KJ99rUgR0qh
 91J5lEZhfHwQuLS4YwWJJYEco4wodyJpP56WDmh8lzFnYCo3TU/9hxQm9upEP+HqVewz
 +sk9dYLtLPpGFSEeH44IaHJY2ySVI+57ZYQ/P1RTyvy/Gnx9pSsKkLL074Qvy7g/Y3wc
 JMFs/ooi0Cnu1syeS8xt9MFyqrUPpFMRylnIx3FVqhvWvmkUPlSXWQzPF/VCzbWEzprn
 cpA1fFw6cLaKLxporMkxHK8O6VIe07ZUAETNLAdDwycaDI+hKQXpVT7Nng2LUmVmlxgy
 qs5A==
X-Gm-Message-State: AOJu0Yx7oopuF5JJtw1XLNIK2AEpB4HOuQsXMjAWZ4fHgOJo5+W+v3Di
 ec06sUn4XjLP24rGXAVWoZQ=
X-Google-Smtp-Source: AGHT+IGQxuQZbvIlUQHNLwbDeMhIDkClCilSRbji1JltB2NzJt78ryhuE4sABAyNLatXBW+Y0Uugow==
X-Received: by 2002:a05:620a:4487:b0:77f:551:e339 with SMTP id
 x7-20020a05620a448700b0077f0551e339mr8791881qkp.64.1703544226978; 
 Mon, 25 Dec 2023 14:43:46 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 p16-20020a05620a22f000b0076efaec147csm3874345qki.45.2023.12.25.14.43.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Dec 2023 14:43:46 -0800 (PST)
Message-ID: <a45cbd9a-cfa2-7728-3c5f-1a21ebbcb068@gmail.com>
Date: Mon, 25 Dec 2023 17:43:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATHv2 2/9] net: sandbox: fix NULL pointer derefences
Content-Language: en-US
To: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
 <20231225153929.8284-3-maxim.uvarov@linaro.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231225153929.8284-3-maxim.uvarov@linaro.org>
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

On 12/25/23 10:39, Maxim Uvarov wrote:
> Add additional checks for NULL pointers.
> 
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>   drivers/net/sandbox.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/sandbox.c b/drivers/net/sandbox.c
> index 13022addb6..d91935e032 100644
> --- a/drivers/net/sandbox.c
> +++ b/drivers/net/sandbox.c
> @@ -65,6 +65,9 @@ int sandbox_eth_arp_req_to_reply(struct udevice *dev, void *packet,
>   	struct ethernet_hdr *eth_recv;
>   	struct arp_hdr *arp_recv;
>   
> +	if (!priv)
> +		return -EAGAIN;
> +

When can priv be NULL?

--Sean

>   	if (ntohs(eth->et_protlen) != PROT_ARP)
>   		return -EAGAIN;
>   


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87907C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 17:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19D148778F;
	Mon, 11 Dec 2023 18:56:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gS0JTWo2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED564877C6; Mon, 11 Dec 2023 18:56:48 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2748B877B7
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 18:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AD60640AB2
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 17:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702317406;
 bh=hks7c6/jiUvhXkEO5+NYWmdAcWBZkSg+b0s/5u0RE6c=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=gS0JTWo2BCHDE0JqbD7Gwut+vFsOEVkDblBT2ea6ZX9OkZyp+phw3zpMyax/fXMxn
 ckvspRoK5A9SwG4aEN46fWxl5BfFiOiTQaEGtNeMloOHRodCO9vUYUOllHHtCU1zD9
 zhU+b0QINjWlHX4PnjKmnqXQH9I59NSTkUgOndY/nS6l5iYtCdSk/m6M58p+5G3ri6
 lZZTxxOR1DqeM8v5f3Mb5iBN/OhSUCCofAhYb/pwx6+gqmBzLI7W1Dlpd3fRwkpacm
 RU2uDlBGZ846qm5UO4e5bJO9841ivO/kvgeJyOVtP7U08a7RNO8cIbVfxzhFIE5UGq
 VjTVWihVGOadQ==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40c3cea4c19so17696935e9.1
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 09:56:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702317406; x=1702922206;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hks7c6/jiUvhXkEO5+NYWmdAcWBZkSg+b0s/5u0RE6c=;
 b=X1E7/FgFOP0HcJbhgh4+WU3X8sWdvRoOroKOP8140p9bvoa++jxaDeLIcId8z/oMiP
 IciKnTzOA+LxgOb4nzFGzNEg6rfhYqcwkeeGDycjK23wqAeTu7w9ZPN18/cGFbF7qrbT
 RvGY456I/3/0HS+wsUpGgWS8rdZcAgp2leQmuGc/lCV61XqUWNMjPavYW1Gp9j/eiW94
 IDPnr0PKHDZYG9b3S/Yt+p44QcEhjI0fMdNGjJJmd8tOvbsuMN4IAu8tOBJWsyhkAxiE
 JbenVw50t10xC90223GoFwFGs5AFnRPNmwInIfU8mGZG1No7U0DnuzUhbuYyxe/RoWkS
 Gcuw==
X-Gm-Message-State: AOJu0YzlyyfDBczZXBwDOzZza6WaWAjr8ccp5l5o+m2I2pWZ6Xi0Tuc0
 tmnTI1tXKCxX0dlMomK6mA5AGh13GXKK6GbDJFoG6M6MNe4DBrX3cppLEQWNkdDLtif+LUpJ8ps
 Ni9FJO4U07dLFTx4W+ZbB7CC/eM4G01Y=
X-Received: by 2002:a7b:c3cf:0:b0:40c:2654:5709 with SMTP id
 t15-20020a7bc3cf000000b0040c26545709mr2258578wmj.116.1702317406208; 
 Mon, 11 Dec 2023 09:56:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjHZI+jeKswOoB3puI0hb5/KYSIlVAUsgGs20SulwONf9zp7KJpOycUTpkvulmdzoOjO15cA==
X-Received: by 2002:a7b:c3cf:0:b0:40c:2654:5709 with SMTP id
 t15-20020a7bc3cf000000b0040c26545709mr2258569wmj.116.1702317405782; 
 Mon, 11 Dec 2023 09:56:45 -0800 (PST)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 l15-20020a05600c1d0f00b003feae747ff2sm16071240wms.35.2023.12.11.09.56.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 09:56:45 -0800 (PST)
Message-ID: <60f3046c-2af9-40b5-aea4-849fc6999d3a@canonical.com>
Date: Mon, 11 Dec 2023 18:56:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] binman: elf: Using variable 'old_val' before
 assignment
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de
References: <20231209185031.7275-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ0wa=CK5Q5SCpPHZiv7zGLGXnEprzVTTt_P6iiP-zmZfA@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ0wa=CK5Q5SCpPHZiv7zGLGXnEprzVTTt_P6iiP-zmZfA@mail.gmail.com>
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

On 11.12.23 18:52, Simon Glass wrote:
> On Sat, 9 Dec 2023 at 11:50, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> old_val can only be assumed initialized in the finally block
>> if it is assigned a value before the try statement.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   tools/binman/elf_test.py | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/binman/elf_test.py b/tools/binman/elf_test.py
>> index e3dee79d06..b64134123c 100644
>> --- a/tools/binman/elf_test.py
>> +++ b/tools/binman/elf_test.py
>> @@ -249,8 +249,8 @@ class TestElf(unittest.TestCase):
>>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> An odd case though...I cannot imagine how this might fail.

This patch is needed to use a recent pylint. Otherwise 'make pylint_err' 
will fail in future.

Best regards

Heinrich

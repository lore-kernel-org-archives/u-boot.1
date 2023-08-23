Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0CDEE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 13:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2B9986366;
	Wed, 23 Aug 2023 15:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="G6oxE54u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F151386480; Wed, 23 Aug 2023 15:25:19 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20EBC8634D
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 15:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [192.168.0.125] (unknown [82.76.24.202])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 3E9D366015A0;
 Wed, 23 Aug 2023 14:25:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1692797117;
 bh=5DslB4lz6/8S3jBVhCht7arOQ/l5xHXzTO44tBE6/2Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=G6oxE54uw4OV8UeORzyFg1cyc9DvySaUe4nBUqxk2lpKKxIN7cScf0FHj9nS1uKbF
 TIqVhK1Ns03U09va51G7rlAJSP8Az8gt1Z9ecW6lRwdTsdqotsfgTv2YUbNSO73EUp
 29C43ZIZZ5YlCa6TyajlU80aun4nPw1W66ohxXK6X/EaTPguTF+7eRM16PiVftCWbK
 9hikQ/IV8HPhD1zUDC8dYyj1XcI2+4KT7EB+bdqXLLgw3dYO0q/syhIdAHcgInCg9r
 1a1XZ2c7ZvxHFbeZcvO+vzusnN4H8UPvBQqov+aiXj/d1SOS0CxroxcT2HljUZrOwx
 oLTUw9tEBpGkw==
Message-ID: <6a306f2d-5488-fa81-4bf5-36bde8454360@collabora.com>
Date: Wed, 23 Aug 2023 16:25:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] mtd: nand: raw: atmel: Remove duplicate line
Content-Language: en-US
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Alexander Dahl <ada@thorsis.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 u-boot@lists.denx.de
References: <20230808130250.188588-1-ada@thorsis.com>
 <20230808130250.188588-2-ada@thorsis.com>
 <CAOf5uwmoewx=ZNuR0Ym36vh9b977kj0LerAUtGbQKSCBOztU7w@mail.gmail.com>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <CAOf5uwmoewx=ZNuR0Ym36vh9b977kj0LerAUtGbQKSCBOztU7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/8/23 16:48, Michael Nazzareno Trimarchi wrote:
> Hi
> 
> On Tue, Aug 8, 2023 at 3:03 PM Alexander Dahl <ada@thorsis.com> wrote:
>>
>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
> 
> 

Applied this one patch to u-boot-at91/next , thanks !

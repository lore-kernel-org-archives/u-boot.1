Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCD3C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 16:40:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAD9C884A4;
	Wed, 17 Apr 2024 18:40:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=epsi@gmx.de header.b="uAx4BF+4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EF4A884BF; Wed, 17 Apr 2024 18:40:32 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B3DB8846B
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 18:40:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=epsi@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1713372029; x=1713976829; i=epsi@gmx.de;
 bh=7LD6F+Asy7CmFlxVDzOhhOGx7CKhQabLovbbN85oS0Q=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=uAx4BF+4LbXTXNdQrRyS8tThm5EFZWYJj3g4/9oKRLEVX5X/WbrdLYMCPHHO6oVq
 Ap2ccvKdlw4umV8egZadLQW3f7WmatDbjgBved0wwRmByRucIwdwzhfNj1/JJgjFh
 +YkMkMKV7ZGiDHVJg7HOjsa0Uv7aywrULBwfxmRXNFrIsTAJRMUSDKL4QcQGoP9ja
 j+3j9ldAtVboBFRIUwU1SxJEXbizUCXNmP6TJSYmi1e0gtxJPB4behcJQuKMjksau
 7yz9D1T196pPuHBaN555o7UUgSmrUYOgg4Xw4UjWw+iO8CRWKx8wiegoom8Fw7Wdv
 Lo4RWgHxA5cZflRbbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.3.21] ([217.225.83.13]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MjS54-1scCN43LYo-00kzeq; Wed, 17
 Apr 2024 18:40:28 +0200
Message-ID: <8173d9d0-5944-400d-80f7-b7785da45de1@gmx.de>
Date: Wed, 17 Apr 2024 18:40:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch] dwc_eth_qos: Revert regression handling fixed phy
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>, Ramon Fried <rfried.dev@gmail.com>
References: <31a9f868-8f5f-2938-a22d-39a2695adba2@gmx.de>
 <31252563-cfe1-343b-cf29-31c374e5287e@denx.de>
 <b94139ba-2135-5f48-aa26-c2b301d13e46@gmx.de>
 <5cf38ecf-f02c-4219-90e8-aceccf558b43@gmx.de>
 <50284627-84dc-4d09-90f8-8061eb570235@denx.de>
Content-Language: en-US
From: Elmar Psilog <epsi@gmx.de>
In-Reply-To: <50284627-84dc-4d09-90f8-8061eb570235@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:qsXN+GC6MBddBqinFxbne6NIR88WorhUCcFAGqOOuOesGqeOi/4
 ExAsbppqF3hQ9ldiM9vzxSKqtTUvCWAiviQxzNIPV03rKOgH8auWDS1nLlqhV1u4wieG7xD
 Z9m9nvGOBQX8GjAP/l9Ykt4hdrA0QM84bkYmqdDvLRUu1HAzxo3vQDdCVq63zHG+jlruJIF
 UcWvhv5eCpjcJesiftoQw==
UI-OutboundReport: notjunk:1;M01:P0:Z59Xwa3zMRY=;TbCeqlNl3ntA9Xj93/aBU6e0oK0
 shxJp1gWpmzWCIWYfEwt50vZ055Y0roVjz40ph2w7Z2al4zbqGgjsuemJwtlN058VQW4gW3q1
 wZED7SvISTJP6KpGS+nJ4WNKDV3fWRT79d+OS3e+1qQ5t+CASeJFlGSVp5k15x9/6k/8tSM6S
 BSY2dVkyH/frLseiKH7oFFqI/uPfQxacHtxELC1yuMbUUWFvXgOd2tDJSaQ07wIdr+7jYuTHP
 wxO62l7wsStUReDqqEy8jK/zr9u+tCWh3kYwTSYmaA6/XXcyhf+0GFwetr8TSBVUvWibmh5QL
 5lcm10qudq/mBKiIKs8K9uSNnBzfRFNXSsoXnxHt4rxaGDBLePegdPgRxebEYfq7bUx1EjFpy
 PesstdTlgn/NSU6s3Kq16dKpPJzKvkd5aHF+mxmtP5kpx8N9gYYyLLf2IelclZq4s3ff068aI
 uxq5EUpTkyBpa02YU0iHtX9HkgItXKb9UQq4hFQLAq5KDPWp0mx5p4wpkHIl7A4sbganBFXC7
 8GaHrMvUhssdyG7IToGZ/r/LiHNVxRhqjVp97uhz66QjDw6z1xE33zn3cbzj9i5RsvJRrRO33
 ABJfezKxd7GbctcRAXhtFI5MMjWeDvrrVRgTsuQoXDtooAZgDyRmCwEbuYAISmzI6uibc77mb
 y2evl1rsSb31UYuR50VQbwmeA24ORnLbk7CKzpfTTk8ZRSWaN5Hq/5610c5znvsKSzF2zGnJY
 173scYzoJsrAGbWYFKF7AaLQ+MqARMw6r47uJZPoZUi/HeTD7gjPZPadVM01RINBZCzXNVJ1O
 Kx95HIzQjZmYAidxrxvs0F/Io2vDP7xa7SvrwvjMxFDfg=
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


On 4/17/24 13:15, Marek Vasut wrote:
> On 4/17/24 10:41 AM, Nicole Battenfeld wrote:
>> Subject: [PATCH] dwc_eth_qos: Revert regression handling fixed phy
>>
>> In imx8mp operation on eqos with fixed phy I get without that patch:
>> ERROR: no/invalid <fixed-link< property!
>
> Which commit is being reverted here ?

True. I just checked the mails last year and my confusion grows.

It was right here at the bottom:
https://lists.denx.de/pipermail/u-boot/2023-February/509156.html

But already in PATCH_v2 it seems that line was dropped, my fault.



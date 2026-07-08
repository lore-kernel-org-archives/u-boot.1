Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65D9C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 10:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D18D584118;
	Wed,  8 Jul 2026 12:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="mr23+KI3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38A01843B6; Wed,  8 Jul 2026 12:12:43 +0200 (CEST)
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [45.157.188.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4955B838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 12:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gwDRr5YTyz2Md;
 Wed,  8 Jul 2026 12:12:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783505560;
 bh=9S1lGXAmlALVcXx/O17pjo2d1S8JbtfyvNjU3zgv7rE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mr23+KI3jEZFrwk+GllrYKRH8gbgjMzTNcSQwSyITqX62QNDmoqraIl0edGJwzxxb
 jBRf/MDi5rSod13iqoJORhb9c005XgJUKzNKtKPV9lC68jz04i14xHxp8v0UgIbPSs
 oVkKY6oEtMoq9xf6vnl7/liTUMeH2NsrbqDHm2t9+Oq02OZ7Y8SJxppPUDKFrNLYsg
 Xjv6CkzXlZz6bfOfJQ7Vml/u4wvTjnl64TBT+O4XThZSINhKZobIe2pFZcGzF+f2cl
 xoUIpI4Cy/27DpqWYO65YZN8smxOVLwgf7TG/ULvhiNxyjaO79O/3Sx1C5KdjcF1qI
 q9jZiJD8m3AmA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gwDRp6zhmzmr7; Wed,  8 Jul 2026 12:12:38 +0200 (CEST)
Message-ID: <22d87b10-cb65-4a51-a1ae-8197c9ead601@0leil.net>
Date: Wed, 8 Jul 2026 12:12:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] MAINTAINERS: add N: rkmtd regex to ARM ROCKCHIP
To: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
References: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
 <20260707-rk-custodian-v1-8-dbc9c696e613@0leil.net> <2064040.usQuhbGJ8B@phil>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <2064040.usQuhbGJ8B@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

Hi Heiko,

On 7/7/26 8:35 PM, Heiko Stuebner wrote:
> Am Dienstag, 7. Juli 2026, 18:09:22 Mitteleuropäische Sommerzeit schrieb Quentin Schulz:
>> rkmtd is a Rockchip feature, so let's match *anything* with that in the
>> path.
>>
>> Signed-off-by: Quentin Schulz <u-boot@0leil.net>
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 49b35945f820..1c94356dc4b8 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -582,6 +582,7 @@ N:	px5
>>   N:	rk3
>>   # RK8xx PMIC/regulator family
>>   N:	rk8
>> +N:	rkmtd
> Is that the raw-nand driver?
> I guess it could also use a comment maybe?

My thought process for the ones with comments was that it isn't obvious 
what it should be matching and why. There's not rk3 product, neither 
rk8. However, for rkmtd, you can simply search for it in the tree and 
it'll return only what's applicable and it's rather clear what it refers 
to (only few matches). Same for rockusb for example.

Cheers,
Quentin


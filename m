Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AF0C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 03:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79F9988780;
	Wed, 31 Jul 2024 05:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722397122;
	bh=MK+kJALQBhhvRPjkNrPlnM9MBWPiQks75Q8rkkgQzqg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=NXegEbtrdU23Jjit49TWX+IHfxOapILMkU2DmK1Pp0X8hegV0i343ENZJfAi87wmm
	 Ru7WjiqqZ6cpXQST2IfxcTQT40WeZ0lV8GPjkZr0KYyqcJip741PeZ6J8Ja1sljYp3
	 +MX757njYXxKp4z2qw0D4nKxxKkX1Wglao9I4COh+sWP7MEENTgagcMvSeMqrEBLGR
	 LHygrgjTqXgtVZ5Iy/drLtIJxTvdlH8e7GWnn3Kmmk5R8hF/7VisqUNtW9jnsCbYZ9
	 2zs+Jt+6ZMs58fZRhYOjsrRp9natZ/2HVEeLdQ02Fs2BYJIAryNEDrbMy8NGmpckIX
	 JjXKlBiD7p9uQ==
Received: from [192.168.1.107] (87-97-105-110.pool.digikabel.hu
 [87.97.105.110])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4D149883FE;
 Wed, 31 Jul 2024 05:38:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722397121;
 bh=MK+kJALQBhhvRPjkNrPlnM9MBWPiQks75Q8rkkgQzqg=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=HMUWFc3wzUwBeN1PgB2joXjQLRR5ui7CZt+NQMG8Ar8qklGGgtLkWuf4/09v7hFdV
 KVWqrComcrJO7QFTSFJttf7Z1oobcr6+Nkc+J8ibFzPWkLSSNfm6RK0NlURag48DN6
 y4G6XyPPmky/xvMTJP9AsFpQ0Fig6A9lVAfQS8toVlNyYfXnk8EbKCrgrXL9Vrw1bk
 0Q/9R2qRupHSSNHVxLTpr/ZXoyHWLSYxRCvQAh4eso3s1RnxXTpAgpfLnJZaxf+/Ql
 DQ4sB2F52+7CmReufJVkFUAlgq3oztXxwX68Neiws594p97xKDVuaq6uUJbCoVbchE
 Vn03B7XItqTQA==
Message-ID: <5f928c0b-a05d-36b0-ab05-b77233e546ec@denx.de>
Date: Wed, 31 Jul 2024 05:37:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v6 6/6] spinand: bind UBI block
Content-Language: en-US
To: Alexey Romanov <avromanov@salutedevices.com>,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 frieder.schrempf@kontron.de, kmpark@infradead.org, joe.hershberger@ni.com,
 dunaev@tecon.ru, sjg@chromium.org, bmeng@tinylab.org, xypron.glpk@gmx.de,
 tobias@waldekranz.com, jpewhacker@gmail.com,
 marek.vasut+renesas@mailbox.org, kever.yang@rock-chips.com,
 jbx6244@gmail.com, abdellatif.elkhlifi@arm.com,
 mikhail.kshevetskiy@iopsys.eu, jagan@amarulasolutions.com
Cc: kernel@salutedevices.com, u-boot@lists.denx.de
References: <20240718054528.799539-1-avromanov@salutedevices.com>
 <20240718054528.799539-7-avromanov@salutedevices.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240718054528.799539-7-avromanov@salutedevices.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Alexey,

On 18.07.24 07:45, Alexey Romanov wrote:
> UBI block is virtual block device, which is an abstraction
> over MTD layer. Therefore it is logical to use it in combination
> with MTD drivers.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>   drivers/mtd/nand/spi/core.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)

Looks good from my side

Reviewed-by: Heiko Schocher <hs@denx.de>

Thanks!

bye,
Heiko


-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

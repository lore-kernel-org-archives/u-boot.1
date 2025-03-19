Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E058C36000
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 17:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2B0F81B42;
	Wed, 19 Mar 2025 18:14:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742404486;
	bh=D59Iz0sdc91d8pBHWkVtZG9FoJ+6fbFTFQ3n4/VXqV0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k5vwJo9RnVkYnPCd+6W0uOiruCgKmwvk1ZyKeILl2YcjoU18PrxRG59/kC+6kNhbS
	 UDiZIaCM86MUJmnlRnaXLengvFci77GG/cDz5OTxOhOlTUkJrVHqaZCBqg579WNJsU
	 JHJPHvBEd1CyLoOR0ZhUTPKU/1qTVy4EaL2nVqbiNfGt6NZNWFOU7jAW66Hlnj1D4i
	 sy0/XfTjkNo3uLumMT3Nqlar3UkoIh89Jd751L7REqaLtFsh5Z4R5/GsCT2JDPYF2b
	 S0QPQdS8/RQbm4RXl9UwaQiVivz4gIdINE+sAhPAkKliv4ZC2gKflg+zFGgtjJ9qi/
	 MtdFlZm97RW3A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CADD281C84; Wed, 19 Mar 2025 18:14:44 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF13981A04
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 18:14:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="CbJy92zl"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 16926101E91D0; Wed, 19 Mar 2025 18:14:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742404480; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=D59Iz0sdc91d8pBHWkVtZG9FoJ+6fbFTFQ3n4/VXqV0=;
 b=CbJy92zlETUKxQiEvDN4qV3GTbU3X7XvwlPe4mpVbEEwbpqb0chxwBQvA37IuW3muhaWmO
 dU388nSjqM9DEcmS9cldj4h5EIhJj7OaJihTt8Uh+FssZ3mKK2tW11YVALBkwpd7foGcVa
 kDbQz2sujTjjWc1QPy67jGGUvrhujKRqrB0naO5IjpxR46I3tYduKSs0IKQftEvDMSWWTt
 VD4O6ti8X3ovr5g3eZVTmIAbXXWFJhzBgCYVeoYAZjO9T+jePieo63vtj80Utjv1VtcEGf
 9rBuP+8h8h/STsBIooLLiHw92L5Drpzrxw/prJBLxkwsUtsPGf9J2peJsrTK7Q==
Message-ID: <da3b8a84-3005-4576-8977-a2eea21e9512@denx.de>
Date: Wed, 19 Mar 2025 18:14:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] clk: Add clk_resolve_parent_clk() and fix up iMX
 clock drivers
To: Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@denx.de>
Cc: u-boot@lists.denx.de,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan
 <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com,
 Fabio Estevam <festevam@gmail.com>
References: <20250319031852.233537-1-marex@denx.de>
 <e09f009d-4a00-45a7-9a33-dba22da6ca4b@denx.de>
 <132-67daad80-19-611b1e80@141681007>
 <CAHCN7x+St2V27aox5hxOUbEaLnEUWTBuOybKeybpNmawC=44Nw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAHCN7x+St2V27aox5hxOUbEaLnEUWTBuOybKeybpNmawC=44Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/19/25 5:52 PM, Adam Ford wrote:
> On Wed, Mar 19, 2025 at 6:42 AM Fabio Estevam <festevam@denx.de> wrote:
>>
>> On Wednesday, March 19, 2025 00:23 -03, Marek Vasut <marex@denx.de> wrote:
>>
>>> Sigh, get maintainers missed Fabio, sorry, +CCed now.
> 
> I noticed that Fabio was being left off too when I sent some stuff.
I think some MAINTAINERS file needs update, maybe using some N: field to 
glob all imx stuff and auto-CC Fabio

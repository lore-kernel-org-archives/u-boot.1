Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD5DC07E8F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 09:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2946883A9;
	Mon, 22 Apr 2024 11:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Zk/ncvzP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D08DD883A9; Mon, 22 Apr 2024 11:22:27 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FAA9883D4
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 11:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1713777744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s0K6P2MBTI+81gRRzRo5eVZfuUWWsnuemMpCpwleUc8=;
 b=Zk/ncvzPgcL6J9dMQFB5wBHwUOQP0tJvW2qnbSPqhrZlBSVP3pD156JtB36dydGIbB4so2
 ejXy4Xtz5FhfFoLBgroWi+BUy1/qIo+kUOIgp4aT854e3lqkKlG6T9TPcltwC8ySYzu+5a
 zSaobOixcpMxdhE3zbAA4phalP139rKkjQLGrdl5N/zaviPRjMb6V9gGQgmuUXMhdFUCXk
 4HKaGP188uo9kMMstR7LwXymSmfHm+yorbiEyv+QcYybffNkOOd5M+Sgcn1UagVyjQQcU3
 IJ579xsiINI8n7mEuGHKKDiXaf8083jKPtWo5yu8d5VHaIfSGuWWe3LkKXdxww==
Date: Mon, 22 Apr 2024 11:22:23 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu
Subject: Re: [PATCH] board: rk3288: simplify the DT file list in MAINTAINERS
In-Reply-To: <99f377ea-5363-42fb-81b2-9fe1ea984a14@rock-chips.com>
References: <369151a2b8d73d733ca79eca98d4d5958f90d491.1713423687.git.dsimic@manjaro.org>
 <99f377ea-5363-42fb-81b2-9fe1ea984a14@rock-chips.com>
Message-ID: <fff76347ef11dea86b671be95a8ec56a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-04-22 10:24, Kever Yang wrote:
> On 2024/4/18 15:06, Dragan Simic wrote:
>> Use a wildcard to simplify the list of board DT files in the 
>> MAINTAINERS
>> file for the Radxa Rock 2 Square board.
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks!

>> ---
>>   board/radxa/rock2/MAINTAINERS | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>> 
>> diff --git a/board/radxa/rock2/MAINTAINERS 
>> b/board/radxa/rock2/MAINTAINERS
>> index 5328fd76014a..af974c983047 100644
>> --- a/board/radxa/rock2/MAINTAINERS
>> +++ b/board/radxa/rock2/MAINTAINERS
>> @@ -1,9 +1,7 @@
>>   FIREFLY
>>   M:	Simon Glass <sjg@chromium.org>
>>   S:	Maintained
>> -F:	arch/arm/dts/rk3288-rock2-som.dtsi
>> -F:	arch/arm/dts/rk3288-rock2-square.dts
>> -F:	arch/arm/dts/rk3288-rock2-square-u-boot.dtsi
>> +F:	arch/arm/dts/rk3288-rock2*
>>   F:	board/radxa/rock2
>>   F:	include/configs/rock2.h
>>   F:	configs/rock2_defconfig

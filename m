Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A162C98311
	for <u-boot@archiver.kernel.org>; Sat, 17 Jan 2026 06:16:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F01E833C6;
	Sat, 17 Jan 2026 07:16:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="b4T+QQYP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 732A78367F; Sat, 17 Jan 2026 07:16:05 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBFEA83015
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 07:16:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B85D710DC8D; Sat, 17 Jan 2026 07:15:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1768630559;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=sfKUtNWYoVbtHz+rjIYrNzisIg+CtgMsBNKD5E4/hE4=;
 b=b4T+QQYPulUiDzk5HnBBGu8k5SZRtrG8S4GdGMD+sSWU0uYExg5Ry6p3bMVk6qD8Mhmz/i
 U/S9Hp3MecHZoK9dyp3YGHkC2MIA96V6Sdv1us/U/+fK/hj1r624zkKXzXAO5xe77vsulw
 hewm0foDg2yFPD3nP9REwywFvm7SuSj8sJ02TFOleCY7BxLGgbzAYH2Akwo8tQtMATY2KF
 U/Vq2OHSUR5uC/ZI7ZwBYUb5Z71WqMgIVRoK/CQbUWCDO+n28gUtWc+7yFhbynJSSCtk80
 zhD9H09ZWGR1nltHVuDUZP8rkPsG4KFcL0/CqHsr8m0N6QmCVbh/wkTr1We5Bg==
Message-ID: <fcdde926-f0b7-f1cb-1676-1541934541ad@nabladev.com>
Date: Sat, 17 Jan 2026 07:16:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: geni: bail when clocks can't be enabled
Content-Language: en-US
To: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260108195301.3159260-1-casey.connolly@linaro.org>
 <176858661122.3399278.240676332307316402.b4-ty@linaro.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <176858661122.3399278.240676332307316402.b4-ty@linaro.org>
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

Hello Casey,

On 16.01.26 19:03, Casey Connolly wrote:
> 
> On Thu, 08 Jan 2026 20:52:55 +0100, Casey Connolly wrote:
>> Failing to enable clocks will lead to bus hangs and the board crashing
>> in some cases, let's actually deal with this error and fail probe rather than hoping the clocks are already enabled.
>>
>>
> 
> Applied, thanks!

Fine for me, thanks!

I just planned to add this today to u-boot-i2c and send pull request!

bye,
Heiko
> 
> [1/1] i2c: geni: bail when clocks can't be enabled
>        https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/d38ec14953eb
> 
> Best regards,
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic

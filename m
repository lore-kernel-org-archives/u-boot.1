Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA508C369C2
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 19:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 014B281CF0;
	Sun, 20 Apr 2025 21:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745176824;
	bh=b41cbrS3YrzprC6db2ZAe0qIenOuinBZ3caQuHxXoU0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=StfKHtMdizUqt0KCrGroVUeBb46lNJPzf9xzjEOkH8miBcITu4hoX04Va4+ZKSLSC
	 twH7kGKt4h0IbGUEBXNUCJlr39fbdRmJfkwlPtFHmSAQbMYBoJ6OKNw/L4yVv5sn1d
	 QV21oCJLR5qQa1hegVMLCRyUGRAazj3viafX/sjZsFSRTt6VvqlxBIENkXMA/Pu2js
	 l2+8itQcR/BOK/jjSTmu3B1rDgRT53dz3FfXfyAFpqRX1BQq+MP8xNkf9fFl700T+U
	 N7sdvJvW8Oh1by8A6YYaAW8ON/6yU5JWjr6ZMRy0zoZOzK1b1+BZl6pXhTYNZwPBAZ
	 yAJoiTjkgIl1w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95AB781D5D; Sun, 20 Apr 2025 21:20:22 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2D6381B4B
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 21:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="W5KDg5sE"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6ADED103B92BE; 
 Sun, 20 Apr 2025 21:20:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745176819; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=b41cbrS3YrzprC6db2ZAe0qIenOuinBZ3caQuHxXoU0=;
 b=W5KDg5sEjuG8RfYgNdZA/kBP8T8mndMrGcgX5Cxc/XsYgiUdXXIFh0AZgdaPXOnUsfk9BW
 4yb7qo4Kk64G3hTPZpuOfV9VNJCD35/IuvOagct2Td6k6s2a0QTVaO8XEriJlSlo6umT5o
 QMZBMmXFWXcfyy12Hqh7TOf3obaEkbBJj8sjvFoF7z/c3FKDRs3sMgQyj4nNmODox+BTJT
 bTIFjGuizr9fx3aszoFd00RQ04ltXV++/r3cukuAJEuEkDRd/9vhMmxKLew8CtcKrf4Be1
 me/Meb59LUW07Uvt1oMRbFgpaVjmrukNo1T3ZiGv+JNopDOwx/QJeD0CiLL9QA==
Message-ID: <28b4bb24-4c56-4fe3-ae9b-db43c63290b1@denx.de>
Date: Sun, 20 Apr 2025 21:20:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: fixed-rate: Use "clock-output-names" to name
 fixed clocks
To: Fabio Estevam <festevam@gmail.com>
Cc: Adam Ford <aford173@gmail.com>, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, francesco.dolcini@toradex.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
References: <20250417171101.2566447-1-festevam@gmail.com>
 <5eb55cce-28b0-436a-85c4-dcf86e6c6554@denx.de>
 <CAOMZO5C_9yojvxO1NoNjtTHxD85ZcGd_cK2t-rofyY_Zxm1xcg@mail.gmail.com>
 <CAHCN7xLkDnLX5PHFNjXYn7AFXA5+S22aksgv62PpWpg80ZDQmA@mail.gmail.com>
 <d81112ad-017b-491a-b517-de828dd30c25@denx.de>
 <CAOMZO5CpQ-yv=8GhNv7=yjnA+uzzP9ZmB=P2d+xmhY1ktQJX9A@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5CpQ-yv=8GhNv7=yjnA+uzzP9ZmB=P2d+xmhY1ktQJX9A@mail.gmail.com>
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

On 4/20/25 3:07 AM, Fabio Estevam wrote:
> On Sat, Apr 19, 2025 at 9:48 PM Marek Vasut <marex@denx.de> wrote:
> 
>> Try something like this (also attached), maybe this needs to be made
>> generic ?
> 
> It works for me:
> 
> Tested-by: Fabio Estevam <festevam@gmail.com>

Can you send that as a fix ?

And also, fix this patch up and drop the bogus second half of the commit 
message and do a V3.

Thanks

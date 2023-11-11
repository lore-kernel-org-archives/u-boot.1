Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5C4C4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 16:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B6D486F83;
	Sat, 11 Nov 2023 17:14:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="w16JcUt2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="q2uquo7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A15F886F83; Sat, 11 Nov 2023 17:14:32 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0023E86F5C
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 17:14:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4SSLP13tqKz9sR1;
 Sat, 11 Nov 2023 17:14:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1699719269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20rcy1dc2/eBl20JbYR3ch9Mv6cninP06ZBq1coNkYo=;
 b=w16JcUt2OjtGjzW8Wb3E8lS9coh2LyYRupo1BJLffJb6uqfmlupq8YsFNfTvuuM9BMETtj
 Gkr5bxvSGvLL6ZG2naaGmxWY4Eewaw4HN7TXzJ6Zzj283qawXMnbcIkdzFG64Qs/2sUZDX
 WhCFHKfeuuG1v3pCiCOzHylTBYgk/a+m2cXmX5iT7h6t1EkCBjqqrEt00S4R5D2QCke2kt
 M4lItBSejriOywdgokUHJ97PNdRSsi2Pn3Em+10mx1eQZPdR8iAYeKMA4gx6hGijkGBJLg
 CDvUzcgevjX37rf3ree46GR6cTbThnTAtuuQlV2rvbc0EgV40hMlMsk4m34KjA==
Message-ID: <c87e9fee-b895-4cbd-9bea-e64ba1eb805b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1699719267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20rcy1dc2/eBl20JbYR3ch9Mv6cninP06ZBq1coNkYo=;
 b=q2uquo7CK9uQypH3JgG4BvNeRbPhOjiIjvSLxGLiOae757MSHbntMH40H/bBSQ9I+nlha/
 +YY5dZmyftbnPV7t++0AOcfd7CWSYbJrl4aJJv4S7JlgDVRB3NE25iFVFfQewH8sB2k40i
 JEQuXrrstejWkkADuLnTRqAwo0C0qNumv7xo8gzRMWcnLJ2t4WFZTaBu6MDWF4zGDXAp9e
 4YD2ED4+V6tR7jQYOi2IPmt80R7XsS5vYFYWePQSSDsOSDcRGlXj0qlE61xHh+9zWhoUsr
 +rhW+kCfUsfv51B96sfzUjVOuM4brtqxYT+5LTGEcCN4GxzFMQQDyG6G3EtZ8g==
Date: Sat, 11 Nov 2023 17:14:25 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] mmc: renesas-sdhi: Disable clock after tuning reset when
 possible
Content-Language: en-US
To: Jaehoon Chung <jh80.chung@samsung.com>,
 'Marek Vasut' <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: 'Nobuhiro Iwamatsu' <iwamatsu@nigauri.org>,
 'Paul Barker' <paul.barker.ct@bp.renesas.com>, 'Peng Fan' <peng.fan@nxp.com>
References: <CGME20231105224327epcas1p2d19ccbed6821310bf0f04dcd2a33da3c@epcas1p2.samsung.com>
 <20231105224304.103997-1-marek.vasut+renesas@mailbox.org>
 <02b201da109b$5fc2fb00$1f48f100$@samsung.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <02b201da109b$5fc2fb00$1f48f100$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: w4xdy1peysy1raeq9ibsy4ppktschjnb
X-MBO-RS-ID: 76f08709f5871fff491
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

On 11/6/23 11:24, Jaehoon Chung wrote:
> 
> 
>> -----Original Message-----
>> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> Sent: Monday, November 6, 2023 7:43 AM
>> To: u-boot@lists.denx.de
>> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>; Jaehoon Chung <jh80.chung@samsung.com>; Nobuhiro
>> Iwamatsu <iwamatsu@nigauri.org>; Paul Barker <paul.barker.ct@bp.renesas.com>; Peng Fan
>> <peng.fan@nxp.com>
>> Subject: [PATCH] mmc: renesas-sdhi: Disable clock after tuning reset when possible
>>
>> Currently the renesas_sdhi_reset_tuning() unconditionally leaves SDHI
>> clock enabled after the tuning reset. This is not always necessary.
>>
>> After the driver performed tuning reset at the end of probe function,
>> or in the unlikely case that tuning failed during regular operation,
>> the SDHI clock can be disabled after the tuning reset. The following
>> set_ios call would reconfigure the clock as needed.
>>
>> In case of regular set_ios call which requires a tuning reset, keep
>> the clock enabled or disabled according to the mmc->clk_disable state.
>>
>> With this in place, the controllers which have not been accessed via
>> block subsystem after boot are left in quiescent state. However, if an
>> MMC device is used e.g. for environment storage, that controller would
>> be accessed during the environment load and left active, including its
>> clock which would still be generated. This is due to the design of the
>> MMC subsystem, which does not deinit a controller after it was started
>> once, the controller is only deinited in case of mmc rescan, or before
>> OS boot.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Thanks. Do you want to take this via mmc tree or shall I take it via sh 
tree ? I wouldn't mind the later, since it is isolated to renesas platforms.

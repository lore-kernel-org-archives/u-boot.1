Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7049C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 15:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 504F484B88;
	Thu,  9 Jul 2026 17:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="eQD9G4QS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46C7084BA0; Thu,  9 Jul 2026 17:19:18 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7285884B77
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 17:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 285E9117C81; Thu,  9 Jul 2026 17:19:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1783610355;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=xx54r1mKkyd+srlFzXB05mMj7icL+lXlT72gX0OSbkY=;
 b=eQD9G4QSPcIvQ5TMI3lhQsx+tBPS+t+MOxajJQNalJmKp4TalU4BfFrgVPu0mjCfdNq3hE
 fU0lXcgtYV31ZPsZbHkvxPlrMW4j8ZLoIrdVi9M8p0n6ciKJigdXrmdiZnWC/Px9TCK3TQ
 BdO8S9DVI6DXCrVqwt3h3FFk+ObEZbcaD/Yi+dtaFfUQ7xMNtcfuEb4pm87tiIeOEcuPsA
 1gNhgPlnpnK7BY7g7w7S/l6c0a5OuqgqJDRjd5zQDHlJGEnj7vYNOn2shlXjmQokGKBtcD
 q+GzIiWj8AlLpaFRkI068QTzaLpukw8eq/at4Iwkw+5jxyjPX4s6PRRmKtPsFQ==
Message-ID: <7c58dd85-0e74-cbd5-ce9e-affa5912382b@nabladev.com>
Date: Thu, 9 Jul 2026 17:18:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] i2c: designware: fix i2c probe error
Content-Language: en-US
To: Coben Han <cobenhan@mediastek.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, wojciech.szamocki@nokia.com, bigunclemax@gmail.com,
 peng.fan@nxp.com
References: <20260611030646.894441-1-cobenhan@mediastek.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260611030646.894441-1-cobenhan@mediastek.com>
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

Hello Coben,

On 11.06.26 05:06, Coben Han wrote:
> Probing i2c slave device just needs its device address.
> 
> A certain type of chipsets such as RTC S35390A have no offset,
> which means address length should be 0.
> 
> But the current designware_i2c_probe_chip function requires
> offset 0 and its length 1.
> 
> This causes the designware-i2c to be initialized again and again.
> 
> Furthermore, after booting into kernel, the designware-i2c kernel
> driver complains its controller timeout.
> 
> This patch fixes this misbehaviour in such way that  only device
> address is issued, no reinitialization needs when target device
> not detected, the designware-i2c kernel driver continues working.
> 
> Signed-off-by: Coben Han <cobenhan@mediastek.com>
> ---
> 
> Changes in v2:
> - use the return value of i2c_wait_for_bb in error case
> ---
>   drivers/i2c/designware_i2c.c | 44 ++++++++++++++++++++++++++++++++----
>   1 file changed, 39 insertions(+), 5 deletions(-)

Applied to u-boot-i2c.git

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic

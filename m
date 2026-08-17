Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38668C5CFC1
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 04:51:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9CBF4069F;
	Mon, 17 Aug 2026 04:51:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rse1GwAKfbYw; Mon, 17 Aug 2026 04:51:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1197740693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786942318;
	bh=KHw2SkC5au+oDySe7fK0Jp3mak4cl+/qzLxElgZoQ6M=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=l+zy+fwy7ERTYX3jPPeHFUwKkY79a3H8AIqOWLYTgsJ2WisUAvHau22oBx6Lc4HdR
	 oPhVM3LdzMaPS2ZTf3WVNlRLhCmc6msJFiGU6qTMCUn8sVxivF6VesFA+IPdiLH32Q
	 EsG7e8oqkg9WPiV1ErrBxg99pu+J3HFDLYb6+D4LvTTgY1PhLNVRqdNC2JfL4VGNJz
	 oeqeX7bteJj5JUQ4aGpIv/Y6uRfCliuYVxwQ5vOv4ARwBFXDzUQBJshq+Mo5iqJzAi
	 KFDl4hNWZJ2msO9aHJIXiQ357n+EZhPbOS44ZxN5tmNQgReN0Pe49M1CtIxurhfSvk
	 243hGlyq3cfbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1197740693;
	Mon, 17 Aug 2026 04:51:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 72E72147
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 04:51:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 58E0160671
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 04:51:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2l-_-lhdYJB3 for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 04:51:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 231416061B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 231416061B
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 231416061B
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 04:51:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 470E911BE02; Mon, 17 Aug 2026 06:51:41 +0200 (CEST)
Message-ID: <ace81628-d641-0a8a-2e12-4707c0b2421d@nabladev.com>
Date: Mon, 17 Aug 2026 06:50:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/4] i2c: k1: enable both functional and bus clocks
Content-Language: en-US
To: Junhui Liu <junhui.liu@pigmoral.tech>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Lukasz Majewski <lukma@denx.de>,
 Yixun Lan <dlan@kernel.org>, Troy Mitchell <troy.mitchell@linux.spacemit.com>
References: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
 <20260815-k1-i2c-fix-v2-3-7d2a48607233@pigmoral.tech>
In-Reply-To: <20260815-k1-i2c-fix-v2-3-7d2a48607233@pigmoral.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Heiko Schocher via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Heiko Schocher <hs@nabladev.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hello Junhui Liu,

On 15.08.26 05:40, Junhui Liu wrote:
> The K1 I2C controller requires both its functional clock and APB bus
> clock to operate. The device tree provides them as "func" and "bus", but
> the driver currently acquires and enables only the first clock.
> 
> Acquire both clocks by name and enable them during probe. Use explicit
> named lookups instead of the bulk clock API to align with the K1 Linux
> driver and keep the roles of the two clocks clear if functional clock
> rate configuration is needed later.
> 
> Fixes: 271546fb8e54 ("i2c: k1: add I2C driver support")
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>   drivers/i2c/k1_i2c.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic

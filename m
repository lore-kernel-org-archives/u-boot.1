Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F214C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 09:33:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E351260766;
	Fri, 14 Aug 2026 09:33:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mviX1GqMFXWV; Fri, 14 Aug 2026 09:33:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 271AA60703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786700012;
	bh=9Gyb/RcjyjkbGNnuPaQqusybvAgYl4CGwseEVrhweiA=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=dkC6geXyB4DMmsij2v//TuZ3kD34VA1crbJR58R6lJ/welCUzlgdAiCXPGmTUFDFQ
	 xi8bDrf/Xo0fkZswSItKuR5e79Idmzypve70em4W0tUi24pbygj9ii/CGzeTjiZev3
	 OAGKcUfBtaysoz0LEZ3t9IKoJOKByfRHe6QoffArMQAc/ipdYYeRTCq0QaPER0PSW6
	 fuhp5nGjEZeyRZRJVRBn0gWgVuX3ed2+F2iostf9OeTT3bs6pLfAJLZS5ubjuckudu
	 657FXgE4TRsNLM4DkZ0mG+Qdyq2IPLHdE84NaHYp4UaoHE9hL6mofayeOPDGNNgC61
	 4p3zhwexBTzIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 271AA60703;
	Fri, 14 Aug 2026 09:33:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DDC1139A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 09:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03D7480F82
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 09:33:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qr_nXZ0t7vsD for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 09:33:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D39C081005
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D39C081005
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D39C081005
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 09:33:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 040FC11837F; Fri, 14 Aug 2026 11:33:17 +0200 (CEST)
Message-ID: <4c2c53f7-48db-b65c-e5a1-68200f3f683f@nabladev.com>
Date: Fri, 14 Aug 2026 11:32:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] i2c: k1: fix wrong bus speed setting
Content-Language: en-US
To: Junhui Liu <junhui.liu@pigmoral.tech>, Guodong Xu <guodong@riscstar.com>, 
 u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong.xu@riscstar.com>, 
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Lukasz Majewski <lukma@denx.de>, Yixun Lan <dlan@kernel.org>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
References: <20260814-k1-i2c-fix-v1-0-f2e19cbe0af6@pigmoral.tech>
 <20260814-k1-i2c-fix-v1-1-f2e19cbe0af6@pigmoral.tech>
In-Reply-To: <20260814-k1-i2c-fix-v1-1-f2e19cbe0af6@pigmoral.tech>
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

On 14.08.26 03:46, Junhui Liu wrote:
> The controller bus mode should be selected according to the requested
> I2C bus speed. However, the driver currently passes the functional clock
> rate to k1_i2c_set_bus_speed(), so the selected mode does not reflect
> the requested bus speed.
> 
> Fix this by reading the clock-frequency property from the Device Tree,
> defaulting to standard speed, and drop the unused clk_rate field.
> 
> Fixes: 271546fb8e54 ("i2c: k1: add I2C driver support")
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>   drivers/i2c/k1_i2c.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic

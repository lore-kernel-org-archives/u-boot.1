Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA16CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 09:31:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EEB460816;
	Wed, 14 Oct 2026 09:31:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n3aXhR9aQ2qk; Wed, 14 Oct 2026 09:31:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C0E4C607A9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791970275;
	b=Q20HSt0XCVNSy3BFEd8eI6n2CUTnb1P+KpDHaIMLQyQdarDpa5zaiR0e7EXo4fXcM3ku
	 oUGleTixfAju1i23aKFtJpzBMyMge8bs5+4j7GR6zEnriKsosK8kGDFQvk7eKbckQYxGx
	 TKoY73nZXfMITcLJJRVFcvhpEFMpsIKz7CktDfYOKhXkB7M/aYkgC0ZN53o+DI9KOms9a
	 /GhPpCFjnmy67QHctqO17lhjpoERj4rd9ZZneTlnnHciR3P7PiSOVkaOgtc1Sw0YFrgaX
	 Y1ZT2gebAsv0+8Ni6stHkRK/dc17IASXcdsbk0Em50pLS+P0R0lUC0fN42yXlI4LK7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791970275;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TBfs3saRs4rB+wQQ6++sCVWtQxWxax3FxTqc1H5t+JU=;
	b=dwzS/R94nC4j7+XOF90tgvzMx8eOuabgqBmDHPhn0UDpHfBNaz69uUESlOK3odzn9+p9
	 U5ZgQo2MdX14cC3n19HBEF+zz9AA70y/4stpJ4/q0N5ihyzU9AmN++8Ve57vBxd1VSazF
	 I89AT811E3nu4Ix6J7y1LsKZA1UQxmzaBd10H/N0ccF11BKDfoO/uWRTtjT6XXIwYeLZC
	 xh4OCqfd1Cq17rtFa1QD7cI1gF90o45YPiAAyCAEObQ7LzABo94GJyLfJjIVKU7n5yjjm
	 UaCXMuJ1YhiBmBQiJKijr/SeYt2pkaDNwn6kpCl1BiTMigPO3ombqU9v4zLl9Rmh25A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791970275;
	bh=TBfs3saRs4rB+wQQ6++sCVWtQxWxax3FxTqc1H5t+JU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JMPs29B8S8jUtaVrT7LybRz0EISn8hP5DCrYzfTQsu5mEjPp3WqM6TF14Z82lOdZ3
	 /Mi1VgmZVJIQp1Sd8digBzhTuBP6tnnyhy6/ZomtZFfROduPSvIMiUmAMDrQByCOeP
	 Ud+3dRrNwkhmGht0EzhhN58fIFVh5JM6bT3DBnwz5zoWbKr4sXbDiMluEvrlA23kDY
	 746v5S5JcRi6duAue0Vw16wmym9Qgkiv+VK1OtTXRq6+5Uba7q4qGyN5041flbiItv
	 kBr7ltQ0hceCC4d+v4xwHgunCd9oozU1yMOfV7mZZUafToyjymAok5/W077RHQrjCb
	 oTsm2Ava0NTUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0E4C607A9;
	Wed, 14 Oct 2026 09:31:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 59B7D1E9
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 366B880858
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:31:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ef3fU6_4z8X5 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 09:31:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 106F880854
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.125.25.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791970273;
 b=k3hsj8a+o6JJbhLHPwb444wf7TBDdYVOsj9lp/4bpKe5G6sPpSg5ttlqPD6F9qJr55m6
 ItuMkyioNPaznjfvkdMR9xzoubN3XfPgBnOcnQg4r/o49cmRkfGEtYJuftLDyFlQhx5cQ
 VVNPEwQ1uctclTRp9FE/5fP/8cpmMHOM9CUmxnsQQ9vgkDmBHi34KWQRwIDY0mJFIRjDT
 4ODGZaWgElv3WOBEwv+d8tBKpq085Sf8XdBg1iyPubfy0GgjwZX6nBlBYbYNi8vX+BfAP
 Uoen4rZGeSF6ALbNokAIZX89yv00avylEiisS8ElJ0O7vVLLFbylz5pNFnryKvPixLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791970273;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=TBfs3saRs4rB+wQQ6++sCVWtQxWxax3FxTqc1H5t+JU=;
 b=I6KEFUONmRT78oFMwTupvsHHm6GnCEthphQDC1f5HZfymdKpeiau5bRxAU6V8E6L1oqa
 1hGUGDlrN3D/9zlvlZ/SwpPsMaJCOvJq++5zY3C4b3fVx4up7GDvFlX4fXwqy7fW7d+5Y
 ZOMYvUV64CqMugmsmfK0SKJ9X3gXHkBfq80OfDyN8nvlE0b6f/vwU9m8q0nbNaYLxRUYZ
 o5NT0ruG8JrymclCG3JLnad1GSFhc8nKaw8iyDvk2TX/rU0HJlo+LfpNYBsVyJHvXDEV+
 R752Gpo6927v4oqWF/KbRfWkDapRQ69sdUtFJNRBOGEAt2iNTJ0dDtJvKIUOU8GfLgA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=i5THltBj; 
 arc=none smtp.remote-ip=185.125.25.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.9;
 helo=smtp-1909.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=i5THltBj
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch
 [185.125.25.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 106F880854
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:31:11 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j4Qtj1mXvz3BN;
 Wed, 14 Oct 2026 11:31:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1791970269;
 bh=TBfs3saRs4rB+wQQ6++sCVWtQxWxax3FxTqc1H5t+JU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=i5THltBjpuCDDY8oVyUjnQhId/ADXXrrsS7/4IXiT7Q6cIfCsrtybKXfL85Si8T1o
 CTh7LcepKdUSSpFvuVdfQXw8joeaEN0c4kfuJUs5k4Oyt5pVNzdYRk4E1ePFH0dAKc
 TmOyOtGECOK2/qvOve11Xh0qlnyORzQysa7d2LCYLIF9ZOMLNCfJLlcF+VwSY5Osuk
 0UUprkHTVxwu0QievaWjhaWEre96etwD0SqU1dXeFUWqlr1YVKtmVi1lcOb2CP2vXh
 1+wdCXuXGvAlN4nDcS2tadXYZS0gpQ2tqBf0NnRnYJuY0/Un0qo17xeKQ/Wd2NxBzk
 sjkyPkI+uC2SQ==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j4Qtg4L1mzyCS; Wed, 14 Oct 2026 11:31:07 +0200 (CEST)
Message-ID: <f142680e-b94b-47a8-ae9d-f793a5d043fd@0leil.net>
Date: Wed, 14 Oct 2026 11:31:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm: rockchip: Avoid TPL_LDSCRIPT configuration when
 unneeded
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>
References: <20261002-config-v1-0-11bb20983682@gmail.com>
 <20261002-config-v1-2-11bb20983682@gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261002-config-v1-2-11bb20983682@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Massimo,

On 10/2/26 6:35 PM, Massimo Pegorer wrote:
> There is no need to define TPL linker script file through TPL_LDSCRIPT
> configuration option value when CONFIG_TPL is not selected. Avoid this
> useless row in the configuration with no side effect on binary outputs.
> 

What is this helping with?

TPL_LDSCRIPT should only be reachable if TPL is enabled, so adding an

if TPL

is not supposed to do anything. menuconfig incorrectly reports a 
dependency on ROCKCHIP_PX30 (or ROCKCHIP_RK3328 if I entirely remove 
TPL_LDSCRIPT from arch/arm/mach-rockchip/px30/Kconfig), but this patch 
doesn't help with it.

> Involved boards being built without TPL are a subset of those based on
> RK3328 or RK3399. Anyway, keep aligned PX30 Kconfig with this fix, too.
> 

Yes, but PX30 force-enables TPL while the other two don't.

Cheers,
Quentin

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884B4EDEBF0
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 20:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4A5283E7F;
	Tue,  3 Mar 2026 21:29:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QCLB3wAV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD68383F2D; Tue,  3 Mar 2026 21:29:58 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E6B3839DF
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 21:29:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fQS8f396Nz9ts6;
 Tue,  3 Mar 2026 21:29:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772569794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SU+Fyum6BrtKnSfHuxtQOpdK5o9kTftk9XgoWMugux0=;
 b=QCLB3wAVemTp1l3gSpaNEP+zMG9NOeB0+Ys/aJmfYZhV2aIAMetz5gUorm3nZlGdvIqJWi
 WVxxbvMkwJG6iY6/176QGuLUL7rFTFGYl/KPvjJL8Dp7Y2ry+qc1XHNCkGtNcej+1+Hp6j
 pQHXrkXdpW6irT5zmVnS0aKIl8q6lXmlEXUA92VTZGpb8Y8RaqYbiDmYflUtk4tPSnzu08
 HwAZUD1HmGHM/2CeMcZScrpi1IJ/G/zUs/6d1MK4aShV3LHjKF7SFIvl1DolLd0kD0Du94
 jR6NP1qAkIfWUgB2/Pzvymiq6J2Mw1MsXx6SEFL1Op5H7IEfjAm+5nrPBFSRHw==
Message-ID: <9accf186-c355-4ba8-b9f7-771666c0f3cd@mailbox.org>
Date: Tue, 3 Mar 2026 21:29:52 +0100
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH v4 1/4] iopoll: Fix read_poll_timeout macro documentation
To: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>, u-boot@lists.denx.de
Cc: Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Marek Vasut <marex@denx.de>
References: <20260303062503.3392544-2-ronan.dalton@alliedtelesis.co.nz>
Content-Language: en-US
In-Reply-To: <20260303062503.3392544-2-ronan.dalton@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: cc80ea66667dc4d1f5e
X-MBO-RS-META: xjfpo3647wrnnqzhakjjyuw69bg9dg1n
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

On 3/3/26 7:25 AM, Ronan Dalton wrote:
> The read_poll_timeout macro has some incorrect documentation. @addr is
> referred to but that is now replaced with @args.
> 
> Update the macro documentation to make it more similar to the equivalent
> Linux documentation, which doesn't have this issue.
> 
> Signed-off-by: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
> Cc: Ariel D'Alessandro <ariel.dalessandro@collabora.com>

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

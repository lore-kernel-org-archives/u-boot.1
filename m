Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92F0E81BA4
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 12:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5C5F83BF4;
	Mon,  9 Feb 2026 13:03:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jbdefAo+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC0A483BF4; Mon,  9 Feb 2026 13:03:21 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF5448341A
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 13:03:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f8jyF49K2z9vGW;
 Mon,  9 Feb 2026 13:03:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770638597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2A9LRXFBCqZH6urpTPo4+2/hAAq8ffFLzB+3Adi7Guk=;
 b=jbdefAo+veEPCCWnEFpNgTvlCU6QRmrZ9TY0iSuEzGP1ANunuGcVHUJY4gkB+Yp5dHWyOh
 RFZFMJDAMxXD5zhuLNRQmgnDf1gpLDW413j7Qi2P8VDr1AvgRPAT7ZnIvAKJpAffJNHXrZ
 dyjxnsYUvv8jtqdyzroqb6W8IAaTSXO8TXeNdCGiOFp9HBhlFqSAUBt+oX5FWgm1AGQFu6
 2XAPv6rwC9tl+Q6/+WW6K0YUp51V/J/76c2Qh6PQXG4FJ9ARi5+esybPcMfP7ig8MbqVVb
 L4xGO1/zcrOs8YF5YCAB9mWtVEB60g03SvSyuhtJ2Q7gCqpiepyD1MFK9B5ntw==
Message-ID: <cb6e1a3d-151a-4dae-a6c4-b7ed0abfc936@mailbox.org>
Date: Mon, 9 Feb 2026 13:01:29 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v6 1/2] usb: musb-new: Relative ctrl_mod address parsing
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>
References: <20260209-topic-musb-probing-v2026-01-v6-0-efce26b4917a@baylibre.com>
 <20260209-topic-musb-probing-v2026-01-v6-1-efce26b4917a@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260209-topic-musb-probing-v2026-01-v6-1-efce26b4917a@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: j14mtk5wn5drgyqs34eou51ts3d8ffc8
X-MBO-RS-ID: 7e84164463aa10b28e7
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

On 2/9/26 10:24 AM, Markus Schneider-Pargmann (TI.com) wrote:
> For the upstream DT the ctrl_mod node is using a relative register
> address which is not translated by the current code.
> 
> Make address parsing understand relative addresses.
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

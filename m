Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B358EC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 08:58:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26DBD88221;
	Mon, 15 Apr 2024 10:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="eZ6MLVaQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54D4688223; Mon, 15 Apr 2024 10:58:14 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 755F28820E
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 10:58:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1713171492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6XtMsrF8Q01PMEory9n7ftUs3VZZHC2K9/zcnenB8Sc=;
 b=eZ6MLVaQnaO6hp02rvkQ2AeRxREY2ZuRKzKgchuuDFdHpPTu6X1AyNY807oocsQXYj+1fn
 HuYN+81WkTgGvbLNDnDXsPxTqUeC46F/v6EDijNfn9j+jTZglPTFruPRmE72vPkBmgX6e3
 8uZc5ssTjHyLVomh/+VZvdSecje1Khh0CvByr+iaGPT85G32beqWb8X+SwQzVHK0Vpiv9r
 GFDuynYcZZpdXpXEQuzGesFYJ0bZWUTKq95wU1BLp9fQXKxUyWmOEwGWMiIlr9HjJ7hrN4
 U0ROsgYOuraJWu4VzeW1F0PS+YHiRtbWrsHmODBVdI/8YtaoaBXySZ46m2I43w==
Date: Mon, 15 Apr 2024 10:58:10 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, Andy Yan <andyshrk@163.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 14/23] rockchip: rk3588-coolpi: Add boards to
 documentation
In-Reply-To: <ad8440ae-d02f-4b02-be58-a37369f3eb52@theobroma-systems.com>
References: <20240413181425.1384357-1-jonas@kwiboo.se>
 <20240413181425.1384357-15-jonas@kwiboo.se>
 <ad8440ae-d02f-4b02-be58-a37369f3eb52@theobroma-systems.com>
Message-ID: <6b46f02336966f5fa1af927101e65298@manjaro.org>
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

Hello Quentin,

On 2024-04-15 10:56, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 4/13/24 20:13, Jonas Karlman wrote:
>> Add the CoolPi 4 Model B and CoolPi CM5 EVB board to the 
>> documentation.
>> Also fix .dtb-file entries in Makefile.
>> 
> 
> When one needs to use a list or say "also", "moreover", etc... it
> usually is a tell the commit should be split.
> 
> Here the changes are not related, so please have two separate patches.

Agreed.

> The sum of changes is fine though, thanks.

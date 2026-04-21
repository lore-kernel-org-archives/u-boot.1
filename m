Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D9CF5A8CE
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 00:48:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45B928433B;
	Tue, 21 Apr 2026 02:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PT4sggTs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0CF384198; Tue, 21 Apr 2026 02:48:22 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC6BD8422D
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 02:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4g03cc4Wthz9tqX;
 Tue, 21 Apr 2026 02:48:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776732496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lp+YQQbNd7or5Y8K1nk0vrX9IF/28wzAONDnkEqk4kI=;
 b=PT4sggTsVO22VnTIl2/xzTWnkpa4VTyCbRWb8Ix4cQA1OMOulmAchxoKo2nYMZdJgI6SHg
 9kxPUAFNRB2kplP9grVUyj/zwXGQwDKzYcIXkb1irujucc7FE/aJWbwJcR2yOkeabh+Tb9
 qvN6+TypI+yDDw8JD7UcMXPZHrOkf+WJYRjgCHqAHAgoiYLjtwALPzk0j7HW8EfQvj10tF
 IOfUdSw/AbLAOCyUx4Nswbj7zHf7OXWQ/dmc/1XHvsWHmOtnARwbqA1mTqn6feZOEDjoxj
 XYceGVvqWCvb9vG0nPJ4uRyQapMhuivJSXpSEhBs1Ml9KqwpFVflCAj3kCYqMA==
Message-ID: <9fb7b80b-cbc7-427e-9a2a-15e243447b0b@mailbox.org>
Date: Tue, 21 Apr 2026 02:43:40 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/8] usb: onboard-hub: fix compile issue with gpio.h
 import
To: Mathew McBride <matt@traverse.com.au>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>
References: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
 <20260421-ten64-add-usb5744-v2-1-eaa81288e393@traverse.com.au>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260421-ten64-add-usb5744-v2-1-eaa81288e393@traverse.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: cd8dec76c8169e1db9b
X-MBO-RS-META: hu9ygxa7ch6i31ujkjszznjgcqriigf9
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

On 4/21/26 2:04 AM, Mathew McBride wrote:
> This resolves the following compile error when compiling
> ten64_tfa_defconfig:
> 
> In file included from ./arch/arm/include/asm/gpio.h:2,
> 		 from common/usb_onboard_hub.c:10:
> ./arch/arm/include/asm/arch/gpio.h:17:9: error: unknown type name 'ulong'
>     17 |         ulong addr;
> ./arch/arm/include/asm/arch/gpio.h:18:9: error: unknown type name 'ulong'
>     18 |         ulong size;
> ./arch/arm/include/asm/arch/gpio.h:19:9: error: unknown type name 'uint'
>     19 |         uint ngpios;
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Mathew McBride <matt@traverse.com.au>
Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>

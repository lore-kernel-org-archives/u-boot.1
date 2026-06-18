Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5234CD98F8
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 04:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A41D847C3;
	Thu, 18 Jun 2026 06:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="b81aVmZ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C73A847EF; Thu, 18 Jun 2026 06:47:21 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7CC18460E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 06:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ggp9c6d6jz9tRs;
 Thu, 18 Jun 2026 06:47:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781758037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3EaH650Faksx+EDPfbaOSoKPUzae23YSomNghRNXZg=;
 b=b81aVmZ5FECQRyGznnwIg5cTTEqAYhxaFNUngxzyJtcbXzsv5A4zJIkcZoTdKKFs0gvP2A
 FhVsZNhqOgQhBU1cJxNTnKH2+GfuMDyqxB4uX2xJueA1WBZb12+5BiBmp1fvf0peqs0VJW
 9WehDgE5RQIm0uSAfutoUuWLsL2L23QuR8YOBTI8rLQlJPC9YT/gvVTqVRXy/iXCblO3DO
 cS4a5AzpTuZTs4ITdu/ApJJI79wcL2fFFgYM0rt23OB0wd0j8GyseqtrlZ589TeI7Z+oEk
 YkUW214SRu8I+ybqi2u04ZqqPNlvPbxm+FN5TsC3wfVJuyghQjzEeB4jtt+i3Q==
Message-ID: <9e1b7ae4-fce8-4ffe-915e-23aefa5541c3@mailbox.org>
Date: Thu, 18 Jun 2026 06:47:15 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drivers: serial: Fix dev_read_addr error check
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>,
 Tom Rini <trini@konsulko.com>
References: <BESP194MB280584A431D400DDB6A9E2E2DA0E2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <BESP194MB280584A431D400DDB6A9E2E2DA0E2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: opqqoxyijx71acw1j68z87w649m66h33
X-MBO-RS-ID: dcb76007930062ef0a1
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

On 5/21/26 7:52 PM, Francois Berder wrote:

The subject tags should be "serial: sh:" instead of "drivers: serial:" , 
I can fix that while applying if that is OK with you ?

> dev_read_addr returns FDT_ADDR_T_NONE (-1) in case of error
> and not 0.
> 
> Signed-off-by: Francois Berder <fberder@outlook.fr>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # R-Car 
H3/M3-W/M3-N Salvator-X(S), H3/M3-W ULCB, V4H Sparrow Hawk, X5H Ironhide 
RSIP and CA720AE

I'm sorry I took so long with this fix.

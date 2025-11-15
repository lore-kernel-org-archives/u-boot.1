Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787A1CEB2F1
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 00:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43C1E83A8A;
	Sun, 16 Nov 2025 01:20:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ROLJx/Ye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04D5383A6A; Sun, 16 Nov 2025 01:20:22 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F4AA83A35
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 01:20:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d8BNJ4l22z9tKR;
 Sun, 16 Nov 2025 01:20:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763252416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A6oSY4EqZ0J46xgU31SP1x4JoyiqTu7c89+wurLqpQ8=;
 b=ROLJx/YeizEmvBgQThVOHdaWtpj8BnzO9a+UQM7Wd2MpTjACFXvimY9Drv0efMXG2Vr4g6
 rfa6B0yCtnB1n+vKL9NGMNd7K2uR3myNTP+bn+I4TUT1QidokqWPxBt9ENlGfS5gUwz+eC
 UJ4k5Yq3bXIqw8F4MdKzGIAcKcAm9rNmoZEzU3j0E13zwy/BXWSnFvZGJQgYLPuWsV8/pr
 UE5/l1k21vpPaWmpH0UmOfycdTCMsnsFSi9HKSB6KpCIsNYUreiQEHS8I5GSMAtXFTm/hZ
 OAgCMivOJSdHaUgda0ttGeu/LAWRv8LgyIkRCfTPSXb2h0ldXMuRFkP18z9z8A==
Message-ID: <71261c83-0a3e-46b6-a0db-d3587a54d71c@mailbox.org>
Date: Sun, 16 Nov 2025 00:23:30 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Synchronize DTC to 1.7.2
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113175700.GM6688@bill-the-cat>
 <63d6a47c-99cc-48d1-9d71-869c58e2eb69@mailbox.org>
 <20251113184917.GN6688@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251113184917.GN6688@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 21ff85ad94a2eee6309
X-MBO-RS-META: 89bzgof4ie6cn3axrq15t7fx7b1x69r1
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

On 11/13/25 7:49 PM, Tom Rini wrote:

Hello Tom,

>> CI does show that no boards went oversize . If there is some growth on
>> existing devices, maybe we can shrink that, but maintaining obsolete DTC
>> code base going forward and picking random updates into it, that will only
>> lead to increasing maintenance pain, so I don't want to do that.
> 
> Yeah, it's not an easy spot. But I'm really not happy with growing main
> U-Boot almost everywhere by 2KiB - 4KiB, and SPL by ~512 bytes or more
> just to keep up. I do see that integratorcp_cm1136 barely grows at all,
> so maybe there's something that can be done more widely and just wasn't
> clear at first. m68k only grows an average of 500 bytes and MIPS is
> ~1KiB. PowerPC grows a lot. RISC-V a little.
I suspect this might have to do with DTO support. The imx8mp_dhcom do 
use DTOs and the fdt_overlay.c code grew a lot.

I also found out that if I patch out can_assume() and replace it with 
plain 1 , then the size drops by 1-2 kiB, but that's probably not what 
we want to do.

Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0D9C88E77
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 03:26:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56AF980C38;
	Tue, 15 Sep 2026 03:26:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oL4o64LMlRHa; Tue, 15 Sep 2026 03:26:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 98A7D80BD6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789442772;
	b=DPKxkuZ51lgT+GVddpBeL3/16hx5u3RN4OK5ju4bo7mAt8Gt1XlAoHbdyuIbrbUqumCl
	 R9P+uA95OIKR7aW9wK0ghpjc400ylb746+kcCy2IUgzjFZ3QUMHCerOsvHmzgrUdL/AJx
	 FWsC+YpZCjIrCNCJLkY5hnZZHz5EI3rNEVvYeKKd2NAsh8c7YjzhquwC2eUKVuds3adFn
	 FXS3CLdftJumJAdouDYOC7vTF2+RzKnhMW21veY/iHmqGRr3eZKMx1PHWakfLNZphVuuh
	 O/QRb8ZfZLQCly1c4ayObyCZchh2HZM/x45PJ4TCuO8naAu94nxWaSAb1e+mCFfXRvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789442772;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:DKIM-Signature:Date:MIME-Version:Subject:To:
	 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cBvaQSDHWLuqRF8SW/29Cis7+g30/Mi8tYG/4JI4gMs=;
	b=TlnWuu4xVZdJIuas9XpWeWbM6HyZP16nDR/wLZll3hQsacg+dIHCQ5booJ9ZQlAzhHLc
	 5dYYQhM03tKaBpb5sAs/A+bgJtbYC+TUHwidmPbcSu/xNucgEMfp0yMz2KER8hVYs/f7v
	 XrVZUi6DdhZJGaLcnQy9tFGG/D6jbVNZO9xdUeSLyRlrljtRmTxQj1nJ76lSCfapPCdef
	 pweDvsu8gXGgdNmzxOaO1b/Yy7KdTmFJgLV8cKMnbERjxBPPJHMq/UF026B9/EBNsG+Wu
	 aGBznmZMzmDqUZRlmr/Ggny+Mv6MSGMxiawMl3hlIYbThNejqZPvXFZJhV28mA+fJsg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789442772;
	bh=cBvaQSDHWLuqRF8SW/29Cis7+g30/Mi8tYG/4JI4gMs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vrCvr8J9AgTjgof2AatcvEeBSMk8sVh4QR4KcA+8LzrwKyPfBw470SfMdCQnwIrxY
	 g4kfOD9PYvyRIOzRtN3mv9MIZDSQpG+DuvoOixx57GX9GPQmBaFPg3YtK8sj7aNbMk
	 tJf5sNW9FpRPtFizTwJkEbBRYSItsSsCpGmmVeAHAUnB/VPIM38cUA1NohQ1EVUb5V
	 Tn/+jXJfZ/Oe6H4jP6OOM91Dk1UMpEiSKGU79xGNqEzqz8yDpRd3g5qpE7GwtG7QMH
	 ylQIr8SzYtb2JjF60wF0OYDz4iasGXBIfFvLu46HJKU3Tapz3EmYdOTM3xC3t6eMlA
	 7X8hgaJshis1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98A7D80BD6;
	Tue, 15 Sep 2026 03:26:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 71AE1465
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 03:26:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6376A4009D
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 03:26:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PUBmR6XOmH3u for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 03:26:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5D0BD40082
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789442770;
 b=I2W9x0oCeZ7DfiqPdYKHta9uW7rL8hR3lxeV7T+odkg6kdEW2KbLJaYjo2jz3w8T95Xg
 ugQDbc3kB7PIdVW0yu+8WNRtsFXwExN155VL49jUV/f4abmkL8Hp9dwX1RLIN682Wj3OD
 1NwZ2Hmot5L2YS/vfsER96K8pWYMXZY5SBritL4LCFFgYhiBbJM/CPB2ufNCh1AMLQyZ3
 9HqKsWGidn0I8S57GaGUlt/aTG+RzvFWTkNz2u0SiTdpshHUP+xdSYzhM8RnlFwZOkoPt
 ativaBLqaB6qSs/cOBADrqvsQZI53E64TbUNuwIM58kAgv9qui9EakodOuwOHK9NRQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789442770;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:DKIM-Signature:Date:
 MIME-Version:Subject:To:Cc:References:Content-Language:From:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:
 X-MBO-RS-META;
 bh=cBvaQSDHWLuqRF8SW/29Cis7+g30/Mi8tYG/4JI4gMs=;
 b=mkFQ7bt9VvCbDEx+9mE9pTmx0shHTC0rR7/iKwtkKUe77we6TSvvVisTBF6PUVgU+zHt
 SVGS+OZtDkas/zhqVE4R6ObcMazbiFpmDSSqSFKXUyHKkchkwLgyyBsCEdDQ5+8469+zu
 ZyzpgDvUJWeRXNu1Sw+lm4obOzd5NQFpaC7qLh0kfdKQiK6Ap+PC9L8azonG19A5mLY+B
 S22KX7lzlylNOK5yyU1t7mf3RDZe27UsHHxPwzyrSx2XcLHXX+35B296gXvwZ6M5DK6jL
 fmpkpPa0dCWeMTbhgXyhKq3Rvr2TwNheuEcGqzXg0krxYIRcaGJZQk+CUINNrgTvzjw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b="OU9Ar/Ak"; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=v63oF6xO; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=OU9Ar/Ak; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=v63oF6xO
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D0BD40082
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 03:26:10 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hkS8v3nTrz8sj5;
 Tue, 15 Sep 2026 05:26:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789442767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cBvaQSDHWLuqRF8SW/29Cis7+g30/Mi8tYG/4JI4gMs=;
 b=OU9Ar/AkFL3LSLblIYDK4bDfbhKKoEVNXSFdmLR+Wh0EL8JVxXa6NTmUtMxOzGtVXQBZUn
 lgraeVPDGMXaXQ6enf1o9pLRu+z/OVWsF8lc6azm9qJ5ksUiclTqsA4u3iW4DGSTXvSFWY
 zd2dz7QMDQtE5dtjLQFlQJjYYNCnpa9RQOCW5o3foV2nrPNmipfbRj2hxwTEdbYrakuLTA
 gKxl0ylbVN7g2gzCai7RZBvNzVZ2b2x9N6AyFDWMwUVGkE3c/iO5VJVnDzHGnUCaUEoxSb
 kUKeFSrvgir7HJ6Sch1pCFsVRbirj1hoOh9T8Xzf1Mn8EMGOmqIKUY5oN+VsLA==
Message-ID: <7afa5ce4-060c-4bde-a820-2a579a0fad12@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789442766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cBvaQSDHWLuqRF8SW/29Cis7+g30/Mi8tYG/4JI4gMs=;
 b=v63oF6xO1IC++NBH5VX2pEgEzFSuo77P3okgQPJJry0UZbuHl0N6qgLBHOkdZXpF195ZVI
 VJUlXufVFQFg8M2S8EDK30UnpOdoZmq6QF8eZDt8VFNgNn5Sgwf8l5S6lF/EFdQx9B0rCZ
 sgvtZ1pl8ZXRUr+enBRqv9jockUp2RVh+/Bl4C3sFGZmr9yaxpZAr7WHw8iw/E8zQjm2xQ
 JkBQ0VW8ExGmcUixl5epFSvCa0UtX4/DgIFRym4H0pM00OIzs99sGyqOqjCfiwDpjPD98u
 Vr4hbbaTtcjlrLM9S+YDg1h7ay2wD8kujTI/H2CngJj2Pp/OBHzqOlEglMG18g==
Date: Mon, 14 Sep 2026 21:31:25 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/7] usb: skip host-only devices when picking the ehci
 gadget controller
To: Stefan Eichenberger <eichest@gmail.com>, francesco.dolcini@toradex.com,
 trini@konsulko.com, ilias.apalodimas@linaro.org, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, marek.vasut+usb@mailbox.org,
 lukma@denx.de, mkorpershoek@kernel.org, antoine.gouby@toradex.com,
 alice.guo@nxp.com, stefan.eichenberger@toradex.com, sjg@chromium.org,
 emanuele.ghidoli@toradex.com, franz.schnyder@toradex.com,
 pbrobinson@gmail.com, quentin.schulz@cherry.de, jbx6244@gmail.com,
 ye.li@nxp.com, xu.yang_2@nxp.com, bmeng.cn@gmail.com, xypron.glpk@gmx.de,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev
Cc: u-boot@lists.u-boot-project.org
References: <20260914074314.12522-1-eichest@gmail.com>
 <20260914074314.12522-5-eichest@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260914074314.12522-5-eichest@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0cec51219451fe185bd
X-MBO-RS-META: qs5bz8ruufmmjrd35gfody1635ch5d6w
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

On 9/14/26 9:42 AM, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The i.MX95 SoC has two USB controllers, a DWC3 controller and a ChipIdea
> controller. However, U-Boot might select a controller that is marked as
> host only in the device tree when attempting to set up a USB gadget,
> leading to failures in gadget mode.
> 
> Iterate over usb devices and skipping any that are marked host-only when
> selecting the controller for gadget mode. This ensures that a controller
> that is marked as device or otg is used for USB gadget functionality.
> 
> Verified on Verdin iMX95 hardware: "ums 0 mmc 0" now correctly flips
> the ChipIdea OTG controller into device mode and enumerates on the
> host PC.

What was the previous incorrect behavior ?

Does your board DT have /aliases { usb0 = &... } entry pointing to the 
chipidea controller already ? The controller indexing should match the 
aliases ordering.

[...]

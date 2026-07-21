Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A133C44531
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 03:33:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48B9D407F6;
	Tue, 21 Jul 2026 03:33:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8BKMkUU2azsm; Tue, 21 Jul 2026 03:33:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 22F96407F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784604793;
	bh=6mSDY5w1Ig2Ze6IHaFQP/H30cDQqBvBY5WGoGJCR88w=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Ab2/lqJzM7bw6ddOZs1AgvpxaCqA+2VA9OvIBa+nu7WUWnyzk00djfJY7tVzSKBxs
	 0uxUffi05SDzcoglbT4H4QrAUq6nVa0Uv60YXGVMQPkP6w+T2kF1RpuTKCd9b7dZW0
	 uWeJmPTxxyvzJLw5+/13/2tnyYaihIHodqVCbrIRfyI8kEJOskqqxmIst3FH7gVYh6
	 sO3tnLZ3aWMCPaIw8PUcrxSF7x8GCcKx0eoT087pKnm6j0BNjIxUTz3w6cKsPVCzkb
	 +wy3eVII3OEPvQSWSntdYaihgE0kqdXJ5Yk2WudohKJ/Yiv/3u8DhPGsf/m1RHR90c
	 +fhhr1LvLwcFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22F96407F7;
	Tue, 21 Jul 2026 03:33:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C1A196C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 03:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 726A9401FC
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 03:33:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FUiiT-kjhZwK for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 03:33:11 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A684A401D0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A684A401D0
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A684A401D0
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 03:33:10 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C376E846A5; Tue, 21 Jul 2026 05:33:08 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D694182991
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 05:33:06 +0200 (CEST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h42yn1Ff7zKwBm;
 Tue, 21 Jul 2026 05:33:05 +0200 (CEST)
Message-ID: <33a73c9d-8449-48ab-9d0a-852042c82c36@mailbox.org>
Date: Tue, 21 Jul 2026 05:22:50 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1] usb: xhci-dwc3: Call xhci_deregister() before
 asserting reset
To: "NG, BOON KHAI" <boon.khai.ng@altera.com>,
 U-boot Openlist <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Janne Grunau <j@jannau.net>,
 Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>,
 Tom Rini <trini@konsulko.com>, "Chee, Tien Fong"
 <tien.fong.chee@altera.com>, "MANIYAM, DINESH" <dinesh.maniyam@altera.com>,
 "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>,
 "LOK, CHEN HUEI" <chen.huei.lok@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
References: <20260224151828.20838-1-boon.khai.ng@altera.com>
 <321c50e3-2557-4b46-924e-13e66281f1e8@mailbox.org>
 <SA3PR03MB718757EF71E7CD6F2A16DA67B4C22@SA3PR03MB7187.namprd03.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <SA3PR03MB718757EF71E7CD6F2A16DA67B4C22@SA3PR03MB7187.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e687bf51c8b214197ad
X-MBO-RS-META: qmcu1g5tfs9mhq7hstuf6yjt44sczx7a
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1784604785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6mSDY5w1Ig2Ze6IHaFQP/H30cDQqBvBY5WGoGJCR88w=;
 b=jad2GvwNuMqPiwgYOCh8CRIM1uHcnIN6ZzxunbiQHWuzjo4FbMg3ORMmKIL8IsDF4mMTVB
 1bB+q+xsoPuSnGyiriJPpvrb5I3dhu9zA8U8eQXDrp0ijGR4+dpf8Maqc4rK/9k5eGbGGk
 dhtEw/N4UMvqHUZY+AHLHhEnaqS05g2sS33s8wfLuP6nNLWJG8BhWRLf1XwSeOsE7ud+Kv
 IBTgGVT843kVFca3DKUtK2Wv4jJyM6qpSJ48WazSxoB3ysslOEMmaDBLMC4WlIhEQ7k4yO
 K5gK86eZ/4BSO7wZixxKHS9pGIKGFcsiGxpAYgIdq9Bd0EVy6ygzFhjfXnvfew==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=jad2GvwN
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=marek.vasut@mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=mailbox.org header.i=@mailbox.org header.b="jad2GvwN"; 
 dkim-atps=neutral
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/21/26 4:56 AM, NG, BOON KHAI wrote:

Hello Boon Khai,

> Thanks for the review. Just checking whether this patch
> is already in your queue and when it might be merged.

The patch slipped through the cracks, I applied it now, thank you for 
the reminder.

-- 
Best regards,
Marek Vasut

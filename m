Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A4AC55173
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 20:16:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B624C60728;
	Sat,  1 Aug 2026 20:16:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yN4fiKAGXf5S; Sat,  1 Aug 2026 20:16:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E14C7606DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785615408;
	bh=amCr9qku4ofBKMyXCYgDQaX0OkVIMOAEjur78dY52J8=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=aVBMgvcidpXIamYC0PgkztP3oZU8zo3BHpiXFwFvUVmR37+uF7MiJ8RnIvATHFt5G
	 ydRviUjJRZvASbcQIELBEeKqX8CB7C0sqRgmH2RqJLFCzoiMJPLmmVDtMXM7Zn6upU
	 BSJsz6jV4H3wn03qFUQQPRPGxJkhigOj9EifS8j56TWtn88exK7d3ceAcuRD7g0HCs
	 uLXp9TENSUt6Q7f8u1evQRpo8LhAdfhHfJbMp3ZybUp1rJbCgH4MJsjE17fLHtmqvZ
	 uKFF9lTYHXkm0l1z3fjz0mqN9FdizRp6vCxAgrYsZlvXipuMnfYGL4kpnTQvv3eM4C
	 EoPstNXC1Z68w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E14C7606DC;
	Sat,  1 Aug 2026 20:16:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 608A23B6
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 20:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 523A040608
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 20:16:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9OjR22hQVV1W for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 20:16:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A2DA640605
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A2DA640605
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2DA640605
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 20:16:41 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B960A844F6; Sat,  1 Aug 2026 22:16:37 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9AAB80117
 for <u-boot@lists.denx.de>; Sat,  1 Aug 2026 22:16:34 +0200 (CEST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hCDjY4nPzz8t54;
 Sat, 01 Aug 2026 22:16:33 +0200 (CEST)
Message-ID: <4de93606-a4c1-4b69-bfc9-328c2aa29c4b@mailbox.org>
Date: Sat, 1 Aug 2026 11:52:12 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] usb: mtu3: wait for TX FIFO to drain before disconnect
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Bin Meng <bmeng.cn@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>
References: <20260720-ccaione-upstream-mtu3-tx-fifo-drain-v3-1-45c0e072b64a@baylibre.com>
 <DKDEITT18XJS.18WZM0Q9PGROO@baylibre.com>
Content-Language: en-US
In-Reply-To: <DKDEITT18XJS.18WZM0Q9PGROO@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: okoiz8zioqobfzyodytt6h1aitgz6ut1
X-MBO-RS-ID: 6467d51b12fa38125b7
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785615393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=amCr9qku4ofBKMyXCYgDQaX0OkVIMOAEjur78dY52J8=;
 b=X+DHGnHn/1Uia9Ar/kVVR12j3812mNhNkj059pldaO4FrFRmcHcijoA316jiDUaSou2Qrh
 +lCQGyxe3tQxy8h03pU5sGe4hUav4W6bGEVw/xHmSzYasI9QtbUlT5ZMW++a2BwAnsD2qx
 JO3vqNBxaMCrHRFOgBoXmlKVBvditDOif8VmFBX1bfmJAM1Utmq8u55WEoQ40j7ppGVRAq
 5O4BpfDM2MCp28YxzF/Mqwehuv9thdO5XYpExKNtduvxsFa3IgmYo1C8qrmFZOFrCrHYbn
 A8gvoA35W482KnI6v9d1x3hSReFsRDK7+9Nt4ScY4zFppicVBi7BvQmSLuoRDg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=X+DHGnHn
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=marek.vasut@mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=mailbox.org header.i=@mailbox.org header.b="X+DHGnHn"; 
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

On 8/1/26 8:42 AM, Carlo Caione wrote:
> On Mon Jul 20, 2026 at 10:03 AM CEST, Carlo Caione wrote:
>> Fastboot unregisters the USB gadget from the completion callback of
>> its final OKAY response. MTU3 QMU can report that request complete
>> while bytes remain in the endpoint TX FIFO. Disabling the USB function
>> immediately can therefore disconnect the host before it receives the
>> response.
>>
>> Before selecting the high-speed or SuperSpeed disconnect operation, poll
>> the FIFO state of enabled IN endpoints that have no pending requests.
>> Bound the wait to 1 ms. If a FIFO does not drain, reset its endpoint,
>> force the disconnect, and propagate -ETIMEDOUT through the gadget pullup
>> operation. Endpoints with pending requests are skipped so an ordinary
>> disconnect does not wait for an active transfer.
> 
> [...]
> 
> Hi Marek,
> can you PTAL? Thanks,

What does this mean ?

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2189BFA3748
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 13:47:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9160C8423C;
	Fri,  2 Jan 2026 14:47:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="epXFFo2F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A80208423E; Fri,  2 Jan 2026 14:47:27 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 776408422F
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 14:47:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4djQ3v4GFvz9vNN;
 Fri,  2 Jan 2026 14:47:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767361643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YDsT8D3RMyjbnVJFNjYHHXGZrdF0FrRuajSOFRDIybc=;
 b=epXFFo2Fs//U0g1+fNxEg4SaxYQcr+pvX+x+DjNk8UfdJL1TlEkAx/STjnIc/WlWFsB/Qs
 UMQ/R7ornWdcwqVJuAhWmRGOKZpA9Q8MvZx9B4ZIohaa0ipykHkwIJZPBCz93bUh9AE4AE
 QDVU7NO+JGFAId5gSEimXQA+i45oxUb62yJtvJ40Ulcyy6i7GrS4I/EtLkxe1B6fZPQUrc
 yEo6OxQ34FbiDDsH3iFlUMFkela3Mp1FJFbr/mWRfhEZxHZGizBcy8qVBLigRyu+/ON/lD
 dpbh8CeMxVEDIb0btsT56enafZpI49IC72HQUwAFf+XpwKb6mdmSVhnbGf3Y2g==
Message-ID: <da40c4d0-8c8a-4341-b779-96f571b7db87@mailbox.org>
Date: Fri, 2 Jan 2026 14:47:21 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] usb_kbd: remove match string
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
References: <20260102125622.144573-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260102125622.144573-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: zm1px18dgfujzakepdo4zi4drao1hgau
X-MBO-RS-ID: a3b7f821ea300e7ca40
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

On 1/2/26 1:56 PM, Heinrich Schuchardt wrote:
> USB keyboards are identified via a USB interface descriptor or via USB
> vendor and product IDs but never via the device-tree.
> 
> Remove the device-tree match string.
The commit message is wrong, you can actually describe USB devices in 
DT, see e.g. Linux:

arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi:              compatible = 
"usb424,2514";

Documentation/devicetree/bindings/usb/microchip,usb2514.yaml:          - 
usb424,2514

However, it seems this particular compatible string is ad-hoc and 
unused. I wonder if this might break some users like RPi which supply 
external DT and may depend on this support ?

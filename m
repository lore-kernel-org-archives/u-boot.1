Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E7CC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 14:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E371889EF;
	Fri, 14 Jun 2024 16:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="W8cJdlYX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EiV8Efze";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0E00889FB; Fri, 14 Jun 2024 16:05:56 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC6A2889D5
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 16:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4W11Jy4DVCz9t0n;
 Fri, 14 Jun 2024 16:05:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718373954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+p9sv1uz5bN0wMpS2s+ImEsg+kmGVKaraFeN4WzaHjY=;
 b=W8cJdlYXJ5rclYUoVuu6v4kxu7Vbp2UhJNsi/+NXIm74xp8/2UOSSBMfNjAEKIUoY58qcQ
 FPuu5sJGPvCTQF8x3SMPoFRq+e6K3QbiOYOgjryYEAXj1ASPz8215ZrJcIBJC+H4Az0gmi
 Tn7jN6guow9yoors5lpLPR4bZUlfzA7zlcGteqYWZHW0r1EUnpuNrjuqwq1UwGA+N3kpei
 yWH9kL5QyA7eDTxbTOTU6Ja0PZFsbFc22Hq3AaluDXgVHNGOV9jiH6dbCIypU9gM7NSEky
 HOJY2JgnEEUv00hd2KXKV6Y441/L76Z/bgLt77qoIqg4huUhLWbKwweOWYQlFw==
Message-ID: <55de44ab-af24-45a2-9dcf-fbd1a61e7af5@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718373952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+p9sv1uz5bN0wMpS2s+ImEsg+kmGVKaraFeN4WzaHjY=;
 b=EiV8Efze+TYyqKBhq5+f+XLIot5eXO5k68JyUwehFYGYlG4QNi6yglPtS/ZkNLTtvMtjIX
 cgHH5aRF3Z2UVd8akOY09W2fEd/cwA99pGk1Bpv3NaXdeY4G0WNRJNDehaxwhpaPz6QAQO
 HHZUezjWiN/MBZiT7gnrJhDdtixf67gDCOAKOvn4qM8ESVku33W5waPRdLc7c4exIW2T/m
 XnJen+mSOb5IO+kx3x/tBoLF/u8MdDpv5TPmztjDDgFLSq5d6brXgU2oWvTMDqvDnPA//m
 B5UrwQX8GR4dWkIjh30NuVX/yCYnuqKHOIMMmHehoigio/aqLq42ul0KJMm4Hg==
Date: Fri, 14 Jun 2024 16:05:49 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 00/11] usb: gadget: Introduce handle_interrupts ops to
 USB_GADGET_GENERIC uclass
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
 "nm@ti.com" <nm@ti.com>,
 "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "trini@konsulko.com" <trini@konsulko.com>, "lukma@denx.de" <lukma@denx.de>,
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
 <a496bca01525cad39174aa6dfe6e1d80abc7ebea.camel@siemens.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <a496bca01525cad39174aa6dfe6e1d80abc7ebea.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ga9sayuaxyruxd38cko6qs7beh4xd84r
X-MBO-RS-ID: 3608b2af23840ddaed2
X-Rspamd-Queue-Id: 4W11Jy4DVCz9t0n
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

On 6/14/24 12:24 PM, Sverdlin, Alexander wrote:
> Hi Marek!

Hi,

> On Fri, 2024-06-14 at 02:51 +0200, Marek Vasut wrote:
>> Introduce .ops for USB_GADGET_GENERIC uclass. The first new ops is
>> .handle_interrupts which must be implemented by DM capable USB gadget
>> controller drivers and must implement interrupt handling similar to
>> dm_usb_gadget_handle_interrupts(). For DM USB gadget drivers this is
>> a replacement for dm_usb_gadget_handle_interrupts(). Convert the DM
>> USB gadget drivers to this new ops instead.
>>
>> DEPENDS: https://patchwork.ozlabs.org/project/uboot/list/?series=410150
> 
> I've applied both the dependency and this series and tested on AM62x,
> which I believe would cover patches 1,4,11 (32-bit SPL,
> 64-bit SPL + U-Boot proper, booted over USB DFU):

I appreciate the testing, thanks !

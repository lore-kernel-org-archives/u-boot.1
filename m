Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623EAD73EB0
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 02:16:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 155D5841CF;
	Fri, 30 Jan 2026 03:15:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Y7ay31dx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F47840DF; Fri, 30 Jan 2026 03:15:51 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D01C2841BD
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 03:15:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4f2KNy5BP3z9tlB;
 Fri, 30 Jan 2026 03:15:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769739346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SGgDXJrBoSNguzNzcK7zQ83vWIaYzKpLjzF/OYBv4fM=;
 b=Y7ay31dxuMQlBhLK9ipqYZMXLcDaXoUfBOd+aIo7orqIo2yKIjZI2Q6wqf79OuFi3xbarE
 PfE0IOnw/4kpq2Vwz2lH22YQTNOcps9o+45DqXgZOqmaNgNT6WoJNE4oarp5MkmImRW54S
 SgC72tQk/zgHrD9f3bTX8naRD1wazxEGqeAnO1arvW8A14UCFFpy1w2Epf+S7zLCd+npuh
 +lk7f7K+GAe4Q6/VXcAc1pmzkNdW+7tIMKsCDuzsmxykLk39q63ubN04A4P1BKv1z7lEfA
 76Fr4rLvhoO4EDp8AvXJuYfgChO15hYXhEFXeC3kHA+9YSz0EJ/gm2Kw89WgzQ==
Message-ID: <d771106a-46be-45de-ab8a-8d0f4f0ee383@mailbox.org>
Date: Fri, 30 Jan 2026 02:31:14 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 6/6] usb: eth: asix88179: Add read_rom_hwaddr() ops
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: Khoa Hoang <admin@khoahoang.com>, u-boot@lists.denx.de
References: <20260130002941.2336252-1-jonas@kwiboo.se>
 <20260130002941.2336252-7-jonas@kwiboo.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260130002941.2336252-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: cc870585ba5b732d3da
X-MBO-RS-META: fm5d6m6g5gyd77g64wk8puiawzpky51y
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

On 1/30/26 1:29 AM, Jonas Karlman wrote:
> The ASIX 88179 driver already has helpers for reading the MAC address.
> 
> Add support for the read_rom_hwaddr() ops using the existing
> asix_read_mac() helper function.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E32EF06F8
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 23:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D1FD8341A;
	Mon,  9 Feb 2026 00:19:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TR/YCzmf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F23CE839FD; Mon,  9 Feb 2026 00:19:15 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCCC6805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 00:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4f8P0Z44Jhz9t8q;
 Mon,  9 Feb 2026 00:19:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770592750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FRJqMSj+HxhC7cKQkKREvGoYXdrun0E2JYEGko68pz8=;
 b=TR/YCzmfZNbg7yiC389P4SXdH1fnSMgdWJ3RxOIvw8fhKD4CpqEafNfhgt1i1dnbZY11jc
 XIXxV1ybt5HonJ6Uj6QhyNBQY2QfUMQ8AaZnihV9kbk6/gQY8rOlHIKVm8/Wn+EXpibMWn
 DfzeGQlUtApxuj8mA1Bi/Xy9KdUUdX2zjVLxVj7CLlKVAb232CBWcEXTRVnF0+K6ng+Tyn
 lC2tQOYpqu0pixeqT5i6QKADCIq4bAsPaIwTb7DhcYwgst4H73c/+a3DRGR2eivkJM6TCc
 r97c/zctEjdubpYrTok6s/XquSo6U5oXow2YeghVPp5WRt+2wIjWqsVDJQMz2w==
Message-ID: <d462a246-86ce-42d2-befa-d1b93b74e99a@mailbox.org>
Date: Mon, 9 Feb 2026 00:19:08 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] image: fit: Apply overlays on a writable FDT copy
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Jamie Gibbons <Jamie.Gibbons@microchip.com>
References: <20260208223715.3721340-1-james.hilliard1@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260208223715.3721340-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: uz71ysaoa453hjbju77i3nabo3r9dr8m
X-MBO-RS-ID: 6df8476a9edbd5f07b7
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

On 2/8/26 11:37 PM, James Hilliard wrote:
> boot_get_fdt_fit() relocates the base FDT with boot_relocate_fdt()
> before applying overlays. That uses the bootm memory map and can
> overlap with the FIT buffer when the FIT is loaded into RAM, corrupting
> data needed to load the kernel and ramdisk.
> 
> Allocate a writable copy of the base FDT with memalign() and
> fdt_open_into(), grow it as needed for each overlay, and apply the
> overlays to this buffer. Also check fdt_pack() errors and free the
> temporary overlay copy after each application.
> 
> Fixes: 881f0b77dc8c ("image: apply FDTOs on FDT node")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
This code is starting to be super-convoluted. Can you please have a look 
at [1] and see if that can be somehow extended to cover this ? I think 
it should trim the complexity, but it likely needs a bit more work.

Thank you

[1] 
https://lore.kernel.org/u-boot/9e498de5-d114-485e-840e-1395e153edc3@mailbox.org/


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBD4E81A48
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 16:53:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D06958063E;
	Mon, 16 Feb 2026 17:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QCfsTYZn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wZHGhsot";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7EDB80FA1; Mon, 16 Feb 2026 17:53:06 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAE1F80325
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 17:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fF83N34m1z9tgB;
 Mon, 16 Feb 2026 17:53:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1771260784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FACJ1HP9oLig6zo02znpBf7AvI0aHi84QpI2xHIk/WI=;
 b=QCfsTYZnyAVgoSOEn4YpGbbd7oYdcgIs8yaP1f+SUZfBau52DNMDAsqBdhSNV/tP7+PhBE
 uCDf010HZqrtQS05X8r8YEc+yCxIE46u2pmDoEjqO1xPVy7bqTbcz4SYV4WN/vDQnATs6G
 DjdRUUMZ0aoPpzXeIyuf0n3m5ylqMjxoYdI+HnZ8hOU/JY+WmtQtSWKEf0QglXOwMC6WYJ
 5HD14KwmGC9lS/pVklHPXzxMHdUcQImYkrXDExXLGctBLt/Kz6Aa7pCNh0quymkf6jltGM
 ai0Q2sN2PVU+cCvEqp8R0qYnV0szlgk/spz0+G4hk70a1hN3hiP7JzCDiIp3ew==
Message-ID: <5efb7146-d0a6-4e2c-9c5b-5150ea97df27@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1771260782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FACJ1HP9oLig6zo02znpBf7AvI0aHi84QpI2xHIk/WI=;
 b=wZHGhsot4XKYRB+CwmZ4rkZUhLK1FzplDFIPYImZdH6rPDNns8R1AMr8xeZ4rWFzExPWNY
 TlWVPlLE83ufOsRYqqbFo1ffdXO43WBA+mPBw23Nv6SVRldU4jqUrz62kX5O3uojw49Xe1
 OwjvsS1gNRt3JjNYuuK7cGVfvjeGPOiFU2ps85kO+ybqlvsY6wH6i46JF1fb+6+4NMD16S
 wDKnq8wx9HzHaJ65xMuzLYsW06Rg283ypcFA9WLD+c1j9XIAzE0yJRej7YlMviY14X9Aik
 Q55+4bwXG+hq5XEIAxsQ0PodrbUm+CpLhbd/EnOPpJAjMw0TeiiZ89bxhhcfwQ==
Date: Mon, 16 Feb 2026 17:52:59 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v6 1/1] image: fit: Apply overlays using aligned writable
 FDT copies
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.denx.de
Cc: Jamie Gibbons <Jamie.Gibbons@microchip.com>, Tom Rini
 <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 David Lechner <dlechner@baylibre.com>
References: <20260212213410.822845-1-james.hilliard1@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260212213410.822845-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 49c9f94c804e30b783f
X-MBO-RS-META: jcuj13j11tu1cxy53odrwkmxha74yzsn
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

On 2/12/26 10:34 PM, James Hilliard wrote:
> libfdt expects FDT/DTO blobs to be 8-byte aligned. When loading the
> base FDT or overlays from a FIT, the mapped buffer may be unaligned,
> which can break fdt_open_into() on strict-alignment architectures.
> 
> boot_get_fdt_fit() relocates the base FDT with boot_relocate_fdt()
> before applying overlays. That uses the bootm memory map and can
> overlap with the FIT buffer when the FIT is loaded into RAM,
> corrupting data needed to load the kernel and ramdisk.
> 
> Allocate writable, 8-byte aligned copies of the base FDT and overlays
> with memalign() and fdt_open_into(). Grow the base buffer as needed,
> apply overlays to it and pack the final tree. Free each temporary
> overlay copy after application and check fdt_pack() errors.
> 
> Fixes: 8fbcc0e0e839 ("boot: Assure FDT is always 8-byte aligned")
> Fixes: 881f0b77dc8c ("image: apply FDTOs on FDT image node")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Cc: Jamie Gibbons <Jamie.Gibbons@microchip.com>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

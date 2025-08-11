Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B7FC87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 08:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EF2083323;
	Mon, 11 Aug 2025 10:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754901030;
	bh=8UToF/MmyJgnF1ZocoQ1bPUguDQbMGCwLCWcakSf0As=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S7gaH+Jq69ZQQugMVJ1bGE6DwQK2RfBSun9ue9HiOQ2qk+Tl0NvpZaQD52/yyM5zs
	 N9gADy1Yb9C0wOZOeNWMnZoax3zHCxjDcTA1GbQ25JIsBIHMPYbL79fBogLoAnUuUF
	 7UkKRsHX2QCDYXqGs8PPg9Nstnyi+cwV5OqEcrkAYeQ22fInqopYNoSRTEiuQJgR7B
	 PhwTWSRBCiNkKgmakBYV8NIJdoMA0i82F2RuZ8KqahIYP0xBl3XX68TDFj1EB9O0wu
	 BL6+IgpvTGQaPNynDJ/2B/yWXaQ6OnIiNQNRf0SYfVpW//sfpqici+7NBOoWl11xDb
	 eXINUeLS0SSDw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D3F78334A; Mon, 11 Aug 2025 10:30:28 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CFF883322
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 10:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="BPYbPLWJ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6A2311038C11E; 
 Mon, 11 Aug 2025 10:30:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754901025; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=8UToF/MmyJgnF1ZocoQ1bPUguDQbMGCwLCWcakSf0As=;
 b=BPYbPLWJ/1INBqxs505SXjrIxoMI88eU5TSHTNRThvfk7KJlM0LvdV1tuW2GxRRXQe6BKZ
 ID3XbqZrqugZSvQrWfbkyxOX7uFmmmp5AYCkoB+BfDvFzHzdTjtBwFZ37Xhd0qAAK9NV4e
 /wzLqITQQNPQvPmepH1YpewEnHBeg0q10LC4LGlypsWRuAPRf0qFQ65Q8icod/GxP7OQ9G
 GMT2J47hZE/1m4joRZrtmDsNuQVFxDHcyPsBtGsHcBsp4tRurJ6zizo+oZb3+v3rQrI8gr
 w6eamDAJsZ1QQEqV4m0KRTrtwDtVxMAXV3aSRnAlskgUJK8Iawjfv9RBeR6yrA==
Date: Mon, 11 Aug 2025 10:30:22 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <michael@walle.cc>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 1/3] Image size checks: Remove HAS_BOARD_SIZE_LIMIT
Message-ID: <aJmqHtGYYhFfGNXG@antares>
References: <20250807102436.452691-1-pro@denx.de>
 <20250807102436.452691-2-pro@denx.de>
 <eac8672f-e90b-42e9-9efd-d94fcc8c1f17@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eac8672f-e90b-42e9-9efd-d94fcc8c1f17@mailbox.org>
X-Last-TLS-Session-Version: TLSv1.3
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

On Thu, Aug 07, 2025 at 03:41:38PM +0200, Marek Vasut wrote:
> On 8/7/25 12:24 PM, Philip Oberfichtner wrote:
> > CONFIG_HAS_BOARD_SIZE_LIMIT is obsolete, if we interpret the value
> > "zero" as "unlimited".
> 
> This sentence makes no sense. Is the variable not obsolete if its value is
> non-zero ?
> 
> [...]
> 
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index c2aa88f59fb..36eed766d31 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -74,7 +74,7 @@ config EFI_SIGNATURE_SUPPORT
> >   config EFI_DEBUG_SUPPORT
> >   	bool "EFI Debug Support"
> > -	default y if !HAS_BOARD_SIZE_LIMIT
> > +	default y if BOARD_SIZE_LIMIT = 0
> This looks wrong, no board size limit does not imply EFI anything.
> 
> And use some common sense and reduce the CC list.

Wouldn't the CC list naturally be large for a patch changing 43
defconfigs?

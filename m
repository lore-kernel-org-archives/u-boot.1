Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC946CC6B27
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 08:39:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 846ED406C3;
	Wed, 14 Oct 2026 08:39:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id alvLW9SsxzUw; Wed, 14 Oct 2026 08:39:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C082C405E2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791967170;
	b=SOkO6xtEdM7tWo99cmGHILtt53I5pENhRaOFwYQWHKV5xxUcmnx9Ynbdb1rLlWmLTgz0
	 Rhq1ntoZWbohNux93w38n81eqHDzYhjCdiP1l2y6yKYzY27kkuzJ6oOZCGdtVlW4fqa+g
	 BpY7CPj+3069I9/5zThXFkF04X0ivHxPwjGWJVUETuLb4NRPjOG7bvkBcEBYWi7HLksjq
	 SRotEmyIwBnheCFp681BXENQMRcnjNS/El4lfTga8+YnWJXcnKsrcqHPGR+KuxxuhGHKf
	 s4ppw0DnjoCyNpiFcdouTr83t3fTTMGwKzW2yqW8RVa8Hh1SbxBCX2k6tvydrPEjJzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791967170;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=heEJPd8Jp19H6kt+tTaEicY378hMHC+iYVdQBGnNtqc=;
	b=MYBFtwTUTqm9/bPfX3BiylJnQ3UELQ6iPuimcE5ocuoRsaZQilV3hN8SWyuLp+zkbMbX
	 LSGKEJcySoDANf6Vivw/8mtjs3pYeiGiVymIaiEz0HcyPY5ueLLm9/ymY5hH0LjykMJRr
	 qiwKPvzkGPHoGLJ6pePAy2DfglFxidwqBj6FsjGodxSpI/4gsj6ygk5yH2WTmrsjM5kQL
	 hcf/e+8zdQaBrAwZ+iVcqoH9IzVO0u9CIQHQXLz8AwubOJnVsRpyDIMpiOojZyMJXk0CM
	 MGNjATOEayzsxH5K1A+qNWBgvqzOy4vUp1Fd71B9GgbeFo0mblKcPxow8SGFXVHjD6g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791967170;
	bh=heEJPd8Jp19H6kt+tTaEicY378hMHC+iYVdQBGnNtqc=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FjHKRjqLF5z97prfmndMKCSdvQozFOg9OyQ/JAs5efUUBrh4NLxBy6uLWcWgnc9Wr
	 lREUKs1dc5ETxUNuiZed9ZARJInCFYU1WrvBDJE3c/Sp3jRV9r3XxKlSf3/AKfu1Sv
	 XQDo/ogYsQ/DHXZAvqEX8VzDPPu2SSgs+nkGwf+T2dJaSOpLQzqxMNYhPD1k9pNGOw
	 4OMYmSmH+Q1W1bOkPhWomE/pzLQK0VuObJCZAOXDS7RRj4BvqwDvFS1ickJPL/Isfn
	 ga6ze6v3usvglVPIaNk1EQn8/m+WSlBQQLtS0uuE4Lp0OprJEpaFexTTbB0USAbsDa
	 CoxBD5ZnC9itg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C082C405E2;
	Wed, 14 Oct 2026 08:39:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E9E0275
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:39:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DB51C40080
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:39:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bzrrBUJ36cT7 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 08:39:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3371C40079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791967168;
 b=AwqwjO7CJgLrovYFtd5/ZoplyThK2CQTyNoWIsa84LYKkfT52mk/L2n7TvXvCII+/+cL
 1Ux42kEesOfs671OsvUPDdoQaYwCkU7cDcFDRlNifyFn27fz6I0YcQPJjaRpMLms8yn+P
 r+IQwj25uX6vxaVbLSCHRZraZjyMg1QmLU1ekyvAVcU6ZRRFBxKAvxl6wT2VMUawW/yhV
 61aSJhQFHtlkq8nNBoaVm3vRuoaNCFXs+EUf55kC2hrtiuLBNBp3/LwR/zzQdv1LGeVj4
 CIDoBleYZXbRI7YtvpgUZYz9WguwqV9zRNbXbGj9TPCIT9c7iOsLFmIgpfTX5XGySSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791967168;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=heEJPd8Jp19H6kt+tTaEicY378hMHC+iYVdQBGnNtqc=;
 b=HTk6VvMiXY/EJsrpSxXHWMiHBjBtNoHpo+B/qZJV5C6+lJgamKXjJkDx0Zxxc7XxZRIA
 wvx0W4YStVvvuDZAUt4M7o+6Jb5TqHyLXW8d/VR8p8mVEEMYy/s7egFwLuDgDXpBaHQPY
 QmYTK0mFBjOVm8OXwHHgjxwSV1oG7nqwezRajMSf0iw5JirU3fzEkkEi5tvODVQGgL4Eg
 WWyotOrqBOqLOd4dsg6h3DiPeGAKekOU81HxMw0h4VhkBtvDDPMVn329JGXOgmcimjer4
 73bQA4pubR2jd3Sa29Tbteb0rONLoABBmqq3WjTEv6EU0EhHYnvV/VoemwRpPlz/xYw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3371C40079
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:39:27 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xGuWC-000000005ch-39Sg;
 Wed, 14 Oct 2026 08:39:24 +0000
Date: Wed, 14 Oct 2026 09:39:22 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 05/11] doc: imagemap: describe the API and phase gating
Message-ID: <bd77217d61defb38362d8b6df3db4d863119488b.1791966831.git.daniel@makrotopia.org>
References: <cover.1791966831.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791966831.git.daniel@makrotopia.org>
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

The imagemap_create() entry omits the devp out parameter the function
actually takes, the boot-integration list names boot_get_kernel() and
imagemap_map_to() without saying which caller a reader can reach, and
bootmeth_openwrt is described as the primary consumer although it is not
in tree.

Correct the signature, name the callers, and add the section on phase
gating that the commit adding this file already claimed was here.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 doc/develop/imagemap.rst | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/doc/develop/imagemap.rst b/doc/develop/imagemap.rst
index f1fea1bba78..66c0db9e8a8 100644
--- a/doc/develop/imagemap.rst
+++ b/doc/develop/imagemap.rst
@@ -13,9 +13,9 @@ Architecture Overview
 The framework is built around the ``UCLASS_IMAGEMAP`` device class
 (``include/imagemap.h``), which provides:
 
-``imagemap_create(dev, name, part)``
+``imagemap_create(dev, name, part, devp)``
    Create an imagemap device over a partition of block device *dev*,
-   selected by *name* or by index *part*.
+   selected by *name* or by index *part*, and return it through *devp*.
 
 ``imagemap_map(dev, offset, size)``
    Return a pointer to a buffer holding the requested region.
@@ -76,6 +76,16 @@ they do for the rest of U-Boot; on NOR a partition is read linearly and
 end-to-end integrity is provided by the FIT hash or signature, so no
 MTD-specific read path is needed in imagemap.
 
+Build Phases
+------------
+
+``CONFIG_IMAGEMAP`` builds only in full U-Boot.  Nothing in the xpl
+phases sets ``images->imagemap``, so SPL and TPL would carry the code
+without ever reaching it, and their FIT loading is unaffected.  The
+``struct spl_load_info`` reader and ``spl_load_region()`` that imagemap
+builds on are shared with SPL rather than duplicated, which is why they
+live in ``include/spl.h``.
+
 Boot Integration
 ----------------
 
@@ -85,16 +95,20 @@ The ``imagemap`` framework integrates with the boot pipeline through
 1. The imagemap device pointer is stored in ``struct bootm_info``
    and propagated to the global ``images`` structure.
 
-2. ``boot_get_kernel()`` uses ``imagemap_map()`` to read the image
-   header and FIT metadata without loading the full image into RAM.
+2. While finding the OS, ``imagemap_map()`` reads the image header and
+   FIT metadata without loading the full image into RAM.  This happens
+   in ``boot_get_kernel()``, an internal helper of ``bootm_find_os()``.
 
 3. ``fit_image_load()`` uses the on-demand storage path via
    ``images->imagemap`` to stream individual sub-images directly to
-   their final load addresses.
+   their final load addresses.  Its internal
+   ``fit_image_load_storage()`` calls ``imagemap_map_to()`` for an
+   uncompressed sub-image that has a load address, and
+   ``imagemap_map()`` otherwise.
 
 4. Before jumping to the OS, ``imagemap_cleanup()`` releases all
    allocated resources.
 
-The ``bootmeth_openwrt`` boot method is the primary consumer of this
-framework, using it to boot OpenWrt-style FIT firmware images stored
-directly on raw storage.
+The ``bootmeth_openwrt`` boot method will be the first in-tree consumer
+of this framework, using it to boot OpenWrt-style FIT firmware images
+stored directly on raw storage.
-- 
2.56.0

Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1BD606A31C
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ge4KOgf+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C312940AD3;
	Sat, 31 Oct 2026 11:11:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CcBbHv5zqRUj; Sat, 31 Oct 2026 11:11:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E199840A97
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793445060;
	b=kotHYKpMUUnFXHcMkIhySYeQVU5I22wh6UAodGV6l+g+RbCw9jJpaFwS+EvuKc4Sv5U/
	 Jr4Ru5waDmXiSi9+Lo58B2bxoJRlbcc0buEMqKDRiW7R+joW89Ml4kJITxr17H7GLkSGr
	 TxPgpGGHmIZeLxTwz+KTuEjJs8GNMzDo8SXToYxjjsQbhZ4w0RiykHZ0hnfOsn7aaUDbZ
	 G3roTMzTJC4/jIoLI8Pr7viCf6YbADWQKfjZ6hbYwvXyrcukgBaJUVqmztngQ5YJc+FLH
	 uo5UuK4z+cYiMoCEQk73+6VGPlTvtp5M0MDdmhJX69NfLvgotHvjR2/+5b1LHiIhEjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793445060;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pXhj1xfw0cwLYKsr7wVZzausnvCkUwh9BEYjudecKGw=;
	b=jrW94rgvB1fnKr/5q2/u0YmD6M+sOc9xb96v3wCZpnsaE284EwOcL7jGlKLOZA4AdGRM
	 wRrWgObw50SQ+9oFj1tuuOHhCkLGIQagUIexZEA8kkdw3yaouXmkS1R4qlO+h5TbmVXY4
	 ouZwmMUb/7bi3WllN8CNsLAUCDFFC2xA17rQLIsUTRZbV4uFMUYRciZNT1G4I36lJjzD9
	 4qlVwy8uxiM3+oKV0j0/204J3fhjxrw6MYoS9vicdp40W4fw31hdB+nvwCR57iJty97Mz
	 JaGqOXWxrEnQZ2jb6yUMGBbR+WaHCjk2nl9Q2+vqamxQJxzvNol3dP1t5qOTp5JS3vw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=makrotopia.org;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793445060;
	bh=pXhj1xfw0cwLYKsr7wVZzausnvCkUwh9BEYjudecKGw=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ge4KOgf+XKcjnJDtKD3Tcpuu2qs14VHK8l7i04L5nuFfjH1Vpf/82Adg4dc1il3Cl
	 q/qoSkfGF5SD6oZBzSzfVTVXasbSUwHvRdiUtFUbnGhT2itv1ePMPip28torTHVZqZ
	 bb2AT5rQsMIEMj3a546nqEpvsJMx5fozYIOPLdtAUNCdbAufHLAG6RoUXERsrEACXx
	 o6ViuwJZpno/1OrWyDaTR3pnQRse7kDOTq5p0WVA3E2Eoe29pQWWg/HKkSxMbff5X8
	 GxwVLbkQj1siDViBBO/8i3x2edWKogSfdbWnncbYaBFCmD/a5ayGNG6flO5MA3eeWD
	 u8oU+GjsImz0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E199840A97;
	Sat, 31 Oct 2026 11:10:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D92A2C7
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:10:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 736FF40A9B
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:10:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id toW5nHbV0KAA for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 11:10:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BFEB540A95
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793445057;
 b=q4lgv49F+mapMpgcgoxguCN3wODSDux0m2zevEEH+vCW/z7joynSm1xnLP3wZo5Plq5v
 T7OOCb5vTJczpCFWefj/e83RcHnk2Jg1oawdkSIMFqloCLjYPV4fIl3jsloBIRE9axisx
 eb5J6eonoqJ2DW3aDeN93TY5FdEGbjkNJpw7O0N9szdSgn2q0l56OXmQily21ORiekH/Z
 7N12ZCp5GEk2I9nrhbQ5wAWVNoyZhULLkBXyucc6+GZbPdMHN3v0z+hr0/EwMWHXLrVkr
 4zqm4ipRjlEStwj+jUaxfcY92l/BkdzI2yANX23Tv3EEKtys4VhZ3gvQOOOUzmrbI4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793445057;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=pXhj1xfw0cwLYKsr7wVZzausnvCkUwh9BEYjudecKGw=;
 b=oGg4HrszDAdEdDNQsbX4L7dRH9aUHlWN47FLond8F8KXDjoijJfS1GObNL4mg0gCQj0E
 rfyNp7ga/Wj8NDaerqA0U82jctzuSG84nPYQy8HcuL8rDcuHzkoaCESNUD2jwXrqPrqht
 TaSxFZkIn0gT8d3bk9TSRAfglDseIvHrggyQWUWWwaZjSgrjTJi94zmWBG0jk0iGOj6dn
 qmYxfvrxzSosp0Ch7z3jhiNNiO5TQYBJ3vUkkbj0PSBEhmBauz/smNJ6m+Rgv7DxwJ/7Q
 q2yhdJJTvPxOUOOyO77FREvN6BI32P9ufRaEVRkSwupcfoSRqYos2IpxAsgX4voFLXg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BFEB540A95
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:10:57 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xN6w0-000000003OS-2KhD;
 Sat, 31 Oct 2026 11:10:54 +0000
Date: Sat, 31 Oct 2026 11:10:51 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v3 05/11] doc: imagemap: describe the API and phase gating
Message-ID: <99bab3748fe4216364dbe8eb75a0f95c04362af9.1793384548.git.daniel@makrotopia.org>
References: <cover.1793384548.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793384548.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The imagemap_create() entry omits the devp out parameter the function
actually takes, the boot-integration list names boot_get_kernel() and
imagemap_map_to() without saying which caller a reader can reach, and
bootmeth_openwrt is described as the primary consumer although it is not
in tree.

Correct the signature, name the callers, and add the section on phase
gating that the commit adding this file already claimed was here.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: No changes since v1.
v2: No changes since v1.

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

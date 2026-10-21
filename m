Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365CC606A338
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cMROHnvf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 133A78116F;
	Wed, 21 Oct 2026 14:09:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o1sUNhHyRbzZ; Wed, 21 Oct 2026 14:09:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3CFFB81181
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792591782;
	b=JAnIs+o0WKXg64qTnV71mJ2IZ9DItQkGa7Ggk6DI9rbm6y7o3PZHS8NN3w5TeKQg8XF1
	 ey3N6O31zKvkkJJpJG5tV19N/6e408KLY7G+16zyG52KTXkq65UcrnZXtGUpLEc/I89Ws
	 G4seKpllz7DeomLFFgAV/FwSW1opdjWkP+1tRUwKxU5D8OY9VBRZBF2QvzdBLXUAmZGEe
	 hdtW5TJp5RiwQxc/GVX5RRvcGjOOpBdumvAKbl8b0VAP4R6EE8iW+gjd53OsYOJNRipKz
	 84yWb/eA8oWTNDYEn6odT1vtqJ/MFQ/oxKmszA95ZuvBY6cXwcl8c85m7Ye20wnMqTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792591782;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MZD47zqpDv5BHYqDqc3yLFjaTuDSpLNI4fIxI7x26sQ=;
	b=WjWTLDkxZpphWjh+daREGNlK/5rgH+BoVRJxCZEoIXF0OftuhK8cFfBZWzJ52VQQvmdD
	 9liH84cfEKRdbatQqBF9AzLqKJHzzG4HuCt7kOSco8k1Zr53m7OWk90p1nzVDX8TN4WJv
	 qD9cxhTWE2ddbJZTiTyky26DHafCKS5SCvUX9ap5rJiWo5uFMgllseMmk5ETt90Op2cLe
	 ZLr7ULP3iLiZeOAAYqLBZAu8y9zjZpvgG/phTI9GOoWC/Fpf/vDfi7A/ajJ9WxPI3bB0y
	 ab+OuJJTaLjwkh0DKLvqtObOa45Arm7CPmNyNn3voU3w3dh+8ARI+JidEeph78ApFiA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=makrotopia.org;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792591782;
	bh=MZD47zqpDv5BHYqDqc3yLFjaTuDSpLNI4fIxI7x26sQ=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cMROHnvfu7eAXwjdDQayWpSQM+BnB5VuIBx6kp+ZixxEnRFbPCO2iWWf6XRExcBMn
	 FVwjt04W5hHjWwzxw3k17Qh2PidXqaF0/Aq8VfSyDUQs8RsziEx3jdpbVi14BawA3/
	 k5MXgGWSQrokvdSbi1GbhdeihAz4VOHwfmL9tHHMPlDZ9bYzBUcyCuKcx7vqLBa07O
	 vwdReswIZcAxnRj8K9HUALbwkKtpcMH/N4d5LjU9hU8tmmfsY4B0edGEE2nYJhqPZK
	 vDr6lZfZwVcof4Qi1rRr4YUjRdsOAQQFmxm+57X/Rw4pjb5quE3vpRTSgldD7hO1S4
	 refkUU9XTeImQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CFFB81181;
	Wed, 21 Oct 2026 14:09:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A5AC1E50
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 980558116F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RgBB5NJsWdOE for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 14:09:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C9629811A0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792591780;
 b=O35AonaaMUoSDkOkbiam2p33WFo1sS5/pfxPYwgTW9AB1o2d2mr/P48aK40jiM0Yyf6V
 dPo65AwosvofSjLcnt/5FZPwVDeOsibPyowJQTOcCoyDZgOy+/3okLiqN0/hKvapvfcmX
 oPZ7qviQ3BJvaAYeJa8SkNj8KoyASgKD8b8GGGAiq2I1lv34iXogz81IzA5KikCB03i4X
 V6muQzgiADnREKcQy8JW98YxwfDelkzpdLcj3L/PcM4oF9/EMENrQreiFXilSCaE4FNLD
 Jfdx3+zN34Lizfp3XZgqHbjROPUpFaAEiKThn+oYok5Q+8XhTmowA4p3p+D+KBlNGQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792591780;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=MZD47zqpDv5BHYqDqc3yLFjaTuDSpLNI4fIxI7x26sQ=;
 b=OJePcQ/MqbcB1jqAnYAdCUFhKpnSAMT+oZ2DRH8csqubjrhFexYA17TlXC7IYE8ALVFm
 rBy7Zbl5iQc6aU6GqsWs4ijKvDZPY/SslEaiIt878OGd72PBFMOCQ73NW1fbvzNqgB8E6
 tku9R23TNEmC+zEfSH//Zyn2ooPI9CyGdTw4YK1gF3X2bkoS/OpiW6bFnZmCcEbzmTnnz
 g+/S0fq8HaVa5Zm6hJXYD9zWCpjE4oEsu0Xqx903t7iyz6qd8oK0Ud5IT2fU7u1ASq0pi
 ESK4wBBiAPg5kP5YyOCeruIonN1NtrQw3hQwv7c5hON4ifntEa3RQGAhWMtmCjmE9GA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C9629811A0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:39 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xJWxS-0000000025g-1rOk;
 Wed, 21 Oct 2026 14:09:36 +0000
Date: Wed, 21 Oct 2026 15:09:33 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Anton Ivanov <anton@binarly.io>, Vincent Jardin <vjardin@free.fr>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v2 05/11] doc: imagemap: describe the API and phase gating
Message-ID: <880d6e65cba7bfca92e4cb00d2430203fa7127e3.1792591479.git.daniel@makrotopia.org>
References: <cover.1792591479.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792591479.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
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

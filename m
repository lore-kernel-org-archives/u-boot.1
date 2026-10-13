Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3AACC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 07:43:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C559060746;
	Tue, 13 Oct 2026 07:43:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kdVcpmduB9hG; Tue, 13 Oct 2026 07:43:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2CB4460756
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791877418;
	b=TNgStPMniliF5VznVuY+ykAmbyN44vizudbNxbiwkZ5C3j5OnUmhXjxD8HL3tDhbzBGS
	 W+/BVita3/d4ihtSppMVtKwOiDEL0Be8E2of4gftqAzdp0Pu9I4e/P23GSaf1pdXTMkgD
	 xIsYSE6kfy+ZDP3aDzYSC9GthvsTf6xa6gVsXMV4dQbRr2QOQzgo8WBhT1dIevAQ8Lk5E
	 BZP5zGZz5GH5vQRj8z5wJIH2Pck3cCrrjnH2tXpUSMs6VuHKUZSfS0RNCEZTqmLjcGi36
	 RHnY5PG+iRNDiEnnSsQ7qb2pWKiiJCjMi9cCjstfDPsrXJ+6MuJsu7lApqlhiz14f7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791877418;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NmwBbilyujQSih2UT3RGnmLJHEHGK4STJCFkwn7+6Os=;
	b=Gz3Ds7+KZ6V0wzsqN0WR5fOTtgQUZ4xM7JZxcbq6BJglzwwzqzCgYd6z+1NjzOoAKVHK
	 mtxDcPnnw0KxzKphBA0EtQf8Ol51XaLEhNPC+kEIo1ObDT1ZwrZjkN3TxGVZV0DyIr7fx
	 hymfkNlLdRZEChGaSD10uwK4Q93iEpC8HAvJIAuNOvrFFUVIYWsy770+QdnYDtTx8XRmY
	 EZLtCLU0YP254ZBgqYCblQF2uWtdDud+SnXiyhLXc9QFyFQmVCNyZPEk3e1Gl/sTiUMhB
	 4V6AjIU8kljVtC5I3c58LFrb2RQ+3/iqW7niLxnWDYiOlHQRVZBwyt4FjQtYrJYZN8g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791877418;
	bh=NmwBbilyujQSih2UT3RGnmLJHEHGK4STJCFkwn7+6Os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LzfvwM7Y5d3nXHGJSfbBvIHviASkVO9yNAR4odA9pAAJCwAH4aCGLHI/Plj3pluLo
	 lCBJW+2vHCgTdSCOZ5jvXLmPzLQ6HDcPoeddekU5OgLa1HsYwP+sbtB2SKm02Gq3Nr
	 oQinyi5P1NRxH8I0dutwceyePNi9ii11kJerjOmx2Jlv1rVYrqVWzC80eVMiOOeZ+b
	 K9mkIGaIGxArrOJNcb1YK5MElJSZe7tUAS7IG52KDGnK4WCYW9Tu+uB++IVvwE5VC3
	 floX67Xh2HTti/XwUbXztWwbn+Jjq+XBR3Wv/UBFZuToXEvE+BqaEZN1BnQxbm2gPb
	 H0uEvl8J3MA6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CB4460756;
	Tue, 13 Oct 2026 07:43:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F75B105
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:43:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 35E0A40068
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:43:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n0iO9uXF0BPh for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 07:43:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0A33B4005F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791877416;
 b=RsgogCmUmX1wHRejiBGjc7bltpEeSauEzK5No1iLK2OJMQebu+l5L9fZAhWamh8f9Yrs
 BL97YnSPk3yLYFaupzwCdDPhpx8s6zwa+RKYY8SZtZppGch0V/YaZ+NcKnuni0npkxqbz
 oi01S/uW1xW6tBFneTuPJbjyo1m39PZzjjxfw9rArEmhuLk6lHHm9kEJLYVIPxeePyTtO
 EYyZG4vc62M/xRM9oca4/ci4NsUqL27nuTYq6jaOapW/C5V/IFfIrqAVNUw5SJ2IOG9qZ
 R0MeswWvze6YtIYNoVzzAMWaq8UfHqh/t9L0uNtMCkFoUp2ztCnRLETr0VbxeY9PCKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791877416;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=NmwBbilyujQSih2UT3RGnmLJHEHGK4STJCFkwn7+6Os=;
 b=VRlLpTQCFKD2gzipLGd9EJKZ5hGs4TcCXQPzRAnoL8fLIn5iJL9W6WSOumzSWPjoYopH
 vxIny7cLAQxd1W4+iUvz+3EWCkzHWsWLNxjHT/H/Yd6HSoq4lRIU/6SoFNJgu+7lb4lIl
 qxkioOVmN57aQYxWuasejhvyFfz5UpQdpWESf9Et4UO0NFyvdvjnEysUTOU9rxF1rlA4y
 FbTNwMR1AIIrT+wgNk9b0Cb7fSohSjQ5BiibCviS+FB5sGYPR4SHFIX1tQoapIChtEz5l
 C9xwR7ffIchZLgvJJeE/Uj/wU8H/m7u1c9hl+rb2bYRIv2DYEJW0MCs4GVspJWO/EXA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Iamjo3NU; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Iamjo3NU
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0A33B4005F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:43:35 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a02753c04fso14026205e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 00:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791877413; x=1792482213;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NmwBbilyujQSih2UT3RGnmLJHEHGK4STJCFkwn7+6Os=;
 b=Iamjo3NURScsz4cqn3LteQpxK4ZLnWm3iiiJstl1y/zjer90S3l6hFejR3KGFtdGcq
 oE8b3tFyi0hFYNkknRElP18JEttY2ypsWUNBOse1wGcPoDGd+/phYvDGLedQZ7OSFQ4m
 3zBA5RUQT6DdFqHQr811+yQZnjw7lkiEvQ6eawl4Y6VkdWBI97fLCwa/dchUIeJVormH
 s6mxqTIm83drxW13RkdJtu9v4XAm1QP8hjOT0oX2AbtKEx0zHisncHDi86c0n18B+I57
 gaY5Y7d19U7fZ339j2T1PSDIWLIVuneHVGXfVXqLDba1FUBEXxF/m7rRn023cR+SCmyo
 YMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791877413; x=1792482213;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NmwBbilyujQSih2UT3RGnmLJHEHGK4STJCFkwn7+6Os=;
 b=zLpfoKQHPQhzdhCLVx7Rw3Bin81DaNi3+tjt0ZHoqPJESwrhuZdbOpE8y+y1rrKPdk
 SSp862gYXdENqg6WPVdKuMqwBzDKX7owcnJBNn3dPh5QUhxIeVmTEYXOv6QpN+n5wVcm
 BFN2Kwfg9aWCx4bJcW2ynLkUHJiOfvVKCHPHI1K0Q4wEB7zUKkAsJqwdZ9LKXPXoG1MB
 qHQRo+ujDyLQxGkZFTodI+fBpN2FAVRyYHSSaMqpq6/okvcc8EQaD2wMTOvZi8tToYa7
 RN/NwZ4tOHKkmwWNA8yV/NnQFXLMhervB2IeJ+AjZ/L08O6hGI3eBs/XRitLhx9xFBYy
 /ieA==
X-Gm-Message-State: AFq9FYLl2EuUqLn+q7gMNLq5Jvx2P9hIrXFB6ucLeC1Q9PSbRjT+/cGv
 mz5p2fmofClOTxSZUayVkVlGkxUjEDmrWH9RF378UUGARUarS0oaKYvHIExtcJWh
X-Gm-Gg: AYBFou2Tq8mmZCodbcs289IhBVJ44hWcTcDs5BzMj2V9VKtoVQE/yVgPptmbnZe7iwr
 cqQosS1XMwx6MXUHMqkYqxsKruQ9BNOPek0Ez9OaRNH97vcNKngRNxrXK6yD3CsQ7H11VdQc3Ur
 tgDwdOzGlHzKLTKEhjoCggD7E0/dd8/+6KO7qGt/8TcWaI8OZTw2dyGj2dweEga2ymAScZlceXk
 6ThfIvUbzNfozNlAelVZlXzISOv3UaPohVEqffPzOe/LJpWqNphGWlRRpR/SSEaEyqvDzoCBBC1
 5jXasIxBenfIZovYIlnoT4AbOcDT+48r/ddlq2w4oGxrCgo2mHxkm0qkbu/P07ajqaH79JqP6D+
 5k+qLszzzQnpKAg3qFrhri2ip4vj7eKk2A4HvYgOQ5Dhv6gyNkuC8jYTln8duhMxeLCDIBklBop
 L9yX899ywGElUDPQ+VTEtarAEqAbtvJOnI3akPElHk/pC62EXgiaSy25k7mZii2iuJqBiAMp6p+
 CBreAINt93gfEoYGSddwTvSaRx3EnUrzZg2XSKINSNNFKb19lujrWFP/oQ9Ye2+hEmIHbuSJ6dc
 kaYaJSweCSKBdxIPTNdnLfm7zIxI29OGocYMBF7tEdvMONKl7XJJ0LntPV6un6L/3//ArI3fAbo
 j8dyV7WdSJ7Fqnll+bDKHECgTZxnFoCJ5sAPFGclF
X-Received: by 2002:a05:600c:4f86:b0:4a1:acaa:c355 with SMTP id
 5b1f17b1804b1-4a1acaac488mr22668835e9.10.1791877413100; 
 Tue, 13 Oct 2026 00:43:33 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-c000-0ddf-303e-2074-f3ca-cf21.ipv6.o2.cz.
 [2a00:1028:c000:ddf:303e:2074:f3ca:cf21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19f249692sm274369605e9.3.2026.10.13.00.43.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Oct 2026 00:43:31 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 2/2] Makefile: Set LTO_ENABLE before including config.mk
Date: Tue, 13 Oct 2026 09:43:22 +0200
Message-ID: <6b1531855e6557a015d83d97ebd0e80417f2e15d.1791877299.git.pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791877299.git.pepe.schlehofer@gmail.com>
References: <cover.1791877299.git.pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Commit a55014d09b29 ("Makefile: Allow LTO to be disabled for a build")
made the condition in arch/arm/config.mk that leaves out
-ffunction-sections -fdata-sections with LTO test LTO_ENABLE. The top
Makefile, however, sets LTO_ENABLE only after it has included config.mk,
which reads arch/$(ARCH)/config.mk, so for U-Boot proper the condition
has seen an empty LTO_ENABLE since then. The xPL builds are not
affected, as scripts/Makefile.xpl adds these flags for them anyway.

Set LTO_ENABLE before config.mk is included.

Fixes: a55014d09b29 ("Makefile: Allow LTO to be disabled for a build")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Marek Behún <kabel@kernel.org>
---
As requested in
https://lore.kernel.org/u-boot/20261012190720.GF3722450@bill-the-cat/

With Debian's GCC 14.2, this changes u-boot-nodtb.bin of the 27 ARM LTO
defconfigs that build on main by -7720 to +2144 bytes; the 22 of them
that use the private libgcc all shrink. Their SPLs do not change, and
neither does sandbox, whose config.mk does not test LTO_ENABLE.

The other three ARM LTO defconfigs, imx6dl_mamoj, phycore-rk3288 and
turris_omnia, do not build on main with Debian's GCC 14.2, with or
without this patch. "Makefile: Pass -static to the LTO link", sent
separately, makes them build; with it, this patch changes their
u-boot-nodtb.bin by -4512, -4112 and -3560 bytes, and turris_omnia
u-boot-with-spl.kwb goes from 976640 to 973056 bytes, against a limit
of 983040 bytes.
---
 Makefile | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 6303a0cca6a..547053d7bab 100644
--- a/Makefile
+++ b/Makefile
@@ -819,6 +819,13 @@ u-boot.cfg spl/u-boot.cfg tpl/u-boot.cfg vpl/u-boot.cfg:
 -include include/autoconf.mk
 -include include/autoconf.mk.dep
 
+export LTO_ENABLE
+
+# This is y if LTO is enabled for this build. See NO_LTO=1 to disable LTO
+ifeq ($(NO_LTO),)
+LTO_ENABLE=$(if $(CONFIG_LTO),y)
+endif
+
 # We want to include arch/$(ARCH)/config.mk only when include/config/auto.conf
 # is up-to-date. When we switch to a different board configuration, old CONFIG
 # macros are still remaining in include/config/auto.conf. Without the following
@@ -858,13 +865,6 @@ export CFLAGS_EFI	# Compiler flags to add when building EFI app
 export CFLAGS_NON_EFI	# Compiler flags to remove when building EFI app
 export EFI_TARGET	# binutils target if EFI is natively supported
 
-export LTO_ENABLE
-
-# This is y if LTO is enabled for this build. See NO_LTO=1 to disable LTO
-ifeq ($(NO_LTO),)
-LTO_ENABLE=$(if $(CONFIG_LTO),y)
-endif
-
 # If board code explicitly specified LDSCRIPT or CONFIG_SYS_LDSCRIPT, use
 # that (or fail if absent).  Otherwise, search for a linker script in a
 # standard location.
-- 
2.54.0 (Apple Git-157)


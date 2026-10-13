Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114E6CC6B12
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 22:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75372608D5;
	Tue, 13 Oct 2026 22:01:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sh2401MdDWL4; Tue, 13 Oct 2026 22:01:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 92E54608BF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791928876;
	b=ibCwPPj1iguqlQ+cagnuOuHaMq0pYEt4/exEEUD4pwXoURmc7jllQI84w4f8Ivn7hqS/
	 0HiAU6Tm0ONUnqH8iorPn1THlxyeEUksQqWylTBYcPfRtZ/rR75+CljuTo9xiEowZSSDV
	 Ncu7HkjnxqfI4b4p2ULBCETtolUog9iHicTB2rs40jsUMHD0AiMysXZlZES+XvVpTrtif
	 xaZgmcfp8RTYV3fJcvu0Zb67CSteQKiZ0ZGAlyTkEpFAmiN5FxgbVor76gTiShXelH42c
	 jjY0XwtBlgG5qybm88HBX08GhNtk5ZOm0/yRFvgUS/+dK/Bn45EwUSzCmKJmBrd1V9g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791928876;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wgB5twfa4lCYNlMVwlHBPXwpEbEkYQpRBte07SIOpWI=;
	b=jmXZRRujzr4EfLH+DwVcDASYCzOjCBJexxhDsfEhJnQNiNM3lZTo0EwjtN4jfYp+EQiN
	 ecsieILhgTlXth+XdcS3vppIy8KwE9EAOFI7xew2sWkkJSmQJNzsQyX1CWqjhRCuIGllX
	 j8sIOQ9R1/P36B5pSQe3x5I1S7fcPhQ/IqccBMzuFmjfHJfe1vUH39nlcIqhUSpGeQEeK
	 +0FFDNH31evwMpRarfbd0aXl08+5kF9Rc/fNS0ngme7Gp5NmH9UFRmsbZ7M6Xi0NCKr26
	 pfuPkfEYPv5aybTYYrsnFN9WLuQhn0ddSpvKwrbNITCaooWOUJ1XW+epdHEdA1ck2Ew==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791928876;
	bh=wgB5twfa4lCYNlMVwlHBPXwpEbEkYQpRBte07SIOpWI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LBnFVllOxjrAma3D87yOmdenassyGx2TlsR51VRj6Ojk32iLJjsHlh/2YSOIMQLRy
	 YA6dCU8Rx7GDMtNeQXj/hUl5hJoEaQsXZ+vIQkwH4NTHtcNVkST49/K3sff5l+7FWh
	 biTq2ZfhGK0BUU+9DoxlXhZ+rhOwjkPy0pxns71+Ez8+3f7Tr7wUMNssmA3oFaY/xM
	 pqj0a3Rl3WSqM2q98Qgdjy9TLk1RLHZvaXhhek0IqzRHu7mKsqoNiSIv3bMDN3fW1r
	 sjSYa3IHUycYdsIB9RzPQ7KRJDUio1i52RlihZ2Mp/3x9kp8GA6KaKWOMv4w8SZy+M
	 L8CCRv3t7cYXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92E54608BF;
	Tue, 13 Oct 2026 22:01:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DE5571DE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 22:01:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF120401A0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 22:01:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gAB5iROMO2s3 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 22:01:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 383C04008F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791928873;
 b=tdrcFUkP2D77LzfHQoZ3iLRD+6D3tjTrNqDXyv0S+NG18bb71QFl3lX0dViUQakyp8LN
 2HOfmhpLZ+vK1DORjT7mOtW5VeRSofWmyVcimpXH6X7q7CFstBnqd2OUKb7zXkkAUQ1z0
 uZ8bM8pyQygD9XYBEMTWoTF443M+r8WmUL18lv3ERu/t3X2q2lWx4A7Z8R3AHyv0Q/sSd
 c11s1dzHJONBVg6VDjMj1KNnhB4y+AlnLKUpitwxDOI/QgqHltXyVuzsYvDg76GPbTuuu
 C9NV8OBeYEwSPY54m703r1p8zFezPHMzrANvyn+Iw4wjqI9d0V2Ajdfp61ZKDWKrWIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791928873;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=wgB5twfa4lCYNlMVwlHBPXwpEbEkYQpRBte07SIOpWI=;
 b=pUlvI49OH6z9w70dZy/911/19qhIJkpTRlSPNv6PbDcsbFLDOMxNuchLV6LWHyAJGN2+
 4tmDQYmxlzFDFZT8sJdz09D7gVXcuXWPPJ9XfwGGVZXpUmeScAjy5E39UKaxWI73N+Hk7
 T/Fq1alHPuZhSxmF83wLa6deMSk9n7DJ/3xpii6k9V74cagsIthuqL7xyoiAyMsr5XI9n
 3f128ONg6Gr6oQ84RwaE3rXRn9p/s0sBmJ1YrQU0R2UfJhWFcdqp/H59tQOLOPodgvUYG
 f2gkRNyD8upDe+0iw/0x5pLPMWmqCzaSTkP6K3Kn4mXwW0EasWEp4zDkW46jUI9eh8g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=N4XZz7ox; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=N4XZz7ox
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 383C04008F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 22:01:12 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7f48c750afcso232432a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791928871; x=1792533671;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wgB5twfa4lCYNlMVwlHBPXwpEbEkYQpRBte07SIOpWI=;
 b=N4XZz7ox4HT5tovmlco5P8B+VxkeLgOQaUBdEUTYwk+vQnhfjT7lVQSHfuBsc9jt+s
 pxGcCA2/vC9otHXTmxQeJpE6b+CqQklcSZre+w7yg66swbkSIbBP2MlW8+B6AjYs8cx1
 V+OzTAK5NcVbTp2TKP+IjArTR/sLFCCTfy3hVi+t+wt/kGzlbZzrNwx70h6ynJ3+KSNO
 VYCnR+wBWuTFlrW4hUgG4iQENrqI0mdn3tGSI5Yr9SKXznvrMus9WrxT6ubAT8xMZVi5
 JkS5QZoqilbEL0n9brfj5zysCHKOI8jHSqM/x2EU8/09JQyH9DIMgnLQ2zh07VZLDd9j
 1XKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791928871; x=1792533671;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wgB5twfa4lCYNlMVwlHBPXwpEbEkYQpRBte07SIOpWI=;
 b=S/ke3ovieVkBqv86xoOmQUkf7fHJVF7QVWshefFH+jK5HyZo5++KK4G6gkup9g2Phy
 3PMAUzkjRP6h/GGzrH7PJ3DqXC2tc4jlDC/EtPp0yGbZwJlq194+9wkblHXYyIw2Lr7g
 5sWHUVrocKoqHsp6mTC4ZVe+iLUGyVqHadHHC7mphLegKJ3Ktb+GgrtfsV7djaYLC9Pm
 XnmhyGjyhYuh1aOyELlmmgbAz/fbvWYm+/4Opuum7oDpMFbOxqgFIQ2V01PvgB/yKGAQ
 i7QvF8sZdZBqfyM/Fx2yJQzYTXTPZm+rwYgcF8+Pgsf5Ve8Qo/tSlOKAVjzI1jOCyxWZ
 MaNA==
X-Gm-Message-State: AFq9FYJee8q74vligHLdWcwS9S6CZ5H+lUXw726tP0YppdgBlxClZAXy
 6ztTu10Im/SA8AQ1a1jVBXh+bqvMdLarQXiZx7jBmQdmcPt5fPFZqrl6PfYSnOEay3Q=
X-Gm-Gg: AYBFou2YDPsUOG1GRY7N23RJLom0jgGm4t5p/gV4UuE9qw9o/RiBs9P8ZaFNnKc3nlL
 5E+Ix0pMUwsTT7skN7bTPddAPqBAj9LsKGxjZ60x8Ndbyy3pSJ1LzIR2Voj0093S5aBDVMBdDNR
 +hQ0p3dgLvJyWpQsz58LgjbiYyvelBQF+Tk8q+lkPuRbNTBmvs1EO9JcqpY8ppLz6/joD1rpL5H
 NIjS5udAYLta9+suE+E6KzTufOlVzHgvUwsqLHJ9gG7tyK0vwtSGLxB4CvE5vlBUkpzWpq8jU3X
 /5ecvLa4Jk/6pToZTZ37WkXn+o2gAUDpZ2ZFLxps2zkyAV9zmVH3DftuPQ9c2L0fp4C7ZWLAs0D
 3V0Uv3Znsl8kPaxE9nJ7qYKINa+KnT1HHuE16AfOFdNpBkfEzNiPm6Z0EW+igsn/tm6NhKBZ1b+
 7w0/lrNLYpvoI6FFPZxNGS655bg8unzOw2dE6i2ztvgA0WEFBHVQFFdODy73eUHr3VLKRLdylGR
 JY=
X-Received: by 2002:a05:6830:640d:b0:804:ca33:4aff with SMTP id
 46e09a7af769-83094e783f6mr13353964a34.9.1791928871517; 
 Tue, 13 Oct 2026 15:01:11 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fc57:1703:6147:d976])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-83039a3dfa1sm13553348a34.18.2026.10.13.15.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:01:10 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 13 Oct 2026 17:00:39 -0500
Subject: [PATCH 1/2] boot: image-fdt: skip reserved memory above ram_top
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-image-fdt-above-ram-top-v1-1-f7db4b36d464@baylibre.com>
References: <20261013-image-fdt-above-ram-top-v1-0-f7db4b36d464@baylibre.com>
In-Reply-To: <20261013-image-fdt-above-ram-top-v1-0-f7db4b36d464@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Randolph Sapp <rs@ti.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2151; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=cqN7vGySnPXeHSYunerp52C9tMRJR5pug8zRVysvX0w=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqzqoTPlsAhvwok3K+iA0z2WGzuUUNvFRfy7y4h
 xW+UGM8y02JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCas6qExYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AFP0H/inpV+gABmjZOryvuVdfBIimXrA6OqHWjledw9Y
 XzbSBGQvszhfF4eYeygnX06AGie7nsimerFaxmBLmYsR4W0Qm1NtkW3AsJ6kM1Udn1magKNEA+I
 lq94FA3phwHArmb0SPZyI5/TJdQN+jRhCHaEIHoemLXk3+J+EOPzDaGP7J7A7hM492/+gq97z6Q
 IuUfdkdPh+pu6oFnjG4lNGfJZUHjxcgp/YYfrXLKINOdXkNAMCfBpg1jJf8i4lMrQHgzWOGlyjG
 EcLs/Dx6XomQOMjDypDYLBERHrPonbbIZ+9kCR8BuassVnA0dmH6f8aHdr+KWlhx8auezDrgbZ1
 Zp3A=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Only reserve or free the part of an FDT memory reservation that lies
below ram_top when LMB_LIMIT_DMA_BELOW_RAM_TOP is enabled.

With that option, LMB reserves all memory above ram_top itself, so that
nothing is allocated there. A reserved-memory node above ram_top then
overlaps that reservation, and reserving it fails with -EEXIST, which
prints an irrelevant error on every boot. A reservation that crosses
ram_top fails the same way, which also leaves its part below ram_top
unreserved.

These regions cannot be allocated anyway, like the regions outside the
LMB memory map that commit 94a09715bf4c ("boot: image-fdt: Restore
suppression of irrelevant ERROR message") handled.

Fixes: 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 boot/image-fdt.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 956a3d97c42..7098ab068db 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -19,7 +19,9 @@
 #include <log.h>
 #include <malloc.h>
 #include <asm/global_data.h>
+#include <linux/kernel.h>
 #include <linux/libfdt.h>
+#include <linux/sizes.h>
 #include <mapmem.h>
 #include <asm/io.h>
 #include <dm/ofnode.h>
@@ -84,6 +86,25 @@ static void boot_fdt_handle_region(u64 addr, u64 size, u32 flags, bool free)
 	long ret;
 	phys_addr_t rsv_addr;
 
+	/*
+	 * LMB already reserves all memory above ram_top so that nothing is
+	 * allocated there. Only handle the part of the region below it.
+	 */
+	if (IS_ENABLED(CONFIG_LMB_LIMIT_DMA_BELOW_RAM_TOP)) {
+		/* As in lmb_add_memory(), a ram_top of 0 means 4 GiB. */
+		u64 ram_top = gd->ram_top ?: SZ_4G;
+
+		if (addr >= ram_top) {
+			debug("   skip %s fdt memory region above ram_top: addr=%llx size=%llx flags=%x\n",
+			      free ? "freeing" : "reserving",
+			      (unsigned long long)addr,
+			      (unsigned long long)size, flags);
+			return;
+		}
+
+		size = min(size, ram_top - addr);
+	}
+
 	rsv_addr = (phys_addr_t)addr;
 	if (free)
 		ret = lmb_free(rsv_addr, size, flags);

-- 
2.53.0


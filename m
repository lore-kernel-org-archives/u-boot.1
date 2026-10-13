Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8787CC6B12
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 22:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4817F608C1;
	Tue, 13 Oct 2026 22:01:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m_cE8C6LUwu7; Tue, 13 Oct 2026 22:01:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 692BD608BF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791928880;
	b=gsTKgL2RIbY06AMoFmPOQnAMQIE3SG9fHoy2CAFefjudtKn1OImN5Gc1IHq40QWqcHnz
	 mBCq6NNt1/w7f0K9kin/d8Fq3xCP05BRNWechaJVvQxxPmC4HyXwNs5V7z3VT7TcwLFMd
	 Ft+f+PnZYWzLzdUqVLH5VQFdAgq1+nM+RyGre6aUS45qX6WaRtyVLd6z6D0wOI2G562BW
	 +AnXHcqN4uyrTnIIcHJWUwZ1DTYl+zUnHpqja9+MY4M9j04sin/+JLJlZ7vmMZrE1WVl8
	 PirIpR99WfAZGFkJ/Bz6dqyqFh/1N/LCywcukqZ6hnGK4/U2FmD7J92wfHXoXV31OQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791928880;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=45akAj5jWJvW20jzlgL/1+CrNlmSl72zEXp1V+V9/FQ=;
	b=q5C4xGM2c4DiX791TyuKrWs6QAlHMWVL3TyIy0LmT8NRH8scD6ETaX0jHr9Mg5tDvPbA
	 L/HbOOMAMP/YYS/2qM6qxg7ZGoQr5g2Smdzg2TI12vGIdnkOEkQ+gvwdTTWY7U3GQzPWm
	 8NLP9Ms3JRnd1sIdARTic2aVVLj+bEriuSLr0hQ3s8DRKdCLRR3KlYYKW3FauJEU0Bo+r
	 mq9WmMDH9DGg77jLfmGMX+YkI77G3RYTcapATGBKxuFwbt8nt3CGLtZWmHC5ppS75wN6I
	 B6mAQPq5PLB6aI/XJ6CuVDpx0WS3vLslD8aJVM/h1M0/7oylyefhx68Bwy+zT5gHifw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791928880;
	bh=45akAj5jWJvW20jzlgL/1+CrNlmSl72zEXp1V+V9/FQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iYvyzQgERTCjf249dYnbKWO5VynMtUlMpTJN1+490n5LZ/3wZYUt9nd6Wy6YxcI5Q
	 FuxpHJKznCgPNafAkEFNF44itU33/O6XuQaHIEu5QccWNlXIv+t5FvvXAZlUJy30MH
	 /uBOSnQHVSOwSYblWEfg92+gYdLfKaESuHHD2DyrBcPvlCabrle7gdZYqulWekYohH
	 RPaF477Aglw289z/owyFHodOz7U5H8bce3+qPedeRVT0qOOGC77Y4Gc/fKUUe/R0dn
	 OwFIqXa7+r0s5nHxrV63e9FaWiie+5i0WSOXc6hHcBzCRMJJZ8C3irgbfo9rG2Ft4I
	 gr4kXijgdRClw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 692BD608BF;
	Tue, 13 Oct 2026 22:01:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AC3072AE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 22:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9E22C401A0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 22:01:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y5fJe81v5UaP for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 22:01:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CB84D4008F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791928878;
 b=RZd6Idcj04/5vlWHe/ACmCtPS28wFPrS9sD4bKChRZN42IXuw0p6K03X1x4xUTAZnGVa
 0sP4HEjlldvgiZOWRVQGmXDsk+JP4NiHOV55YsRLZQCsZbOIKrGHrW3y/mChEq37jz6IJ
 sIpeCYZ0LhZwtHLIV+plb4ra0egzr67drBzhZtq6FhWIZEtxAIWwQ4f+iucDgub7h/WG9
 9nzh8+kO6JebG4DOac6WAXbdZxqQalg9mjCaddL+Wnr4bqbkx9+uMOa0hXDjAQO8GWjv5
 yyrdgYsfJgQV+yyXIssGa6VezxPK/Q2oHglEVzzocJYQij4NpMNiVMIuIlkYb3+VxVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791928878;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=45akAj5jWJvW20jzlgL/1+CrNlmSl72zEXp1V+V9/FQ=;
 b=jk7BqSHKiB6a6cL/EoaUKFcx3KIlr5BPBIzO2Ii+8FwOb/QaERnQE1wYfdA/aro6Jv0F
 WPOSYpiR4wknHsLkr7TOAZewF3+fVKZiXk97LCkmSVO0PHnMwPxmkMgpriOId8HCpec3h
 RlQH23GiweO2Lnm57sDpwv5qE9cEml/ORgh+Ou6pyasgwjpjZcciNx911BwdHu4fzqFHk
 vlA5rJ5VH57egXHcA1hPt1DkEMhMHLj5H/7s64+OT12n5fvSlDvI7OwSfFebq5X/X0mYQ
 CVARveAaAoAg/adFMmLZuT92DlJCEHYUdzsWl3DNjWmcdNVDlZQYNB2CJ6zkkWa0epw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=BsIX+RO1; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=BsIX+RO1
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CB84D4008F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 22:01:17 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6f74f6b46abso1230399eaf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791928876; x=1792533676;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=45akAj5jWJvW20jzlgL/1+CrNlmSl72zEXp1V+V9/FQ=;
 b=BsIX+RO1HoBjv4w+A6eANgzLuks+Gt63AXJS9SvNjcuFgyjZxEyZA7iToMbox4Iktw
 BP0W9nRktVc4b1wXOA6eDQ2fS7n+RS0LYorl6caz/h9MgMeKPUOE4bfozhVaYTSaUnBZ
 t2W4Cud3OfHOv1meiIo6ooZFCjrA9a2ZeY9GK+E+oPRuT029PyT+43uUumFYXGxPli7Q
 POU2xVVZ4zp9WmtxSNpwhSxUghK7zdnwnfu7j/7zZThZcFKu2mmjFho3w92yD0voEetr
 vzzYgzjDOUs2LkNQfJkGNG00y7XhBX1Va9c8PBNs4ks0b9Neuwe1lk+VRBZ2/J8Eljab
 ZErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791928876; x=1792533676;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=45akAj5jWJvW20jzlgL/1+CrNlmSl72zEXp1V+V9/FQ=;
 b=xfWa08A0ZwD6wmHEpq0iVMzC0WGdt4q0mS78u+G5w1XGxm/NOEJI3ZolBqrJury72N
 MAJWGqLqPUSMlD4QcWQhZX3i5LISztBKap9CEqOo7fYJOr+glFi378YYk2UVu1ROYL3V
 SjmRdqi22yerxUQWxE20RsOtDNeQojpvQW4aCvLOBlMuAuxVc3PEXDIKsbUeFTIyJSuC
 T5JvtkXydVNGR2CDrQSfq/BKSWpXm+CD6VtBum41KQjjkCii5E7FYf6JiGltlh3hJaxv
 F1IcY1AZXFc78caLSak4pqEdnSEqRGaiLgsMfHPuHJG6TD5yliwv+C4VY0PoLvYb7eos
 ztkQ==
X-Gm-Message-State: AFq9FYLct3OQXQiAKd2Re9wqSmxxYc9HbkoqK5kgJFD5bAGffNjAkut4
 9w8WulvxETijptoO+RVAsglcamK7u9KCUhnV+vyFOJSOnjtglMdXOIPJy8L9Pq5PDb4=
X-Gm-Gg: AYBFou2ADh0tyvpFvUAFBwsl9cSdF86+msy/juH6M8PK67RurtdBbfF6bT6jNURyglm
 03O6VmRF7hleUXO7S8zC1DmHmByqed0amYruEcyY3fAhXVjXvmxHsRmQe79uq7NMocczA3ht25V
 LV7CGynOnYGHXDwYN3WBPYyMnJ/28DfNPwkEKEd10kibfobyVVd7k4JkTtaxs8/GUJd3svtD+A1
 Q4Rd0O4PX3GouSFiODpgRgeDgtAT0FZuTHA5QBI8L2+JS0xjP91E7tD+GtFnLPggrb9gtZ4Vo9W
 ozOxkLExbLVOF8JliSSMsuJE/j7kAiFTx6q764qBFmTHQRClBLp8hswjQ+f5GTdvyrahC/5RMIQ
 OQ88Qv2m21VpDZqW0JFAXff5IVH+zIJIwOiPqpnVzhy89moLnHbYvhQoP4i4bobDRagDyPt0yVl
 9qbdeLv1tphroymyEimttXAvoxZssc18dl0jqeECKtO17Fq6XEjnfTiPdAWZGdS/tzxnPrD5VCT
 hw=
X-Received: by 2002:a4a:e84a:0:b0:6d7:4f30:8f6c with SMTP id
 006d021491bc7-6ef0d332397mr10180128eaf.28.1791928875881; 
 Tue, 13 Oct 2026 15:01:15 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fc57:1703:6147:d976])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-83039a3dfa1sm13553348a34.18.2026.10.13.15.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:01:12 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 13 Oct 2026 17:00:40 -0500
Subject: [PATCH 2/2] test: boot: image_fdt: test reservations above ram_top
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-image-fdt-above-ram-top-v1-2-f7db4b36d464@baylibre.com>
References: <20261013-image-fdt-above-ram-top-v1-0-f7db4b36d464@baylibre.com>
In-Reply-To: <20261013-image-fdt-above-ram-top-v1-0-f7db4b36d464@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Randolph Sapp <rs@ti.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4064; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=lZ8/oY/cxkTztgn7mydxdJ2u+GfrMfixmGwrQyY4P7Y=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqzqoa+FWSu5GaerkCX9eTkbUcFu5sTaVWCvNNT
 C8KlaGYmc6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCas6qGhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AGGoH/iepapFRLWagZvFds1+m+Ow8Vt1TUdYUDpwYNNU
 WeFfoEIMqZX63Di+X/gTOYNPI9krrGSEbGDxA/Tq9Y4nqz31b8ElU+WRB+/+eFrJAs/u1XeNUG0
 j/5P3MjqoECWXemCiwkgojFhpusAnGYtzuynbdXqknmXweuanVif6e2L1w/J3qhSht/BoG7/hIz
 9s50+RdrwNGJAR3rzCJ3bGVEnZZTo7bPj4Vp8itjDzo291BGPaxejUIy+27nj5yIQtqWnL6yjjk
 JGVEabeaqtunW/4LIatiho0NTAxeTVvO3hVqTm26WyQmLo7YKagYndmFs+mrBi7Y4B9SJRhUXZU
 N4kc=
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

Add a test that reserved-memory nodes above ram_top are skipped without
an error, and that the part of a node crossing ram_top which lies below
it is still reserved.

Enable LMB_LIMIT_DMA_BELOW_RAM_TOP on sandbox so that the test runs. The
sandbox RAM ends at ram_top, so nothing is reserved above it outside the
test.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 lib/Kconfig           |  1 +
 test/boot/image_fdt.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 021a82d4709..96d3da335d2 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1372,6 +1372,7 @@ config LMB_LIMIT_DMA_BELOW_RAM_TOP
 	bool
 	depends on LMB
 	default y if ARCH_BCM283X || ARCH_MVEBU || ARCH_ROCKCHIP || STARFIVE_JH7110
+	default y if SANDBOX
 	help
 	  Some architectures can not DMA above ram_top boundary,
 	  which is after 4 GiB or 32-bit boundary too. Limit the
diff --git a/test/boot/image_fdt.c b/test/boot/image_fdt.c
index 5417689a683..13d2f83983c 100644
--- a/test/boot/image_fdt.c
+++ b/test/boot/image_fdt.c
@@ -6,11 +6,14 @@
 #include <config.h>
 
 #include <fdt_support.h>
+#include <fdtdec.h>
 #include <image.h>
 #include <lmb.h>
 #include <malloc.h>
 
 #include <asm/global_data.h>
+#include <linux/libfdt.h>
+#include <linux/sizes.h>
 
 #include <test/test.h>
 #include <test/ut.h>
@@ -81,3 +84,75 @@ free_blob:
 	return ret;
 }
 IMAGE_FDT_TEST(test_boot_fdt_add_mem_rsv_regions, UTF_CONSOLE);
+
+/**
+ * test_boot_fdt_rsv_above_ram_top - Make sure dt reservations above ram_top
+ *                                   are handled quietly
+ * @uts: Test state
+ *
+ * With LMB_LIMIT_DMA_BELOW_RAM_TOP, LMB reserves the memory above ram_top
+ * itself. A reservation above ram_top must then be skipped without an error,
+ * and a reservation that crosses ram_top must still reserve its part below
+ * ram_top.
+ */
+static int test_boot_fdt_rsv_above_ram_top(struct unit_test_state *uts)
+{
+	phys_addr_t ram_top = gd->ram_base + gd->ram_size / 2;
+	phys_addr_t old_ram_top = gd->ram_top;
+	phys_size_t size = gd->ram_base + gd->ram_size - ram_top;
+	struct fdt_memory above = {
+		.start = ram_top + SZ_4K,
+		.end = ram_top + 2 * SZ_4K - 1,
+	};
+	struct fdt_memory across = {
+		.start = ram_top - SZ_4K,
+		.end = ram_top + SZ_4K - 1,
+	};
+	phys_addr_t addr = ram_top;
+	int nomap_start, nomap_end, nomap_above, noov_above;
+	struct lmb store;
+	void *blob;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_LMB_LIMIT_DMA_BELOW_RAM_TOP))
+		return -EAGAIN;
+
+	blob = malloc(SZ_4K);
+	ut_assertnonnull(blob);
+	ut_assertok(fdt_create_empty_tree(blob, SZ_4K));
+	ut_assertok(fdtdec_add_reserved_memory(blob, "above", &above, NULL, 0,
+					       NULL,
+					       FDTDEC_RESERVED_MEMORY_NO_MAP));
+	ut_assertok(fdtdec_add_reserved_memory(blob, "across", &across, NULL,
+					       0, NULL,
+					       FDTDEC_RESERVED_MEMORY_NO_MAP));
+
+	/* Set up LMB as lmb_add_memory() does for a lower ram_top */
+	ut_assertok(lmb_push(&store));
+	ut_assertok(lmb_add(gd->ram_base, gd->ram_size));
+	ut_assertok(lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &addr, size,
+				  LMB_NOOVERWRITE));
+	gd->ram_top = ram_top;
+
+	boot_fdt_add_mem_rsv_regions(blob);
+	ret = ut_check_console_end(uts);
+	nomap_start = lmb_is_reserved_flags(across.start, LMB_NOMAP);
+	nomap_end = lmb_is_reserved_flags(ram_top - 1, LMB_NOMAP);
+	nomap_above = lmb_is_reserved_flags(ram_top, LMB_NOMAP);
+	noov_above = lmb_is_reserved_flags(ram_top, LMB_NOOVERWRITE);
+
+	gd->ram_top = old_ram_top;
+	lmb_pop(&store);
+	free(blob);
+
+	ut_assertok(ret);
+	/* The part of the region below ram_top is reserved up to ram_top */
+	ut_asserteq(1, nomap_start);
+	ut_asserteq(1, nomap_end);
+	/* The reservation of LMB above ram_top is left alone */
+	ut_asserteq(0, nomap_above);
+	ut_asserteq(1, noov_above);
+
+	return 0;
+}
+IMAGE_FDT_TEST(test_boot_fdt_rsv_above_ram_top, UTF_CONSOLE);

-- 
2.53.0


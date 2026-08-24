Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85422C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D55880DE4;
	Mon, 24 Aug 2026 13:13:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BF76yDSXMWDN; Mon, 24 Aug 2026 13:13:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577236;
	bh=0mlWO6nVfm8rGojx+zPg9QWP+uql6KuzAhaRElqFLss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D8t+MPXd5S7GPB2CAcQyaCLn0zxYNcPxUGxOwdSy9bqgWEs+Obfw6iZZ8AbSIBhvo
	 PdGeYQxZBk9ZfoBPJAaqq2BhGwIbn9bIC+5UvRXpHphaCWUICwMQMfXd1CoYRuxSjA
	 bvnG0CIaTdeEWy5nqrqW8ICXjI4Nht2zrHXeK1RXI41uzxTIcMkporcsxs/p+ylnNs
	 cadgR7eqqJNkaYC1UrjSqddW+PuggQFOvqb25WGxijtr4WhIc669EowmmbuDLi6WQA
	 c4u7+8kGkp06Qah7uH8jCIcJW87P3kzORNhwLZSlsX9ENkRdSxXh1/T2O+Efg2ovwy
	 Reh7Ybv+bbMGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6BFF180DF0;
	Mon, 24 Aug 2026 13:13:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DF17386
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7FBB5605E5
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2YfBmHKgttgH for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:13:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=XqdO6WYv
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5EF99605AC
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:52 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so31858465e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787577231; x=1788182031;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0mlWO6nVfm8rGojx+zPg9QWP+uql6KuzAhaRElqFLss=;
 b=XqdO6WYv1cYgCQFV17dp4WVZ7Xz8Ysmtfwb5McS4bmSZyLARzucGy62YNDsWpBOiNd
 ddTAsgLTI0xYd1qNy/n2/mGPhFJRd4EFlGYfdyGTNPVby+u0JDJjSIkTUZGHUAF1EylX
 0UlXvm6tDW2oMa8OEcEOw05wYWgDF4WYLjTIxPBsqyQuUUHb5pOTouKH85X6Sl6A8M7t
 4I42pgCsfS56Rhhu52DVqD+iabKeAa57D9nIQ27ZrwbabRIqGdZyg5F5iDNMU7CYgutt
 VcHg+NN8YgNhjHKl0QopgfAOetfOBqp7Ff7WWGvHyk9kz4+vNU1FK3unhphmKC4NUItS
 ygow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577231; x=1788182031;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0mlWO6nVfm8rGojx+zPg9QWP+uql6KuzAhaRElqFLss=;
 b=KX3sIR5dl73fYJANs5BJ9PaBGmmFcTP6u0p6u63uZgW+z4NMqSiM+JQdfgmYXHX9HZ
 hr30SGpfBmKSi9GqgiFQat9DyzkmjEZUxqEKsoFk3J4heOyfZVGoitoEIoRzhxiEYFWp
 O6SiZml9FLAB2oXwWLlcsgSNPQ0cXo/ZN4eZAkiLKs8dEIBLCUl1vUBsBsGiAmZUT0bl
 BKhZucq8qJCYoKwHg+6vdGz1k+ceeV0Uf+FCeNZZpW42VAJMfBw2njuHKHbtfeHycoRG
 enbSaVsSm5DnLfysazd3LEPzyvWzPz+eUyvuFgIg74KgfsmzMqkBSFhd3siy4PiIf3JZ
 SYYA==
X-Gm-Message-State: AFuF++l7DDwBgEdv+mTyVsrqaIEM1C2PvJ4ASEtSfDegb9D2FggZxfVp
 IofcHIu7YjjoykyT+CPEMb+QJKuFbWThdWs3GdGZRkvJJGP83WHxBr2KTDh8aEXKVyQ=
X-Gm-Gg: AR+sD10JunCF/868zJwVXAlWcfSoouemMXOJSEs/yAhpRrnaXhyeGbKnBNSaI5U1kSm
 UNO/WRq/BsiKuZI337fHLCEzjM7IJ28qbxsTVIEX2tfkbHjXJO/scP8fx5UmvvuZ9fvBrnIR+Uk
 dtMcormJ3zjXOF20we86TYb+4jR1MdOg6WgyrFwH3Pcrls9/ve42cNwFKG04Ul2pggIae8EfmA6
 VUvHa/FhnV7ggj8jFCpN+3kOqCgaC1YpaE6x1L145A95jIBhUATeO4xO9zqy2RlIrJ3tEjEQr6H
 +t1BKyAsjYF2zFKoLx/sjwU5+fRIWoQDdGdhovnxYImqaMWIhOU0gcf4VD7KzTNvgB3SaRKJF6p
 xEVx2StLU1rmZ275jnZ4oEqraNNEthIhqaX8PIcxC5iFLojPjUs6GKDFAgCt4JLEI/Vdv8P8oor
 b16QakyHcZOQoQTr8bzCfFHE0X4U3wDDAp+RqGBllCFdcIFEuv6GaDaFPs7B0WEB09YVpki1sOt
 So0Jpk1xGVmhDglzXHhWNaVry5Bw4M94H8/65aNg0lMKcl4NRi/
X-Received: by 2002:a05:600c:8b77:b0:499:48bb:417e with SMTP id
 5b1f17b1804b1-499b82f4163mr352355215e9.2.1787577231084; 
 Mon, 24 Aug 2026 06:13:51 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b85412sm8144059f8f.14.2026.08.24.06.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:13:50 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 24 Aug 2026 17:13:12 +0400
Subject: [PATCH 15/17] pylibfdt: Add add_mem_rsv() and del_mem_rsv()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-pylibfdt-sync-v1-15-a42be6fa4872@flipper.net>
References: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
In-Reply-To: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Luca Weiss <luca@z3ntu.xyz>, 
 Brandon Maier <brandon.maier@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Simon Glass <sjg@chromium.org>, 
 Rob Herring <robh@kernel.org>, Jaipaul Cheernam <jaipaul.cheernam@est.tech>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2305; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Yg0BsQm9AtrDJ0P+8tKsy6ohbYSN7GAXGtlBv84pkY0=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1OGdfP/pf+CP/DBtBGYYJt3oX8GXPPl6z4MJbs6NxF
 WtWFFzO75jIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqxewZ/oo1XWRLOvZ14qEK2y3rGM+0/nMw3narad8D+8v/Z648m2XJ8M9mTlh
 9juy8cyJrRFaarHVx3OEScPG69b8X7XntwvcfurIBAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

The memory reserve map can be read through num_mem_rsv() and
get_mem_rsv(), but changing it requires calling the raw fdt_* wrappers
with the private Fdt._fdt buffer, as the class exposes no methods for
the write side.

Add them next to the existing accessors.

This is a backport of dtc commit 89c99ce78ac8 ("pylibfdt: Add
add_mem_rsv() and del_mem_rsv()").

Link: https://github.com/dgibson/dtc/pull/190
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 scripts/dtc/pylibfdt/libfdt.i_shipped | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt/libfdt.i_shipped
index 1983ebaee335..127ec22de3fe 100644
--- a/scripts/dtc/pylibfdt/libfdt.i_shipped
+++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
@@ -640,6 +640,42 @@ class Fdt(FdtRo):
         del self._fdt[self.totalsize():]
         return err
 
+    def add_mem_rsv(self, addr, size, quiet=()):
+        """Add a memory reserve-map record
+
+        This asks the client program not to use the given region of memory,
+        e.g. because something was loaded there.
+
+        Args:
+            addr: Start address of the region to reserve
+            size: Size of the region to reserve, in bytes
+            quiet: Errors to ignore (empty to raise on all errors)
+
+        Returns:
+            Error code, or 0 if OK
+
+        Raises:
+            FdtException if there is no space for another record, or another
+            error occurs
+        """
+        return check_err(fdt_add_mem_rsv(self._fdt, addr, size), quiet)
+
+    def del_mem_rsv(self, index, quiet=()):
+        """Remove the indexed memory reserve-map record
+
+        Args:
+            index: Record to remove (0=first)
+            quiet: Errors to ignore (empty to raise on all errors)
+
+        Returns:
+            Error code, or 0 if OK
+
+        Raises:
+            FdtException if there is no record at @index, or another error
+            occurs
+        """
+        return check_err(fdt_del_mem_rsv(self._fdt, index), quiet)
+
     def set_name(self, nodeoffset, name, quiet=()):
         """Set the name of a node
 

-- 
2.54.0


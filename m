Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3369C5AD4E
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 21:46:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B539A60678;
	Sat,  8 Aug 2026 21:46:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Da5QuwGHxWR; Sat,  8 Aug 2026 21:46:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7202A60638
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786225570;
	bh=m33vvptqoBi1bmTp18aGCeuoRE7Wgv/apEKxfuFyIoU=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=sBfSXnO0KtQHnAlWQvJefE0q19pIolTrL2JqIwpWaM1aQgi5tO027lv0MX5dm5moL
	 4ZjgZawIF7jkbgSc2cSdlzW0M6GOQVhdNR+tE2EJ6jFYrE7gzLQL/96hyMIsfSDvLm
	 BhmOWY2ZoFN8LcwGQ/npLijkK4KrGOhoFrRdaJmaSTicZlmmIFzXEpWeBaKvsw6AfM
	 OO4wll5r250iKySMT9xmvd9uid/z+O8TJTiccgZ3kqQbS2D7elx8QoOcO/SS0PqUME
	 jwqeZ7PkzfXWpUHNW1UWIAy4CuAhplbuILS4lkTsoEobRr62I8fsKmiF/vp0P2EIvs
	 lDBs4BRVt/dzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7202A60638;
	Sat,  8 Aug 2026 21:46:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B3E32F5
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 21:46:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2907D4006A
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 21:46:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Or01NqXqx2UJ for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 21:46:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5F50E4005A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5F50E4005A
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F50E4005A
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 21:46:07 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hHZMb0BXKz8tBm;
 Sat, 08 Aug 2026 23:46:03 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Shiva Tripathi <s-tripathi1@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] doc: ti: k3: Fix pseudo DTS syntax
Date: Sat,  8 Aug 2026 23:45:36 +0200
Message-ID: <20260808214559.98133-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1fed16294f676c321fb
X-MBO-RS-META: gb9rsbswfmnrbgo47mif7qjuiuogjdsh
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786225563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=m33vvptqoBi1bmTp18aGCeuoRE7Wgv/apEKxfuFyIoU=;
 b=Cz+qL665l9r3WMv4HvaUI+8gwK62NJSxEvUQfKgg//EiFsMmNp+ODT68bDmRUi8j3DudPd
 tPK2uoa5ybHQQ5/yZ578pVHOmJjtVTIbIdht6IPQpLY5JyHghjwSwAbyvhfpJ1F+TdgzJI
 X8S8v0P/QrOoZV25yIcRheZuvqmyrcJJ7goQIWZbs696GTcgBoRPDlUEjK1pJJ+syr9kIM
 YXcTfc4Yp4qRo4KsTZ4Em54NngJp8f9kI+MTr3CqAfPzlzb0exCJHDPf76LSvCA/MSy0o1
 gQ04THJB4sqxJKvCd05m7561nbwygdDnEYKO1iqvcjzs1FZOpUVm60PZHhhsWA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786225561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=m33vvptqoBi1bmTp18aGCeuoRE7Wgv/apEKxfuFyIoU=;
 b=Myt1K+kW9Er/XQNCu/Ry1g1u/sNYIoNKkVqaQwHpcTrQWSBS1xIwX0gIGS00rZ6qVAXQ08
 BQpQa95jKJhODsU6STwi2bn9OcuJ7R3d6asJYBLrZOngLC66A/GBPUzSHbkS9p8s1YLHhy
 07A7OqM2RYcGb3NYcnGdm4rQ3SE9lwF/tAtGog+QXQJhAaSRoYo+6cgbXHvvW2m2LFaBJz
 ZXOD17CYIUX7yXJYAyWcJBqc/2VWiruIv2pSR3RbeES0TOswqfid6PzpO+hXJ8jMW/62WO
 8ZkO79kRsriBG5wKh+XEOKyIwGd5m4KzzD1BrqFnBkz5/MBA6wWZZhW7nK0I9g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=Cz+qL665; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Myt1K+kW
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The code block does not use valid DTS syntax, but rather a pseudo
DTS syntax. Sphinx complains about this, so fix the syntax.

"
doc/board/ti/k3.rst:467: WARNING: Lexing literal_block '/dts-v1/;...};'
as "dts" resulted in an error at token: 'i'. Retrying in relaxed mode.
[misc.highlighting_failure]
"

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Shiva Tripathi <s-tripathi1@ti.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 doc/board/ti/k3.rst | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index d3ecaf59909..7eeb1a040d3 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -473,18 +473,24 @@ choose any configuration at runtime to boot from.
         #address-cells = <1>;
 
         images {
-            [image-1]
-            [image-2]
-            [fdt-1]
-            [fdt-2]
-        }
+            kernel-1 { };
+            kernel-2 { };
+            fdt-1 { };
+            fdt-2 { };
+        };
 
         configurations {
-            default = <conf-1>
-            [conf-1: image-1,fdt-1]
-            [conf-2: image-2,fdt-1]
-        }
-    }
+            default = "conf-1";
+            conf-1 {
+                kernel = "kernel-1";
+                fdt = "fdt-1";
+            };
+            conf-2 {
+                kernel = "kernel-2";
+                fdt = "fdt-2";
+            };
+        };
+    };
 
 * Sample Images
 
-- 
2.53.0


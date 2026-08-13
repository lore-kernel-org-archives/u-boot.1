Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7F8C5DF6A
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 15:57:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3783F409F5;
	Thu, 13 Aug 2026 15:57:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0cGfvAeKNt0w; Thu, 13 Aug 2026 15:57:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7765C409F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786636638;
	bh=lih+rqQqlkJ8puFaHrQp5t9dIV5JwX7+xDLIntPzguA=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=eKoBG/b6h4TzYZoPAV05ZzGPFmPXQZiDPSZJDy6MNtmbPoyVWiA7Cu2lqNS7Tz0dz
	 Y3dL6t1Db+1wEWw4pj4y6XLZK6M8g0kdknNxF2u9X8a15SihjAqU35A1brGGKaWKb5
	 Gt2f438NgKbdjtxBdYxRDbT6AdwOr7KgFnx6yELrNkxYb0EStfx/eUxyfVOcE7wmKm
	 oLdNO+02ISOpeALSxgQjWerMZ2HANbTTis7cbCi+wgD4ZbGcLi3zv9u3Lid4ArLwgO
	 Yst+LTBktNus9/HxGCqQJGHGssaPu1q3+IwXG/eaXXFptDhiEkivxSrOxDoxGmg3A7
	 65j0wUXflPFTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7765C409F1;
	Thu, 13 Aug 2026 15:57:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CCD2259
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:56:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B02840158
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:56:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bloK4RhQ6h1g for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 15:56:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B4F9B400E5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B4F9B400E5
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B4F9B400E5
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:56:52 +0000 (UTC)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BE20D3F135
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:56:50 +0000 (UTC)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e5a616d07so2776416a91.2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786636609; x=1787241409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lih+rqQqlkJ8puFaHrQp5t9dIV5JwX7+xDLIntPzguA=;
 b=P9S4fvMbUmpH7CBa+VYzM/fAGqVdKrbSg39DCVPnVf3oQ8rNoYajtbSumaez62WWnG
 yDD+P2/ecbfkz9SnlO40tf/kr043Je7mSwHlg/XFyiuriNyiXF/Wm8PhIAOBVA87xN/f
 +1udI0scjtWTHxEU/d/rPEQimQoIawe5olYKkKMP73brU3g/2U+wWaedWTADxNlukt6Y
 0g6xh2/czgKDhL5gC6vOTFIKQc4BgcDPoQtnsvJaLkDqNrUNRhNfSfI06xoki6qYEv/L
 Gy1Gv3lLQj1ztQT7Pa+/FYWuzl+jkvNFNYrWN28ldU3KN0gGnMu/ojjn3K5DAPEuPX4r
 Etdw==
X-Gm-Message-State: AOJu0Yw19XsZZ02Nr2csqf5I6caowDLV9r//vOsnaNVHBDqAQ8GTPMPp
 0Ftd1chSJPM5j6J8cA8hq675IlXVFpNBdPiL+ip45/BtgQ0JZPOXl9VcljruxU9VAkxDswiWuZa
 xU+UWX/EJ4PyhQH5EIPt39uy+mTqKqq72U8WJKJGZWPxni187UVEBK36Jx13/rOmuNBDa/RKbeu
 jzFZsrbNNdDBF/BeiHWw==
X-Gm-Gg: AR+sD10xTgJzddjrSZ+7wzMO9qeqHLhxk0uPAJY2ISOLWVPiiMInSzI311J6XtPbj0w
 DcYXCNNA3qbMszdSayACp4Cz5ks0sDntQd+IlyMBjVAb/yLjtNkGbTeyjc+xVtG8IxzJO5oVVn6
 RJyicYyMK/GQr5+8bULWj33+x6yGCuuzO5cO4lSQEOxlVARlwgASKc6dULVL7ZHnmKNqOxkJyKt
 oFxdkCqlEvvneQnGGLyltK3A/jqPpSUYqYt0OEpL/krho38EocNaMOQ+9mu2e07tQaaYZKgtvWV
 HWwaXnLJWqU8zCBMny/IfIHUlf+3+JYtUejNUDcnHoAHw03ip5hPxBRorM9y3u7Ovb81YU8/Gdk
 as7vQ0DRuBolPWCme0pyJoHhsd5u35wF6HbynHMUJF2fgPwU9wx4=
X-Received: by 2002:a17:90b:254a:b0:36b:77b9:5c8c with SMTP id
 98e67ed59e1d1-3931e2dd751mr8198102a91.17.1786636609230; 
 Thu, 13 Aug 2026 08:56:49 -0700 (PDT)
X-Received: by 2002:a17:90b:254a:b0:36b:77b9:5c8c with SMTP id
 98e67ed59e1d1-3931e2dd751mr8198024a91.17.1786636608738; 
 Thu, 13 Aug 2026 08:56:48 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931f44de1esm3603538a91.13.2026.08.13.08.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:56:48 -0700 (PDT)
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Martin Schwan <m.schwan@phytec.de>, Francois Berder <fberder@outlook.fr>,
 Denis Mukhin <dmukhin@ford.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 5/7] bootstd: rauc: Fix leak of the strsep() source buffers
Date: Thu, 13 Aug 2026 15:56:15 +0000
Message-ID: <20260813155617.184928-6-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813155617.184928-1-aristo.chen@canonical.com>
References: <20260813155617.184928-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 15:57:08 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786636610;
 bh=lih+rqQqlkJ8puFaHrQp5t9dIV5JwX7+xDLIntPzguA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=UbzOfK1kcdBIGvQsJTBk7Wyp1zalqFMN9J49kj69yD6L+tLhRiJ9z66Gfw3r9+GEF
 qdUIzNvomusHJqaFkNJOh8AG5yDtludpeyJ5NvnPikgC/7N7T9H9pOZzJ99TXD3554
 ps0BGafnDw//3xH+9ofUlyMsjBMTIQvrRZ3K4IkFo9ndYzbsDHGbajTqQmzpmPmcah
 +OCjYpF+Dxa2GpJ58Sx4EYSbtRR468DaMr9QR+s1ZisLDatcFfmgDifnHNu+9dojkp
 VIRpCFSW2OEXd3H1Y9anDoZY58KHecL3NTLYPbIs2K+JoF6RTDUqeqy0xsv1cK2RR3
 1jjSoLgk+dmPduDIFXEVZDI/cRo2X4A/Upxz2go7tUgVXGnf0qZjViBbCUn6hz2S0j
 y2/z9X7HaMdZCn6xgKRg5K0yd+BRbj8QYlkEC7toNYhbdvw2g+atGqnmFO8rOmYwmD
 3kpqdjc4MQabxdYzUVaQLxZXJ4j3a5GIB2AVbp58hVbLdg5ClQzBmRr9EjjgwFR6hT
 A0Fah/t9fQ1d29+0jBf/xc9Ad7GneEC23kG5gTPetta4qbNClx0knVd3JpzwWb/3VV
 RJxhf655RPHusMU7pw+KtSixrrYYn0tEQ5WHbCGvY//kY56vTdw/6J0DNwq6Wg9a6m
 4bLfubMSfSNmXut/ZYcjbgeE=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=UbzOfK1k
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
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

distro_rauc_read_bootflow() duplicates the default boot order and the
partition list with strdup(), then parses both with strsep(), which
advances the pointers until they are NULL. The error path then calls
free() on the advanced pointers, which is a no-op, and the success
path does not free them at all. The two buffers leak on every RAUC
read_bootflow() call.

This also removes a landmine: if the two lists ever had different
lengths, the leftover pointer would point into the middle of its
buffer and free() would be called on an interior pointer, corrupting
the heap.

Parse via separate cursor variables and free the original pointers on
both paths.

Fixes: 7e5c2c782fb9 ("bootstd: Add implementation for bootmeth rauc")
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootmeth_rauc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index 12ab9fc5bbd..2df141f7424 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -147,10 +147,12 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 	char *slot;
 	int i;
 	char *partitions = NULL;
+	char *partitions_cursor;
 	char *boot_order = NULL;
 	const char *default_boot_order;
 	const char **default_boot_order_list;
 	char *boot_order_copy;
+	char *boot_order_cursor;
 	char boot_left[BOOT_LEFT_LEN];
 	char *parts;
 
@@ -198,9 +200,11 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 		goto rauc_read_bootflow_err;
 	}
 
+	partitions_cursor = partitions;
+	boot_order_cursor = boot_order_copy;
 	for (i = 1;
-	     (parts = strsep(&partitions, " ")) &&
-	     (slot = strsep(&boot_order_copy, " "));
+	     (parts = strsep(&partitions_cursor, " ")) &&
+	     (slot = strsep(&boot_order_cursor, " "));
 	     i++) {
 		struct distro_rauc_slot *s;
 		struct distro_rauc_slot **new_slots;
@@ -239,6 +243,9 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 
 	bflow->state = BOOTFLOWST_READY;
 
+	free(boot_order_copy);
+	free(partitions);
+
 	return 0;
 
 rauc_read_bootflow_err:
-- 
2.43.0


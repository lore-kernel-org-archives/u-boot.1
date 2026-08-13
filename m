Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F19C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 17:59:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F9548130F;
	Thu, 13 Aug 2026 17:59:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cjQ3A2s66-hO; Thu, 13 Aug 2026 17:59:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49A2C81311
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786643965;
	bh=YenJ49/FROMBb7sj13qV9XVpj3vUEY8ONmFrfSbrYh8=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=muMJWkKu7ShnWEuOG+fqTlB2P1GHgPDuh0L4VKPD0er7q8LoyHfnBXjetYhaDgUnu
	 iZEhSd1n9XuXgGspSo6PwKSzM7WhP0+ZLb4XaiDxbC9+Hwl0eumHYKW0UHKg6GcaDj
	 CYDnaEko3OdLcPxx9STULiYeaA/KAbTpGXrHWyaVrtntFfqwvx03HE0M2o5qyjS6KY
	 zN/d+7E6G9GQIzHB/MRwAb1IrdQrmhYxPwyP3pc1/z9+rjBegjSc7aAcjUTZXI24C+
	 xB1pv7kjA7zI1K4Lyp6kmJocHyeZwiuCpg8AOCTeb9vX7vl74vuQscpmCMRnX0X1pw
	 DoBdG9PCN4irg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49A2C81311;
	Thu, 13 Aug 2026 17:59:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EC1A5357
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:28:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D1BB240879
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:28:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0GUQkszQBvHw for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 16:28:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1BA464085C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1BA464085C
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1BA464085C
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:28:17 +0000 (UTC)
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ED72E3F135
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:28:15 +0000 (UTC)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-80ee3cb097eso1558027b3.1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 09:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786638495; x=1787243295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YenJ49/FROMBb7sj13qV9XVpj3vUEY8ONmFrfSbrYh8=;
 b=JvHLuZksK/VHTSrqxPyZfEekv8/0wQWq/inMi0hq/36hfhn6uTM7OS/SczqOOI10pf
 FoAlW3zYwQFnWiLD86gjJjN1JjzRVyMhjCA+ZnRYeM8OOTkGsma3SHbtd9tL9VnYmY5L
 xS7FMoe1wYb4RQzPw+X3PER4uLPc92R1EzcH+Ps/t4tsIclBzx+wBXQ99PshZjk9xYcC
 5kH1XGVDhlujo3qZ8GDiYrGxVaA5AavUYh4OK+gNVyphkfQ8Pgt9tDin1em9WBWYaS4H
 lmGqpULhaK2iByTD8oqIg2yAxdBcpgsT96Q1LMtSujBnQRmeptJFzXOQBBiOKlocFPgX
 ZSQA==
X-Gm-Message-State: AOJu0YwKFqOaqDZJJ28jAh8KsXdwfTVYKNCZ9vRbzCTP0Qtig8958oSw
 NVGeLs84upwkRQaff8WdAXChokBOM0x1eAHGa4baGTHpdl3xeYTZUXA8x6pEAmiDiYgVogSTcHm
 uLz9Vtx02gfGVvwILoqF1KwIt5RgGwMuQfBIqoZRdl4BEyjx9FwHSqW8Vg0KEDyqxvmjM+1vHrJ
 iB4eAV0mLYrifRftquXw==
X-Gm-Gg: AR+sD11a0Xzh0rRU1cHrdAEsisnl+32zoH/z7QFLVue6mpG5+1V+p0+W1pwM8xko9jb
 tv5KeRa8dxZN0kB5R2nAZm34TM9ub0dSkNKvm3gSYQ+pww+NMqhGWALE2pO+ymzudfx7hHDDpky
 2UEtT+mn9i9m1F0A9N4wmCOeKzteVA27z1bsOWcgjelGj13DGM5gdlU0BHYbrHO6QwE21lixWEP
 SXagmbMR4OMmL0rqbWN2Gns+HEtYpxmpP29HQ8y9GXCTv4R7Rnw8gMuzxEQSSPiMXR+tp1395qe
 KPPyTsABE2ySH6gvM1SKU62JPET1y7DY+vJKLznkXt1dfS1sofREm9pUjO5TRo8ftljHAIBN+Uu
 WZNMS5Xn0LJesKWsLvf/OLqXAG/ZXcc5mDkSXAYOG4XwLxBK6688=
X-Received: by 2002:a17:90a:e7c1:b0:38f:c90c:72d9 with SMTP id
 98e67ed59e1d1-3931e059eb3mr7982190a91.9.1786636611266; 
 Thu, 13 Aug 2026 08:56:51 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c1:b0:38f:c90c:72d9 with SMTP id
 98e67ed59e1d1-3931e059eb3mr7982139a91.9.1786636610772; 
 Thu, 13 Aug 2026 08:56:50 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931f44de1esm3603538a91.13.2026.08.13.08.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:56:50 -0700 (PDT)
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Martin Schwan <m.schwan@phytec.de>, Francois Berder <fberder@outlook.fr>,
 Denis Mukhin <dmukhin@ford.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 6/7] bootstd: Free abandoned bootflows while scanning
Date: Thu, 13 Aug 2026 15:56:16 +0000
Message-ID: <20260813155617.184928-7-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813155617.184928-1-aristo.chen@canonical.com>
References: <20260813155617.184928-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 17:59:17 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786638495;
 bh=YenJ49/FROMBb7sj13qV9XVpj3vUEY8ONmFrfSbrYh8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=mDQ/otRZRjmvIQs4h0sfJeo5Qz25rw1i5FuyBhsO75Jb17WjHBSiLy18PvZeJZDke
 5Yqc8pQxemOEQxqt3rjBDl1Zg1NxnKshcZ8xWvjChkmPsYTO2rcgOIv8yOu4jlg28p
 cT/DJHy67b2a8Mc8hWJUVTS2ERifLwt9i+R1hDPqiXtaV+i7b8sZrsSZPLvxpb7vdx
 1LVBkVxszDcI/N6ZaWTt5X82kvNwycRg1UG1h0YL7uuPXDZ217zEatvgO4VeLdh960
 JWS3VilJqZ4wGVLbEYUgJ9uavTTKNhRKHY0F6kK0TUYReLpIHNxobp3yqZVcZrS/75
 2JkGoMuh3GhlrmZdNULFPKgiEZReMpnAAF2X6GU3pxoOyMsHr/mb+g2AKsJ5vbQuUY
 vUzfyH6kt28miTCIPhdMsSlNG18M0MK4/RO38st4bPIz8x1ps6JXP+cJlPH9KSP1wh
 WfBxSWcwn6EbNJS0Tl2bRYinn1McMUE6RjOwOP36P0LowhmuuMWRAfepxjV1So2s5Z
 eY8s6y0HUbIeIxcdv8ZVeHr4kbZV7Wv9geTWwD0B4efkFuE5K1fyF9jjhuoEjWAyD6
 aZJTUNQfb/npn0BhmdOMDyXrwwUlrESQOyWlSUW+6SyEbTLwU5ZdCWbNI3XRkU4YIp
 i7sWuz8JTw2O7CZavQEkZ1AU=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=mDQ/otRZ
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

bootflow_scan_first()/bootflow_scan_next() try each candidate
(bootdev, method, partition) in turn. When a candidate fails and is
not returned to the caller (no BOOTFLOWIF_ALL), the bootflow is simply
abandoned: the next candidate's bootflow_init() memsets the struct,
orphaning everything the failed attempt allocated, starting with the
name allocated in bootdev_find_in_blk().

Each failed candidate therefore leaks its allocations on every scan.
A single failing 'bootflow scan' on a sandbox MMC with a RAUC A/B
layout leaks about 1 KB across ~30 abandoned candidates, and scans can
be retried indefinitely from the U-Boot prompt.

Free the bootflow when it failed and is not passed back to the caller.

Add a check to the bootflow_rauc test that repeating a failing scan
does not change the number of allocated bytes. Together with the
previous RAUC fixes this makes the failed-scan path leak-free.

Fixes: a8f5be178db5 ("bootstd: Add support for bootflows")
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootflow.c      | 2 ++
 test/boot/bootflow.c | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index d8a4a81a838..7ee940460af 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -580,6 +580,7 @@ int bootflow_scan_first(struct udevice *dev, const char *label,
 			if (iter->flags & BOOTFLOWIF_ALL)
 				return log_msg_ret("all", ret);
 		}
+		bootflow_free(bflow);
 		iter->err = ret;
 		ret = bootflow_scan_next(iter, bflow);
 		if (ret)
@@ -614,6 +615,7 @@ int bootflow_scan_next(struct bootflow_iter *iter, struct bootflow *bflow)
 				if (iter->flags & BOOTFLOWIF_ALL)
 					return log_msg_ret("all", ret);
 			}
+			bootflow_free(bflow);
 		} else {
 			log_debug("incr failed, err=%d\n", ret);
 			iter->err = ret;
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 8fa8835c20c..ef4638ec700 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1403,6 +1403,7 @@ static int bootflow_rauc(struct unit_test_state *uts)
 	struct udevice *bootstd;
 	static const char *order[] = {NULL, NULL};
 	const char **old_order;
+	ulong mem_start;
 	ofnode root;
 	ofnode node;
 
@@ -1458,6 +1459,13 @@ static int bootflow_rauc(struct unit_test_state *uts)
 	ut_assert_skip_to_line("(0 bootflows, 0 valid)");
 	ut_assert_console_end();
 
+	/* Repeating the failed scan must not leak memory */
+	mem_start = ut_check_delta(0);
+	ut_assertok(run_command("bootflow scan", 0));
+	ut_assert_nextline("No bootflows found; try again with -l");
+	ut_assert_console_end();
+	ut_asserteq(0, ut_check_delta(mem_start));
+
 	/*
 	 * A failed scan with -a stores the failed bootflows; the next scan
 	 * removes them, freeing bootmeth_priv. This used to double free the
-- 
2.43.0


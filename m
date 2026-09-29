Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA407CA5FAB
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:06:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E83440573;
	Tue, 29 Sep 2026 00:06:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dc3QcHGnokUk; Tue, 29 Sep 2026 00:06:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A8A1A40568
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790640367;
	b=WHaSwy+ZCAlXJZwBSty0v+MG/fy4+876DFkJlk7gVnq3775CdLxfJtmFk0Q+VgNmr5+Y
	 tx9v1utfLU2ml9KTHCyDtEEhdaZhBIeTn/JSK/4bKt4CGCBiGxOWaxuI+LrF0qTfau/8n
	 9eCNaCllnkcrHAewcSBGTJd0e1OcB2mUrhn3oqhmw1cKi56640wY4K0277vUqi+DcfEma
	 CIIrBB8KEPvrSkyQFZcdC/+26sBpQ2c9gHC7H+DX8QrIlQHV1etdOyoWrvdtLhsDncKeI
	 89qtvkCfFiliAymefouKs5S05UPTViCVkhf3gzjbBdW1YN22p1I0uM/NNA5c0giFXiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790640367;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0yxz3SOZZ8lvNFH7H706ghIPoQ6mD7eKJTWcNGwhLck=;
	b=fIYwLksc1tefIw0bMyWdjhDzfBPL9SDkIkPWViRUNjlJB8V1FGK1rKagAb2DxdJVv94W
	 mYJKuDH1YBm1sm+xbntDWFBMQT52jFFSHz8+KE5+R1Bju4rdfb+QN9GG9PSkE8Sb1o8lB
	 Z0dvZy2oCT0GVTCFhr3dB63Dxds/eBf40//HlCLAzTeo7rn3xyVIAdLBffuWP+plgO/7P
	 nVPjSZLCQ9troq1+3WVjes0AWoUKb7OO33GG0KDCqaPZ1CKdVDGnwIhvpTuGYRwrKXqW+
	 mH+kXkz0iuEvaC6e+5s0ff2HTBpT3NhBru0h8TmGtkxjICPRwnzEO7AqK3+bGgZogrw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790640367;
	bh=0yxz3SOZZ8lvNFH7H706ghIPoQ6mD7eKJTWcNGwhLck=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RE4cnfSqDYuygKSVUJrpr91JOJ3xyTdItejLeJDKp/2S8RzYyTI/JnSj3KXR9DyNK
	 PlBMAWmiGDKshh5MiHuUOpYawa1AnOg57PsuQbgmniUHLq5XBvKaaeZrr8I4Tv5Tn1
	 BymNzQAV0jqWIolGdo5Vd8rN3Odh+lfLJBkFhdVyIUVPSrwRvYcJc9LpUa3UE39RKo
	 yf61XZkJXWb9LWmCu0CIWAkwyh7YqDYXOhUAiInN5S4bFEHZtryJdOI6SUO+8MqivH
	 BMdyu7VGmRDTkIXFv2wj0bLlB3Qu8cam+gtXqKhY+LTdC/93CWWAYUrW0mryiuugZc
	 1BSkdfl4IGO3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8A1A40568;
	Tue, 29 Sep 2026 00:06:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 744B03D8
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 55A0180C06
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:06:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pr3e8ak7dCjd for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:06:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A6DE680BD2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790640365;
 b=YO1zqlc1NNsuhkZ1cGVO1gDK1DXdXlb/lPIIhWKzBdNeODRoBe0qHXtWuH7GaNfTOw+V
 SYBbwRv5QtpKtjNCa8uXKEdpFpkq5sGxDzb6IlKLUY4NnQ8hZQcRqFOJRvkSkKKxXUzcp
 zyydEi3edJPSHAhq17nlGD5AJdieUULH4wiLLgwqTR9bqfxUB0H3ed0OVFXYx0yTZdFbS
 ozTLRYaPYGoLiqKlcg1pMMfalVgDpUEz/vLsDbYIJkrovrliAXW2YHK32uloKQwntYduW
 20bEfIbgL3r51OdorkVzAAHehGKfLZVaxHL7PJsqQS9qpvCYqD0zacBTTluWgpD7oTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790640365;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=0yxz3SOZZ8lvNFH7H706ghIPoQ6mD7eKJTWcNGwhLck=;
 b=D8q3JofixpOjc9rdcgqnbBJ4O3PuUk+AUrGWVlOP8ill5leJ1fRc4PCGn8J8HQwQez+E
 0wa6Dj1R1Qb98lHikBN7C0Pd+6BrDq+EoU+4Y8nnkuf7IGPAtzIuwanauiaXclS/pr2la
 8DSjphalrq3f/HfzWX06RCx/EGlzqly0jzjBS1HuIbJKgaXDHBMNt4uDpLGeWeI2DQ0T3
 hvuRUBp5jIYxbi4HagYyCEZbpSl2oYIUAXNOfV8icnPw7XFkHkawyaRrP/c/UXnVQKFeW
 3uxodIU6awkuQXXRs+QtLj6gFUiXz432CiAVNpOz97O/9UAgDD2ECysCUyiBjd23qOA==
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
 by smtp1.osuosl.org (Postfix) with ESMTPS id A6DE680BD2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:06:05 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100)
 (envelope-from <daniel@makrotopia.org>) id 1xBLM9-000000001RX-3vs0;
 Tue, 29 Sep 2026 00:06:02 +0000
Date: Tue, 29 Sep 2026 01:05:59 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Kyungmin Park <kmpark@infradead.org>,
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>,
 Weijie Gao <weijie.gao@mediatek.com>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 10/11] test: boot: imagemap: detach UBI when the test is done
Message-ID: <820120100ab98d856504b7edd2c5d86a09e2723c.1790626459.git.daniel@makrotopia.org>
References: <cover.1790626459.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1790626459.git.daniel@makrotopia.org>
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

The UBI test attaches UBI to the sandbox NAND and leaves it attached, so
UBI still holds a reference to the MTD device when the test ends. Running
the suite a second time crashes in mtd_partitions_used(): the test calls
mtd_probe_devices(), which rebuilds the partition list of a master whose
partitions UBI is still using, and the walk then follows a freed entry.

Detach UBI at the end of the test, and again at the start so a device
left behind by anything else is released before the partitions are
rebuilt.

Fixes: 05c1fbbfa79f ("test: boot: add imagemap unit tests")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 test/boot/imagemap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
index da038a33243..20a8f150a48 100644
--- a/test/boot/imagemap.c
+++ b/test/boot/imagemap.c
@@ -592,6 +592,13 @@ static int imagemap_test_ubiblock(struct unit_test_state *uts)
 	u64 off;
 	int i;
 
+	/*
+	 * Release any device a previous run attached: UBI keeps a reference to
+	 * the MTD device, and mtd_probe_devices() would then rebuild the
+	 * partition list behind its back.
+	 */
+	ubi_detach();
+
 	mtd_probe_devices();
 	mtd = get_mtd_device_nm("nand2");
 	ut_assert(!IS_ERR_OR_NULL(mtd));
@@ -638,6 +645,7 @@ static int imagemap_test_ubiblock(struct unit_test_state *uts)
 
 	imagemap_cleanup(imdev);
 	free(wbuf);
+	ubi_detach();
 
 	return 0;
 }
-- 
2.55.0

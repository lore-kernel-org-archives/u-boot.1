Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DECC61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 10:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 083B980B91;
	Tue,  1 Sep 2026 10:24:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ajOOSR7ODWZa; Tue,  1 Sep 2026 10:24:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788258252;
	bh=ePIjP7IMyd5vK7tvH0OpTjP0eqoHGQAgVHY/7gTRLY8=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QyfL3HIqChjYPg/z1uyZ8DAuOWj4W4d3g0EYBaHMtq3xqyTtrjfGMznNwmfNb5uDi
	 E2C8wFQ0d1rnSp7rzNXZvy5QXchWsIH3GTbb21ZY2ZDItpnEk4YJ70l/AgmEe4x2Ho
	 W6R7UIaEI/vIKlo9qV/qOsqAsqVNNWHJai5eeUvBfPUMwtcTXlUljGJMjMvR4safgJ
	 d3zkt8AoD7KdqmZq21qdrp+FgiCbP5LkqcZp/Vw7Xd5uNMkN8UOFzmylzyKCgihMWv
	 hdTpCpPdfW8hw7nhowIp1R9Mn7L0duri4ybEtNQBBSwjRAOHUvPNlDrHuyUySW1R1M
	 sAeYgq+zQ6luw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E762E80B78;
	Tue,  1 Sep 2026 10:24:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E3CE51DE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 10:24:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C9C4380B78
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 10:24:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LtxMy5GgsDBg for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 10:24:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com;
 envelope-from=naveen.osdev@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=tCAuTtQ0
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1752180B5C
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 10:24:07 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-853c947bfefso834446b3a.0
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 03:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788258246; x=1788863046;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ePIjP7IMyd5vK7tvH0OpTjP0eqoHGQAgVHY/7gTRLY8=;
 b=tCAuTtQ0O4WtCWsNKIaE4e0zZodO6ES2rs0KrYp2EgllknhqDi9EXiIZSByYo2xPmv
 3O0ujHw+m1iNYZifXM3gcC+DWV5m4k5hdqDJv51yeXDELTSTlY6J2dO/69IdtL4/L8Vj
 /hSM3HRk0PeIsqHLtDIsG5RDekSrQGdjpz4ocsH17XLi7TRng+09odrTxYtpT37+Xf0F
 BSTrKNSLdiwyoeIkqyu7WApyRiw3G3Czzu1eyGnkqlyBWpCNsaLjJLua1Up229qbAJ9M
 bdPm1Ozq/cbTmU1y0SjjnTE3oZ6b7wYCq3aeD6bGY6u9QFc1SeAwnVjT5hyuEXmXwTJ8
 GfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788258246; x=1788863046;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ePIjP7IMyd5vK7tvH0OpTjP0eqoHGQAgVHY/7gTRLY8=;
 b=K9fjv4LBSu3CPfzqrMTxmYLPHEnVkBlERNuKImstw8Eaet3Q+VrfA4CI1vNB2KiwY8
 qieV7yHdGAPZGVjd5GfrTHoc1C8EPt9jOP7zP16J9UmUUwWHdl7N3kiYEhF+xHHzBGsv
 8cPCF6BsuQn69fU9wuSeOaf4j48NTTwnHl1AqLYkuurbXwATvgYf+yt9nZ9ZjMW2sjsK
 AxJG+nEd0oMYRWufkJInFqeveoFslkCcClLxTabKRiAZ3WYyZcJGeBb24oj/V9e8f9Fb
 n2Te5gcGoPVU04aXav9o70UNjLt8MLveNpVwAejf9l40zQk6C320tMABU13z6kyZU3eS
 i0MA==
X-Gm-Message-State: AFuF++mAF2emTr8pspxMlnIv1iU2aq6vNaZB8qgCmV9icJQBpXy7SB06
 yzFe6J+zWC+J4OWZRadzlNPm2v5T2tFOuSRB6nrApmv46eT+L6xboMAKnp0c1g==
X-Gm-Gg: AR+sD11yxHfzNs//ei2WGFpAbxjH5v/VHPLNZNc2UZIEVX0CcwBTjeMiBVMDDb1s47m
 SECGWfI+IZTrOdRVClGowzBn2VBKJyPG4TZAmO/fVmzbeNS/qhrc6EQHyCbXOMH2U2QQ4zxSo3K
 itrhUkEGwKUDprrqjjhuJxMWwuy72mwfyALmO6XfuXEix/1RHQQfNYmP3RE520w4p80utH8pIp1
 7P1/NsYr7LH4Bm/yBv8Ww5/+ReI8cB4TvW5S8RajXAjGkJgxhDDwTKtFXKRkMULbuOZcb+Crj25
 6SeAD9wnKHPGNmOFInC5ae19z2hOyBMw+dtyHYdgH4rri6c0OG1LJF5J7vvEZWGXeJN5vbLsLnV
 gPotW+g2r0kK4NCsL5fGPvZaZa4fA17Xq+iVcJ7auJ+OqxyvWb+PTF1iCqGsHr2o7FnGstuqiup
 3QDsqrOfuFrtJWxlHqVLCQffGCKVWA2pugws+IG1BuTP8yEMKiGDoskFXgLpV5DQ==
X-Received: by 2002:a05:6a20:939e:b0:3d3:aed2:6f26 with SMTP id
 adf61e73a8af0-3d819bc7fc6mr3802713637.26.1788258246283; 
 Tue, 01 Sep 2026 03:24:06 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1f36f2a29sm6062423a12.31.2026.09.01.03.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 03:24:05 -0700 (PDT)
Date: Tue, 1 Sep 2026 15:54:03 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH] bootstage: guard against NULL record names during
 relocation/sizing
Message-ID: <beqmeygt36o4pcvilrea27o6a4vwjdslo2wiz2ubzq5thupyd3@75i6ozh5sj5k>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Bootstage records may legitimately have a NULL name (for example an id
turned into an accumulator via bootstage_accum() without a preceding
bootstage_start(), whose record is zero-initialised). bootstage_relocate()
called strcpy() on rec->name and bootstage_get_size() called strlen() on
it directly, both dereferencing NULL and crashing during relocation.

Skip records with no name in both functions. They are handled identically
so the size reported by bootstage_get_size(true) still matches the bytes
written by bootstage_relocate().

Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 common/bootstage.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/common/bootstage.c b/common/bootstage.c
index 4532100acea..4b1e5b91743 100644
--- a/common/bootstage.c
+++ b/common/bootstage.c
@@ -75,6 +75,8 @@ int bootstage_relocate(void *to)
 	for (i = 0; i < data->rec_count; i++) {
 		const char *from = data->record[i].name;
 
+		if (!from)
+			continue;
 		strcpy(ptr, from);
 		data->record[i].name = ptr;
 		ptr += strlen(ptr) + 1;
@@ -523,7 +525,8 @@ int bootstage_get_size(bool add_strings)
 		int i;
 
 		for (rec = data->record, i = 0; i < data->rec_count; i++, rec++)
-			size += strlen(rec->name) + 1;
+			if (rec->name)
+				size += strlen(rec->name) + 1;
 	}
 
 	return size;
-- 
2.43.0


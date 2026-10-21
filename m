Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DD4606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KSLfv1eP;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=bfSrNH30
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5FC7606C2;
	Wed, 21 Oct 2026 16:05:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YCnDKoIm4URA; Wed, 21 Oct 2026 16:05:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0B37B607E4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792598716;
	b=D5kD5MLbOaVRuSfAN4RsrfM7lNx1DBXHLUc4i32drvPKGiQis5gbgi8estPdGlpK47UD
	 HCUAxe1XP38Tn3bo9UudSkpa0ihH7z5BA2uLeQjeqpW/Lawbj9EU7pCIvMVeLYRJvbf8l
	 aEgT24LWlBu3hGwvGiFQmGocU96daip3yOv0DrZhU06+XQJ8k+OGzg6aqVMDjf64VMQXv
	 z7yKqzUIiP6z8s3FwvgSqqgiJJ50tc58Jn8w+q9HWbm53rJCLK8O3Mx/3AgjeBg52tGKg
	 NkK79ipIr2H6mqOVvEr3fPwPmAceZYTPHvewMlMGjiRvUwkb5cSE/jPbAqYCzz+Lzyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792598716;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ibycYgy7n6OT5FZfUzz8ndJzdtUhC54nIGfBmBENi0c=;
	b=Z/0Xr415Q25EtK3isxR9ahIc3zd2xsSVGF6HIZvkUd7Zn2hRtaSMitj4R6Rh9DDJTzGl
	 jEzRQwGvK18rXm9yleJPZn+S2eTdfX7A5aLwp8FQ7XMptaRbYMumSeyPozBRPy+ZTw6Bv
	 bhcxA6Ik5KZPcwtM/4Fw+PhOcoiLgLf8x6kyhDU/DN3dRQtKeSts8uU/OuZ9lpzWud8FB
	 8tgJI50XTWediC4awvgN1KaOCiABtkmWrAoB1mm2hLvPZD6zt070W0Cq+uQBSbfgamf7c
	 tlQki+EI6bANI+6eTispw6y8pillQJtRrAkbcfnPLHaLcK2E34tGrRe1CiXq9SJjpmg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792598716;
	bh=ibycYgy7n6OT5FZfUzz8ndJzdtUhC54nIGfBmBENi0c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KSLfv1eP5F3s9XiYWdj90AOTjbPbxAlbNfZB453qY5oAxcMIIKNEAzqSbUnG+UXU1
	 xAEBjYoLAmwWnEryGc9fektp6LYvS7hhlryasyaJ7CgKsOV4Wv9dFNZgpKOr42w2KQ
	 vGcra5zGXWeZDM6koojWYXKeBcy3DXN5WpZ2HKR+zyDOMRd/ryk1+j7XOfhxeELsJe
	 NBuSdsm69iio2IJIgH1ZgQ9u6w1SAN3hjxlxNRya+XfbB2Nbxu3L1wth0zjnC6wQOB
	 kZWH9d06vnQc1mhReP4NEtPOsm72SDMAQJ+NOpUJ/QbMC7tmMG2lnePRLzTUkYBkJC
	 eyr8SmE2ig60g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B37B607E4;
	Wed, 21 Oct 2026 16:05:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BED1356
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2178840889
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aZqAZ0pZEtBl for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:05:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 967F840879
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598713;
 b=IYrgZGwrF/wwluYFedFIHLB0I5gE59gXWtgJaiASSw+AY9p8vT/e3bKNTn8p06av2XGx
 HH89+SiidePBaAiUgCZzCv8jqtXya5jp5J1E/Z4Cy7eByD+X1rUuuqd+ABz8DWEtFIw8l
 AkPyIM60FTiTF/KersZeqdiZcOICh6IvYvInM3rQK6nzJDzG0zWBA9wsumvx882j4excL
 FPWZ7JqPcMVvRrxIuw9gR2LgL+Qh0xjm0n3FbO6c9XraFjO4tTWGSMMuTFcTU0UOakBOR
 zAjMIVOPDWhKrBY7kVshEpUx7ziJk6xRCqN6UTfqXjWdsZvj2m4PYcn+G1Tt1gzISfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598713;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=ibycYgy7n6OT5FZfUzz8ndJzdtUhC54nIGfBmBENi0c=;
 b=FiUbHMpT7cyvl+It1o2OiM+Yau3Vn4/8h5l3GLJWO9eYzS10k+em1BS1dsxAL545sbRo
 K13Mn7oM1ktcAZtFPNM0ARr+2YmNwHHMfsc2JAYsUQ1H2oFpXNvCVjnxgOWsXKwWDN1eW
 U9Ou+dMZ+c7tEePCx1tTq7okXpyyEjrVGsCdTl0LdgnXLiI8azAywebGTNQZxcv++Ors0
 ib6vbnGMOm64CKv7MjJTZ4ZCMm3EooDNIFS+Ae5fVWoGsDmLWfUzgvLa55UqJu0rwkuyX
 ObPGyKoSV3LNRrjnQsW4yzRl0DV52wYpyXE8nwoH0nIQdl9eo81rz8SWu3du5yBSyPw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=bfSrNH30; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=bfSrNH30
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 967F840879
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:11 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so6616675e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792598709; x=1793203509;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ibycYgy7n6OT5FZfUzz8ndJzdtUhC54nIGfBmBENi0c=;
 b=bfSrNH30XC/NFa5RjlOyfVcfIowVDdnM/CCFRN3rX6fjM4F+TCuxijrXHYobPszsgE
 QNN/G3xsAJkOLYXAlypY1/gqxdwZMGxg81yu8chm0q+oZyL0gOpTnrNLpGoxtTP+0cNi
 7mT+8d8YkHoL2x7G+1S4YbxwHPQ1UJ+R7x3o8nkhuWt1D9DKsjuhhHBzzllXCFd5S4iV
 xrBkNdiAB8L81jmopzyREBs8wCltGGyetfqabplimLiKkdS2I65P9PEfQbeHvHWnqFaq
 63df0fLKU+pLVb8BzWuxDe54UeuUiSjjyIovZoeUPKs6dhsi0S9mPPKoSOsCTKo+FGMb
 0cJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598709; x=1793203509;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ibycYgy7n6OT5FZfUzz8ndJzdtUhC54nIGfBmBENi0c=;
 b=OhBfVlCkQ/L6NKRsnrYpjadOPAmeP3+P0djk+FtQvHAIJLQgHaM0q3+3uTnSi8RGJw
 mjx9/4gxscHKJ5nk2D9uBqy6MOs3CGXqQ0VcI7riIfNJB46+W5jgLKHQfcC/tcNhWwQ3
 ZHQJiqsFba4Wsu00mw+DFCo4R2X+4WV6hQ+WzfVo7DgPsQecyXY0BVVAlGcaSM3zK641
 uDsnaedvon+MQnLVDPgehwRJxmd4Iza1r2jwKY6jHiJkNESei2+ie+PJzgWSeZuLXpEF
 gVtNq1Qk6EWcN9gQT+FM3ECOj5UTbszUIIqbbhrAz0qN7ai5A3lnFHhuaLkvNzAeke8V
 n2eg==
X-Gm-Message-State: AFq9FYLxk12Xpod4xeSW3UfKKwgShVeFsCjr6tyWtXaVl4UdX7Movdr2
 /Zc/zMPMPe+83KYrZ3M0mOFW4iEmNB3F2b+W7FoCDImTiiy38ZdZEc8aFUP21XrOkwU=
X-Gm-Gg: AYBFou1qV9ybRSP8EQqJLIDCYZbT0c3xJGrkBmouIxA2019uk/mym/wgzSJ35AuWNrS
 NfUkIok/J/m1z8BuzV7uWn6MCSzUTbPTCMFCZiQabeOmJ2EjtbhJn6Htu0iYVdEcr6mKFR6JLXK
 C+f+UbPH9/zwJvJMU0IyLZQ3wwJ6qOv90KZkGGckA8H53Ymr+UwH4GhptHy9WE7LYxM1j0397XB
 stdAkbGMcXnM0GzFnQoFMpJyjIW0jnvk0q0Va50Gpwp10nLu/CIqkyC++kbmpsxBqtcUBpBlT4M
 Fgij7Yz2qLlxD3aPLt6nGcKVahjTjntXfmQjgrdTvJhPuHwkEBMH9YuTmpeRT82xy2eiODj6APz
 1+um6SwVMGhMvO4wDxpyNmrwsc53BolTGNXhbqBkDS6ledVwHzmvpjb5DVcaFNXATI6qU+qz5R1
 iNbMm7achTPjC9gL1zaj8dAcf/g8q3rw7eOdgblbbwJdMMHjF/mB/5H8Axy01YTce43D2tBaI7W
 8ke0/8qYr43/NjNP/Dg5JghDTWeCthCctS5YA5r9RYwiDC+RAotMPUR/Km3X1sgugONmlnXtKLN
 StxSmqjJGG8Ol8TvVkfDhJJ82ZynuMcqniVc
X-Received: by 2002:a05:600c:4f41:b0:4a1:d8fc:8165 with SMTP id
 5b1f17b1804b1-4a1fdb12d28mr56099235e9.20.1792598709492; 
 Wed, 21 Oct 2026 09:05:09 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcd629bbsm54075975e9.5.2026.10.21.09.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:05:08 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 21 Oct 2026 20:04:47 +0400
Subject: [PATCH v3 2/4] scsi: add a lookup by target and LUN
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-ufs-spl-boot-wlu-v3-2-064e73cd2209@flipper.net>
References: <20261021-ufs-spl-boot-wlu-v3-0-064e73cd2209@flipper.net>
In-Reply-To: <20261021-ufs-spl-boot-wlu-v3-0-064e73cd2209@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Alexey Charkov <alchark@flipper.net>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Denis Mukhin <dmukhin@ford.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Carlo Caione <ccaione@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3561; i=alchark@flipper.net;
 h=from:subject:message-id; bh=l/3HbiLQTQAAyIKC8jEEI9dtZ9k3jbRVmQfjU7klprQ=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTdeLTysuSU1PWKzZv5JwfOMeZMUD65b72rdJmW4Oq/9
 b7//+750DGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBU/z3I8M8+d/Pl18/EdL+YPG/yX5t/+2nKzHUFWjNnPWYPl5ip8zaRkeH/qys
 bj/su1D4qcJP5Sd3mLwZflEJP6bDtDzxTMHPzom3sAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SCSI device numbers are handed out in scan order across every
controller, so a caller that knows which logical unit it wants on a
given bus cannot derive its device number without assumptions on what
else was scanned before it.

Add a helper that finds the block descriptor of a unit by its target
and LUN on one controller, where those are meaningful.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/scsi/scsi-uclass.c | 21 +++++++++++++++++++++
 include/scsi.h             | 17 +++++++++++++++++
 test/dm/scsi.c             | 22 ++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
index 39b4c7476d45..81753ea45b3f 100644
--- a/drivers/scsi/scsi-uclass.c
+++ b/drivers/scsi/scsi-uclass.c
@@ -47,6 +47,27 @@ int scsi_get_blk_by_uuid(const char *uuid,
 	return -ENODEV;
 }
 
+int scsi_get_blk_by_lun(struct udevice *dev, int target, int lun,
+			struct blk_desc **blk_desc_ptr)
+{
+	struct udevice *bdev;
+
+	device_foreach_child(bdev, dev) {
+		struct blk_desc *desc;
+
+		if (device_get_uclass_id(bdev) != UCLASS_BLK)
+			continue;
+
+		desc = dev_get_uclass_plat(bdev);
+		if (desc->target == target && desc->lun == lun) {
+			*blk_desc_ptr = desc;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
 int scsi_bus_reset(struct udevice *dev)
 {
 	struct scsi_ops *ops = scsi_get_ops(dev);
diff --git a/include/scsi.h b/include/scsi.h
index 439a7f4fedea..5497065b2c0b 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -366,6 +366,23 @@ int scsi_scan_dev(struct udevice *dev, bool verbose);
 int scsi_get_blk_by_uuid(const char *uuid, struct blk_desc **blk_desc_ptr,
 			 struct disk_partition *part_info_ptr);
 
+/**
+ * scsi_get_blk_by_lun() - Look up a SCSI block device by target and LUN
+ *
+ * SCSI device numbers are handed out in scan order across all controllers,
+ * whereas a target and LUN name a unit on one particular bus.
+ *
+ * scsi_scan() must have been called before calling this function.
+ *
+ * @dev:		SCSI controller the unit is attached to
+ * @target:		Target id of the unit on @dev
+ * @lun:		Logical unit number of the unit on @target
+ * @blk_desc_ptr:	Provides the blk descriptor
+ * Return: 0 if OK, -ENODEV if @dev has no such unit
+ */
+int scsi_get_blk_by_lun(struct udevice *dev, int target, int lun,
+			struct blk_desc **blk_desc_ptr);
+
 #define SCSI_IDENTIFY					0xC0  /* not used */
 
 /* Hardware errors  */
diff --git a/test/dm/scsi.c b/test/dm/scsi.c
index 66859c991df1..36713e40dd62 100644
--- a/test/dm/scsi.c
+++ b/test/dm/scsi.c
@@ -36,3 +36,25 @@ static int dm_test_scsi_base(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_scsi_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+/* Test looking up a SCSI block device by target and LUN */
+static int dm_test_scsi_get_blk_by_lun(struct unit_test_state *uts)
+{
+	struct blk_desc *desc;
+	struct udevice *dev;
+
+	ut_assertok(scsi_scan(false));
+	ut_assertok(uclass_first_device_err(UCLASS_SCSI, &dev));
+
+	/* The sandbox emulator answers on target 0, LUN 0 only */
+	ut_assertok(scsi_get_blk_by_lun(dev, 0, 0, &desc));
+	ut_asserteq(0, desc->target);
+	ut_asserteq(0, desc->lun);
+	ut_asserteq_ptr(dev, dev_get_parent(desc->bdev));
+
+	ut_asserteq(-ENODEV, scsi_get_blk_by_lun(dev, 0, 1, &desc));
+	ut_asserteq(-ENODEV, scsi_get_blk_by_lun(dev, 1, 0, &desc));
+
+	return 0;
+}
+DM_TEST(dm_test_scsi_get_blk_by_lun, UTF_SCAN_PDATA | UTF_SCAN_FDT);

-- 
2.55.0


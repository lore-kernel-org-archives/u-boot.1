Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5ACECA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86CC94059A;
	Mon, 12 Oct 2026 14:01:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PtxvVPvzENEW; Mon, 12 Oct 2026 14:01:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AD583405CC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813677;
	b=PP5EEKT9u30ozeGKrdnlV6cBSShW97VjMjHrL0LWxTIPaA/zRioHpc9fF6gGkJ1cz9iC
	 gNS7BIw+XJUcygzX+uDtxx4JR5p+47myT5dttmKQV/DxiB8P3jNdt3sYA39+hBe/jzlL0
	 MHkFIyptzvG/VsGPbCiXvRP/ahqogpkBlN09hgJmUn/nSb7TDAqtWu14x9nTUS/gzTONp
	 uFWS4JmpxMc5ZGw/kv6rVe6pXfZSbd4KICVAjbnW6o/pi/0U3loiU00aB995bepmC2SXk
	 sJnMyLgx70FBSxq2kgx/U2C+1S4LioOKBdMQLT/NJItok3IvOaSFC7jEzuqaT2tLbQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813677;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kuOaJLmxnY7yoVsV4vEGIpHLhEj34y0iyvEaELuk1CE=;
	b=gASo1Lr+ShJ1BSq6QatfqSbhMbHIOXTb2bnt2gIZ48oU5NMBQn6zMOTHFIkYavwi3OsA
	 X/RMhzxY9IfzeUScAf4XbJv3h6Km9p60ySnKhpF+xU4SG7ety4MFdHx1nWxajKulw4IW8
	 Pt361S4XPC0t8a/KB60AngMzVUtaIy245IVDg1UDKFMhCgzGtqdbfjEXQVhppnlTFTnfF
	 lLeg8R4yfzSmQJ9Mspc1eZzojyCMzwPgpS0i9U6aE20uH9drK3SlKmaTeekMqs9tX5iLq
	 MomXVsa30UofReqwMA9gdgstQVzVTKKP3rhT9nGDbQ8hwy7BBt5RVTBF6kHduUclqzQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813677;
	bh=kuOaJLmxnY7yoVsV4vEGIpHLhEj34y0iyvEaELuk1CE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J74gc22cfAN/ZEcMIHFH9T3c+OC345BauiDNCBLE9jjZxILDUFBkumjALhDBcrt15
	 bzS5IqVmakojX7SHxagWAsYiWNKJUB/dHTWgyjK1mTHmA+S+fQFek1zLBJJOpVCl4M
	 F2A4UUZM8CQ6L6XO7RmeoFGFxkslNJUmfEzPuNbEfuD9Y+ibwaH8DsnycA4psJY3z2
	 T8Tz3h4PfCWuIpM6s/PT0gq3gn7mIR5nG34XJ1jmi6a+1Y6uj8mz7lktyUg/eoogq5
	 2hJ3c96MnzCvNzSjWLRMXlIT0EbIJfyoxV+S8veqkNNbz+qIVWDJaliJYXwiN+S2Vu
	 t23JV/RTXmFSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD583405CC;
	Mon, 12 Oct 2026 14:01:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F8DA2E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01CA04010F
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LuA7SwqdiHwP for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:01:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 397384004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791813674;
 b=P1/zdg4jnr1akY9PecE7XCW5xMrIALmfjtrCiZtFQvpGPDWOxF7Cnb1ZTx9PJXE9lW/t
 cTURsQn6lSgjJmBADGfeGFnJ+WiSZfDiW1CxPdfa1oszBvqiEJpTfWYwLXNX3MWjQsNjy
 0Yeiu/1TqBorl0Yx43S5f7/KWEsquxIgjQDjms7TkRAuzi5Bwejwv3G+GaHDjKxVDI42y
 8tIPfJyRYIDfYXzyvtWWougGgGDKAgh1vt5M74AH5UDRVM9sXjHqMilWM/HOYv+Xqwh+7
 P9euUTykgP+c6s8HY36CIa2ZEy572KaQ5CxsghwrfxCj7OacZEVPNCEqJuDk/BNp4KQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813674;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=kuOaJLmxnY7yoVsV4vEGIpHLhEj34y0iyvEaELuk1CE=;
 b=jDMBfQtLTXTIXh4+XTi13uSDbQwerll4Ed+yCVWTZtTdnMNt/L/u+it68fraajAJZUTX
 neqpkKx/kqQevgIX+8RFncIknqDSoi6FNHYe4Tv/oudmoBEphKSKWQM5bkFzsbOLfxc79
 JsmMhSd+IpxPRl7mBE7iZ2vgs1VU93czTnkBRqGAkcoAh8LfRqw4BBz6JkqdbiRLB572+
 uouX9JS4VfGzUktm+pYblOiEbyAP2muRftC5ZyUli1S4vqBKg77R3N1OkQmR+4fDquEac
 xfV1euDNIX6VAsF/TmZ0MLI1m/7Mvjw/gZVWTCRyaGOHVXqLEchjVEndWysoqrwj53w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=Ge4AelPs; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Ge4AelPs
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 397384004D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:12 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 564C33F342
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791813670;
 bh=kuOaJLmxnY7yoVsV4vEGIpHLhEj34y0iyvEaELuk1CE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Ge4AelPskzoOHSIeXkNm/CYmAFtAFKnidRpMv2wVk0lefqgHy+iZp4SRnv9I4FIXw
 PooWsckNzlwY6+EutsVKweov2IR/z7jB1s8OaN+E4Ste9d6UkkQltQxj1OpoxiLldK
 2YY4a2msMjX5C7zZUoXD2VDbgFWK/HsmJeOPupA879pvU6XjfrD/wdcEuMdullcZQ5
 3DKuL56z/KNK0oh/Ho1qkK9fL+fZyxc6v58/2dxqe5M+Z7g7rdPypxv+cLjk2TSCbz
 canKCX4c59FkYDH9vd7B0lRKEMzMjREK52WiKgfounrU7IMij1/czec6Em6uYXaC/W
 PxGENELaUoe8DCZeCZQXD2U2kb7PrKgEnTc+Z5HGBhuPPqG6JW0FDrxAKU3TdFN2k4
 88ffvOox0gc46rR4eQBK/6WRFLXGq4Pv1t1ZGSyH3RIxQQ46M/8qXGSl0irYoIQvbK
 nJhkdJnghJdzldc53W3SDc3hh+J2gh2zFpOMYxMbGHFfLfr7yIdtw2PiPSd+iSudTe
 pqNlhypJzgZEJBxqydlrQJkk+PumkarSHFpLYML0NXBFSDjZKtDEdzfmVAN473HSw2
 HZjpWiZvSvHbi5+7dxkX+ZnoDhUwj4D71RgjnAKmva9yrFA6tChkdJIjbskaF1bPuu
 uaxHSllhlaVK+EVC+syqQiwQ=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a01d1fb07bso23620675e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813669; x=1792418469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kuOaJLmxnY7yoVsV4vEGIpHLhEj34y0iyvEaELuk1CE=;
 b=c2ZC1z3a4RS/QNQis2ht9QZjUUwOn/27yFIYUhqAE06T6ksqpo8aOhVBDXoFY8HrNs
 k1TDTx5DY6FrFE83wx+BRG5mxqI/zAJaXgpfbGQYEhGeNwC6pkE5goQtaEkJSQsUDZfs
 FEwViqbTGN6zlcP7dwiUfsWi6HmHgWK/CPG+ZBNJovNNSQbZ4UoEPgra1zrddj1F2vl9
 mk0orf/vN/yJFiBGuXJFzd7Z+rFJvtLeNYza11VG7qBjRy/Hlrjk3m57GTnz0JbRuU9y
 cBKK2Vl2A15Zb7YR9mmo3zRDntWhEAcOi4KffCqDHqrgTpFkK4a8+kJJv0Tscx1PsECO
 Nthg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPUOLaPekIyPuRkDNRjQ/BGgwn+/dyscgx8S7H11HVzAqUmXYm87sOw4cB/XiVXjRLiC/pT/g=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJSvlH+F/RmvDVPxazR/jXqkpdWFx7XKidpX3Gfr/W5djz84uE6
 /occ9ulFjVvT2av24zKNhYF3KbUOTO4BNU2okTd8iPEUHx/cMqMKACue6K/kRJq85flkmgy+NGZ
 MDfFtMTZbbPYFAwEXEZesYRMuZloINekZpRfYlv00yIMcM2wxTB0+RmwWPg4N1+DaONCt3D6GrC
 kU71EukiD/FQ==
X-Gm-Gg: AYBFou2BvPsk2LDSwKa6/jul6xvId+wJSY6lwX6UFxigTCxnEFBNkg2QD7GehGzsoln
 pGlxjnChgHpv3XUI4vVfYk5uQ8cehReHsAwRghELqZ51apwLlBSh+4hQICeUXGtuleMEw3TSfOa
 esCt1wkUiFqrHmYIt2wi2Gty1Q5LQZ6KAjF3xLCrFvspaAfKxrHtSQFJIlytMRlTLvpoH4mFgtB
 3mG4yUcm/Agv/V6ZDrXCIfgjd3y9YkveAEWJUMymwNpur6lPsXM8gWxPYV+5Tq9nr504Im7ewCH
 yzrKlMbG5PIDGBJXddOGwb4/Y8BhffRQ1h1eABpci/r+JyfKDbSX/8T4ZnX7R/ljFkH7yST3H5K
 zIcvYuUQIIHaAIWLNQt8DxtkJFVf/2lA+bMCmVIcn3AS8hd8Le4qAMcg=
X-Received: by 2002:a05:600d:6413:10b0:4a1:88d7:4e6a with SMTP id
 5b1f17b1804b1-4a19470eccamr88701605e9.27.1791813668890; 
 Mon, 12 Oct 2026 07:01:08 -0700 (PDT)
X-Received: by 2002:a05:600d:6413:10b0:4a1:88d7:4e6a with SMTP id
 5b1f17b1804b1-4a19470eccamr88700855e9.27.1791813668274; 
 Mon, 12 Oct 2026 07:01:08 -0700 (PDT)
Received: from workstation5 ([2a02:908:1242:30e0:468d:767c:32e6:22fa])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf15691sm284551015e9.6.2026.10.12.07.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:01:07 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Daniel Munic <v-dmunic@microsoft.com>, Tony Dinh <mibodhi@gmail.com>,
 Alexey Charkov <alchark@flipper.net>, Vincent Jardin <vjardin@free.fr>,
 joaomarcos.costa@bootlin.com, Aristo Chen <aristo.chen@canonical.com>,
 u-boot@lists.u-boot-project.org, linux-erofs@lists.ozlabs.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/9] fs: move struct fstype_info definition to top of file
Date: Mon, 12 Oct 2026 16:00:40 +0200
Message-ID: <20261012140048.214059-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
References: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
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

Structure definitions should precede code using them.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/fs.c | 86 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/fs/fs.c b/fs/fs.c
index b18ccec8cb4..b647b1cc103 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -39,6 +39,49 @@ static int fs_dev_part;
 static struct disk_partition fs_partition;
 static int fs_type = FS_TYPE_ANY;
 
+struct fstype_info {
+	int fstype;
+	char *name;
+	/*
+	 * Is it legal to pass NULL as .probe()'s  fs_dev_desc parameter? This
+	 * should be false in most cases. For "virtual" filesystems which
+	 * aren't based on a U-Boot block device (e.g. sandbox), this can be
+	 * set to true. This should also be true for the dummy entry at the end
+	 * of fstypes[], since that is essentially a "virtual" (non-existent)
+	 * filesystem.
+	 */
+	bool null_dev_desc_ok;
+	int (*probe)(struct blk_desc *fs_dev_desc,
+		     struct disk_partition *fs_partition);
+	int (*ls)(const char *dirname);
+	int (*exists)(const char *filename);
+	int (*size)(const char *filename, loff_t *size);
+	int (*read)(const char *filename, void *buf, loff_t offset,
+		    loff_t len, loff_t *actread);
+	int (*write)(const char *filename, void *buf, loff_t offset,
+		     loff_t len, loff_t *actwrite);
+	void (*close)(void);
+	int (*uuid)(char *uuid_str);
+	/*
+	 * Open a directory stream.  On success return 0 and directory
+	 * stream pointer via 'dirsp'.  On error, return -errno.  See
+	 * fs_opendir().
+	 */
+	int (*opendir)(const char *filename, struct fs_dir_stream **dirsp);
+	/*
+	 * Read next entry from directory stream.  On success return 0
+	 * and directory entry pointer via 'dentp'.  On error return
+	 * -errno.  See fs_readdir().
+	 */
+	int (*readdir)(struct fs_dir_stream *dirs, struct fs_dirent **dentp);
+	/* see fs_closedir() */
+	void (*closedir)(struct fs_dir_stream *dirs);
+	int (*unlink)(const char *filename);
+	int (*mkdir)(const char *dirname);
+	int (*ln)(const char *filename, const char *target);
+	int (*rename)(const char *old_path, const char *new_path);
+};
+
 void fs_set_type(int type)
 {
 	fs_type = type;
@@ -148,49 +191,6 @@ static inline int fs_rename_unsupported(const char *old_path,
 	return -1;
 }
 
-struct fstype_info {
-	int fstype;
-	char *name;
-	/*
-	 * Is it legal to pass NULL as .probe()'s  fs_dev_desc parameter? This
-	 * should be false in most cases. For "virtual" filesystems which
-	 * aren't based on a U-Boot block device (e.g. sandbox), this can be
-	 * set to true. This should also be true for the dummy entry at the end
-	 * of fstypes[], since that is essentially a "virtual" (non-existent)
-	 * filesystem.
-	 */
-	bool null_dev_desc_ok;
-	int (*probe)(struct blk_desc *fs_dev_desc,
-		     struct disk_partition *fs_partition);
-	int (*ls)(const char *dirname);
-	int (*exists)(const char *filename);
-	int (*size)(const char *filename, loff_t *size);
-	int (*read)(const char *filename, void *buf, loff_t offset,
-		    loff_t len, loff_t *actread);
-	int (*write)(const char *filename, void *buf, loff_t offset,
-		     loff_t len, loff_t *actwrite);
-	void (*close)(void);
-	int (*uuid)(char *uuid_str);
-	/*
-	 * Open a directory stream.  On success return 0 and directory
-	 * stream pointer via 'dirsp'.  On error, return -errno.  See
-	 * fs_opendir().
-	 */
-	int (*opendir)(const char *filename, struct fs_dir_stream **dirsp);
-	/*
-	 * Read next entry from directory stream.  On success return 0
-	 * and directory entry pointer via 'dentp'.  On error return
-	 * -errno.  See fs_readdir().
-	 */
-	int (*readdir)(struct fs_dir_stream *dirs, struct fs_dirent **dentp);
-	/* see fs_closedir() */
-	void (*closedir)(struct fs_dir_stream *dirs);
-	int (*unlink)(const char *filename);
-	int (*mkdir)(const char *dirname);
-	int (*ln)(const char *filename, const char *target);
-	int (*rename)(const char *old_path, const char *new_path);
-};
-
 static struct fstype_info fstypes[] = {
 #if CONFIG_IS_ENABLED(FS_FAT)
 	{
-- 
2.55.0


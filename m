Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E087BCA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88B9A60678;
	Mon, 12 Oct 2026 14:01:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QHRHtmaTS9-D; Mon, 12 Oct 2026 14:01:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8199260607
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813681;
	b=r8sgT3mJXpOPEt7gECWIfoYg0Ihl7DGSKPTCwJzFHZsucVh70r/twttdLTX0aqZAGgLO
	 qgKGt4uaNAu7tQUgh7G4U70SwHLDLGEQ6kt+d+Fvur5kHhcSZWC09sztyo2+mrembWxa9
	 JYyS+Ent1i6ZCvQzIZV2Un5RvWao8BBEb9aJFZSuB6lKvudWQObgIu4DRAXRgStgcDPWx
	 124+mvZgVkHLlGHkiNT124hPsZ8g4X5CdiIWBx4QQsL82QEMiX2M6eBoH40CxLaKhwciK
	 RxH8IyYB/YyaM5B3kw0Op7hy2dIMoKYLHP0l0ADQTtNJYp0zTUZ95E+lMsjMSE8IEKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813681;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QOsDFRp3TKDVFxqmB41q8YobI+Hs1Pby8cBb0RwFczE=;
	b=Fo1X7Cvv8MZUJGfEX3+u/EDIwvh0MfqdaYCP3WMyuVT1HPc4lDDuv6+fLTRPQT553cHU
	 fdIoj2Xi92lVl5yvoaSbNZf1osrn7yk5V/6+fjHyGw7W1xzrX6i3VPrmNLDM2CPjJfo8d
	 th9TwoOep21JOkLrZceVSvZeyibD3gCgZEJPLuJ/nTFBRlfGfW8KCo/4k1v3Q3eLZoJz+
	 ptQUHXYEELxEQyeQVP2FnttPO7oFRLgXOL01znHrpZxvYK1irzTSAQUKNZwbzssSVZHMz
	 MPuUVXzG7wkSvCFbsU88Ik1KxhaPSfMuc5Syh11rKwS6Q0PFlN11bq9o3w399MzTmbQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813681;
	bh=QOsDFRp3TKDVFxqmB41q8YobI+Hs1Pby8cBb0RwFczE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EqIdYiAkBG9pbU5uxYSmLL2W9iuprxs3wP1pvSxBrGBZOijwRe4X735ZyVHXEe8mr
	 A1YRl3bDNxfKGw469jk/ziSYRrGgDNIb0DY3Jf1mnbZJ58Ebq4rAgH20PKbTG2BQNr
	 IEuf5Y0p2FUCb2CT25y4G5uWV+Q5+ZRnTW0vzlRDtwmSRCeZtOvlNAiJMKd4lrrtkU
	 xZ+jLwoqI27PqZLMYcLu2LS21sK1Sk7JmRgzIB9muvrc8Z1Iv7LZk7WaNhILk3pU+t
	 +WPbrOlEsgQAfW3R/bIksixyQGAmnvEtLdc6faEle75F4oiZlX/cHlkv0429JqXgkf
	 rHkjHuLO8l73A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8199260607;
	Mon, 12 Oct 2026 14:01:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4439F179
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B16B4010F
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kwDy_A8yoBza for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:01:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 94DD74004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791813678;
 b=hGCFCaRy6fQDEge36jRpVfPf2F3PnjfDvHW4Z6pAPieBYFGgGsCH4E9Rcc7vGNiFloeT
 IzQubmqR7wacW890Fx3SZSbtoUemKxY9OhN56R9upEfZUDETEJokeUQ0gSr6UlXUPL+IN
 mZyYRspddGhrEnG+dLV4ICXbrf4xcW41ihUOl8FUIZyOlDfky5JQgXSFMyqDrGgNgaci6
 qXCcFgii5Dp0+nalHZxX+nNGSoVTYtufo0mXxbCri9VRVVG9dI8jdtOVWjuXnoNsRb5bt
 nSuh10Ztc/Z66T0/uCLtNOiorm/lFVkmm2gtQB11JkwhjHvGJ7fTXSqzgJj6CNq4OWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813678;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=QOsDFRp3TKDVFxqmB41q8YobI+Hs1Pby8cBb0RwFczE=;
 b=TSVNtNYehpuCcP9h6imx11pxKFuq8uSbn0W3+2OT7j4CPysTwdxTd6HmYaBP1qXxcZmb
 s//F0sIsZ5LaHzflANpeD3qx6C3ZJavQDlG/SoPeIbk7GVspgJLMOyimH1+1/JPGcW/44
 nVPwwjq0MOyk2vrVF//Y8E1wyexvtQrT+hTWLbMueidYLhaalnpDK9SWgcyYLAKGUxi01
 +Td3BYsoUXNdEdJX3Rygvdh2hjrgc7u3DowA7hkHzUBNg0leNpfiSr4DZ4kBj9iSKtJp1
 HyFXTaYzI/dwdjRYSAV2QJBghUNkcsAmkP7JZTl6/RMTRq3S2oTNz0pt5sYVAwQPeNA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=RN7KpRzQ; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=RN7KpRzQ
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 94DD74004D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:17 +0000 (UTC)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C89203F323
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791813674;
 bh=QOsDFRp3TKDVFxqmB41q8YobI+Hs1Pby8cBb0RwFczE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=RN7KpRzQhnZ+eKPsKm9XE3z0ZeU3sPGci3Ay/O2oxP1bNKoASRa4e9aF1cy1hAOHg
 WbtqCNBYHV1havsCfQlB6xxSHO8mkcUrPtUgfohYYSHle62Uhc5JNmqynznY9+lnmw
 kHeWIIyFkpqolHT9QP+1+QRk4FpswP6nDgA9AroVF44FXhw1ZFc9TS92mfzEqEzwt5
 Gc+79wdnCq24mCkrE8N2JgMpRsyfAti6njigMlDx9yKmU0fm9ODPS9LkL0af43RF7y
 7Uh7r5eAhPSGXWuCAPvqKzTDnaokbcqSou56//Ej2NpfbaG2xUtadI+90PHDr+9zSj
 lvoNWP6Qwe/SbCAylwRc69mfPCSTVf5ie4c9VZ3g0HVOf5049uWqK27D5/Q/ATDeWF
 k9j1Q4q8/kOXj/3xji7lFSxEbib7qTvryhISfRvXNDUdM1RogOGRrLunt+7GWvXkjy
 C2W05rfTnbSMuti24K0tLBdkiMG5weN5We+HCyFarSicykwoAthZhAMUE5eUnIeGW4
 aOA/JszFHFhvY+bnqPUrOUXCUwGqjc8K3eo6tdp+nF3vujGHO2zCH3AQ2JuYB8CbBN
 TkKGYCQOoQtSa9y7gPU0GImOZKC1NDba2RHopA3PTDjMrKhlo4yGfHeN+op6Ja0EnR
 ntOQFIe21+cQKK0SxkgcIBgM=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a019d53f46so15471725e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813674; x=1792418474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QOsDFRp3TKDVFxqmB41q8YobI+Hs1Pby8cBb0RwFczE=;
 b=qS7A1/Zhr/VzpZlDfjydM7YFVMX3ndeoUixkI0PhXTdb7fITWT48G95b4skf8sN1ny
 rYrbyvMZBdUmT4f2tFdVAGnAZefX+K/TBDPMcZ9oZ3Lq6ZtE5DU7VWBbKz+aknuEEmn6
 7HHzabT2PY12BN13x3OBaXcdpBYKmvtXQnjulZxZ5t4DiVEtqd3ZB2+CUh2SoGXwmy7D
 JGiLlVL6gm9HodinPQORoJOV/ghjYmwgtJu/1TvB6un7VB7FjiPlDai+GJrICI+VcWY6
 aeLrRvLRcP0/VsHKvIuD1E1BFAmHWYEyEEsmRmA2Hs1cy6gsZYrhAjaqOdDxpJ8VBoFU
 rN3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfFzl6ymGnkdfWsek82kJPcTiViwyx1jQ+Pd1OB7/H7xpo9rk8Q/9LnUwAm+3EojyzS3tVGaw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIxCbR4Cr8mPXo3NXEBQzRdDj5bEhun3aAWaufDDbbFZcisrdcs
 B/gEvA4HO3CCsZFYIwnDHEzU0Iio8kQCHEepEOlH9MAFuVkFzk1i1aasX84Fhr2X9LK8vvYc2Mb
 nnaODqPNf91YdYv9UkJdaym0KMV1Ttl1XxC9iQqEVSQDjUD9oJozTEUzA9ON9lDPB6qNAma+jV1
 hJAxahwZFj4w==
X-Gm-Gg: AYBFou2njj+WcPpjdO48I4S6UIJZKsFYepZqkHomPLsSEBB1hh5NymV+F18TsUja9Vt
 0t8dfOylaEIDRrxhvGF4hfoocFmDvwMH6lgeFfX5SL4FyQpGEcFsqQ6HqwX8aE7XDDhbP30Soaq
 53WK1Fze4j9HLaWkuMm69JiBRwfKMwTVo7mqcvTX7rBJmn66zoiqPBAAP5GHElVKz4+KhDqdv2O
 GI0kWBWd8fIgxx/szqfAh3aKEurVQA1x8mdxS7lt1TNMiYhdEnhD4E0RtSKcOYbfuGmowMZItRJ
 K2aJxztfGZI/YzDRGAMScFaS/9PPjUNKrSst/YpmV6V+EdXngWXiaak7TL/Nlq25tbPjTxVbjGG
 vab1KXtGF1x6gaRCRmFDUPz40n+HqB7hKkfrvv66Omas6uv6QwvCMOvc=
X-Received: by 2002:a05:600c:3b98:b0:499:79b9:e220 with SMTP id
 5b1f17b1804b1-4a18e49886amr207510615e9.10.1791813674038; 
 Mon, 12 Oct 2026 07:01:14 -0700 (PDT)
X-Received: by 2002:a05:600c:3b98:b0:499:79b9:e220 with SMTP id
 5b1f17b1804b1-4a18e49886amr207509665e9.10.1791813673443; 
 Mon, 12 Oct 2026 07:01:13 -0700 (PDT)
Received: from workstation5 ([2a02:908:1242:30e0:468d:767c:32e6:22fa])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf15691sm284551015e9.6.2026.10.12.07.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:01:11 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Daniel Munic <v-dmunic@microsoft.com>, Tony Dinh <mibodhi@gmail.com>,
 Alexey Charkov <alchark@flipper.net>, Vincent Jardin <vjardin@free.fr>,
 joaomarcos.costa@bootlin.com, Aristo Chen <aristo.chen@canonical.com>,
 u-boot@lists.u-boot-project.org, linux-erofs@lists.ozlabs.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/9] fs: print change date in directory listing for FAT
Date: Mon, 12 Oct 2026 16:00:41 +0200
Message-ID: <20261012140048.214059-3-heinrich.schuchardt@canonical.com>
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

fs_ls_generic() displays file sizes but no timestamps. The FAT
filesystem stores a change date in every directory entry and already
populates fs_dirent::change_time in fat_readdir(). Print the date
alongside the file size for filesystems that provide it.

Add a u32 capability bitmap (caps) to struct fstype_info. Each bit
documents a property that the filesystem's readdir() implementation
guarantees:

  FS_CAP_DATE  BIT(0)  change_time in fs_dirent is valid

fs_ls_generic() tests FS_CAP_DATE once before the loop to select a
consistent output format for the entire listing:

  12345678  2024-03-15 09:30  filename.txt    (FAT)
  12345678   filename.txt                     (ext4, squashfs, ...)

Set FS_CAP_DATE for FAT. fat2rtc() loses the __maybe_unused annotation
since it is now called unconditionally outside XPL builds. The attr,
create_time, change_time, and access_time fields that were previously
only populated under CONFIG_EFI_LOADER are now populated whenever
CONFIG_XPL_BUILD is not set.

Extending the feature to another filesystem requires only adding
.caps = FS_CAP_DATE to its fstype_info entry and ensuring its readdir()
fills in fs_dirent::change_time.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/fat/fat.c |  2 +-
 fs/fs.c      | 38 +++++++++++++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index c1ccf30771a..7443f5952af 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -1539,7 +1539,7 @@ int fat_readdir(struct fs_dir_stream *dirs, struct fs_dirent **dentp)
 
 	memset(dent, 0, sizeof(*dent));
 	strcpy(dent->name, dir->itr.name);
-	if (CONFIG_IS_ENABLED(EFI_LOADER)) {
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
 		dent->attr = dir->itr.dent->attr;
 		fat2rtc(le16_to_cpu(dir->itr.dent->cdate),
 			le16_to_cpu(dir->itr.dent->ctime), &dent->create_time);
diff --git a/fs/fs.c b/fs/fs.c
index b647b1cc103..ad577c475f5 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -39,6 +39,11 @@ static int fs_dev_part;
 static struct disk_partition fs_partition;
 static int fs_type = FS_TYPE_ANY;
 
+/*/
+ * define FS_CAP_DATE - readdir() populates fs_dirent::change_time
+ */
+#define FS_CAP_DATE	BIT(0)
+
 struct fstype_info {
 	int fstype;
 	char *name;
@@ -51,6 +56,10 @@ struct fstype_info {
 	 * filesystem.
 	 */
 	bool null_dev_desc_ok;
+#if !IS_ENABLED(CONFIG_XPL_BUILD)
+	/* Capability flags (FS_CAP_*) */
+	u32 caps;
+#endif
 	int (*probe)(struct blk_desc *fs_dev_desc,
 		     struct disk_partition *fs_partition);
 	int (*ls)(const char *dirname);
@@ -99,10 +108,19 @@ static inline int fs_ls_unsupported(const char *dirname)
 	return -1;
 }
 
+/* Forward declaration - defined after fstypes[] */
+static struct fstype_info *fs_get_info(int fstype);
+
 /* generic implementation of ls in terms of opendir/readdir/closedir */
 __maybe_unused
 static int fs_ls_generic(const char *dirname)
 {
+#if !IS_ENABLED(CONFIG_XPL_BUILD)
+	struct fstype_info *info = fs_get_info(fs_type);
+	bool has_date = !!(info->caps & FS_CAP_DATE);
+#else
+	bool has_date = false;
+#endif
 	struct fs_dir_stream *dirs;
 	struct fs_dirent *dent;
 	int nfiles = 0, ndirs = 0;
@@ -113,15 +131,26 @@ static int fs_ls_generic(const char *dirname)
 
 	while ((dent = fs_readdir(dirs))) {
 		if (dent->type == FS_DT_DIR) {
-			printf("            %s/\n", dent->name);
+			printf("          ");
 			ndirs++;
 		} else if (dent->type == FS_DT_LNK) {
-			printf("    <SYM>   %s\n", dent->name);
+			printf("    <SYM> ");
 			nfiles++;
 		} else {
-			printf(" %8lld   %s\n", dent->size, dent->name);
+			printf(" %8lld ", dent->size);
 			nfiles++;
 		}
+		if (has_date)
+			printf("%04d-%02d-%02d %02d:%02d ",
+			       dent->change_time.tm_year,
+			       dent->change_time.tm_mon,
+			       dent->change_time.tm_mday,
+			       dent->change_time.tm_hour,
+			       dent->change_time.tm_min);
+		if (dent->type == FS_DT_DIR)
+			printf("%s/\n", dent->name);
+		else
+			printf("%s\n", dent->name);
 	}
 
 	fs_closedir(dirs);
@@ -197,6 +226,9 @@ static struct fstype_info fstypes[] = {
 		.fstype = FS_TYPE_FAT,
 		.name = "fat",
 		.null_dev_desc_ok = false,
+#if !IS_ENABLED(CONFIG_XPL_BUILD)
+		.caps = FS_CAP_DATE,
+#endif
 		.probe = fat_set_blk_dev,
 		.close = fat_close,
 		.ls = fs_ls_generic,
-- 
2.55.0


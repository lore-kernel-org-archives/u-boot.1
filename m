Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4E0606A328
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y/mOk4B0;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KT+R+y1h
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15A4D6083F;
	Tue,  3 Nov 2026 16:50:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DkXx8duTZPLJ; Tue,  3 Nov 2026 16:50:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 006D16084E
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793724630;
	b=MDsukwa926ueW2HsHXjofH4c+5oQsS/CWSjx3CIMI0SigGp8QJf5aFmOJqpo5WQEgxa4
	 GSehQQcv7ZsvvVKWRc9XsAnT2K2cmpl0FNymWzzgEP8+i58ZigpD6bfL1XPP0nBsI/doG
	 1q33uDi4V9hLX8BiYIheVL+ebm7vmhNLWU5qETd6lIHEcExG9w5rWVs4TVN4PSXjRynsc
	 F6iWRupWPkPNYSbkcGWhHuUwu296t04dqZ5P3QZJ2P1NMIrV8i+WNJSflW2pNNOxQuqPN
	 hRJMNuU+7v3yryXgt+ZGxJeztoMh5PRgGTwIzLhZXc4xgMyFIw9ed+5+FJMAs7bH4Ng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793724630;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BTN5zi4Yp8Iye7DUWUJf4R+HZqX6BmzFjNdhdxRjI9A=;
	b=ky1JUiO8ep3ntB3k8wQUD7/bEITE1v2QUgPyr4iP4E5NOalM9VmDux2os8GBavYR3nMJ
	 5DHsyPbi9dSj0+giYeFfcWjiX72AiSd22WM4FYqEohEnRdIuJCwJN0ZsiyVSs8YxIjtQO
	 2sqbeQVnrEi0Q4wfABpWcWcbNGRb3YYESRSK00LLedfnV4QcFmYzCuuRFONKnk9GWeKWS
	 Qmegw+fhFUnLzSIs9l++KsaT1tiuvwPRto7NkZ8a51V834jNzRo5g5z4Z5hDAQ8qPYcyo
	 ploeyuyqy4uBoxiG3fLtXi/EdPnKj1o/y522UrLofb0ABU5xF8rxBluOKMJAaP8MOsw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793724630;
	bh=BTN5zi4Yp8Iye7DUWUJf4R+HZqX6BmzFjNdhdxRjI9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y/mOk4B0fB7pmcw2WBUWce21+9VUAlRA5DRgY/bsMejR2M0McCjpSvvdQqmnLOSXT
	 JfBfkpDXgeyjG/fktghWyn23iuDnSuXddcpd28ZApkzKKc1srG+I0agx2PLDxJmsyd
	 yz7DaMDPS9qp6YLojkssncHrkprSW/Q3D2yzn1jvcWUoC1snbVKegDhDgHPXqkt7QN
	 PdTLiXz498qEO14yyiiQ7iOxw7dUQdDJbp/fhRwmi9y9vjBzJUwjqC7ZI9u2rHNlQZ
	 pSXK1/tOKk14eH5Iz+9KvEo6g9Ls7yRI1UNY2J2JE3JCjmZgzQDIWocElCAXLd7bWX
	 6nkn166FZ+F0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 006D16084E;
	Tue,  3 Nov 2026 16:50:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A71872AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 989C740748
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rUwXnvFuj6tS for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:50:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A3A644074E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793724626;
 b=m3xdC3FYTUznGIumZ/d+jwpG/KrBKezgWvVBRjbDEocx+c5Xnv6lFyN42NZa3r09IhmP
 Gjhx7lRO4TFcLLUEpdAH7IvLm4qV2haqKgc59gzVd/LYQf9oVqIlt5k6Ku7NvPn/BCGkB
 iQ7iZuYnrfoho6Z9Rofk5//3yyVpdhsyrU1PgIZs3L9MDShtdmwO2N5SOH4MDXOSLKgHF
 qr/H0BGqWQ6azyG6RljWP7KI2A4vuxFisSv1R8E0gw+XuNuO0pNK0lfUtgEv/tAc+k2ea
 oa4GymfWxriOQq5xunx9dqMsQBh7r1vrelagIUnLh0QTmxOsys3+c0vqEMOg5mHaozw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793724626;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
 bh=BTN5zi4Yp8Iye7DUWUJf4R+HZqX6BmzFjNdhdxRjI9A=;
 b=LwPuUlLl54saUO80sk5xhv/HvEFRd06+ZrlWVBdV8d7eZm9XBjsJHPfJi7UYIrqu4uKM
 GN5hk4CwI2PpJjxruJaXrSrQCC3DVXQPyooiZov67wSyitjku7/ErNyTP0U1NScEYlm8C
 sFlscoFN0oBqb2focZf/TMebffxqTQZiVRnbj3Polp//mzHrzcgJK/51LCCFhhZ/WGmcY
 Hq9LTrhp2p1TE2wlO19+GTbv7rrquETJX4Xjkpf0rw96JMwwZGKROOb6Fd7ULeFeM5G8V
 0nA/RCXUeTAzRggwzS9o+bMi4JlcTMqVa3vNKpkJgjXivaEa23aeBhaPkHBNeLEwHbw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 spf=fail smtp.mailfrom=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=KT+R+y1h; 
 arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=wpopov@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=KT+R+y1h
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A3A644074E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:25 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AEB784823; Tue,  3 Nov 2026 17:50:23 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4F6E84828
 for <u-boot@lists.denx.de>; Tue,  3 Nov 2026 17:50:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wpopov@gmail.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8b06c0794cfso40885537b3.0
 for <u-boot@lists.denx.de>; Tue, 03 Nov 2026 08:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793724614; x=1794329414; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BTN5zi4Yp8Iye7DUWUJf4R+HZqX6BmzFjNdhdxRjI9A=;
 b=KT+R+y1hrw41BPmwdE5Jnt7iP1k3Fse375nLZyNZya2H4KxxNf3S6ZKSWQTm7iJjeH
 vOS4OKEg9klYg0I+vDrRX/HFdruGbRvLIadXBb3iOpZs3N17x8hixD+Kah5S6iExqkbN
 YWrIb3S0MqSZ3hSz12KnVjCOFFYPdLq1OGGqcpITv8BcfEEjhZ11Dp8YEwN8ITMV2WRH
 QPltyVlrVqZ/5ko88TRcVt14XtPaamzvXqrF2imMlRar9jYl7s6TU6QyW8KFeDNaG906
 +yby4cszn8PRrRT3UIiw5RmlLoC3P5phkSF7ynUi1DTI6I+Hg6jJaTqSx1Fbwl0Ct3Wh
 ue7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793724614; x=1794329414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BTN5zi4Yp8Iye7DUWUJf4R+HZqX6BmzFjNdhdxRjI9A=;
 b=Ml30vtOAxjIl1pJPtoojRV87NBAwIdQ0g+bwNuMn/tg+cVZiN0EMPp5y9HSaqjsIhi
 ccWxpok425i6NlD053nUJJZf+bvuZCHGlMjoFqCIstifwsnkc84J5rSocmrHyCF2Wemi
 8d+V2nLx6HzdwYUwLKCTpc4rI1ozoATqgeeyGIXk43e+lU1bI5lpWPVXo6NK37gJfEE3
 /K31sWGcyKoZ1fZ2/3q9qOwfGejWieT+rG4IsXYhHgUxTfH/TC2DlXkAXYdd/KVkOFUY
 CsYOZWcVKa8qcRzHYCz1GwlCZwWwgfYjSoND/pE6+ieDL9op7xKNaWkf+WOW54ofyQgo
 RKWg==
X-Gm-Message-State: APuU4Z8G2M7yKRPXpMGd7p3TNwsgMks/M6a7lRXwRblRNu3wmAvsPkUU
 aPGjYCdFePCSkQF8QG5jJzOrS633vgeSTulG2Yc7X80OL45zT5XQHN/mDK6jnUQt
X-Gm-Gg: AYBFou0tKTFgCfA8McbfAWjg2ih3fQoTJh/Wfh9uDZo3ZveemakccsBZnrJse9Zvq5Y
 t8wHVDcEoP2cSUui7pDCcsIQK8vRKB0A1SoS+eVTieo/TEGnj5m/75vWz74Si3yg9VF5a00bGSU
 6CGMKoX/YsCyDcv1kvn5CFdES9frbM2Syy/0mrzuROw9TIkI/v28iaze7GzSIJl2ZhOC9OByWAa
 AkOwDoTrthY03u8xm9q2T+P9lp+upQFG8cJmNo1jM2lXICGlhSXl9HbWkzn9Q9dKOnHt0w8pAvP
 iB5Rh0sPC9WVe5t9C/PiDgUROJjcffeMcy0HFRdVvsdGnkjQPozwMs+s2YwC2LIj52Bnjn5y+1s
 Vaof9sWofrS4vCPXP7O9+1Fmtzi768eC360xkZbta/YYxMDdLhegSp6hyE+tCrGlMu9feh9juFO
 fab4/+aAi7wCjwFrB4JKPsblbOsVWn3MkYx9jtrddoo/s2dUjfHW8r7IVzu2911yF09eUbJZ/Wa
 eu9BKATI1YRdDyNPtEswjeYgDGJcHVS8+6NBNfxHgJUqP85cAxDoyzbFyJXnKIsCYsuby2qp6O3
 QwaJ3LOuFTRdhkfZIL44woZkhpl7Fp6jXoU206TQ5taejcpNDqR5l8DPkw==
X-Received: by 2002:a05:690e:138e:b0:679:b1f8:72da with SMTP id
 956f58d0204a3-67ba4fa145fmr9671737d50.18.1793724614461; 
 Tue, 03 Nov 2026 08:50:14 -0800 (PST)
Received: from ABELHA2618-VM-UBUNTU.autotrac.corp ([177.174.221.194])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67be800b325sm440329d50.0.2026.11.03.08.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:50:13 -0800 (PST)
From: Wagner Popov dos Santos <wpopov@gmail.com>
To: u-boot@lists.denx.de
Cc: wpopov@gmail.com
Subject: [PATCH 6/7] fs: jffs2: cache directory metadata during one-pass scans
Date: Tue,  3 Nov 2026 13:49:52 -0300
Message-ID: <4e314d1b1f832e5161b5a013addf79884c7c5f9a.1793724561.git.wpopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793724561.git.wpopov@gmail.com>
References: <cover.1793724561.git.wpopov@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_NONE,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Intern directory entry names in a configurable hash table during full
and summary-based scans. Allocate names from 10 KiB pools and cache
inode numbers, parent inode numbers, and name pointers.

Use cached metadata for lookup, sorting, and listing. Group sorted
versions by interned-name pointer equality, while preserving raw dirent
comparisons when names are not cached and checking deletion after
selecting the latest entry.

Add Kconfig options for the cache and hash width, document remaining
reads and memory costs, and free the name pools with the filesystem
cache.

Signed-off-by: Wagner Popov dos Santos <wpopov@gmail.com>
---
 fs/jffs2/Kconfig         |  21 +++++
 fs/jffs2/jffs2_1pass.c   | 164 ++++++++++++++++++++++++++++++++++++++-
 fs/jffs2/jffs2_private.h |  30 +++++++
 3 files changed, 214 insertions(+), 1 deletion(-)

diff --git a/fs/jffs2/Kconfig b/fs/jffs2/Kconfig
index dede59ee336..2fe2ce96eae 100644
--- a/fs/jffs2/Kconfig
+++ b/fs/jffs2/Kconfig
@@ -30,3 +30,24 @@ config SYS_JFFS2_SORT_FRAGMENTS
 	  though.  Sorting is done while inserting into the fragment list,
 	  which is more or less a bubble sort. That algorithm is known to be
 	  O(n^2), thus you should really consider if you can avoid it!
+
+config JFFS2_CACHE_TO_SPEED_UP
+	bool "Enable JFFS2 extra cache to speed up sort, list and load"
+	depends on FS_JFFS2
+	help
+	  Cache JFFS2 directory entry names while building the filesystem
+	  lists. This reduces directory entry reads when sorting, listing or
+	  loading files, but listing still reads the selected directory entry
+	  nodes. Additional memory is used by the hash bucket array, name
+	  pools and extra metadata in each cached inode and directory entry.
+
+config JFFS2_CACHE_NAMES_HASH_WIDTH
+	int "Hash width for cached names"
+	depends on JFFS2_CACHE_TO_SPEED_UP
+	range 4 16
+	default 8
+	help
+	  Selects the number of bits used from the name CRC to select a hash
+	  bucket. The number of buckets is 2^value. With the value 16, the
+	  bucket array uses 256 KiB on 32-bit targets plus the blocks for the
+	  names.
diff --git a/fs/jffs2/jffs2_1pass.c b/fs/jffs2/jffs2_1pass.c
index 0021697c907..021c524f444 100644
--- a/fs/jffs2/jffs2_1pass.c
+++ b/fs/jffs2/jffs2_1pass.c
@@ -409,6 +409,79 @@ static inline void *get_node_mem_nor(u32 off, void *ext_buf)
 }
 #endif
 
+#ifdef CONFIG_JFFS2_CACHE_TO_SPEED_UP
+
+/*
+ * To avoid frequent small memory allocations, allocate memory in
+ * larger blocks.
+ */
+#define MEM_BLK_NAMES_SIZE   (10 * 1024)
+
+static void jffs2_cache_name_free(struct jffs2_name_cache *cache)
+{
+	struct jffs2_name_pool *pool, *next;
+
+	for (pool = cache->pools; pool; pool = next) {
+		next = pool->next;
+		free(pool);
+	}
+	cache->pools = NULL;
+	memset(cache->buckets, 0, sizeof(cache->buckets));
+}
+
+static void *jffs2_cache_name_alloc(struct jffs2_name_cache *cache, u32 size)
+{
+	struct jffs2_name_pool *pool = cache->pools;
+	void *ret;
+
+	if (size > MEM_BLK_NAMES_SIZE)
+		return NULL;
+
+	if (!pool || pool->remaining < size) {
+		pool = malloc(sizeof(*pool) + MEM_BLK_NAMES_SIZE);
+		if (!pool) {
+			printf("%s: Failed to allocate memory for name cache!\n",
+			       __func__);
+			return NULL;
+		}
+		pool->cur = (char *)(pool + 1);
+		pool->remaining = MEM_BLK_NAMES_SIZE;
+		pool->next = cache->pools;
+		cache->pools = pool;
+	}
+
+	ret = pool->cur;
+	pool->cur += size;
+	pool->remaining -= size;
+	return ret;
+}
+
+static const char *jffs2_cache_name_add(struct jffs2_name_cache *cache,
+					 u32 name_crc, const char *name, u8 len)
+{
+	struct jffs2_cached_name *cached;
+	const u32 bucket_idx = name_crc & (JFFS2_CACHE_NAME_BUCKETS - 1);
+	const u32 alloc_size = ALIGN(sizeof(*cached) + 1 + len, sizeof(uintptr_t));
+
+	for (cached = cache->buckets[bucket_idx]; cached;
+	     cached = cached->next) {
+		if (strlen(cached->name) == len)
+			if (!memcmp(cached->name, name, len))
+				return cached->name;
+	}
+
+	cached = jffs2_cache_name_alloc(cache, alloc_size);
+	if (!cached)
+		return NULL;
+
+	memcpy(cached->name, name, len);
+	cached->name[len] = '\0';
+	cached->next = cache->buckets[bucket_idx];
+	cache->buckets[bucket_idx] = cached;
+	return cached->name;
+}
+#endif
+
 /*
  * Generic jffs2 raw memory and node read routines.
  *
@@ -599,6 +672,25 @@ static int compare_dirents(struct b_node *new, struct b_node *old)
 	 * being read. This makes most comparisons much quicker as only one
 	 * or two entries from the node will be used most of the time.
 	 */
+#ifdef CONFIG_JFFS2_CACHE_TO_SPEED_UP
+	if (new->pino != old->pino) {
+		/* ascending sort by pino */
+		return new->pino > old->pino;
+	}
+
+	if (new->name && old->name) {
+		size_t new_len = strlen(new->name);
+		size_t old_len = strlen(old->name);
+
+		if (new_len != old_len)
+			return new_len > old_len;
+		if (new->name != old->name)
+			return strcmp(new->name, old->name) > 0;
+
+		/* Duplicate names are sorted by ascending version. */
+		return new->version > old->version;
+	}
+#endif
 	struct jffs2_raw_dirent *jNew = get_node_mem(new->offset, NULL);
 	struct jffs2_raw_dirent *jOld = get_node_mem(old->offset, NULL);
 	int cmp;
@@ -659,6 +751,9 @@ jffs2_free_cache(struct part_info *part)
 		pL = (struct b_lists *)part->jffs2_priv;
 		free_nodes(&pL->frag);
 		free_nodes(&pL->dir);
+#ifdef CONFIG_JFFS2_CACHE_TO_SPEED_UP
+		jffs2_cache_name_free(&pL->names);
+#endif
 		free(pL->readbuf);
 		free(pL);
 		part->jffs2_priv = NULL;
@@ -857,6 +952,20 @@ jffs2_1pass_find_inode(struct b_lists * pL, const char *name, u32 pino)
 	counter = 0;
 	/* we need to search all and return the inode with the highest version */
 	for(b = pL->dir.listHead; b; b = b->next, counter++) {
+		if (b->pino != pino)
+			continue;
+#ifdef CONFIG_JFFS2_CACHE_TO_SPEED_UP
+		if (b->name) {
+			if (strcmp(b->name, name) != 0)
+				continue;
+			if (b->version < version)
+				continue;
+			inode = b->ino;
+			version = b->version;
+			continue;
+		}
+#endif
+
 		jDir = (struct jffs2_raw_dirent *) get_node_mem(b->offset,
 								pL->readbuf);
 		if (!jDir) {
@@ -988,7 +1097,17 @@ jffs2_1pass_list_inodes(struct b_lists * pL, u32 pino)
 			int i_offset = -1;
 			struct jffs2_raw_inode *jNode = NULL;
 			struct b_node *b2;
-
+#if defined(CONFIG_JFFS2_CACHE_TO_SPEED_UP) && \
+	defined(CONFIG_SYS_JFFS2_SORT_FRAGMENTS)
+			struct b_node *next;
+			for (next = b->next; next; next = b->next) {
+				if (b->name && next->pino == pino &&
+				    next->name == b->name)
+					b = next;
+				else
+					break;
+			}
+#endif
 			jDir = (struct jffs2_raw_dirent *)
 				get_node_mem(b->offset, pL->readbuf);
 			if (!jDir) {
@@ -1004,6 +1123,12 @@ jffs2_1pass_list_inodes(struct b_lists * pL, u32 pino)
 				struct jffs2_raw_dirent *jDirNext;
 				if (!next)
 					break;
+#ifdef CONFIG_JFFS2_CACHE_TO_SPEED_UP
+				if (b->name && next->name &&
+				    (next->pino != pino ||
+				     next->name != b->name))
+					break;
+#endif
 				jDirNext = (struct jffs2_raw_dirent *)
 					get_node_mem(next->offset, NULL);
 				if (!jDirNext) {
@@ -1143,6 +1268,13 @@ jffs2_1pass_resolve_inode(struct b_lists * pL, u32 ino)
 
 	/* we need to search all and return the inode with the highest version */
 	for(b = pL->dir.listHead; b; b = b->next) {
+#ifdef CONFIG_JFFS2_CACHE_TO_SPEED_UP
+		if (b->ino != ino)
+			continue;
+		if (b->version < version)
+			continue;
+#endif
+
 		jDir = (struct jffs2_raw_dirent *) get_node_mem(b->offset,
 								pL->readbuf);
 		if (!jDir) {
@@ -1369,6 +1501,10 @@ static int jffs2_sum_process_sum_data(struct part_info *part, uint32_t offset,
 						b->ino = sum_get_unaligned32(
 							&spi->inode);
 						b->datacrc = CRC_UNKNOWN;
+#ifdef CONFIG_JFFS2_CACHE_TO_SPEED_UP
+						b->pino = 0;
+						b->name = NULL;
+#endif
 					}
 
 					sp += JFFS2_SUMMARY_INODE_SIZE;
@@ -1377,6 +1513,10 @@ static int jffs2_sum_process_sum_data(struct part_info *part, uint32_t offset,
 				}
 				case JFFS2_NODETYPE_DIRENT: {
 					struct jffs2_sum_dirent_flash *spd;
+	#ifdef CONFIG_JFFS2_CACHE_TO_SPEED_UP
+					u32 name_crc;
+	#endif
+
 					spd = sp;
 					if (pass) {
 						b = insert_node(&pL->dir);
@@ -1390,6 +1530,17 @@ static int jffs2_sum_process_sum_data(struct part_info *part, uint32_t offset,
 							&spd->version);
 						b->pino = sum_get_unaligned32(
 							&spd->pino);
+#ifdef CONFIG_JFFS2_CACHE_TO_SPEED_UP
+						b->ino = sum_get_unaligned32(
+							&spd->ino);
+						name_crc = crc32_no_comp(0,
+							(const unsigned char *)spd->name,
+							spd->nsize);
+						b->name = jffs2_cache_name_add(
+							&pL->names, name_crc,
+							(const char *)spd->name,
+							spd->nsize);
+#endif
 						b->datacrc = CRC_UNKNOWN;
 					}
 
@@ -1812,6 +1963,10 @@ jffs2_1pass_build_lists(struct part_info * part)
 				b->version = node->i.version;
 				b->ino = node->i.ino;
 				b->datacrc = CRC_UNKNOWN;
+#ifdef CONFIG_JFFS2_CACHE_TO_SPEED_UP
+				b->name = NULL;
+				b->pino = 0;
+#endif
 				if (max_totlen < node->u.totlen)
 					max_totlen = node->u.totlen;
 				break;
@@ -1851,6 +2006,13 @@ jffs2_1pass_build_lists(struct part_info * part)
 				b->version = node->d.version;
 				b->pino = node->d.pino;
 				b->datacrc = CRC_UNKNOWN;
+#ifdef CONFIG_JFFS2_CACHE_TO_SPEED_UP
+				b->ino = node->d.ino;
+				b->name = jffs2_cache_name_add(&pL->names,
+								node->d.name_crc,
+								(const char *)node->d.name,
+								node->d.nsize);
+#endif
 				if (max_totlen < node->u.totlen)
 					max_totlen = node->u.totlen;
 				counterN++;
diff --git a/fs/jffs2/jffs2_private.h b/fs/jffs2/jffs2_private.h
index 9284ab5c2c1..fcde1b9e54f 100644
--- a/fs/jffs2/jffs2_private.h
+++ b/fs/jffs2/jffs2_private.h
@@ -8,12 +8,39 @@ struct b_node {
 	struct b_node *next;
 	enum { CRC_UNKNOWN = 0, CRC_OK, CRC_BAD } datacrc;
 	u32 version;
+#ifdef CONFIG_JFFS2_CACHE_TO_SPEED_UP
+	u32 ino; /* for inodes and dirents */
+	u32 pino; /* for dirents */
+	const char *name; /* for dirents */
+#else
 	union {
 		u32 ino; /* for inodes */
 		u32 pino; /* for dirents */
 	};
+#endif
+};
+
+#ifdef CONFIG_JFFS2_CACHE_TO_SPEED_UP
+#define JFFS2_CACHE_NAME_BUCKETS \
+	(1U << CONFIG_JFFS2_CACHE_NAMES_HASH_WIDTH)
+
+struct jffs2_name_pool {
+	struct jffs2_name_pool *next;
+	char *cur;
+	u32 remaining;
 };
 
+struct jffs2_cached_name {
+	struct jffs2_cached_name *next;
+	char name[];
+};
+
+struct jffs2_name_cache {
+	struct jffs2_name_pool *pools;
+	struct jffs2_cached_name *buckets[JFFS2_CACHE_NAME_BUCKETS];
+};
+#endif
+
 struct b_list {
 	struct b_node *listTail;
 	struct b_node *listHead;
@@ -29,6 +56,9 @@ struct b_list {
 struct b_lists {
 	struct b_list dir;
 	struct b_list frag;
+#ifdef CONFIG_JFFS2_CACHE_TO_SPEED_UP
+	struct jffs2_name_cache names;
+#endif
 	void *readbuf;
 };
 
-- 
2.43.0


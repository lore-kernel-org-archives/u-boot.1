Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501BEC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:48:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35F6684C12;
	Wed,  1 Jul 2026 13:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ibjm9e8u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F083884BE4; Wed,  1 Jul 2026 13:47:16 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B293B84BBD
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-495c49f8eccso441087b6e.3
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 04:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782906433; x=1783511233; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pu5jERnP0TgQJ8vaZk5pjbcFE79VUPusRm4VcTIIZq8=;
 b=ibjm9e8ubU7LkCdZyncQN4qYpqiPxzKxet/ZvI3TvcoUxRnR3NMRg72i4m5+EBzFg7
 /VwM7wekKymJszuPUS07bR8kSTP+aNT6L76g8ErcwFrWpdag4TINiRTN0+DPMQuYWGB3
 Qup1IRZgcEwYArm3KNxnSIMsXY53obnLZY+RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782906433; x=1783511233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pu5jERnP0TgQJ8vaZk5pjbcFE79VUPusRm4VcTIIZq8=;
 b=DW2q+Wh9GEfrg7JTUZdf0tP1OCAYaet/65/JsWa8M7s/q94ZpARyFTMYzTYcQCjZif
 EGSwVpcNSZZY/jZHBUpszTJJYHfc3Ya7Lah72MomDd4MCVl9mk80rBu1LdFONbMq3rN5
 IauDEv+g99YbJ/Fi4j9L8h3d2RlrIwSs7/B+s5eYMl3PvB1PqOxTlnSfrprnLguQsSLf
 e7XQDOq047/Uugm2XtGtV+lA2+HfedihwHFyii+NUgfJwN6XHiuesi/4QEBuzcKXAkbF
 xnrh2QcbYAUVuNYP3j0cVy3q03APXzoF1rpRQdmLfCiwlQWQSK7xyOvjhLJboaqj3D8J
 nkLQ==
X-Gm-Message-State: AOJu0Yz5p6tm3cLGIJ7b/ENY0nRnFlRbV/olEvGrYMrxshyhiZd2c4Ma
 /l660GmJfTfiEQ+F7FizRqJwKLCUgLkrLZJFnyblao2Eaz32tHtsj/hzJXegDxVW2H5Lms+3HLR
 nWtE=
X-Gm-Gg: AfdE7clNkXzO0kTLnJWyHkq47Wn5OoGUO4l+UETRDOsKPTNBpAUMO9oYRLNf0F/8sR+
 Ya5pZNuIzbkVoMg6plyfXqdROlVKNwgtOpIY4xEZb6IvpJQJk+omSt4mRIj6fMXl4UK8dlNRnaC
 bFZ+5xsxWP4QksSdFi/Jq75Wwq55/AJKIN21LdXeXALEW809Ytxkj1p2QcnCgNflqExs8+7yOx4
 Bcg7aOiVhWyA2ipu5VsQyghMV8Tcbt5MemPlG7Ct8LaZQtx90BAtUn2oR+PH2psroGAMWtHAN7/
 6gH/t6xkLArK2b4zHv4jjR6v9QfSQV0Rovp9tQyjkdMZi7Me+bE0Ymae96sstLV4ALDACvpJ97/
 4cEZznpDiO856QC31zmvdf324vHUyxgxKiyzhT15TREwyHIEh5zD3so6zYXwRgIFaBxHnYW8BHV
 pflFtmCE8=
X-Received: by 2002:a05:6808:c3d2:b0:48f:d469:d035 with SMTP id
 5614622812f47-49636a2cdcbmr132704b6e.42.1782906433450; 
 Wed, 01 Jul 2026 04:47:13 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4960655e3e2sm1199823b6e.0.2026.07.01.04.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 04:47:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 07/14] hash: Drop unused cmdtp and flag args from
 hash_command()
Date: Wed,  1 Jul 2026 05:42:27 -0600
Message-ID: <20260701114248.1396125-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701114248.1396125-1-sjg@chromium.org>
References: <20260701114248.1396125-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

hash_command() takes a struct cmd_tbl pointer and the command flag but
uses neither; they are threaded through from each caller's command
function purely to satisfy the prototype. Drop both arguments so the
helper is independent of the command signature, which lets a caller
that no longer has cmdtp/flag to hand (a getopt-state command) call it
directly.

Update all callers: the hash, crc32, md5sum, sha1sum and sm3sum
commands.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/hash.c     | 2 +-
 cmd/md5sum.c   | 2 +-
 cmd/mem.c      | 2 +-
 cmd/sha1sum.c  | 2 +-
 cmd/sm3sum.c   | 2 +-
 common/hash.c  | 4 ++--
 include/hash.h | 6 ++----
 7 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/cmd/hash.c b/cmd/hash.c
index 96d0e443a5b..f4f1dcf02f9 100644
--- a/cmd/hash.c
+++ b/cmd/hash.c
@@ -41,7 +41,7 @@ static int do_hash(struct cmd_tbl *cmdtp, int flag, int argc,
 	argv++;
 	for (s = *argv; *s; s++)
 		*s = tolower(*s);
-	return hash_command(*argv, flags, cmdtp, flag, argc - 1, argv + 1);
+	return hash_command(*argv, flags, argc - 1, argv + 1);
 }
 
 U_BOOT_CMD(
diff --git a/cmd/md5sum.c b/cmd/md5sum.c
index ded3f9e1831..a96c0dc97b6 100644
--- a/cmd/md5sum.c
+++ b/cmd/md5sum.c
@@ -33,7 +33,7 @@ static int do_md5sum(struct cmd_tbl *cmdtp, int flag, int argc,
 		ac--;
 	}
 
-	return hash_command("md5", flags, cmdtp, flag, ac, av);
+	return hash_command("md5", flags, ac, av);
 }
 
 #if IS_ENABLED(CONFIG_MD5SUM_VERIFY)
diff --git a/cmd/mem.c b/cmd/mem.c
index 68eb6989b94..4a7629eba02 100644
--- a/cmd/mem.c
+++ b/cmd/mem.c
@@ -1263,7 +1263,7 @@ static int do_mem_crc(struct cmd_tbl *cmdtp, int flag, int argc,
 	}
 #endif
 
-	return hash_command("crc32", flags, cmdtp, flag, ac, av);
+	return hash_command("crc32", flags, ac, av);
 }
 
 #endif
diff --git a/cmd/sha1sum.c b/cmd/sha1sum.c
index f2757146bba..18cefb4bb03 100644
--- a/cmd/sha1sum.c
+++ b/cmd/sha1sum.c
@@ -31,7 +31,7 @@ int do_sha1sum(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	}
 #endif
 
-	return hash_command("sha1", flags, cmdtp, flag, ac, av);
+	return hash_command("sha1", flags, ac, av);
 }
 
 #ifdef CONFIG_SHA1SUM_VERIFY
diff --git a/cmd/sm3sum.c b/cmd/sm3sum.c
index 9044a322e22..7c59b7c8cab 100644
--- a/cmd/sm3sum.c
+++ b/cmd/sm3sum.c
@@ -28,7 +28,7 @@ static int do_sm3sum(struct cmd_tbl *cmdtp, int flag, int argc,
 		ac--;
 	}
 
-	return hash_command("sm3_256", flags, cmdtp, flag, ac, av);
+	return hash_command("sm3_256", flags, ac, av);
 }
 
 #if IS_ENABLED(CONFIG_SM3SUM_VERIFY)
diff --git a/common/hash.c b/common/hash.c
index 71c4bef5826..790fb2a5248 100644
--- a/common/hash.c
+++ b/common/hash.c
@@ -580,8 +580,8 @@ static void hash_show(struct hash_algo *algo, ulong addr, ulong len, uint8_t *ou
 		printf("%02x", output[i]);
 }
 
-int hash_command(const char *algo_name, int flags, struct cmd_tbl *cmdtp,
-		 int flag, int argc, char *const argv[])
+int hash_command(const char *algo_name, int flags, int argc,
+		 char *const argv[])
 {
 	ulong addr, len;
 
diff --git a/include/hash.h b/include/hash.h
index 8b3f79ec473..577875f321c 100644
--- a/include/hash.h
+++ b/include/hash.h
@@ -90,13 +90,11 @@ struct hash_algo {
  *
  * @algo_name:		Hash algorithm being used (lower case!)
  * @flags:		Flags value (HASH_FLAG_...)
- * @cmdtp:		Pointer to command table entry
- * @flag:		Some flags normally 0 (see CMD_FLAG_.. above)
  * @argc:		Number of arguments (arg 0 must be the command text)
  * @argv:		Arguments
  */
-int hash_command(const char *algo_name, int flags, struct cmd_tbl *cmdtp,
-		 int flag, int argc, char *const argv[]);
+int hash_command(const char *algo_name, int flags, int argc,
+		 char *const argv[]);
 
 /**
  * hash_block() - Hash a block according to the requested algorithm
-- 
2.43.0


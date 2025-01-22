Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739FFC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 13:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B899880934;
	Wed, 22 Jan 2025 14:22:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a77CZAMs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BF62801FB; Wed, 22 Jan 2025 06:33:57 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6640880137
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 06:33:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gabriel.dalimonte@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b9ad0e84e6so748188285a.0
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 21:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737524034; x=1738128834; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UgbxJ/qFGtM0KVIPQGV/9ZYfQxsZikBsEa20p5LYVi0=;
 b=a77CZAMsUkd2xO6LrzLle+Sc6yae0LUOvHmsACcsK/dVITOXs5CqSxomHSl7RoeJKJ
 odEUZ+2vASYSLTT+mUhv0vrosKQflhdJF+IHd+RIRd+KGsWqJDcOHgHRmdrTt9u5eR5w
 ZYeWohl/ywftha9eBRVyFIHJiooZlIdo3/WQVevQZL8WJlA2PnVuVP1CHGCihYUESvIu
 C8jcnbd0QuVh5XmGHgBicGwtDdvO/kQz0s0n92zzW1gWgIJzli8xpUrAfUNUgh+1iVPg
 6fIShdMRn3xVOqbyNokcVuWbBLZPVBxW2tKzhRa8sy5i2gD79hpcZXyANtRZ7CCZhug9
 9ECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737524034; x=1738128834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UgbxJ/qFGtM0KVIPQGV/9ZYfQxsZikBsEa20p5LYVi0=;
 b=U2l7Jr2FhisO6Ik10kI1bf+BjSkacKaOi1RdNoyRpKykauXDdqWWdcaMzay0EeWh28
 GPOMHdFKLeZcdljcAv8GPgOZ9ZvacbLZtfov3hgDV9I4+tSZZ0cg2kmG6EpxDE2O3PhB
 IWenlm/puQZwHSrcuj2uV/h45gom/tghsnwfCS/G2vqz69h1lUmD3ipeRxU3t29Nsp6u
 0kcynUosnPsWl9x/62YKZ3SEab2WntFAEVXAtbYIo5fh6mgGQdQPMKei3YftZTK6JHeF
 lwjEWOSVfr20QzRpOTG5eVlTrRNe3QEEygWQoGP0QqPsm2FuGgy/f4lUAg4b3DqYM5s7
 79qA==
X-Gm-Message-State: AOJu0YxXpRdiTAMFDXB/hUwvsWNQ7lNS/KZAGC6AuI/lR28oi/Z+0i2b
 N/D9KypQZr8/rdvC276b8wpwC8Y64S+Kawur+8HStzcjb+g5qeor0ymPyLGMLmo=
X-Gm-Gg: ASbGncv3hLFofM1exfAn+jfTQc96zoIPSF/DP8KuIEFzAT2zc567Dtl7clfh7jbKHll
 RXAZNm5+gSljXN9uyyQaNTM0kvCvY+w9qnQiCJ0PX2vaOmrUYWhuYhu1CL0yx5bWo+EG9hc8bTI
 f4F2dBy8BXV6xd8DkBdaFYn59ToRDxOM2aas2Ot3d1Q6YUwspfERszRn9xYvdp24gwEF5eBzuoO
 5YD206ZUKIrwi7V2JtCD0nVA1A9Bli0nZQX8KH5Y/LJu82cMiTro3kcw/tcOLkl+5P/poTeOtpe
 6MSEMopU3WkVu3i6QwfTol6daOeFK8+E0c+AOWGC4+b1C7oleY/zSWMkcir/ZJJJ5ENmyJXirRl
 hyUsVcSqIcxHc9GI=
X-Google-Smtp-Source: AGHT+IG360dI8G4cyThTWkdisbBMWlFICQX+RorcGTodIn4OzFF3Wj8ezzs6HaDHIAJEs1bGDrGbTw==
X-Received: by 2002:a05:620a:2986:b0:7b6:d23a:be39 with SMTP id
 af79cd13be357-7be63248fdcmr3124996385a.44.1737524033657; 
 Tue, 21 Jan 2025 21:33:53 -0800 (PST)
Received: from localhost.localdomain
 (bras-base-btfdon1720w-grc-54-174-88-143-14.dsl.bell.ca. [174.88.143.14])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614d98b2sm634136785a.76.2025.01.21.21.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 21:33:52 -0800 (PST)
From: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
To: u-boot@lists.denx.de
Cc: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/6] fs: fat: update parent dirs metadata on rename
Date: Wed, 22 Jan 2025 00:32:29 -0500
Message-Id: <20250122053232.17365-5-gabriel.dalimonte@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122053232.17365-1-gabriel.dalimonte@gmail.com>
References: <20250122053232.17365-1-gabriel.dalimonte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Jan 2025 14:22:36 +0100
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

None of the existing fat code appears to update parent dir properties
however, the POSIX specification for rename() mentions that the
last modified timestamp should be updated. In addition, I believe
the ATTR_ARCH attribute should also be reset on the parent directories
as the content of those directories has changed.

Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
---

 fs/fat/fat_write.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index f9f7051e30..2559e38d5b 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -1912,6 +1912,42 @@ exit:
 	return ret;
 }
 
+/**
+ * update_parent_dir_props - updates the modified time and resets the archive
+ * attribute for the parent directory
+ *
+ * @itr:	iterator positioned anywhere in a directory whose parent should be
+ *	updated
+ * @Return:	0 for success
+ */
+static int update_parent_dir_props(fat_itr *itr)
+{
+	int ret = 0;
+	__u32 target_clust = itr->start_clust;
+	/* For START macro */
+	fsdata *mydata = itr->fsdata;
+
+	if (!itr->is_root) {
+		ret = fat_itr_parent(itr);
+		if (ret)
+			return ret;
+
+		while (fat_itr_next(itr)) {
+			if (START(itr->dent) == target_clust)
+				goto update;
+		}
+
+		/* dent not found */
+		return -EIO;
+update:
+		dentry_set_time(itr->dent);
+		itr->dent->attr |= ATTR_ARCH;
+		ret = flush_dir(itr);
+	}
+
+	return ret;
+}
+
 /**
  * fat_rename - rename/move a file or directory
  *
@@ -2086,7 +2122,12 @@ int fat_rename(const char *old_path, const char *new_path)
 		ret = flush_dir(new_itr);
 		if (ret)
 			goto exit;
+		/* restore directory location to update parent props below */
+		fat_itr_child(new_itr, new_itr);
 	}
+	ret = update_parent_dir_props(new_itr);
+	if (ret)
+		goto exit;
 
 	/* refresh old in case write happened to the same block. */
 	ret = fat_move_to_cluster(old_itr, old_itr->dent_clust);
@@ -2097,6 +2138,7 @@ int fat_rename(const char *old_path, const char *new_path)
 	if (ret)
 		goto exit;
 
+	ret = update_parent_dir_props(old_itr);
 exit:
 	free(new_datablock.fatbuf);
 	free(old_datablock.fatbuf);
-- 
2.34.1


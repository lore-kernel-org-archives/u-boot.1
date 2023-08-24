Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C641AC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E485686A1A;
	Thu, 24 Aug 2023 21:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K2kpGgPt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2E2E86A1C; Thu, 24 Aug 2023 21:56:16 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47F198683C
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79264ca4b34so7681339f.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906971; x=1693511771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n389bQ7KBadWT8Z9VlJmeBPe80Ua8I0v8PZqB3oHE3M=;
 b=K2kpGgPtTKUBwXiUlt2Mfi4fnI0q/b/6Vr4UNoiRV2/wgMq8U+r6p5YMHJKBuyHdS6
 qNsMUGdCUB55lWkvZBPrzenIhtMdFr2MW/J2G7iKhzT1V3TlMXa3h5ohu65eiSx2Ar29
 OZvEM9UgRcZvsaUTsjI2xzZZhgYXVYQUZaNi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906971; x=1693511771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n389bQ7KBadWT8Z9VlJmeBPe80Ua8I0v8PZqB3oHE3M=;
 b=Ptehpv+fo8g0OTNbh6L16rdzHutYxIcSK0Gv4uge2ieeRsk7jdYM1y+mCdSDp/Ttcd
 JvPPB7tOFekiDf8eorKTq8Nc4AvOXHAMp0qEiUdaz+T3XAEU3AkdADN0OdZIm5AAc91Y
 ZBPuFGopVGDgl/buUYOAKZ67s5d2g1O0KDgiOn75EVLA0sm1n6Ir9n/3ag5vTySo+zPg
 aqO15cFrnU6ylEeiFyfKtXjuALz8ql0SMMD5SzCEV+IF4rse8LMfqTPOAZwpPoj6oD5U
 dcbSvutIg49TL/bRJ6ZxnfBWtZTLjF6aRkUxf8daddUVJtinyW3R9VrH6z8aCK651D/4
 kPvw==
X-Gm-Message-State: AOJu0YxG6M06cVYnLfsARxO+dwaI317mlzJ9RdFpq23aJ8BcGrQHw78V
 1yxHxTCwb0iBxb9MrHmXIF/zrAJQKj5NJVbXVXk=
X-Google-Smtp-Source: AGHT+IGoE4+iAdXqELaJhWN3ER1yFg2uKvOWLCZbQDvv+0yZCs28THKV2iKJ4nJcNmS/msEB3895hg==
X-Received: by 2002:a6b:d003:0:b0:786:ef34:1a6 with SMTP id
 x3-20020a6bd003000000b00786ef3401a6mr7292854ioa.7.1692906970847; 
 Thu, 24 Aug 2023 12:56:10 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 14/23] sandbox: Add a way to access persistent test files
Date: Thu, 24 Aug 2023 13:55:37 -0600
Message-ID: <20230824195553.1685996-15-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195553.1685996-1-sjg@chromium.org>
References: <20230824195553.1685996-1-sjg@chromium.org>
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

Some pytests create files in the persistent-data directory. It is useful
to be able to access these files in C tests. Add a function which can
locate a file given its leaf name, using the environment variable set
up in test/py/conftest.py

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/cpu/os.c | 24 ++++++++++++++++++++++++
 include/os.h          | 10 ++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
index 9e93a0fa571f..85d0d6a17035 100644
--- a/arch/sandbox/cpu/os.c
+++ b/arch/sandbox/cpu/os.c
@@ -258,6 +258,30 @@ int os_unmap(void *buf, int size)
 	return 0;
 }
 
+int os_persistent_file(char *buf, int maxsize, const char *fname)
+{
+	const char *dirname = getenv("U_BOOT_PERSISTENT_DATA_DIR");
+	char *ptr;
+	int len;
+
+	len = strlen(fname) + (dirname ? strlen(dirname) + 1 : 0) + 1;
+	if (len > maxsize)
+		return -ENOSPC;
+
+	ptr = buf;
+	if (dirname) {
+		strcpy(ptr, dirname);
+		ptr += strlen(dirname);
+		*ptr++ = '/';
+	}
+	strcpy(ptr, fname);
+
+	if (access(buf, F_OK) == -1)
+		return -ENOENT;
+
+	return 0;
+}
+
 /* Restore tty state when we exit */
 static struct termios orig_term;
 static bool term_setup;
diff --git a/include/os.h b/include/os.h
index 968412b0a822..fc8a1b15cbf0 100644
--- a/include/os.h
+++ b/include/os.h
@@ -98,6 +98,16 @@ int os_close(int fd);
  */
 int os_unlink(const char *pathname);
 
+/** os_persistent_fname() - Find the path to a test file
+ *
+ * @buf: Buffer to hold path
+ * @maxsize: Maximum size of buffer
+ * @fname: Leaf filename to find
+ * Returns: 0 on success, -ENOENT if file is not found, -ENOSPC if the buffer is
+ * too small
+ */
+int os_persistent_file(char *buf, int maxsize, const char *fname);
+
 /**
  * os_exit() - access to the OS exit() system call
  *
-- 
2.42.0.rc1.204.g551eb34607-goog


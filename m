Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1CEC4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 03:51:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5533087C8E;
	Sun, 29 Oct 2023 04:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZufgT/eW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA57B87C6F; Sun, 29 Oct 2023 04:49:08 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 520D2877AD
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 04:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-778a47bc09aso253348385a.3
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 20:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698551345; x=1699156145; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/M7udaK1XsPcrPcD/PWkusgpIxZnuFkNNzDosMqIBk=;
 b=ZufgT/eWjM/VGl+ey4Tepg4HR25o1CxsLX+SsjTy7uT53EjNv5SggbasQuIwPHYWFZ
 GUMt63YnxRUAeuvTfU/urkT5NGq05xtup9+rGR71FvwkukOVsr7T46o5ht4cEPYIj567
 TxrrkmDgpDIt27rnZOWoDHAFbDXI7l17RlrYWFvgm0jPiuIifyJc4lO7447TDS04VmRZ
 sO3O+ulZOEMV+cAr29dkkcYSoABmmgR5epxPHWo4rsSuJuT9kwOtwMoo3ug+PDn8pXS9
 rYoEeSIeSrEm3TkQGi1QGzSCzRwPooGdNpjoYKyrQdzfauwapa+hV7mjuBvFOzWCPf7w
 REMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698551345; x=1699156145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h/M7udaK1XsPcrPcD/PWkusgpIxZnuFkNNzDosMqIBk=;
 b=MAkVDrutxdyFhAePIFojns5JbxOe+TmH/7yFl6eB2OyIaybVM5y67szzPhvHuTSlGZ
 4xgbcUPQl0xlA52hReXAz/PG0nkIHiU1C9ZaOIZkOc+ETlA5+n8WzJ96mVv7pufBNndx
 2YbjBWwGkpyWev8w6Hgs8ihBmp6mrPCU1wr5TcC0+qxVDw7ysgUPg8ZUJXNIxnOVGc5D
 zJrFU54Yk8BMr44O0P72vRKEOAs0sCRX/357nCqsBV+2pze/qTY6C5Pz3ZBu+JmVTJ0f
 sfdTiEfZ8igVhYR7cy1bY6hxXT6hk5nDU06j9I+Q1jY7vtCyyWM1W85dn/xXNqtkaHZy
 dayA==
X-Gm-Message-State: AOJu0YzEiYS4mvO6a04FcnRPQTQ49fupvcx1BCAiVU7XRrtPerZEXyNO
 FpczsO/J41hZKXRyz3BGl5xokW57LZKEcQ==
X-Google-Smtp-Source: AGHT+IEbWCoJGxiVcVOVpMKQ2G1EoJ274k0rFb3OXfBlfbGmKNd2v8T/l0GlIhBKkGJsup9QyoeJhA==
X-Received: by 2002:a05:620a:5587:b0:778:912b:269b with SMTP id
 vq7-20020a05620a558700b00778912b269bmr6665740qkn.66.1698551344882; 
 Sat, 28 Oct 2023 20:49:04 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 d26-20020a05620a137a00b007757868e75csm2105549qkl.117.2023.10.28.20.49.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 20:49:04 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 13/15] arch: sandbox: Add function to create temporary files
Date: Sat, 28 Oct 2023 23:48:43 -0400
Message-Id: <20231029034845.1169614-14-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231029034845.1169614-1-seanga2@gmail.com>
References: <20231029034845.1169614-1-seanga2@gmail.com>
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

When working with sparse data buffers that may be larger than the address
space, it is convenient to work with files instead. Add a function to create
temporary files of a certain size.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 arch/sandbox/cpu/os.c | 17 +++++++++++++++++
 include/os.h          | 13 +++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
index 85d0d6a1703..8847c4cd0a8 100644
--- a/arch/sandbox/cpu/os.c
+++ b/arch/sandbox/cpu/os.c
@@ -282,6 +282,23 @@ int os_persistent_file(char *buf, int maxsize, const char *fname)
 	return 0;
 }
 
+int os_mktemp(char *fname, off_t size)
+{
+	int fd;
+
+	fd = mkostemp(fname, O_CLOEXEC);
+	if (fd < 0)
+		return -errno;
+
+	if (unlink(fname) < 0)
+		return -errno;
+
+	if (ftruncate(fd, size))
+		return -errno;
+
+	return fd;
+}
+
 /* Restore tty state when we exit */
 static struct termios orig_term;
 static bool term_setup;
diff --git a/include/os.h b/include/os.h
index fc8a1b15cbf..877404a6c13 100644
--- a/include/os.h
+++ b/include/os.h
@@ -108,6 +108,19 @@ int os_unlink(const char *pathname);
  */
 int os_persistent_file(char *buf, int maxsize, const char *fname);
 
+/**
+ * os_mktemp() - Create a temporary file
+ * @fname: The template to use for the file name. This must end with 6 Xs. It
+ *         will be modified to the opened filename on success.
+ * @size: The size of the file
+ *
+ * Create a temporary file using @fname as a template, unlink it, and truncate
+ * it to @size.
+ *
+ * Return: A file descriptor, or negative errno on error
+ */
+int os_mktemp(char *fname, off_t size);
+
 /**
  * os_exit() - access to the OS exit() system call
  *
-- 
2.37.1


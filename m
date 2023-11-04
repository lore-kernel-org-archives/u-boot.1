Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6159DC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 20:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67AA18708A;
	Sat,  4 Nov 2023 21:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a/yIu4WT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75C6B8743F; Sat,  4 Nov 2023 21:38:19 +0100 (CET)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C6D68700F
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 21:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7ba45fc8619so1409126241.2
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 13:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699130291; x=1699735091; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2k7zhFNAzarNQFdA5UtoLGx61loYaEvvUASS+mfpVfU=;
 b=a/yIu4WTL+oxFBZfiKWygRQfAKIpNTuoeHZFHRHWrC+zSrCY6etLPXYO2pN/5W373l
 9/iHQyMy4XJpDTe9IgRE4wL8Sx8MJBSJovVQAEn6+mHI/FEhKopk1gyNu2ii8tN0AQz7
 7NzhlrpaVjh5nWv1R78lSLNMZXabCZPIwu47D0wrn1kyAgesk/sRazDxS+lsUY3IQ3Tb
 xJhnvU7lSYVud1AgtUz7h6nqmk1VySwlEBmzbPd9d9w7vSyjGyvCiEyzqbSgFjoKDYM6
 8lQpaTwRQqGblVxH7l7AGA1gWhrOHV+G5GFB6LFpCTLwhv9IeuYmLvFsVXFiBd2O57Ik
 QsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699130291; x=1699735091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2k7zhFNAzarNQFdA5UtoLGx61loYaEvvUASS+mfpVfU=;
 b=E3nPOP/tCRXcPQExiKuytj06rBi6RV9wQ3DYbj5fEJHSaf58wM/MWREkxMvHBrcSpm
 W35wnlj+hw/xR6Wp7dq001kDdrdszHHqhafSaO5uLMc7vx8p8FQMPIBZrvKb+UffYV+D
 iSazDojqZ1G/QVY/JJsLgBnAbcdVG/TxJ/+ofG9HDvQkB/cDeYbUq2XCuH2EE/ird9PA
 9ypo7tR77sAzGTYalRC8ZJz7U1WFf/pAbm2oCd2jiOy4l1OzE0LITwAiK1WIzaIpynnU
 SVJI+iRdUbE9TX1BXQ+WGDH8uN46S01TZCgqkE4uf9RZlLNWh2woqjWdBZ5/tGvI8z8h
 BqyA==
X-Gm-Message-State: AOJu0YzaoN1IUpo8SdZDRtYhJPF2NYFAuDcCN3LtNcbULe3ertyYaroL
 GX2+ebMpDlgQzzU5Suh+j3BiN2y9jrsTsQ==
X-Google-Smtp-Source: AGHT+IHDvQiZvw6ZjdORVLv22QRxT8a88hxzH9RACZ0MP7jbYGWeM+N3gEqynV8YbOVQJOGqy0hwkw==
X-Received: by 2002:a67:cb82:0:b0:45d:a2ac:44eb with SMTP id
 h2-20020a67cb82000000b0045da2ac44ebmr3105755vsl.17.1699130291112; 
 Sat, 04 Nov 2023 13:38:11 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 dc7-20020a056214174700b00670e0f71ff7sm1944043qvb.90.2023.11.04.13.38.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 13:38:10 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 13/15] arch: sandbox: Add function to create temporary files
Date: Sat,  4 Nov 2023 16:37:51 -0400
Message-Id: <20231104203753.1579217-14-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231104203753.1579217-1-seanga2@gmail.com>
References: <20231104203753.1579217-1-seanga2@gmail.com>
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

(no changes since v1)

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


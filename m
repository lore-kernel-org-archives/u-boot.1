Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15899C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 19:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D92786DB1;
	Sat,  4 Nov 2023 20:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RD8ZDcz8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F411583414; Sat,  4 Nov 2023 20:57:43 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A85386BC5
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 20:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-778a92c06d6so199011785a.2
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 12:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699127856; x=1699732656; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/ZyN8vbDy3W26gCMTAeIja8Z8SMMmbiZ9RZ9ab0zNmo=;
 b=RD8ZDcz8b9Dh6q+E4yxOp5gVtAdOVwClXQyyuGv01yG618HiUk6mfql4V/qfOirxg/
 Gtbgiamd9rwxuSqGrpL29JU0OlJO09Yf2PC0V725k+fD+i0ruhEtKi5RjFo1kbVAlMsw
 leXHWKg54m51ZsY99Nv4+iaI6R18ZgCoq7xUq/b0rmprVxGA1CIT+czbyBmKEAlA/JC1
 SXMftXo2G3hZdMcg1dzJiq20Bo/kZlBHgOlv5i95HIncr0nXsLIlEOxr29lc6LpUXJbC
 rWX5d0Aoj9Wu06GdVpI519D8pH+QtCiVTbIHng+5Tuk9YSKVrwDL0+QjzzttDQYAOZtO
 RvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699127856; x=1699732656;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ZyN8vbDy3W26gCMTAeIja8Z8SMMmbiZ9RZ9ab0zNmo=;
 b=OcH942VAZTKSmHo96j2hV9kWh1vaW6Zm+lQcsMoA/ob0iJJNT8ETtEYdXptHIrux2h
 yltlWytj5GzaIUCgaZw+oI8thH3Q7JInC377ew3Ltru/Ii/bwwp3ax4jjI5re/1HBzwk
 CkVqufjuJ/IrcXO/Kkb/sXrZ6ZXaZP+RvOMjeemqMgkLK/R5RSHkmnkWVmajL1/QfilP
 rKIOrnewxzzMq8xhjiPe6rp2hxYTqsKuefOiQxkH40Xatf55TZbeZw9iMc/UshiAR8oQ
 1rQJOpQxG9+6GV9TB6a/Fb8B4ORsLyc445ilTnh0xsf6fo9m9CBhJo+r+axG8dgh7wfn
 vscA==
X-Gm-Message-State: AOJu0YyINZ4aABEgxNasfLnbQCcVyctVsg5coS7h8ZIGxQH7QQGroixR
 ZvEHSy13VPeGXBnMAui1Xs397tmF0YD4Dg==
X-Google-Smtp-Source: AGHT+IGMZvPDLXy3nfCKS5pjlJKF6IHEfDtC2ajrn+Z7yqLBajdU6fI83zkU73zv7zdnmmDsqPPn0w==
X-Received: by 2002:a05:620a:140a:b0:76f:20df:f032 with SMTP id
 d10-20020a05620a140a00b0076f20dff032mr23174994qkj.69.1699127855632; 
 Sat, 04 Nov 2023 12:57:35 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 c17-20020a05620a135100b007742ad3047asm1802278qkl.54.2023.11.04.12.57.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 12:57:35 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] sandbox: Close file after mmaping it
Date: Sat,  4 Nov 2023 15:57:33 -0400
Message-Id: <20231104195733.1576679-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
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

After opening pathname, we must close ifd once we are done with it.

Fixes: b9274095c2c ("sandbox: Add a way to map a file into memory")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 arch/sandbox/cpu/os.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
index 85d0d6a1703..95c26d855ab 100644
--- a/arch/sandbox/cpu/os.c
+++ b/arch/sandbox/cpu/os.c
@@ -219,7 +219,7 @@ int os_map_file(const char *pathname, int os_flags, void **bufp, int *sizep)
 {
 	void *ptr;
 	off_t size;
-	int ifd;
+	int ifd, ret = 0;
 
 	ifd = os_open(pathname, os_flags);
 	if (ifd < 0) {
@@ -229,23 +229,28 @@ int os_map_file(const char *pathname, int os_flags, void **bufp, int *sizep)
 	size = os_filesize(ifd);
 	if (size < 0) {
 		printf("Cannot get file size of '%s'\n", pathname);
-		return -EIO;
+		ret = -EIO;
+		goto out;
 	}
 	if ((unsigned long long)size > (unsigned long long)SIZE_MAX) {
 		printf("File '%s' too large to map\n", pathname);
-		return -EIO;
+		ret = -EIO;
+		goto out;
 	}
 
 	ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, ifd, 0);
 	if (ptr == MAP_FAILED) {
 		printf("Can't map file '%s': %s\n", pathname, strerror(errno));
-		return -EPERM;
+		ret = -EPERM;
+		goto out;
 	}
 
 	*bufp = ptr;
 	*sizep = size;
 
-	return 0;
+out:
+	os_close(ifd);
+	return ret;
 }
 
 int os_unmap(void *buf, int size)
-- 
2.37.1


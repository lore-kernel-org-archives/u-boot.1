Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BDEE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E78180602;
	Mon,  6 Jan 2025 15:48:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jg7UXE/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71E72805F5; Mon,  6 Jan 2025 15:48:11 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87D16805E2
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:48:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a817ee9936so56124765ab.2
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174886; x=1736779686; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNcQsuBjcd1mQXmb32bpRKq0oloKqyo+pN5FIZneTYg=;
 b=Jg7UXE/x4i/aRRT2qgFMC7Prwvgt35mVlWKHo/qd3OYnlGo5u0/hQjbW5vXeFaNfrK
 +MedN+MQFV/UZELhtkZDJnVIUndTvZciXlxVXAbsgEfQvqZpC+uaDfl9elLGkwLD6qSu
 2GPl3FNto+YwD3C2OayQNt56Vzhttb0aoIOEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174886; x=1736779686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fNcQsuBjcd1mQXmb32bpRKq0oloKqyo+pN5FIZneTYg=;
 b=D/4nQ5G41di0aS1V8KIlSgBPyIi1GQAUoIAhlKVYO+qJYQk2pC/UQZahJfyPF/X3vF
 lxCV2f4xu62X9vtTzkFW8LZkF+FtpXiZV+3TY4Sv3ZlRVZLCxwTRsFR77xS2jHmJS+rS
 v4f+bTeFJOtZFDuMO/vickrWBn0YXDWOAy4rFABCfwsNkMQ0CTGbL3spO4mMaQ7cK6ES
 0F46MmlbWJXyTS947VUR9QVxjTGaGSyXvIB1P0RZq7Wkx2YSmEcnQpMRPkxpoUnLUkEi
 EIFgcBeGVrHDaoAAljHnMt8hn3jt57PndZ2m/2JxNi99mlK74WcrLZ+lmkpla35kKa8a
 9KoQ==
X-Gm-Message-State: AOJu0Yx4GbQJqMZ5kD8XnkDbUJp32ATG2asFrXOav2jVNwGEIkBHBqym
 oQR2f5HeL5scBJem8HMj0yh8SyHsPvCKXSZ9qQ9bD0mL62Xe5HQDzYkxz3iryFTmAn4QwfDYN0o
 =
X-Gm-Gg: ASbGnctg7zEawNRkgKeSoL5lB/8f10Jd18WlICsbVaU9Ed0Yfzhhd/RmpzoFbRGMFRF
 GrQ1momzqxQaMy48ojZvuMx5d63lKsdDBIn3qks2AWJZwFbxUkv9j6jbYb2bgXzTq6f2HfukAm7
 fS3EE3inCvmW1cGOMSwvLVK9dPg8OpBDEAEfaF6ySxBvVhcB5STPwU2cv6UmfFed1BrR+0DLzNm
 HSKgXC+dTnsQzNvH/Eh5OVTnEfIa4X3yOmbbddQuHconLkcM+CmNpn5WFuuhdBhIYbLnaeqFdcN
 p6ZT2AvxoC+SD/Htaw==
X-Google-Smtp-Source: AGHT+IHAU1Oh6+IuNhTRCh6TgbzWYEOM79CTnWi3oM1tmXegpy5cow1ijIHBPtUz0HEq2kJRbIeExg==
X-Received: by 2002:a05:6e02:3201:b0:3a7:c3aa:a82b with SMTP id
 e9e14a558f8ab-3c2d1aa2b75mr482435055ab.1.1736174886627; 
 Mon, 06 Jan 2025 06:48:06 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c37bb139a0sm94081185ab.70.2025.01.06.06.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:48:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/8] efi_loader: Fix display of addresses in log
Date: Mon,  6 Jan 2025 07:47:49 -0700
Message-Id: <20250106144755.3054780-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106144755.3054780-1-sjg@chromium.org>
References: <20250106144755.3054780-1-sjg@chromium.org>
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

The allocate/free-pages functions return an address, so there is no need
to convert it. Fix this.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: c824a96d76d ("efi_loader: Use the log with memory-related...")
---

 lib/efi_loader/efi_log.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_log.c b/lib/efi_loader/efi_log.c
index 4b9c6727fe7..ad490bb431c 100644
--- a/lib/efi_loader/efi_log.c
+++ b/lib/efi_loader/efi_log.c
@@ -340,8 +340,7 @@ void show_rec(int seq, struct efil_rec_hdr *rec_hdr)
 		show_ulong("pgs", (ulong)rec->pages);
 		show_addr("mem", (ulong)rec->memory);
 		if (rec_hdr->ended) {
-			show_addr("*mem",
-				  (ulong)map_to_sysmem((void *)rec->e_memory));
+			show_addr("*mem", rec->e_memory);
 			show_ret(rec_hdr->e_ret);
 		}
 		break;
@@ -349,7 +348,7 @@ void show_rec(int seq, struct efil_rec_hdr *rec_hdr)
 	case EFILT_FREE_PAGES: {
 		struct efil_free_pages *rec = start;
 
-		show_addr("mem", map_to_sysmem((void *)rec->memory));
+		show_addr("mem", rec->memory);
 		show_ulong("pag", (ulong)rec->pages);
 		if (rec_hdr->ended)
 			show_ret(rec_hdr->e_ret);
-- 
2.34.1


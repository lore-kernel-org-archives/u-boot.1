Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2A7E7719C
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:04:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 929C380790;
	Sat, 11 Jan 2025 01:01:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gFj3QtcP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BA8280790; Sat, 11 Jan 2025 01:01:43 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ABCF80757
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3ce301bc718so18605855ab.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553699; x=1737158499; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J4KF7fBXPe91gaHmyo3v+v2AGV2IFAb3LRvJ4hTsXxg=;
 b=gFj3QtcPl1cQExOYiKTc31g2xbt4gM4juMAD3+vbLehWB0WmP+HYPgj9w6z49yQRDc
 RE74Dpv700h6P2kWf9Dpfcb4cJE29tRj2Qwxxb3OTAmPuF2E2oOfXLYmqBVl+v6MD6DH
 gwXFtWE5rSIFwuWduHh5wapGvfCXEI8Y8wBMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553699; x=1737158499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J4KF7fBXPe91gaHmyo3v+v2AGV2IFAb3LRvJ4hTsXxg=;
 b=DzzmQVM/mdhTH5e6eLmL9qXRPVCLJHGTsS9Zm/14X3RdRG2/ckwE/dlwtaDtsb5LoL
 2daVuTq7E+RKYbW063G5Nr0oA3kjIcUPn/QMowMDYkanlGXGj+fp4waZmmH5fOa7V+YC
 cV4kyfvgUHZeXMbU+w01v9KSz2m7xmnjPJbKbXg0163trn/24Go1ZYZiv+akY9MpH8xU
 7Ou1xglJE86S838FYyiP+C+/wDe6dwDSMABxOr+ml2lJE1/SvK2PaBQj+Tml/v/kOP89
 1e9cZYE/kgH7Eyk+pEbTQNmruauzxgBbG5/YnBIXFn0/LPcbMqN3/FVH4uh3Tzqtg/4C
 AXLQ==
X-Gm-Message-State: AOJu0YyReirUrDZe+FGKOmkK27DW9imRS/ng1JHml8mFcolD6JgApN3z
 6t+he1oYJ1iwpn/qh+cb5/u2gI1ShcFJ3KFO4vmr2S95viIEh1ZSzy5XSpB9Aow8/7KUF7xOw+g
 =
X-Gm-Gg: ASbGnctbG7Xxy4I2GI5Up6qXjxCWLxN4kYLOGE9fdatW3zw9LpF5IQcpFwvIXxSVdOf
 Cme0/bXPC0kGaeHAx5CaKpVhgcyvVAoEcQaRA9fr+Jy0iQpe5P/eo4NY714iviNL706uUMyU2FM
 gxKAExIPOWRGFEEP8EhX1yGzS9wCIUHrjPNC3oif3uLX+t/a+Tnbr/yYGmXIO9EJMqZ+2SR01m3
 Sg0gaFEOngggB8ySXjv04wdBbA7kGCvdJ3gfOT/Q9w6MGVH6VzGcNYjMjQfMx3ZBZa6ESDlAAzQ
 aAqtNRVa9zbcUENkkQ==
X-Google-Smtp-Source: AGHT+IEvudMNB0aDcOsojm2pwvd9ZjVMahqPlcTbGVeNg/bOcmm6/AUsH/C0hC28LmGA4FmRvvpZnQ==
X-Received: by 2002:a05:6e02:190f:b0:3a7:e047:733f with SMTP id
 e9e14a558f8ab-3ce3a86b02cmr99775065ab.1.1736553699657; 
 Fri, 10 Jan 2025 16:01:39 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Janne Grunau <j@jannau.net>, Matthew Garrett <mgarrett@aurora.tech>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 22/30] x86: Support jumping to a UPL image
Date: Fri, 10 Jan 2025 17:00:21 -0700
Message-Id: <20250111000029.245022-23-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

Add a function to allow x86 boards to jump to a UPL images. Currently
only 32-bit entry is supported.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/bootm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index 2a7933cdaf8..3c420b00936 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -280,3 +280,14 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 
 	return boot_jump_linux(images);
 }
+
+int arch_upl_jump(ulong entry, const struct abuf *buf)
+{
+	typedef EFIAPI void (*h_func)(void *hoff);
+	h_func func;
+
+	func = (h_func)(ulong)entry;
+	func(buf->data);
+
+	return -EFAULT;
+}
-- 
2.34.1


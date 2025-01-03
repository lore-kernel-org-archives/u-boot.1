Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A851E7718F
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 23:21:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25373802EF;
	Sat,  4 Jan 2025 00:21:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="i0PGvCBg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FB7380079; Sat,  4 Jan 2025 00:21:40 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9756B803CC
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 00:21:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5F77D3F370
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 23:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1735946498;
 bh=d/xIHpiPoHpRWu9LcycfpL/ZPRS6jIxLVBb9Zfp1rUQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=i0PGvCBgeVrVYqiWjvRrl2nN+yMzIfXwDZZ2vkQ88d/6xRVwKF5AT9IteSCvyvh+O
 5YQYLxCxd0FBnrFf58XNfE45q3H1n08qw31h/akM5BW0O9gMLppqLUK9lQ+a9YAB3w
 a2+0fzSdq1OH+wv8SgxlcQ1G/+/Uc6fJYFeD2wAfyMCqU+jN/7QaTb1t3PMGS5mJFv
 qZuIgBkjJmDLql06lKPEEA4DifhE4+f5GRKWbrsxsfW5tEG0XBcLKkMMgDC24tEwdV
 AUqoMGx7bs+jVYwFDgdkE7AHJwAKXIbXUaLIoWVsKijJPqTVF8xQnHbkkb3clZrNK2
 XLqAo6iYmC0hA==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38a35a65575so5694588f8f.1
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 15:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735946498; x=1736551298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d/xIHpiPoHpRWu9LcycfpL/ZPRS6jIxLVBb9Zfp1rUQ=;
 b=g18U3LxiOTYVDwq4+22CF1SEHYLo27O34YHp4mzJCse63S2nr1v5JJiASV5ZB/mYcA
 hjUjR5Rcdny9uQIQ/uchD+SOlyaTTUrX21ZYNWDptbevDbOzXarH7bGsBjCWLCqAwWic
 Gu03A1/fV8l08FdvSbyrp1QXHUv0DUIQFaEqiyXeUGI3RZ5XYazo99wy4AKUXpUhtfB8
 w9m30Qf0Irf1LD9NZpaQqy7Fay+hJtxVdr+V30rvWb840NSqQgiMB0O3SDGJDehb38y6
 kO+vUNlyzwl6AMClYQXgBjyhEOKUh7tidOv64nT0h+OLmIcsGZK7/cgYOTWZbzMTzvGW
 oJNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjk3G39RoBIfFjv4tgaTW5y9jtHQmIIcbDVgND+KSUGUdviohm63L1+i6Flvw1dMOWJZVs7gA=@lists.denx.de
X-Gm-Message-State: AOJu0YwKt6y/CrA7Vyv1PjRciZf4HvCnZwE/7mZdwH9Qrx3lWhOyx9C4
 Ydh/FrBecZeXgaPKBW4ncLI5Escl6cHZpMyjJujJBetD9DMXqndhjs3cKZIldhz8Yuz8+PNb6JG
 RpPdS1CBinS8WUAyFAZhaeiqRScBS1mTppJGIy4LiHSYFFt1lO83Mc/kZL+ZhxEtFEmU=
X-Gm-Gg: ASbGncvchh9PhdCe6XniwVcdX+V5bXGlxQ19cS0mcFgIcWhQh+tfhs1H4OA/CaDDAuW
 XuMJBs2cbGv3tiBAtq3vJZ12kCpakVo7AtmC0Iv4qKM/1xL/lEeoRelnqjcT+7yyK8Uoy6RoNa8
 Omtq5HcwtFe0M6xYQfkQrpRHCgFMApCpE32KxbGOKHEw6JlKP/BJ/fq3lYakDrYZ1QnW378SrLm
 jcjcZ9dukdrdXtR+u2caSW/1E1AeyV3icS/q+rg0MyvasnqVdP0wvovib7hCaVF785OBH2Hn6TF
 J4XfcQ==
X-Received: by 2002:a05:6000:1faa:b0:385:fc8c:24b6 with SMTP id
 ffacd0b85a97d-38a221f9c14mr40839750f8f.27.1735946497928; 
 Fri, 03 Jan 2025 15:21:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHThfHWpPKDphAufpsZWlI95WxW3OwWi0L7vUt+/k7Y0VQKmep1fbUsGSQfdMQvRdtSi8MgAA==
X-Received: by 2002:a05:6000:1faa:b0:385:fc8c:24b6 with SMTP id
 ffacd0b85a97d-38a221f9c14mr40839739f8f.27.1735946497582; 
 Fri, 03 Jan 2025 15:21:37 -0800 (PST)
Received: from workstation5.. ([2a02:3035:6e0:45ea:405b:a98b:b831:787a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b3b214sm536283125e9.28.2025.01.03.15.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2025 15:21:36 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/3] net: use strnstr() for lwip_strnstr()
Date: Sat,  4 Jan 2025 00:21:18 +0100
Message-ID: <20250103232118.711135-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103232118.711135-1-heinrich.schuchardt@canonical.com>
References: <20250103232118.711135-1-heinrich.schuchardt@canonical.com>
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

Using strstr() instead of strnstr() creates a security concern.

Fixes: 1c41a7afaa15 ("net: lwip: build lwIP")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/lwip/u-boot/arch/cc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lwip/u-boot/arch/cc.h b/lib/lwip/u-boot/arch/cc.h
index de138846358..6104c296f6f 100644
--- a/lib/lwip/u-boot/arch/cc.h
+++ b/lib/lwip/u-boot/arch/cc.h
@@ -34,7 +34,7 @@
 	       x, __LINE__, __FILE__); } while (0)
 
 #define atoi(str) (int)dectoul(str, NULL)
-#define lwip_strnstr(a, b, c)  strstr(a, b)
+#define lwip_strnstr(a, b, c)  strnstr(a, b, c)
 
 #define LWIP_ERR_T int
 #define LWIP_CONST_CAST(target_type, val) ((target_type)((uintptr_t)val))
-- 
2.47.1


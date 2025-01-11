Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9235EE7719C
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AB4C806FB;
	Sat, 11 Jan 2025 01:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nUl0KV4z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 600F980716; Sat, 11 Jan 2025 01:01:15 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30EA2801B0
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-84cdacbc373so78571339f.1
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553671; x=1737158471; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bFB72bZMf4lrIasXqHVjNfnCVUlmz0sRqUbYu9798Kw=;
 b=nUl0KV4zkAjsrQY8KESJ7TRJQA4t0JSjZY7YZAZCrjVMLAIcp60hPJJU4jyGwX0Duc
 CBkQJP9aw+N2BeXmVRKb6POJnia0XvJU8b5vicgIIQuv1GKhM2xq/5qPijWfMWs4LzL9
 +hijkJRAWQ37ibsTmfiNIt/1podleOZQkCMGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553671; x=1737158471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bFB72bZMf4lrIasXqHVjNfnCVUlmz0sRqUbYu9798Kw=;
 b=vk07XryfTS7vCADHHtZ4QaM+2tSRAo+xZejkKSadrOHFFRF+IsrJYqvgeXLQhZdjci
 Up8quOrKFMtt3j+T+VUOiBjV7/4FP5DcjpVc12QCmpjlPuChOOSfUWZYwhs8LsW0RjxV
 6F+DIhmfqYUdugX0KmsTmOvkcPlY/cM46n1Wvh3Pd5i+KPJEEWFyV6QlzwE5WcT9m9um
 rz7WgJkPsUoBtWCLR7jxMCgRWiwPqTchtY6wFs5D/tWig6IplNjl5+eXcKtWOXTQxgD+
 rrEYGHMnyLzYNTwJSAHWaVuD79qceUURYywiLoG5/q6oLGRRhR1jh/im9f9VHIrg/HTI
 Rvlw==
X-Gm-Message-State: AOJu0YxoQ2f9jyJWpQxSZAoSt9xm31Tm6OZUYff72HoS9clmjWKBqAsI
 6qkOy2Ecq2ulu0I224jrmiBMELYIEzdRQ1rGQItkSY/rsfpsSust5Ac5L1/yKabOsY2sePwrj1s
 =
X-Gm-Gg: ASbGncsB+54faJERcEddAChofvLpv7UFWBjtfw01ph2i0Ya6wf5TDsBLSu/2cr8iSSr
 tgmIbGS2NU2zpdLQ4f0lTkffGUckEfj5hVoovkxTCKEzfdWVyx84rl8gvolgiM+fO8X1QfbLt7Z
 U0eS39fmY7OUOzHXAb3vr23DoJYDf1NqpYMr9tS6LMk0g6l1mrYBHDN4tHy1X9499SKzVcVe1V1
 qYRnP3cZi0pE912USHOFGPPsTf4kjT4F+APypvPgT2LW8Ht//nOzqXQ+Bf8pfCyr1SabREmgLOO
 UVA5K7XQOqPJLvxFkg==
X-Google-Smtp-Source: AGHT+IEyLk2O/C/YZPtFo88eUx99K1TMJDiIjZC9Lv5lUAnHlzHfYR5Zunh+Uj9T5aUHt4kQ8JT8Rg==
X-Received: by 2002:a05:6602:3585:b0:84a:51e2:9f93 with SMTP id
 ca18e2360f4ac-84ce00c49f8mr1150803839f.9.1736553671438; 
 Fri, 10 Jan 2025 16:01:11 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 11/30] ofnode: Indicate when out of space in a few places
Date: Fri, 10 Jan 2025 17:00:10 -0700
Message-Id: <20250111000029.245022-12-sjg@chromium.org>
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

Update ofnode_add_subnode() and ofnode_add_prop() to return a suitable
error when space is exhausted in the FDT. This makes it easier to see
what is going wrong.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 drivers/core/ofnode.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index ec03f6f550d..5b8be218d3b 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1607,9 +1607,10 @@ ofnode ofnode_by_prop_value(ofnode from, const char *propname,
 int ofnode_write_prop(ofnode node, const char *propname, const void *value,
 		      int len, bool copy)
 {
+	int ret;
+
 	if (of_live_active()) {
 		void *newval;
-		int ret;
 
 		if (copy) {
 			newval = malloc(len);
@@ -1623,8 +1624,12 @@ int ofnode_write_prop(ofnode node, const char *propname, const void *value,
 			free(newval);
 		return ret;
 	} else {
-		return fdt_setprop(ofnode_to_fdt(node), ofnode_to_offset(node),
-				   propname, value, len);
+		ret = fdt_setprop(ofnode_to_fdt(node), ofnode_to_offset(node),
+				  propname, value, len);
+		if (ret)
+			return ret == -FDT_ERR_NOSPACE ? -ENOSPC : -EINVAL;
+
+		return 0;
 	}
 }
 
@@ -1897,7 +1902,7 @@ int ofnode_add_subnode(ofnode node, const char *name, ofnode *subnodep)
 			ret = -EEXIST;
 		}
 		if (offset < 0)
-			return -EINVAL;
+			return offset == -FDT_ERR_NOSPACE ? -ENOSPC : -EINVAL;
 		subnode = noffset_to_ofnode(node, offset);
 	}
 
-- 
2.34.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8EEE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:34:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2B9A80613;
	Mon,  6 Jan 2025 15:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YRuz+X6t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6157E8060C; Mon,  6 Jan 2025 15:33:06 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42757805FE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:33:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-844e9b8b0b9so1149342539f.0
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736173982; x=1736778782; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=avW9jpHTYAW9DV1eINQViBYfSM2C/e1G/P0jUkojUtE=;
 b=YRuz+X6tArAtpPkSaP/8gginrMVqVcAek30qN6je5RNH++WagIa/NbuBaKaAtFdxkm
 PMsgjnL9j6jzuGwBTSzHIkPll0wQ3Btk3xyObvqTYHev8JzRe/PkemuMJSNjMbUSuCwP
 cjCvUEtdoAe90vrIZfGQ1GOcIu46y57lkgHNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736173982; x=1736778782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=avW9jpHTYAW9DV1eINQViBYfSM2C/e1G/P0jUkojUtE=;
 b=SIGHeHG4dn0iI/N+poYiIULQe9jqoLDhoUptyRLFsvAfQQiYcvKQCDLcDpR/dsECK7
 mbPot7CEBkraSI9y4JlaHSOA6w37qKZiUQb8t1eFWWxM7pP3JHl4DqZlZ7QwEN+jQ0bl
 qQOHiaFCBxVp6wbYFLjoPvDkD8BJ1Ek4rCCVZSNBFBjFaDpv9u9ltTjl3TG8qYlnDrNR
 k1P5FlE814yUobYnyx4pTdTQVeUQMuWjOaq/d/s2DNV13S6Xd32T0iwa/slmgkKFzDf8
 9GZtsPJgjKDjvi9JJshW1HNXL8JQ2iK2ogFVPbVOBmxwX9zeq5eEHboKXTf0N8sEvKLY
 VzmQ==
X-Gm-Message-State: AOJu0YwLi4JdCoRMRxEXDdrqd66OcqbXid9gi+fMPQZSI1XawsV1XOMH
 OQHx+j+BOZVSmFg4GeH+KI69ZE51hhj8VEpeiOATSCMIVBY9mcw5lQ3Vj0qpi781jEVxUzeuu7s
 =
X-Gm-Gg: ASbGncv+IDfDbXldZv83uXuHLEGBbKyYkHrr65kGmDcG1QMxTLZ3SCag1too588G0KH
 w6XZpobRg9Cd0CBPfYdmAN05EWqSTG+8tJfCS9kfFojjwnkSblQ4cZSfTUmUrN0lLegnGh+Osvi
 +aDaRKm2CCCB8GpRgBB1lFY7typLA9C0qj7x/q2rRXbv5agxeEX7g5R/f1ymixFtlItxORYvjDE
 0+Z+mXj1UzHEngrAQGVbXZSB/6goh5XQs4fbJv2edgq3U0lPtwPKv/Hi/1/SQhLRuNbk8GeBzgj
 KRgsHwRcjROnukl4mw==
X-Google-Smtp-Source: AGHT+IE3alU1SmdnQxqDOeQHfA/JT4iijzwmFQQhkxitBpiQ/FFBwXH0MUbzJNg2nqhIWxkZEAfvcA==
X-Received: by 2002:a05:6e02:34a0:b0:3a7:21ad:72a9 with SMTP id
 e9e14a558f8ab-3c2d5152acfmr440697515ab.17.1736173982498; 
 Mon, 06 Jan 2025 06:33:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:33:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marex@denx.de>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 09/33] mkimage: Update map_to_sysmem() to match its
 prototype
Date: Mon,  6 Jan 2025 07:32:05 -0700
Message-Id: <20250106143229.3023771-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

Update the version of this function in mkimage so that it uses a const
pointer, as is done in the mapmem.h header file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/mkimage.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mkimage.h b/tools/mkimage.h
index d92a3ff8117..15741f250fd 100644
--- a/tools/mkimage.h
+++ b/tools/mkimage.h
@@ -37,7 +37,7 @@ static inline void *map_sysmem(ulong paddr, unsigned long len)
 	return (void *)(uintptr_t)paddr;
 }
 
-static inline ulong map_to_sysmem(void *ptr)
+static inline ulong map_to_sysmem(const void *ptr)
 {
 	return (ulong)(uintptr_t)ptr;
 }
-- 
2.34.1


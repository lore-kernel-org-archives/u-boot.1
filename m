Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142A4C54E90
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 23:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1B8382F84;
	Thu, 22 May 2025 01:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FeQnG6bt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79B8282FBC; Thu, 22 May 2025 01:01:36 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18D1482FB9
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 01:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6066c02cd92so3920613eaf.2
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747868491; x=1748473291; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HxIdhPidyd5z2n8I2M0mFLt0/3PFJz2kL5GsR9KzbKQ=;
 b=FeQnG6bt19jjNuGj2oDrc49aiiJovESjdLc6yDb2lKxnbvqoAXeP6m6IMfOUR5H5D7
 USMVKo6/5mMEy4RzheBL7uYRrXeMk3Wsk6MpXFFhJ5QO9AX0ImfN8EGsRae2+BaB+KE4
 PYnvDBbde8DdZFlkckUIlu+4XQcEHOBLVWsm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747868491; x=1748473291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HxIdhPidyd5z2n8I2M0mFLt0/3PFJz2kL5GsR9KzbKQ=;
 b=G5+z7uQwYaimZOnWpQZiY4hStAaUR1D3J4oeELhCdHa+ixR0WMUUZ7/35rW8P0k1oF
 vPHoCrbZfsHdjmYulEVGP8vKKa1PoVPXcJoJTbwwEc6dUP/yF3zy03Rd2optfvua2BB7
 EUqRM45qGLZdMv9nQetPrO2KAzZjrFTRlHZrv+skGh0M9udp0NcWJ490VanUWCccCLvh
 PmkHj3ZZLifkVJrjhG9Dri+890HUeQtrwmIR/JNXEEPrE1b6uqWC77bXvRfT4FmzVLVG
 +v9AMBKA7kZMM/+9xiXz2J5Or0Mb+TEnMYKd/VqPL0Ec3kAUkFlFRitlwYEAO44UI5dE
 KVtg==
X-Gm-Message-State: AOJu0YxIC5HXKJc3ZrjZZq6kFbD9FaeSt2sgJ9De2nocEYE0kX+i/pcI
 ee7oN9wwoJiSTcmJPv8LYF64It3bDLwBDBudZiZG7+xguM1sEtPsS1B4vC9yfestKr8TlYGhJPq
 Gb1NBARg=
X-Gm-Gg: ASbGncuGd85LWg4OAwmb3/SV9+RDNKi9UwCQXkelsVpr8a9h4oiNbetrjg6MWwhaHVr
 oaT4vpnUQcSztuiHh/bUoPEvBpQPzcBXcFG8vx1Bw+OdRMcPeVoGIklo8c4O1TGxI1abzpvPaZQ
 vJXeZ6cFwzpNfJcE8PmuP4A6Jj1ntBYT3y2uHmG3BttHALYqu63rGJmQJ3HAADgrORpdta5gnUj
 sJkM5mOhDju3mjR1Qfy8/O4uYEnE3Ro3dRD65mMNY3ddBSeCFtSiorTvv9hu7ONTlJdBsvgrWKh
 U6BFemVNKStDHjm1Z75fPiHhyyOSCStx+ot7X86M5Wbh3t3xCAMK30XJNyVtV7OwnrKtJ69SVAG
 SKPb1i8FAJyYrhso=
X-Google-Smtp-Source: AGHT+IExB5ch4kG6jOMzDtiwYW+1lJpmFPkDCB4Cv3Z593q9riHdq+hahfP4GHWUV2qCabtocoOWdA==
X-Received: by 2002:a05:6820:1b09:b0:604:5e57:80ab with SMTP id
 006d021491bc7-609f35fda0emr14235588eaf.0.1747868490761; 
 Wed, 21 May 2025 16:01:30 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60b7e43d07bsm473895eaf.26.2025.05.21.16.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 16:01:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 05/17] include/bootstd.h: Audit include list
Date: Wed, 21 May 2025 16:51:10 -0600
Message-ID: <20250521230119.2084088-6-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521230119.2084088-1-trini@konsulko.com>
References: <20250521230119.2084088-1-trini@konsulko.com>
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

This file does not need <linux/list.h> so remove it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 include/bootstd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/bootstd.h b/include/bootstd.h
index 2bc464756dd9..f2fb5f55faab 100644
--- a/include/bootstd.h
+++ b/include/bootstd.h
@@ -11,7 +11,6 @@
 
 #include <alist.h>
 #include <dm/ofnode_decl.h>
-#include <linux/list.h>
 #include <linux/types.h>
 
 struct udevice;
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD7FCA0FF7
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 08:17:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 666F08365E;
	Fri, 29 Aug 2025 10:16:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gK8cYDIX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CE1E83447; Fri, 29 Aug 2025 10:16:58 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E41483447
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 10:16:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3ce4ed7a73fso769543f8f.1
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 01:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756455416; x=1757060216; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UwrviiXoZz2eJN+hKAvENlgBuJhn5xPRkvjRRWbeBvA=;
 b=gK8cYDIXwUirCKk6BCpLOFCGYG0zZVlBNQGvMfMbl46qupgZL/DFTRc2RATJPESgZ1
 XNWOOCgrL6ZocTqf9wFZZce1lBXFrdSwUmjxYJO45UdfCtsXuoBjehQPdg5Pep1rUWqJ
 Un6+iiPnpuSUCE61UWz+mHwyHQ3+M7sulhaLX0rUxddYtaumMcF5geaUtHGCrN9fIkjg
 VF0sMQy6lhWRfGVaJpkqNG1mYNS91w38ai7LQgHkIsEitdD+hg2QMo6YUisySgmqE+Pp
 ZAPNr7KBlZJvg3q49ANCtvu844P6UMmp+ED0OXybA+XQxrGW3UozM5wpa5qdhmPZLkLR
 cVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756455416; x=1757060216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UwrviiXoZz2eJN+hKAvENlgBuJhn5xPRkvjRRWbeBvA=;
 b=eEm6jwmd3TOWJSnSH74Ldje7lZSOIHtZw/UeyA9ThJ89InPjVfTfCULbkFE6U03uPc
 oPrHMqsd9cjLYkL4ejsL0hWDVeBUlhTAU1vdNE/+eLue2uMh37Xb3jSQouFD5J6qD3b4
 mGmipOhFmHQ6fl4lw+Tvk/up+4WBQFOY7TvqaxnzNfNQO+tnSjlMMVays7TlDVVihg66
 LlSN3SELuxsZLWAWXWBb27h35SFyZqwTUwGrSMJR19HnjfuruS1Sy8b2LK6dLgZTpnKU
 b0x5fjBRzJIPKj080Be68oQf23yO93mNKmhTxGg7CwnXwDdp9CCzFm6j9wEhMEiUFf2w
 mKKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSpalq4pLKnsBXEHLqYDDB1Q1dz3ykWTCJFSdsu/3Q1eSef2101E6OY5xiPO1iyzxwDN/TrCs=@lists.denx.de
X-Gm-Message-State: AOJu0YxT8gk32OalvL8fn8nwXibNZBGtIihIOe9jt7t8swjCJSLLWWsF
 xDk+Zp1NF4ObUB2vcfutvzhYe0lFcABXGbSsuH6DFvqFWS+Fi8PIxgfITjswIAzXGAs=
X-Gm-Gg: ASbGncvt7XGC8IPRIIPuU14k5B2OfZhW2V5hrbBFR8wlMBh0meSvLUfOScinQIrHDHN
 HW0hsfD+gjE47v1XOEaGSMJWH6SdyIgVIqmWm+/1i+DR+OpzNYfw6+AZ5oU21XlcLtN0aEwc7rJ
 Xw0st8JGvhRAzWMXfor9wVWg/XFUurY85+wtP7BmydNGRapJPzaMk3Oj/d7bBAEAna6uz7/Qlbb
 sUVgLSjlZ6xuwZxZVS2Y9uOfOO78HI/LHfmLtFKl2V8y/zzLUghuZ+ZobU5EuHj/qcDUdXtybpw
 5xq8aIeeTETOtq/fJCstHW/yXgitofhHaCFHz81hC8j3uFwGEFm5YOS7cloLzkEh9gZc462EBFH
 A9A7FqTI2OoQyU/Q5SVrIHCZ5pxNyxPcgG9RpWAo8KZ1uSZohU874ZW+u6tOiVdvIL4p3yloYRi
 JLSSCyrm4A0TayASCKjm6g1Sf3r0pxeQFTsuuRmKL6TnvKufhM6iGlrmjOQ9XCK/JDTV5SwSbou
 3OoYIznardaB/ANx1yHTGzQYeUwQH9Y6Nw=
X-Google-Smtp-Source: AGHT+IHwI8FwJ3nkZp3hdUsdf8S8CbKioddmzIBXRK3iexoVyHJYBJ/zSHiq0205V8B1Fd+vByYHIA==
X-Received: by 2002:a05:6000:22c8:b0:3ce:46d8:5e11 with SMTP id
 ffacd0b85a97d-3ce46d866d0mr3797942f8f.34.1756455415856; 
 Fri, 29 Aug 2025 01:16:55 -0700 (PDT)
Received: from hera (ppp046103010177.access.hol.gr. [46.103.10.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fd01csm2449008f8f.12.2025.08.29.01.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 01:16:55 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 =?UTF-8?q?Carlos=20L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yifeng Zhao <yifeng.zhao@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, u-boot@lists.denx.de
Subject: [PATCH 7/8] tools: imx8mimage: Mark build_image() as static
Date: Fri, 29 Aug 2025 11:16:21 +0300
Message-ID: <20250829081628.2327372-7-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829081628.2327372-1-ilias.apalodimas@linaro.org>
References: <20250829081628.2327372-1-ilias.apalodimas@linaro.org>
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

The function is only used locally. Enabling -Wmissing-prototypes
triggers a warning. Mark it as static.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 tools/imx8mimage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/imx8mimage.c b/tools/imx8mimage.c
index 0f24ba75c0fb..fe1aff35b4dd 100644
--- a/tools/imx8mimage.c
+++ b/tools/imx8mimage.c
@@ -475,7 +475,7 @@ static int generate_fspi_header (int ifd)
 }
 #endif
 
-void build_image(int ofd)
+static void build_image(int ofd)
 {
 	int file_off, header_hdmi_off = 0, header_image_off;
 
-- 
2.50.1


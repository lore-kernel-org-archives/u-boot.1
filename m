Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E19C54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 22:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B07A87083;
	Sat, 18 Nov 2023 23:04:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="kkb1HUoH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD93A87252; Sat, 18 Nov 2023 23:04:30 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FA958700D
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 23:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4083ac51d8aso5960895e9.2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 14:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700345065; x=1700949865;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t7kksgcUCA1iCjzeWaVzK6/jbeKMR2yq1yL0ae4KGI8=;
 b=kkb1HUoHv1EXl+niu4tmjRICijA9GAJqPMotSaC8zAGE5cn58DeVZ0MFTXEkr3u45Q
 XPLXwFNxi54i4dyqx/+zcLxykRoiNKWS1C4GWCfBvsQbl1/mhkXtVvu7+S0ts2CUwqH4
 YR/Do8sL4gqTv97QZeCzuAofBG4Lgcw2IMe6GJTmYuAYmpA18DMjnXZ5Qt7a9crl1FY+
 1W3RSCcH+VyhRMV33uTeqpmjalnUgWcd/Z1dbKr/e4fbFgxnresGmKJPmaYncLnVpP0L
 SDFVbFyTiJ6qnzg/SSVVKiqULHK/IYG/PSl6o9RonZ/0jpH4Zdukh4xN30avkcnlKrz0
 9igw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700345065; x=1700949865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t7kksgcUCA1iCjzeWaVzK6/jbeKMR2yq1yL0ae4KGI8=;
 b=NvWeY1DSDVl+5ZyJp0GSdayOjJOruF5A2nu6C2idlDCP28Kcqdm++i4bmg/fnswlmK
 V1eCEbyEk/YUxWQlF4KongBaBLD0Q8P7KnFwjAqqIbCPDqimPAwzrYAVp6oc4C364zdk
 Ysdyma4EVeff07r6xEwtfo1jv563VjNRywTIrXkkZuu2+kGvsWcZICZBIADv+wGHuVko
 tlLZZnFgakrWMs5SXT3MWPZcy9I/W+YjcjDdRrhLOVz3D7ufNkGb6yYn5abq0L996ljj
 WXnWEFVfIf235HnAmJboUq7mtydm2VwEDvdmVTqFmrXsJ55q2qiZftO21Q0KQW4Q2nCA
 vMyQ==
X-Gm-Message-State: AOJu0Ywlp8lTrTvi28WW6HhluQUCBnjNuAuK/ZtXQEu799uVcmIgQMK1
 gzjNAKo0rKZyLnQiPw6nC9Wzmm+ZFPjbGcvkFsljSyUs
X-Google-Smtp-Source: AGHT+IE6F4GPR6fJ4MKmxV+vm+R37Sc/WsJQ3UUrxEzacboRZCy/eN0tEJY3g0kpqxSdEdGWzzlNzA==
X-Received: by 2002:a05:600c:4e8e:b0:40a:70c9:887f with SMTP id
 f14-20020a05600c4e8e00b0040a70c9887fmr2883545wmq.10.1700345065479; 
 Sat, 18 Nov 2023 14:04:25 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 fc16-20020a05600c525000b004054dcbf92asm7776118wmb.20.2023.11.18.14.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 14:04:24 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, xypron.glpk@gmx.de,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH v3 1/4] bootflow: bootmeth_efi: Set bootp_arch as hex
Date: Sat, 18 Nov 2023 22:03:13 +0000
Message-Id: <20231118220313.1271556-2-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118220313.1271556-1-i@shantur.com>
References: <20231118220313.1271556-1-i@shantur.com>
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

bootmeth_efi sets up bootp_arch which is read later in bootp.c
Currently bootp_arch is being set as integer string and being
read in bootp.c as hex, this sends incorrect arch value to dhcp server
which in return sends wrong file for network boot.

For ARM64 UEFI Arch value is 0xb (11), here we set environment as 11
and later is read as 0x11 and 17 is sent to dhcp server.

Setting it as hex string fixes the problem.

Signed-off-by: Shantur Rathore <i@shantur.com>
---
 boot/bootmeth_efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 9ba7734911..682cf5b23b 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -339,7 +339,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	ret = env_set("bootp_vci", str);
 	if (ret)
 		return log_msg_ret("vcs", ret);
-	ret = env_set_ulong("bootp_arch", arch);
+	ret = env_set_hex("bootp_arch", arch);
 	if (ret)
 		return log_msg_ret("ars", ret);
 
-- 
2.40.1


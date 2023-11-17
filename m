Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDE6C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 21:22:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4DAE874DE;
	Fri, 17 Nov 2023 22:22:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="f9xDcl0e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 553BA874FD; Fri, 17 Nov 2023 22:22:01 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25C76874F6
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 22:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32d9d8284abso1580118f8f.3
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 13:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700256118; x=1700860918;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n49Enfsq+O+OaWtRv4lW0fr1tptAe9PunBsSitoO6Y0=;
 b=f9xDcl0eVZJqkwggpzTzrmHv2Bk3eqaHahX8AxiPhdof9cdVT1QvjXNC2OdLrXESc7
 0rUAWMEX/IlrKj8Na0lL+uN7YSmimR/cmdmt/cOQypZqW9cuEl8iumTmI13JHt0b5bv0
 Wf8z6aXDqObFYKxlVQgDvEZawT7+ZIeKEzeJ7qcH+VNN8ODhopIY0Ggv1r9SDQsDqbC6
 ijbkMvF5CuGAZUOIUgsMC/epxNi4xkUYy9hxMBfUGH56K0UOgV1XPFtr1n5lkk/TSAQg
 s9Fq5brjzLOoy/wHN+FUEIuOM1ws9viQliOo6Pt/WFet7bKAbs6TXX/W/uaHP4TYvvUI
 rqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700256118; x=1700860918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n49Enfsq+O+OaWtRv4lW0fr1tptAe9PunBsSitoO6Y0=;
 b=RBnSNrPLO7zOWQCZAoaR2c8z1K11XdoW6GkHSTV1JHZKZ/vnBpQ7cqE3BZ1XE4CmxH
 AiSwhH15kl95fXEizySMBimlIYZ6Tgdoe+2CwowKvxYUPx5+kt6Bag2MaTKQGDkbZFIc
 HdgwNeS6kt3bip/pHqGrfuqNEOSNjUCo+h4RThlXaqT1RIEfz0Dk0prWZv2mbLurjZFU
 ezayDHMNBMU7fmCxMQMk4e4l6uqRVJi8GOuHO6RQmS3onoJXDG6T/rFJTnQQETg/hUOy
 /d0GmzqPOt9VYinpprS9mTDJY07jV4PG0pskW/O/IIBW2Lz/cIwBBu6s9so67dkNTW8e
 49uw==
X-Gm-Message-State: AOJu0YyBM2I1Cceic4m3nQ1ztuz58hZLRE5dePmZmrFdW6x677edTPQL
 DFd7hdgfJec0QZeVRcS3hNwMaPyiC25F/Cyht2nCV47qvbw=
X-Google-Smtp-Source: AGHT+IGNL610R2gwdvxhvdT/Uo7jDTW79eeAjO9iZih8vCi1Ka29YZAvIuu5D2STelX5qLgbwIe6nA==
X-Received: by 2002:a5d:588c:0:b0:321:6bed:1646 with SMTP id
 n12-20020a5d588c000000b003216bed1646mr171630wrf.14.1700256118263; 
 Fri, 17 Nov 2023 13:21:58 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 t6-20020adff046000000b0032d9a1f2ec3sm3393540wro.27.2023.11.17.13.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 13:21:57 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, xypron.glpk@gmx.de,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH v2 2/4] bootflow: bootmeth_efi: Don't set bootdev again
Date: Fri, 17 Nov 2023 21:20:37 +0000
Message-Id: <20231117212039.1210784-3-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231117212039.1210784-1-i@shantur.com>
References: <20231117212039.1210784-1-i@shantur.com>
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

efi_set_bootdev is already called as part of tftp while doing dhcp_run()
Doing this again crashes U-boot and we don't need to call again.

Signed-off-by: Shantur Rathore <i@shantur.com>
---
 boot/bootmeth_efi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 682cf5b23b..5917458dc5 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -360,9 +360,6 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 		return log_msg_ret("sz", -EINVAL);
 	bflow->size = size;
 
-	/* do the hideous EFI hack */
-	efi_set_bootdev("Net", "", bflow->fname, map_sysmem(addr, 0),
-			bflow->size);
 
 	/* read the DT file also */
 	fdt_addr_str = env_get("fdt_addr_r");
-- 
2.40.1


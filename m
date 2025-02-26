Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7728CC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 22:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 643D481292;
	Wed, 26 Feb 2025 23:23:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DRao3GoD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 153BA810F2; Wed, 26 Feb 2025 23:16:25 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E225181113
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 23:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2fea3026a3dso389484a91.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740608180; x=1741212980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n7SxG6o68AcFiNYjjH0sbObrdENWHfjBEg0C66iZfMU=;
 b=DRao3GoDU7g4pxKaxSKOOihqdOWfta52lbthgNF4ckufwq+NhFmnkwYRUYQ7SuD33f
 +ziPLgFuDsJP7VfxDqpVCbdc5pmOLp0ExbFoH0C1d6hexK6Ub6ouEODcNrrYkKX2QRTn
 I58QF5KsKdKd9H5GdeonG90v8zQHQBjb8iR7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740608180; x=1741212980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n7SxG6o68AcFiNYjjH0sbObrdENWHfjBEg0C66iZfMU=;
 b=bcaxxsoBd4WC1twDuHjjogJ4/2pAlUCPFnjetxiy+thCqvtrxvC74Yg+AnbM+3m83j
 LtB+scHlMb01XsDiSueE5sm1dHw+eEmPY5wDJ/QtXg/fs2iUxBBepfGhQNuMDV8ECYUw
 kOPEEgl1KQbjCLcFSVD/KaB+xjhmEIvw5O2IEhCszcbJi5UorGPXJ40HQSbNknRF7MED
 4/lbirhn23zPdQCiFlaWmhEsISW2BkE4euPrNOR82FqjE832BiuU6cmg6zYc2LzgB4L9
 k4+eP+VGTKdJmnxfs9+HewcQLrdBXj97QRhD0rhjhyVJNSyaxDSkBtNahshOMJfU/t5I
 9TfA==
X-Gm-Message-State: AOJu0Yzbe051w42Z/zROgvsp/pFOCXdoaQFemL/jv/uk9vYo6nzx6H7/
 tTI7IApl4fw3TB9E4YbsQCQ7HruGpnavQ41YFQr6gcNMBDECuxdceLdaLBmLs0pBsv78kq+zdBc
 =
X-Gm-Gg: ASbGncuumI0wcw9Ww6iIHNc85+ZeZbECYA2keXIbsCkntKLpu3yoOkVidAfQw2+/g4G
 tY1UTYF+Awq06trd5UhxszuvmVqXHhC/2BlQo0CIyywebEznuZIqamJ1QqRDAiKRQwZqV29/h3p
 XloxmvsQlOHa6ttZjGo00t495o8+dNXpU4h8yzja6u0FvbES9XCS29VATGc3uo7WByCcPwrYISY
 PaTi0uyrlcg24ZQefr9XQPzdqM/0VGEMxSYPXzPlIpOG4jpzw0doZ0tNrTqbD5v9Xc81u0MiAaG
 hnrIE/gCitCE6QWu2NyU6gXUkHa4BCYw9WQvxo2hnnd/D+CgZ8RK+Cg8us4666zguw==
X-Google-Smtp-Source: AGHT+IFYjDJWhG4srJyqClC8eR3JnuTz8nAdVxjkeBjqOy0t4Z313javeiNkbb0UtueUzqyxDTUBBw==
X-Received: by 2002:a17:90b:2801:b0:2ee:45fd:34f2 with SMTP id
 98e67ed59e1d1-2fe7e2e9383mr7444555a91.6.1740608179860; 
 Wed, 26 Feb 2025 14:16:19 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2fea676bf4esm60695a91.18.2025.02.26.14.16.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 14:16:19 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v2 07/15] cmd/cbsysinfo: Skip the CMOS 'option_table' when not
 present
Date: Wed, 26 Feb 2025 14:15:53 -0800
Message-ID: <20250226221607.1283592-8-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250226221607.1283592-1-swboyd@chromium.org>
References: <20250226221607.1283592-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Feb 2025 23:23:35 +0100
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

The CMOS 'option_table' isn't populated on ARM devices running coreboot.
Check to see if the pointer is NULL and bail out if it is.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 cmd/x86/cbsysinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/x86/cbsysinfo.c b/cmd/x86/cbsysinfo.c
index 3936d30da0e1..ed7b50f6d0fc 100644
--- a/cmd/x86/cbsysinfo.c
+++ b/cmd/x86/cbsysinfo.c
@@ -224,7 +224,7 @@ static void show_option_table(const struct cb_cmos_option_table *tab)
 	const void *ptr, *end;
 
 	print_ptr("option_table", tab);
-	if (!tab->size)
+	if (!tab || !tab->size)
 		return;
 
 	printf(" Bit  Len  Cfg  ID  Name\n");
-- 
Sent by a computer, using git, on the internet


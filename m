Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA981C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADFEA83560;
	Sat, 24 May 2025 01:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c7I7bB9t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B558E8334D; Sat, 24 May 2025 00:59:09 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D4CA8334D
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-879d2e419b9so246491a12.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041146; x=1748645946; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fBL9gsIH5UdRwquWomfD5XC3L5dJel88D7GnfbcWmEo=;
 b=c7I7bB9tOkBTHnpZf5/oclvGDWT0lxi2O20FC+s2mx9oqi+rliOuXgzHRbkhc/gPAw
 2rQU3n+rCFx+Q/6ToRTidb8L2fP7pxfqv0SsDIn2Fgv4x/9PVS8Dvho2u7F8dEEBw9Rr
 2POzi7T4rv2NZajPeapYPd9nFQHOmutgd+h84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041146; x=1748645946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fBL9gsIH5UdRwquWomfD5XC3L5dJel88D7GnfbcWmEo=;
 b=T4lV55X4yKPzLQufaoIpYu52BW41eCdc1AETDQ6tyK6AgQFqt+jk3miu0VMkKCw8FU
 m7HzeiUcAyI20W56TeKdWSIxDjumTb0n285pxTlepHufq8VyfaiEdtSrXzjY//3mBatc
 UbPJ/UHm90XrYNcPKfDNBJUTl6s82cd1dxuMJhL9Yj9dsXMyXQraDHH8Ky6kqoHxuUEK
 8JTpdIiW42sprMz2FmGvr8hxh4CK4mnb6EZzRdlGMTKJNkCiMd3TzMuSLtnKesbA4A1M
 XoI/ZFUB7gLJEaeQjfVdG7CVmBrrrqbG/mXMcgWlPHX9EAsnUChI//JCUaB5MWMcNftm
 7uTg==
X-Gm-Message-State: AOJu0Yw2X9x4bNMnaLyuC2prS6Cawmis3HLqQRs3SXRPpC0QCVCiGagL
 CShsyBD+huY7bQCd03/gBnIdfcXDLO7riVO33m2lqBHn1fOwOh91dVMKR21WcRfcyby+/4nNbgN
 EtDY=
X-Gm-Gg: ASbGnctdAbKHkEfzH37QGBevskDW7njPg1vxqWz9qQajk4FWozjp7kaXyuf6SoOeb+U
 /6Sbq8qblCQtOAcMW7gKSH22ilVP4f8F7BmVWgf5lMvPuDLuxwYjy+6h0RB/O2p9c6bZyVJht0v
 NVArSfRlg5tPUMj6zzB4trB7fAMZlm5e67F/FYtrZdwOwFHba2h+WQeiNYINKYU6nPIylEtxF+d
 Z+6js/m3x5wobTYlZaTaDiiYhD1tbVIlVnG3s+usfQj4sDZrIKn/Hfwm4DbZ/uYpOuhb5EBI4SQ
 uRUnUyNpuhevYrQ4i3FwqbSUjQ8ihdFo5PBtdUh2xRfn6NY8IuOKLmo2NLIWh0rfN0A18A0g4pQ
 SE6PZYRxb82GVIfWNTNo5RLB/Cg==
X-Google-Smtp-Source: AGHT+IHOWfyBGLRGLONCFUY3/EfnwiJUnJ1tYrbZW+wJMp1NMfj1EK8Tt8DN4DokeYDxlk/da0AhVA==
X-Received: by 2002:a17:902:d486:b0:22d:e57a:279b with SMTP id
 d9443c01a7336-23414f8d3c8mr20150315ad.24.1748041145919; 
 Fri, 23 May 2025 15:59:05 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-233fd7d561csm11432895ad.101.2025.05.23.15.59.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:59:05 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 12/28] cmd/cbsysinfo: Skip the CMOS 'option_table' when not
 present
Date: Fri, 23 May 2025 15:58:27 -0700
Message-ID: <20250523225845.2311989-13-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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

Reviewed-by: Tom Rini <trini@konsulko.com>
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


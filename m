Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBECC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:09:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00BA888976;
	Wed, 24 Jul 2024 17:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V9cCvXEH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E33E98896F; Wed, 24 Jul 2024 17:09:42 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D60B88971
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-39834949e42so21978135ab.1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833778; x=1722438578; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N5y3MP0b2Y9/1Fw5SBvV3iDjCsHvZ2ng6pwLD/rnbrM=;
 b=V9cCvXEHwjOkwojCnAlMSs5saM5B9ydeAn85tOtjYkqJIKgFib6JP2HOHrhq6wTnRq
 S+fvDBIg+27eRBYQZT8OIK4Zp6VG478ubGhwzg6R7kcU3xK7BC0vzhwweM4SeSrcRZV1
 XSwQGHd4POaK9paOLCI/TrFBt+GYMde+cSnJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833778; x=1722438578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N5y3MP0b2Y9/1Fw5SBvV3iDjCsHvZ2ng6pwLD/rnbrM=;
 b=DWawh7H4zzzk1EpZTDwC1w/w5pl4pl+GG09vo+sFqIijffsIpSnHCQIcaooPt37Fvo
 CPKHZt5SGjlWJuDJJjXYqkdLmqqGqmBM71bQAx57J5OyL5s8qawvVza84ZfM7554bwmN
 a9h5FqJoRDreA/8q9fcti1BAiukIYbImEX72B3ka6kzItKlu49Szmf65R5hnilYY8HLv
 lpiUVYiMMUttQv2uD4Bo1Do3n1M9xeTIpsOPgkzOBZIU5adIEixoV4MSb3WxdDhgls1y
 Re+EKCQP/E5ZJD/8BPrvKoezTBdhomS+wjtXsYOCayFbUMwTNRhYO89VKxzOvR3z+xVJ
 HW+g==
X-Gm-Message-State: AOJu0YwmJGWhcnkOBgLd4RePpjt0CAEtEvMBVeJXitgK+eyncdvDtlMj
 OnMOpbPY+eiqra6Ye1f6lj1ba6gOnYFbWCazfQxbDFjQfgiKr/cLAr43TpkgmLrrQ+O21S2sSrI
 =
X-Google-Smtp-Source: AGHT+IHh+vvuCsB8qhjHLza0fUt7w0HoW03RFzj6kiQCs4gGOIBFqW6UUSsJu55ONUUMLE3JHPAEHA==
X-Received: by 2002:a05:6e02:1c24:b0:381:b3a9:3ba1 with SMTP id
 e9e14a558f8ab-3993ff9c371mr177035735ab.13.1721833778195; 
 Wed, 24 Jul 2024 08:09:38 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 02/35] x86: Drop use of global_data fb_base
Date: Wed, 24 Jul 2024 09:08:49 -0600
Message-Id: <20240724150922.2343249-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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

This value is set by not used on x86 so there is no point in setting it.
Drop the assignment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/fsp/fsp_graphics.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/lib/fsp/fsp_graphics.c b/arch/x86/lib/fsp/fsp_graphics.c
index 5f7701265a9..ad25020086c 100644
--- a/arch/x86/lib/fsp/fsp_graphics.c
+++ b/arch/x86/lib/fsp/fsp_graphics.c
@@ -103,7 +103,6 @@ static int fsp_video_probe(struct udevice *dev)
 	 * For IGD, it seems to be always on BAR2.
 	 */
 	vesa->phys_base_ptr = dm_pci_read_bar32(dev, 2);
-	gd->fb_base = vesa->phys_base_ptr;
 
 	ret = vesa_setup_video_priv(vesa, vesa->phys_base_ptr, uc_priv, plat);
 	if (ret)
-- 
2.34.1


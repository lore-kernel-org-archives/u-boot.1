Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4D5CAC587
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 16:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BB81833EC;
	Thu, 11 Sep 2025 18:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iXiLY+MK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E617833C0; Thu, 11 Sep 2025 15:35:51 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CB6D833E1
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 15:35:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ranquet.guillaume@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45dec1ae562so6876745e9.1
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 06:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757597749; x=1758202549; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jj+VxDDPoVWOScyog32eLkBz/EftUhvrkDG4RyRUOUQ=;
 b=iXiLY+MKVJmJ4LkCisgw2f+Bef+qNsWOOD4pQjktne0SYHEMDbxwzG0S6ZJkUmGH4J
 d/Pxg6HQmYD6GBeZvCLSdLuirjbNY68NJY8pRhSnzaEa1BUbnUFgosdrG5rmmgsAAZ7N
 0W5PpN/r+OTvVnkZZCYzeCaAc0iwyiEMRRcTlwbszybKne5O4xWjNDJxB7bE6LbONPuM
 TpwZnh3YP+06WZAbsq8ktQeIc1dwBMVOmyiCsKAcGL+GT7grXVpKnOy40xG8FzSubm1C
 eB4D1+S2v4DmiPcXmd3RP2zyoDEaoSzjmtv8pZvYZvorrbCDPeDzYROd9QBKwik9KazR
 fLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757597749; x=1758202549;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jj+VxDDPoVWOScyog32eLkBz/EftUhvrkDG4RyRUOUQ=;
 b=ITPCqEIgToxAuNjeIfLts2cQ4130b/gpmnMyCuUMi9HDX5CEyBDyxxGnnZm5KyhOlo
 AzmsARFrUyz+GxE3N4P/Xyhl0hjz5y+Oew9etot+SD9+v517SOqjT+l2wYnPxrx14YUj
 iDEVYTfYQG8A7IaY+YX50kw9JGfGVfmLlBSPschVd5G3/Vlu4KanD8qzG9te47HsAy0J
 e0qGBAbwN6MAAXJwXVDrcQ16EXlW3P/toIG5GlKh6vrGdR8Acz0CE36GZfvFtAhsk557
 u0CyjW2IRyBfKDQgFGivsDMWVAnTwcwYUIkO/LaOuTmCdgG5qg59K6TAO+9t3G0C0+AA
 bDPg==
X-Gm-Message-State: AOJu0Yzg71b0v5Fyd+jxGvmQOC99GgrPMmYcs6s5kO0pSzKbLFSXUF5V
 Ncrmgsc9TNxSie/X5bzkk2/KC4OKE+ZIDUxwnmNVam1pJ1paBsMvkIDc
X-Gm-Gg: ASbGncuaTD5PQ3J3STzPRZZnu9xU+pP8sEQRhQJXBiCLP3vFqHO4ducw8tMsP8ijp/Z
 UG2+kK2dSj29iu6pQasn4iyqRPe4zB5qMidpKSjBisgcjJ8YY42S8NxvFAaBf3gd4WCKkdrosnr
 NPbbpR0WrTDQBFZ+STTA5Gi8kYqK7sYsqzmhJeJOJc7WlsSp9rkv1bzowfW4KK8UJLohOwJ4PKL
 7DPdqzUBtbgz41RTff7nYX8vo6D4YqwZJflUtjNKv3L2565TVcmdqkUxFyY3NEAj7xXxbTkQoDY
 qSjKU/e363Qh0S9x4cKyBcnxhlCv/IriGoNZXwd1W2JTCPjCDxIay8d/giCyeMWqfUazjxIBUEb
 mRDJSOvrOvPj3V8fDpsOZKDVfegZmXMICsd+r3WVOEwEw7hu5glVaGjMQD4AQ8cjyjdy0fmzzv2
 8=
X-Google-Smtp-Source: AGHT+IGpRwkI37oQ4JhYNe2inZLQ38C3vEZbUhpsyYOyvUfFmIvflIR5EgTD5D+/AreM8UO37yUpuA==
X-Received: by 2002:a05:600c:3b08:b0:45c:b549:2241 with SMTP id
 5b1f17b1804b1-45ddded9806mr161402875e9.27.1757597748339; 
 Thu, 11 Sep 2025 06:35:48 -0700 (PDT)
Received: from [127.0.0.1] (lfbn-tou-1-1277-64.w90-76.abo.wanadoo.fr.
 [90.76.96.64]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e017c1455sm26729455e9.24.2025.09.11.06.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 06:35:47 -0700 (PDT)
From: Guillaume Ranquet <ranquet.guillaume@gmail.com>
Date: Thu, 11 Sep 2025 15:35:41 +0200
Subject: [PATCH] x86: boot: fix unreachable else branch in boot_prep_linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-fix_fit_zimage-v1-1-bd779ef56b22@gmail.com>
X-B4-Tracking: v=1; b=H4sIACzQwmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwNj3bTMivi0zJL4qszcRKCsqXlSipmRZZppYpKpElBTQVEqUAXYwOj
 Y2loABqzgemAAAAA=
X-Change-ID: 20250703-fix_fit_zimage-57bd629f5ab5
To: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Guillaume Ranquet <ranquet.guillaume@gmail.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Thu, 11 Sep 2025 18:10:40 +0200
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

The else if branch uses the is_zimage boolean which is initialized to 0
and never set before being tested here.

remove the test on is_zimage to make this code reachable.

Signed-off-by: Guillaume Ranquet <ranquet.guillaume@gmail.com>
---
 arch/x86/lib/bootm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index 0827a884b1d245ecb8a55d46105a1d67d0cdfb56..7a94dc877e31dc8c02131699b9318c35e4fcfe79 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -103,7 +103,7 @@ static int boot_prep_linux(struct bootm_headers *images)
 		}
 		is_zimage = 1;
 #if defined(CONFIG_FIT)
-	} else if (images->fit_uname_os && is_zimage) {
+	} else if (images->fit_uname_os) {
 		ret = fit_image_get_data(images->fit_hdr_os,
 					 images->fit_noffset_os,
 					 (const void **)&data, &len);

---
base-commit: c85b8071e7d3fd333f8a2fdd28083cb5ec3a0645
change-id: 20250703-fix_fit_zimage-57bd629f5ab5

Best regards,
-- 
Guillaume Ranquet <ranquet.guillaume@gmail.com>


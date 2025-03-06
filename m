Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A82C282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D6AA81430;
	Thu,  6 Mar 2025 17:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cOZPsKAL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3EF381430; Thu,  6 Mar 2025 17:04:51 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE8DD81417
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:04:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-85add1c48d9so21083939f.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277088; x=1741881888; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YQfL4L6uYerdOiZWpujGOWu5RaO1Hox5ZOiRJHUzlu0=;
 b=cOZPsKALp7tkoXLyLNdOUyZKvG6vCzU51AmLp4bsgYrlpvJSrz5OxZbFeTMDFXsAhq
 /OjwbsnXZjtR7uOG1z+YH4GR/FyAW7b0OWpq6//lwRVmp2JvV7Tp7tR9Elu8/gVGOtu7
 hPh/xKeTZPdWqErs6FEpAl680Cslmq90aoPD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277088; x=1741881888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQfL4L6uYerdOiZWpujGOWu5RaO1Hox5ZOiRJHUzlu0=;
 b=CLFYM0dSXKCGXdImZn6UBAOfib14TaA+Utnvm2QMkFgcatTCt1M9C7Lp+ld0FrBaU/
 OemwnTkbhj9l3nQZ1k/w4QLa6jkkG+FV2XlF/m0NSo76/ro6RLEtjd4JyKQJxzf3XEpv
 zrrlzSJuoamfGv4dh57LgZVa8mAAl5Nz0nNVoQgkLicrQHBbhMmdnpTh/zuA8MJUzFtw
 ocfdhbvs1SoajIhHGo0wd5uLFsslcmN8yu0lLIE6lOlATN7l6a6OdYbhX8sBAe47oDot
 p9SdH9H6ksEkwPOgTQhDgT7+HKbW3J2niqEIHRk/6UbWVkLkufV7u1cEl7fBzKXfhK9J
 WMow==
X-Gm-Message-State: AOJu0Yxb/CbcdAmTT6P5nGKF+LgWX1H/5b7x9Fb0NgKr2ud6zEhWSukL
 bqeIlVraI6nz4DSNpbNJoy0cCtPlIQ56b+uEQre9PPreMFsEq7R2smTyDYgaCimNpAlIrnwcZ/Y
 =
X-Gm-Gg: ASbGnctHp42vNRVfXuMZ0Gz3CGO+XnBjLkwsKEup+BVGkhVPAwNwTCzfPWrrO06/dDU
 jNxR1dOLukL4xQuq5f+/36hNDzjdZz8DkoyptDc3Dt7RujxZ0n9dXdM21b9qXLvNKRIu33zPY9k
 rS5MZ0L/QbjYgtqmu5s+eRItChsl8+T4IqkcV9Sa/quk2yfANrE7aZ9W/97cwDD+EG4OF2+5iXM
 WDKXVeIkrhgRq30lbmLylj/jZlKawC8fcjieOJP+DMmMsDO7ju3fnYN5HkeR9WRzkCqO5inr+tw
 Q1S4rgim0/IXXAy5p4klmwxu5hY0FakYG1tjYFQNbK4TMC4dltr4J4j9eXPNiOPVnQM1nkFD6RW
 xeGFaow==
X-Google-Smtp-Source: AGHT+IF8t/5R+2AdC1Yzgsz9Q3DeVFyWWb3dACtYDcl8BzHcVTdsIvPDbgVNR7mcAMWt3gw0MQWiYA==
X-Received: by 2002:a05:6e02:b26:b0:3d3:dfc2:912c with SMTP id
 e9e14a558f8ab-3d42b97bc4fmr84938685ab.17.1741277087618; 
 Thu, 06 Mar 2025 08:04:47 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:04:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 02/47] sandbox: Correct a typo in mapmem
Date: Thu,  6 Mar 2025 09:03:29 -0700
Message-ID: <20250306160428.3041057-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

This should say 'cast', not 'case', so fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/mapmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/mapmem.h b/include/mapmem.h
index f496c96d16c..8ec03d59f0b 100644
--- a/include/mapmem.h
+++ b/include/mapmem.h
@@ -33,7 +33,7 @@ static inline phys_addr_t map_to_sysmem(const void *ptr)
  * nomap_sysmem() - pass through an address unchanged
  *
  * This is used to indicate an address which should NOT be mapped, e.g. in
- * SMBIOS tables. Using this function instead of a case shows that the sandbox
+ * SMBIOS tables. Using this function instead of a cast shows that the sandbox
  * conversion has been done
  */
 static inline void *nomap_sysmem(phys_addr_t paddr, unsigned long len)
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8041DC282EC
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 13:51:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF1A781428;
	Mon, 10 Mar 2025 14:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="Ztx7XUZ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 522B180E93; Mon, 10 Mar 2025 02:48:30 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C63F8043C
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 02:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jimmy.ho@sifive.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22113560c57so67549845ad.2
 for <u-boot@lists.denx.de>; Sun, 09 Mar 2025 18:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1741571305; x=1742176105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u21nEFwP7fZiwZxz7l5m9zGlkj1hbYvdHVrFyDiJxOA=;
 b=Ztx7XUZ+7sUrd4bs2SWXlejhDS+TS6LqsgGpzla9Q83c8Fb0eBYjhbB1rdarD8/TDu
 AroOFOwfmOKycm5/mdOf7qK/GQTBl6Tac7g6EOKE9AU73ZujLESw23VieKz2tHrng20F
 Y7MnMsVv/9lprwADbHQiDo6hxnNg1D6lq282uh8wDW3zJnPLgiUDbk1+C16FNK16Ywct
 WmvEEf8wIAxDb/ahcA7vlE8kRUbCq8SuLbPLKmxy7uOSFVgELIidjYqIweT8tRPl+lx2
 JZG3rCpp0NlNQ5g0pAuuwdCCpvVyQ0zCCG0xj0rS8Wmq00hwOSJnXpaurlKODAP3r5Wx
 1uuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741571305; x=1742176105;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u21nEFwP7fZiwZxz7l5m9zGlkj1hbYvdHVrFyDiJxOA=;
 b=tDo+kPL4L0jsSX5qK0cOxDw3UkTAOygE34Bgz/w5YzVP0xvPccWmnf9iPr/YJUkXXX
 3ofJKz9qMVMjJL1Rtuac9vO99Wjq5qtMidRvfyJBQd+ab/icqys94S2ompO7pt//uwqG
 unKOPuwnyG6g9Rv8teagYURqJE0TfPdsSbvLoZ6Rf+UwUfZBgwKGBjs3eo+7KTaVmonS
 vCw0AFZFkjiTgtnBrQr2WFcDsZdervx3pc4s84g2ffDKB2nUb1YamfwSxcKsTG4uSrU+
 4EPcLO0aOrAmD58TpTTY36YB7+cg/oT8Xf6zAVMGpLbqecfxTqpofgoFotI6XfIRurkG
 r25g==
X-Gm-Message-State: AOJu0Yz1X9atQFoQX3Mx4C9CXECI0T4tc4BYWPbL+/t1LMXJK47nmho5
 EYzB9SrgEsR2pZ8nH8uFV90Rul4QkgxGOfpJQYNuCMwulUwS98QN/Sbcmf/WzfJCQP1WgB7WGwJ
 I/F1i7TsbWW7dY/AXlKUYmfuyfsNU/BUyrK8dtf+HZgcTZsEW8qONdb/sFjAC9qaw3vz/aoxR4b
 BE9QYWGzLcXaiT1IecjUrYehhxQUvUzVMAJQ==
X-Gm-Gg: ASbGncs8nnebTkt5bnX7N3OIAlNjchPkXlp5N4nfH1KBoZLu+OSNOJJ6YwYBcHnkQ1/
 SGtMNujSG6Nczs5EN6nAgp0/FzEwr0uFgHGJJndKPpGfXoaeXDMRQsfsId2vtSz1NPlw6dy/I50
 BAO8FkxiO2h4AalDOXTBLxoOAcI7ZwJBFYMsUXEnDH8hlCYtoITrns0ExJwHzj1+tPKh87nvbGd
 c4VJ+mXttAon5BEO/5n+WXwhV+Yv2lQdZyD4Gs5+sMlCKAbrmfQavB6KdmDOpbVGOhcZ2o7DS4V
 b9taCbdNRRu+Wxtl1lRk13g3MptSisoJLVoDJ0PyADSe7fhDEYzGvByHAohmfsv6VBma
X-Google-Smtp-Source: AGHT+IEsPoEbW4pPXP4hCx0DzX8UA81SfFcbqxE9VfNwvgIUF3Zpsr6IEFaYNG58Ln9oIw4B53l5TA==
X-Received: by 2002:a17:902:e84f:b0:220:e896:54e1 with SMTP id
 d9443c01a7336-2242889f4e7mr165752995ad.26.1741571304890; 
 Sun, 09 Mar 2025 18:48:24 -0700 (PDT)
Received: from hsinchu01.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a7f93esm65712125ad.142.2025.03.09.18.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 18:48:24 -0700 (PDT)
From: Jimmy Ho <jimmy.ho@sifive.com>
To: u-boot@lists.denx.de
Cc: Jimmy Ho <jimmy.ho@sifive.com>
Subject: [PATCH] RISCV: config: Remove CFG_SYS_SDRAM_BASE
Date: Mon, 10 Mar 2025 09:47:48 +0800
Message-ID: <20250310014748.6882-1-jimmy.ho@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Mar 2025 14:51:01 +0100
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

Remove CFG_SYS_SDRAM_BASE so that we can get DRAM base from dt instead of compile time config.
Removing this config helps the u-boot more portable.

Signed-off-by: Jimmy Ho <jimmy.ho@sifive.com>
---
 include/configs/sifive-unleashed.h | 1 -
 include/configs/sifive-unmatched.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/configs/sifive-unleashed.h b/include/configs/sifive-unleashed.h
index 2996b37572..cd8d0438ba 100644
--- a/include/configs/sifive-unleashed.h
+++ b/include/configs/sifive-unleashed.h
@@ -11,7 +11,6 @@
 
 #include <linux/sizes.h>
 
-#define CFG_SYS_SDRAM_BASE		0x80000000
 
 #define RISCV_MMODE_TIMERBASE		0x2000000
 #define RISCV_MMODE_TIMEROFF		0xbff8
diff --git a/include/configs/sifive-unmatched.h b/include/configs/sifive-unmatched.h
index 27e0912665..e0064edc5c 100644
--- a/include/configs/sifive-unmatched.h
+++ b/include/configs/sifive-unmatched.h
@@ -11,6 +11,5 @@
 
 #include <linux/sizes.h>
 
-#define CFG_SYS_SDRAM_BASE		0x80000000
 
 #endif /* __SIFIVE_UNMATCHED_H */
-- 
2.39.3


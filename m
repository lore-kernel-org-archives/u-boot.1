Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE021C3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 23:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C72282CD2;
	Wed, 21 May 2025 01:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kRv54rYw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6D5F82BD6; Wed, 21 May 2025 01:49:55 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE74482D2E
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 01:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-60638c07cabso3589738eaf.3
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 16:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747784992; x=1748389792; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xtBzJnYDiRAhGWiY5fHkr9/GH4WFUN8M6W/+4DxgNEU=;
 b=kRv54rYwRHeOuGGkBmV+0aUCucrdaAhSMm4kjkQAVRAMvZk7+aGXP9FuOHq4rDvoFh
 hRGFqxFF7DMeSWQYit1Rv0aeKfTmHDUgRLroi8u1UaBVrZMtctdaLoU2wChNy3EnmO/K
 0XPGVJBWR/D+RQIKQ7thvYNM7NYulfEFN68qq9za8gBO3sGXcnQtdUZ9S1DJeIqHycHc
 Ya3ltnandD9vq1HyVtANWs9toW9+uuyinxwnAqsgApyLqE7o+Yq6+11KNREQSeia9IXv
 Csztd0QMopBFqrEad+MxXhd0jtp6pHrbbkWj60m1pSvt/4eKaN1DRrpM08tfaSAmNHNn
 yrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747784992; x=1748389792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xtBzJnYDiRAhGWiY5fHkr9/GH4WFUN8M6W/+4DxgNEU=;
 b=LmzbYrnuDghphYyxCQxb4bCperppF4ntLVO3fQGrDinshQfGCl+YFqhQD+AET1yn94
 f9AC+XuOaUOMPTbf0chlSJGaGK26Xp6B9uxMcKpAJ7jwWMMId3AeIkWpWxTas8SGgYVu
 wlt62tF/AmhtbfIfRC1iy6LxRo9SazPnfwdfE9af2ppD5UEQCde5gqzV9Iq3iDL8kZM2
 VewdlvDLlfX6FGSg+dK2rfdqaz/2rwh5WPhMaZj3nRz7jIPazgS/eKOY3V6dSjQwamT0
 EC5U9/OD/xNeQt1VcwxUbwJoiCtirl+kjmUkO8okha93UGV/LSkwLtMZOUqagfpCVmXJ
 OI/w==
X-Gm-Message-State: AOJu0YzU+6eFz+67rUEdG8SE5E3BiGPrsNn8krU1fNycNdvceU7l02Nk
 mQF7Ozy8VyEx6E6hvWGtXBnszp02t89caGHMoZSvASx0ditvTfUimh/Sw4slow==
X-Gm-Gg: ASbGnctUFwS37HpHvtS0armBvgS2+JAwrTMj9B7Vkt1desuPn69erF7aZ+ye0+M9zvR
 4BqRU6CKpYmU4ohAgwk3Gl43+f6IVsPnrSy3wGm0vC79S25T1Ok5Yzsm51+Fv1yZmedu3XZZ0g+
 kNxuQsptZDs4gNo8BfnSOVtPgLmjnWGTNu7IG3+i8hVoGZUjd79A8eWcOlgB0PpwV9fMfp7wf7R
 C//TKV0GJPov0wCu0cRYNnGRHzyEZwsonbX7OVpw3mpIRGDPHKXtwQgiFRqemAN7HEtFIrJFnxo
 tFRdBH9cA6ztr3185+AWPiBEieFBuAN3jva56D/mTXTW7KYNpQVFmHKuKThHnscIqi3KmNVHcVl
 CifHzUYr25Q3DxHCwezQGi3SwAETsGa8wtoKt928=
X-Google-Smtp-Source: AGHT+IHmvv4NVcxLn38Uck/W27OgojU5fHdnmDPsRcObCiaNHM+oJzWpgBXofzLGOeBLK0Yke0Aa/A==
X-Received: by 2002:a05:6870:70aa:b0:2d4:d9d6:c8bf with SMTP id
 586e51a60fabf-2e3c1f4dbe2mr11159678fac.32.1747784992177; 
 Tue, 20 May 2025 16:49:52 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c0b21e70sm2422378fac.41.2025.05.20.16.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 16:49:50 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tony Dinh <mibodhi@gmail.com>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH 1/1] fs: fs_devread should log error when read outside
 partition
Date: Tue, 20 May 2025 16:49:24 -0700
Message-Id: <20250520234925.26339-2-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250520234925.26339-1-mibodhi@gmail.com>
References: <20250520234925.26339-1-mibodhi@gmail.com>
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

Log the error if fs_devread() fails when trying to reading outside
partition. This will make bug reporting easier.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 fs/fs_internal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs_internal.c b/fs/fs_internal.c
index ab4847ac257..ff27c564efc 100644
--- a/fs/fs_internal.c
+++ b/fs/fs_internal.c
@@ -28,7 +28,7 @@ int fs_devread(struct blk_desc *blk, struct disk_partition *partition,
 	/* Check partition boundaries */
 	if ((sector + ((byte_offset + byte_len - 1) >> log2blksz))
 	    >= partition->size) {
-		log_debug("read outside partition " LBAFU "\n", sector);
+		log_err("** Read outside partition " LBAFU "\n", sector);
 		return 0;
 	}
 
-- 
2.39.5

